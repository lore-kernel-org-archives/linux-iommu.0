Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594B32F76D
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733563; cv=none; b=FIb4rZas2PApEJGJL5TyjGP+6Gd/7HcXYUj48okS7LOkh7kNVNi+uwMdTl9fgQ3zGJhAEzTTEiANwpGfz7rHQPGLJJkdcbgbvCgYMXOgRibfacRwNMOggBnx6PXpN+maleA3kcRwvtADVlQQRIrJosf65mIAhx4PVFEf9ZY/khc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733563; c=relaxed/simple;
	bh=p9nKXCnB6qgsDcC8CnnwgOuqSJeVhPxO7RZCp/8yaHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TF0MQgSLimpsdj4VcOSEdN4DE3OKX+nIkZcA9V5JPMO4fVK87d1/WH699C1gKKiN0UY5/JEGQvhpzsRlvrmCiKyLHkhJfP6HBqNPSFnpZxn4zBp8yNKZr+nZN4SUjetGcI+CBcN/oYQWkCMPi1ykYKJjtfYCNwdvvvj2isGKkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVsAagrG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVsAagrG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48704db565eso44169835e9.1
        for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774733561; x=1775338361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/BJ0N9r5LqYCwMEFbnoh31TQxYmD0rO7Mhn/V1aoiaA=;
        b=cVsAagrGP/tSfk0x7K1qY+3feaSWZ0I1AHz+ZdMg8fdpST/2h/cuRMTfF6bsQFmaA6
         e3SIBcGcMU6XbBpOXX2gSG2pX9FK+EApRl0br0bSRZfPluxxdtdm1tDDkL4HDo+d+Zz6
         pqK8U9jzgilTFQSWoqoKr4gQNCjfn65rmHjRj0YJ94SZXwzSFouejXIvVB1CX7SNUdEy
         219/CdyHwl2PJG2F89rdbtaau3cjtrYiPbEBackLHguv2ScAEA8NeTrzvW2gHrV5j63c
         xrw4lCmzSF19TATTHRc/HomkGBnNO30b7NdVQ+1zplcZQSst+XCHPALQHnJKY6qgvjX0
         yzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774733561; x=1775338361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BJ0N9r5LqYCwMEFbnoh31TQxYmD0rO7Mhn/V1aoiaA=;
        b=oiv4Pq1FUIylaKZp2uEWwL9gDmllnRxQd6y1KqO/ytMhDiRU9VxsboVbIrW6idJZFb
         jQHh7zO1Tz1p6OeEIVX11mA+brhTIa1ABWnSM0C1xKYc43FmgGIUA1mLTRfjCH8fdpg0
         Pp9UlMEolEuAWW+oqv8pid6/16smVKCllbC4X3PQdLUjUpN2G9zAwEk4Qye0QNUo3ZdA
         ZWG0eVbHjVgJaF36ROr694J/4IhuBaKGvPL1R4tPLVDlrHhhaQN8bKoL8Sa07Uk+MP+j
         uRu2zPQ9fG7EKFaAW3BvMZcxgDND4l9uy4zlRLOOGKPCxcjhDBV2+9SLLlj5Q6750CcW
         pWkg==
X-Forwarded-Encrypted: i=1; AJvYcCWyHMW1+Nlse9HO1oksejMJUjgFVgu1pSfToqMdB1dLzdGxgypmJ4DvcUVryTwvn8Rp8s31+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlLwzFviwkwJ4UtW6S0dwlptEqDcSyORjoq6vUfCvFcA3aAkv+
	64b66UymMpSoG7icvEdD74pkUHGPaaVaEXjGxD2fMgZjxTV98tVuAx7O
X-Gm-Gg: ATEYQzyg7xPs/+IZv20VGExEI/Dc3pWXhIQForo2yBWOFHRgIqwi5D+/YW1jRaYYFlr
	atmfL53rVO20Y1LjQeZHRn7RhDSh+M89/6J4ZUXyl1ApuYEjZOp4CCY0EiMgHrY5bzMZrdZDo9U
	c1nc+BHpEKtIf7k6YchXT4ctwoHTGHE7ea84a9Cp3w+tjAHZ9MS8LMnc2syK0olgcObMWZPGaqF
	hQRF8V6mD2cvHrPgZ+LZHZN+N6Y92NLhyMEVeOlqcMqBnzl/uLN46Foo89IZO/uR+OVwpvpLW43
	qC70e41UVYOaF6wh9n9CgCHpwDu1+PUK4jIuKNAcn8bQxQ2IxTYi/H2x0/WVkXcub5Hy8Tiwfmc
	8TKcKWfdjBKtLcip15a5OcUuPAXSL1pMY6/z7ockbI9I7/gy3AztoWhN13E73KO9adzJd+I79K0
	UUjUMro7SZRE3uW+UH67lHzyXLIIETI5F1tOJEcupbGaBu1DNvyF+nz5FloMSsNfcUZY5rL7doR
	wdeusAxoi6OSOEIyoaE/nClDWLLoewdTIgc9hM/iX4+60XuG14bRbNRqUzWOL3AnRHP1XGs3cgw
	1FQIOfdp9fzrGBGmCnxI/H94cn1WnYazjE2e2siJVuFg9a9evXoeV7JEsJI=
X-Received: by 2002:a05:600c:5303:b0:487:2439:6266 with SMTP id 5b1f17b1804b1-48727ee5445mr119932975e9.30.1774733560373;
        Sat, 28 Mar 2026 14:32:40 -0700 (PDT)
Received: from archlinux.kangaroo-newton.ts.net ([185.213.155.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725da0333sm64002595e9.2.2026.03.28.14.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:32:40 -0700 (PDT)
From: Christos Longros <chris.longros@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	iommu@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christos Longros <chris.longros@gmail.com>
Subject: [PATCH] iommu/amd: add amd_iommu=relax_unity option for VFIO passthrough
Date: Sat, 28 Mar 2026 22:32:28 +0100
Message-ID: <20260328213228.12084-1-chris.longros@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some AMD motherboards (Gigabyte B650 Gaming X AX V2, X870E and
others), VFIO passthrough of any PCI device fails with:

  "Firmware has requested this device have a 1:1 IOMMU mapping,
   rejecting configuring the device without a 1:1 mapping."

These boards' IVRS tables include IVMD type 0x22 (range) entries
spanning wide device ranges (e.g. devid 0x0000 to 0x0FFF, covering
PCI buses 0-15).  The entries exist for platform devices like IOAPIC
and HPET, but they get applied to nearly every IOMMU group on the
system.  Since commit a48ce36e2786 ("iommu: Prevent RESV_DIRECT
devices from blocking domains"), any device with IOMMU_RESV_DIRECT
regions has require_direct=1 set, which prevents VFIO from claiming
DMA ownership.

No PCI device can be passed through on affected boards -- not just
the platform devices that need the identity mappings, but also
endpoint devices like network adapters and GPUs.

Intel handles a similar firmware over-specification with
device_rmrr_is_relaxable(), which marks certain RMRR entries as
IOMMU_RESV_DIRECT_RELAXABLE so VFIO can claim them.  AMD has no
equivalent.

Add an opt-in amd_iommu=relax_unity boot parameter.  When set, IVRS
unity map entries are reported as IOMMU_RESV_DIRECT_RELAXABLE instead
of IOMMU_RESV_DIRECT.  The IOMMU still creates the identity mappings,
preserving DMA for platform devices, but VFIO can take ownership of
individual devices for passthrough.

Tested by passing through an RTL8852CE WiFi adapter to a FreeBSD
QEMU/KVM guest via vfio-pci.  Without the option, vfio_iommu_type1
fails to set up the container.  With amd_iommu=relax_unity,
passthrough works.

Signed-off-by: Christos Longros <chris.longros@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 drivers/iommu/amd/amd_iommu_types.h             | 1 +
 drivers/iommu/amd/init.c                        | 6 ++++++
 drivers/iommu/amd/iommu.c                       | 7 ++++++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630..974506ad9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -441,6 +441,12 @@ Kernel parameters
 			force_enable    - Force enable the IOMMU on platforms known
 				          to be buggy with IOMMU enabled. Use this
 				          option with care.
+			relax_unity     - Mark IVRS unity map entries as relaxable,
+				          allowing VFIO to claim devices that have
+				          firmware-declared identity mappings. Required
+				          on some AMD motherboards where global unity
+				          maps prevent any device passthrough. Use this
+				          option with care.
 			pgtbl_v1        - Use v1 page table for DMA-API (Default).
 			pgtbl_v2        - Use v2 page table for DMA-API.
 			irtcachedis     - Disable Interrupt Remapping Table (IRT) caching.
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c685d3771..bc35d5016 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -907,6 +907,7 @@ struct unity_map_entry {
  */
 
 extern bool amd_iommu_force_isolation;
+extern bool amd_iommu_unity_relaxed;
 
 /* Max levels of glxval supported */
 extern int amd_iommu_max_glx_val;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f3fd7f39e..a89120700 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -173,6 +173,9 @@ u64 amd_iommu_efr2;
 /* Host (v1) page table is not supported*/
 bool amd_iommu_hatdis;
 
+/* Relax unity map entries for VFIO passthrough */
+bool amd_iommu_unity_relaxed __read_mostly;
+
 /* SNP is enabled on the system? */
 bool amd_iommu_snp_en;
 EXPORT_SYMBOL(amd_iommu_snp_en);
@@ -3676,6 +3679,9 @@ static int __init parse_amd_iommu_options(char *str)
 			amd_iommu_pgtable = PD_MODE_V2;
 		} else if (strncmp(str, "irtcachedis", 11) == 0) {
 			amd_iommu_irtcachedis = true;
+		} else if (strncmp(str, "relax_unity", 11) == 0) {
+			amd_iommu_unity_relaxed = true;
+			pr_warn("AMD IOMMU: unity map relaxation enabled\n");
 		} else if (strncmp(str, "nohugepages", 11) == 0) {
 			pr_info("Restricting V1 page-sizes to 4KiB");
 			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_4K;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 760d5f462..4606fa6a4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3070,7 +3070,12 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
 
-		type   = IOMMU_RESV_DIRECT;
+		/*
+		 * When relax_unity is set, mark unity map entries as
+		 * relaxable so VFIO can claim devices for passthrough.
+		 */
+		type = amd_iommu_unity_relaxed ?
+			IOMMU_RESV_DIRECT_RELAXABLE : IOMMU_RESV_DIRECT;
 		length = entry->address_end - entry->address_start;
 		if (entry->prot & IOMMU_PROT_IR)
 			prot |= IOMMU_READ;
-- 
2.53.0

