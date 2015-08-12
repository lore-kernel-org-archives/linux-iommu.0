From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 4/6] memory: mediatek: Add SMI driver
Date: Wed, 12 Aug 2015 20:39:34 +0800
Message-ID: <1439383174.7382.24.camel@mhfsdcap03>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
	 <1438597279-2937-5-git-send-email-yong.wu@mediatek.com>
	 <20150811145633.GE14980@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150811145633.GE14980@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Thierry Reding <treding@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, youhua.li@mediatek.com, k.zhang@mediatek.com, frederic.chen@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-08-11 at 16:56 +0200, Joerg Roedel wrote:
> On Mon, Aug 03, 2015 at 06:21:17PM +0800, Yong Wu wrote:
> > +static int mtk_smi_common_get(struct device *smidev)
> > +{
> > +	struct mtk_smi_common *smipriv = dev_get_drvdata(smidev);
> > +	int ret;
> > +
> > +	ret = pm_runtime_get_sync(smidev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = clk_prepare_enable(smipriv->clk_apb);
> > +	if (ret) {
> > +		dev_err(smidev, "Failed to enable the apb clock\n");
> > +		goto err_put_pm;
> > +	}
> > +	ret = clk_prepare_enable(smipriv->clk_smi);
> > +	if (ret) {
> > +		dev_err(smidev, "Failed to enable the smi clock\n");
> > +		goto err_disable_apb;
> > +	}
> > +	return ret;
> > +
> > +err_disable_apb:
> > +	clk_disable_unprepare(smipriv->clk_apb);
> > +err_put_pm:
> > +	pm_runtime_put(smidev);
> > +	return ret;
> > +}
> 
> [...]
> 
> > +int mtk_smi_larb_get(struct device *larbdev)
> > +{
> > +	struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
> > +	struct mtk_larb_mmu *mmucfg = larbdev->archdata.iommu;
> > +	int ret;
> > +
> > +	ret = mtk_smi_common_get(larbpriv->smi);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pm_runtime_get_sync(larbdev);
> > +	if (ret < 0)
> > +		goto err_put_smicommon;
> > +
> > +	ret = clk_prepare_enable(larbpriv->clk_apb);
> > +	if (ret) {
> > +		dev_err(larbdev, "Failed to enable the apb clock\n");
> > +		goto err_put_pm;
> > +	}
> > +
> > +	ret = clk_prepare_enable(larbpriv->clk_smi);
> > +	if (ret) {
> > +		dev_err(larbdev, "Failed to enable the smi clock\n");
> > +		goto err_disable_apb;
> > +	}
> 
> The clock enablement looks similar to the function above, maybe move it
> to a helper function?

Thanks. I will improve it in next version.

> 
> 
> 	Joerg
> 
