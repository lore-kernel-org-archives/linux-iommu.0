Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA5CC433E1
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 15:09:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA872075B
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 15:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E040T9qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA872075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4D97087746;
	Mon, 13 Jul 2020 15:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id exlnjm5G8BcO; Mon, 13 Jul 2020 15:09:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B7A9F8840E;
	Mon, 13 Jul 2020 15:09:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A058FC088E;
	Mon, 13 Jul 2020 15:09:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D221EC0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 15:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C0DAF87431
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 15:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z2uhc1OoSukq for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 15:09:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4E6EA872A4
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 15:09:09 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C8A14205CB;
 Mon, 13 Jul 2020 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594652947;
 bh=vngHFPy6JLQna7o2+Dx1IPDqHMOEQth8MnxQOxW04yA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E040T9qhClnKRLJxdVpFYW9R6VpwPxG9f7y42Fa2tHvqsGskw4NuW6j0cd3ObUudq
 C88NkzK3mA+1rIsiiflU4VV5PwpEa7I2V/YQEyD1t8Tu42WQKdA1ZFog36C6ESpbNV
 57ZOU5atVZ7mjGB1ufC8p0H5F1tiOPa8sFPjAVqs=
Date: Mon, 13 Jul 2020 16:09:02 +0100
From: Will Deacon <will@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v9 4/7] iommu/arm-smmu: Add a pointer to the attached
 device to smmu_domain
Message-ID: <20200713150901.GA3072@willie-the-truck>
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
 <20200626200042.13713-5-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626200042.13713-5-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, freedreno@lists.freedesktop.org,
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

On Fri, Jun 26, 2020 at 02:00:38PM -0600, Jordan Crouse wrote:
> Add a link to the pointer to the struct device that is attached to a
> domain. This makes it easy to get the pointer if it is needed in the
> implementation specific code.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/iommu/arm-smmu.c | 6 ++++--
>  drivers/iommu/arm-smmu.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 048de2681670..060139452c54 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -668,7 +668,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
>  }
>  
>  static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> -					struct arm_smmu_device *smmu)
> +					struct arm_smmu_device *smmu,
> +					struct device *dev)
>  {
>  	int irq, start, ret = 0;
>  	unsigned long ias, oas;
> @@ -801,6 +802,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		cfg->asid = cfg->cbndx;
>  
>  	smmu_domain->smmu = smmu;
> +	smmu_domain->dev = dev;
>  
>  	pgtbl_cfg = (struct io_pgtable_cfg) {
>  		.pgsize_bitmap	= smmu->pgsize_bitmap,
> @@ -1190,7 +1192,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		return ret;
>  
>  	/* Ensure that the domain is finalised */
> -	ret = arm_smmu_init_domain_context(domain, smmu);
> +	ret = arm_smmu_init_domain_context(domain, smmu, dev);
>  	if (ret < 0)
>  		goto rpm_put;
>  
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 5f2de20e883b..d33cfe26b2f5 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -345,6 +345,7 @@ struct arm_smmu_domain {
>  	struct mutex			init_mutex; /* Protects smmu pointer */
>  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>  	struct iommu_domain		domain;
> +	struct device			*dev;	/* Device attached to this domain */

This really doesn't feel right to me -- you can generally have multiple
devices attached to a domain and they can come and go without the domain
being destroyed. Perhaps you could instead identify the GPU during
cfg_probe() and squirrel that information away somewhere?

The rest of the series looks ok to me.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
