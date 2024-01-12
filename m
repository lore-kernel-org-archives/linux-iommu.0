Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26415D757
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VShIcEp3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f8ffd9fb8aso76657177b3.3
        for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 21:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705038795; x=1705643595; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxvkESmzviEYCBtp91snCvTXp4bYwC2oMLMP2RAwiuA=;
        b=VShIcEp3yLk+3VgVx/xoZ5gkzhmHt85bIsmbVvwdAQlAqUVcaxOPMxFIB3UUIb1DOA
         bwDKOcfZ0rAqxTCfsE6WunpW9zA1OrL7VLQeT1i88CDfgE8Ak7fI+ynTfjTq0NiB2X3J
         VFRbfw9ubgDatM9z4/gT1SK1SicqKxWLoViEl5ccaaJKBpWln/2xnGn+Vu8cWBbuKCxD
         plHAPgxw5eIY+1S6sGAwKeJ5xdkaWutCYh4iDJ9kBLEOZAm/Jr3qhccFAIOA6++G4wur
         Hnyj/rT8JXDgfIRo+6I0yEX7IiCD5FZH8YfvE4sS3BgR5fAyWbRhhuP3egEikum//raw
         8QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038795; x=1705643595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxvkESmzviEYCBtp91snCvTXp4bYwC2oMLMP2RAwiuA=;
        b=vHCVLec2wkzST3k0SDVF4nBzRrx9LXJJ6Ys+lpRw7iIDgIcKKjwp9FtH0xFVEIjk+x
         YK+prRA3WdPmTGhsVG/ovCrnN/xGl0dTqzrDhXfVMNLJDTl9bVjx2gBRkMkkOsrXj0kc
         Y9+UaNv9d0g31NjldnY86Bi+US6j4MtPQteULLwT1X+Vra5g9gssscCmAHkfbTYWleBy
         pf22F1LJVE8CTwIG0pxhSa/mNj1ieV8nL7yAit4EgkmJ/xoLuXIFveaq/0or/z5VdSjt
         MRH3R1lQZTS/cpt0frwow6aEnXJ+Ms9Y8FFgZu2uqafvT2q3ewov6AXrp+zaGMqC5OPr
         Zw0A==
X-Gm-Message-State: AOJu0YzimeRfFDicIjkA4lru6aB2aBN/kk/gMZNNzxPUu+MYzuiYwhu8
	tD6QJ9IrtpBsreane7a5OGHjcxGEJ3cqOvhsiHhkh5g=
X-Google-Smtp-Source: AGHT+IEQgbkriNOGK5mfwWNuA4LMZiYYrvGPT1vz3dpLuatntUClCmGcbrPmnPd+PTEtKaWhmKYQgGZpVUGSTNxw
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a0d:e003:0:b0:5fb:7d88:a558 with SMTP
 id j3-20020a0de003000000b005fb7d88a558mr497217ywe.0.1705038794846; Thu, 11
 Jan 2024 21:53:14 -0800 (PST)
Date: Fri, 12 Jan 2024 05:52:51 +0000
In-Reply-To: <20240112055251.36101-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112055251.36101-6-vannapurve@google.com>
Subject: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at 2M alignment
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

Return error on conversion of memory ranges not aligned to 2M size.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/mm/pat/set_memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e..6f7b06a502f4 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2133,8 +2133,10 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	int ret;
 
 	/* Should not be working on unaligned addresses */
-	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
-		addr &= PAGE_MASK;
+	if (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address: %#lx\n", addr)
+		|| WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK,
+			"misaligned numpages: %#lx\n", numpages))
+		return -EINVAL;
 
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
-- 
2.43.0.275.g3460e3d667-goog

