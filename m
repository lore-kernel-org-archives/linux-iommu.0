Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4140858;
	Tue,  8 Oct 2024 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357531; cv=none; b=SLxMSUTDEFHYgm8YKlC0vb4yuyskQLvhjWkDRGUY/WQex55J/+JjgEUzihzLFt39pILb9KxLAYCkt4rjl64rZun01kMq3qg21YRC0J4FvVNQ4TxbZ5VSUJaIn14MOl9ciFwfRMcGAMLx5vaWnC2eARG30bU50oL0juZnpC21SOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357531; c=relaxed/simple;
	bh=Ua933CzRTJumVMvUdj0HaC4dU69RBkIzAn0YeOYi6sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AnCfHb9AhYCaf2tB23bazx5ljsKZoamQ73CFqqSikMKrLqQp3zV4a0vKoYu3SlYii1ouidoAwVjdv5zZOU4cesmtUQ9OTD7BG+Ox19WasfQ7On3Zrho4doEUe5/4jMIzAaZetk5QoYbmrB38IGLTP2/R8gNCHLWh2QK3oXR8Jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ3akMKu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ3akMKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DB2C4CED0;
	Tue,  8 Oct 2024 03:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728357530;
	bh=Ua933CzRTJumVMvUdj0HaC4dU69RBkIzAn0YeOYi6sQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FZ3akMKui/CJtn3sffpchhRNiHNfThic/+bw7MCNtF2Vbg44VQatISMGVRIB3NAUS
	 jA6YKz/x+1CTEC9MNcAZ1CWMlIvlQkp6L542zPWLJ9MHXSzMlD37nZ7LVxxjBYf4Uc
	 2FzoXU5us6kQ/1ERiJrzpWtfE0zWVpHC07UzXfm1RpAMWv9IOCJCpJRiQjlwEXY5td
	 rFg9t1Q1CDqEPirmQPHNlsM5H2tM37wM9fofAsOW8RP/E/+Ax1hETR8M2NvYuK9AEg
	 1qY9ZHCh3lxw+4l4Q7f/OD7erR7+qnaXncXxn45yPaQK3tAzkbJeRitV9cEKDM0uEk
	 vT6aWlq2PzJJA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: jean-philippe@linaro.org,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Fix overflow with sid_bits when computing level1 table index
Date: Tue,  8 Oct 2024 08:48:31 +0530
Message-Id: <20241008031831.1254130-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the spec, max bits of StreamID can be a value between 0 - 32
inclusive. With the FVP model, SMMU_IDR1.SID_SIZE returns value 32 which
results in arm_smmu_init_strtab_2lvl computing the last_sid_idx wrongly.
This caused a failure in ahci disk initialization with the FVP model as
shown below.

[    7.147067] ata1.00: qc timeout after 5000 msecs (cmd 0xec)
[    7.147177] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[    7.458320] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   17.643140] ata1.00: qc timeout after 10000 msecs (cmd 0xec)
[   17.643251] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   17.643359] ata1: limiting SATA link speed to 3.0 Gbps
[   17.954651] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 320)
[   48.107079] ata1.00: qc timeout after 30000 msecs (cmd 0xec)
[   48.107190] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)

Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>
Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..01a2faee04bc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	u32 l1size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	unsigned int last_sid_idx =
-		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
+		arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
 
 	/* Calculate the L1 size, capped to the SIDSIZE. */
 	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
-- 
2.34.1

