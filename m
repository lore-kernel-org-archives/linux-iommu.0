Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91131C433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:58:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A7A613C9
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A7A613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3A5B40285;
	Tue,  6 Apr 2021 01:58:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PfCv0NXK1hxx; Tue,  6 Apr 2021 01:58:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC40140468;
	Tue,  6 Apr 2021 01:58:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBE17C000C;
	Tue,  6 Apr 2021 01:58:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2FC3C000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF12C848D1
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:58:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ry5Atzd82B3f for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 01:58:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B033848CB
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:58:50 +0000 (UTC)
IronPort-SDR: QgvIt0/iYAH3RYmjGgy684lizDKE+mfCwouK9kX7ywHPwjgABd/iwBf7Bm5orr7eQwUkxrNeCe
 qoFfWpbDaagQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="173036602"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="173036602"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 18:58:49 -0700
IronPort-SDR: oeHHwjqaRE4ijc8v3/NGtbZ+kGMCPTJWIwtdM6chvFOhB4FVs0CXGp2Obv85gDW9K8VSyOCGga
 4LPvtVtU69vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="440728272"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2021 18:58:48 -0700
Subject: Re: [RFC PATCH v3 04/12] iommu: Add a map_pages() op for IOMMU drivers
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <20210405191112.28192-1-isaacm@codeaurora.org>
 <20210405191112.28192-5-isaacm@codeaurora.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f62db5e6-1e2b-8ee0-3198-59fdeb16ee4d@linux.intel.com>
Date: Tue, 6 Apr 2021 09:49:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210405191112.28192-5-isaacm@codeaurora.org>
Content-Language: en-US
Cc: robin.murphy@arm.com, will@kernel.org, pratikp@codeaurora.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/6/21 3:11 AM, Isaac J. Manjarres wrote:
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
>   include/linux/iommu.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9cf81242581a..528d6a58479e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -192,6 +192,8 @@ struct iommu_iotlb_gather {
>    * @attach_dev: attach device to an iommu domain
>    * @detach_dev: detach device from an iommu domain
>    * @map: map a physically contiguous memory region to an iommu domain
> + * @map_pages: map a physically contiguous set of pages of the same size to
> + *             an iommu domain.
>    * @unmap: unmap a physically contiguous memory region from an iommu domain
>    * @unmap_pages: unmap a number of pages of the same size from an iommu domain
>    * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
> @@ -244,6 +246,9 @@ struct iommu_ops {
>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> +	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
> +			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			 int prot, gfp_t gfp, size_t *mapped);
>   	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
>   		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
>   	size_t (*unmap_pages)(struct iommu_domain *domain, unsigned long iova,
> 

This looks good to me.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
