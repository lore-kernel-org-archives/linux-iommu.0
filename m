Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489309;
	b=S5RsjAlG6W14eXOHOn/3v4+MmI7Feyin7spfTX/FH/IqkNRRhTNSgVOce9naKSNdsRq2
	 iOKdOzQxEKn8GgZAP7+Vg/HMJJhnQy/SIjoE/n3jPa5Jntdn8TEKRoxlWmOu6ECJxZr4I
	 z2LBFUiPrH+8w2TksiMSUWiPeWzsfkc3SmAzsubES4Djh76wcKBvB8oKVTeI7HFFlGn3O
	 g2Faluri9YeErcADtDc/83/fXMlejzHaMojiGOeoF3iEK3QTuRzoSw78WapiU5Rx2FJ9o
	 X1x/cDda8rWzXyNujUoAj5KVdxVw0IZ9zh98LDSwItpW/c4bj/4j6/dgqSk2f8ed7PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489309;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m4AFHwfD1n7+MjIFKPn07bPGFTJ0v3hSm0zgGLTdWXM=;
	b=OfATsFzrTNDhoEdISbRXQyFiihAYYKszoKMm+VX3ZWGVVv5/IHIaUvB+H9xUahdbX7BW
	 v7KTK4bA6l0ecr6y9cs6UfsLITibTu0FHHKKms4aYi80LBKN8gW2DgYgVx5RLfzmxBez1
	 c6S+CIVW1mf6pMQhWHn1P9b1l1zA8R+bs150Z4O9HzIA1PkLfgrb3n2lYxgb0tW0lgmWt
	 cy9pfk09z0fRlVJbf2x/C4D/TZthdWjyRJRkT2Yzw8dLeV5b3n9hskO1Tv5rc5k4CWbLs
	 AAvFSX5PHYJLTXLHZHlY1DBTi1SNKbBibHKx1jcQ1IafHTziOuk023O0icEIzO+hSzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wZgPdfnj;
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD460A2627
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 09:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2BD460A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wZgPdfnj
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792489305; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=m4AFHwfD1n7+MjIFKPn07bPGFTJ0v3hSm0zgGLTdWXM=;
	b=wZgPdfnjJOeXPUixdOhn3RqSomKtnh0N5fZK3jCJEPxcYeZpKiTRnlqeULYZnJu/Hxnw4OnbtuZIvgjsIY86Pv1ZAQghmcvNxFEkU6uXeQAh26YuBwsOqtubhydZ/uixwt3Fxf9MgTUWvbJ/0ny8buYQ5iVMh9NGT/qm8EEt/Nc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XDCspe8_1792489300;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDCspe8_1792489300 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 17:41:43 +0800
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
Subject: [RFC PATCH v5 08/10] iommu/riscv: Pre-enable GADE for second-stage domains
Date: Tue, 20 Oct 2026 17:41:04 +0800
Message-Id: <20261020094106.92722-9-fangyu.yu@linux.alibaba.com>
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

Pre-enable RISCV_IOMMU_DC_TC_GADE in the device context when
attaching a second-stage domain, if the IOMMU supports AMO_HWAD.

Software pre-populates second-stage page tables with D set, so
enabling GADE by default does not change normal behavior. When
dirty tracking is enabled, iommufd clears the pre-set D bits and
GADE becomes necessary for hardware to update the dirty bit on
write access.

This avoids toggling GADE dynamically and keeps device context
setup consistent with second-stage domain attachment.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index debce1b4201c..9310b818c038 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1236,6 +1236,8 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		tc = READ_ONCE(dc->tc);
+		tc &= ~RISCV_IOMMU_DC_TC_GADE;
+		tc |= new_dc->tc & RISCV_IOMMU_DC_TC_GADE;
 		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
 
 		WRITE_ONCE(dc->fsc, new_dc->fsc);
@@ -1352,6 +1354,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
 			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
 			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
+		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
+			dc.tc |= RISCV_IOMMU_DC_TC_GADE;
 	} else {
 		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
 			return -ENODEV;
-- 
2.50.1

