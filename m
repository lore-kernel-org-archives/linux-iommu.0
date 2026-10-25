Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894788;
	b=KxtNDdWsLDLz4lGjyT/GZygHfY9M83EYMagNeluytQbpsZ5v9bbrX9I0G82dM4A8IMHx
	 utJ5eNbHpnfPBlV9Jq5HQGxGkNEqt4BXrp/2VMHkY8/fs66kqiJTpVIZw9cuRU9AQSUgA
	 akmAWgstTbwNAXrHSpdnjgK2Mf2RbY4CBUp8P+TjpYsIgATgipGXpU/RKjV35KUU2YGQe
	 tRZTWKrqTaU6J895BZO0Y+ma1BlPvF2V3VZf74wtLkSHGiSRM3fs9v5FB8Yznx2fk/8l5
	 Qjl8VWO10TBWHEkvwxzD44fx//LFNW486VGdHP+YlY+wsCBiZhq+Z4LPYDVpOJy0YkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ul+GW30CyTASrbA0JVXqnRHT26v9kwMzrmnUD+B3Prk=;
	b=R76wzoJNS0QeptTUXJfRrH//zLpoJ6FkIrqJAxfOlol8p7A3mjZjo8hPisV0a7HV7G/P
	 g4hO/xImo0ZhMlvvkbBAhOA0vvx8Dy4SnjEi4Dbx56xms42/HALdMuEH7UQwDEC0cr8kA
	 FLJbfJ3cXWWbeZ6Ik4amm5Z2cv5+xETxGT0POG5XUi6ZpXUJp5le3mmm2RMpgaq0UrHAh
	 ptBLmcBj8hnnSc2CRamP7ADayRTn9+VZIP4Ja+ShX1Og1P8ekXuZOVNvB1HS8NLhGTefQ
	 OgZTK4sKNY+QyAXGABes4tY/8llON6goa5brq3qZ+OS6jg3PGNlPtcXkftvFwhYaokw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nQB3MEtT;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7A606BF73
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 02:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB7A606BF73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nQB3MEtT
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d02df2bf09so14280815ad.0
        for <iommu@lists.linux.dev>; Sat, 24 Oct 2026 19:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894786; x=1793499586; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ul+GW30CyTASrbA0JVXqnRHT26v9kwMzrmnUD+B3Prk=;
        b=nQB3MEtTXKBFt2i31yvWtb595Ish2xLrPTlKdLb1pPKyznnZ+EJrJ0y9WnwuNz3NgW
         FAMJFeLDgUVbXXbBnLXAqRKcLhhOi7MDp/COiieR66cuHOeYgx60gcb2YZHjyULG3f5T
         prH+GAX/EdnA7l4G4BeMGLGeIsPv4fZxcRIQuIOLsRWo4oqQy63aCBx/IxhVWRE07LBL
         LHxiLQ0QwGZ8+t5VJeC9/tr5Lm1BOpFMebTItYBR8m3EQHf3PuILu2yvFSBOgHd2NYYK
         JkuaHAs2+Q34nES7TuJVkdjMr4ps+w4b8SqGthdu9b741zVhQ8ENX99k/InZU7ITQEtq
         6pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894786; x=1793499586;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ul+GW30CyTASrbA0JVXqnRHT26v9kwMzrmnUD+B3Prk=;
        b=KQgkyKf+j+eoG2w5TGFkVQVMct+FblpvBvkM0A13vRM1LJQNyeEOBfIws166pqykfD
         Cfwx5oafzGe+I9HlWxONQSI5HnCsc7fPZlMqyuDKFPnQs2aEBC1qGWLWfG80V9pJY2yI
         EbURHu15JAhYNVZ7ByGPuFm+ffmGkG3fCS6gqEwviJsOn5Asi27a6SuK2zp9gKV3m8tg
         hgjBim+qDJW4InsvlimPLezukaBO1EwQM2YUTHLvEzWlzUHvSnT1VA7nLXYeqg/3fI8F
         LUie8bnSiwgsUD2IIqOt7wDR9YxF5TTTxSGTC4fz51CmjyWQXEgphHBFWahJhv7DTtPI
         JMhA==
X-Forwarded-Encrypted: i=1; AKwUvByk+R8kw6WVrXAPXkggNxTOddWksg9Fe9Feiom2ArXiSTELGs4Zz2mzYVzDIk+CfNX2a9IP4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIGQEn9HegIstWfbOd/d+VXG3hHeceCBMU8G+WURpq1oAP4VnOM
	eBxEVJY5PcJTZeyX3G2m4hXgHsKjoa3L4T/l+OLUoGJRKWPkWK9CrSDtG/BKbEKvILDbYT/X7U8
	Nl8xlw/lTyaqmmQ==
X-Received: from plfn3.prod.google.com ([2002:a17:902:e543:b0:2e4:ad81:3a9d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1968:b0:2e9:95c0:7c50 with SMTP id d9443c01a7336-2ea9c95ba36mr23233515ad.71.1792894786219;
 Sat, 24 Oct 2026 19:19:46 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:20 +0000
In-Reply-To: <20261025021930.674647-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261025021930.674647-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025021930.674647-10-skhawaja@google.com>
Subject: [PATCH v6 09/18] iommu/vt-d: Combine disable_dmar_iommu() and free_dmar_iommu()
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
---
 drivers/iommu/intel/iommu.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 23a1da351ddf..35ec2ae0c8d5 100644
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
2.56.0.257.gf7497c7d27-goog

