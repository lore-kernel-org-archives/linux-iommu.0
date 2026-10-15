Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16B49C4BC
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047182; cv=none; b=fUTpyI/sfLd1xcRgqXS5pq9M7Rkt6Cva/OzDu0g06uCd0PwishEua1whNQPlihLAwgnYD1mRvV6P5qsH5PT2yJsLwhqcawHOrZ3ntPEnEBFUeUoOy+HRjTIB29Z7nDMp4bpZJhCpJVF9HL+VFlgn8wm2Bs4KUIMzWFxh7ysBNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047182; c=relaxed/simple;
	bh=KpBRoo1AGCSg/H6JDJ7ELtcRGaW7NHwEetKk7sLzBXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAZOWUSK0Gzk+KC8i+4NVVGuD0cCpaE2B7DTfoWJZn3fa2y+kzG467IekvbneZw4AdzadgvJIg4f7HbW6cDLdUwD+zuzuT/KZMXecFYaO2TsmGYu6IJl21YG7nJcgzfzOR2ho+vORXIYp7UGS4pPkKW39ZdJEB8ooPtYkZywZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4zKX3rJdz8Xrrd;
	Thu, 15 Oct 2026 14:52:48 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl1.zte.com.cn with SMTP id 69F6qfBb013906;
	Thu, 15 Oct 2026 14:52:41 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:43 +0800
X-Zmail-TransId: 3e816ad0783a024-55537
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Tomasz Jeznach <tomasz.jeznach@linux.dev>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Fangyu Yu <fangyu.yu@linux.alibaba.com>,
        Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>,
        Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 06/12] iommu/riscv: Add vIOMMU cache invalidation
Date: Thu, 15 Oct 2026 14:52:26 +0800
Message-ID: <20261015065232.604503-7-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
References: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 69F6qfBb013906
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 15 Oct 2026 14:52:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD07840.001/4j4zKX3rJdz8Xrrd

Implement cache_invalidate for the vIOMMU, which takes IOTINVAL commands
from user space in the struct iommu_viommu_riscv_invalidate format and
forwards them to the physical IOMMU command queue.

The uAPI payload is little-endian, so convert it to the native command
words the hardware queue expects. Only IOTINVAL.VMA is accepted;
reserved bits are rejected. The guest-owned GV, GSCID and PSCV/PSCID
operands are replaced with the ones the host actually programs, so a
guest cannot invalidate caches that belong to another guest.

Co-developed-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu-bits.h | 13 +++++
 drivers/iommu/riscv/iommu.c      | 93 ++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 2a8230a0c1bb..68190d6cc060 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -486,6 +486,19 @@ struct riscv_iommu_command {
 /* dword1[61:10] is the 4K-aligned page address */
 #define RISCV_IOMMU_CMD1_IOTINVAL_ADDR		GENMASK_ULL(61, 10)
 
+/*
+ * All standard bits of the IOTINVAL command. The remaining bits are
+ * reserved for future standard use, forwarding them to the physical IOMMU
+ * may make it treat the command as illegal.
+ */
+#define RISCV_IOMMU_CMD0_IOTINVAL_STANDARD \
+	(RISCV_IOMMU_CMD0_OPCODE | RISCV_IOMMU_CMD0_FUNC | \
+	 RISCV_IOMMU_CMD0_IOTINVAL_AV | RISCV_IOMMU_CMD0_IOTINVAL_PSCID | \
+	 RISCV_IOMMU_CMD0_IOTINVAL_PSCV | RISCV_IOMMU_CMD0_IOTINVAL_GV | \
+	 RISCV_IOMMU_CMD0_IOTINVAL_NL | RISCV_IOMMU_CMD0_IOTINVAL_GSCID)
+#define RISCV_IOMMU_CMD1_IOTINVAL_STANDARD \
+	(RISCV_IOMMU_CMD1_IOTINVAL_S | RISCV_IOMMU_CMD1_IOTINVAL_ADDR)
+
 /* 3.1.2 IOMMU Command Queue Fences */
 /* Fields on dword0 */
 #define RISCV_IOMMU_CMD_IOFENCE_OPCODE		2
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8046cadefbd8..c34331bcd661 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -2075,8 +2075,101 @@ riscv_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	return &nested_domain->domain;
 }
 
+/*
+ * One invalidation command, viewed as either the little-endian uAPI
+ * payload or the native command words.
+ */
+struct riscv_viommu_invalidation_cmd {
+	union {
+		struct riscv_iommu_command cmd;
+		struct iommu_viommu_riscv_invalidate ucmd;
+	};
+};
+
+static int riscv_viommu_cache_invalidate(struct iommufd_viommu *viommu,
+					 struct iommu_user_data_array *array)
+{
+	struct riscv_viommu *rv_viommu = container_of(viommu, struct riscv_viommu, core);
+	struct riscv_iommu_device *iommu = rv_viommu->iommu;
+	struct riscv_viommu_invalidation_cmd *cmds;
+	unsigned int i = 0;
+	int ret;
+
+	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_RISCV)
+		return -EINVAL;
+
+	/* entry_num==0 is the data_type support probe */
+	if (!array->entry_num)
+		return 0;
+
+	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
+
+	cmds = kcalloc(array->entry_num, sizeof(*cmds), GFP_KERNEL);
+	if (!cmds)
+		return -ENOMEM;
+
+	ret = iommu_copy_struct_from_full_user_array(cmds, sizeof(*cmds), array,
+						     IOMMU_VIOMMU_INVALIDATE_DATA_RISCV);
+	if (ret)
+		goto out_free;
+
+	for (i = 0; i < array->entry_num; i++) {
+		struct riscv_iommu_command *cmd = &cmds[i].cmd;
+		u64 opcode, func;
+
+		/* The uAPI payload is little-endian */
+		cmd->dword0 = le64_to_cpu(cmds[i].ucmd.cmd[0]);
+		cmd->dword1 = le64_to_cpu(cmds[i].ucmd.cmd[1]);
+
+		opcode = FIELD_GET(RISCV_IOMMU_CMD0_OPCODE, cmd->dword0);
+		if (opcode != RISCV_IOMMU_CMD_IOTINVAL_OPCODE) {
+			/* Only page-table cache invalidation is forwarded */
+			ret = -EIO;
+			goto out_free;
+		}
+
+		/* Reject reserved bits instead of forwarding them to the physical IOMMU */
+		if (cmd->dword0 & ~RISCV_IOMMU_CMD0_IOTINVAL_STANDARD ||
+		    cmd->dword1 & ~RISCV_IOMMU_CMD1_IOTINVAL_STANDARD) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		func = FIELD_GET(RISCV_IOMMU_CMD0_FUNC, cmd->dword0);
+		if (func != RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA) {
+			ret = -EIO;
+			goto out_free;
+		}
+
+		/*
+		 * The guest operates in its own GSCID/PSCID namespace.
+		 * The physical IOMMU uses the host-assigned GSCID and
+		 * PSCID=0. Enforce both for correct cache invalidation.
+		 */
+		cmd->dword0 &= ~(RISCV_IOMMU_CMD0_IOTINVAL_GV |
+				 RISCV_IOMMU_CMD0_IOTINVAL_GSCID |
+				 RISCV_IOMMU_CMD0_IOTINVAL_PSCV |
+				 RISCV_IOMMU_CMD0_IOTINVAL_PSCID);
+		cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD0_IOTINVAL_GSCID,
+					  rv_viommu->gscid) |
+			       RISCV_IOMMU_CMD0_IOTINVAL_GV |
+			       FIELD_PREP(RISCV_IOMMU_CMD0_IOTINVAL_PSCID, 0) |
+			       RISCV_IOMMU_CMD0_IOTINVAL_PSCV;
+
+		riscv_iommu_cmd_send(iommu, cmd);
+	}
+
+	riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+
+out_free:
+	array->entry_num = i;
+	kfree(cmds);
+	return ret;
+}
+
 static const struct iommufd_viommu_ops riscv_viommu_ops = {
 	.alloc_domain_nested = riscv_viommu_alloc_domain_nested,
+	.cache_invalidate = riscv_viommu_cache_invalidate,
 };
 
 static size_t riscv_iommu_get_viommu_size(struct device *dev,
-- 
2.53.0

