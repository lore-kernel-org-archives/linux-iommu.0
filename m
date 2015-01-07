From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Wed, 07 Jan 2015 10:33:29 +0100
Message-ID: <54ACFD69.1020500@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com> <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com> <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com> <54AC93E0.8010705@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54AC93E0.8010705@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Inki Dae <inki.dae@samsung.com>, iommu@lists.linux-foundation.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>
List-Id: iommu@lists.linux-foundation.org

Hello Joonyoung,

On 01/07/2015 03:03 AM, Joonyoung Shim wrote:
> On 01/06/2015 06:49 PM, Javier Martinez Canillas wrote:
>> 
>> Also I tried forcing the kernel to not disable unused power domains by
>> passing the pd_ignore_unused parameter to the kernel command line. I
>> see on the kernel log a "genpd: Not disabling unused power domains"
>> message but HDMI output still has the stripes that Sjoerd mentioned.
>> Do you know if Exynos DRM HDMI in mainline is supposed to work without
>> SysMMU / IOMMU support?
>> 
> 
> I don't think iommu support and power domain issue are related. I also
> get displaying stripes via hdmi but it is just power domain issue
> regardless iommu support.
> 
> I observed 8th bit from 0x1445000C register of mixer is set to 1 with
> displaying stripes. It means "The graphic layer0 line buffer underflow".
> There was same underflow issue on Exynos4 based boards. As Marek said,
> because LCD0 power domain was turned off.
>

Interesting, thanks a lot for sharing this information.
 
> I just tried to turn off DISP1 power domain at u-boot and DISP1 power
> domain is turned on from kernel hdmi and mixer driver on odroid xu3 
> board. As the result, i can see displaying penguin logo from hdmi.
>

Can you share the patches you are using to turn on the DISP1 power domain
since AFAIU the kernel does not know about the DISP1 power domain after
commit d51cad7df871 ("ARM: dts: remove display power domain for exynos5420").

I tried reverting that commit before so the kernel knows about the DISP1
power domain and booting with pd_ignore_unused but still had the stripes.
 
> But the problem exists still because it is failed to control on/off of
> DISP1 power domain more than twice from kernel hdmi and mixer driver.[0]
>

Something that is not clear to me is how display panel is working on the
Peach boards if this is a power domain issue since according to the manual
both the modules used for display (LCD controller and DP) and the modules
used for HDMI (MIXER and HDMI) belong to the same power domain (DISP1).

Or am I misunderstanding something? 

Thanks a lot for your help and best regards,
Javier
