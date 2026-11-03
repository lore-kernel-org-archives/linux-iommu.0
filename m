Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707401;
	b=gITguXFbJF/imeGceoti+sTy8kkq4KeEtxb/CLFWfyFJvzf40NLsvzT26IxAmZW/Iv2I
	 klb5d9/34HiDokM/PNpebI3oF1AJboEylT9xKTj/w0AiWg0LK4oujQHB5+Oi04gCYPQ5N
	 gXt5NPubzozWSrF5h6B8sRo5ArJfOsZ1q+KizBK8i6joKZb2rpf9HmAIMaPJHYDlJa3f7
	 WJpjvFnqmMloOuU6rKygQaZOnBw8AshDcbmAKUp1Qh8sFjoikq4pH5Lk7naNwk5TmN1vm
	 p1JK/h/CvvXI9NgRdKQZjTFciK7h7yPkxsky2Us0B7rbDQuJNTmRwdIojWLzMTMtUsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707401;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6p5yvFa6XuR3x0uOGBMYmOORDZRKEzDHmfCxWVkYjRA=;
	b=WYMe91hEPvPuw85Lzo8GoFvd9LUpnWRnIF01NMj8EhsTPVZCq+IQimaPXrIFjtX/BuQs
	 vT656XJj6J/kaWt4xj4kkq+On0YF8JDYD/7AKFjDRjR9W+PzTgYo6YIB7gqAXKFowy/03
	 XeT6YIglEbZAjY/nGOVY283WBZ4vg16237v2tir705IvWzSVHvUU929lWzO/aDkUD4gA8
	 eqfb5Bde9oj/jytOepS8LF1ZCXDKojUuut7J0/TwHeFaH6WhYR6jmOtibY/WxmrbJcg9u
	 Xq0VOCuUPNr16wrFC9htE+osuWMl4JQ1uyt+vGT2wHap74d6eipzLzYR6fjGcrshdoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cCjGWU9S;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728E606D83A
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 12:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A728E606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cCjGWU9S
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793707397; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6p5yvFa6XuR3x0uOGBMYmOORDZRKEzDHmfCxWVkYjRA=;
	b=cCjGWU9SCP5WJ3ZfZQOGv9jgcCagPCUYFtPXOZCfirAk0uDNE8LwBffQs15Gha3IMFDSLzCQb9y/86VlcABzd4OlSFICUkyWCVyh0HQGXFIDlrTHjrFZ40pTPCFyE/n2+rlnXsonV1FQJJ9r0CHy8SqLy0khi2R58zn/SFDDzkc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0XE2qH.c_1793707394;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XE2qH.c_1793707394 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 20:03:15 +0800
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
Subject: [PATCH v7 08/10] iommu/riscv: Pre-enable GADE for second-stage domains
Date: Tue,  3 Nov 2026 20:02:34 +0800
Message-Id: <20261103120236.53474-9-fangyu.yu@linux.alibaba.com>
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
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/iommu/riscv/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 61dfde11ba13..b3f05dfdf278 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1237,6 +1237,8 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		tc = READ_ONCE(dc->tc);
+		tc &= ~RISCV_IOMMU_DC_TC_GADE;
+		tc |= new_dc->tc & RISCV_IOMMU_DC_TC_GADE;
 		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
 
 		WRITE_ONCE(dc->fsc, new_dc->fsc);
@@ -1353,6 +1355,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
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

