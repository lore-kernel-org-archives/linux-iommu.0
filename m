Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE363FE5F
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171847; cv=none; b=ISqJEyXII/5VkLY4Qg/Ng7EBuxND+0zCV5WQBinG7rqwZfPk2HkCNuPt/l4CaDITpv2hKxKBJQ7DAqAClNA6oZlcv34RvdvZW3fWF7AvB91GQenzyC33JvRZi85bNMMVkQ91dzZSjid4/6TX7ddEdFd/zidk5uPzVoHr5GubFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171847; c=relaxed/simple;
	bh=vC+09tLRfMKWEKQFxq6BEb9i3D5JAX2l8AB4jWSy8sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Umda42vU0WSGQAPrH58/ZEw+Jf1EcPhflnKo/Cwv3rWujErPiMt9z2JjymDccQsehdfa1HsNuKh2lpmnMJaNU085F5xd3bNlI03pbleghM8L8ZaH8kYxWrX9OnVsu4bTbE7ZedLykI4HbQl+j7Zn2rbBFCqagU0SBQa3fbO3ckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vaa1C1kc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vaa1C1kc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758171845; x=1789707845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vC+09tLRfMKWEKQFxq6BEb9i3D5JAX2l8AB4jWSy8sw=;
  b=Vaa1C1kctZjPQzIXobKfkMHsYIMCBpf2UoC6isl8Vt+Z6vNemcAkRea9
   zk2cW0PgfsKvTAdtGbbwhjAvRhzAhA/+BJ4JNDEKz589fjo2nLJDEvg5b
   mJ8dnzhwUyajAuYODObG9r9jVg+iSuFBLHnOEHQiBj+erxvg+0QrikTfp
   JBhsOdo0TLGqftbAtKA9/c/JDbgeWffFoErzhbJGfrDUKg4LOiDx6h8Se
   2MIigIDDqQ3FprORv8bI/EX7aQzbeZmYggNdHRr2coJFvIxjXvP2tvRo0
   mymP8Uj35Ud/cD3jtYhQGkmODTcsjRrQZR+w0J551JqMKzTcrtFLPLUOT
   g==;
X-CSE-ConnectionGUID: LjDVVk2gRnu+AEI+2kdDsw==
X-CSE-MsgGUID: 6TVCYYfGTdOdVlge7C7HIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60182256"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60182256"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:04:05 -0700
X-CSE-ConnectionGUID: DB/bwS7vR/CzrEY189Iqvw==
X-CSE-MsgGUID: haNOsQhaRz6VchvvuvjqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175353402"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2025 22:04:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] iommu/vt-d: debugfs: Fix legacy mode page table dump logic
Date: Thu, 18 Sep 2025 13:01:59 +0800
Message-ID: <20250918050204.359508-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918050204.359508-1-baolu.lu@linux.intel.com>
References: <20250918050204.359508-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>

In legacy mode, SSPTPTR is ignored if TT is not 00b or 01b. SSPTPTR
maybe uninitialized or zero in that case and may cause oops like:

 Oops: general protection fault, probably for non-canonical address
       0xf00087d3f000f000: 0000 [#1] SMP NOPTI
 CPU: 2 UID: 0 PID: 786 Comm: cat Not tainted 6.16.0 #191 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
 RIP: 0010:pgtable_walk_level+0x98/0x150
 RSP: 0018:ffffc90000f279c0 EFLAGS: 00010206
 RAX: 0000000040000000 RBX: ffffc90000f27ab0 RCX: 000000000000001e
 RDX: 0000000000000003 RSI: f00087d3f000f000 RDI: f00087d3f0010000
 RBP: ffffc90000f27a00 R08: ffffc90000f27a98 R09: 0000000000000002
 R10: 0000000000000000 R11: 0000000000000000 R12: f00087d3f000f000
 R13: 0000000000000000 R14: 0000000040000000 R15: ffffc90000f27a98
 FS:  0000764566dcb740(0000) GS:ffff8881f812c000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000764566d44000 CR3: 0000000109d81003 CR4: 0000000000772ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  pgtable_walk_level+0x88/0x150
  domain_translation_struct_show.isra.0+0x2d9/0x300
  dev_domain_translation_struct_show+0x20/0x40
  seq_read_iter+0x12d/0x490
...

Avoid walking the page table if TT is not 00b or 01b.

Fixes: 2b437e804566 ("iommu/vt-d: debugfs: Support dumping a specified page table")
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20250814163153.634680-1-vineeth@bitbyteword.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 65d2f792f0f7..38790ff50977 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -435,8 +435,21 @@ static int domain_translation_struct_show(struct seq_file *m,
 			}
 			pgd &= VTD_PAGE_MASK;
 		} else { /* legacy mode */
-			pgd = context->lo & VTD_PAGE_MASK;
-			agaw = context->hi & 7;
+			u8 tt = (u8)(context->lo & GENMASK_ULL(3, 2)) >> 2;
+
+			/*
+			 * According to Translation Type(TT),
+			 * get the page table pointer(SSPTPTR).
+			 */
+			switch (tt) {
+			case CONTEXT_TT_MULTI_LEVEL:
+			case CONTEXT_TT_DEV_IOTLB:
+				pgd = context->lo & VTD_PAGE_MASK;
+				agaw = context->hi & 7;
+				break;
+			default:
+				goto iommu_unlock;
+			}
 		}
 
 		seq_printf(m, "Device %04x:%02x:%02x.%x ",
-- 
2.43.0

