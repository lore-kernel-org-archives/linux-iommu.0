Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46A17BED0
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008252; cv=none; b=ef5Yy6eSUnrzTre1FO4wuNmPP67t/yoEsdwEpyA2jON5+KENbdk7Mu9y9v3Mq+pXyCqLFJiGQVThXXUeM929U37UiotqnFsPYum9JswtQfJsPz2R+MHQdP4M0AO/hwAKD+b4mAnDopHcEEMFnf1HWLzlyWu4IfedgBnEqLA0csU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008252; c=relaxed/simple;
	bh=OLizbiH//ZIur3H0hcedWvPa4Ex9i8tuAXKdIf0Ss7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jZLlIC4r/6vpkqlzU0eUp3bMZ1RIaFPwj0ipC+c0KBVXPdLgOoSNTNwVC5nc4Y5P26MrXg/1WwPGc6U23LGCSuhwiN8DGyZ5jupA4rZW1m7UvZhYX07hj2kUgYSPk9blJ0R/XaIx8eSW9s42eHl39Ue5J6xmJb/dLAYJTuvTGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJqyHRfI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJqyHRfI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224347aef79so46645735ad.2
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742008250; x=1742613050; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7gds+58q6+VRF9HZlaEhINqjYzInTmh9/a/W9pln2U=;
        b=WJqyHRfItpObObuKbINx2SncTUEC6i5ztEyTAyrHJa7agTuyL6ds/jpjG+rnpOHl4R
         v0GkihLCcwcMpfKAwDezcps9+hk2w84z406aifUHbAhvO40q90Isf2suys21IVwd4Nhx
         QnGI72X8qCNRL6c3GJ+KBvKFGdQN9Co+n5II5lpYanBAOvvI015NCzshxwnZYpAOiTJ5
         vIXkFrrJvs7CDa5I8C0S4CwpZ/blF+4yMSQET9JxcxgDZS9g/HNYp2qOUU9zjqhf/BoJ
         fzwqAIqrV2qBiL/cPIcHA2Jr2MrjWpzxK3mGKBMIXWd+Pk3rFtevRw0VkOrpSLc2cj48
         RVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742008250; x=1742613050;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7gds+58q6+VRF9HZlaEhINqjYzInTmh9/a/W9pln2U=;
        b=FK+Z1QUfvKKXqIhxP9hdqIzBNnP9H+7ky2qOexskxnIGsz9K2gmWCF6f1ZaDAVP8TS
         axmCYMGgv/+U+pEDDYofxcNu0Xr6CW0tmzHCDP28uLF8eWP8VEM4j7b7FHJY72tFrdwE
         7SWtC1qRgWsymT7RjjV0NzykV1OYtr8WhwLSuRg2Ne+3855ye/xEOILBHzphisJzqmqG
         Hs/7tPdJ9VdAkPtaz+3p48q/fZwzc9hSySUo2mZAHDMqg6NQPwGs/pyzRFRtoekIDPKI
         psSZGfuvmSM3YGqyVKvyz3+XBI24cg//rnpTGSxP45Rk6jmvQU3S8HSfKFUfBWckD8UK
         50xQ==
X-Gm-Message-State: AOJu0YzLC0dYFuQO+jkWnKGRi+K9gbpYcwPhZtWh2I01PDp4guNH9j12
	RwSvtsONADYz2JJh4ezO0t19lLq+j3r9kkrZcm9vhEXqj4jaYLIfJKQn+E7uN9ozdx/zHbT0l7D
	4aQ==
X-Google-Smtp-Source: AGHT+IH7AfjlFM7Z9PNPtzJaUSCYK7f83WWLXt8NM7UXP61+YAys7SZHeLCK+pprtrBAnSdJ0yquC3LZQhQ=
X-Received: from pjwx4.prod.google.com ([2002:a17:90a:c2c4:b0:2f5:63a:4513])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b6d:b0:223:fd7f:2752
 with SMTP id d9443c01a7336-225e0a954abmr60595725ad.29.1742008250480; Fri, 14
 Mar 2025 20:10:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 20:10:48 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315031048.2374109-1-seanjc@google.com>
Subject: [PATCH] iommu/amd: Ensure GA log notifier callbacks finish running
 before module unload
From: Sean Christopherson <seanjc@google.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Synchronize RCU when unregistering KVM's GA log notifier to ensure all
in-flight interrupt handlers complete before KVM-the module is unloaded.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b48a72bd7b23..b314523d9194 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -982,6 +982,14 @@ int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 {
 	iommu_ga_log_notifier = notifier;
 
+	/*
+	 * Ensure all in-flight IRQ handlers run to completion before returning
+	 * to the caller, e.g. to ensure module code isn't unloaded while it's
+	 * being executed in the IRQ handler.
+	 */
+	if (!notifier)
+		synchronize_rcu();
+
 	return 0;
 }
 EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);

base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
-- 
2.49.0.rc1.451.g8f38331e32-goog

