Return-Path: <SRS0=JP6a=XN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C31C4CEC9
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 15:37:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E3821907
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 15:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6RCkLeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E3821907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3CE67CB5;
	Wed, 18 Sep 2019 15:37:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F29D4C4E;
	Wed, 18 Sep 2019 15:37:42 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AB12683A;
	Wed, 18 Sep 2019 15:37:42 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id E422A21848;
	Wed, 18 Sep 2019 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568821062;
	bh=o8d7dJQnvHL39KRSK6KjVP0f0KtmfzKyIduld2o7JMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6RCkLeoK1SHQW8pEwDSkWFf3OL7vtPollpZp9p6cfdYVaaOTfpSbPfvfQfWkO448
	IGY6tm12B5p36OrH3wTXMnkgWd7r7VJ2184V0HrBsuKhv7eWKSjpmpiZmsslReXLrc
	8L1mSHwAHB0oZ2pSUrJYW7DWdjpkn3bCs1TJP5AI=
Date: Wed, 18 Sep 2019 16:37:38 +0100
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/5] iommu: Implement iommu_put_resv_regions_simple()
Message-ID: <20190918153737.dea2z5dddhuus25g@willie-the-truck>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
	<20190829111752.17513-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190829111752.17513-2-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Aug 29, 2019 at 01:17:48PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Implement a generic function for removing reserved regions. This can be
> used by drivers that don't do anything fancy with these regions other
> than allocating memory for them.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  include/linux/iommu.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0f585b614657..73a2a6b13507 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2170,6 +2170,25 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  		ops->put_resv_regions(dev, list);
>  }
>  
> +/**
> + * iommu_put_resv_regions_simple - Reserved region driver helper
> + * @dev: device for which to free reserved regions
> + * @list: reserved region list for device
> + *
> + * IOMMU drivers can use this to implement their .put_resv_regions() callback
> + * for simple reservations. Memory allocated for each reserved region will be
> + * freed. If an IOMMU driver allocates additional resources per region, it is
> + * going to have to implement a custom callback.
> + */
> +void iommu_put_resv_regions_simple(struct device *dev, struct list_head *list)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	list_for_each_entry_safe(entry, next, list, list)
> +		kfree(entry);
> +}
> +EXPORT_SYMBOL(iommu_put_resv_regions_simple);

Can you call this directly from iommu_put_resv_regions() if the function
pointer in ops is NULL? That would save having to plumb the default callback
into a bunch of drivers.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
