Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FB234977
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795659; cv=none; b=oMPypVogYbrsME8i4eyMwU5+J+bk50tQ4KCFGjodiZ/7I/h3LvKcnA3gQJqflnNsHpZ9eHbOatG6Z1Iv6IZB927U1YqRedHWeViEdUl8SnaTJ8xL8HKnYtFC3ar0IDeS5aJHTcG0Hi2CUZ+769SZKF+QMJJhMSivLCOrnL1AwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795659; c=relaxed/simple;
	bh=qRJSMg/wJdVt+yvoikFVSNe2Xy3I3T24yQmnIrUC1yE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C8yC4pZXIDF6tCXwI9iS2299oWDT4r+P7r/glJIn6BfQ6GYjcUbQg5MkpAurn/THEYHHwCukWtsCA2cI40uUz4fw5t055OTmz1RhxsVuH7esxpQv2h9mPvwf6lbeZ0Tkbt3yJQ934vimxDQJdJ/OocowoB/PDiBt+WAV0dEYIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjitdrEw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjitdrEw"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af972dd0cd6so1649093a12.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795657; x=1744400457; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kz4x5Upf+TkOuVEZrNth6TOEjNFtX/45/lAAaTZzYMc=;
        b=SjitdrEwtDctWPcgNFlUp6Bsz28VoZ+ge4B7K+I/cLkZlkt3XZUmNOpdhl38MPzVTj
         8Xj6eSMAb6T4tNY532AIAX+ctZ40yMHtwskwsWw7GJjLIiVdjHoeAZTdZ61qhXNTG6td
         jv+o24lWBOVwc+cqgOnmB3SKugi03C5FTwJ0xh7L1va9zAwudBoGRBnhR3ovUQ+TA14P
         244UagsyBVFgDnmDfp/tTyCxBf0uiGgsdselDbdl8jvTdjp0dTExSIN6WEvS5lapquQR
         uH4YzGzOyDjDVpnqvd9EaBPZolICwYV3wSD3FiVXYVvUA1/D1VpnkElAFkh1RNmTS9kH
         /aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795657; x=1744400457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kz4x5Upf+TkOuVEZrNth6TOEjNFtX/45/lAAaTZzYMc=;
        b=DTxUv+Si9rkDzlxbHqIyJze2KP4m0jsHgoa7GSGnZD+siwShxyIaHENCL0TT0G0Zyj
         hvNhf0kkf8bDYxK6TkYjUuTy3oxUo3JTFzU+DBAYcaZ9ts9YSR3gm6nIaYcKsz0onCcT
         F6I3BxDlC+ly6eYHv3Uw7rsFIzzzFQx1lYrwOvUrx4cW+LDFby+0uaNvMA5lV9T0hwZ4
         C0a4rClMI5wTZjTdwXI2jT/BERwTj0/FaHjg3gpegFE/27Wu8U81ii9Hfs3lgSerr3Iz
         IPf1SeAUzn7Mm6S/DvWknqInq30HNUKbS5njWbAucPdbWRp42XG5w66ZtFD6bK6KTrAO
         BWkg==
X-Forwarded-Encrypted: i=1; AJvYcCXk2Xvr1vB/jj0G60fbTlKjWgzfOWxrQBlPFzlgfA6v5gaRBimVd5LTbzv0ztBD1+OunrXNXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnbOOkdUSbRNPBp9YyPvGyO7nlcQ+7jLkCtl4EXnAyRUSHN1ua
	zn++28IOafcJkiyLABdMwfN0WwwwKjB4GNjDT37sj6zlBEGsmyhrrztf1tqWVN1dfCI1XbwOY8x
	Eeg==
X-Google-Smtp-Source: AGHT+IHkLFUYrRFyJCAgYTx0bID7tXQUTRqySewXCzFOP3XCxELB+3z+iKZV1p70EJLDf5uCBKxj0CFwan0=
X-Received: from pfxa13.prod.google.com ([2002:a05:6a00:1d0d:b0:736:a68b:88f8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8d:b0:1f5:93b1:6a58
 with SMTP id adf61e73a8af0-20107eacc49mr5032422637.8.1743795657302; Fri, 04
 Apr 2025 12:40:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:56 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-42-seanjc@google.com>
Subject: [PATCH 41/67] KVM: x86: Don't update IRTE entries when old and new
 routes were !MSI
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Skip the entirety of IRTE updates on a GSI routing change if neither the
old nor the new routing is for an MSI, i.e. if the neither routing setup
allows for posting to a vCPU.  If the IRTE isn't already host controlled,
KVM has bigger problems.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8325a908fa25..0dc3b45cb664 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13678,6 +13678,10 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 				   struct kvm_kernel_irq_routing_entry *old,
 				   struct kvm_kernel_irq_routing_entry *new)
 {
+	if (new->type != KVM_IRQ_ROUTING_MSI &&
+	    old->type != KVM_IRQ_ROUTING_MSI)
+		return;
+
 	if (old->type == KVM_IRQ_ROUTING_MSI &&
 	    new->type == KVM_IRQ_ROUTING_MSI &&
 	    !memcmp(&old->msi, &new->msi, sizeof(new->msi)))
-- 
2.49.0.504.g3bcea36a83-goog

