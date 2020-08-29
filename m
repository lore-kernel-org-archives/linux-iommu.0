Return-Path: <SRS0=2ZMi=CH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7D3C433E2
	for <iommu@archiver.kernel.org>; Sat, 29 Aug 2020 10:01:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B123820825
	for <iommu@archiver.kernel.org>; Sat, 29 Aug 2020 10:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iJqgYe2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B123820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 50E3587730;
	Sat, 29 Aug 2020 10:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hdwD1E3Mg66m; Sat, 29 Aug 2020 10:01:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 90A50875A2;
	Sat, 29 Aug 2020 10:01:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FA70C07FF;
	Sat, 29 Aug 2020 10:01:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B360C0051
 for <iommu@lists.linux-foundation.org>; Sat, 29 Aug 2020 10:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 778E085F6C
 for <iommu@lists.linux-foundation.org>; Sat, 29 Aug 2020 10:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pER1t7DSK40N for <iommu@lists.linux-foundation.org>;
 Sat, 29 Aug 2020 10:01:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C759D85F61
 for <iommu@lists.linux-foundation.org>; Sat, 29 Aug 2020 10:01:32 +0000 (UTC)
X-UUID: 06a97a601b30491ab643e29003ee3d10-20200829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=YQ4nWNJaU2/84I56GfA7izeF71Nu7GxMGRIJ/4QLhhI=; 
 b=iJqgYe2INoU7y5RbgeFWvqv7yXDT7wXXuH6QVWH8MwimigaAtcURtEZCqOdT81bfUhVmsmSMN0cgKkkduDX0H0CGIdSOMIeqyALhmkFm3cZq6FZ8b5Y573JvKeY6fGwQjf1MnghwP2HLQpe0YZOO0SZ+7z8XJSjwGZQ7GXZNHEA=;
X-UUID: 06a97a601b30491ab643e29003ee3d10-20200829
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 818620872; Sat, 29 Aug 2020 17:56:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 29 Aug 2020 17:56:20 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 29 Aug 2020 17:56:20 +0800
Message-ID: <1598694891.19851.12.camel@mhfsdcap03>
Subject: Re: [PATCH 09/18] iommu/mediatek-v1: Add IOMMU_DOMAIN_DMA support
From: Yong Wu <yong.wu@mediatek.com>
To: Robin Murphy <robin.murphy@arm.com>
Date: Sat, 29 Aug 2020 17:54:51 +0800
In-Reply-To: <a259b248ffb14273b56f8473c20b0381e8d74c7a.1597931876.git.robin.murphy@arm.com>
References: <cover.1597931875.git.robin.murphy@arm.com>
 <a259b248ffb14273b56f8473c20b0381e8d74c7a.1597931876.git.robin.murphy@arm.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AA63C797C93CBD61B254A639A39F87490728FF8037E9BB375825F26FABF9D7122000:8
X-MTK: N
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, digetx@gmail.com, will@kernel.org,
 hch@lst.de, linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 linux@armlinux.org.uk, jonathanh@nvidia.com, agross@kernel.org,
 kyungmin.park@samsung.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, inki.dae@samsung.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org, sw0312.kim@samsung.com,
 linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2020-08-20 at 16:08 +0100, Robin Murphy wrote:
> Now that arch/arm is wired up for default domains and iommu-dma,
> implement the corresponding driver-side support for groups and DMA
> domains to replace the shared mapping workaround.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/mtk_iommu.h    |   2 -
>  drivers/iommu/mtk_iommu_v1.c | 153 +++++++++++------------------------
>  2 files changed, 48 insertions(+), 107 deletions(-)

Hi Robin,

Thanks very much for this patch, It makes the code much cleaner.

Please help squash the little change in this patch,

--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -555,6 +555,7 @@ static int mtk_iommu_probe(struct platform_device
*pdev)
 		return ret;
 
 	iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
+	iommu_device_set_fwnode(&data->iommu, &dev->of_node->fwnode);
 
 	ret = iommu_device_register(&data->iommu);
 	if (ret)


Then,
Tested-by: Yong Wu <yong.wu@mediatek.com>

> 
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 122925dbe547..6253e98d810c 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -67,8 +67,6 @@ struct mtk_iommu_data {
>  	struct iommu_device		iommu;
>  	const struct mtk_iommu_plat_data *plat_data;
>  
> -	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
> -
>  	struct list_head		list;
>  	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
>  };
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 82ddfe9170d4..40c89b8d3ac4 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -28,7 +28,6 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <asm/barrier.h>
> -#include <asm/dma-iommu.h>
>  #include <linux/init.h>
>  #include <dt-bindings/memory/mt2701-larb-port.h>
>  #include <soc/mediatek/smi.h>
> @@ -240,13 +239,18 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
>  {
>  	struct mtk_iommu_domain *dom;
>  
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> +	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>  		return NULL;
>  
>  	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
>  	if (!dom)
>  		return NULL;
>  
> +	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(&dom->domain)) {
> +		kfree(dom);
> +		return NULL;
> +	}
> +
>  	return &dom->domain;
>  }
>  
> @@ -257,6 +261,7 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
>  
>  	dma_free_coherent(data->dev, M2701_IOMMU_PGT_SIZE,
>  			dom->pgt_va, dom->pgt_pa);
> +	iommu_put_dma_cookie(domain);
>  	kfree(to_mtk_domain(domain));
>  }
>  
> @@ -265,14 +270,8 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  {
>  	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> -	struct dma_iommu_mapping *mtk_mapping;
>  	int ret;
>  
> -	/* Only allow the domain created internally. */
> -	mtk_mapping = data->mapping;
> -	if (mtk_mapping->domain != domain)
> -		return 0;
> -
>  	if (!data->m4u_dom) {
>  		data->m4u_dom = dom;
>  		ret = mtk_iommu_domain_finalise(data);
> @@ -358,18 +357,39 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>  
>  static const struct iommu_ops mtk_iommu_ops;
>  
> -/*
> - * MTK generation one iommu HW only support one iommu domain, and all the client
> - * sharing the same iova address space.
> - */
> -static int mtk_iommu_create_mapping(struct device *dev,
> -				    struct of_phandle_args *args)
> +static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>  {
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct mtk_iommu_data *data;
> +
> +	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
> +		return ERR_PTR(-ENODEV); /* Not a iommu client device */
> +
> +	data = dev_iommu_priv_get(dev);
> +
> +	return &data->iommu;
> +}
> +
> +static void mtk_iommu_release_device(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
> +		return;
> +
> +	iommu_fwspec_free(dev);
> +}
> +
> +static struct iommu_group *mtk_iommu_device_group(struct device *dev)
> +{
> +	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
> +
> +	return iommu_group_ref_get(data->m4u_group);
> +}
> +
> +static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
>  	struct platform_device *m4updev;
> -	struct dma_iommu_mapping *mtk_mapping;
> -	int ret;
>  
>  	if (args->args_count != 1) {
>  		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
> @@ -377,15 +397,6 @@ static int mtk_iommu_create_mapping(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	if (!fwspec) {
> -		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_ops);
> -		if (ret)
> -			return ret;
> -		fwspec = dev_iommu_fwspec_get(dev);
> -	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_ops) {
> -		return -EINVAL;
> -	}
> -
>  	if (!dev_iommu_priv_get(dev)) {
>  		/* Get the m4u device */
>  		m4updev = of_find_device_by_node(args->np);
> @@ -395,83 +406,7 @@ static int mtk_iommu_create_mapping(struct device *dev,
>  		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
>  	}
>  
> -	ret = iommu_fwspec_add_ids(dev, args->args, 1);
> -	if (ret)
> -		return ret;
> -
> -	data = dev_iommu_priv_get(dev);
> -	mtk_mapping = data->mapping;
> -	if (!mtk_mapping) {
> -		/* MTK iommu support 4GB iova address space. */
> -		mtk_mapping = arm_iommu_create_mapping(&platform_bus_type,
> -						0, 1ULL << 32);
> -		if (IS_ERR(mtk_mapping))
> -			return PTR_ERR(mtk_mapping);
> -
> -		data->mapping = mtk_mapping;
> -	}
> -
> -	return 0;
> -}
> -
> -static int mtk_iommu_def_domain_type(struct device *dev)
> -{
> -	return IOMMU_DOMAIN_UNMANAGED;
> -}
> -
> -static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
> -{
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -	struct of_phandle_args iommu_spec;
> -	struct of_phandle_iterator it;
> -	struct mtk_iommu_data *data;
> -	int err;
> -
> -	of_for_each_phandle(&it, err, dev->of_node, "iommus",
> -			"#iommu-cells", -1) {
> -		int count = of_phandle_iterator_args(&it, iommu_spec.args,
> -					MAX_PHANDLE_ARGS);
> -		iommu_spec.np = of_node_get(it.node);
> -		iommu_spec.args_count = count;
> -
> -		mtk_iommu_create_mapping(dev, &iommu_spec);
> -
> -		/* dev->iommu_fwspec might have changed */
> -		fwspec = dev_iommu_fwspec_get(dev);
> -
> -		of_node_put(iommu_spec.np);
> -	}
> -
> -	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
> -		return ERR_PTR(-ENODEV); /* Not a iommu client device */
> -
> -	data = dev_iommu_priv_get(dev);
> -
> -	return &data->iommu;
> -}
> -
> -static void mtk_iommu_probe_finalize(struct device *dev)
> -{
> -	struct dma_iommu_mapping *mtk_mapping;
> -	struct mtk_iommu_data *data;
> -	int err;
> -
> -	data        = dev_iommu_priv_get(dev);
> -	mtk_mapping = data->mapping;
> -
> -	err = arm_iommu_attach_device(dev, mtk_mapping);
> -	if (err)
> -		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
> -}
> -
> -static void mtk_iommu_release_device(struct device *dev)
> -{
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
> -		return;
> -
> -	iommu_fwspec_free(dev);
> +	return iommu_fwspec_add_ids(dev, args->args, 1);
>  }
>  
>  static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> @@ -524,10 +459,9 @@ static const struct iommu_ops mtk_iommu_ops = {
>  	.unmap		= mtk_iommu_unmap,
>  	.iova_to_phys	= mtk_iommu_iova_to_phys,
>  	.probe_device	= mtk_iommu_probe_device,
> -	.probe_finalize = mtk_iommu_probe_finalize,
>  	.release_device	= mtk_iommu_release_device,
> -	.def_domain_type = mtk_iommu_def_domain_type,
> -	.device_group	= generic_device_group,
> +	.device_group	= mtk_iommu_device_group,
> +	.of_xlate	= mtk_iommu_of_xlate,
>  	.pgsize_bitmap	= ~0UL << MT2701_IOMMU_PAGE_SHIFT,
>  };
>  
> @@ -626,6 +560,14 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * MTK generation one iommu HW only support one iommu domain,
> +	 * and all the client sharing the same iova address space.
> +	 */
> +	data->m4u_group = iommu_group_alloc();
> +	if (IS_ERR(data->m4u_group))
> +		return PTR_ERR(data->m4u_group);
> +
>  	if (!iommu_present(&platform_bus_type))
>  		bus_set_iommu(&platform_bus_type,  &mtk_iommu_ops);
>  
> @@ -636,6 +578,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>  {
>  	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
>  
> +	iommu_group_put(data->m4u_group);
>  	iommu_device_sysfs_remove(&data->iommu);
>  	iommu_device_unregister(&data->iommu);
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
