Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACC221F06
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795599; cv=none; b=TIs5Aq6EnCYfyFzVwwnZRh8DOM2r7qfMeg7tie0ZjBJzBiEoXijtbODYHUI1NH9eHk0hklRWAuLf4gWPLUs/+bO1YO3eH4Znc9QCDmCrJrr9xBHTq+jy5pfUuvvCxTGcTOIcWSFLzrraQgsHcQUAtiXSly7eFjLDAtwNNSjQnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795599; c=relaxed/simple;
	bh=GCCtnDomY+lLuf5+xII3/z6zqPIPK391FSHfxII0HaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YOVolOtGNY7jsENa8vh5EVTJfAezLIF+MudJsCzn3JOeXKSWryl0RWA3Cv2dOZj3sIJ5krIRh8ghaL8mlL2C/zocdQMWYvjaB9afP1j9hFeTUQtshRMqsNMDlAAGhKdRLgNk/WCa8MNsvdgXZm9qE1ivAm0OOIDyL85kkuZqAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIpGuBvU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIpGuBvU"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso2397191a91.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795597; x=1744400397; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wBBmYaZBofsgLugSeNOxbYqcOo/hzEiN1pKLRJ98ixQ=;
        b=rIpGuBvUfoMuqxXxNwqkmAYFF/flrnekdgFzESnFGRrLyttleVtN4dp/DKPviS0EJO
         epUYZNaYGJZqBTNqwrxWKshHmFC4pbbkoBn8rOtXVscp0w9vqNWEjwOQlutMaLULx5CE
         fB38nT2rKofBkS/zDxkuJNc3VK2MzWSRL4TOA1WXYWS/RZiOwy3pyWVkCHG0wlzM6xcS
         VVbMznX62PQbjV5dbQRBih2UMIsgWx3YqQEFX/rYWoXFgz/xvak3k6m0Wab0LO7yKJtn
         ATJk5Pit0KO2Ij1fLFSICFpbJQaIEfzYRE4qANwM/jFH4vAO409oWIaiD0DcyAtYbJyV
         QyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795597; x=1744400397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBBmYaZBofsgLugSeNOxbYqcOo/hzEiN1pKLRJ98ixQ=;
        b=XKXSdGx4sw6d7WvfdUAE60j3pvzFm2jextEUSD9jd+gkuvIdLgypvsi+jNZv4fzFlR
         X1rlW9Kxe+HP6hqk/6UGi2WoHtXvYAgBEQRp6/S0LNzfv5ULPL2N5R+y148vbCftmoa1
         0C7f8+z0lIyBYlCI8taS8HfCHb8vNoqRg4EcF/t8vXpvgvfiI/liMCYCsmBo3UAtUb2n
         YSyvV5ARyupjhkyum00fg9eME2e32lgPvzTFJA74l/RFgpkw80BxG4J+S4adi8g5nuw2
         C24KSge+AKozClNVrwdkC0UxrP7mkTshd20RAHoNEBfiM3hFbMyNYVcrvK7D/mCYWRW7
         0Y5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtA0priCl0BK+/14u5E66nXsE2+l4mYEeeT/kaYZhOJGNb1Sj1JzKyBPkwjwW3ruLgoqitaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGDA/VRnH3Us/h1RxPgifyr3gdIckgmvIpLiaaUMQbUnoqiWp/
	0IuAUIvn4biWa0z0c6OqouTYJVBj9SUv21N01bzmaFEiqr6r6/YgDXWbki817cN3WH1hLNMfUoZ
	KYw==
X-Google-Smtp-Source: AGHT+IEBvDLqiwZ4BM4ogV2kWH9PVQzEHSq6D51X+1Q81b5CZqFohRw+cIfM1ejZIuAlzQtHAHcZOhjh9GM=
X-Received: from pjbhl5.prod.google.com ([2002:a17:90b:1345:b0:2ff:8471:8e53])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540f:b0:2ee:ab29:1a63
 with SMTP id 98e67ed59e1d1-306a611253fmr5033572a91.3.1743795597468; Fri, 04
 Apr 2025 12:39:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:21 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-7-seanjc@google.com>
Subject: [PATCH 06/67] iommu/amd: WARN if KVM attempts to set vCPU affinity
 without posted intrrupts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if KVM attempts to set vCPU affinity when posted interrupts aren't
enabled, as KVM shouldn't try to enable posting when they're unsupported,
and the IOMMU driver darn well should only advertise posting support when
AMD_IOMMU_GUEST_IR_VAPIC() is true.

Note, KVM consumes is_guest_mode only on success.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/iommu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b3a01b7757ee..4f69a37cf143 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3852,19 +3852,12 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	if (!dev_data || !dev_data->use_vapic)
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
+		return -EINVAL;
+
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
 
-	/* Note:
-	 * SVM tries to set up for VAPIC mode, but we are in
-	 * legacy mode. So, we force legacy mode instead.
-	 */
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)) {
-		pr_debug("%s: Fall back to using intr legacy remap\n",
-			 __func__);
-		pi_data->is_guest_mode = false;
-	}
-
 	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
 		ir_data->ga_root_ptr = (pi_data->base >> 12);
-- 
2.49.0.504.g3bcea36a83-goog

