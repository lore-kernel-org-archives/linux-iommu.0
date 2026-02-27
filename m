Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711836605D
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214776; cv=none; b=pB/LAPcE32U4778NNgUILbLzA6NF3U4PPPD+qMW8thtj4sLcAQTqimKtlgvvdaxV3nCE2vk+5fRt/Gt4VgdSpoB5gtSERLK8HUFkOdtDl7HftUuSrU46IS0MizGwG6zpoEtHa6WIIVGxGGcCvVyF/sBo4EWEAKSQF8sObSU/1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214776; c=relaxed/simple;
	bh=xVSDUH51PrQlO9FZjAgm0NH0MdnAZeIcuaw7S9IuRFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKfzO6ltICy5ZZ4Kzae+MMdvYCLqaAsh6skpFxRXXe8BMgBmn4dtu6DQPzBZlCeabttLUxPeRSVx2HBRJjXxcL3CcmYc7Yb/ubCwGcuOt0ast7AJjTb1QEpRiAqMsScj3Wf1REBU8Ef0X6chQpLTY9Qjc8N4MH2PII58+cF1u0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g0iPFCKZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g0iPFCKZ"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 134AD20B6F02;
	Fri, 27 Feb 2026 09:52:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 134AD20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772214775;
	bh=78agt53msrArRhO0OIzV37Pk6/mDTJ+S/0LVkBcuyc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0iPFCKZzCNM6pfmmG8JLx535OxcnVhsxFe7FitX75IzvJ+EQGvAR/BProDFVycI9
	 1X/RkOrQ02s/vWN/JkqYm/xjcrXXk/ZSnxy934xG0RMzPdUNWg+Mrc4ZelsIVTBrPS
	 6csyL4+/lD6q4RHlCWBdcejJLJ/IqpJ62TNiiOGM=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 07/11] vfio: Update noiommu device detection logic for cdev
Date: Fri, 27 Feb 2026 09:52:43 -0800
Message-Id: <20260227175247.26103-8-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
References: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
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

