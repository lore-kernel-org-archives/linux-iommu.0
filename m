Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD216197A7F
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902739; cv=none; b=A1EXdxVg4PPEhcBj3TT5baL99bd/3RdUw606oh6M/laOu5P6Y9k4SQJG/p7Y2l8xRg36/b5T8KtOpFRJDmfsYechmNBgp4VX67IxC4uSpOxt9fbxZNHvq/75Txh5/EAnpoYCKTDeMt4G4Yn/eZxM1EC02GIxburhQTqMuMNZ8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902739; c=relaxed/simple;
	bh=yoLyLZ9ZX/fObQ8mnxyo/4YWg5mFnXFKiHF5SttoGY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJuhKAIpCcC0IonAufYxM7HsXiYZbSwiaq8n6ZMhZMn9BQESF+3PgjK7EB7Ti5mlihElxB+tmrbW86fIKfcTucDrIXYbajP8FsZ2lvbSCFyCivk6zKf/JdHr2bwhFn6K+hitX91Sv31Xr0v+mfUzmpDquhoxpTOFrFEjZsKyxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYNXvKeb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYNXvKeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728902737; x=1760438737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yoLyLZ9ZX/fObQ8mnxyo/4YWg5mFnXFKiHF5SttoGY4=;
  b=RYNXvKebVky0iTgRVzE2+uUO3DC6w9qMzRzLa4vgnFKBxp5ngMeTI3A7
   QjrHesPqVc25YS0xD1SRxNlXY1rkLpCWvEVaExO7lnC1joKY+NZNVY3zt
   S/VQMkJDASVVpJU6o+KA5CWsHQLZsAyv3robc/NZ9RnbgdTtjFJz/64GA
   9MKACt1Wkt6/2cJOCrDbjVuaSk4d2pp65eNnJ1rpUjIhtkndO3ko1wYCT
   zMN+T1UCPfWorRz747Mrzc+VmlK+ttOiCiNRx441/NrTIVVn8zz9/3Lfx
   B6r/mnGUoKIQqK7T3Q9reF5WfpGNfZdK9uhiQGgXvQoF6H6cIr9vSYcJc
   A==;
X-CSE-ConnectionGUID: N2SzMmQ6Q82YxqYQw3JFRQ==
X-CSE-MsgGUID: W/P3AE4/RJeWAYxJPVuGZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38799585"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38799585"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:45:36 -0700
X-CSE-ConnectionGUID: AVT9CvHaSd+sarV/5vZSpQ==
X-CSE-MsgGUID: rgWQ74yqRC6qNPMh7MzA4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="114990292"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 14 Oct 2024 03:45:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E5B722E6; Mon, 14 Oct 2024 13:45:32 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <jroedel@suse.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iommu/vt-d: Increase buffer size for device name
Date: Mon, 14 Oct 2024 13:45:29 +0300
Message-ID: <20241014104529.4025937-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC is not happy with the current code, e.g.:

.../iommu/intel/dmar.c:1063:9: note: ‘sprintf’ output between 6 and 15 bytes into a destination of size 13
 1063 |         sprintf(iommu->name, "dmar%d", iommu->seq_id);

When `make W=1` is supplied, this prevents kernel building. Fix it by
increasing the buffer size for device name and use sizeoF() instead of
hard coded constants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 2 +-
 drivers/iommu/intel/iommu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index eaf862e8dea1..e16c2b1d7633 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1060,7 +1060,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		err = iommu->seq_id;
 		goto error;
 	}
-	sprintf(iommu->name, "dmar%d", iommu->seq_id);
+	snprintf(iommu->name, sizeof(iommu->name), "dmar%d", iommu->seq_id);
 
 	err = map_iommu(iommu, drhd);
 	if (err) {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1497f3112b12..61701c1c22d3 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -720,7 +720,7 @@ struct intel_iommu {
 	int		msagaw; /* max sagaw of this iommu */
 	unsigned int	irq, pr_irq, perf_irq;
 	u16		segment;     /* PCI segment# */
-	unsigned char 	name[13];    /* Device Name */
+	unsigned char 	name[16];    /* Device Name */
 
 #ifdef CONFIG_INTEL_IOMMU
 	unsigned long 	*domain_ids; /* bitmap of domains */
-- 
2.43.0.rc1.1336.g36b5255a03ac

