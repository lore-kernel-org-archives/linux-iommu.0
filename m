From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/3] Add larbid init routine for mediatek's gen1 smi larb
 driver
Date: Thu, 27 Jul 2017 14:58:12 +0200
Message-ID: <20170727125812.GD21502@8bytes.org>
References: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: honghui.zhang@mediatek.com
Cc: matthias.bgg@gmail.com, robh@kernel.org, robin.murphy@arm.com, devicetree@vger.kernel.org, kendrick.hsu@mediatek.com, srv_heupstream@mediatek.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com, erin.lo@mediatek.com, yong.wu@mediatek.com, xinping.qian@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 27, 2017 at 10:01:09AM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Mediatek's gen1 smi need the hardware larbid to identify the offset for
> the register which controls whether enable iommu for this larb.
> In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
> the larbid was used without properly initialized. This patchset fixed
> that.
> 
> Honghui Zhang (3):
>   memory: mtk-smi: add larbid init routine
>   dt-bindings: mediatek: add descriptions for larbid
>   arm: dts: mediatek: add larbid property for larb

What are these patches based on? They don't apply to v4.13-rc2.



	Joerg
