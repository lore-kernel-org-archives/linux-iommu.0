Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74013DDB6
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967495; cv=none; b=np+Z/l1S5m69b8zaeiJNOxyEEdVfh/sxiPWHNJo6fdC7nFx0YWHU3ISk3y4xGB3HC3vuQA5rl4/gad6K6Rg/eYdmmPZccTT4+sM/wOc9nWpCncSz2HLjILgD5x1YuLrHw8LYkC09TQMSqEi2djDBkVu2Zxhwp9wniC9lYb6La+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967495; c=relaxed/simple;
	bh=BY/hZo13CLwFiuLGXW4iBxh7QnHKbF0uMbcvEEfu4u8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BwEAlB0sVODNl+E0tvawUtL3xIwDgBc8rMJ+5wpYG0twyIt4bACDMo7G5sN2B/n74rGUEWfETPTz8ZyOJYMnUQLUzuFCGU0h1y+bl+q1F5k8NMsc4b9qHFL9aNHoniJg6UepiZ8Oc/8Ft2UsxwzVbYPxUN+4nr3zIakR5RwTHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ia3q3hAw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ia3q3hAw"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ba04ab5e2cso2518804a91.1
        for <iommu@lists.linux.dev>; Fri, 17 May 2024 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967493; x=1716572293; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jzuhfQ6w0AXMfOQGLEmaZLyI3U2s6W3AD5J7+WG1xGA=;
        b=ia3q3hAwmbxVJS7qvSfIDDI/TebkQNg1kctKNTyQQjCCRx9GUGlOh/fqN6I+gO9G38
         qWnjSuCdkIHKQB1KK5uwPBSPQj+/ESSDNo/ehBY4gsuz5lVPs5qBYtdC9yM+pi0si5c3
         XSECAaea2qINtq/UhaFyCL2IpI1BmrF7QX4tXzvnhvf1AZqYJwskTkB4eFVAds/tjr3f
         gHv9d3b5xSrF+fXgTo0cSoM7RIipiFLX8U1qTCa3UU9DgS9vSR0m96XI9LuXQRs7epKO
         YJ288LfzyunWD2hOC628VtDbSYkaORAVzrLH60BKIicfu5G8L/HtcjntXTSPUfu17f2z
         Wx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967493; x=1716572293;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzuhfQ6w0AXMfOQGLEmaZLyI3U2s6W3AD5J7+WG1xGA=;
        b=K4VxzHYnJM+luuOXAtk2odjUTWcsjG5/12Gnx3ZZgh3/sfQvnzL7vTazwepz42NnR5
         oX6FzWhy9p1UjWo/xg4o68h/JqfSz4EjvpajN5Kl/y97LcyA6SaUdscNhMdoA3WHDZye
         ZKRYZOn5ifi2pcFtyWdliVJABLPIKaf0q9jQsFYxi0GL5i3csBW5gEsXqh0JRZVcHlCF
         OAeRG44ZdFAeJUqTrQ5x5TB6I4QiTvyyFfsjRrsk2x8K0MpUvgiWEmd6KR09M22Rvvb4
         ZVoLUTPMkTf5ZB/BcpGc7iDjhqvResTnZyHY4B2nGXAOFI0/XSiHZ1MnatFKTcPnTRPr
         7xfw==
X-Gm-Message-State: AOJu0YwTD7LhpBX+PifaxcdwKOldLlJ2+s/2LdUsDtStqFJAtILQh5GG
	FzQ1OJoPY142wMYNcI5S8cZTzNSEuNr+uYWAUEeUGtQ1Qk/DIsRTeWav9WI8NJYAv19LCKxJldB
	MzSb/ZkhVW3tugA==
X-Google-Smtp-Source: AGHT+IEcSEnhlabGL3MljAexrvTLovRHSHspelEweE+rv/3eEDJNx1P5eiOiDLgxiAyFBGGJIPp91LWn/mkrckE=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a17:90b:2341:b0:2b9:df61:c002 with SMTP
 id 98e67ed59e1d1-2b9df61c049mr21973a91.3.1715967492100; Fri, 17 May 2024
 10:38:12 -0700 (PDT)
Date: Fri, 17 May 2024 17:38:02 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240517173805.4181349-1-tjmercier@google.com>
Subject: [PATCH v3 1/2] doc: swiotlb: iommu/dma: Clarify swiotlb=force option
 applies only to dma-direct
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: iommu@lists.linux.dev, isaacmanjarres@google.com, robin.murphy@arm.com, 
	will@kernel.org, joro@8bytes.org, Petr Tesarik <petr@tesarici.cz>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

IOMMU implementations now sometimes bounce memory through SWIOTLB to
achieve cacheline alignment [1], or prevent DMA attacks by untrusted
devices [2]. These uses of SWIOTLB differ conceptually from historical
use which was a solution to the problem of device addressing
limitations that prevent DMA to some portion of system memory
(typically beyond 4 GiB). IOMMUs also solve the problem of device
addressing limitations and therefore eliminate the need for SWIOTLB for
that purpose. However as mentioned, IOMMUs can use SWIOTLB for other
purposes.

The swiotlb=force kernel command line parameter does not impact IOMMU
related use of SWIOTLB, and that is intentional. IOMMUs cannot be forced
to use SWIOTLB for all buffers. Update the documentation for the swiotlb
parameter to clarify that SWIOTLB use can only be forced in scenarios
where an IOMMU is not involved.

[1] https://lore.kernel.org/all/20230612153201.554742-16-catalin.marinas@arm.com
[2] https://lore.kernel.org/all/20190906061452.30791-1-baolu.lu@linux.intel.com/
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Reviewed-by: Petr Tesarik <petr@tesarici.cz>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 Documentation/arch/x86/x86_64/boot-options.rst  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 213d0719e2b7..84c582ac246c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6486,6 +6486,7 @@
 				 to a power of 2.
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
+			         where a hardware IOMMU is not involved
 			noforce -- Never use bounce buffers (for debugging)
 
 	switches=	[HW,M68k,EARLY]
diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index 137432d34109..a37139d1752f 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -292,6 +292,9 @@ implementation:
         Prereserve that many 2K slots for the software IO bounce buffering.
       force
         Force all IO through the software TLB.
+        Hardware IOMMU implementations can use SWIOTLB bounce buffering in
+        some circumstances, but they cannot be forced to always use them, so
+        this option only has an effect when no hardware IOMMU is involved.
       noforce
         Do not initialize the software TLB.
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

