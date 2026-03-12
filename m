Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B73F23BD
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331013; cv=none; b=i9gN7bNrZH/a7CRALsZNkB3EsWJW5S+lOBX0P41NAvl/w0RW0auzJvYyQZlZr3egax82f5HVx2iAarHExiFoyyoewMMauFmdYwaaOSw711AZmyGopl5HaQCojdeBkMz1wPuUsgWw6+3uGpPdJtXwz5kyRO+Y7xaq5mHYZlMaN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331013; c=relaxed/simple;
	bh=xVSDUH51PrQlO9FZjAgm0NH0MdnAZeIcuaw7S9IuRFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwRsMGy8taqC4oGCyQ5UWgIwD/Ouzh+Ba+WgCLis7JTTmNtycqYzKZiwmQ80ZuayRfT6zQ1MFmMQsQaio2yVKV96M6CpzullulIFTQZigt9A8c/wp2PTiw6kHMskPBmy7URtkHydyG5q9SYjBbDIxUg06PMJDXADIW9NZM0Ds98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NvEF6qWa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NvEF6qWa"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7DD1820B6F08;
	Thu, 12 Mar 2026 08:56:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DD1820B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773331011;
	bh=78agt53msrArRhO0OIzV37Pk6/mDTJ+S/0LVkBcuyc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvEF6qWaBx37P6rvFNFteLOY6DiNj1pZ/fx21SqJ432lfxbMrUnbDeNma9ZN2Fti2
	 9ghOzdWCMbwUFnl7zAM6QgdyssN8wvlBdrG3Ck2OqiFbWOp0Mkl/hABGRO6qod1ith
	 fTsERs9M8nFy+CKViXQT0ySLyyer2URYu2K2QZjw=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH V2 07/11] vfio: Update noiommu device detection logic for cdev
Date: Thu, 12 Mar 2026 08:56:33 -0700
Message-Id: <20260312155637.376854-8-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework vfio_device_is_noiommu() to derive noiommu mode based on device,
group type, and configurations.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/vfio/vfio.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 838c08077ce2..c5541967ef9b 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -127,8 +127,13 @@ static inline bool vfio_null_group_allowed(void)
 
 static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
 {
-	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
-	       vdev->group->type == VFIO_NO_IOMMU;
+	if (!IS_ENABLED(CONFIG_VFIO_NOIOMMU))
+		return false;
+
+	if (vfio_null_group_allowed())
+		return vdev->noiommu;
+
+	return vdev->group->type == VFIO_NO_IOMMU;
 }
 #else
 struct vfio_group;
-- 
2.34.1

