Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8799180053
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568960; cv=none; b=HqNGFPFd4vs01j3WYMksbQl+rfpYWfma0uDFA3Ca5R/tF+YImC7xBSPhYSzYlkW01ibN9vQnubObmLvgzsrC3GXxbYCpGL6skDqag5J7dMiJ1LF871FEk5MLXck5oXC8kKTMvqZNWgmf2VGjbp38Ma6kdRRECYC2VCznLNj1p3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568960; c=relaxed/simple;
	bh=yGKs/GKCL3nl4YxWXN4A6FvutpRKPliWYBfVVipIw1w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S1Mca4jpV5K/DV7erVmjc72UidHbLXo6YzxtknXVXsq5O6A5r2I9AvFjqthSHFgwTIH9plwidnjaaQ9CBLFnlX+Bb1ZE/N2Xulwu2hbZBxAdMpGAGpJYikyxCpPZz+l8uPas4hM8p0fL1NUWoE9F57DCQK2YDf/PwCvQl3lEJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCdSGMKB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCdSGMKB"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e033e353528so9173127276.0
        for <iommu@lists.linux.dev>; Tue, 09 Jul 2024 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720568958; x=1721173758; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7mDbytgqOLMqMz+EYXhiJVnxk2hfmw4URx/DKSaIyt0=;
        b=lCdSGMKBu/NfkIQ1h+YrXo8AbROTO1XVfp6+r0ByHjjd/KucIUonRQjoaoLWr054RF
         qhHSFLJIJxlBzYA5fQMFYY4C4MBf7fN1zudR+98bojWIO0UoVCfsO2mwCf9Q0AaxoCi9
         3Ikzak1I7z7HjLxnvYNbOw15rPG/onsRYVm3rves4ZAwZGj1XdXwOHymxMXzFCx/wDxe
         nlnqGgOycDrpNTIEAmF3bALUGkS2n+tUL7a0ufBi49HQCRiBqX9xgyC3ziazaxyr9A8H
         L3EpsPsYYpydrp3qPBro+eWvs6AP/vJOLwPQO6uMue8kR3LUzUX68eeeRUSbX9tYgFUI
         1hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568958; x=1721173758;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mDbytgqOLMqMz+EYXhiJVnxk2hfmw4URx/DKSaIyt0=;
        b=JjlEKcjlmzT1Dx+kN0mfriKDliELuNbQOD+RlvlsyHaAwLHrFRSiKSNXRmbM5ZhiSr
         quCcOOK4oEC+aQo2AyeD3WNDqt3pD7oKhttgESfdzBtgjB71+vHff2AB1GYTkHiz/RPo
         AfMs/4imA90FsS9DMpu/D+eXps1kxFOK4yckjKDLgyilfgE/1TES4Dp8YfPVMfB0IMbZ
         y7lJPuMShwqykIvF725rvAipJY83pmoFbaE1bu8JLF8wmvCjs1Ki1TZCXMqXY6UOv4Lb
         Lj8AQuIEGQo7A3YhHGKK3ondAyWSQiX/Q31H+HSzG9CsqSKwxo3Ij2+tB3XQHFCSpkpD
         8c6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjx3nsmW14fvZmnKUSrSYjpkJDlOaxkQC7CLCM00wwp71Fl1IjyzUKPXKlU0bSY1pxmOFyTszjsUxconZrQF+Kvk8K4QY=
X-Gm-Message-State: AOJu0YzAbh/Kn5RsZ0LBp7z1uKPvmHDJckUa11cBtlPpFwOBlTm96nSy
	lMxv4coHMjfQQEA09sgxKNWx4atAEWCY7abMdxUcNFz2BXLg12GLrVfroI2qmVq+N0JkTgXZ3Cg
	hAA==
X-Google-Smtp-Source: AGHT+IG8cNE725G12Kfa72RNPLrZxQ2HsAiG8z2ywoOGl1i6XzVN390kI4TOHDz7MkFev5cilMkjvotl9kI=
X-Received: from pandoh.svl.corp.google.com ([2620:15c:2a3:200:dc7b:3f1c:f4a8:f387])
 (user=pandoh job=sendgmr) by 2002:a05:6902:161a:b0:e02:6dcf:e9ab with SMTP id
 3f1490d57ef6-e041b0688b2mr7939276.6.1720568957867; Tue, 09 Jul 2024 16:49:17
 -0700 (PDT)
Date: Tue,  9 Jul 2024 16:49:13 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709234913.2749386-1-pandoh@google.com>
Subject: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
From: Jon Pan-Doh <pandoh@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Tejun Heo <tj@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jon Pan-Doh <pandoh@google.com>, Sudheer Dantuluri <dantuluris@google.com>, 
	Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"

Intel IOMMU operates on inclusive bounds (both generally aas well as
iommu_domain_identity_map()). Meanwhile, for_each_mem_pfn_range() uses
exclusive bounds for end_pfn. This creates an off-by-one error when
switching between the two.

Fixes: 5dfe8660a3d7 ("bootmem: Replace work_with_active_regions() with for_each_mem_pfn_range()")
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Tested-by: Sudheer Dantuluri <dantuluris@google.com>
Suggested-by: Gary Zibrat <gzibrat@google.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fd11a080380c..f55ec1fd7942 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2071,7 +2071,7 @@ static int __init si_domain_init(int hw)
 		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 			ret = iommu_domain_identity_map(si_domain,
 					mm_to_dma_pfn_start(start_pfn),
-					mm_to_dma_pfn_end(end_pfn));
+					mm_to_dma_pfn_end(end_pfn-1));
 			if (ret)
 				return ret;
 		}
-- 
2.45.2.803.g4e1b14247a-goog

