Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAB7C56201
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 21:39:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6763520866
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 21:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XerLvPVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6763520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0BEE88475A;
	Tue, 24 Nov 2020 21:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1zIC-SxFkHe; Tue, 24 Nov 2020 21:39:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F0E38405F;
	Tue, 24 Nov 2020 21:39:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61514C163C;
	Tue, 24 Nov 2020 21:39:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37EA2C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 215F88475A
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3BGefHwRZ4Ab for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:39:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C55AB8405F
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:39:24 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F157A2083E;
 Tue, 24 Nov 2020 21:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606253964;
 bh=BTK/WvWriIxnwavgHEbW5VAszssfpXosYOXxF+X6xRY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XerLvPVsvsKgeHuOc3H2w+A9dpR9WF2I/J/sOhvd4pEgfTaULs6Zka5HUR6sNO7C0
 n0QTKF4Qcd7eAf9jC88hpOBV9Hx8GOSR13pwnXHJZ+pNd9rBN/gXcSWoXf4jfVS1yb
 McYowqtP4ITtSgcwUpXu9MR9Ea0jgn67AngC4Bpw=
Date: Tue, 24 Nov 2020 21:39:18 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv9 3/8] iommu/arm-smmu: Move non-strict mode to use
 io_pgtable_domain_attr
Message-ID: <20201124213917.GA14252@willie-the-truck>
References: <cover.1606150259.git.saiprakash.ranjan@codeaurora.org>
 <47f8e9760a7fba8b58ea89c9add96f5615f97014.1606150259.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47f8e9760a7fba8b58ea89c9add96f5615f97014.1606150259.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Nov 23, 2020 at 10:35:56PM +0530, Sai Prakash Ranjan wrote:
> Now that we have a struct io_pgtable_domain_attr with quirks,
> use that for non_strict mode as well thereby removing the need
> for more members of arm_smmu_domain in the future.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 8 +++-----
>  drivers/iommu/arm/arm-smmu/arm-smmu.h | 1 -
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4b9b10fe50ed..f56f266ebdf7 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -786,9 +786,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  			goto out_clear_smmu;
>  	}
>  
> -	if (smmu_domain->non_strict)
> -		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> -
>  	if (smmu_domain->pgtbl_cfg.quirks)
>  		pgtbl_cfg.quirks |= smmu_domain->pgtbl_cfg.quirks;
>  
> @@ -1527,7 +1524,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  	case IOMMU_DOMAIN_DMA:
>  		switch (attr) {
>  		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			*(int *)data = smmu_domain->non_strict;
> +			if (smmu_domain->pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT)
> +				*(int *)data = smmu_domain->pgtbl_cfg.quirks;

I still don't think this is right :(
We need to set *data to 1 or 0 depending on whether or not the non-strict
quirk is set, i.e:

	bool non_strict = smmu_domain->pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT;
	*(int *)data = non_strict;

Your code above leaves *data uninitialised if non_strict is not set.

>  			return 0;
>  		default:
>  			return -ENODEV;
> @@ -1578,7 +1576,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>  	case IOMMU_DOMAIN_DMA:
>  		switch (attr) {
>  		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			smmu_domain->non_strict = *(int *)data;
> +			smmu_domain->pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;

And this is broken because if *data is 0, then you _set_ the quirk, which is
the opposite of what we should be doing.

In other words, although the implementation has changed, the semantics have
not.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
