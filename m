Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448D5C902
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMBBnmid"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso93574307b3.3
        for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 21:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705038792; x=1705643592; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sOaEOFbZAWEH5Yjsdlubc01KHjJyWCBCS9BwuOvGQrw=;
        b=OMBBnmidRSKd604FeeS6yEz1teM/sUV2BpSe6VKPsw9wKUHNHTln2uZlmFIldbUFv2
         tmzqxMWeh8ZEjPWN6DspRe6Fsd6Fy0A1snPtlEOcQ90jSZ8QeMZQZ0Q7nDfbBm2ZaCtJ
         cW88G/E71X3vN+CCXzOppIL6U0ik/z+IZEyKapv2Q9/rtafgb1YpV1AfVTdNKDIm197C
         Wu3SG5U5oVbKWXoRmfFeDjHd/3NNAE7Nhnf8GRI3m5Op/8QA7xlFvLljiPM3M8h0eP1v
         97rXqcxI8s8q8IOY/GDSaJ33fHj7lAjruIZhP1hM5A2J5uJ2Ug9N9saEPnFKM6YNa0qu
         xKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038792; x=1705643592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOaEOFbZAWEH5Yjsdlubc01KHjJyWCBCS9BwuOvGQrw=;
        b=wWE8p3qg+rZNo1vuzgL61M3rDcl1zzdCDJIYcc2Z+y60DvemCgA26A9uDuTJIDsUzX
         JKAWuiTauBbemEJoG6Ctu9Pbh15oTNrdIavX1xiobCpB5Rjwwwoypchm3HFj15gOvghs
         PGmEETWGMQsxxmM/HoJB2VeFIFUD1MhY9rKKMAkyZLNvRXjSTpsPVh2vuOwOrpMV28YK
         MIzdPu0x9afWFQ4qqanoTVttrEIEftxGDLD2q57b8xWO8H/kewtccQN1X4Q/hV+BI+hM
         n6/AMq2i+fTgaNN63pTvssMNtNUw3vCZqX45HSyiV33fOCXkOrhvrMQ2GCz0EHeQVkm1
         1kYA==
X-Gm-Message-State: AOJu0YzIduTAyoZZ1U4aMfY9RX/j1YJYuMfzgrBZ76w3xI4BoG1exmW6
	HbI18pR7u/66n6yHIZ/mHdg26DIgNDzrWIgvPD4l0YQ=
X-Google-Smtp-Source: AGHT+IGaBbJ5M4pHi7k+543Q/p59waeE7UFHvcz2IdcmC08A81gveyAh20QzVYUNlkq6+5OlavoIfF0F2/qyiJ/k
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a81:7102:0:b0:5fb:914f:207a with SMTP
 id m2-20020a817102000000b005fb914f207amr352561ywc.6.1705038791836; Thu, 11
 Jan 2024 21:53:11 -0800 (PST)
Date: Fri, 12 Jan 2024 05:52:50 +0000
In-Reply-To: <20240112055251.36101-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112055251.36101-5-vannapurve@google.com>
Subject: [RFC V1 4/5] x86: CVMs: Allow allocating all DMA memory from SWIOTLB
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

Changes include:
1) Allocate all DMA memory from SWIOTLB buffers.
2) Increase the size of SWIOTLB region to accommodate dma_alloc_*
   invocations.
3) Align SWIOLTB regions to 2M size.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/kernel/pci-dma.c | 2 +-
 arch/x86/mm/mem_encrypt.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index f323d83e40a7..3dcc3104b2a8 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -61,7 +61,7 @@ static void __init pci_swiotlb_detect(void)
 	 */
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		x86_swiotlb_enable = true;
-		x86_swiotlb_flags |= SWIOTLB_FORCE;
+		x86_swiotlb_flags |= (SWIOTLB_FORCE | SWIOTLB_ALLOC);
 	}
 }
 #else
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c290c55b632b..0cf3365b051f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -112,10 +112,14 @@ void __init mem_encrypt_setup_arch(void)
 	 * The percentage of guest memory used here for SWIOTLB buffers
 	 * is more of an approximation of the static adjustment which
 	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+	 *
+	 * Extra 2% is added to accommodate the requirement of DMA allocations
+	 * done using dma_alloc_* APIs.
 	 */
-	size = total_mem * 6 / 100;
-	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	size = total_mem * 8 / 100;
+	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, (SZ_1G + SZ_256M));
 	swiotlb_adjust_size(size);
+	swiotlb_adjust_alignment(SZ_2M);
 
 	/* Set restricted memory access for virtio. */
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
-- 
2.43.0.275.g3460e3d667-goog

