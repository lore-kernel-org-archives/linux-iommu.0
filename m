Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409401;
	b=FvdGqoqDgrxVcdpZERRtNQXByOVU3b/7EuiZqDz9CoQl8n9ssRbjVUOBjgBRofk3neLK
	 sn9ScHO50/IrFpNtijLLOB97pqcFYStaDLexZUT6+MKFidni6oqyyOfXuQsuKej+FOEXD
	 Pd6N8vkkuZEIkbxwYv5qEy5xyXQwYM186wTak0/jubRKu6ESI6SbP2Tb0vVpOjaYVHtms
	 nRcodvSkVUHx1G86xqeNDxHFbpM78FcJfPCilm5ZDtHLlUIvIVtLOioIJXbReh+5Z0npj
	 QbSVR0skBqi3Bg3Nx7YDGDsZh1fvRSOx6h8JHIVSseK636pt1/UcytgzkS+6L4Ww8ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6MNIHKKL1TyoX4SD1X7Fi8nLR6k5WbA5DIiwx/onbm8=;
	b=x7EZiQzSnN66EE0KwgQPuUw5PNLqtA6K5tBy8Ytor+ltehuKXAQgdiW7Mp0XKDDtOmoK
	 49PXWm0Oj3uG/C7pG7dqS/vZzrOIoPZiW5rYZttphQSP+fxMI94LcYmV4G6XICTFBuo9W
	 EwVt1+hXqNUXfLPB6zXzt+cC8l6UfXDRpeRRiNstzU+NkO70Y+GfSDfeuhyCnv0XnCdOI
	 XcW5AadCVKJg0i9+W9wdzYbU+jl0HvWEaONOLZ+g7sAag5a39BzS2+y6DywqIxwBo6aDQ
	 nGpW+ptkasDrgsU2bfnr4OqBzGy4wV+o2oYQMgAz6Jt5TlLBYQ5tizMNIXn0kZYJfmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PpuZHgMo;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1628606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1628606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PpuZHgMo
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so2828983a12.1
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409400; x=1796014200; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MNIHKKL1TyoX4SD1X7Fi8nLR6k5WbA5DIiwx/onbm8=;
        b=PpuZHgMoz15EqXsI9pg3hkF9LK/H4WM09+UQv4r6djFLvGQxMk+98xEtNwVRLKyXa7
         Wp874CTX0Pk8qzYILkP1b5vlcfsPj28Ddc+BQL48fVUWt62OIDKFK9ONVMP0w8VlnY+L
         4acJ5/Lnnxltt8Pi/7UFZWeJA8yrgK+/6flnpiaAtDZbU2wTsetoraGJzbIB2yAF8mlF
         lVypzvbzw/M+G9jgXgBZJq/Bc6mcTWLnjGqyF0x/hBZs0DG4dujuyzJMaCU165czoFzT
         Z3qBwc5Xrvh+kcmX2M/U5jBhg+9wufELg1WklQH7zBeSH8tDpW4hXNxHZplGneeS3yhx
         XmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409400; x=1796014200;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MNIHKKL1TyoX4SD1X7Fi8nLR6k5WbA5DIiwx/onbm8=;
        b=iHWx+IkL3AxMTH3QsD+Ac2g55FcMUXYL6DOb9d+gP+WBkU4RHbU46HXfO+uworES3p
         WX8rsCeH+q+v+MaEIVeV9LHQ7Vz86yLfYIOj0RLios+i9WfEdIzv81gQb5R79LWSViu+
         IJ3622neGySie7mwI/axeEcLlBlWCkBbiquduXy4IPFQxzz1fndLixt9Wz+xURsiH8tz
         lYgy7CzHF8HFXCHHia5VqBW9uckLKa9BO0tjVRoAtgdn+IfZ6NtHkDzfQhY3tCREt1yK
         xURLHRsTwYV70FSGaeA7JIY5Yl53Zrm0PNJtlCRpiUVCtZN2CIAGwFodiI0kPBhilxKc
         8/fA==
X-Forwarded-Encrypted: i=1; AL+hErGt961lX3engmkvTBWleBrDlB2kRkh6TTWr8hiijKgV4NAQjz3XvkimUXJFC57XVU3rOXLNgA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/qGW1SS2Sy+kmGDLeJL/QjRrJ02cXOIN7MmRxkEUs0meUZHrYI
	WrDXOyjNanT6uPB0M5nUJEuTBKxvoq0SY9mqEexvugHGxD/bVErpSDYeN/7Lea25tGkLHYGGbP5
	kOl0Yh9raHpt4gA==
X-Received: from plho3.prod.google.com ([2002:a17:903:23c3:b0:2ef:a836:c1be])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f87:b0:2ec:ff7f:6f8 with SMTP id d9443c01a7336-2f03f268843mr97692615ad.57.1795409400082;
 Sun, 22 Nov 2026 20:50:00 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:41 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-11-skhawaja@google.com>
Subject: [PATCH v8 10/18] iommu/vt-d: Combine disable_dmar_iommu() and free_dmar_iommu()
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Every caller of disable_dmar_iommu() immediately follows it with a call
to free_dmar_iommu(). Combine the two helpers into release_dmar_iommu()
and simplify the teardown and error paths in init_dmars(),
intel_iommu_add(), and dmar_iommu_hotplug().

Also drop the early return when
WARN_ON(!ida_is_empty(&iommu->domain_ida)) triggers so translation is
still disabled before freeing the IOMMU resources.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d31d2d5845e6..6c86c155d12b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -985,21 +985,17 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-static void disable_dmar_iommu(struct intel_iommu *iommu)
+static void release_dmar_iommu(struct intel_iommu *iommu)
 {
 	/*
 	 * All iommu domains must have been detached from the devices,
 	 * hence there should be no domain IDs in use.
 	 */
-	if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
-		return;
+	WARN_ON(!ida_is_empty(&iommu->domain_ida));
 
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
-}
 
-static void free_dmar_iommu(struct intel_iommu *iommu)
-{
 	if (iommu->copied_tables) {
 		bitmap_free(iommu->copied_tables);
 		iommu->copied_tables = NULL;
@@ -1867,10 +1863,8 @@ static int __init init_dmars(void)
 	return 0;
 
 free_iommu:
-	for_each_active_iommu(iommu, drhd) {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
-	}
+	for_each_active_iommu(iommu, drhd)
+		release_dmar_iommu(iommu);
 
 	return ret;
 }
@@ -2280,12 +2274,12 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ecap_prs(iommu->ecap)) {
 		ret = intel_iommu_enable_prq(iommu);
 		if (ret)
-			goto disable_iommu;
+			goto out;
 	}
 
 	ret = dmar_set_interrupt(iommu);
 	if (ret)
-		goto disable_iommu;
+		goto out;
 
 	iommu_set_root_entry(iommu);
 	iommu_enable_translation(iommu);
@@ -2293,10 +2287,8 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	iommu_disable_protect_mem_regions(iommu);
 	return 0;
 
-disable_iommu:
-	disable_dmar_iommu(iommu);
 out:
-	free_dmar_iommu(iommu);
+	release_dmar_iommu(iommu);
 	return ret;
 }
 
@@ -2310,12 +2302,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	if (insert) {
+	if (insert)
 		ret = intel_iommu_add(dmaru);
-	} else {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
-	}
+	else
+		release_dmar_iommu(iommu);
 
 	return ret;
 }
-- 
2.56.1.809.ga0b61035b5-goog

