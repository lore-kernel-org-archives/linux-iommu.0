Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB717BCC
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374942; cv=none; b=BWxs8krc17HO+s0ag7I/qKfz3qQFNJWO8XHeIh3cHmqBnxOatD+X7zCpsEDhmfpL5gWHVBMRKb7A4bDzbx94cy/ReHSYiKiWGJpwONcbw/Xn+fSSVuvA+rXMzZqZpUpUCKNzSha82HsOFRTW166/8eXKjUL4b0xmwxW7ogjs4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374942; c=relaxed/simple;
	bh=skj2/BWRX5MDxu4BMRzPV1cfBbCsNidIjZimfPy4/xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Cwg1kFSx3/DhNnEIrk+yaqgeEcwxiK5DzmGxnYk9aUnCuuLAjKT+7d4CR0NJ5ZZvebG5LiZyi1k0EZqg3PS/oWCsiJmab0d/FhiVclLDbRBDfRK0FJ6bV6R7qD9O0cjrzhmxrucMiQd170ohtHCU8Mjd1DRltUP+9WC2sPlXUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lGwjdjTZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lGwjdjTZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6f38b1ab0so17833385ad.1
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374940; x=1718979740; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M7iZUV99NQN3RgJM91vO01sfzoKXhBrbq1qPqNaXoaI=;
        b=lGwjdjTZmUs3NHcknh3UjTD0fw2wMQINTfp/VuSPzD5n/ExU180XDFIvtE+THz9dOR
         vrEEy17Y+2PCivbIzElfb/rG0EWgfsc8027k9G57oyWn39+0cGT0G5mE4NFgVL+hdMbT
         mLCQBNF3QEUfaxwGO4mgktEyZPwYdO/TtbnKb/HnlxMMu9duVatHq1WGRndDEgpJN87o
         shLM3viieOdEbEMo8gFv7pgJz8O+SUhgHT2Fc8wFD8sD0/qunaUNSYoXqzv69MeNJ/k8
         QVhxLDZ9V3/MeJmsEDlekdN/xXzKeYSpTjK2W8cls13n4SnS3s1yHsTYXrczBA9Rce4T
         rgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374940; x=1718979740;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7iZUV99NQN3RgJM91vO01sfzoKXhBrbq1qPqNaXoaI=;
        b=Rb+i+eUekeoc9lca5ZkaQNeNf5RY5zjnZxqlvcAGsY9Si5Jj/k7rl6K7SeuicRoWJj
         GIsyTfEJp80ovKGTRd9RW1Jh+en0mfh10r7yAWgnmBtiViZJyvDSq+KVobPFeKICHWB1
         noKS85HgKfdwH6U4G6LuGdrUGSlIz8U+Nj4beb5a0f++NRi6KlJAagKwMjrHJuVRVBIe
         2ET6hK0pjgO5hjkJRU/Ju8JrwWRd5JyhVZ117TkTktvuARaPbnpkKT2EkfVsDr0D4XqJ
         mMTVOnMEPOfz9nlUkt1yNPvh90m5nVLcxKHEMpcyMDwH0lyxYxy5CQmqg8x07RmS4SQN
         919g==
X-Forwarded-Encrypted: i=1; AJvYcCXXyBGsv7shpb1WUQ13X1FPU7F53gwq2ihJySKHGaEmYkdFJ1TEgxAomsj4soTdpn6MJETgY+6WND13OCJwjTFo77cQ7ig=
X-Gm-Message-State: AOJu0YwZ9VDEEZV3BOJejY3ybnBlyuhLK0L308CLLRoz3TLFatbktO6o
	m/98uH/UAog9mqHq/ek2U2ClCODgXm+dqBND8HUmV2ELcRSVV1BK/AMTTQtNutd0XwhS4PbYRUY
	1NfQ=
X-Google-Smtp-Source: AGHT+IGJERSTIzaOjggWWP0rQrcqidvG0Fn1shO0SdaiGkk+fF3agyv6rp5JLRqhxN5jNm2HLZv71g==
X-Received: by 2002:a17:902:6906:b0:1f7:21fd:ab83 with SMTP id d9443c01a7336-1f8629feaeemr22250365ad.54.1718374940068;
        Fri, 14 Jun 2024 07:22:20 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:19 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation support
Date: Fri, 14 Jun 2024 22:21:50 +0800
Message-Id: <20240614142156.29420-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add iotlb_sync_map operation for flush IOTLB. Software must
flush the IOTLB after each page table.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Makefile |  1 +
 drivers/iommu/riscv/iommu.c  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index d36625a1fd08..f02ce6ebfbd0 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o iommu-pmu.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
+obj-$(CONFIG_SIFIVE_IOMMU) += iommu-sifive.o
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 9aeb4b20c145..df7aeb2571ae 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1115,6 +1115,16 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
 	riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
 }
 
+static int riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_domain,
+				      unsigned long iova, size_t size)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	riscv_iommu_iotlb_inval(domain, iova, iova + size - 1);
+
+	return 0;
+}
+
 static inline size_t get_page_size(size_t size)
 {
 	if (size >= IOMMU_PAGE_SIZE_512G)
@@ -1396,6 +1406,7 @@ static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
 	.unmap_pages = riscv_iommu_unmap_pages,
 	.iova_to_phys = riscv_iommu_iova_to_phys,
 	.iotlb_sync = riscv_iommu_iotlb_sync,
+	.iotlb_sync_map = riscv_iommu_iotlb_sync_map,
 	.flush_iotlb_all = riscv_iommu_iotlb_flush_all,
 };
 
-- 
2.17.1

