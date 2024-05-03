Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F592C6AE
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761333; cv=none; b=MIG0lCSADMNW0/sdTreFvZZw/ArQMbNLtww4NtbEboHCfm9AKalxszQbVCwDTxl3813+QhgeS+onvs8jkGe1uvPCn2VnIBPyv90LlEtzALAip1vhbZ46KX6yXjDWZ80skR6F3eWCMnBxheywEbKpi5xqV5Ie92Rgwqv2pdfKkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761333; c=relaxed/simple;
	bh=lctBDKKbaQ0GP8xmsQpbPsTnN5YakI/d7YGn9gn3TMU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OZILFjt73CM+qi6gdIhz6mWc9Weu5R25M1hp04UXM5+7BWZdG7sMtDgFW5qgFc5VmqscywdlRmlw5b9DFZ+T5CeWD9X9WoHcTkJcEYCW4gtSJanrBLshz0uU5Pu9+mLxofdFq2qrH5LAXxO7CDHN5yntjiW0aiFcSktx/goUMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzQV6Vvy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzQV6Vvy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec5efb0a33so37305985ad.3
        for <iommu@lists.linux.dev>; Fri, 03 May 2024 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714761332; x=1715366132; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iVQp8VZ+GT1btk34Ge4A/qMobcmdU0dr1U1FJvarTM0=;
        b=tzQV6VvyQ8aBhQhsek16Mx3eeAOFxAH8BLC1nxph7fa+2/igd440ROuYlkZ61iuQLV
         YOO7THZz88cqlOnyS36E4tMimMH57mXScZxYdgIcgN8i8b6EUEjGySWcHfYnPLAe84kD
         9W7HxIOwA+YFtpyC2h3kY7ZZupLSljP8gb6Cis7awu2H3+mV73tMSdGODD42s45NJiTG
         0lMTsiss0papHzhdCi42YI90uErJ8fTaahKM+0tvtFDyofnCAA7U26N8WJ+vHJ62t+fY
         sWukZQsc5WiQMvb0AmS+O0qyXcp9z5ioKW3eWib8gQgksHgZV5BPzjgH9Ctmhg4QJFWu
         YGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761332; x=1715366132;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVQp8VZ+GT1btk34Ge4A/qMobcmdU0dr1U1FJvarTM0=;
        b=ZLFedTFE170yjucT0YS2kRCsPYpNXLcUxjDvuiIpN3eAkoNSvbu331HQJKS5tPXFYQ
         BDDhCldYicB+VMUvmTHmPtxYe8bRUimBfGObN0uXTGajQpc+FB4fRKd6Itc3CFplr3hk
         SjTKlEmido9Z5UM0oKE5hskmxUttZ9pjLfhl/s1sZCVJJ/vEDzJ3ZTxQfNELg1yAR1rS
         fzvmSw59jSCZFOX5eSeF0DTz3vIqF0bbokqFtWxQbtDvfy2567zf1X0l8W4hfXTDJdS1
         YoCLsiAmYFd6kdQ9AwnzlejL4sUPwU2IMVe0pMuqeYN4mlVhdj/A13YrThNko1dTxhOv
         6GfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvSgBFaB/Rl7XyXub7SR5ScYyko/uqfwZ4U6dW5EnUo797HaeCqg9aYe9kA4uyPaqBXBoQx9gN8OZOkGh9MWyVE3Li+oQ=
X-Gm-Message-State: AOJu0YxmxsKqb8zr3Az236zBRuBLpvhtHLbkVjCNRx9YcttBcW/QsfSA
	Hb/G3IGhk18faHHslYhVrn5aGM6ErvpxF+QcRit6SR3/159aQRVeDbVahuCkFUGFA2RXFNQUPNP
	XhSktVnhz5T5u5A==
X-Google-Smtp-Source: AGHT+IH43Mgk2bJwNZrlwDJzmhbx9udVERtQckuEWb3sCigBB6T1dsjzWtnv29QEOO5n0WToIxr27/3AIGcP6sU=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a17:902:f94b:b0:1e8:a7fb:c1fc with SMTP
 id kx11-20020a170902f94b00b001e8a7fbc1fcmr7948plb.5.1714761331746; Fri, 03
 May 2024 11:35:31 -0700 (PDT)
Date: Fri,  3 May 2024 18:35:26 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503183527.1548119-1-tjmercier@google.com>
Subject: [PATCH] swiotlb: iommu/dma: Clarify swiotlb options apply only to dma-direct
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: hch@infradead.org, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	akpm@linux-foundation.org, isaacmanjarres@google.com, iommu@lists.linux.dev, 
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

The swiotlb kernel command line parameter does not impact IOMMU related
use of SWIOTLB, and that is intentional. IOMMUs cannot be forced to use
SWIOTLB for all buffers. Update the documentation for the swiotlb
parameter to clarify that SWIOTLB use can only be forced in scenarios
where an IOMMU is not involved.

[1] https://lore.kernel.org/all/20230612153201.554742-16-catalin.marinas@arm.com
[2] https://lore.kernel.org/all/20190906061452.30791-1-baolu.lu@linux.intel.com/
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 Documentation/arch/x86/x86_64/boot-options.rst  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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
index 137432d34109..066b4bc81583 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -285,7 +285,7 @@ iommu options only relevant to the AMD GART hardware IOMMU:
       Always panic when IOMMU overflows.
 
 iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
-implementation:
+implementation where a hardware IOMMU is not involved:
 
     swiotlb=<slots>[,force,noforce]
       <slots>
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

