Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF256188736
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008173; cv=none; b=a2NWUzXQ0bwEsWiXOg+HJqcdW9s49/zCXMy60EjPN4Z1nEIVFBTNnG6rg48wDeWS6ykaIABL+w6wyXnbiTWOWcwBxg/FUdAPQyB6DDvicMZo6DZpDJ+nhqGszE+GddlEMleZQhNbI43jd29N9+76JP0nNA2dBQZbhSyIcc1UD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008173; c=relaxed/simple;
	bh=sbIUUtbhKoqaRF1XiCfJiPMT1BQtiAUvE4BMli7XQLM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tLcT2sw84nLDbaseQWFpdPHTjOGZMEjQz239ZEp5gVzy/OCa+6aExspqRIT1TfyZHDrbD9vaUnSAFmWvrw9VC4q3150DHVD8FRtP2mRym0BpB+ci1LxKgFGiX6tFy5Mm/jB27WqYx4WAMtZFWPa+R008qash0ZqeUrx1Ooj+xGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVSTyA/M; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVSTyA/M"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso421062a91.0
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 20:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742008171; x=1742612971; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gak29tsjnPuV+z4b5bqPopzZmVyIubK7izsrv5a+gSo=;
        b=YVSTyA/Mgrd9UbagaUbo86UHlMzVmyOqvPRRhnj2f/RgT5+u+Db/PI2CoOmQN2+xbu
         6Jj8acZTnVBaJAAsAoxzJGv34GTZJDZNiqg/SS0lPt0nJrZC6p7OH1JxZ0qJmHwB9TGZ
         VDF2HVUIm70eGXmxt5A2Nxn8hgynnMf5zXomIvEOE6WxUhoXMOCXv2fHp8MTmNaNNoA4
         IURA2VTKbV8/tDoqav7bsKCU/Sv3HzW/pB2KCv6tN3321Gw52f9T9VvLFd2ML2yxUAz5
         Au7w41xVvv3XJ3cq/dOdU85HXH5amCoyJxq3eQNnD1Tc8PFCXkxDHs0ZpA/3LO133qmB
         DPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742008171; x=1742612971;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gak29tsjnPuV+z4b5bqPopzZmVyIubK7izsrv5a+gSo=;
        b=DU1xZ1ss2tdt3842o3UWsTKoYSrHn/LN/aB4W9oyN7GZFMoZ79in77l3+9DbVz+7X0
         TXBKvKZBJrglLME6lPMXiUg92ilCo0AuigGjp6KQzrtJtYdppeIQyFL4mU8Ven09tVSy
         WJV7YO/P/rAFRYfIg9FEd2HzufTDBD2VhteZhRtY3CjmW11TVsExOc5m/tjs3vWB6obA
         9GbH2NCaHgCpylimbfEars7i++Z9tuS7JsJvvTpoTYGcuV6EnzEihyPZ2gdsEV2vTahT
         bEBvEsdSNQRT28+xymYmQagr0eCJX5pdUu6jvWDLwehXDjr6Dcww62tcWj4sGY/chNdb
         cZzg==
X-Gm-Message-State: AOJu0Yzor7eNO6wVXRg4ZzCbsnWJclFPFibcmcuzY/un2cvWSjMbnuLK
	0ulGR6Twku+sspObP/IZazg7gN8rrvFmjbcgyvbOaa9ghfExkSvw8h6dwfLlkn/QZowfEJiXVPM
	YEQ==
X-Google-Smtp-Source: AGHT+IHARToxIR6VtRmzurSAC1xRmKsv9pkDNgIgaOjeWW+naTGMb+8yOvOGBklnWsF0Q5GPNfNOFHtDSVk=
X-Received: from pjbdy6.prod.google.com ([2002:a17:90b:6c6:b0:2f8:49ad:406c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec7:b0:2fa:2133:bc87
 with SMTP id 98e67ed59e1d1-30135eab48emr11511389a91.6.1742008170985; Fri, 14
 Mar 2025 20:09:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:09:28 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315030928.2373250-1-seanjc@google.com>
Subject: [PATCH] iommu/amd: Explicitly bail from enable_iommus_vapic() when in
 legacy mode
From: Sean Christopherson <seanjc@google.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Bail early from enable_iommus_vapic() if IOMMUs are configured for either
of the legacy modes, as it's absurdly difficult to see that
iommu_ga_log_enable() is guaranteed to fail because iommu_init_ga_log()
skips allocating the ga_log.

Opportunistically have iommu_ga_log_enable() WARN if it's called without
IOMMUs being configured to support AVIC/vAPIC.

Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/init.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cb536d372b12..05c568da589a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -931,8 +931,8 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 
 static int iommu_init_ga_log(struct amd_iommu *iommu)
 {
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
-		return 0;
+	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
+		return -EINVAL;
 
 	iommu->ga_log = iommu_alloc_pages(GFP_KERNEL, get_order(GA_LOG_SIZE));
 	if (!iommu->ga_log)
@@ -2863,8 +2863,10 @@ static void enable_iommus_vapic(void)
 			return;
 	}
 
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    !check_feature(FEATURE_GAM_VAPIC)) {
+	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
+		return;
+
+	if (!check_feature(FEATURE_GAM_VAPIC)) {
 		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
 		return;
 	}

base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
-- 
2.49.0.rc1.451.g8f38331e32-goog

