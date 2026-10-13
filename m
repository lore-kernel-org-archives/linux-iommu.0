Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ABB4F7CC9
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893996; cv=none; b=dhahKIRMlD0wLKViQFzztS6RDOj/0Vs5rLVm27dJGuYWBY/LM+duDYCgvjKwxs5u3vdUaxuTx2XKOnBE5bVduME+h4Use7jU4Y/xRETTAD48cgIPhkea3bUqfkPqapYmrzPTGDiSGgQvV01nvnC3Jm4U3JlYxoXp6n+Mx55/5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893996; c=relaxed/simple;
	bh=HClb3+R7XqUi6eYTOz7iTtJSRX2ibpgrEI5bky7lR/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrbbC+e36195YFPAnuzpOFaSPo9bxozi0ncVNlpYv2eX1UUrNCrpk0LjZRp/TL0Ov3g5x9uC/xGNH/EPm9Jz18/gQkBCTlz5SPAa4+yBhljD0fDFyYqfRy8Zxg8AnkNyudWZi48qXPNK+OlwB7qTosShbSCMK5lvyV3HYDcCtog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=bTivdQzn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="bTivdQzn"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2771723f8f.1
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1791893991; x=1792498791; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nClHHLwqIIKVi02OMAQklsmsGC+QC3Qdr3aT7miJ3Rg=;
        b=bTivdQznwL8GJ4mqfc8SrpiQi7FXgFwbTg/W6oZJEq5Xtww9BOfejx5+x3Gwyq8CoC
         51a8A9hk22j0wMQdfHQhTr5rMEDcdpsTN+SCSLcosJ9Xh8S2/nSUxjQ7R7F2TZ+/JbHO
         TiHrF8zO8mz/MWrwOYcxPSs5PDVqEhQZRWzw6ABB0oKgEejQU/iUqZkOculdPsMz+77V
         ekwgf2Y/o7tBfcDJo8NsEeTYg8ib5h/H6znAN9EB83DkheyW8+iS1d5jafRrn8w0/+9B
         gYkGUFmvuvdmaWYrEii57950sBTfLFX0ueVIGqOW+5rvAUo5ORqJ+Gon7fXXhdx4DoOg
         ZahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893991; x=1792498791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nClHHLwqIIKVi02OMAQklsmsGC+QC3Qdr3aT7miJ3Rg=;
        b=sT1zrijX0HpuOmOG7ZBBBPbTkxHs3iOrG3wGMG37eBWHEMh79X7LZsjvnSSxygyr4X
         sg8ZRvQNz+gYMRQCK8lGT8neEZdFHFoSnuNjU1GYNAM/QzRqDYQixkHkfFGDPWE5GmEw
         olokam9/YGUOmv99al9eakUwIKkNsvxplLSy8XuZoy8g+yCgodBY6ZZBAOg43Hc+1cDi
         T4kzwmTUMI/0yh+akD9SeYDmB+GSxTlMhmVXOiZpamU6zda/gp4SMvjee+fbeCpgSriE
         t5iiP9ety44s8BbN8U325CddAt/iq+dg81xRFXuobCWnwhE9HRkBvxJXUzSj7fyYkS6c
         j7wQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuN56ouvlEf+te1eqCM1tYRxVfN7Q6qejFG3HFNV4WcyQHfURciK315j0syQGVUs5SxRzeQQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIxcbPO51BE10j1v4ZR3EWcV3tCagtIvBCw4t2BgorrvoIesmRm
	PP/5Q3/YLgHJfEUnyL6+obQC8qk6KHPBc/b52V/0VZf2OsJWKUhRV1ocSTTm8si1Oa0=
X-Gm-Gg: AYBFou1iiSbjXnXLRvaG4mygb8+5mNPxvI1cfrm6NcFu4RJDiHxcScIn9QB8v3+O8ze
	saMMLHGmWJTwua1gj5Q37nsFc7oZTmFMIHw3mDwBd88jMHUpQgRCHV2ZrmK/2Ku7K/z7RklgAlp
	XF6C1gYJ5WTKG9qzoyVkeYoTDZQf14Glp/U2RMcGaSG/33KoKINxLp7LOtbypaGkhEEN9QnJ76r
	U9g37bOmMUx8fYnHp4B1KW8cUX0lba6Sf0pLnHT1csbeHVMHz2iR8Jj51w6lDIzPYHxqp3jaNqk
	ONEtlMzhLVMxVRezhzeJptWKSlWRdkQFNtVRruIufny2pjjnIkfE2YWJ9TVHbv/TUyo12TtPF9P
	rtKUUa7C+k2p6/BAYsMOFPg8EIp0lyvgpRc4MraKBcjx4BWgmJinzgYIpZFz/kOqmfDJq3/KdtL
	rYAV3xSvt2W6jpxpVMuV9V5la5YQNF0x8JDEYHixHYPprAWuWeeTnNIKPymGyIoAkjRwWWLWkZ
X-Received: by 2002:a05:600c:c3cc:10b0:4a1:a7f8:c12b with SMTP id 5b1f17b1804b1-4a1a7f8c219mr37427115e9.19.1791893991549;
        Tue, 13 Oct 2026 05:19:51 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26c8::3dd:3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc5e0asm4806155f8f.50.2026.10.13.05.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:19:50 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Ankit Soni <Ankit.Soni@amd.com>,
	Baoquan He <bhe@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH v2 2/2] iommu/amd: Don't allocate kdump device table from DMA32
Date: Tue, 13 Oct 2026 13:19:44 +0100
Message-ID: <20261013121944.4060097-3-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013121944.4060097-1-matt@readmodwrite.com>
References: <20261013121944.4060097-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Booting a kdump kernel with crashkernel=X,high crashkernel=0,low on an
AMD system fails the per-segment device table allocation because there
is no memory below 4G:

  swapper/0: page allocation failure: order:9, mode:0x40104(GFP_DMA32|__GFP_ZERO|__GFP_COMP)
  iommu_alloc_pages_node_sz+0x7f/0x150
  alloc_pci_segment+0x4bd/0x650
  iommu_go_to_state+0x213d/0x34e0
  amd_iommu_prepare+0x39/0xa0
  irq_remapping_prepare+0x83/0xd0
  enable_IR_x2apic+0x61/0x370

On our E810 systems, the kdump kernel booted but ice MSI-X interrupts
never fired and the TX queues timed out.

Commit b336781b82cc ("iommu/amd: Allocate memory below 4G for dev table
if translation pre-enabled") allocated device tables below 4G. At the
time, the kdump kernel programmed a copy of the old table into the base
register with the IOMMU still enabled. The 64-bit register is updated
as two 32-bit halves, so the running IOMMU could see a half-written,
invalid table pointer. Keeping both tables below 4G leaves the upper
half zero throughout the update, so the pointer stays valid.

Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
the kdump kernel reuses the previous kernel's table without writing the
base register, so its newly allocated table is discarded when reuse
succeeds. If reuse fails, the previous patch programs the new table only
after disabling the IOMMU. Either way, the kdump kernel's table doesn't
need to be below 4G.

The previous kernel still allocates its table from DMA32, so the kdump
kernel's check that the old table is below 4G still works. Drop
GFP_DMA32 for kdump kernels only.

Cc: <stable@vger.kernel.org> # 6.18.x
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/iommu/amd/init.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0572e1a674f0..16c26d75f46f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -648,8 +648,19 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
 /* Allocate per PCI segment device table */
 static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	pci_seg->dev_table = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
-						  pci_seg->dev_table_size);
+	gfp_t gfp = GFP_KERNEL;
+
+	/*
+	 * Keep normal kernel device tables below 4G because a later kdump
+	 * kernel only trusts and reuses old tables below that limit. A kdump
+	 * kernel's new table is either discarded when reuse succeeds or
+	 * programmed after the IOMMU is disabled, so the table does not
+	 * need DMA32 memory (which the crashkernel may not have).
+	 */
+	if (!is_kdump_kernel())
+		gfp |= GFP_DMA32;
+
+	pci_seg->dev_table = iommu_alloc_pages_sz(gfp, pci_seg->dev_table_size);
 	if (!pci_seg->dev_table)
 		return -ENOMEM;
 
-- 
2.43.0

