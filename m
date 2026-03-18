Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28812C15A5
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871359; cv=none; b=gkLDmMngJF89ZZj8xaeOsDG9w7+qnMyeWjk1A+UNubWIZNTYF8lMok+pEDz97nXdZqNIEGqFPsEpPdehH3/Oxa3eopjg96+2VufMAA5R8i1Ef8SyW7temxIuf3+hYGCva9mNkPXh+ZGXe1k5K1bxgnbAyPkecHxnxY/tjWm4bAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871359; c=relaxed/simple;
	bh=HqUIH1+qdjXuqXvG79xkAqR86UdDeaKrxocv3JQHwGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUYp0dOZ2qtoKOxhcO9pBG9beWbkMGPosFKQZ9MH5XoCilJxH7AzNa6LnuhiiEI5QyYTBc9yloIY4rvsw9eTwrMsVN8wej0Nyto1aw0ZOXHTZ4Wc7UJIzzpkH5zIzPlc89Uuv0JjZXN93b2pGKMeoHkdbxODa18cvPVNE9RFG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGyM0PJs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGyM0PJs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b052562254so29655ad.0
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773871358; x=1774476158; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWL0RuLJN0YCYwd7OUvYKgvM4/v9ZFsPnPl8Rwt0VYI=;
        b=rGyM0PJslExYX0wgpPddvAap7FIBpWUpADPhDuFOOlU7SEkFtgX3qu8IVrfPINPYlu
         8Ii65bpE/XV64GsprCF35ut9AMVKcvNKUPhvI2oAEoKVIWkW7nsFfRK9sbymnRRh59UL
         TmgFWYNEdSmr1xrgxwJXkpCxCxaFtepHhDyS1Xm7U6AXGYSvvS4BaNKq7lNuhSwr6hut
         6kXBeV1kWeuk7txurrAvndUFvDy7HMo5MzGISFz2Ph5ovDax9n06bxA8XgTLPVhzqr/H
         Unmcmj99stwWQsXwJTzbse4PkgOYRHgulLPAvQsDr7hY6gdTDTo1YdWOA/MPYo0DBeCM
         wzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871358; x=1774476158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWL0RuLJN0YCYwd7OUvYKgvM4/v9ZFsPnPl8Rwt0VYI=;
        b=eZ1iRgKZAw0+2IxF5NHC4MPiivASiXOiTf0G5fOCsYV8RP9K3Veqmuy/9XvBBMcnnQ
         rgXTfNY4+JCmC7i4P3LLNhw+r39vKvR7TLScIApeeqbASNv91iiqZ3VDvGFL2krc34Nz
         iE2tMj5PC0DJ17US7VAVO4zgfxpujtUUY35WQolHli2SMpUz5HuRB6zkSawDny6Glu6V
         HfDvdCpjhrTmdG+LFBXGC5f6CYQKwulOpWOvsxpQe6jFPvoY0jfJaKGfez46SbniH3kS
         cjdNgl3Ycmom/Frln0QDE16W1b99mq98SHXm3NzbF6S9LEW4OuagblO2PyFBihOtCycj
         f9zg==
X-Forwarded-Encrypted: i=1; AJvYcCUi0fE9g082Q9QWLQlNpGBZZtsCUXy4S/ZTpagvyLv1ldt+ByyJ1MTpcM6o24b7sy5YMY8SfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4Jah2UNegvQzPr19NqIdilY68rbn8fNpXpI1kssyqdaXdhKJy
	Be/Kw8m9mivuajOpdFK7sHfNXToxwsAgCNM8B/HkofLy6pvUSfcDrNL9icTLz79R1g==
X-Gm-Gg: ATEYQzx/a7RzXGffSJDzy5qdpFbSQPNdbdUWwLVKU3RT0/ZGvVd/lH6VKvEeiGL9fQL
	IpPAOgyrqEMJB2yD2vtj9gSkNkixeaGFBOP0/73uqtsxmvIW5vq0aCS4opVvEWofXcqm1ikqfND
	+v4Tlg0BmJve6pxJraWvRoBsMU+dwGwcCqo21GJwbdJqrmJm93jZ90RGWRpLZJmy582K6V8gXvu
	8DZieis+/W2SrAqK8MuIgrtHpbTwR4v5E/4jUdYWEwThDId3hsgmMB924IX4SbFy2jskuL5ruoQ
	a38f80b1CyYEV646f1sJQgiQl71TbY+E7oE5pM3wLxTeYtovYPhpm1/6OPwVDTEbr3I1kl5BdUW
	lojibrgoff99QZQ+nIxQsidS2ypLWKGDVPsDQCu9ZSj+k/A+UcDuYNEExmy9am18VOKaGSHFSZ0
	//PbBqpLuJ/kwLnntygtcLfdnmGHj5IQsY42jpmmXfQ0TfNf/m/ieI9elL8mJddg==
X-Received: by 2002:a17:902:ebc5:b0:2a7:4151:2c74 with SMTP id d9443c01a7336-2b077df2de7mr1074425ad.16.1773871357349;
        Wed, 18 Mar 2026 15:02:37 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc62e4b53sm576347a91.7.2026.03.18.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:02:36 -0700 (PDT)
Date: Wed, 18 Mar 2026 22:02:32 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, jgg@nvidia.com, rafael@kernel.org, lenb@kernel.org, 
	praan@google.com, baolu.lu@linux.intel.com, xueshuai@linux.alibaba.com, 
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	vsethi@nvidia.com
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <absfAT4jgL2f3UfR@google.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>

Hi Nicolin,

On Tue, Mar 17, 2026 at 12:15:37PM -0700, Nicolin Chen wrote:
>An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
>aware of the timeout via a GERROR interrupt, the driver thread issuing the
>commands lacks a direct mechanism to verify whether its specific batch was
>the cause or not, as polling the CMD_SYNC status doesn't natively return a
>failure code, making it very difficult to coordinate per-device recovery.
>
>Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
>gap. When the ISR detects an ATC timeout, set the bit corresponding to the
>physical CMDQ index of the faulting CMD_SYNC command.
>
>On the issuer side, after polling completes (or times out), test and clear
>its dedicated bit. If set, override any generic timeout, return -ETIMEDOUT
>to trigger device quarantine.
>
>Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>---
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++++++++-
> 2 files changed, 20 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>index 36de2b0b2ebe6..3eb12a34b086a 100644
>--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>@@ -633,6 +633,7 @@ struct arm_smmu_cmdq {
> 	atomic_long_t			*valid_map;
> 	atomic_t			owner_prod;
> 	atomic_t			lock;
>+	unsigned long			*atc_sync_timeouts;
> 	bool				(*supports_cmd)(struct arm_smmu_cmdq_ent *ent);
> };
>
>diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>index 01030ffd2fe23..9c8972ebc94f9 100644
>--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>@@ -445,7 +445,10 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
> 		 * at the CMD_SYNC. Attempt to complete other pending commands
> 		 * by repeating the CMD_SYNC, though we might well end up back
> 		 * here since the ATC invalidation may still be pending.
>+		 *
>+		 * Mark the faulty batch in the bitmap for the issuer to match.
> 		 */
>+		set_bit(Q_IDX(&q->llq, cons), cmdq->atc_sync_timeouts);
> 		return;
> 	case CMDQ_ERR_CERROR_ILL_IDX:
> 	default:
>@@ -895,9 +898,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>
> 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
> 	if (sync) {
>+		u32 sync_prod;
>+
> 		llq.prod = queue_inc_prod_n(&llq, n);
>+		sync_prod = llq.prod;
>+
> 		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
>-		if (ret) {
>+		if (test_and_clear_bit(Q_IDX(&llq, sync_prod),
>+				       cmdq->atc_sync_timeouts)) {

This will not be set if a software timeout (1 second) occurs. Do you
know if the ATC timeout of Arm sMMUv3 is less than the software timeout
in the driver?

If not maybe we can handle the software timeout here also as the cmdlist
is already known?

Thanks,
Sami
>+			dev_err_ratelimited(smmu->dev,
>+					    "CMD_SYNC for ATC_INV timeout at prod=0x%08x\n",
>+					    sync_prod);
>+			ret = -ETIMEDOUT;
>+		} else if (ret) {
> 			dev_err_ratelimited(smmu->dev,
> 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
> 					    llq.prod,
>@@ -4458,6 +4471,11 @@ int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
> 	if (!cmdq->valid_map)
> 		return -ENOMEM;
>
>+	cmdq->atc_sync_timeouts =
>+		devm_bitmap_zalloc(smmu->dev, nents, GFP_KERNEL);
>+	if (!cmdq->atc_sync_timeouts)
>+		return -ENOMEM;
>+
> 	return 0;
> }
>
>-- 
>2.43.0
>
>
