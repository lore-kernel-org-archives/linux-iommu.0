From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/5] soc: mediatek: Add SMI driver
Date: Fri, 06 Mar 2015 12:30:45 +0100
Message-ID: <1425641445.24292.280.camel@x220>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	 <1425638900-24989-2-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425638900-24989-2-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yong.wu@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-03-06 at 18:48 +0800, yong.wu@mediatek.com wrote:
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -20,3 +20,10 @@ config MT8173_PMIC_WRAP
>  	  PMIC wrapper is a proprietary hardware in MT8173 to make
>  	  communication protocols to access PMIC device.
>  	  This driver implement access protocols for MT8173.
> +
> +config MTK_SMI
> +        bool

Nit: make this one tab instead of 8 spaces, please.

> +	help
> +	  Smi help enable/disable iommu in mt8173 and control the
> +	  clock of each local arbiter.
> +	  It should be true while MTK_IOMMU enable.

I don't think anyone using the *config tools will ever see this text, as
there's no prompt. So you might as well make this a comment or drop it
altogether.

Is this selected by more than just MTK_IOMMU (see 2/5)? If not, I think
MTK_SMI will be set and unset in lockstep with MTK_IOMMU. In other
words, you could as well use one Kconfig symbol.

Thanks,


Paul Bolle
