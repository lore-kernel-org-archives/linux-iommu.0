Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD6AC433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 11:58:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C07611AF
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 11:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C07611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B78160664;
	Tue,  6 Apr 2021 11:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cw2mBHJc7biQ; Tue,  6 Apr 2021 11:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CEA46062E;
	Tue,  6 Apr 2021 11:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BD03C000B;
	Tue,  6 Apr 2021 11:58:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2187AC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E980402D7
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kUlvyz0rV068 for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 11:58:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47C80401D0
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:58:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1D6061019;
 Tue,  6 Apr 2021 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617710292;
 bh=x1kNZt9arPO+gkS4yLBAeurwV80dRJyxHFz/hfkha+8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Np72cHPqUv7pxv4nJ1w/sPDpMm1G+4QBjDmqYktQkhWFO/FcxBCyNFHkZOIebQA7G
 +KUn2/gaYlO+1Ksaz/wPXYFrtgd592O72g/+JKKlkSkIsYId8yTdP9KG1NLNsEd1c0
 dWw4egO5XPcFjh0am0w2sac/45vW8a+qqAB9DwbryBkKD5FwRMskiR7exZlXGLlDO7
 cr2nY7rFjuqSBCSctE5fqD7HMHkYi+hsossA3UisY6p/kU8OxUPgr7EMIBHkfMAgJQ
 1WI559QyLq8rdbn+2+ZkHoBnJJYF/RWKPn03q1hi/9qB48CYRl1Wii28MaJ2hBK36s
 rkTWXIisQEK9g==
Date: Tue, 6 Apr 2021 12:58:08 +0100
From: Will Deacon <will@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH v3 04/12] iommu: Add a map_pages() op for IOMMU drivers
Message-ID: <20210406115808.GE13747@willie-the-truck>
References: <20210405191112.28192-1-isaacm@codeaurora.org>
 <20210405191112.28192-5-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210405191112.28192-5-isaacm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Mon, Apr 05, 2021 at 12:11:04PM -0700, Isaac J. Manjarres wrote:
> Add a callback for IOMMU drivers to provide a path for the
> IOMMU framework to call into an IOMMU driver, which can
> call into the io-pgtable code, to map a physically contiguous
> rnage of pages of the same size.
> 
> For IOMMU drivers that do not specify a map_pages() callback,
> the existing logic of mapping memory one page block at a time
> will be used.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/iommu.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9cf81242581a..528d6a58479e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -192,6 +192,8 @@ struct iommu_iotlb_gather {
>   * @attach_dev: attach device to an iommu domain
>   * @detach_dev: detach device from an iommu domain
>   * @map: map a physically contiguous memory region to an iommu domain
> + * @map_pages: map a physically contiguous set of pages of the same size to
> + *             an iommu domain.
>   * @unmap: unmap a physically contiguous memory region from an iommu domain
>   * @unmap_pages: unmap a number of pages of the same size from an iommu domain
>   * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
> @@ -244,6 +246,9 @@ struct iommu_ops {
>  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>  	int (*map)(struct iommu_domain *domain, unsigned long iova,
>  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> +	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
> +			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			 int prot, gfp_t gfp, size_t *mapped);

(same comment as for the io-pgtable callback).

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
