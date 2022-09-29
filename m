Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF510E8
	for <iommu@lists.linux.dev>; Thu, 29 Sep 2022 04:45:06 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so4817574pjh.2
        for <iommu@lists.linux.dev>; Wed, 28 Sep 2022 21:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=extrahop.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XuwacA25Ce11kE/CkEh1ttARCk/4f4lHymQEddi6vGQ=;
        b=JT2BCmbLrhAXof74HAAh2qwgT6/L7i398J4NLP8srkP+fCUx3NYFstmxQ5uUgGisf5
         5smWYousThnkCPMZImjMPio1PfhuV8MAwFu6Oe+nd9MZt86xWhYdwWXIV4LxxQvchUCV
         Z0lyjMfYESosDYsk3Cn4eoBJ44lAwHz9a/ZNqN3bPVQCwgtUsWgoy/4wcQb4hM7bUrDC
         iAHoJCzfG9/Qwg3Tcjx7YWL9vNEBEh1SjB6hECr3RYYzs2PmpLZPvkqXmoKI3C8zHeBj
         lvaS+y/wFL58T08Cssy2W83gEhZYOs8oPeJSz2vPxs8B7uT2xR8tbagviDbiPi81Nf1c
         9/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XuwacA25Ce11kE/CkEh1ttARCk/4f4lHymQEddi6vGQ=;
        b=KFkzG++k/9pUNjMIH4SyTKYgrWp8dkJ+g5pKBav29aWbCZm/k0Ajp8RZtCz8YmLIiT
         etSwv97Vffzci5AdTUTax7FnPvl/yVIqH8h8+pmevQXqleKVaISrBkYNrwnDOt6a5rYn
         XsahC/FHOQjtmjYgr5xtUtv/EnFqOYNv21bTU/ecCVI7vGgZ1I6FaowDZYXRsHJ8CjPu
         KUC4hyNvTyJAqEZuve63TGRjQjR18WAMFamWujDDjS0AhEnSQseToiuM4RyuaAIihKCg
         7BVi5kVO5+DDXkoA0hG6gn23csV3IVc1vqMy6rUgVWiekJ8JjJSq7F+toSsIhGdAZ3Bn
         pG+A==
X-Gm-Message-State: ACrzQf0vHKNxcgxQ5NXM37Q4T2ER9RNGdF5wlGC2/HbcsjEY2xYN2wPF
	Wa7n9pRvrhJmY9XZZVLm4kZgK0nzpuXF/w==
X-Google-Smtp-Source: AMsMyM7buwBohJbp7BBFHXmhTH0VOPrsvGrwhPt/lOPnOBpOauc6yi8zeCDxA3nOcLX8GKuUXod3zw==
X-Received: by 2002:a17:902:ce8a:b0:17a:829:ee8 with SMTP id f10-20020a170902ce8a00b0017a08290ee8mr1607493plg.125.1664426705949;
        Wed, 28 Sep 2022 21:45:05 -0700 (PDT)
Received: from vanilla.sea.i.extrahop.com ([65.155.239.27])
        by smtp.gmail.com with ESMTPSA id 82-20020a621955000000b0053812f35a41sm4922049pfz.194.2022.09.28.21.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 21:45:05 -0700 (PDT)
From: Charlotte Tan <charlotte@extrahop.com>
To: iommu@lists.linux.dev
Cc: yian.chen@intel.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	junichi.nomura@nec.com,
	atomlin@redhat.com,
	Charlotte Tan <charlotte@extrahop.com>,
	Will Mortensen <will@extrahop.com>
Subject: [PATCH] iommu/vt-d: allow NVS regions in arch_rmrr_sanity_check()
Date: Wed, 28 Sep 2022 21:44:49 -0700
Message-Id: <20220929044449.32515-1-charlotte@extrahop.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

arch_rmrr_sanity_check() warns if the RMRR is not covered by an ACPI Reserved
region, but it seems like it should accept an NVS region as well. The ACPI spec
https://uefi.org/specs/ACPI/6.5/15_System_Address_Map_Interfaces.html
uses similar wording for "Reserved" and "NVS" region types; for NVS regions it
says "This range of addresses is in use or reserved by the system and must
not be used by the operating system."

There is an old comment on this mailing list that also suggests NVS regions should
pass the arch_rmrr_sanity_check() test:

> The warnings come from arch_rmrr_sanity_check() since it checks whether the
> region is E820_TYPE_RESERVED.  However, if the purpose of the check is to
> detect RMRR has regions that may be used by OS as free memory, isn't
> E820_TYPE_NVS safe, too?

https://lore.kernel.org/linux-iommu/64a5843d-850d-e58c-4fc2-0a0eeeb656dc@nec.com/

This patch overlaps with another proposed patch that would add the region
type to the log since sometimes the bug reporter sees this log on the console
but doesn't know to include the kernel log:

https://lore.kernel.org/lkml/20220611204859.234975-3-atomlin@redhat.com/

Here's an example of the "Firmware Bug" apparent false positive:

> DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x000000006f760000-0x000000006f762fff], contact BIOS vendor for fixes
> DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x000000006f760000-0x000000006f762fff]

This is the snippet from the e820 table:

> BIOS-e820: [mem 0x0000000068bff000-0x000000006ebfefff] reserved
> BIOS-e820: [mem 0x000000006ebff000-0x000000006f9fefff] ACPI NVS
> BIOS-e820: [mem 0x000000006f9ff000-0x000000006fffefff] ACPI data

There are more details at https://bugzilla.kernel.org/show_bug.cgi?id=216443

Fixes: f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region in BIOS is reported as reserved")
Cc: Will Mortensen <will@extrahop.com>
Link: https://lore.kernel.org/linux-iommu/64a5843d-850d-e58c-4fc2-0a0eeeb656dc@nec.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216443
Signed-off-by: Charlotte Tan <charlotte@extrahop.com>
---
 arch/x86/include/asm/iommu.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index 0bef44d30a27..0e99cc1aec08 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -25,8 +25,10 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
 	u64 start = rmrr->base_address;
 	u64 end = rmrr->end_address + 1;
+	int entry_type;
 
-	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
+	entry_type = e820__get_entry_type(start, end);
+	if ((entry_type == E820_TYPE_RESERVED) || (entry_type == E820_TYPE_NVS))
 		return 0;
 
 	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
-- 
2.17.1

