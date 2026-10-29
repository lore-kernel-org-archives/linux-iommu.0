Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254315;
	b=mKXEhvGwLjSxsMNGdMiJgcx8fS7TsU34Q6hVgb7i6prqhxlZF16Qt4n1t11Rs7eTZhE1
	 YcaTnFuhWHT4pwz3DL2eTm1Rho8C738feumE5PYi6ZaxGOaDeF4SIuTiFtQ0J0x2xfGPi
	 VzB7JJwKKHGynhAZSN2jJcGXpwX6MbEKI/5NXKKLl3R/zvB0r36UNkjxGqmHt2imbs3IX
	 hC7EGgZ94C69dwYRpe5NdjapeOYcyYgBuqejhSEwC4xprlYNMfJkpM6CiYkSonjGsobNr
	 8Ou0oTClLkAkULZPmBIz6GhBwnCSKQ4z6U8GQvCux+5mX5OWaG/jrxt3Nop0syuYj3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254315;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=9Z5BZia7ii0BYSoM8tYxpXNMJRw7pVpb6yMuc7WTOSo=;
	b=H6LXrp30UxN/JXtqeeq32u+n7Cnf/PCX1QZJTfx8WQaTUsawSH2v4Kjsd2cKhbaTNnq5
	 7IPhijII4zwxSgdZGuaLc+BqOeVGlU9nMGD2p8kYsp4Z3UTOo9y4H/jjKHreEkkzHVqOn
	 NxNzHoQoEr1fO06K0yqbXwR/3zyVn5OH/E3Qcw27KU/9TftBSS0uRjtJV/rTFMD8kObN3
	 dQQBSjvEnZ16YUmzzCPoQ3nIb7xm55hDjRqaFLS8IvVH3FPW6vOKkstJVeVDDbhITgrqg
	 bYoycTCeS3083RsG/vv35o3GyWu+5Q/IpCTxyCdRrn38EF3DXx75kHcfHoPS/JPEgTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C2606A334
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B45C2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jFYld3LqWz55RJ2;
	Thu, 29 Oct 2026 14:11:41 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 69T6BaVg044491;
	Thu, 29 Oct 2026 14:11:36 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:38 +0800
X-Zmail-TransId: 3e816ae2e399027-e7d37
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
Subject: [RFC PATCH v2 6/9] iommu/riscv: Add vIOMMU cache invalidation
Date: Thu, 29 Oct 2026 14:11:28 +0800
Message-ID: <20261029061131.584453-7-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
References: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 69T6BaVg044491
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 29 Oct 2026 14:11:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E39D.000/4jFYld3LqWz55RJ2

Guest page table updates require IOTINVAL.VMA commands to invalidate
cached stage 1 translations in the physical IOMMU. Allow user space
to pass these commands through the vIOMMU.

Do not forward guest commands unchanged. Validate them and replace
the guest isolation operands with host-assigned values so a guest
cannot invalidate cached translations belonging to another guest.

Co-developed-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu-bits.h | 13 +++++
 drivers/iommu/riscv/iommu.c      | 93 ++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 80c32f00ee5e..2f32330fcd16 100644
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
index 371d60902eaa..6bcf214016c3 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1812,8 +1812,101 @@ riscv_viommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
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

