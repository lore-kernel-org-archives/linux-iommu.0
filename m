From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 01/22] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
Date: Mon, 18 Feb 2019 09:44:45 -0600
Message-ID: <20190218154445.GA28558@bogus>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com, yong.wu@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, 17 Feb 2019 17:04:39 +0800, Yong Wu wrote:
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
> >From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
> Control Unit) is connected with smi-common directly, we can take them
> as "larb2", "larb3" and "larb7", and their register spaces are
> different with the normal larb.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Hi Rob,
> In this version, I changed the picture in the binding and list the
> detailed SoCs which has "bclk" and "gals". So I don't keep your R-b.
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  30 ++++-
>  .../memory-controllers/mediatek,smi-common.txt     |  12 +-
>  .../memory-controllers/mediatek,smi-larb.txt       |   4 +
>  include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++++++++++++++++++++
>  4 files changed, 170 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
