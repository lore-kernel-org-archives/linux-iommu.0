Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874622494F0
	for <iommu@lists.linux.dev>; Sat, 21 Feb 2026 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771717865; cv=none; b=D0CbWvHmHD/N2Xev0dUb/waPtXU0udtH/CGcxe6l+BBdd7f6aHEgeVBAAJhDS/6ddKi4Cs9YqAxyMf8Omy/UsbYxVs/tM/nfsdNpcqmOHgndaxdBuOz5OHjsHUkO3DPncX+Xjkdk3w5tU/gKWbee3AK4JjH5S/a596ZBsEIyCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771717865; c=relaxed/simple;
	bh=2RYQmzcTUiBbagRrayxSa+eTk4tXP5lF8//BxS4wImo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQU0Rw/cZHti0bmuG6IYnBfEqoBQzV4mD6Wo6pSPZrUkOoyc0jCw+cLHeCuzLa0msSpezTvjrtiMbMguxL8m9pjc/msYkXbnlNO+MqduPkC5nghcA/fa6pIzA5Vp7/xVl+6VFB4GkvBje9OmZ8wmhXfQS3GZXQwzKSreTM9Y2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=E2WF3V8y; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="E2WF3V8y"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 6BE2EBBF51;
	Sun, 22 Feb 2026 01:50:56 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 6D799BBEF5;
	Sun, 22 Feb 2026 01:50:55 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c5:43c3:0:378a:d3f6:f8b0:bed1])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 4062C1FFBD3;
	Sun, 22 Feb 2026 01:50:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1771717854;
	bh=baMPunq6vAHqyGU3U92dXLB+5FVcY87mfWdLIJ0ujDg=; h=From:To:Subject;
	b=E2WF3V8yAQ9uiS0KUOYlQDVCIVBHz/ZKT3AnsBPXJ0K8BPrbnYi2mL7rmNI1M9OtQ
	 F8EfcmVS/ZjvtKPSa919y9gfmNp4KlWlDvpPoa9hTsLk4IHfiCvD/N9s/caYstHrzT
	 mFyTMHkyYoEzQl5V/byuk3xw7wuqHV6FIr0aAy1HZmd+Ld3EIkSt2dzKxm5HeT53Ih
	 PciaWYQB0nR9rQMgNOE/Ul89T7lqqvYGe5yo/4BUi5eOjyUX9QyHHlGskA7k1Gk2oy
	 3vYZXtvgaQ+lwuZEBk1LBTFy7WlgZ3l4/FNaCZr0sfhUrU0wekfhSH9Qi/ze6H3Xjf
	 /fHgqqrOCmlwA==
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
Subject: [PATCH v1] iommu: Skip mapping at address 0x0 if it already exists
Date: Sun, 22 Feb 2026 00:50:50 +0100
Message-ID: <20260221235050.2558321-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177171785479.3878801.5871207421121691119@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
introduces the shared iommu page table for AMD IOMMU. Some bioses
contain an identity mapping for address 0x0, which is not parsed
properly (e.g., certain Strix Halo devices). This causes the DMA
components of the device to fail to initialize (e.g., the NVMe SSD
controller), leading to a failed post.

The failure is caused by iommu_create_device_direct_mappings(), which
is the new mapping implementation. In it, address aliasing is handled
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
instantiations to fix. Therefore, catch ret == -EADDRINUSE only when
addr == 0 and, instead of bailing, skip the mapping and print a warning.

Closes: https://www.reddit.com/r/cachyos/comments/1r5sgr6/freeze_on_boot_after_kernel_update_to_619_fixed/
Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/iommu/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4926a43118e6..d424b7124311 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1224,6 +1224,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 				ret = iommu_map(domain, addr - map_size,
 						addr - map_size, map_size,
 						entry->prot, GFP_KERNEL);
+				if (ret == -EADDRINUSE && addr - map_size == 0) {
+					dev_warn_once(dev,
+						"iommu: identity mapping at addr 0x0 already exists, skipping\n");
+					ret = 0;
+				}
 				if (ret)
 					goto out;
 				map_size = 0;

base-commit: 57d76ceccee4b497eb835831206b50e72915a501
-- 
2.52.0


