Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD633CA4A3
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591739; cv=none; b=F4ifSEm7wgPVyQu7D7nPPsjaArgSWjvAPqXHlGfcs2JsTPdSksSU0l9JqdfQFI3cjQI/p9rjZfucHUZoade43FFaajY6gu7dyGcM9kQ3mR/BdqG3/m1+LIyhOrsPe09bYqPOpack5tuMiJzcuI01yQYpotGalIMOcqoSGBsoZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591739; c=relaxed/simple;
	bh=05e4kCmh5d4jmhjGWrDP68fi2cOhrwkmP/2S+lC/vVc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G0hMPNfOCfyjUzeZ+WO4T602KVpiSfrnx7RffyU3t1bCP77oUGaC5nRI5v1lRE5eZgexA0Od9N8PE1Tz05psOJ+z8FAn4jnh4kF67DPJkk8HlZr6+VaPpzitLElvemyhvSBwN1PXC90kN9U45o/8PSQ3gCjZaLHRUfPw5+DZPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDXzWaOA; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDXzWaOA"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c87ba0890so7399202c88.0
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777591737; x=1778196537; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J7V+aJczrYa+luWKSbD/4vJrKAK9nvJvKMYrb9vqHfk=;
        b=VDXzWaOAE4OU1Ez11gj2d98RLkdRKFm1pUVyR+gP06Qx9ryRkamQc4+DpecuyyxPF/
         H9wAT7R3N7bLh89H/a7gNgDPAmPcIAoxn1DMgB2d+uT9lgoM24XeIFtan14MXxkAmarA
         FWViZ6mivqkEJonjtaeiFfm70sabgHOK1f515deBoL/egGKw4z9nw/UoOIHkSe8h6avJ
         eklkYuP4fL4Sp6zzh0+qV9SMbwZxywKW3v2r1RD6/8OBQJlJ5I3jIepSebiUMopuUcWw
         Mn8Yne967e8s/gHElhpREfJ4gz36h2d/HM6GnNlM7wguaE2OeL2YO+2AEffIHAdaCsJn
         G1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591737; x=1778196537;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7V+aJczrYa+luWKSbD/4vJrKAK9nvJvKMYrb9vqHfk=;
        b=Y40igrnbR9grjk+D70ODkocXgfmoODDpXPCZwiV9IGZZX/0HAhTwiCnY+hguYZdxmm
         nmy1Y23C5zEv/x3YjuzPQE9kXC7EAgamdnu14xTQIe71UBXuVWcqYfjV5Lpbwf/UtO1e
         +mQg6YKgUw/Tepch1JQJ6T2kDNIxmMT8+lQcxfRuyl4eAg6Uy5ynsao9WDlCPP+Af3g0
         YYEAUdEfnWIHe2Iu/1VOIJerbG5v9I5kqOytOMDpMZu9sJXWObZdRw2lc5Rc/2kNSdxC
         h4Bo0F50aRJxY1w1hojXZdnYXo+IjCUfupPQgPxdrRCEEMHvfwjSgk2EBo/itejOC4Zc
         sd4g==
X-Gm-Message-State: AOJu0YwvkI2lF2knv4GM57u1Cqm/oUT7KIEwN72+0LKHEkJjM0GtXnkX
	TioBjY7x15chQpW7WbqLQc9qVTVDNpTkbFD7GUns2IBQ31K7X/murkrtWhErfYuewRxdgV7T3s0
	ZgtH7lcvLp1+Zi1N2X9IcrWnhoYOXk8NOtrAUY14pTdQK9EvgUA77V1UolAwaDxriBFNRjMzeLp
	exhi81LOQTRdxj9YBSnYYHQib5QnPrjQ==
X-Received: from dldnz3.prod.google.com ([2002:a05:701a:ca03:b0:12d:bd4b:5b09])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:985:b0:12d:b7e5:a691
 with SMTP id a92af1059eb24-12df822905emr291576c88.7.1777591736300; Thu, 30
 Apr 2026 16:28:56 -0700 (PDT)
Date: Thu, 30 Apr 2026 23:28:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430232851.236666-1-wnliu@google.com>
Subject: [PATCH] iommu/amd: Fix precedence order in set_dte_passthrough()
From: Weinan Liu <wnliu@google.com>
To: iommu@lists.linux.dev, jgg@nvidia.com, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com
Cc: will@kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	robin.murphy@arm.com, vasant.hegde@amd.com, santosh.shukla@amd.com, 
	chrisl@kernel.org, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"

Bitwise OR | operator has a higher precedence than the ternary ?:
operatior. It will be incorrectly evaluated as:

new->data[1] |= (FIELD_PREP(...) | dev_data->ats_enabled) ? DTE_FLAG_IOTLB : 0;

Wrap the conditional operation in parentheses to enforce the
correct evaluation order.

Fixes: 93eee2a49c1b ("iommu/amd: Refactor logic to program the host page table in DTE")
Signed-off-by: Weinan Liu <wnliu@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 01171361f9bc..ccffbecb15c2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2149,7 +2149,8 @@ static void set_dte_passthrough(struct iommu_dev_data *dev_data,
 	new->data[0] |= DTE_FLAG_TV | DTE_FLAG_IR | DTE_FLAG_IW;
 
 	new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, domain->id) |
-			(dev_data->ats_enabled) ? DTE_FLAG_IOTLB : 0;
+			(dev_data->ats_enabled ? DTE_FLAG_IOTLB : 0);
+
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
-- 
2.54.0.545.g6539524ca2-goog

