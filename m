Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0C307AC5
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716619; cv=none; b=jpQVyB09u+BOiNEDHtGF1vf3+hdjwEUmXhYRWa8uhhPTwS9OaxI4qEp3NstEiEmTZljOKlR/Q0UgiD9BZA340v194mtRQR3bSztMyIFSYHBpy12jUESKYU5Yg/7ZI3Ju4kjiJdHDYimk1BqrnF2gWHE1MnOWnQaQL+WiZ6uc2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716619; c=relaxed/simple;
	bh=yUZI/irVfwiaP4PFSwpXr/fxPmv+UTawXdvsT/zLHjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVQU1yo+KeEbqZQFENkqlvw5NQM6e0OQCJVRg5ACDIrcpF7QX36chqMZzmd4T39oDnnVpIzou3ujK5PFqnpAKSDD7ZXg/WdLqXyXlCgwYOESNwOOSV0ovwt+OCtWhk8yvdooa7vIEInyQAipZ/dX+iGrN0HDC/FfpMdXByrayWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSJAq9J2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSJAq9J2"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340d3b1baafso8054472a91.3
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716617; x=1765321417; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mZ6L2jBPpsYrbVWvwV7OWcG6bK6uqvVq9Q2DCACrdk=;
        b=JSJAq9J29A2k5sdgB8zn9pX4vpVZnF5qEyKOuUM26APaESt+zSno+ZhEqd8tdTubl2
         ZsFsrT3qrm02WUNpl1xM0ZC9V0aC7VaMuPiB3+EXjMq9VWxuGISSZY47//ii1cLCd59R
         Lb0GjidycmYNeIzpUS+5Pe0+LSZj12DAwxN4+Trz3ZstZOJsCKQMW3RoanLkfhisS6BO
         vVpTZe3GQxBbi+RzCwhvoUfRTp8xg9fQgc/uEsVLsdZAcbmFwN3GCOqlTOqpD9+Qc8et
         10vZimUbkpMbgsUsI5i1d1Ye5zdemGHRDPQdXBFGFVjL66cuv3CKKWeb3pRZaixo9QDD
         mkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716617; x=1765321417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mZ6L2jBPpsYrbVWvwV7OWcG6bK6uqvVq9Q2DCACrdk=;
        b=qP2iFN9ErrGUIAD8LfHhnAnKYGPhxUyclHoOk4tvcClTFDXIpkcnX8ysCbQdA+pzyM
         O7B0eri6XuUI842LCUk3QqCzRfGYmEf6fLpsKFW8u+/awAJVP72Apmh7hRhTU+JtscSh
         Ncr8NBmLJB2xFfekH6UmSLpvWOUKNV1rYlup078LJRvm5ji667UsGCntC2CT/UgjWhmU
         +3sLFRs0Q/Ehmx5mWta+AZIy8XG4aTZbrBSbg4q/S/CnzIKTDav9RaVAbgWrgaxCAckB
         MrqXcCoGysszEfblSl84vVkduUgPGq2ajv+8c3Jq3Ex3hJ7xpGhpt3wLX8dAIs5qcXwU
         S+zg==
X-Forwarded-Encrypted: i=1; AJvYcCU2/YftPsgrZSWCO2S8U98LyxzigtpyCOkEpnPMGdmvb+CT21dR3MxMmrQsoj21xqrYxcxM3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPfg0cD2Zm8L3dtzMtrmV5bhS2paXZq6k36c2NpSiQIVSQFuN0
	PR4o38evidsrui++2ExbhuyUAhsRlOcuqbRxVSf+0tnYdkFguchoXedP/o3Hpuc1ZCkVtWQbwXV
	PXxovz+nakkNr9A==
X-Google-Smtp-Source: AGHT+IEYhoU7ADyVksV3xKCXL4U6ohVJDbeio3wZoom6OShVYzd0zuWruj0oybl/9ze7UEg+jWKn0RqmwKZRBQ==
X-Received: from pjbca18.prod.google.com ([2002:a17:90a:f312:b0:32b:ae4c:196c])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a8b:b0:341:194:5e7a with SMTP id 98e67ed59e1d1-349127fdfd5mr335129a91.29.1764716616667;
 Tue, 02 Dec 2025 15:03:36 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:51 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-22-skhawaja@google.com>
Subject: [RFC PATCH v2 21/32] iommu/vt-d: Clean the context entries of
 unpreserved devices
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

During normal shutdown the iommu translation is disabled. Since the root
table is preserved during live update, it needs to be cleaned up and the
context entries of the unpreserved devices need to be cleared.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      | 33 ++++++++++++++++++++++++++++++--
 drivers/iommu/intel/iommu.h      |  1 +
 drivers/iommu/intel/liveupdate.c |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3f69a073b2d8..84fef81ecf4d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -16,6 +16,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-direct.h>
 #include <linux/dmi.h>
+#include <linux/iommu-lu.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
@@ -52,6 +53,10 @@ static int rwbf_quirk;
 
 #define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
 
+#ifdef CONFIG_LIVEUPDATE
+static void __clean_unpreserved_context_entries(struct intel_iommu *iommu);
+#endif
+
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
  * (used when kernel is launched w/ TXT)
@@ -2376,8 +2381,12 @@ void intel_iommu_shutdown(void)
 		/* Disable PMRs explicitly here. */
 		iommu_disable_protect_mem_regions(iommu);
 
-		/* Make sure the IOMMUs are switched off */
-		iommu_disable_translation(iommu);
+		if (iommu->iommu.outgoing_preserved_state) {
+			__clean_unpreserved_context_entries(iommu);
+		} else {
+			/* Make sure the IOMMUs are switched off */
+			iommu_disable_translation(iommu);
+		}
 	}
 }
 
@@ -2884,6 +2893,26 @@ static const struct iommu_dirty_ops intel_second_stage_dirty_ops = {
 	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
 };
 
+static void __clean_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+	struct device_domain_info *info;
+	struct pci_dev *pdev = NULL;
+
+	for_each_pci_dev(pdev) {
+		info = dev_iommu_priv_get(&pdev->dev);
+		if (!info)
+			continue;
+
+		if (info->iommu != iommu)
+			continue;
+
+		if (dev_iommu_preserved_state(&pdev->dev))
+			continue;
+
+		domain_context_clear(info);
+	}
+}
+
 static struct iommu_domain *
 intel_iommu_domain_alloc_second_stage(struct device *dev,
 				      struct intel_iommu *iommu, u32 flags)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ea88c86030bb..1eb60ce1300f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1283,6 +1283,7 @@ int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_se
 void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser);
 int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
+bool intel_iommu_liveupdate_clear_context_entries(struct intel_iommu *iommu);
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 491075802e4b..3f8c7f15bc36 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -9,6 +9,7 @@
 
 #include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
+#include <linux/iommu-lu.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 
-- 
2.52.0.158.g65b55ccf14-goog

