From: Tomasz Figa <tfiga@google.com>
Subject: Re: [PATCH 1/3] memory: mediatek: Add a new interface mtk_smi_larb_is_ready
Date: Tue, 26 Jul 2016 11:30:42 +0900
Message-ID: <CAAFQd5AXXpVQU7+ek0Jb_aNm5md=1GVrysEDD5GO7erLUByzrw@mail.gmail.com>
References: <1468983721-3627-1-git-send-email-yong.wu@mediatek.com> <cd01b829-f869-606b-5c1a-8077fbddb085@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cd01b829-f869-606b-5c1a-8077fbddb085@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Yong Wu <yong.wu@mediatek.com>, David Airlie <airlied@linux.ie>, Philipp Zabel <p.zabel@pengutronix.de>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Tiffany Lin <tiffany.lin@mediatek.com>, Honghui Zhang <honghui.zhang@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, YT Shen <yt.shen@mediatek.com>, CK Hu <ck.hu@mediatek.com>, Daniel Kurtz <djkurtz@google.com>, Arnd Bergmann <arnd@arndb.de>, Lucas Stach <l.stach@pengutronix.de>, youlin.pei@mediatek.com, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Mon, Jul 25, 2016 at 5:39 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
> On 20/07/16 05:01, Yong Wu wrote:
>>
>> Currently the iommu consumer always call iommu_present to get whether
>> the iommu is ready. But in MTK IOMMU, this function can't indicate
>> this. The IOMMU call bus_set_iommu->mtk_iommu_add_device->
>> mtk_iommu_attach_device to parse the iommu data, then it's able to
>> transfer "struct mtk_smi_iommu" to SMI-LARB, and the iommu uses the
>> larbs as compoents, the iommu will finish its probe until all the larbs
>> probe done.
>>
>> If the iommu consumer(like DRM) begin to probe after the time of
>> calling bus_set_iommu and before the time of SMI probe finish, it
>> will hang like this:
>>
>> [    7.832359] Call trace:
>> [    7.834778] [<ffffffc000764424>] mtk_smi_larb_get+0x24/0xa8
>> [    7.840300] [<ffffffc0005a1390>] mtk_drm_crtc_enable+0x6c/0x450
>>
>> Because the larb->mmu is NULL at that time.
>>
>> In order to avoid this issue, we add a new interface
>> (mtk_smi_larb_is_ready) for checking whether the IOMMU and SMI have
>> finished their probe. If it return false, the iommu consumer should
>> probe-defer for the IOMMU and SMI.
>>
>
> Can't we just skip the functions in the probe and call bus_set_iommu only if
> we were able to bind all components?
> Something like this:

Note that we have to call bus_set_iommu() and actually have
.add_device() and .attach_device() called before any of the slave
devices probe. I found a similar problem with rockchip IOMMU after
adding power domain and runtime PM handling there. I also found that
current design of IOMMU core and related DMA mapping code is utterly
broken regarding the device add/probe ordering (no support for
deferring things properly).

So my idea is to keep .add_device() as is, since typically it doesn't
seem to require anything from the IOMMU hardware and just initializes
some per-device data, but make .attach_device() being able to defer
probe of that device if respective IOMMU has not probed yet. I'm still
in process of figuring out the right way to achieve it, though...

Best regards,
Tomasz
