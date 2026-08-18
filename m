Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE71478865
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060102; cv=none; b=cLAFeoX/v7oAZNYbPae3LoVvNfor6SE9YEP9MATA24DgP78HNyc7qXXmu9s0w0InYKP++5Z8cuM12oWn6DgZpdQECu9VchjZ6HyxW69mx1wC9Xf7XrbqjyLo5LUJGwq++Dzdv+qBTglJ7TjCw7wvRdfYVZrd1V3HObLniFILvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060102; c=relaxed/simple;
	bh=ygflGRP/Pxy4texFJBQa8yWUSlPHDuiz8a1gu31y++k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZbyPDcm7WHXWFHYGQOSFQzPlHZvzvD8X14AWqi5mjY5VenJDwKJWtGgucOn7DSzGXotD1aIpFOkU+pMNn9hayCL1YL5lk8RFOUDN2EzyoIAlHSsgrPTjdRYkImBfVOJeHOuQWdyjQvG3MWYOOOjFueMSoxjsw31RRqMUTxrEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lsZStvsa; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lsZStvsa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787060091; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AMqQhPIVZVTnz+mlp2yD/CiRqzqmyuR3oAehC/dra64=;
	b=lsZStvsaoLHQN8Aa1nu82caTa3AzGcaunhJ6Tvn1qdV93pF2qOoi4AH5oskl2rdZrOIDpE2wHQtHDdibAr+vcYjvjKXC2SX++bivIVPRMpOee8YgL+c1xKsCQ6H8Fq+5lTzmJ3WGTGEygV6wGhJPLRfKTfPqvET1xuQ3ajcXbbo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0X9DUoVH_1787060087;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9DUoVH_1787060087 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Aug 2026 21:34:49 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tjeznach@rivosinc.com,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH v2 05/10] iommu/riscv: support GSCID and GVMA invalidation command
Date: Tue, 18 Aug 2026 21:34:47 +0800
Message-Id: <20260818133447.44426-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <4mcwrlk7yc4kozsqbrumf5gbknydquzwdb4g7lv6bgjk7m6ob2@alld2yusipnq>
References: <4mcwrlk7yc4kozsqbrumf5gbknydquzwdb4g7lv6bgjk7m6ob2@alld2yusipnq>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> @@ -1212,8 +1225,15 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>>  	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
>>  		return -ENODEV;
>
>This needs something like the below diff squashed in.
>
>Thanks,
>drew
>

Thanks, agreed.
I'll split the helper into fsc/iohgatp variants and squash this into
patch 5 for next version.

>>
>> -	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
>> -	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
>> +	if (domain->gscid) {
>> +		dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
>> +			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
>> +			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
>> +	} else {
>> +		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
>> +		      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
>> +	}
>> +
>>  	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>>  	     RISCV_IOMMU_PC_TA_V;
>>
>
>diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>index 307baf33c646..434d2d4f26f5 100644
>--- a/drivers/iommu/riscv/iommu.c
>+++ b/drivers/iommu/riscv/iommu.c
>@@ -1262,9 +1262,9 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
> 	kfree(domain);
> }
>
>-static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_mode)
>+static bool riscv_iommu_fsc_supported(struct riscv_iommu_device *iommu, int mode)
> {
>-	switch (pgd_mode) {
>+	switch (mode) {
> 	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
> 		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39;
>
>@@ -1277,6 +1277,21 @@ static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_m
> 	return false;
> }
>
>+static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu, int mode)
>+{
>+	switch (mode) {
>+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
>+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4;
>+
>+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
>+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4;
>+
>+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
>+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4;
>+	}
>+	return false;
>+}
>+
> static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
> 					    struct device *dev,
> 					    struct iommu_domain *old)
>@@ -1294,14 +1309,17 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>
> 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
>
>-	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
>-		return -ENODEV;
>-
> 	if (domain->gscid) {
>+		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
>+			return -ENODEV;
>+
> 		dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
> 			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
> 			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
> 	} else {
>+		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
>+			return -ENODEV;
>+
> 		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> 			 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> 	}
