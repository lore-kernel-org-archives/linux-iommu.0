Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489313;
	b=hDK1IjJUh5q128zAyjLfTiRlRemTRvaFpS9Da0pVbKHW9xTW0eqEStGA+PHeGypFuU6d
	 +J7Eu26RqdQoRhklVmhY8GfwrBk9A1YjOExkr+4RBiqa13FURkjHB1thGquUDg7ixIDYI
	 sT+zhBQTXE1L5PofsRoHXi4efiX6Scv0m7BzbxYRYDOAxUYL+9UMOm46csAC+/o5miLQJ
	 55ePG0lanB/lP7IiF/iLIw7kthOoy7ZzIvITAaMxfddZAc6q1Y/KjTWkIpVysG0UMnpsf
	 YVCeTRXxol/jpXWZvI8mKlURyRx+Ckgnxe3C610mLL3tyqRLwtawRVokSCw6gglhKhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489313;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sApxe0kej5AMvFjUhFTHU6ozNHX+GiLdwcc2SeFwNCU=;
	b=MDN0T2w4Hp3+ju/7dDpRp25zGsHeQD4h7jIZWO8bKs2LrgAnYtPKrqG7/TRiiEFyAaWg
	 5CHggiw8VnsL0zrA/nEsQJOUdKCVEQ94z048ky1y4yudgQ5POWzaIqfOFkfBqAPsta7+U
	 wdMd0d+kQ/l7aP9ql0m6meMiYQuxCu4o4785oh4hgipY2tfSoDoc3m5Tqdhixh2n8/jzw
	 AJwt+gcRTLdDw6Migl0vULgncsyACGylSEwEXYV5GBKuRIehZa7rIbvkFqu1hmsEwhELB
	 uC7nSOC//dVx/N+ihmJObkjrzSKsVgrHWcrxIowVF5PcrVvbAdjus1kWyU8ESTyXCXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jgy5jZ46;
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2E60A6F4F
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 09:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C2E60A6F4F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jgy5jZ46
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792489311; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sApxe0kej5AMvFjUhFTHU6ozNHX+GiLdwcc2SeFwNCU=;
	b=jgy5jZ46Mj+Ld2M3HUF8u4tSrXqFVmFJSb93UV2pvgVglWWj8OGxEyX+kEkBEr8nB1WfPs54uSmYDva4wf3chaqIDr+phpAADnFsHkT1/LZUIb2kbVHncTqwvsxdXnnPbRYdZV0jdG20GnNw0ccJBJDpa9ShOocBvOdNVC3CbiM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XDCspg5_1792489306;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDCspg5_1792489306 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 17:41:49 +0800
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
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH v5 10/10] iommu/riscv: Add IOTINVAL.GVMA invalidations
Date: Tue, 20 Oct 2026 17:41:06 +0800
Message-Id: <20261020094106.92722-11-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
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
---
 drivers/iommu/riscv/iommu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e3791e912af3..a764a172c588 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -830,6 +830,15 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
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
 
@@ -1175,12 +1184,15 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
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

