Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798270;
	b=2a2Oe9ppT+9Bxasw2XnP1820xau52+gr0mAwMfyLkYITgkvsuVdwgvmzIQ31GWH6e3iX
	 s50Q8dywCvK35NLQaZ1ZcbwqMY19PExZId3RZMEI0iB4jt8lpuJ3A4ZEb3o6Ubr67ewHr
	 LW3yMmO3+yY7jeadeh6zAnbw54aqy9/tKXmy9mQr7gwcbbV/k4wBAFmbwlu0krUgJ5+eX
	 dD1ffQRNE3TTROVmhvIzYHvyQWW9x5vS+UcaAxvPg4OK0wyYXo/d+z1YKYgax5OkiVAs3
	 9oZROWb0MXhS9kkIUzp49asu/uBzcEOWLpB7W+zS1+j2zILp0HQz4XA4pED3ZD+at7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PWqyUavBnfNEo1DMfRHoVS39e8foN13m8UB6fhUtUw8=;
	b=HWgHgKkS6TXUnqsf3gbnidMofQG2lFoF5mHWPi8VLzlXqBvp5Jjhq9obV6/gq3wLvCP3
	 +96+KZm0QfO/OJjFlrTRe43YLeO7Y1gMb0KxdZp9/lnEUTySwGd87CY+wkRT+oxLfEfV0
	 7VE2g1lBh0dNTt9bFRRXRrJXtL7OXmxnZcIgl9SC3Y0KcoLJMrxVLg61lTMwdDc3MvkRy
	 +NBdGKQcD6wBpKZ8ZiDAxRRmoN0Pk8b02CtloWb9iddjRb4WtQZMY0SJ7spP/czwxM0RD
	 G5ZzGOfLO/6sFUBVnWSWU2MA1DHxCtsXbzANVFbW7aX8htSEJSDH9VQsrX2LVbOiY/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gD6jYL9B;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961C606A31B
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 23:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6961C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gD6jYL9B
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9f6a16afcso11535ad.1
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 16:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792798269; x=1793403069; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PWqyUavBnfNEo1DMfRHoVS39e8foN13m8UB6fhUtUw8=;
        b=gD6jYL9BVFlwKLwyqKKPSpXht1HyOdAtUYtSOaGDa2fG8FFxDh3luDLuRqVCPdnp7A
         td+YzABu66F/Tr1mLM75KURd6gKZU/R8XsQqVfF/dnJWxoCXdhNq5gyj8jhrRM2d8Ffs
         NynTgeDqsde/48MW0iHlXStktoCU0on5K3OzDjMNhs+RBETOw+LNFbT5lh9u9d4GCrRV
         Tixx/qE7SvsFUonRZRYBP5qBjMzzFN8YhxcmuiQCwOKhlc0QxrLLgGi/IMA95Z2puJu1
         QtCpKUpSa6EYQlFPyaKuwRxanVD92TiYIx8jZJ3bQ55+OicKiDa6wtZM5FZh/J/NpHWm
         TlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792798269; x=1793403069;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWqyUavBnfNEo1DMfRHoVS39e8foN13m8UB6fhUtUw8=;
        b=X3PLpOsupXMaIgcbrVEaatG9tD55YL7mwWEcorZLnJmgLR1Aqtn+5KT9vkJJ8DrKnd
         CpuYJ/VY2eUql7IlzAk049YXAmAlAkgsVPkXP/q/XuwVTk83S4Q/saiFZkM85hYmp+e7
         lJKR56Ti2Rn6THSkmcc55toUhpapWEla/KdJz5+h0FGu0TTImYsceQMAA658BBSMVGk1
         7HLJqWTk0JoVZUEfEAccRo97MLCG1DIxAUYzkyWQZTDOe7l4BkQNdOUg9J8HU3ocNbto
         9qpPKzGnpsEvaFnmvLsyKyP2ooydNCFBsEykJXHAovSW1KaFDAnniq/pQ6NRGICNM+yU
         ZuZQ==
X-Forwarded-Encrypted: i=1; AKwUvByd2uW/N2J5jZuenqoLDnTcr0hvcOssCMvv85gyvxVk/ZY+XyG4E1/0Qu+tQ/NzxJuBg0z+yg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJS5GVvDRk7SxainRlDF85Pe2/qoUvM4tsqtEa4yumKZOHMfJbO
	Bi6YvY6ZyzDwWGHWOwhAEG4WS9rranDyljdGUh6Cb5G/lDdikTiSYq+nmX3XTD+mmN/OYL4TDmV
	4tO1MCA==
X-Gm-Gg: AYBFou0t6yUF3FhotZEzMrvM+FaR/M5rw1VAtuYnxnRQKX8rk9b0Mr8KPDNUTsod/aR
	tDZMeYOJPrBXRxEQkUR+xxh05ZvpUWdeJ4XXyRvK4Oq7g/YlfUiahCgN6fCzJRrSQ3oDxStdQPv
	y3vboNlqYY6yPCdNdq7PnBVrzqNikZ4mkD6CillKNLLEaNC7XR4imZaY4vpLwWYhxXFBjATxM/R
	MCREy6etdVcCL1jr6iQRckHtNjdTt8mYbo03h8V98sllaiuEKozXH4X6EL0L1/AiN+xY0GyxR7v
	6R96HROFzm8LTKQPi8u8UIDePlVsPPrYoxlhZ1Ju0fKY4f/R4n5+WhiyOoCByxr6sBBipKcExKS
	MniHExRv2DBQHWiSBeGMj9pY31uHU1BK720n/YJ3hsheG0g1t4dN+hvFsvR0YR7RRRpcxlwKjud
	C4WT3y80RykwBXkC0quWIcBnffhqAniELJ2aQVb4qwnViS5Q+Bu6FTU7ydvbAs1AYZLY9Tx9hL9
	YBWlc9yNKCFj3j6HuA/+FP7PQxFHn8PZdopUNlzhXQ/KSufODLnLm/Mq15UgeExAnGGJFlkTJ0a
	VIV/q8DdjFSiLxqaflVbC4FheQ2q0ePTVW26DStVOfLQKXKg
X-Received: by 2002:a17:903:1cc:b0:2e6:1917:fa with SMTP id d9443c01a7336-2ea9d12a727mr853705ad.7.1792798268197;
        Fri, 23 Oct 2026 16:31:08 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb27a1bsm707176a91.15.2026.10.23.16.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:31:05 -0700 (PDT)
Date: Fri, 23 Oct 2026 23:31:03 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 3/3] iommu/arm-smmu-v3: Add support for hitless
 replace of S1 domains
Message-ID: <atvppceAqBVx8G9S@google.com>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <20260925011308.3381953-4-skhawaja@google.com>
 <3d1eb92f-3447-49f0-a210-fd4fa015304b@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3d1eb92f-3447-49f0-a210-fd4fa015304b@arm.com>

On Fri, Oct 23, 2026 at 02:43:28PM +0100, Robin Murphy wrote:
>On 25/09/2026 2:13 am, Samiullah Khawaja wrote:
>>S1 domains are programmed by CD entries in the CD table. During a new
>>domain attach these are updated using write_cd_entry. Since ASID and
>>TTB0 are in different 64-bit words, the write_cd_entry considers it a
>>non-hitless update and sets V=0. This means such an update is disruptive
>>and would generate translation faults if there are ongoing DMAs.
>>
>>Replace the CD entries by using an unused temporary ASID in following
>>sequence to allow hitless replacement of CD entry,
>>
>>- Update the CD entry with temporary ASID.
>>- Update the CD entry with the target TTB0.
>>- Update the CD entry with the target ASID.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 ++++++++++++++++++++-
>>  1 file changed, 64 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>index 5732f3ba0122..59f4b8cf89f6 100644
>>--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>@@ -1641,6 +1641,68 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
>>  	arm_smmu_write_entry(&cd_writer.writer, cdptr->data, target->data);
>>  }
>>+/* Invalidate every stage-1 TLB entry tagged with @asid. */
>>+static void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
>>+{
>>+	enum arm_smmu_cmdq_opcode op = (smmu->features & ARM_SMMU_FEAT_E2H) ?
>>+					       CMDQ_OP_TLBI_EL2_ASID :
>>+					       CMDQ_OP_TLBI_NH_ASID;
>>+
>>+	arm_smmu_cmdq_issue_cmd_with_sync(smmu,
>>+					  arm_smmu_make_cmd_tlbi(op, asid, 0));
>>+}
>
>Feels like this should probably use the existing invalidation machinery...

I see, I can use the arm_smmu_inv_flush_iotlb_tag() to issue
invalidation for the ASID.
>
>>+
>>+static void arm_smmu_cd_set_asid(struct arm_smmu_cd *cd, u16 asid)
>>+{
>>+	cd->data[0] &= ~cpu_to_le64(CTXDESC_CD_0_ASID);
>>+	cd->data[0] |= cpu_to_le64(FIELD_PREP(CTXDESC_CD_0_ASID, asid));
>>+}
>>+
>>+static void arm_smmu_replace_cd_entry(struct arm_smmu_master *master, int ssid,
>>+				      struct arm_smmu_cd *cdptr,
>>+				      const struct arm_smmu_cd *target)
>>+{
>>+	struct arm_smmu_device *smmu = master->smmu;
>>+	struct arm_smmu_cd stage;
>>+	u32 tmp_asid;
>>+
>>+	lockdep_assert_held(&arm_smmu_asid_lock);
>>+
>>+	/*
>>+	 * Nothing is translating through an invalid CD, and an update that
>>+	 * invalidates one cannot be made hitless anyway.
>>+	 */
>>+	if (!(cdptr->data[0] & cpu_to_le64(CTXDESC_CD_0_V)) ||
>>+	    !(target->data[0] & cpu_to_le64(CTXDESC_CD_0_V)))
>>+		goto write_directly;
>>+
>>+	if (xa_alloc(&arm_smmu_asid_xa, &tmp_asid, XA_ZERO_ENTRY,
>>+		     XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL))
>>+		goto write_directly;
>>+
>>+	/* Copy the existing cd entry and update only the ASID. */
>>+	stage = *cdptr;
>>+	arm_smmu_cd_set_asid(&stage, tmp_asid);
>>+	arm_smmu_write_cd_entry(master, ssid, cdptr, &stage);
>>+
>>+	/* Copy the target cd entry and update ASID to the temporary ASID. */
>>+	stage = *target;
>>+	arm_smmu_cd_set_asid(&stage, tmp_asid);
>>+	arm_smmu_write_cd_entry(master, ssid, cdptr, &stage);
>>+
>>+	arm_smmu_tlb_inv_asid(smmu, tmp_asid);
>>+
>>+	/* Update to the target cd entry as it should be hitless now. */
>>+	arm_smmu_write_cd_entry(master, ssid, cdptr, target);
>>+
>>+	arm_smmu_tlb_inv_asid(smmu, tmp_asid);
>>+	xa_erase(&arm_smmu_asid_xa, tmp_asid);
>>+	return;
>>+
>>+write_directly:
>>+	arm_smmu_write_cd_entry(master, ssid, cdptr, target);
>>+}
>>+
>>  void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
>>  			 struct arm_smmu_master *master,
>>  			 struct arm_smmu_domain *smmu_domain)
>>@@ -3664,8 +3726,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
>>  		struct arm_smmu_cd target_cd;
>>  		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
>>-		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
>>-					&target_cd);
>>+		arm_smmu_replace_cd_entry(master, IOMMU_NO_PASID, cdptr,
>>+					  &target_cd);
>
>No, we cannot blindly do this for arbitrary ->attach_dev calls - the 
>majority of S1->S1 transitions are going to be moving back and forth 
>between the default domain and user domains, where there is zero 
>expectation, let alone guarantee, that the translations would be 
>equivalent and thus not liable to lead to TLB conflict aborts or 
>amalgamation hell.
>
>This needs to be in a dedicated "I know what I'm doing and I fully 
>accept the consequences if I get it wrong" call path.

Agreed.

I will update this to only be triggered with explicit request from the
Core to satisfy my live update use case where a preserved iommu domain
is being replaced by a new domain setup by the user.

Thanks,
Sami
>
>Thanks,
>Robin.
>
>>  		arm_smmu_make_cdtable_ste(&target, master, state.ats_enabled,
>>  					  STRTAB_STE_1_S1DSS_SSID0);
>>  		arm_smmu_install_ste_for_dev(master, &target);
>
