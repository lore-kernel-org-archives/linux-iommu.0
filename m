Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707405;
	b=5swFQBPpRZ3PvgrL8YUBsxAftQEyyB+wjdL2X7eWQ8JzpNJUMRIgqOFZCWPy0KkIQ41f
	 gdd2tE31WpJkBK4RtYhtHdwYkX6S4B/8kZeeXctKSHbScSeeRt+YsI+GX4mSaU5275G2z
	 2412c217ibVIXoypBtKzuMC27IBwHTsxPYf2rFQPTrfOD8nfHo+aDA33v2J8cMOlulBZ4
	 Bj1f7lJ4CS6X1/TUtNQqDp1yBVf8gB67uZ7gi7fGeFPdXBrbNJm+M9ZGWeYu3mqH/mVUL
	 drSBcYworZKE/nPuUkk/iLAyx9bipWphfVj0Ik8eULb4nu+0hhwfHuONuzdymG2pjdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707405;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NOxToOaRCWHOshJgMcU31n+bkp0++VjZYWL+rK/hMio=;
	b=227Q7hQ4ba/xj9H1VRz5htJN3D///JNWpPwWAVaY8vJNaTosfB9HnfWJFSw6itl0fue2
	 P4s+ZAKuYB6ifea8g9BIt6fxyOyxffUMksk7B0VdKSaI3LZmTGiWx4ItvrOPSFp5tE33+
	 Rl5kgg3DD3lU1EGqFlfU6qMR2xpogO5WkuIbQdKWROUxv7rID8RFjNoA/guWiT1u3s7BW
	 2983snmo8gUYOpWKvpEUWs/dpAFpuWgNBGITzWjffkkaLLzfi77FgDIeKi+flCzbyAevh
	 MK3PU65RK+HHkOjJtIRZD2mmlVGkUa6/HC6ESu184aXox9HWNeuKF8H8floWt/SYZGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PwoQat0r;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C5606EEAE
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 12:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21C5606EEAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PwoQat0r
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793707401; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NOxToOaRCWHOshJgMcU31n+bkp0++VjZYWL+rK/hMio=;
	b=PwoQat0rStQKNniXm2CLGOpw/39cEiOdRNQClpTmPwSoSIewwVcxfqwI5DdAYMzEGDSIHdgwJoSap3iNUYAVzNJDr9Yrm/1Z1XJEL8SHPqOVgn658/FyUEHvwhnfeeuZl7C1DMvC+d148A+0roZS+CX8iiJtzxDVsVL5MgUTa80=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0XE2qH0l_1793707398;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XE2qH0l_1793707398 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 20:03:19 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com,
	tanchi25@mails.ucas.ac.cn,
	gong.shuai@sanechips.com.cn
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v7 10/10] iommu/riscv: Add IOTINVAL.GVMA invalidations
Date: Tue,  3 Nov 2026 20:02:36 +0800
Message-Id: <20261103120236.53474-11-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261103120236.53474-1-fangyu.yu@linux.alibaba.com>
References: <20261103120236.53474-1-fangyu.yu@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Previously, only IOTINVAL.VMA was issued, which is insufficient for
second-stage address translation consistency.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/iommu/riscv/iommu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index ff1043afe973..8c15710d60b6 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -831,6 +831,15 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	riscv_iommu_cmd_inval_vma(&cmd);
 	riscv_iommu_cmd_send(iommu, &cmd);
 
+	/*
+	 * Per the RISC-V IOMMU spec (sec. 5.5), the IOMMU may retain
+	 * cached translations across mode switches. IOTINVAL.VMA only
+	 * covers first-stage leaf PTEs, so use a global IOTINVAL.GVMA
+	 * to flush stale second-stage translations.
+	 */
+	riscv_iommu_cmd_inval_gvma(&cmd);
+	riscv_iommu_cmd_send(iommu, &cmd);
+
 	/* IOFENCE.C */
 	riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
 
@@ -1176,12 +1185,15 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
 		/*
 		 * else: IOTINVAL.VMA with GV=1,AV=PSCV=0,and
 		 * GSCID=DC.iohgatp.GSCID
-		 *
+		 */
+		riscv_iommu_cmd_send(iommu, &cmd);
+		/*
 		 * IOTINVAL.GVMA with GV=1,AV=0,and
 		 * GSCID=DC.iohgatp.GSCID
-		 * TODO: For now, the Second-Stage feature have not yet been merged,
-		 * also issue IOTINVAL.GVMA once second-stage support is merged.
 		 */
+		riscv_iommu_cmd_inval_gvma(&cmd);
+		riscv_iommu_cmd_inval_set_gscid(&cmd,
+			FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
 	}
 	riscv_iommu_cmd_send(iommu, &cmd);
 }
-- 
2.50.1

