From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 01/22] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
Date: Tue, 19 Feb 2019 15:28:54 -0800
Message-ID: <CAE=gft5pp7sUHM8P3RTeFPdY-VWVLwLM6=abS6FffZU4WSOd8g@mail.gmail.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Feb 17, 2019 at 1:06 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> This patch adds decriptions for mt8183 IOMMU and SMI.
>
> mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
> uses ARM Short-Descriptor translation table format.
>
> The mt8183 M4U-SMI HW diagram is as below:
>
>                           EMI
>                            |
>                           M4U
>                            |
>                        ----------
>                        |        |
>                    gals0-rx   gals1-rx
>                        |        |
>                        |        |
>                    gals0-tx   gals1-tx
>                        |        |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-----+-----+--------+-----+-----+-------+-------+
>   |     |     |        |     |     |       |       |
>   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
>   |     |     |        |     |     |       |       |
>   |     |     |        |     |     |       |       |
>   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
>   |     |     |        |     |     |       |       |
> larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
> disp  vdec   img     cam    venc   img    cam
>
> All the connections are HW fixed, SW can NOT adjust it.
>
> Compared with mt8173, we add a GALS(Global Async Local Sync) module
> between SMI-common and M4U, and additional GALS between larb2/3/5/6
> and SMI-common. GALS can help synchronize for the modules in different
> clock frequency, it can be seen as a "asynchronous fifo".
>
> GALS can only help transfer the command/data while it doesn't have
> the configuring register, thus it has the special "smi" clock and it
> doesn't have the "apb" clock. From the diagram above, we add "gals0"
> and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
>
> From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
> Control Unit) is connected with smi-common directly, we can take them
> as "larb2", "larb3" and "larb7", and their register spaces are
> different with the normal larb.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
