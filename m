Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD64736AB57
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179628; cv=none; b=nYWNBu4qj8o+WYF75MkjAjeHYEYjZ1cdROSCdqplxkowOVv7vrGEhk9l56X4x6R2qscy84890k/uDNRjW2FIM1HOPsVBwk1pUg7B0sppYiMuqMYnZ4rl5q3ThJ3HG4JlQRXGpX+e2364Kawjf/BpWMTZ2vp9Bkp5vRrKmKEl8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179628; c=relaxed/simple;
	bh=bjeQqEK/l0mjR3XT5V8P7F5xMoE+wW4BF5iFZFOeDQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThV+42z7/wNvIEAYGp7+YSNCM0S773d9uq/44LtbvFJnOS6jGPROxjxNkLlL23rttGhIPMyyANlFwXh/ZmhGAxyINW4T6etO9ARGv+Whw9jpd7Ko79KZGJputynWTEGh1eNqphriBJvMhYGDsfoI40sKUtr7k6tLoDODUziHR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=KkDgfPuv; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="KkDgfPuv"
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 375EB5E7D2;
	Fri, 27 Feb 2026 10:06:58 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 0CF3E5E807;
	Fri, 27 Feb 2026 10:06:49 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 905381FC3FF;
	Fri, 27 Feb 2026 10:06:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1772179608;
	bh=3mYH757P2K2Jucic/spvsZ1RRTqse+4kfwrBJpx5MCE=; h=From:To:Subject;
	b=KkDgfPuvyJ/crv4/uPtx6X/f2HvvZ2jPmJIrUu7C55xf7HiPUFC5LJTtYP3yJphYQ
	 ytJRSXI/Ln/V1E1ZsIeGiZSiPPP1SYWxJSVyz4uLDXXG+NYaVxBAOFcGyE8RvomAYj
	 hZ3EAxyCatr05zPcpMyhbpI81kr8dkitF8GrliOAedfp545DzcOe7jgIV1BYaYfy9a
	 JgVjvFp1sR4iL4mxfjxaNW4jzviJn06sBcDurWnYvNhQLq6f2iLm4XyhqaYWf5AiW5
	 SdPksGS9ZUsocqsTgYJ8315jqJ8HL5v+77j4Lr9Qo3e0/acwUOvuOvj6+mk4x9ECRx
	 kBeKQ3GXqbVzg==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	dnaim@cachyos.org,
	Mario.Limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v3] iommu: Fix mapping check for 0x0 to avoid re-mapping it
Date: Fri, 27 Feb 2026 09:06:37 +0100
Message-ID: <20260227080638.208693-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177217960820.1012861.4546139478497230872@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
introduces the shared iommu page table for AMD IOMMU. Some bioses
contain an identity mapping for address 0x0, which is not parsed
properly (e.g., certain Strix Halo devices). This causes the DMA
components of the device to fail to initialize (e.g., the NVMe SSD
controller), leading to a failed post.

Specifically, on the GPD Win 5, the NVME and SSD GPU fail to mount,
making collecting errors difficult. While debugging, it was found that
a -EADDRINUSE error was emitted and its source was traced to
iommu_iova_to_phys(). After adding some debug prints, it was found that
phys_addr becomes 0, which causes the code to try to re-map the 0
address and fail, causing a cascade leading to a failed post. This is
because the GPD Win 5 contains a 0x0-0x1 identity mapping for DMA
devices, causing it to be repeated for each device.

The cause of this failure is the following check in
iommu_create_device_direct_mappings(), where address aliasing is handled
via the following check:

```
phys_addr = iommu_iova_to_phys(domain, addr);
if (!phys_addr) {
        map_size += pg_size;
        continue;
}
````

Obviously, the iommu_iova_to_phys() signature is faulty and aliases
unmapped and 0 together, causing the allocation code to try to
re-allocate the 0 address per device. However, it has too many
instantiations to fix. Therefore, use a ternary so that when addr
is 0, the check is done for address 1 instead.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

---
V2: https://lore.kernel.org/all/20260226204400.15573-1-lkml@antheas.dev/
V1: https://lore.kernel.org/lkml/20260221235050.2558321-1-lkml@antheas.dev/

Changes since V2:
  - When addr is 0, check for address 1 instead. Add Suggested by for
    Robin. This is an alternate fix.

Changes since V1:
  - Remove closes tag. Turns out there are multiple compounding bugs.
    See [1]
  - Remove warn log
  - Remove the addr check and make skipping universal
  - Cleanup commit message

[1] https://github.com/CachyOS/linux-cachyos/issues/704
---
 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2ca990dfbb88..3a0c0e4b42ff 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1207,7 +1207,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 			if (addr == end)
 				goto map_end;
 
-			phys_addr = iommu_iova_to_phys(domain, addr);
+			/*
+			 * Return address by iommu_iova_to_phys for 0 is
+			 * ambiguous. Offset to address 1 if addr is 0.
+			 */
+			phys_addr = iommu_iova_to_phys(domain, addr ? addr : 1);
 			if (!phys_addr) {
 				map_size += pg_size;
 				continue;

base-commit: f14faaf3a1fb3b9e4cf2e56269711fb85fba9458
-- 
2.52.0


