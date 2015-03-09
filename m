From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH 1/5] soc: mediatek: Add SMI driver
Date: Mon, 9 Mar 2015 11:26:52 +0800
Message-ID: <1425871612.4871.10.camel@mtksdaap41>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	 <1425638900-24989-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425638900-24989-2-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yong.wu@mediatek.com, Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Daniel Kurtz <djkurtz@google.com>, Sasha Hauer <kernel@pengutronix.de>, linux-mediatek@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-03-06 at 18:48 +0800, yong.wu@mediatek.com wrote:
> From: Yong Wu <yong.wu@mediatek.com>
> 
>     This patch add SMI(Smart Multimedia Interface) driver. This driver is
> responsible to enable/disable iommu and control the clocks of each
> local arbiter.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig      |   7 ++
>  drivers/soc/mediatek/Makefile     |   1 +
>  drivers/soc/mediatek/mt8173-smi.c | 143 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mtk-smi.h           |  40 +++++++++++
>  4 files changed, 191 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mt8173-smi.c
>  create mode 100644 include/linux/mtk-smi.h
> 

Hi Arnd, Matthias,

For the SMI driver, we can't find a better place, so we put it in
drivers/soc/mediatek now. Please let us know if you have any suggestion
or concern. Thanks

You can find more description about SMI and how we use it in the cover
letter:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328451.html

Joe.C
