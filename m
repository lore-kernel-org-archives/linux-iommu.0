Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD4175D39
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 02:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007101; cv=none; b=dQn4CX3yG051e+haa8ks/0DyBOpwM3gemSGeUcO9ojVCfphmgxRHuCx7dltesfyTSN22HvV2cEGvy5UJyuoMBzmgji7BnPJM26NMtWjWXQoHQ9jfHfzeJKgDeapLiDYglxnufkismCzmC6KHBscKZfpc16P1VLsj6gGBvRHOErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007101; c=relaxed/simple;
	bh=KAU1WQksVUeLu8XbTbDNBIX6iR4oh10bUnf4hOkUiOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oxMKVjQVBOu7axA7HaUdFu2HZp854rjvvzpEW8GN7itdgLEEi4BsmqgaR2b5KAar+tBgJsr7d+P644o5Zyl/7tpWZJDc25Lq98JnezfSehWltMKlIOlGHRqCPPXdPfm1tOVbUT2W1V9ldznZV9A2ci+3gJD4mJH5p9IkbioSK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viVFOlPW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viVFOlPW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-300fefb8e05so371039a91.3
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 19:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742007099; x=1742611899; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6DdDweXZGONOQ8p3OcwX2GdBhyObwocdEvnBBogkzE0=;
        b=viVFOlPWo7Mod8nqjwJpPwrt+KA6eNG44BcS/DAaqXRoKg/3HPlh/2y28hR1cumq9+
         FLnFhj/VX5WXHHQn7qVBLrmKUcT69aQX+xe2DBuSv53s7e+CeHSeq5kd4bb4UuUbNa6K
         aiqENh14ifmvLQ4lv9/VyrzvodxvnXWYryXhY/O35dyR3ew8DhcJgaDKOQLskR/hHjqX
         lvHZdUWRqBKSrCu089JECI8dII6ogBdbc2/TZfyzSLAYLBYv3otD4nGYZHYs/4ZYzlXS
         L0A8InMWQrSKSsde/8Lp4HqAaTjNckZw+bIWdMyiA4ah9+7RiColPXm+25THEALwdNju
         7iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007099; x=1742611899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DdDweXZGONOQ8p3OcwX2GdBhyObwocdEvnBBogkzE0=;
        b=m5giBUutPexEOHFP90QLc+Oh6ClIpNaWQCwFbvNuhA5BMogRfI3phQns2RfIepLwfR
         5SnpcEsYt5kdvsdHOg9hpSHAkOmos+Fj7nha/3cCO6KVU4bYYnlz+LEMFADGnL5qSbEI
         pYdnYzCsXwEpjAQf6JPau90eaCW59CE9HgEym/UzYA2SSIjHr+JyL2SGw1RRQBZxnrOW
         9qA8qJ5sJbbAiXYPgOAFtyBjTL6w4siQ614iyB+DyslkKgkEuhxynobGOyLv/BqAI5Sh
         5mFR4kM0hPLV2AaFzwNSXa6FWNq5jR6l2yM/duUA1+KOHDV6VVUBsMBBVe+D3ulpJeOX
         Bs+g==
X-Gm-Message-State: AOJu0YzzNrJEoSuUM4Naj7vR6U/am6Mx4Vmvx5OjeJTGosocjoDpsdSl
	l6EQe9LNMl+1XTf+Rm1paaZRtmGJ73qEb436ElzNWqHIy7bvKz+mrg04XDpIk4JR3NHKrLzbJyT
	MNA==
X-Google-Smtp-Source: AGHT+IHNo1IQxVvQ7fJ3sdBQ5GhPKCquV+nBHWIdEDzmmDIqrRvXzmr7mYM7Qp/dU0xSCkO0TDf6GZHCMbY=
X-Received: from pjbmf4.prod.google.com ([2002:a17:90b:1844:b0:2ff:8471:8e53])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0b:b0:2ee:ee77:227c
 with SMTP id 98e67ed59e1d1-30151c9a3cfmr5571726a91.3.1742007099399; Fri, 14
 Mar 2025 19:51:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:51:34 -0700
In-Reply-To: <20250315025135.2365846-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250315025135.2365846-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315025135.2365846-2-seanjc@google.com>
Subject: [PATCH 1/2] iommu/vt-d: Put IRTE back into posted MSI mode if vCPU
 posting is disabled
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper to take care of reconfiguring an IRTE to deliver IRQs to the
host, i.e. not to a vCPU, and use the helper when an IRTE's vCPU affinity
is nullified, i.e. when KVM puts an IRTE back into "host" mode.  Because
posted MSIs use an ephemeral IRTE, using modify_irte() puts the IRTE into
full remapped mode, i.e. unintentionally disables posted MSIs on the IRQ.

Fixes: ed1e48ea4370 ("iommu/vt-d: Enable posted mode for device MSIs")
Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/intel/irq_remapping.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index ad795c772f21..c495b533103f 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1169,7 +1169,17 @@ static void intel_ir_reconfigure_irte_posted(struct irq_data *irqd)
 static inline void intel_ir_reconfigure_irte_posted(struct irq_data *irqd) {}
 #endif
 
-static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
+static void __intel_ir_reconfigure_irte(struct irq_data *irqd, bool force_host)
+{
+	struct intel_ir_data *ir_data = irqd->chip_data;
+
+	if (ir_data->irq_2_iommu.posted_msi)
+		intel_ir_reconfigure_irte_posted(irqd);
+	else if (force_host || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
+}
+
+static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force_host)
 {
 	struct intel_ir_data *ir_data = irqd->chip_data;
 	struct irte *irte = &ir_data->irte_entry;
@@ -1182,10 +1192,7 @@ static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 	irte->vector = cfg->vector;
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
 
-	if (ir_data->irq_2_iommu.posted_msi)
-		intel_ir_reconfigure_irte_posted(irqd);
-	else if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
-		modify_irte(&ir_data->irq_2_iommu, irte);
+	__intel_ir_reconfigure_irte(irqd, force_host);
 }
 
 /*
@@ -1240,7 +1247,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 
 	/* stop posting interrupts, back to the default mode */
 	if (!vcpu_pi_info) {
-		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
+		__intel_ir_reconfigure_irte(data, true);
 	} else {
 		struct irte irte_pi;
 
-- 
2.49.0.rc1.451.g8f38331e32-goog

