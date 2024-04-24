Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140C15886D
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943102; cv=none; b=Pplxemc92vXfGdslsxxeTL8q0/oTqJkiTRy0aOGv16Z8DTg6q3RIdv6aRkGfp2SlLZdLw2K3oX1GYHE0vldog+orQ/x/5bWxHi2R9yRHupDxIe8I7g4j7sOKNb89Js8Rx+sjX/FwjSfVdScHMDMDXbNt2VDmmFYgt2szDpSGbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943102; c=relaxed/simple;
	bh=XPJvJoJo5bArnseRCaC3hNrXN8ICEYpp06SG8wKh3f8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNiJvPdcuC07lwa3rPmM2XlMPqHB2cG26eXJnajHNFpgqsnCH+WeM57dTX3xIK6JJfwKVU2kh7tO3dlaAos/vPTNRJjxE9GDDVnq48mHWJjlJJq/ocBr59l8huuRhpdXp1HUXX4v5zefvY/jrPiU7q9Ex1pDEVvII2XfFZYkv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKVyJZLP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKVyJZLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943100; x=1745479100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XPJvJoJo5bArnseRCaC3hNrXN8ICEYpp06SG8wKh3f8=;
  b=eKVyJZLPcK5gWgaW1Mf49PwymvLHz9PppzL1oj1ukrKYcKG0ns49QKZl
   Ce86QjdvJeiZ3j8d6hdKvkSyS0JykSm37Q5rhS1ZVpbBV68M1plMEFjGG
   Phh3oTrGNaRy/5rzKluEKzOzVSJrV/RiyzxATM4AgmC6doGBZ59HEhIJT
   tK4SdY542D0diSHQoT9RE1+Rbah56CeggYgA1gpVNL62TRhSFJ3CmyXGY
   8P8fhGDkOsoh7ujcxKCbDG5gxEOgTRXha46Q20uzJGnGWcDjUxnybKzoV
   UxGEFgfBV17BDVDnVGRzu5I7qKxEp46OGaYh/chAaSAY/5N7z7CPKD2oy
   Q==;
X-CSE-ConnectionGUID: amJEMJP+Tau0ZHj3GxVXfg==
X-CSE-MsgGUID: S3Gu7hdeQLauFx1MveeCAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073121"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073121"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:19 -0700
X-CSE-ConnectionGUID: aQQn42vcQBWYuz1I4fwAGA==
X-CSE-MsgGUID: AK/QvK0/Ri2ypUPcE+GNJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24664872"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:16 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/18] iommu/vt-d: Remove debugfs use of private data field
Date: Wed, 24 Apr 2024 15:16:30 +0800
Message-Id: <20240424071644.178250-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jingqi Liu <Jingqi.liu@intel.com>

Since the page fault report and response have been tracked by ftrace, the
users can easily calculate the time used for a page fault handling. There's
no need to expose the similar functionality in debugfs. Hence, remove the
corresponding operations in debugfs.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
Link: https://lore.kernel.org/r/20240308103811.76744-2-Jingqi.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/perf.h    | 1 -
 drivers/iommu/intel/debugfs.c | 7 -------
 drivers/iommu/intel/svm.c     | 9 ---------
 3 files changed, 17 deletions(-)

diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
index fd6db8049d1a..df9a36942d64 100644
--- a/drivers/iommu/intel/perf.h
+++ b/drivers/iommu/intel/perf.h
@@ -11,7 +11,6 @@ enum latency_type {
 	DMAR_LATENCY_INV_IOTLB = 0,
 	DMAR_LATENCY_INV_DEVTLB,
 	DMAR_LATENCY_INV_IEC,
-	DMAR_LATENCY_PRQ,
 	DMAR_LATENCY_NUM
 };
 
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 86b506af7daa..affbf4a1558d 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -706,7 +706,6 @@ static ssize_t dmar_perf_latency_write(struct file *filp,
 			dmar_latency_disable(iommu, DMAR_LATENCY_INV_IOTLB);
 			dmar_latency_disable(iommu, DMAR_LATENCY_INV_DEVTLB);
 			dmar_latency_disable(iommu, DMAR_LATENCY_INV_IEC);
-			dmar_latency_disable(iommu, DMAR_LATENCY_PRQ);
 		}
 		rcu_read_unlock();
 		break;
@@ -728,12 +727,6 @@ static ssize_t dmar_perf_latency_write(struct file *filp,
 			dmar_latency_enable(iommu, DMAR_LATENCY_INV_IEC);
 		rcu_read_unlock();
 		break;
-	case 4:
-		rcu_read_lock();
-		for_each_active_iommu(iommu, drhd)
-			dmar_latency_enable(iommu, DMAR_LATENCY_PRQ);
-		rcu_read_unlock();
-		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ee3b469e2da1..e014350db354 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -583,12 +583,6 @@ static void intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
 		event.fault.prm.private_data[0] = desc->priv_data[0];
 		event.fault.prm.private_data[1] = desc->priv_data[1];
-	} else if (dmar_latency_enabled(iommu, DMAR_LATENCY_PRQ)) {
-		/*
-		 * If the private data fields are not used by hardware, use it
-		 * to monitor the prq handle latency.
-		 */
-		event.fault.prm.private_data[0] = ktime_to_ns(ktime_get());
 	}
 
 	iommu_report_device_fault(dev, &event);
@@ -768,9 +762,6 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 		if (private_present) {
 			desc.qw2 = prm->private_data[0];
 			desc.qw3 = prm->private_data[1];
-		} else if (prm->private_data[0]) {
-			dmar_latency_update(iommu, DMAR_LATENCY_PRQ,
-				ktime_to_ns(ktime_get()) - prm->private_data[0]);
 		}
 
 		qi_submit_sync(iommu, &desc, 1, 0);
-- 
2.34.1

