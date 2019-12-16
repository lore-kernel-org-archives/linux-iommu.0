Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE4C43603
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 12:13:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F904206D3
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 12:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gB8kmiKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F904206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4826A85E6E;
	Mon, 16 Dec 2019 12:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cWd3BUl-SWop; Mon, 16 Dec 2019 12:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8357B85E6B;
	Mon, 16 Dec 2019 12:13:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B2FBC18DD;
	Mon, 16 Dec 2019 12:13:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B49A5C077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 12:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9E44F877E7
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 12:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50Y-2EwcFi5X for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 12:13:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E1DB8768B
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 12:13:23 +0000 (UTC)
X-UUID: 96a927f982284ffd80da20c66b46ab6e-20191216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=01Zdn2moavFSAH92DOzH42F7drWh36U1FiCarROFBME=; 
 b=gB8kmiKJsw2QXVsVSf87Ql0IIKx6iaF1MPzMyMIa344K8meP31Ih0lFWASZP7OJ/s5GytRk2BSpN5cCqMw4zqXAZ68tR6etmIohcfZ9i6xT7MtcZ/1kpe7pTO21hUt6fALn4tkS4p7ZugkgWGjVW1WsM1cpLPrN2ya6fVEAvGqo=;
X-UUID: 96a927f982284ffd80da20c66b46ab6e-20191216
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1289468991; Mon, 16 Dec 2019 20:13:17 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 16 Dec 2019 20:12:41 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Dec 2019 20:12:59 +0800
Message-ID: <1576498396.28043.78.camel@mhfsdcap03>
Subject: Re: [RESEND,PATCH 03/13] iommu/mediatek: Add mtk_iommu_pgtable
 structure
From: Yong Wu <yong.wu@mediatek.com>
To: Chao Hao <chao.hao@mediatek.com>
Date: Mon, 16 Dec 2019 20:13:16 +0800
In-Reply-To: <20191104115238.2394-4-chao.hao@mediatek.com>
References: <20191104115238.2394-1-chao.hao@mediatek.com>
 <20191104115238.2394-4-chao.hao@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 39EAD26C571E2DA9A3ADF7D67BFB280A5C20D797FC547AE679A650866EB2D9B32000:8
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
 Cui Zhang <cui.zhang@mediatek.com>, Jun Yan <jun.yan@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Miles Chen <miles.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Guangming Cao <guangming.cao@mediatek.com>
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

On Mon, 2019-11-04 at 19:52 +0800, Chao Hao wrote:
> Start with this patch, we will change the SW architecture
> to support multiple domains. SW architecture will has a big change,
> so we need to modify a little bit by more than one patch.
> The new SW overall architecture is as below:
> 
> 				iommu0   iommu1
> 				  |	    |
> 				  -----------
> 					|
> 				mtk_iommu_pgtable
> 					|
> 			------------------------------------------
> 			|		     |			 |
> 		mtk_iommu_domain1   mtk_iommu_domain2  mtk_iommu_domain3
> 			|                    |                   |
> 		iommu_group1         iommu_group2           iommu_group3
> 			|                    |                   |
> 		iommu_domain1       iommu_domain2	    iommu_domain3
> 			|                    |                   |
> 		iova region1(normal)  iova region2(CCU)    iova region3(VPU)
> 
> For current structure, no matter how many iommus there are,
> they use the same page table to simplify the usage of module.
> In order to make the software architecture more explicit, this
> patch will create a global mtk_iommu_pgtable structure to describe
> page table and all the iommus use it.

Thanks for the hard work of this file. Actually this patch and the later
ones confuse me. Why do you make this flow change? 
for making the code "more explicit" or for adding multi-domain support
in 13/13.

IMHO, the change is unnecessary.
a) For me, this change has no improvement. currently we use a global
mtk_iommu_get_m4u_data to get the M4U data. I will be very glad if you
could get rid of it. But in this patchset, You use a another global
mtk_iommu_pgtable to instead. For me. It has no improvement.

b) This patchset break the original flow. device_group give you a
software chance for initializing, then you move pagetable allocating
code into it. But it isn't device_group job.

I can not decide if your flow is right. But if you only want to add
support multi-domain, I guess you could extend the current "m4u_group"
to a array "m4u_group[N]". It may be more simple. To make mt6779
progress easily, I suggest you can use this way to support multi-domain
firstly. Then you could send this new mtk_iommu_pgtable patchset for the
code "more explicit" if you insist.

> The diagram is as below:
> 
> 	mtk_iommu_data1(MM)       mtk_iommu_data2(APU)
> 		|			   |
> 		|			   |
> 		------mtk_iommu_pgtable-----
> 
> We need to create global mtk_iommu_pgtable to include all the iova
> regions firstly and special iova regions by divided based on it,
> so the information of pgtable needs to be created in device_group.
> 
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 84 +++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/mtk_iommu.h |  1 +
>  2 files changed, 85 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index f2847e661137..fcbde6b0f58d 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -123,6 +123,12 @@ struct mtk_iommu_domain {
>  	struct iommu_domain		domain;
>  };
>  
> +struct mtk_iommu_pgtable {
> +	struct io_pgtable_cfg	cfg;
> +	struct io_pgtable_ops	*iop;
> +};
> +
> +static struct mtk_iommu_pgtable *share_pgtable;
>  static const struct iommu_ops mtk_iommu_ops;
>  
>  /*
> @@ -170,6 +176,11 @@ static struct mtk_iommu_data *mtk_iommu_get_m4u_data(void)
>  	return NULL;
>  }
>  
> +static struct mtk_iommu_pgtable *mtk_iommu_get_pgtable(void)
> +{
> +	return share_pgtable;
> +}
> +
>  static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
>  {
>  	return container_of(dom, struct mtk_iommu_domain, domain);
> @@ -322,6 +333,13 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
>  {
>  	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
>  
> +	if (data->pgtable) {
> +		dom->cfg = data->pgtable->cfg;
> +		dom->iop = data->pgtable->iop;
> +		dom->domain.pgsize_bitmap = data->pgtable->cfg.pgsize_bitmap;
> +		return 0;
> +	}
> +
>  	dom->cfg = (struct io_pgtable_cfg) {
>  		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
>  			IO_PGTABLE_QUIRK_NO_PERMS |
> @@ -345,6 +363,61 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
>  	return 0;
>  }
>  
> +static struct mtk_iommu_pgtable *create_pgtable(struct mtk_iommu_data *data)
> +{
> +	struct mtk_iommu_pgtable *pgtable;
> +
> +	pgtable = kzalloc(sizeof(*pgtable), GFP_KERNEL);
> +	if (!pgtable)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pgtable->cfg = (struct io_pgtable_cfg) {
> +		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
> +			IO_PGTABLE_QUIRK_NO_PERMS |
> +			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
> +			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
> +		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
> +		.ias = 32,
> +		.oas = 34,
> +		.tlb = &mtk_iommu_flush_ops,
> +		.iommu_dev = data->dev,
> +	};
> +
> +	pgtable->iop = alloc_io_pgtable_ops(ARM_V7S, &pgtable->cfg, data);
> +	if (!pgtable->iop) {
> +		dev_err(data->dev, "Failed to alloc io pgtable\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	dev_info(data->dev, "%s create pgtable done\n", __func__);
> +
> +	return pgtable;
> +}
> +
> +static int mtk_iommu_attach_pgtable(struct mtk_iommu_data *data,
> +				    struct device *dev)
> +{
> +	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
> +
> +	/* create share pgtable */
> +	if (!pgtable) {
> +		pgtable = create_pgtable(data);
> +		if (IS_ERR(pgtable)) {
> +			dev_err(data->dev, "Failed to create pgtable\n");
> +			return -ENOMEM;
> +		}
> +
> +		share_pgtable = pgtable;
> +	}
> +
> +	/* binding to pgtable */
> +	data->pgtable = pgtable;
> +
> +	dev_info(data->dev, "m4u%d attach_pgtable done!\n", data->m4u_id);
> +
> +	return 0;
> +}
> +
>  static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
>  {
>  	struct mtk_iommu_domain *dom;
> @@ -508,10 +581,21 @@ static void mtk_iommu_remove_device(struct device *dev)
>  static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>  {
>  	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> +	struct mtk_iommu_pgtable *pgtable;
> +	int ret = 0;
>  
>  	if (!data)
>  		return ERR_PTR(-ENODEV);
>  
> +	pgtable = data->pgtable;
> +	if (!pgtable) {
> +		ret = mtk_iommu_attach_pgtable(data, dev);
> +		if (ret) {
> +			dev_err(data->dev, "Failed to device_group\n");
> +			return NULL;
> +		}
> +	}
> +
>  	/* All the client devices are in the same m4u iommu-group */
>  	if (!data->m4u_group) {
>  		data->m4u_group = iommu_group_alloc();
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 132dc765a40b..dd5f19f78b62 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -61,6 +61,7 @@ struct mtk_iommu_data {
>  	struct clk			*bclk;
>  	phys_addr_t			protect_base; /* protect memory base */
>  	struct mtk_iommu_suspend_reg	reg;
> +	struct mtk_iommu_pgtable	*pgtable;
>  	struct mtk_iommu_domain		*m4u_dom;
>  	struct iommu_group		*m4u_group;
>  	bool                            enable_4GB;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
