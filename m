Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6D375F6C
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822417; cv=none; b=uoYnTlwzGvdXB65yWmhVAUhAUXD2DCiRR8KqUN9yXnEsPlJ24zhxMM1ypTngmQsObm6152QKx6LiXDy/l0L13Q1hkhjmWKeosFOekb0pmn+0XTewfXllhdMuboO7wsxbj3t2kcvBAvjL1UxVfu1HvyswE0vVf0tlCQzen6ysblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822417; c=relaxed/simple;
	bh=G4NwAmdQYNsaz3MOxXsSex5bQIwUllTzHht3/K7h/rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpCN7P7AQ3ioPYgg6KMM7ko2jEdOVqOTr6NeygtczU78E0cuLU+bOMJVi5SHJlBeZDj3eeTSi2/ipB2bRsYKTKQqgj2LDC9SWoe4d0Glt1bJ7yUzJ+tJiGrzy1tFUUTyLFwPAaOBEgGGIuDD9wrCUU+gYLg+8Q/b7XYUZtOM6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syJ6Isth; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syJ6Isth"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0a5354da1so26726845ad.0
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780822414; x=1781427214; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/fHXPpv25IIf+IqumkILHnKbLJe6zPc+sZq7buAPJg=;
        b=syJ6IsthnYqB9qIqz8JKNRXjg287Jamt6ima4BirsP5jeAWnU3dRKEz7ToMO7JMelq
         TYkSYZ/pKpX+RhNZc3J1W6MxFgGXirbrUOTHE9JKh6C4m9BQ/d4GTVNqTW76RpnxzoWi
         NNeHxZ18ZPp0g9nFJovvZ2eJpwQxr9q/Isp08HlGrxH2NX8nCdc5nLAcqU7IIgpoXYDg
         4pKYYPcyGrcCj4a7MZ17OkLI80aoJTlpUU6AqSIbp5MC/5vmPsFV7qbFGdpf2S6jqAGz
         IN4BvIz7eu2NUbP7mMVoqZXn0Ldkg3zs8iePJMBJFQKHF7I001P3gXOGbIBtT3g376wq
         kqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780822414; x=1781427214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/fHXPpv25IIf+IqumkILHnKbLJe6zPc+sZq7buAPJg=;
        b=qLS74WPwvgzvQ5Ijag0m8uNYUpYFTXZsBftk6v0fzurJQ85w2gcfUOs9O5ImlSsonI
         lrN0NnE6oxQLLvZila/EuLjjWLDkcsTDE2TKnfaiITljNM2+Y+tFxdICoOkU3s3pnlVL
         iwzdyq3crvqKJhxfsMhlLDsWEp6EkRS7nz+p03/oitxvYtk2p9TLLJ0QPvsyG1nD65ri
         5ccG2ZpGtmGSnYbisDvggJXzJD3y+Os0zmG91/sjQ9/rZv4cjMpvWh/OlkEOkp3BE9Ke
         GUGqEbOKCnCHt0OuHqMosbX+nUGc7vNi2KfOmMO9Rj9jV5fd+58Ft9UxMyiMlpo2LIUU
         5O/A==
X-Forwarded-Encrypted: i=1; AFNElJ9L3rIFoTYjMMvo2z+rrEbUz86C9IlL5MOpoiWF7Zmuk7qNBCMic8LxR4XoXpdnAriliUol9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxA5wnwMR9lLZUqbgEc51iIzqPttKb6Gu1GCxB6DAVq4mx5JbD+
	c4qIpwbERDPYseqNyK5Aav5cKbDWpczgZEDycsZ+6A0ptgnKd18P1nB/
X-Gm-Gg: Acq92OG5qJRFo9jp7JwjUGTRP4TPdsc3AoLoF7TLtV8/CSvlN4HipRRF7yUQIIIXXOF
	n+ST84omHYQzd6XgIIDRVYow5HunZVigU8WNB+dKGjuIFizEt4X6dYZZsr/d2nI/yHszVh8YMXk
	C6dyqg1ts2ymjpFGwokK8hJHrgI7QWzZJdwlENLAclGAcOG5lJ3yE0YqAltBvBGroOY8M5NkEs4
	6QIIFn5cm/T479D0mCUsiyvsxiybESbu+7OoWoK4H9kSafF1CEtDI1Lsdhy9X5kaeyf1WMBjRry
	3Qs3Vz8TMsufAJCnYeI5ONeB6vAqoR3wTag58lTdmiD7Fi4pr2V/cbKj8wF3Sda91yGA3soIqp1
	5UPE9bkg6NA4i2eI/sQtW1JGfLTrC4vBXjZWEaCPUwMVUss+PwQXA+9LeC3Y/EieuG4Xnt1XUBa
	XQTcU/YQp+JKac2Ss7UQV2trxtEe4QUyk48TJJjJvBVoCsnICof9CKc5YdGQ==
X-Received: by 2002:a17:903:11c9:b0:2b9:6cde:c34b with SMTP id d9443c01a7336-2c1ec7982f5mr94110965ad.15.1780822413844;
        Sun, 07 Jun 2026 01:53:33 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e636sm145529555ad.51.2026.06.07.01.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:53:33 -0700 (PDT)
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
Subject: [PATCH] iommu/iommufd: Require write access for writable MAP_FILE mappings
Date: Sun,  7 Jun 2026 08:53:18 +0000
Message-ID: <20260607085320.73274-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
