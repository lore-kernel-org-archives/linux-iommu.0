Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763C5C918
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTMbSBjR"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf3d102221so2919984276.1
        for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 21:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705038789; x=1705643589; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jQidOKSMiiXlthXl3syuEmjTW2A6fx8EoTn/KG4frI=;
        b=tTMbSBjRrP4IeDqQDUWRiMotQ1FDjzVruufNxCo8sKp3ZNj3JvbPf6naWAjsLA0l/l
         WHjlY4Yx5JXrlznksmmrgyUxj9jZNLV6ue9nNeQ7AgAslEH5aiR4HPU0Z04Baiqc0jME
         myJFRQCQA+EDba6UxPg2MyRfjx7H/tOjr4ZAJOZISZc8awpTDLS2NmbWUuPnPd48t/gi
         RvEaLmSilky8RXgsvzfaHuUGLJ47ZI6rpCK+/LHHZ48UiFIVNM1m1U8uSdu00prr8dvt
         UKawUhYJ1nWKX04VWfHFW0filn6F693KetEheJmhxW/XIF3CqdksZQv0nzBc9ZSOjtsX
         8IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038789; x=1705643589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jQidOKSMiiXlthXl3syuEmjTW2A6fx8EoTn/KG4frI=;
        b=uR9GZGcgIPGVcVNCSfXQm/n6IO8vpSEWHAXOzogcRrjzqpCssJi/MnH4qibjqtSFyi
         2GOtpfOajNS1AlqunceCHNLBhySW0cQr8At+uBGA9hgz5KBa0b5p8Mk25rCoEGJhuUuX
         /DXicdrMxZbRfBiAp1MX2bFvWJfYGqadL1+1UM845g/TAq8ljO6VsbI71OX6ZlkPHP67
         ZiJZPlyE1EGFK14Il9eZTCxsdiPa0ShtoCG9eo145lc1qe8a3fVM/wxSj0mxj0X2+sLE
         P1R9yv8h4qP4c2cmwJpbBEHuZWky74ovQX2ZFv/OQy1AF/miLrg1fLuPWJ0nduzpMdKF
         bl/A==
X-Gm-Message-State: AOJu0YyN2YgR/4BW1vccTXG6BkISA17DRTOuV5MDVt68845URoLLOMK/
	bGRxFgM/jc7sorgtQE1Y6UPX5Dgoflx8N89maMOMX18=
X-Google-Smtp-Source: AGHT+IHKtqhJvPuX99AmjEPzIekAgNij/RFYGidlE8shwCwScd2W0RcK+2eNPVzJk4tEIt4roua9lsBYL0xT4CjS
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a05:6902:168c:b0:dbd:4683:21da with
 SMTP id bx12-20020a056902168c00b00dbd468321damr154755ybb.8.1705038789001;
 Thu, 11 Jan 2024 21:53:09 -0800 (PST)
Date: Fri, 12 Jan 2024 05:52:49 +0000
In-Reply-To: <20240112055251.36101-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112055251.36101-4-vannapurve@google.com>
Subject: [RFC V1 3/5] x86: CVMs: Enable dynamic swiotlb by default for CVMs
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, rientjes@google.com, bgardon@google.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, peterx@redhat.com, 
	vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com, 
	michael.roth@amd.com, kirill@shutemov.name, thomas.lendacky@amd.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, bp@suse.de, 
	rostedt@goodmis.org, iommu@lists.linux.dev, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

CVMs used SWIOTLB for non-trusted IO using dma_map_* APIs. This series
will ensure that dma_alloc_* API to also allocate from SWIOTLB pools.
Initial size of SWIOTLB pool is decided using heuristics and has been
working with CVM usecases so far.

It's better to allow SWIOTLB to scale up on demand rather than keeping
the size fixed to avoid failures with possibly increased usage of
SWIOTLB with dma_alloc_* APIs allocating from SWIOTLB pools. This should
also help in future with more devices getting used from CVMs for
non-trusted IO.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1566748f16c4..035c8a022c4c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
 	select X86_MEM_ENCRYPT
 	select X86_MCE
 	select UNACCEPTED_MEMORY
+	select SWIOTLB_DYNAMIC
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
@@ -1534,6 +1535,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select UNACCEPTED_MEMORY
+	select SWIOTLB_DYNAMIC
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
-- 
2.43.0.275.g3460e3d667-goog

