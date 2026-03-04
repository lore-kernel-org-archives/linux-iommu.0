Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E73876C1
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659837; cv=none; b=FrsbCg3m11pROGwaUqPXFbIZwEdee3AiPYX0b53Y0bMxa8ALeQHMXb3CjZWbXeiuVwrRbG+pmjIPtw2Z6OJifJrns7kSusZGDppkuT8P0GSwV4Z1rwrT+JGI5VAlE9yAKOcI1rz+mbKmXwswkIyx87Y9/PwzRjhMuYMm8KDe8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659837; c=relaxed/simple;
	bh=3c6quBI7XKemYPlN0GskGbNjt6avnY6lfsxgp6Bz4Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9KPU0+XCbo977kd223Vo/YXRsWHmNIl0Sfud3dC2kdCRonZ88EBYolcnKI4qGjSqqGrG12vppw+RmzDjmPG92igBvBSQLzI8hT0+junX05NDwGp1MIeHMB5thpgVLNdaC7E+KTh2p5DBRkV8UV9vcx+U1CncuxmBoXevQVDW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Wd9g/UMn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Wd9g/UMn"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cbad8e6610so793913485a.0
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 13:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1772659834; x=1773264634; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSYjaX5A2f3fgxWLqUioHt5Z6vX3IWJb5py3eGwR73M=;
        b=Wd9g/UMnSS/IYe9nj3oAARnwyzZSz31k5mmBNfnJj9Ppeb/WO2UWkxe+IXO1M4aAwB
         tzAThVu/ZEqBlDvDMw2m7BCVfZxyiO3uFaUFh4zh2plrZ/uCla5UffaOsxa31qhSLewq
         YghRNli/3G0w+m6U19AlC+EHBsn/SQiQ+VgYdrkPu4xyDB9RBCh49Vxti1jJaSDDk+rd
         1NlW6zJx+kcoEOQTzkqSwzEUutsNQUabQzoegJKbt1380PC38VRNWTYsmunhsFyImTLu
         s1Pd3CTBklpROyUdD/qL6UzhqI7Uguet36M7VEkmLljyK2955yAB+XALlsMV7D08s8R7
         Cihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772659834; x=1773264634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSYjaX5A2f3fgxWLqUioHt5Z6vX3IWJb5py3eGwR73M=;
        b=rD5fv9FuCYx5tLxHdA+5psktSFgVRAXu2uDDKIqyquv9LAg/olH5ZkTaMm0fCAAUNR
         1w5Iri9fnG/xZbnfs8/A74zxb2kgu59EX+CGAjOvhY2vlTyCF1amdRNlMxS5rgvqYhBO
         nCPyNEJWNTsdoy4Q3/dfCINOvJqqb3zYYownv3HHIb2qupHkRn7OQOc/ZES1XVYAlizK
         bkvVYYbsM5LEOdmEyjue7Fv3eXungL+IQuAIf2frGap+Aln2v9d/Kde8CMjvzDzaT+HC
         RwMiFxGx4zhlrzONmqO29k7qpEZR4/d4/CHTDHI6KUnQq/Py0aZBVzIkK+65LuDbXi6m
         0d1w==
X-Forwarded-Encrypted: i=1; AJvYcCWhpzkCLT0Q1475KPITkanAgPNlic/OTl6XqxQs/b7AqUWNzJsW8dArYfkyPHmAgT4d34GSvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YztzjhPhEzfYTjEuWDDiRq002wr5bBaspAt9da+SaKJKUgR23Pt
	z3RVS6spimLQxlCOOtUZoPgHQFl60MJxEIqMgaMNIe0fYbmyLITEs7s3T8AMYfatDbIddNtRIKk
	wjmkOXXx4Pg==
X-Gm-Gg: ATEYQzwAt/HuOcsOizEjteRsCaOsyIMTCAGdS7y5rp0KLboD0U9VgcwUdoJJPf+euzj
	N9JFAVylYecnTBqg5GWT69nS+EgPJFkH88UYajvohthYB4aTTYqIOtdh0VKNUvPv061PB5Y9aGB
	f/K1UfhyLTbk8jj6F/wZDRgx8dkU8i1RI8MEQGy+ihxIWou1b56WLoZzNqS7sDEnrpj6QgP9Y0L
	Ju6MosRINDjd/Z1Rza5SUSp/ut1IOfP5+LpG9UJDrUtQEpsytYgsP98lZxTjOIk2U1cr5U4a+2D
	TxcdQlbeS5p5hVPPDEK0IiyI3vpV3QPiE6lcs0n60P3P1yYehCohh+VguWSPBYHd39+n+kA7YRE
	nn3ZjcFIwCkhDweg1+FX82AtBEjj5EUstyhj3svgZgFyel8BQriXMU8n9UUZU5DkG7/RWiLR0+g
	Bx/njA7ZyZcrpoX/7BmLVeXLWt7qvpGPWy3O2v
X-Received: by 2002:a05:620a:370a:b0:8cb:baea:89c4 with SMTP id af79cd13be357-8cd5aef2c3bmr477281285a.24.1772659834084;
        Wed, 04 Mar 2026 13:30:34 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6869f5sm1998144785a.20.2026.03.04.13.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:30:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] amd/iommu: do not split domain flushes when flushing the entire range
Date: Wed,  4 Mar 2026 16:30:03 -0500
Message-ID: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are hitting the following soft lockup in production on v6.6 and
v6.12, but the bug exists in all versions

watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:1274919]
CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS Google 10/25/2025
RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
Call Trace:
 <TASK>
 amd_iommu_attach_device+0x69/0x450
 __iommu_device_set_domain+0x7b/0x190
 __iommu_group_set_core_domain+0x61/0xd0
 iommu_detatch_group+0x27/0x40
 vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
 vfio_group_detach_container+0x59/0x160 [vfio]
 vfio_group_fops_release+0x4d/0x90 [vfio]
 __fput+0x95/0x2a0
 task_work_run+0x93/0xc0
 do_exit+0x321/0x950
 do_group_exit+0x7f/0xa0
 get_signal_0x77d/0x780
 </TASK>

This occurs because we're a VM and we're splitting up the size
CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes. These
trap into the host on each flush, all while holding the domain lock with
IRQs disabled.

Fix this by not splitting up this special size amount and sending the
whole command in, so perhaps the host will decide to be gracious and not
spend 7 business years to do a flush.

cc: stable@vger.kernel.org
Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..f0d3e06734ef 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1769,7 +1769,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 {
 	lockdep_assert_held(&domain->lock);
 
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+	    size == CMD_INV_IOMMU_ALL_PAGES_ADDRESS) {
 		__domain_flush_pages(domain, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
-- 
2.53.0

