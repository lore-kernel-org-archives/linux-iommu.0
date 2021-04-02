Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4CFC433B4
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:39:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DAF60FF3
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DAF60FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D45E484BC9;
	Fri,  2 Apr 2021 01:39:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jNTRngAtPa8C; Fri,  2 Apr 2021 01:39:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A430884B8A;
	Fri,  2 Apr 2021 01:39:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8567DC000B;
	Fri,  2 Apr 2021 01:39:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C7B9C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 8612E84B9D
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:39:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id QS2Z9Zt8eFvg for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 01:39:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id BCCB984B8A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:39:43 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617327584; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RmuH0hhJr6wxUwqCriDjPq7/6SvyZdBMyqGQoZGSs+g=;
 b=CT5Hx8Ey736rkisXrhsmB+9TTz5TOZkNptd4ApJwUQoY884pKtsTXqE/lBZ1D2EVTsPbg0Pc
 p+oVzx+5ZOrrbqKxHlfuf0TAanbRoTGe/8oRn/NHvbw9z+1Drg+ysDKCg8ojt+pisFuQLUNn
 MpmlSzQTIoGri9YpLyaq+LXKHnk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 606675d88166b7eff7737c3e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Apr 2021 01:39:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 24C56C43463; Fri,  2 Apr 2021 01:39:36 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FEAAC433C6;
 Fri,  2 Apr 2021 01:39:35 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 01 Apr 2021 18:39:35 -0700
From: isaacm@codeaurora.org
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 3/6] iommu: Use bitmap to calculate page size in
 iommu_pgsize()
In-Reply-To: <20210401164738.9513-4-will@kernel.org>
References: <20210401164738.9513-1-will@kernel.org>
 <20210401164738.9513-4-will@kernel.org>
Message-ID: <7c012a63e8a5ad1856aac08995e6f154@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Pratik Patel <pratikp@codeaurora.org>, linux-arm-kernel@lists.infradead.org
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

On 2021-04-01 09:47, Will Deacon wrote:
> Avoid the potential for shifting values by amounts greater than the
> width of their type by using a bitmap to compute page size in
> iommu_pgsize().
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/iommu.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d0b0a15dba84..bcd623862bf9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -8,6 +8,7 @@
> 
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/bits.h>
>  #include <linux/bug.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
> @@ -2360,30 +2361,22 @@ static size_t iommu_pgsize(struct iommu_domain 
> *domain,
>  			   unsigned long addr_merge, size_t size)
>  {
>  	unsigned int pgsize_idx;
> +	unsigned long pgsizes;
>  	size_t pgsize;
> 
> -	/* Max page size that still fits into 'size' */
> -	pgsize_idx = __fls(size);
> +	/* Page sizes supported by the hardware and small enough for @size */
> +	pgsizes = domain->pgsize_bitmap & GENMASK(__fls(size), 0);
I've fixed this in the latest RFC for the iommu_map/unmap optimization 
patches,
but for the sake of completeness: I think this should be GENMASK_ULL, in 
case
__fls(size) >= 32.

Thank you for these patches, by the way. I've looked through them and 
they
make sense/seem correct. I've integrated them into the latest RFC: 
https://lore.kernel.org/linux-iommu/20210402013452.4013-1-isaacm@codeaurora.org/T/#t.

Thanks,
Isaac
> 
> -	/* need to consider alignment requirements ? */
> -	if (likely(addr_merge)) {
> -		/* Max page size allowed by address */
> -		unsigned int align_pgsize_idx = __ffs(addr_merge);
> -		pgsize_idx = min(pgsize_idx, align_pgsize_idx);
> -	}
> -
> -	/* build a mask of acceptable page sizes */
> -	pgsize = (1UL << (pgsize_idx + 1)) - 1;
> -
> -	/* throw away page sizes not supported by the hardware */
> -	pgsize &= domain->pgsize_bitmap;
> +	/* Constrain the page sizes further based on the maximum alignment */
> +	if (likely(addr_merge))
> +		pgsizes &= GENMASK(__ffs(addr_merge), 0);
> 
> -	/* make sure we're still sane */
> -	BUG_ON(!pgsize);
> +	/* Make sure we have at least one suitable page size */
> +	BUG_ON(!pgsizes);
> 
> -	/* pick the biggest page */
> -	pgsize_idx = __fls(pgsize);
> -	pgsize = 1UL << pgsize_idx;
> +	/* Pick the biggest page size remaining */
> +	pgsize_idx = __fls(pgsizes);
> +	pgsize = BIT(pgsize_idx);
> 
>  	return pgsize;
>  }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
