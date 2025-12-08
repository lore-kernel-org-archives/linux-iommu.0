Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316782DF70F
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765229342; cv=none; b=S3mmzJSWdcg+v6CanWMfwg0uqMYBU8OGXa7yksJ07YZK51gF1zLWDqCxZeEd+LHXreVvB4Jiry64kjQStqFCOdTymtTFv+HV8O/q9zs+m/+DSw9ewDARcUIWNV/VdJPu5AEa3p4TETBbB0w6NmoNzRaZF9+Mo9tfvOf3xi4KEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765229342; c=relaxed/simple;
	bh=ZWO1QudnFRSa/UfJWADrKqPlpf4gjcW/LBipSYFpdRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBnRjrIQlI2SXyOnK3jjawi6lYrInDLQ1ZD0FgLu5sAqjyiBDOBFRTsPKYZEWGFG589Xvv6secQwpbEOCHBVvklMxBBZ1f+Iifo/zB5xO08yTYVWnh8DFwmuK+LN/9rwD87QLzDKHOWmqlc5sME+h1Ia8mXb++lgVgXXvTA8ohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B/n8wCWT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B/n8wCWT"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F3772116048;
	Mon,  8 Dec 2025 13:28:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F3772116048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765229339;
	bh=tsK3GpldGAW1/rhp32GUlYbF7U4FuS5oiQ9b0RSvaIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/n8wCWThXglPw4hACGK2/bbAbgaXQngxfoYLcj9s6kh/wkRdHLCE+NtZSa8zdOWV
	 Ut5j81lhHTPlorWHzs4BW5SSO/lq0xah7vpP7vYd9nE39UJgTaK1q8BpXn53DLt7+a
	 SAUsM4P/Nf7BUUyj3EAzJh2TnCzAf1iyCzml5aVc=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: [PATCH v5 1/3] iommu/arm-smmu-v3: Parameterize wfe for CMDQ polling
Date: Mon,  8 Dec 2025 13:28:55 -0800
Message-Id: <20251208212857.13101-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
References: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SMMU_IDR0.SEV == 1, the SMMU triggers a WFE wake-up event when a
Command queue becomes non-full and an agent external to the SMMU could
have observed that the queue was previously full. However, WFE is not
always required or available during space polling. Introduce an optional
parameter to control WFE usage.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bf67d9abc901..d637a5dcf48a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -191,11 +191,11 @@ static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 }
 
 static void queue_poll_init(struct arm_smmu_device *smmu,
-			    struct arm_smmu_queue_poll *qp)
+			    struct arm_smmu_queue_poll *qp, bool want_wfe)
 {
 	qp->delay = 1;
 	qp->spin_cnt = 0;
-	qp->wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
+	qp->wfe = want_wfe && (!!(smmu->features & ARM_SMMU_FEAT_SEV));
 	qp->timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
 }
 
@@ -656,13 +656,11 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
 	struct arm_smmu_queue_poll qp;
 	u32 *cmd = (u32 *)(Q_ENT(&cmdq->q, llq->prod));
 
-	queue_poll_init(smmu, &qp);
-
 	/*
 	 * The MSI won't generate an event, since it's being written back
 	 * into the command queue.
 	 */
-	qp.wfe = false;
+	queue_poll_init(smmu, &qp, false);
 	smp_cond_load_relaxed(cmd, !VAL || (ret = queue_poll(&qp)));
 	llq->cons = ret ? llq->prod : queue_inc_prod_n(llq, 1);
 	return ret;
@@ -680,7 +678,7 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 	u32 prod = llq->prod;
 	int ret = 0;
 
-	queue_poll_init(smmu, &qp);
+	queue_poll_init(smmu, &qp, true);
 	llq->val = READ_ONCE(cmdq->q.llq.val);
 	do {
 		if (queue_consumed(llq, prod))
-- 
2.43.0

