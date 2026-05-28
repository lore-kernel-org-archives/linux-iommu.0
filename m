Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D331279DCC
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936977; cv=none; b=lMjFEGilfUHW/+l2ONF5EVM/uLdTHUodf8ilDdah725UQlQOtXULg02P+xTImoGlra9J5yMc1lO7AiIBURYXpujOJNztpoEIFl+eASwtNK1wqlHWTyKgwoM9Hru5DoDlJ2zQCLu0YW8CnLOGBiTBL9ZQmi2pX13AdI747f0s87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936977; c=relaxed/simple;
	bh=b23qsbPX6e2MSdXnbKgH6veJevmyNVpkSiIDY1F7Y0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PfBNn3Znu7G2i4u8AKt4nCq3upBmNmDZfUtFELWMrjZBaSoYFX+9KPSp/4G5aMir8vPyEyBHfoyoxxA25XR8/cZui0HiHEQ2tm1OYnjm7NesGvPkDHLmcxPKXA5G5dwtsD/+wK2/zPL5fF+vOfcxly7/IL63ntbFJoEKTsCIW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr/bFofD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr/bFofD"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e63771d91so114199551cf.0
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 19:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936975; x=1780541775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYBoL5jG1iN0eoFpALE/QB8NqS4xj7k8hYReouwIAOI=;
        b=Rr/bFofDL5MBRTwx1PbsmTur9AJX0PXmXOSawq26kptOP4HaTdF3tIoeRfrdE5tf6m
         u9/+JHPEUVP5iT302o3xdiqsn+zf/nZWyU5aSwqKLHvCHEfjoVNVhCiaQZClGxH3wBvw
         UfaqCAkMW+u7DWtawn7uJ6EZlp+ptobgQNLuKi12VL5y5pGdpyDlN1hCn4A158yubSNd
         6C5uKB7wSOlYOaX1w+Bl2BXb5KHi1DPjfiU4Q5rmiQ8x8yktf1RpKnACFnSUkqPC75Y3
         6If0fTgfE4jdOjKGpYdNHpqHqNkZ/iHVw5yKp5LaZTk2tGjstnVD7QTBbjy8LQqQ9236
         buMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936975; x=1780541775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYBoL5jG1iN0eoFpALE/QB8NqS4xj7k8hYReouwIAOI=;
        b=lGcqU3vcPT8FWGdDRgKibmCyKnHoXewa+MpBiWxnpIjsDP49PgNzQsZSKyxj/wMgXr
         TokADDg/l6RBJieJVB3yYsjJHgytTCsA6iBrZ4PkrjS/cfgD7V4bIuOvv/vD8WY6o5gR
         wyNgR6snOir308JOMLJGj29jLXsmoN956ciXQUAR0p7nuPivFT+UnU6OtBc7czxhcnvI
         HFRNlT1dUpx2IaoTj9QU1NDPuNi0oFPs3G9kbZJLVs1U6Ib8S6bfljyFxiEnmJn2OWsJ
         l9q1IhjdtarkZDIpnwUMYrHiKiGVrrjNaT5NbEO8pYcw7vozqW/xzN1OQ5DRMpMcICqg
         ArDg==
X-Forwarded-Encrypted: i=1; AFNElJ8xkiJKNsM+j0/KmAlVlQ4JZg0Igdpm0OcdCBrlDwJyniU5h1ZQdJSqr+rpyvo5NRxL7GIwOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMd8PqueygObgaazl+xXm3tM4M4n/MlwOwiP6/xGnYknioQkvg
	hl9r/YXHDEBykX66olkNGhFSVCNKR7wGLsXzGb4s5sV4ROaz5HROLErz
X-Gm-Gg: Acq92OG5whCkfyaSdFcOoTGUQZ4NLFnh9tVeh0n2jFJXFhEjDPVVHh538T5BnZydZCb
	LlWHhyZZ21904V12ZawzRL7D6AnAjNqoo4WZC9mhOzLwM5KzSikYP7gqlbIa0UAMN33uhl5QiDA
	T2nsKpvsm8vt3h6AAqGB9vWcksaGxkVNgpAonKjCjbhLjCEL3FRUFbEK4nh+O4e83nUPYPh/DNJ
	BkDHcm5O7oWj6xuVvaAETKewgnO4zYDcWpxS1346eU+BS7tRQ5aCP1zyIO4JrpG19r1nnbB/Vcj
	Zohpc/o5e/8utvYb9aq1xWHKRx7ah8n5N5JNeMDQO13kU9KTefDekKg2z872LeSmWPRNGxP1yUs
	i2frjLIrnxWAiQP5+Av7zfiDXCtUzi+PUWntZY53+bEu6nENpYEoA98S8kYljbk+D8TqSWXcBFT
	+DhcpXdkCkkmSEy3eJ+ESYSkAaTdxcPsRieylnJyKkWHrfuImurRElLthYrCBPYQiMDltzhBHDi
	r50AOE/RNSfLLJi9MyTK8MIf6Qgagw=
X-Received: by 2002:a05:622a:1104:b0:516:dba2:143a with SMTP id d75a77b69052e-516dba23d77mr330748821cf.51.1779936975106;
        Wed, 27 May 2026 19:56:15 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069f2d2fsm67556291cf.3.2026.05.27.19.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:56:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Clear Present bit before tearing down scalable-mode context entry
Date: Wed, 27 May 2026 22:55:57 -0400
Message-ID: <20260528025557.3209367-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

device_pasid_table_teardown() zeroes the 128-bit scalable-mode context
entry with context_clear_entry() while the Present bit is still set. This
creates a window where the hardware can fetch a torn entry, with some
fields already zeroed while Present is still set, leading to unpredictable
behavior or spurious faults. The context-cache invalidation is issued only
after the entry has been zeroed, and intel_pasid_free_table() then frees
the PASID directory pages, so the IOMMU can keep walking a stale Present=1
entry that points at freed memory.

While x86 provides strong write ordering, the compiler may reorder the two
64-bit writes to the entry, and the hardware fetch is not guaranteed to be
atomic with respect to multiple CPU writes.

Commit c1e4f1dccbe9d ("iommu/vt-d: Clear Present bit before tearing down
context entry") fixed this exact pattern in domain_context_clear_one() and
the copied-context path, but device_pasid_table_teardown() was not
converted.

Align it with the "Guidance to Software for Invalidations" in the VT-d
spec, Section 6.5.3.3, using the same ownership handshake as the sibling
fix: clear only the Present bit, flush it to the IOMMU, perform the
context-cache invalidation, and only then zero the rest of the entry.

Fixes: 81e921fd32161 ("iommu/vt-d: Fix NULL domain on device release")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Found by static analysis while auditing the callers of context_clear_entry()
for the same teardown ordering that c1e4f1dccbe9d addressed. This site is
reachable only in scalable mode, so it does not manifest on the legacy-mode
hardware available to me; I could not trigger a runtime fault and the change
is verified by code inspection only, on the same basis as the sibling fix.
Compile-tested on x86_64 with CONFIG_INTEL_IOMMU; no new warnings.

 drivers/iommu/intel/pasid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 89541b74ab8ca..40910dc7363b1 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -748,10 +748,12 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 	}
 
 	did = context_domain_id(context);
-	context_clear_entry(context);
+	context_clear_present(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
 	intel_context_flush_no_pasid(info, context, did);
+	context_clear_entry(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
 }
 
 static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

