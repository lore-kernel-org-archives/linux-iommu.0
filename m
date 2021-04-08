Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0EAC433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:58:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704E66102A
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704E66102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 390AF84B0A;
	Thu,  8 Apr 2021 13:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZXenhjbRG4Y; Thu,  8 Apr 2021 13:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2457B84AF7;
	Thu,  8 Apr 2021 13:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE069C000B;
	Thu,  8 Apr 2021 13:58:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46A4DC000B
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2806B84B0A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p5ZcddjvY7Wz for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 13:58:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA52F84AF7
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:58:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2177D610FB;
 Thu,  8 Apr 2021 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617890292;
 bh=sE1Qram1VeOU1YRXJK66SXAyjytxycG6cooodItBbOg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gAa3xHbEsySDocFO0l126rUM6WglwRSvMNmU6KhY9EiZH30VgD3H2weMujNwNPn+m
 8aT+c27X+WP/Bav9yB4lhEr89xiLcPKLUq+dgw1OygwV5CSx5ZBjSY1J/qjBKk8bLD
 TfajsOyOV6CzKvn8/QyC2llHhifHms7wBXJaT0/s6Au7vLvE6/T8Wml4q0nWVoF4nx
 p72glfnIf5yTTMyuq+hxf/5b2WBTPUlVtkA/dnZ86webbRqNKwzT11m2Zx6gBTIyIT
 Y3MoeXeTodIanOSzu0rjXacHor9lc0Nu9zwrCt8dPMBoN1lPwqaXNq5cjAEdPw7UZW
 TnDTVFyDHpMIw==
Date: Thu, 8 Apr 2021 14:58:07 +0100
From: Will Deacon <will@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH v4 12/15] iommu/io-pgtable-arm-v7s: Implement
 arm_v7s_unmap_pages()
Message-ID: <20210408135807.GA17998@willie-the-truck>
References: <20210408045241.27316-1-isaacm@codeaurora.org>
 <20210408045241.27316-13-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408045241.27316-13-isaacm@codeaurora.org>
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

On Wed, Apr 07, 2021 at 09:52:38PM -0700, Isaac J. Manjarres wrote:
> Implement the unmap_pages() callback for the ARM v7s io-pgtable
> format.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index d4004bcf333a..5e203e03c352 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -710,15 +710,32 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
>  	return __arm_v7s_unmap(data, gather, iova, size, lvl + 1, ptep);
>  }
>  
> -static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> -			    size_t size, struct iommu_iotlb_gather *gather)
> +static size_t arm_v7s_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
> +				  size_t pgsize, size_t pgcount,
> +				  struct iommu_iotlb_gather *gather)
>  {
>  	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	size_t unmapped = 0, ret;
>  
>  	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
>  		return 0;
>  
> -	return __arm_v7s_unmap(data, gather, iova, size, 1, data->pgd);
> +	while (pgcount--) {
> +		ret = __arm_v7s_unmap(data, gather, iova, pgsize, 1, data->pgd);
> +		if (!ret)
> +			break;
> +
> +		unmapped += pgsize;
> +		iova += pgsize;
> +	}
> +
> +	return unmapped;
> +}

Wait -- don't you need to hook this up somewhere (likewise for ->map_pages)?
How are you testing this?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
