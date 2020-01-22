Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE7C33CAF
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 11:28:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A62424684
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 11:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUhRzvJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A62424684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AE70B2035D;
	Wed, 22 Jan 2020 11:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MAppzqQe5kAr; Wed, 22 Jan 2020 11:28:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AF21A20341;
	Wed, 22 Jan 2020 11:28:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80B68C0176;
	Wed, 22 Jan 2020 11:28:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E751DC0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 11:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE97887BC2
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 11:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dOODWyGSNCsF for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 11:27:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CE5E886A14
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 11:27:58 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id s144so1380998wme.1
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 03:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=knvu6hj1YMdRv4GxaaPdJaGKBIjx4ZURVNFJlu663gI=;
 b=QUhRzvJR/E8Tg8y8gbycgQzQNnl76Ro3IiAtj841XZXgVvQ2faPL+5dfpU+bMK/IFf
 CDCtXlucnexvdoSIMlgLH8lexY71sdGS4ofwsyO+epzJOTnSWFPK1Gk9RoTduH2iuv2z
 uihDmhyI4rhOYY2mfozgGc4x+6GC7/SLVFZ7GHZFMERQ+mHsFbNnvHb1Z8YWrHYQ2x5n
 bvKjZlyrBv9YmT3h89o7iw28opeiPeEqwnqWZ0dPU964Fxd4DquHdZoUmm+JoeRkMQCn
 BNZDrzJuQRqwZukt1Q6HBMzVw3yvbjgzv5MWnIYkIF5mRO0U0B1+K0l5k6Apd7qxyEVY
 QJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=knvu6hj1YMdRv4GxaaPdJaGKBIjx4ZURVNFJlu663gI=;
 b=Iw1siSfgX73rnumFkVxaMWV8wisui5rerPFZCycvYqLXzQjRA0asilikZZQfmfjhHP
 2XLQbj5X729pHkFv7+SUzxK4xO7dc9BAmEDWiRDQJGgGSkVUYyv1oWzw13srtGnMIVUe
 FZhsLPtcQ55N3rGXK9LNfmRjP32URtXDvh/Uvxwh0w6I2qnOwod5PC2Vt6OD/sNSThh8
 OMoxdB80ktHI2QohgFKkzs7fnn2BAUsT3cyacrVv3hqTcCBXHLxIUrIYNFHYOFsBytB4
 ACilk2gH65vxBg8x3vRlGzS4icbdnv4V+xp/4rgRdLmmz9BcKGY0Qj3VK7IixLg/bYNZ
 1q0Q==
X-Gm-Message-State: APjAAAUuk0U2+WtWuZ1PZUdhvrPQZV/hZsahWDAJxRrLowNF3+LeR4LP
 NSpdBq3USu2KSkK9mtSeuKokRA==
X-Google-Smtp-Source: APXvYqwWtRST1C66yMeWxDBk4S6jeuNNRCmbja2XQ6zWcWnM1yCeh4Ts9WlBoKEdUq+IeB7iVVgukw==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr2450662wmc.173.1579692477218; 
 Wed, 22 Jan 2020 03:27:57 -0800 (PST)
Received: from myrica ([2001:171b:c9ad:af70:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q6sm60111383wrx.72.2020.01.22.03.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 03:27:56 -0800 (PST)
Date: Wed, 22 Jan 2020 12:27:51 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Batch ATC invalidation commands
Message-ID: <20200122112751.GA635551@myrica>
References: <20200113143906.11121-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200113143906.11121-1-robh@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Hi Rob,

On Mon, Jan 13, 2020 at 08:39:06AM -0600, Rob Herring wrote:
> Similar to commit 2af2e72b18b4 ("iommu/arm-smmu-v3: Defer TLB
> invalidation until ->iotlb_sync()"), build up a list of ATC invalidation
> commands and submit them all at once to the command queue instead of
> one-by-one.
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index effe72eb89e7..e91b4a098215 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1919,10 +1919,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
>  static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>  				   int ssid, unsigned long iova, size_t size)
>  {
> -	int ret = 0;
> +	int i, cmdn = 0;
>  	unsigned long flags;
>  	struct arm_smmu_cmdq_ent cmd;
>  	struct arm_smmu_master *master;
> +	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
>  
>  	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
>  		return 0;
> @@ -1947,11 +1948,25 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>  	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -	list_for_each_entry(master, &smmu_domain->devices, domain_head)
> -		ret |= arm_smmu_atc_inv_master(master, &cmd);

It may be worth reworking arm_smmu_atc_inv_master() as well since it's now
only called by arm_smmu_disable_ats() to invalidate the whole ATC. I don't
think it requires batching (it's not on any fast path and num_sids will
almost always be 1), but it doesn't need the cmd argument anymore.

Thanks,
Jean

> +	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +		if (!master->ats_enabled)
> +			continue;
> +
> +		for (i = 0; i < master->num_sids; i++) {
> +			if (cmdn == CMDQ_BATCH_ENTRIES) {
> +				arm_smmu_cmdq_issue_cmdlist(smmu_domain->smmu,
> +					cmds, cmdn, false);
> +				cmdn = 0;
> +			}
> +
> +			cmd.atc.sid = master->sids[i];
> +			arm_smmu_cmdq_build_cmd(&cmds[cmdn * CMDQ_ENT_DWORDS], &cmd);
> +			cmdn++;
> +		}
> +	}
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
> -	return ret ? -ETIMEDOUT : 0;
> +	return arm_smmu_cmdq_issue_cmdlist(smmu_domain->smmu, cmds, cmdn, true);
>  }
>  
>  /* IO_PGTABLE API */
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
