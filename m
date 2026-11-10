Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283723;
	b=RXMzY+vQD2qtetoIByeZw4V9PYUVxf9QutSihpKq77wgaReHL+z9LT/fx2HNqLDPMTYm
	 s1urzBOJskzWWq82O+iM1Va0jit936d5YcOdj0g6zr7WGO2WBY4gC3YqtFz/TPnu7T7Zq
	 1j7ELN2oGJShiXgXzl2gjzakAe4mVIXVw4ykW+Odi0LUEGj/hC02ABganjMe67ajREef4
	 nvzeUL5LAtp4s0Oyaff5XvPSC1b5J2qa26lmgpvBeCaq6ALe8CNPpIMhWT+bX2NfrZFSB
	 KNUeMGz2ydG+4oi/B+AWHRD1siOW7HzTlhm80nLLtl1LuNZtPZB36VWUiA3C4VjmXIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FuJECyUteBIYhk4zt7IpaezKNFcH3wE4eNPgkjkn+yw=;
	b=l7JhukG2cns/3YJWhT/DKQYnOzw88I9gjnYRR1bTkNFWjPRDrrS78Ez1s3hgpMVQeHt+
	 viBrj7TgmwsAmb2z7HwINHgLQCmjH2953q7ldVyVpwJOGnz8Un+MDOkRzfnzT8zbeRfLA
	 e/YDo3rvhONsB2E5YaHiKb3JZaw9UypZyuERJeoe7oNWItEtGa/M9RnFxO4qQ0GDGoCzk
	 Xg165GGAk2/HzO9/76RDMc1Y6bRBlD9CL0qzgmQKwWPWWaqm8OWPI07/Do1DQBAq7QsF2
	 Evsl26FEupc3A7sAiXmC6sVx+r5blEBSOYH24/C6jBpAdvgOXMZtohOQ75vSrZpHmdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h8Dk1roH;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7860A2601
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E7860A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h8Dk1roH
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b5e3b5daffso2031564b3a.2
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283722; x=1794888522; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuJECyUteBIYhk4zt7IpaezKNFcH3wE4eNPgkjkn+yw=;
        b=h8Dk1roHDN5x/T9udBtmR7oMNYERjsq8t2LvQ2QIRKt9d5gHzDRL1r8G1xlSYhybaA
         rqFO98Wo5NJwAJ10kfaiaFoXWjOybjJgE+JPWMIc/W33oZ6kfL6O7F3l2YyGDySbiGBO
         zvHKxM9QkcRHyn0fEEJv7/lxn97oMI4T7FNsUDac1H7fvpctBWRIwRo4NGNASNN0uA3x
         7E3/1MTB1UKPpFz38EinpXs+SBXB6DsKXTTGJJHVMlw8CPOjJQzhee8Ky74LRF0/VZjg
         zXB08oBHvCUPr6qP8qYdi2wx43pYuZ89ok7ut0yc8ENS1juEab/nMWJ39JuE4Ww/ZQJF
         91gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283722; x=1794888522;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuJECyUteBIYhk4zt7IpaezKNFcH3wE4eNPgkjkn+yw=;
        b=r8F4B7hcLmTsZ0hN+VP2On+Lu/veMMyz/Rt6rjKm86WbKiDe6R5GvZPtLh0nN99R0B
         v64bbN31+/V30VhhA6AZ2PCsA5mzFscX2szEm7WHPqWyAFI/OwOi6ZvAlj8pUU97XmPf
         kopq2Lb+siOqHf5JoBwLXTKBvhDaprED8lzS8GJf5V10/P8FqeC68+JBgZ3RS+0w9hcD
         Pt6muiEtqHluCi3JG8fnZpATi4m+hqdfXUrNR8y78GPx8D4yc839uSBhQ+CUlL1yJLVq
         KM5U9GwPmnkCK+343HokO5UGbwF6vBSEg2nhq2A4nUZutcD0IXHbXPyaIN9z5PZHiTkS
         ABBA==
X-Forwarded-Encrypted: i=1; AL+hErGSUzs4nKYtHUdaaMquXCLkwSeqMnRU01+PH8KntikxeEELjHqtcncosfB15cmyOr4+oVbrRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z94XIMKRlFctspfQg/oTbR6qVKwE8zp3799oPlxcg2tZsOSQE4o
	zSDRPQi1+YhDX9P73E8OMxkrnZnKRldPryexzRc/g2bv2CSdZGFE78ifmNzcZD0EvW4TD3hwQWV
	piVVi3ztopWjgDQ==
X-Received: from pgmn6.prod.google.com ([2002:a63:5c46:0:b0:cdb:91f4:387b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3b46:b0:3e2:a849:64bc with SMTP id adf61e73a8af0-3f18c1166aemr1076569637.9.1794283721794;
 Mon, 09 Nov 2026 20:08:41 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:15 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-10-skhawaja@google.com>
Subject: [PATCH v7 09/18] iommu/vt-d: Combine disable_dmar_iommu() and free_dmar_iommu()
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
2.56.0.506.g506a7eabc5-goog

