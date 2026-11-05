Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906865;
	b=PiSPkJO7tCXgLEXYmZVCpxbRBa0ZMbMe0nMIVhUCieYxfnicufClvPrsfBE2KK+fHzmE
	 NP2UbTyZFz67UxjeBdyEbIZrnNWDV09uvWNdi5OLdAEADkqIlGCPBffj/NZZlQ5F6e6yg
	 7HLRwxxBb0AZiaTFXgspeIxg9R20TE4jfzmwHxDyNjz8uBtzcSc4IAfLst9ZBrqsj5Erm
	 RMSyeeIB12mPnPx1P73wwCidIYeOSHon3yrF9keG+QbLDJr6wNzw5q4mmlx9awJ34dOh5
	 wSJG/mkkR5Ic/Ca5hm1POFaSTCNLoV8ZzO1yymWc1xCf7kUrj7XJZgYRWfijROzWCMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fbbEG3gQeTzOUIsTltAH47maYBG1Ws8wsE+J4GEN+e0=;
	b=jDVWSUBjAwDgrAZJdboy7k5obFSDnBs0f8zr/8qQrf0mDrrcndhwhD5jNqPZyyTV8O0T
	 GJvfoDot8cd5JlVoqu77BeJ1nFhuSlwVWj8P5o7wZN+zrh1kmxeGthKDy1inZVLwPey+s
	 upAQv7KcLb6eL7BuHQ9joVndLrrQhNYQy+vkGBwNwZtMccodmZ2Us73WKCFc+g0BA73kj
	 sIzopdJFEG2Bum6NjU0LbE1Z1SrEwj591E/JMXZeEt7Qo31rn2poPmFlbjY8+HpGSrLxI
	 Ip8lU4JUdwe8lPbx24YvqoHgqQD9vg14UvGkvCjC8+twnPcRORCXjV7mqGOEWc47/oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r/1+L2vr";
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8C606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 19:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A8C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r/1+L2vr
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-537548b811aso17541261cf.3
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 11:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906864; x=1794511664; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbbEG3gQeTzOUIsTltAH47maYBG1Ws8wsE+J4GEN+e0=;
        b=r/1+L2vrKzMybLfqQNGh+YGX104JLXiE4eYoipCubnEkWyCNZttv8sLORv5MJjmXrr
         ZSLumfR8q+ZvPkKwOgySshLdcnQbWDV07t0SU1Omly5bFLgUoIcfuqMmKju5KkNeo0o1
         B6Ne3+59jELLfiASd2iDaQ31xLwEPP5qtMS70ui6AviV/oGUnqA1Brz56IMENq1VAXaw
         3/tDdko0KovfDJBMGcCF2j9tJIIzrTfzGcAF52DwSxg0/BQtvTY7IDTORtT2SxUiCi4F
         r+L+8JDO9XqE1uauFDkFPjHMFoWiV/w4V4vFYvgLed/exuRvzvf7A/ub11qdTsvYjSo2
         Uekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906864; x=1794511664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fbbEG3gQeTzOUIsTltAH47maYBG1Ws8wsE+J4GEN+e0=;
        b=DLiYv3HvTsTrrp/LMhjqC+HvYRIf3qSJMoJhAWPyXeTSCo0HLQk7stcu74uDq68jdQ
         xwWihJ7ArCgJabLXJmYj0JDutfk8DBFbVQxvIXa+Q+d1bq02TqJfO4B1z6TijkucKlqK
         MT4bsEnbwIOG48nOPOr575dJS+1NSzTmTmftCx2d20HqgPpHGNOfpI9Z4iZJBfltFxd3
         9ADcd4tE9xQBhCCjVf1nI4ySfP2Ngz10MFnBH9euhhzWSaAhYbE1KhgJGFR8YZcJqvJx
         kGXs3Da49OG0VOGffLbeCjz0smLCowHykXW/jWKsIevxE5n2BrYvwfm3r9b3e5nOp/PT
         pkEg==
X-Forwarded-Encrypted: i=1; AKwUvBxVLUhxTZr1LZY0PHP4CZlfyMfZ7fuTfMcsMzZlurR5Gg+rTlhZmxUDZcfg41sIOrOQUKexNg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/1gOrFOLHvoTL4nnpYl2wK97Gs+9UbYUM2FWS+6u/QxFQmK2K7
	xV5vzrbDF1yNnWu8T6tp0y50nBYRjHxN8NvMoaDqWGPlYNLD3fo8BGEw
X-Gm-Gg: AYBFou2s29nFyV5J0RcVFklqbrruRdiTR0BmDeTpu61t+Oj5eYt4Asa4TCpWFZJ4Y6D
	iStbKGLd6nzu33G2JdEoS1jjt7yh4FYSh27qSO5yUcOPgeS6Ak55m69K0a84eQ12o2RPZKRHz1I
	+Vos+PtSyUZo2tYNRd/p9YNsC2X6rWpNjeHo1GU2DwoAbgoZgTOC6UhASl8qU/wo6K9POAGb9nH
	C6o6+rq3BXtniiN2W4iSFW/ZLsmAe1poVkUxIhImfy3SmPl77Zfo96vjTCYspnvDiNXsK8una+y
	GiELmlU93xEv/5zvUGW9mLw6iIdpv5PJCIzO5nT0EZjfw87DzuhOdel5s7CKRhhlSpGU1i4ntLE
	c3HQFJgbFxBuRMDCl8k3bWTcg5W29fRgqyplyp884E8AngbR1mWTVvZAaynUwEHk/hBjQ3BF3/H
	ifqP77FYKuHLgBQOhohrWf2y3BcX+th3zlPpXAjJR06ykaqO+cubHmh6bEUHBZPHRl2J7a76oU5
	qEWBJ9En54S1wV3ZdeZ1F/Av0ZvxhDR3SyZ3hll2gW6aAm3g8VNvUwZmdJ3N/cAPmxuyhvrxdJ6
	T6UOYQoMUMEM38Q+Wd6/ymeGQV3EPUs+nSxEsRdEd+apRYaCISPKfg==
X-Received: by 2002:ac8:5ad4:0:b0:536:6383:577f with SMTP id d75a77b69052e-54e15b66b1cmr4847061cf.64.1793906864051;
        Thu, 05 Nov 2026 11:27:44 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e25785890sm925801cf.7.2026.11.05.11.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:27:43 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Thu,  5 Nov 2026 14:27:08 -0500
Message-ID: <20261105192738.70664-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hv_iommu_paging_domain_free() frees all page-table pages with
pt_iommu_deinit() and only then asks the hypervisor to delete the
device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
fails, hv_delete_device_domain() only logs the error, returns the
domain ID to the IDA, and the domain is freed anyway.

The hypervisor then keeps a device domain whose page tables have been
freed and can be reused for anything. The ID is also handed out again
by the next paging domain allocation, while the hypervisor still has a
domain with that ID.

Delete the domain before freeing its page tables, and keep the ID, the
page tables and the domain if the hypervisor fails to delete it.

Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (x86_64 with HYPERV and HYPERV_PVIOMMU,
W=1); I have no Hyper-V guest with the para-virtualized IOMMU to test
it on.

 drivers/iommu/hyperv/hv-iommu-guest.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index 876a22f21f1e..205c642c8d40 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -107,7 +107,7 @@ static int hv_create_device_domain(struct hv_iommu_domain *hv_domain)
 	return hv_result_to_errno(status);
 }
 
-static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
+static int hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
 {
 	u64 status;
 	unsigned long flags;
@@ -122,11 +122,15 @@ static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
 
 	local_irq_restore(flags);
 
-	if (!hv_result_success(status))
+	if (!hv_result_success(status)) {
+		/* The domain still exists, so its ID cannot be reused */
 		hv_status_err(status, "HVCALL_DELETE_DEVICE_DOMAIN failed\n");
+		return hv_result_to_errno(status);
+	}
 
 	ida_free(&hv_domain->hv_iommu->domain_ids,
 		 hv_domain->device_domain.domain_id.id);
+	return 0;
 }
 
 static int
@@ -466,11 +470,16 @@ static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
 {
 	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
 
+	/*
+	 * If the hypervisor still has the domain, it may still use its page
+	 * tables, so leak them.
+	 */
+	if (hv_delete_device_domain(hv_domain))
+		return;
+
 	/* Free all remaining mappings */
 	pt_iommu_deinit(&hv_domain->pt_iommu);
 
-	hv_delete_device_domain(hv_domain);
-
 	kfree(hv_domain);
 }
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

