From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/6] memory: mediatek: Add SMI driver
Date: Tue, 11 Aug 2015 16:56:33 +0200
Message-ID: <20150811145633.GE14980@8bytes.org>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
	<1438597279-2937-5-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438597279-2937-5-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 03, 2015 at 06:21:17PM +0800, Yong Wu wrote:
> +static int mtk_smi_common_get(struct device *smidev)
> +{
> +	struct mtk_smi_common *smipriv = dev_get_drvdata(smidev);
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(smidev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_prepare_enable(smipriv->clk_apb);
> +	if (ret) {
> +		dev_err(smidev, "Failed to enable the apb clock\n");
> +		goto err_put_pm;
> +	}
> +	ret = clk_prepare_enable(smipriv->clk_smi);
> +	if (ret) {
> +		dev_err(smidev, "Failed to enable the smi clock\n");
> +		goto err_disable_apb;
> +	}
> +	return ret;
> +
> +err_disable_apb:
> +	clk_disable_unprepare(smipriv->clk_apb);
> +err_put_pm:
> +	pm_runtime_put(smidev);
> +	return ret;
> +}

[...]

> +int mtk_smi_larb_get(struct device *larbdev)
> +{
> +	struct mtk_smi_larb *larbpriv = dev_get_drvdata(larbdev);
> +	struct mtk_larb_mmu *mmucfg = larbdev->archdata.iommu;
> +	int ret;
> +
> +	ret = mtk_smi_common_get(larbpriv->smi);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_get_sync(larbdev);
> +	if (ret < 0)
> +		goto err_put_smicommon;
> +
> +	ret = clk_prepare_enable(larbpriv->clk_apb);
> +	if (ret) {
> +		dev_err(larbdev, "Failed to enable the apb clock\n");
> +		goto err_put_pm;
> +	}
> +
> +	ret = clk_prepare_enable(larbpriv->clk_smi);
> +	if (ret) {
> +		dev_err(larbdev, "Failed to enable the smi clock\n");
> +		goto err_disable_apb;
> +	}

The clock enablement looks similar to the function above, maybe move it
to a helper function?


	Joerg
