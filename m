Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425063;
	b=YFlS4vTr3+8VpR7c1ZhAnd+1vMf+HXSvsqMr0HPaWOHsJxkmtT1/HVA3ALlPDZqA1/Ph
	 Ff5fMbVSrW/oJBm98Z3uKx/ohVCFdLrkZU8HvgEamb2ntk70Ti6oX6a+J35l2ZvoTqr5P
	 wqfg7Ex5ZASsngv6qjkOcYFkqUXk6Tv9mTjjCZ1OMR5AwppUQ6sCYgOfb8Lx4e1f7PjFt
	 3bGBtH1nssWIZqkiZjAaQds5e7oCkp3YGy1FxAbp0Sv+JgKP7AnSNNSt9zYQQ7U7o5moW
	 wJY1QBjq3P5RrWOwZV7bHMeEkpWtdUxwMcFcu/ssxnIUu2ZSct8TC+YV7usoMNCxW3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
	b=H4Ht4hrC0XiuK3VOnO1MSolwV7JrFbJq4fAQlXO+k6VM4NRSbvGl2ZtNEzVDk8cnJZyq
	 CzVTkj67GTHLqtCetWFr4U7FQij4MswX9CwhLM1XZ+uXkPw2Ud1ADBKjOmMaKQQqJdnZ4
	 NXfs9NKSyahuNmMWloHRi0Di19w5uoYyqbViq1LfyO67vfBROSKJD2x+fG83whLWlFkk2
	 p1t9nOVoD9ERr8VXM51CIBeicqM4fEjKMz2dem3aEnRuUd8NwF60DC4fdogRNVtz9MW/T
	 qVKErYMyEP01HMy64mf5U4SN448ahbat6gQ8ze8BdB07ha371EHaRa3wdtOyNxvoWYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c5kGszhB;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF2606B5DD
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 19:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FF2606B5DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c5kGszhB
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-540537f959fso3941350b6e.0
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425062; x=1795029862; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
        b=c5kGszhBCO+ksD/yiMBBus/t35R7yztpMq31d7jxK0Ht7OsgVkDbuBteywyiObTjwO
         qspj2qM4HJSkv6nLBsSj2UdHL36n8ootxZnkTPgzaCI6yAX8+NQrtAuAO9JBWxG3dJVV
         CFh/9FtXPaAyxbCo5LdBQ/chpgVcz0Lt1OzFq0mfDSD1J9KjscpoB5hYT+2xTDMyXqt0
         qvp73nYJLHcE1VPt84LfRd5XHh8BMuGfM+Qhcx+ptAj0y7hJiPvVmHSq63EAZwTOTU1W
         O8lbzgvZQH7uIAkC79FZ6gYslFXjwsWJ4F7n0+MzrnvNKxhHkB51L/DbRCRAEZoSJRAQ
         RWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425062; x=1795029862;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZrkVSPnOLbwhYzrPljddPiSGOm8sAR0nI/sR9X9KfM=;
        b=atbHXcHV/WHRlOROPHsUBEoR1ajoA8DOJjAeBLW8quHU2Q86gZe9Nn/2D91mJcskiI
         N/BlY4KsdLEp9Nfd6ddeI8wrmQvnfnj/iwVkgh7mimPAZLl3UpeoPVt7p6ZZJQyneap+
         ZZC6i2jJW+cQQef84W6WZV5fZOx1jHcFPtcIkEEzC3A/w7CZjTmcPhZMxWV+sCc0Hs1V
         FoUVnG9JWRZDFU/DDQ1C8v++Fs34glF/jjsxt7r8wjZsAfXIdQBDtg3wS7mzdx0pdc2w
         1eDLFghW7Hn8Be8GroHy+lZH2osgJjyAyvZmAQa0xgwae0WT2jm4L5N4ZexY4sfG7J7A
         X2PA==
X-Forwarded-Encrypted: i=1; AL+hErGt7Ewpr6tpWlxUAIZ3NL0/b48MGhkHZddklO34kmO/hPb4FUGrZMnt48DkTZbTYpaEvdeAFQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9nrimlOP2awolYvxm6ae16w7ZEAqacILTRNL43nVOsCb1UcmSU
	DoQy/fRbNfwSxy8ZGTY0IMExNun/huYqkSFruQIdOUn7NKzhU7E9Z6LcfGKldvwd1/s7L6GITcl
	YD6NaPA98qE0PJQ==
X-Received: from ilbec1.prod.google.com ([2002:a05:6e02:4701:b0:527:120b:a51d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:191f:b0:53f:3c0e:c74b with SMTP id 5614622812f47-56b93447ed4mr3152606b6e.9.1794425061950;
 Wed, 11 Nov 2026 11:24:21 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:09 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-6-dmatlack@google.com>
Subject: [RFC PATCH 5/7] vfio: selftests: Add iommu_map_file() helper
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add iommu_map_file() and __iommu_map_file() to map a file descriptor
(such as a memfd or VFIO PCI dma-buf) into an iommufd IOAS via
IOMMU_IOAS_MAP_FILE. Also skip regions without a host virtual address in
__iommu_hva2iova(), since file-backed DMA mappings do not require one.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  9 ++++++
 tools/testing/selftests/vfio/lib/iommu.c      | 29 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..2b39c49e66da 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -42,6 +42,15 @@ static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
 	VFIO_ASSERT_EQ(__iommu_map(iommu, region), 0);
 }
 
+int __iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+		     struct dma_region *region);
+
+static inline void iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+				  struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommu_map_file(iommu, fd, file_offset, region), 0);
+}
+
 int __iommu_unmap(struct iommu *iommu, struct dma_region *region, u64 *unmapped);
 
 static inline void iommu_unmap(struct iommu *iommu, struct dma_region *region)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..ba602685f892 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -71,6 +71,9 @@ int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova)
 	struct dma_region *region;
 
 	list_for_each_entry(region, &iommu->dma_regions, link) {
+		if (!region->vaddr)
+			continue;
+
 		if (vaddr < region->vaddr)
 			continue;
 
@@ -149,6 +152,32 @@ int __iommu_map(struct iommu *iommu, struct dma_region *region)
 	return 0;
 }
 
+int __iommu_map_file(struct iommu *iommu, int fd, u64 file_offset,
+		     struct dma_region *region)
+{
+	struct iommu_ioas_map_file args = {
+		.size = sizeof(args),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE |
+			 IOMMU_IOAS_MAP_FIXED_IOVA,
+		.ioas_id = iommu->ioas_id,
+		.fd = fd,
+		.start = file_offset,
+		.length = region->size,
+		.iova = region->iova,
+	};
+
+	if (!iommu->iommufd)
+		return -EOPNOTSUPP;
+
+	if (ioctl(iommu->iommufd, IOMMU_IOAS_MAP_FILE, &args))
+		return -errno;
+
+	list_add(&region->link, &iommu->dma_regions);
+
+	return 0;
+}
+
 static int __vfio_iommu_unmap(int fd, u64 iova, u64 size, u32 flags, u64 *unmapped)
 {
 	struct vfio_iommu_type1_dma_unmap args = {
-- 
2.56.0.567.gdb80ae8cd5-goog

