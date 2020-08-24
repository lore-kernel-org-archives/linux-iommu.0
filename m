Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9CAC433E1
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 21:40:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B0F20702
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 21:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tJ6RhK6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B0F20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F15F860B0;
	Mon, 24 Aug 2020 21:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aSfDUflThXyQ; Mon, 24 Aug 2020 21:40:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7513085F4E;
	Mon, 24 Aug 2020 21:40:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 582E0C07FF;
	Mon, 24 Aug 2020 21:40:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6B88C0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 21:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6303A85FFC
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 21:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wKKXr475u9AR for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 21:40:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3CBFF85F4E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 21:40:43 +0000 (UTC)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07OLdsPY046027;
 Mon, 24 Aug 2020 16:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1598305194;
 bh=bf+6mDZifTI9HQJSeivn4me8d5zREYk1XPJ3eAaDXHY=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=tJ6RhK6wvGyEiAhqwOPDwT69Y3+7BoJNjgEuOOW+0PGCMSlzIrjy7T2GrEFwuAAcZ
 51c8X4oGyc7X5b+1hxYLGjFw1iyT+DGwI6G2Whe/r0fmJRG1pX1zZGWT3yn2053eaa
 4Szann3xS0X39D0KAerooEYGEMuFIf1zy1xME1pQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07OLdr7q044652
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 24 Aug 2020 16:39:53 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 24
 Aug 2020 16:39:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 24 Aug 2020 16:39:53 -0500
Received: from [10.250.32.171] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07OLdqBH090259;
 Mon, 24 Aug 2020 16:39:52 -0500
Subject: Re: [PATCH 11/18] iommu/omap: Add IOMMU_DOMAIN_DMA support
To: Robin Murphy <robin.murphy@arm.com>, <hch@lst.de>, <joro@8bytes.org>,
 <linux@armlinux.org.uk>
References: <cover.1597931875.git.robin.murphy@arm.com>
 <5ac3788f9f61f7698cfa9c5924d62714e230f678.1597931876.git.robin.murphy@arm.com>
Message-ID: <c98765ad-e824-a54c-7cf8-c245dbf960d3@ti.com>
Date: Mon, 24 Aug 2020 16:39:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5ac3788f9f61f7698cfa9c5924d62714e230f678.1597931876.git.robin.murphy@arm.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 matthias.bgg@gmail.com, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, digetx@gmail.com, will@kernel.org,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
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
From: Suman Anna via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

On 8/20/20 10:08 AM, Robin Murphy wrote:
> Now that arch/arm is wired up for default domains and iommu-dma,
> implement the corresponding driver-side support for DMA domains.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/omap-iommu.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 71f29c0927fc..ea25c2fe0418 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -9,6 +9,7 @@
>   *		Paul Mundt and Toshihiro Kobayashi
>   */
>  
> +#include <linux/dma-iommu.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> @@ -1574,13 +1575,19 @@ static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
>  {
>  	struct omap_iommu_domain *omap_domain;
>  
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> +	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>  		return NULL;
>  
>  	omap_domain = kzalloc(sizeof(*omap_domain), GFP_KERNEL);
>  	if (!omap_domain)
>  		return NULL;
>  
> +	if (type == IOMMU_DOMAIN_DMA &&
> +	    iommu_get_dma_cookie(&omap_domain->domain)) {
> +		kfree(omap_domain);
> +		return NULL;
> +	}
> +
>  	spin_lock_init(&omap_domain->lock);
>  
>  	omap_domain->domain.geometry.aperture_start = 0;
> @@ -1601,6 +1608,7 @@ static void omap_iommu_domain_free(struct iommu_domain *domain)
>  	if (omap_domain->dev)
>  		_omap_iommu_detach_dev(omap_domain, omap_domain->dev);
>  
> +	iommu_put_dma_cookie(&omap_domain->domain);
>  	kfree(omap_domain);
>  }
>  
> @@ -1736,6 +1744,17 @@ static struct iommu_group *omap_iommu_device_group(struct device *dev)
>  	return group;
>  }
>  
> +static int omap_iommu_of_xlate(struct device *dev,
> +			       struct of_phandle_args *args)
> +{
> +	/*
> +	 * Logically, some of the housekeeping from _omap_iommu_add_device()
> +	 * should probably move here, but the minimum we *need* is simply to
> +	 * cooperate with of_iommu at all to let iommu-dma work.
> +	 */
> +	return 0;
> +}
> +

I have tested this series, and it is breaking the OMAP remoteproc functionality.
We definitely need some more plumbing. I am currently getting MMU faults and
also the DMA allocated addresses are not coming from the device-specific CMA
pools (opposite of what Sakari has reported with OMAP3 ISP). Just removing the
of_xlate gets me back the expected allocations, and no MMU faults, but I don't
see any valid traces.

The MMU devices that the OMAP IOMMU driver deals with are not traditional
bus-level IOMMU devices, but local MMU devices that are present within a remote
processor sub-system or hardware accelerator (eg: OMAP3 ISP). The usage is also
slightly different between remoteprocs and OMAP3 ISP. The former uses the CMA
pools and iommu_map/unmap API (UNMANAGED iommu domain), as the allocated regions
need to be mapped using specific device addresses adhering to the firmware
linker map, while OMAP3 ISP uses it like a traditional DMA pool.

regards
Suman

>  static const struct iommu_ops omap_iommu_ops = {
>  	.domain_alloc	= omap_iommu_domain_alloc,
>  	.domain_free	= omap_iommu_domain_free,
> @@ -1747,6 +1766,7 @@ static const struct iommu_ops omap_iommu_ops = {
>  	.probe_device	= omap_iommu_probe_device,
>  	.release_device	= omap_iommu_release_device,
>  	.device_group	= omap_iommu_device_group,
> +	.of_xlate	= omap_iommu_of_xlate,
>  	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
>  };
>  
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
