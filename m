Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07236A32
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008913; cv=none; b=LqS3F8YQMn7yEFe4QOzEgDvZS/co5zASuGDXjGxGH04fLeZEljC9MJkbvMCVWiCkH1c1ZarcbvqWq0Hu3+/aCEktTxWKmrG+uOsiRMTcW0q38eRd7bDFU27XCKFEVuuU6cmyBoR5UxAi9iNF6SITcqVE+3DRIm11q+kAiua+lpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008913; c=relaxed/simple;
	bh=58Kkdy1QlvdfBEuLJA2KBjrWGtga1wrtrRCSqTVz2ZY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i8+6e9aLQjjm1npD6rF+0lE2dDDMxwLMbzp9atuiqEs1AkfkbbptSW3+OLX7azBa3K+Jky4WTgK+X5rvpmhdlRVSjs94/6R9qchNBsP1wiFM9f6NwlzEtjzyGnHF7K0PPt3ybyBlUFHUkK/RcwTsgy30gViqfhGE9ZduR8cZYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+E1UU1O; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+E1UU1O"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso852779a91.1
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 20:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742008910; x=1742613710; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVCPNlPV716eA7La4uOIv6jwtGosj4v+uOcJZBxhxmM=;
        b=U+E1UU1OmYnQIPCctxb13OC+sop1XV7Gvi8H0aPXhhDsitue7Wu91NlTTdMmI42yOa
         9ZyM2MHksk0uzlogYOZjgzFNld3h4C1HFzrme6DIqLMnLAroXEsO/kTyymFtmD3lVW+t
         A8OsDmRHp3aMGN9KTyyHErocu02dbVRxoUnHXFp9/2+Bhu8OeViykw7btLmVG5FPwNwf
         Xx4YYLsONoFn2+zoQUIDVQoPjbgMufCA0xWeFfghzLVFPA06sENBtUqGYDzU5TvldmPL
         anACFRgfbpflFVtkqyppi9C7GtCfR3Gj3fAQtsbmw7pfoQ/VKtB6UfmRk2LpIX3bJWUl
         qL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742008910; x=1742613710;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVCPNlPV716eA7La4uOIv6jwtGosj4v+uOcJZBxhxmM=;
        b=BQs2M4oq5gZOqqflehFarqjoYz+X9VoE+QXyPvdKGcrOl6GH7VIkcwv7BoACmNB0qi
         GG5qMWJnyCPEhg+UXI87aCdyw9wycDERIxb+4aXvic6n3QXTH3AT/beiRUQwAxkaqN1q
         Ujfl6FUGopa8TB6dXVPPomBNGvTSZW0j2J3ydaqobeDhmc7+hlpVUN4bPceCb6ExdGdp
         BnwCyBkDPdEhAE3fWuXzOe714LsEWViRUALgwRv3r8/S5l1AKxnYakQOCcAdK4u4MrEi
         4W3ptWPNnuNxjIhV1mIJWrxse0KivM1u2QifZVYWT+RKdAAzhxz2BxM+ie0d+wshsp5i
         YbTg==
X-Gm-Message-State: AOJu0YxpNZH4dNGV3y0k4H9Cxz2wrG4NChabfteWYrh+C1QNKLOJ0jq/
	dVXDVW8yypZT7SoEHXBQtTqla11Vf45XEpq609an3qrBwd4Ki6OSW9xtS38v3RsywfV4QiBksml
	Mmw==
X-Google-Smtp-Source: AGHT+IGW8BzaRRhRtE1NpejkWAjQCEpQYH7Vd03oALl0yO1WNIEFXABlD9h6ktTlwxQxaDA8jNMrdESFAOo=
X-Received: from pjbpw13.prod.google.com ([2002:a17:90b:278d:b0:2fa:284f:adb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d64f:b0:2ff:69d4:6fe2
 with SMTP id 98e67ed59e1d1-30151cff09bmr6553454a91.16.1742008910387; Fri, 14
 Mar 2025 20:21:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:21:48 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315032148.2377902-1-seanjc@google.com>
Subject: [PATCH] iommu/amd: Fix a stale comment about which legacy mode is
 user visible
From: Sean Christopherson <seanjc@google.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Update a stale comment about which of the legacy modes is visible to the
user, i.e. can be forced via amd_iommu_intr=legacy.

Fixes: b74aa02d7a30 ("iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..f7877abd0091 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -968,12 +968,13 @@ static inline int get_hpet_devid(int id)
 }
 
 enum amd_iommu_intr_mode_type {
+	/*
+	 * The legacy format mode is not visible to users to prevent the user
+	 * from crashing x2APIC systems, which for all intents and purposes
+	 * require 128-bit IRTEs.   The legacy format will be forced as needed
+	 * when hardware doesn't support 128-bit IRTEs.
+	 */
 	AMD_IOMMU_GUEST_IR_LEGACY,
-
-	/* This mode is not visible to users. It is used when
-	 * we cannot fully enable vAPIC and fallback to only support
-	 * legacy interrupt remapping via 128-bit IRTE.
-	 */
 	AMD_IOMMU_GUEST_IR_LEGACY_GA,
 	AMD_IOMMU_GUEST_IR_VAPIC,
 };

base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
-- 
2.49.0.rc1.451.g8f38331e32-goog

