Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617A338906
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900947; cv=none; b=DKMxaW81fDa6zCArnQL6KiAIbrAAZZ0tAI8MAWMe9QO9fgmHc9H6DKE2S3Njs5figUpXBj/H9TZ+gjdpeX7xPVwVgWaztZYJB5rQNw0mST2cD70Vg3HLSjTsUpetlf2gHZXO07ICy3ck0CDrxnGnZDfmuyA2MJU57VoimUoZG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900947; c=relaxed/simple;
	bh=0S8tvoyNB0MBm9GLPrKZBj/V5Cfw8tU439iV60Dpy+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxT8EH4oyDtT+v5wETF5yRWWTAgAUWF7Z7Bgis4NR4JOcRhIVPqwBFOF+x867e5lN3svk508LcBJTyc0dXBYTBQbwZhlCQ3mo6S0wDvrNd4FMIhPiNFp4fDT/3lW7oGw85mqVbXGqsBpoTJ83jze5ZL5mBfCA4SytgJVWSdELBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNDg4zl9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNDg4zl9"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so332019b3a.3
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 23:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773900946; x=1774505746; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OXeZt9Y4f4f82jU5A2ObTC5XK08MnscssukO7f4OZg=;
        b=eNDg4zl9FxPy0gvt6wMrknzjqVexspaTYFbUm5HVyiwh2ohbUmSE/sSZFRmPwbGvOG
         n/i8MiOuITBHgAFeuSnqRnY8VZlhVEImbz5IFMx4p8CmCqi6QfGnqaQ3rpjdf4qR8RD8
         l9OpdXv3BwZEkhmHzPXr9kfCa9Xi+YZJPPufEIqvwhgFIKR1VwMww2KbfgzpJvbGK/Ae
         k+B2K9/rnI51BJFzqiJWR/yGRmEomRW1nVcfeGiELckVNF1kbr3IzUWPGGkKWvvi3H+v
         cMXahahPuMQGKsx8sDvuGyDL/iCeWbvFJSLjIhUWkbMRfD99O9BVkOR190sFo6CkzYiB
         0s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773900946; x=1774505746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8OXeZt9Y4f4f82jU5A2ObTC5XK08MnscssukO7f4OZg=;
        b=mlvqWnRo7d0Ak/3z6Vx9PiNE8O4771QIWSqLbnvSrG5bTugSLPeEK+O5zdM6Fz+0No
         7uCJBIebtEZQoXJyypHHGF7/pYJCKxY20YMtSTMMrAEeQPA7Kk5FBWFuc6fmCbrqKDSL
         rw+1OArlYB5RDhZxaLx5QGILKaWuxCfn3vPnoEXLTZoJjDpClKNZut6sM+pJdFUgGo+Q
         XFTELjLTCVjW1EPMspd6N5S63UnGJEVwLotkIsjNAmsLeXn9qS+TU8ONk0JG9AeGCNYE
         FG/4KQwzSIe0vRisWmqtBilEs1EODEb5Yt7uyjkXo20tSW2qOyk+B10h4YtN/w+NJWnA
         Xblg==
X-Forwarded-Encrypted: i=1; AJvYcCUP4wPOQeCuuNCGYtPl8OgyolOo8i3t38J0CvqvLS6/ONjO0pt07bTmXXthJNOjOibvQLfWTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUdpbuqPbEOn6RV3xJyUu+n168mrLW7l4cMgUwKf6GU+reNEk9
	9OBqH1Fr6u1y9l/4pWgnZnNkT1B8uMRAaMkbjBmhvenbGmQv2h/S3JB3
X-Gm-Gg: ATEYQzxMteWWeoJkyUcb/SvZNrQfdBhf+gNcRL8KwiILp7XKbZPFXOoLbc0ej6vM9uT
	ZAlKqUhEqF1Y5MYC4+qIT0wQ6KdMj2NQNx+NNKFm3k3lMX9jVZvZ6vfHErD+xBkbywTRcLBLHBf
	XNnfiyXIKgvPXsn3KTO7ik20nFA3ZE+80RYwwr05nF/WpdnYzu0x1D8hR0ku50lrndWc1HCIPig
	OVeipkqF750e+6vzSnU64H2MQk3ErfeII1P0Ui2iq3VzPy1sAv+T85v6nvo0rql7Sv7LBcfYZS3
	p8o3jM9FBnYkDraixgws+UTN+Q70Sf3s8gizoIW7Sve6Z9Xer4I8E1+gQbdHd9RV+peFE0sA3E+
	dgcTh4wkNZz/O0J+dzz88xcsGGBOoC3+AOjSm3r+1WqWh9SCtC29zUSdL9Di6b2du8Cl/8ZvCd3
	1eOiOHgXJJtfW2sf+aEU0oFJbOjxN9vkHsFkZdPTR+MuvWv+xEzMbqRUczgS0rSFkOMDWpZWRgc
	xmFVlH2nEFndQ==
X-Received: by 2002:a05:6a00:399c:b0:827:3307:170 with SMTP id d2e1a72fcca58-82a6ae53fafmr5958993b3a.37.1773900945809;
        Wed, 18 Mar 2026 23:15:45 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bef5ed8sm5660824b3a.57.2026.03.18.23.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 23:15:45 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 1/2] iommu/amd: Keep x2apic enabled when appending amd_iommu=off
Date: Thu, 19 Mar 2026 14:15:06 +0800
Message-Id: <20260319061507.541-2-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260319061507.541-1-adrianhuang0701@gmail.com>
References: <20260319061507.541-1-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When booting with amd_iommu=off, the AMD IOMMU driver currently
disables the entire IOMMU subsystem, which also results in x2APIC
being turned off. Consequently, the APIC mode falls back from
x2APIC to physical flat mode.

The dmesg log shows the transition:
  x2apic: enabled by BIOS, switching to x2apic ops
  ...
  APIC: Switched APIC routing to: cluster x2apic
  ...
  APIC: Switch to symmetric I/O mode setup
  x2apic: IRQ remapping doesn't support X2APIC mode
  x2apic disabled
  APIC: Switched APIC routing to: physical flat

Since physical flat mode supports only up to 255 APIC IDs,
systems with large CPU counts cannot fully initialize. For example,
on a 448-core system, the kernel reports repeated errors such as:
  smpboot: CPU 112 has invalid APIC ID 100. Aborting bringup
  smpboot: CPU 113 has invalid APIC ID 102. Aborting bringup
  ...
  smp: Brought up 2 nodes, 224 CPUs

Eventually, only 224 CPUs are brought up because of valid APIC IDs
and the APIC ID limitation of the physical flat mode.

In contrast, on an Intel platform with 960 cores, booting with
intel_iommu=off does not disable x2APIC:
    x2apic: enabled by BIOS, switching to x2apic ops
    ...
    APIC: Switched APIC routing to: cluster x2apic
    ...
    APIC: Switch to symmetric I/O mode setup
    DMAR: Host address width 46
    ...
    smpboot: CPU0: Intel(R) Xeon(R) Platinum 8490H (family: 0x6,
    model: 0x8f, stepping: 0x6)
    ...
    smp: Brought up 8 nodes, 960 CPUs

This confirms that x2APIC remains enabled when intel_iommu=off
is specified.

Adjust the semantics of "amd_iommu=off" so that:

  * DMA translation is disabled
  * x2apic remains enabled

This preserves x2APIC functionality and allows large CPU count
systems to operate correctly, while still disabling DMA remapping.

With this patch, the system correctly brings up all 448 cores when
booting with amd_iommu=off, as verified by the logs below:
  x2apic: enabled by BIOS, switching to x2apic ops
  ...
  APIC: Switched APIC routing to: cluster x2apic
  ...
  APIC: Switch to symmetric I/O mode setup
  ...
  smp: Brought up 2 nodes, 448 CPUs
  ...
  AMD-Vi: Interrupt remapping enabled
  AMD-Vi: X2APIC enabled
  ...

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/init.c      | 56 ++++++++++++++++++++++++++++-------
 drivers/iommu/amd/iommu.c     | 14 +++++++++
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1342e764a548..82c10f55f0ea 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -22,6 +22,7 @@ void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
 void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
+void amd_iommu_dev_set_pci_msi_domain(struct device *dev);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f3fd7f39efb4..0f577534702d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3396,6 +3396,41 @@ static __init void iommu_snp_enable(void)
 #endif
 }
 
+static int __init amd_iommu_devices_set_pci_msi_domain(void)
+{
+	struct pci_dev *dev = NULL;
+	struct amd_iommu *iommu;
+	int ret = 0;
+
+	/* Register IRQ handler for each iommu device. */
+	for_each_iommu(iommu) {
+		iommu->dev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
+						 PCI_BUS_NUM(iommu->devid),
+						 iommu->devid & 0xff);
+		if (!iommu->dev)
+			return -ENODEV;
+
+		ret = iommu_init_irq(iommu);
+		if (ret)
+			return ret;
+
+		iommu->dev->irq_managed = 1;
+	}
+
+	/*
+	 * In configurations where the IOMMU is disabled but x2APIC is
+	 * required for high CPU counts (> 256), the kernel must explicitly
+	 * map PCI Message Signaled Interrupt (MSI) domains to the IOMMU
+	 * hardware's interrupt domain to ensure valid interrupt routing.
+	 */
+	for_each_pci_dev(dev)
+		amd_iommu_dev_set_pci_msi_domain(&dev->dev);
+
+	print_iommu_info();
+
+	return ret;
+}
+
 /****************************************************************************
  *
  * AMD IOMMU Initialization State Machine
@@ -3416,13 +3451,8 @@ static int __init state_next(void)
 		}
 		break;
 	case IOMMU_IVRS_DETECTED:
-		if (amd_iommu_disabled) {
-			init_state = IOMMU_CMDLINE_DISABLED;
-			ret = -EINVAL;
-		} else {
-			ret = early_amd_iommu_init();
-			init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
-		}
+		ret = early_amd_iommu_init();
+		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		break;
 	case IOMMU_ACPI_FINISHED:
 		early_enable_iommus();
@@ -3430,9 +3460,15 @@ static int __init state_next(void)
 		init_state = IOMMU_ENABLED;
 		break;
 	case IOMMU_ENABLED:
-		register_syscore(&amd_iommu_syscore);
-		iommu_snp_enable();
-		ret = amd_iommu_init_pci();
+		if (amd_iommu_disabled) {
+			amd_iommu_devices_set_pci_msi_domain();
+			init_state = IOMMU_CMDLINE_DISABLED;
+			ret = -EINVAL;
+		} else {
+			register_syscore(&amd_iommu_syscore);
+			iommu_snp_enable();
+			ret = amd_iommu_init_pci();
+		}
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
 		break;
 	case IOMMU_PCI_INIT:
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..75b10eca9ecf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2439,6 +2439,20 @@ static void detach_device(struct device *dev)
 	mutex_unlock(&dev_data->mutex);
 }
 
+void amd_iommu_dev_set_pci_msi_domain(struct device *dev)
+{
+	struct amd_iommu *iommu;
+
+	if (!check_device(dev))
+		return;
+
+	iommu = rlookup_amd_iommu(dev);
+	if (!iommu)
+		return;
+
+	amd_iommu_set_pci_msi_domain(dev, iommu);
+}
+
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
-- 
2.47.3

