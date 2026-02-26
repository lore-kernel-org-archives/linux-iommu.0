Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452646AED8
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138651; cv=none; b=ef2PgxS6I3FupOxEemFPtQj0BHiWGxeDAPWd0uQD6ZRE+Viz23eGFxAw+pBvoOsb8F+GZftYpKFewhBzhA00D0vf+LXb93MbDfq9rN4tSwChJjP4LKqtXcbB3obhE5pdpwNdfI4Rq9wJMESqiRr++a5+0cPPHnHS5X0h2iGOXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138651; c=relaxed/simple;
	bh=4Bsm5NXktJ67xaxNuLnW65X/mDJrSRNEEQqAJj9YrBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEkTd+GXtD+5nKKF4FbWp4ouOLZFUktMHdo5bXm6kuspJHzf8/+pr1V+CnfFDT4vWhW1P6BgSL9qoYuTFUcKbQU1cDUN9iLvFg/AqT5h49lLswU49hXWZvWd2DeUqCo5YOzJU9pNZVrf32XWMdoA+rcm/YtPuLE0tBtSOox6oeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Xu24GvVV; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Xu24GvVV"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 18560BC127;
	Thu, 26 Feb 2026 22:44:07 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 528B7BC093;
	Thu, 26 Feb 2026 22:44:06 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 624BC1FD8FF;
	Thu, 26 Feb 2026 22:44:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1772138646;
	bh=LqGf8tGYtQ/f68PvZswGjUAim/goI4LS6IxcmCtY7MI=; h=From:To:Subject;
	b=Xu24GvVVaAE2QCLZB+KZSdt2uDWhRbx3knq49eaAg0CY5eTyRg1nQLmuXS3vNTGpj
	 cZLM2TRGM56n+eNuT+kya/3bzhZMRZKfNYcVgcEwdwKQsRs3shQpNyqVnOZq0lAcYh
	 muMZBQdFtTnsl0nJ3ruDU1VduvY3WXT9tg5YBmqUUgYUryeKZoXskbUYl8i5aTli3m
	 bxrMVkAK32P5lIohHmzvL/yBn8ir8E7M7LIH9F1HOa4HeYeNmDqv61TXXnS39zKtXG
	 9sbvR8Fl5SiLW7ety/U4uxrvX3W67KVqDPnwAxX0uqkYtDc65VYNCIyIIu9FOcx8wo
	 T9NPCZ+K4xb5w==
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
Subject: [PATCH v2] iommu: Skip mapping at address 0x0 if it already exists
Date: Thu, 26 Feb 2026 21:44:00 +0100
Message-ID: <20260226204400.15573-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177213864595.2327265.17831448725374266753@linux3247.grserver.gr>
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
instantiations to fix. Therefore, catch ret == -EADDRINUSE from
iommu_map() and, instead of bailing, skip the mapping.

Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

---
V1: https://lore.kernel.org/lkml/20260221235050.2558321-1-lkml@antheas.dev/

Changes since V1:
  - Remove closes tag. Turns out there are multiple compounding bugs.
    See [1]
  - Remove warn log
  - Remove the addr check and make skipping universal
  - Cleanup commit message

[1] https://github.com/CachyOS/linux-cachyos/issues/704
---
 drivers/iommu/iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2ca990dfbb88..0a15c22df94f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1218,6 +1218,14 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 				ret = iommu_map(domain, addr - map_size,
 						addr - map_size, map_size,
 						entry->prot, GFP_KERNEL);
+				/*
+				 * iommu_iova_to_phys() may return 0 for allicated addresses,
+				 * e.g., for the 0 address, causing iommu_map to fail. Since
+				 * the intent of the code is to allow aliasing of reserved
+				 * regions, ignore the EADDRINUSE error.
+				 */
+				if (ret == -EADDRINUSE)
+					ret = 0;
 				if (ret)
 					goto out;
 				map_size = 0;

base-commit: f14faaf3a1fb3b9e4cf2e56269711fb85fba9458
-- 
2.52.0


