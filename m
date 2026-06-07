Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FC370AFD
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822323; cv=none; b=p0QLXsbwtaYEsX4CDiOYf8j9OsyXSY2h/IbrqJcmhGmYMNhdj4eQgqYDDPy8/Rv+XJ25lAcMK5FT+GMj64kcydQGuvQj4e1Dgjk4dYqx0PfzXQxIhe2Fv7/NuOLqbidpyPMofsBvN/J8TfSrR5ogWVDiaVzzuhFkb65LYqQkjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822323; c=relaxed/simple;
	bh=yZ2GguxlK4Drxdf98CXs/sIfvx5cN1fpDUIlYKB7jkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glmgzGAJEM91P4eqrm5M4bJcoHj9Ere8sgRBR2S7ZGOgbcxGf5pbbjoDVZaSqVbeHMufSgFzvXrnmzpm6+UincahFN/aN63Ba44hoCtZGizzlAfQG3Xt/Stf2kqdX1RNl1jQgrfOPvZIKrpDJw6risnMSPhRP360uFoliErBDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlvwoMPo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlvwoMPo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso22569655ad.1
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780822319; x=1781427119; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4++l0toGNACfhr7BSQDzAeyeBlGSABMgjc/G9H6+5Yg=;
        b=WlvwoMPoMLR/qPccfZJ4jFEZi85m5GL96ScYW99PvrGtKQNYEmbodnn0SRYJ8VAIqC
         UuP2AaHYU6fB5ztYij5X11/NCDSe3mr+2kQq6wGgTfPx6i/qQunmjp2EX4lWuHd4miPB
         mIHthqztp+LokIMTje7yx4m85iFMc/FSpnYcdw5BlaL73vvISa6ZE/3GLoN/KwYe7iUX
         eHgfx7iCshY66WXrocNj2+K8TCDd1vsG9L3Lpt8I6BLDRkml0vGMs9PgBJRHGHNLUdzB
         UvD2ee3KSBbRgRFFMBaS/wPq4AJdtJ5QgoI2TXPXdKaXXUNDuCESpodVlEEQZP9SbYlV
         Te3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780822319; x=1781427119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4++l0toGNACfhr7BSQDzAeyeBlGSABMgjc/G9H6+5Yg=;
        b=aw94KRVBuAa2LVXM5ZZYdSuVtf4FQjgETIWOKP/0m65xXjItuD03R3GdMeg5hav5TI
         zaKA/GBTSEGUQWcpv7/PjG3eXA7AXxOfm2Jkhf5bEdWq+vNcT1dEaeQN6vfRTpQLvYrX
         VICKgAchaOSLtCwxwf6kwrlKDIp1AEEUsri8s+Vb2AnmnR2owxuPc6XAnizjtNXyG+MW
         t2LO3ZL76v94++ga2g2MVBP20pl6d460t1u3LFwXakj7of6HqN3x5vduIC4YaTTCFYBa
         zd6OcCBSMWl9Ad5y8r6uUjpTlTSt4TF6fto09hIow/tZEIzBpoqayHvs/R5BkLfSOLqr
         nT3A==
X-Forwarded-Encrypted: i=1; AFNElJ+U4tgUrzQ4w8zy9puZAZt5Pb5YG8XIhx6YNVmnS3cPqRvIZBkpFuRvlhp+RVaeOwdYEqYI7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJm4ZoQ7Fxx3zWbh6X//SiiCLIfdhgIQ7xm+q7MgqCwus5M+jy
	BduFvllsyRhFOm9rOSnv1BnZLDyofUyOnBRROlYZHEoT8XxPHTyi5tVd
X-Gm-Gg: Acq92OHXcP2p7MMZdeitMjsFd2jPA388RZOHVhyVFS+B/BQ0O1oAKaH6X1z2rsgu0gn
	+GAfTd8jwn0Zn4Tv1hOTWWP7xWR6qjyhZ7ZNU+h1JXNditVX9HzFtsCYGnQ/mKAORILB42iTu9L
	OwyWMEebZsCfN2Ho2MzyOJGsSmtCA7MJZdi5a1cHQrvbFQkf4jnLXZ3lIMqlDqfhkI0di9HqUGr
	shBLkZQVKCcwl5aJIvVRnquJVKAOS5ghH4z2921He9g4l1g55F1t0ujf+/s8+Idfo6Z0g06jdW+
	nZi1bly55mEomYWwps8Rl+FEBu90bEmIhiLS02f+6UANsKd71K8gv1Qr+6N63IyA6ZMmNoAuqnC
	UvOilaIEyQVnTn/37i0k63905enM81qghmkkNN62iwzHlD371Z7CtkKE3M7cvfGJTlQYhXSOWTu
	WrrhMNi7xelKXqh2g7L1FLTskLX9AHpw7heoYA4TJvQinheOGIgLcJWAQNMtVEzA==
X-Received: by 2002:a17:903:fa7:b0:2c0:dd75:e824 with SMTP id d9443c01a7336-2c1e80f98cfmr118746105ad.4.1780822319417;
        Sun, 07 Jun 2026 01:51:59 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm197220335ad.17.2026.06.07.01.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:51:58 -0700 (PDT)
From: Yiming Qian <yimingqian591@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	keenanat2000@gmail.com,
	yimingqian591@gmail.com,
	stable@vger.kernel.org
Subject: 
Date: Sun,  7 Jun 2026 08:51:21 +0000
Message-ID: <20260607085145.71402-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit









From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Yiming Qian <yimingqian591@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 stable@vger.kernel.org
Date: Sun, 7 Jun 2026 07:40:00 +0000
Subject: [PATCH] iommu/iommufd: Require write access for writable MAP_FILE
 mappings

IOMMU_IOAS_MAP_FILE pins folios from a shmem/tmpfs or hugetlb file and
uses them as the backing storage for an IOAS mapping.  When userspace sets
IOMMU_IOAS_MAP_WRITEABLE, the resulting IOMMU PTEs allow DMA writes to the
file-backed folios.

The file path currently records the IOMMU mapping as writable, but it does
not require the source file descriptor to have write permission.  It also
bypasses the address_space writable-mapping accounting used by memfd
sealing.  As a result, an O_RDONLY fd for a root-owned mode 0444 shmem file
can be mapped as DMA-writeable and a device, or the IOMMUFD selftest access
path, can write into the file page cache.  The same missing accounting also
means writable IOMMU mappings are not excluded by F_SEAL_WRITE or
F_SEAL_FUTURE_WRITE.

Treat writable MAP_FILE mappings like shared writable mappings: require an
FMODE_WRITE fd, call mapping_map_writable() when creating the backing
file-pages object, and hold that accounting until the iopt_pages object is
released.  This rejects already sealed files and prevents new write seals
from being installed while the IOMMU write mapping exists.

Cc: stable@vger.kernel.org
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  1 +
 drivers/iommu/iommufd/pages.c        | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 27e3e311d395b..63e3fd738faf2 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -234,6 +234,7 @@ struct iopt_pages {
 		struct {			/* IOPT_ADDRESS_FILE */
 			struct file *file;
 			unsigned long start;
+			bool mapping_writable;
 		};
 		/* IOPT_ADDRESS_DMABUF */
 		struct iopt_pages_dmabuf dmabuf;
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9bdb2945afe1e..f97d94d9eddd1 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1421,13 +1421,27 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
 
 {
 	struct iopt_pages *pages;
+	int rc;
+
+	if (writable) {
+		if (!(file->f_mode & FMODE_WRITE))
+			return ERR_PTR(-EPERM);
+
+		rc = mapping_map_writable(file->f_mapping);
+		if (rc)
+			return ERR_PTR(rc);
+	}
 
 	pages = iopt_alloc_pages(start_byte, length, writable);
-	if (IS_ERR(pages))
+	if (IS_ERR(pages)) {
+		if (writable)
+			mapping_unmap_writable(file->f_mapping);
 		return pages;
+	}
 	pages->file = get_file(file);
 	pages->start = start - start_byte;
 	pages->type = IOPT_ADDRESS_FILE;
+	pages->mapping_writable = writable;
 	return pages;
 }
 
@@ -1668,6 +1682,8 @@ void iopt_release_pages(struct kref *kref)
 		dma_buf_put(dmabuf);
 		WARN_ON(!list_empty(&pages->dmabuf.tracker));
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
+		if (pages->mapping_writable)
+			mapping_unmap_writable(pages->file->f_mapping);
 		fput(pages->file);
 	}
 	kfree(pages);
