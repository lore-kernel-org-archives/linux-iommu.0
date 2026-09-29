Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778643D3D18
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692269; cv=none; b=X69XI0Tq3fvcSKBdllv9eZ8X71IxeyjYUH5yQmQPQcBEQbUDZmHFzfq5fxWyVy2nO7CzJ4mRm7kzbCpxRI0oVqRLbdA96S55lAE2irlu/wjmiIvAPn92L6VNwudf6cZOJ6ATNzOauAhYKA1lpIFAtLW4ZyL4PK4kEX0F18TeGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692269; c=relaxed/simple;
	bh=7ldb8HOmjgXtNUqB8nPLQ9i0TZ7S1XWD7Hhe/UMCeKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laMR4Wx/WUDi6qQEPtY49Ow/bNI0RPB3PcFpHb1NmjJQ5+MrYhTar/1cjIHqEYC6RxR2FxigwK38EP0wkQhH9qAY5Oqdn52ugtkfq80osvAuaKLjOpxXbvbhxy0LYbUiZCzjU394Kld3ZyT9b4uRmCYAcfCJLNBVAAaPZM2gZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5KKyuWG; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5KKyuWG"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-4887dc16848so1038898f8f.0
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790692263; x=1791297063; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQTnQKTsS6Avi4kBaKDVGL1M647FRs0iTSqK5qxgUsQ=;
        b=S5KKyuWGl2W3Qmqq+Mu2DMnIpWm19xx4bCaNMUDdaoaxez4pcZcqId5msvUh3W+awc
         +9vS/M0wRG6IZ/GrHBv6L8Rl72wvK55KZu5KRPQ7G8EtYDesvxfP1ZLKuTJ6+wF/Ed5I
         tkABU/n/v1pScuoAb039rjhCTKO0lSduvyWPYoWkYs9tkpT7Jo3k+rvi58dmPXgFVlV/
         ZBa3F/S4RvKanKT91R/qeZArWT3z3Hub+dOTOz/CXA02aSgP8n2wEu9EIKPI1sBiZSQl
         M0OvFZ5yTCxtrd6inBDwLFAqTATEi0LsO/7oQ6i7a7I1G3S7hmpgpbo0cuoZdOPQyZ1s
         pYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790692263; x=1791297063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQTnQKTsS6Avi4kBaKDVGL1M647FRs0iTSqK5qxgUsQ=;
        b=j3MpsS+9CY8xL2YKY5NpqEbpcGlKuhMsZ/HgWOp7YhOF3/0aTmEkCcEyXHIFNdJCp3
         ONRqGYjgY73a6g2HEZFrILKTxOOL+5Qy2LxXHuEZrKZEPC1aBDeNCbPN6d3E8/PgnLcV
         aEu1rk7nkOJAxVYCyvrTW6f7N1Pc0C1OeNfXCUXMcMtmzeHcpX8Uk7+mAJaOQV77HPof
         GxtJ+GdzZWsXUNo/25CkTbJGZ7nlGKsLVztYrl+goNNoojDx1vW5Ag8LzKgjl7HXzOJY
         9rN+8QwTcIp3nK5lAT/trVdxnebm8RuiW9MdL0S6sTYfxFibWsvoVBieU+bsfyhZrknj
         teUg==
X-Forwarded-Encrypted: i=1; AKwUvBzKF8b8VaKBWQDQI/6QC3ALe9VBL8FlJKus04sAmOYWHuBPgXPSD7rwVnEmOmodcYrAwkRGPg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKeO9SQpRfQ2S9ER94Q7RtU+7qtLcxBaHgBZ+JawncI5d52R57T
	RklWiaVh1FBrA9WHskPcMPm4Ya4VhhnSFmHOd/TKHqhORHpM5yY40FMV
X-Gm-Gg: AYBFou2W/AFZspnQZ7DzaPrbyI9z4u7hOjfnJPzxrukQcwSGDua/id0NVu11+n1w854
	i/Nn1xgVuhY4hlWThMHN603Sf9y/0xlF9CB22F49RtjxoQ2rJMLeNtYZ++tSltlBPJlznfX+M7V
	UzNhdPS/z6ekxGYZ+0nSGpa3RajSolbb+Fcuymc3hD7EAajRnIBOzaioC2yNyRO04sZU1Y59f7i
	wnqRW+6b0QdZnYYLpcputX/As+H/V/35W83gN5dSdP2cFkyaw1dUtbyntWSfGAv05FAQ2E6DXbb
	2Njy9OoRV4eQsKpdr1QOUt90uA7NfkZfeANkFfy8PL/DDk8pmQ1lNia7l9ITYkMQTB60SxYJKSo
	TWKI8LeDMklGl5Lb73iw3uLAWNEUMWzu4r9T4jBWvOZ3HlZYcXQHT/fjLjrHLKyecVqilJxAxWg
	QkCEjuTe+6/bitohGKlVj2fisn9yrYD3tQKc34j+tt0c/sMSB++8EnpgBGy+ShrciXepKK1aoEM
	yRp6Zw83t+IOWFw
X-Received: by 2002:a5d:64cc:0:b0:487:212:a412 with SMTP id ffacd0b85a97d-4887165f6fdmr32380213f8f.9.1790692262433;
        Tue, 29 Sep 2026 07:31:02 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5030037sm5196243f8f.8.2026.09.29.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:31:01 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Betkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleinxer <tglx@linutronix.de>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yi Lai <yi1.lai@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.10] iommu: disable SVA when CONFIG_X86 is set
Date: Tue, 29 Sep 2026 17:30:34 +0300
Message-ID: <20260929143036.82392-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

commit 72f98ef9a4be30d2a60136dd6faee376f780d06c upstream.

Patch series "Fix stale IOTLB entries for kernel address space", v7.

This proposes a fix for a security vulnerability related to IOMMU Shared
Virtual Addressing (SVA).  In an SVA context, an IOMMU can cache kernel
page table entries.  When a kernel page table page is freed and
reallocated for another purpose, the IOMMU might still hold stale,
incorrect entries.  This can be exploited to cause a use-after-free or
write-after-free condition, potentially leading to privilege escalation or
data corruption.

This solution introduces a deferred freeing mechanism for kernel page
table pages, which provides a safe window to notify the IOMMU to
invalidate its caches before the page is reused.

This patch (of 8):

In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
shares and walks the CPU's page tables.  The x86 architecture maps the
kernel's virtual address space into the upper portion of every process's
page table.  Consequently, in an SVA context, the IOMMU hardware can walk
and cache kernel page table entries.

The Linux kernel currently lacks a notification mechanism for kernel page
table changes, specifically when page table pages are freed and reused.
The IOMMU driver is only notified of changes to user virtual address
mappings.  This can cause the IOMMU's internal caches to retain stale
entries for kernel VA.

Use-After-Free (UAF) and Write-After-Free (WAF) conditions arise when
kernel page table pages are freed and later reallocated.  The IOMMU could
misinterpret the new data as valid page table entries.  The IOMMU might
then walk into attacker-controlled memory, leading to arbitrary physical
memory DMA access or privilege escalation.  This is also a
Write-After-Free issue, as the IOMMU will potentially continue to write
Accessed and Dirty bits to the freed memory while attempting to walk the
stale page tables.

Currently, SVA contexts are unprivileged and cannot access kernel
mappings.  However, the IOMMU will still walk kernel-only page tables all
the way down to the leaf entries, where it realizes the mapping is for the
kernel and errors out.  This means the IOMMU still caches these
intermediate page table entries, making the described vulnerability a real
concern.

Disable SVA on x86 architecture until the IOMMU can receive notification
to flush the paging cache before freeing the CPU kernel page table pages.

Link: https://lkml.kernel.org/r/20251022082635.2462433-1-baolu.lu@linux.intel.com
Link: https://lkml.kernel.org/r/20251022082635.2462433-2-baolu.lu@linux.intel.com
Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robin Murohy <robin.murphy@arm.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Yi Lai <yi1.lai@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ The context change is due to the commit
  be51b1d6bbff ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()")
  and the commit 757636ed2607 ("iommu: Rename iommu-sva-lib.{c,h}")
  in v6.2 which are irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2025-71089

 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9d65557dfb2c..e3f1496013b2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2988,6 +2988,9 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
+	if (IS_ENABLED(CONFIG_X86))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!ops || !ops->sva_bind)
 		return ERR_PTR(-ENODEV);
 
-- 
2.53.0

