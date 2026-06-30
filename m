Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC893E5A3B
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805683; cv=none; b=XDNenNzAKkzziCTvA3sWJiFRtgX6VdwHTaaD6KuWjUy4rUPZjzeo0lhb9BlP6gnSE9AJH9SImjnC5+0SgX+gHK0QhCxqR5uew9VjXM4pXT4KUOEcHLnXv3P/i31NiH0ptXy1XEp7sMlkmiC9jJOhOtQzxzs1tpsviWfZ0ugewks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805683; c=relaxed/simple;
	bh=eRKNOIjCkiF2jF/wqDsLoKJFJ7gQkK71h6q8X23yaLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1gE9/hsokDhxSkhaxuE8biyQFjL+M9D7xa6trrlaC4oHEu2Eh2mgY7/1CFyYN5vqIoKb5MwYeEjyYPWs5JYkIgiOhRKqibysGGHZVXTbDuQoL1WLh1zg/3GL03SoqFRRcewAcx8wjWyuxqJgHM4Sr9xJ4VrEIUa80UtZIoqsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFewLym6; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFewLym6"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-37fb17e1435so1424162a91.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 00:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782805680; x=1783410480; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Grclqvhv7nIlB4Htu6FP2QRzAU/Ix2vbgSwcdXfpMs=;
        b=QFewLym6Lx+VHqKHROkBXkZTpxoLGUQZCoxwT1CRWOKh0OllviiI//eY6XapBlBEjw
         v394C4HAiZS1Ml+ri84llMmWGkOOrH3AvmP4gRFzL14UUDai17pSRQfbQiBI0aIkt0FL
         DxvCDDhX7fZTccic+Pa7z1NEQNc+PCKOy/KNuQmWcfJ7/gqq3d4jUnHgnts4sERgHv5d
         VOwFD+LISNaMl/ZLXOvkG9RX2Zv4K0golprSnMezfHRBnmcxiCOu5Q8zIoEGNrCn1Crn
         AM/Q7m0bkKAscbHx9vJcUbasnIzYpHgJrLeJgEG4nd6Y/TTY/nf3PucKduNiMD+Govav
         E9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782805680; x=1783410480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Grclqvhv7nIlB4Htu6FP2QRzAU/Ix2vbgSwcdXfpMs=;
        b=gf07KpYXGqgK3wBdtrGfi7oS2FjtZ5BC0CKz2EVbUv3uecaX+1h+X1wWT7Z6uGdbBp
         wHG03yQimsFWtDEuIJZAZAh8+T9rpW+f8bonre/OTj0cIfvlhziGHaxHqMiBK25IyCBC
         Y0w7fkKbeXv6CWjtJ6MEVxA3f072IQ1byMUqVz87QchmUBt00S1f5lAHROkma4Bs9e8n
         pc7ax9YpvxZbdoSEf0dn9StFRKGlELgkhWqSk3TS+yK5BEiHXC2+qq5QHKQPzPPVFN8w
         bqpyx5/vFDX0RM9MkwVGJobUYvg6pL2iLT4VeERuZUhZsHTke0xSgqtUpGi9lk+x2Rei
         O64Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro0NeTWoA6BAvYa9Pqedc7Dh9JS3VdZH2dXpmdc48QV8B9kI69b576HVcqDt/i9K+cY8hAPFw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+WHJXegNhrdRmDpK1CwI8IkcpK/B3SXFc9mHRg4sqoSNIhowx
	zcSAHYfVy8X5LfoVfPKZYuWcu8+cp3nFM2iulYv7Buf65PdP4bKAV8dJ
X-Gm-Gg: AfdE7cmDjwb+5PnEiRSV3qZHAn4+J/4seWZ3k/gNZ0uBO3HsswtM7GpmWF1XhXZQ9l3
	7PuIPPuNtI5A9OiikcXp6GDYahKnMVKEkUQ+1qfYir0NQy1YvIT84belHWnz6nogwsqImdgVxP5
	0l4OggskkrWjW2ca/X6KR+bzp94jGL8qMHmmn0aCtMe/dJuRJDrHhS4h/os6li5lKEtI93gep24
	wmF9dYsePy1dyVrFKNFqV2OzI4Ovwib1xXXnRKqKh+FkGN1Eei/sbn85ZOjKVYmzvPzt2AZOJHW
	d6bgSHOf6dKEjI9pMk/QDYl0AHo1YeDSAF+Eud1z1kf8FrpjXaahSeemN26HFT60dNg6hKqvL1V
	tl09QSXkisi067KDcKKCR6HcPQATcGsby0qBd2I3+X/8A8Nuqxea+27FIGpH308ihUbFKi59gRd
	kgaYwDFBu3E0LN35iZLKYsaBKoNA==
X-Received: by 2002:a17:90b:3c8e:b0:37f:9ce0:af34 with SMTP id 98e67ed59e1d1-38052826ad9mr1631272a91.31.1782805679897;
        Tue, 30 Jun 2026 00:47:59 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382a2d3dsm7821045ad.55.2026.06.30.00.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:47:59 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	bhe@redhat.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev,
	zhaomeijing@lixiang.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v4 03/10] of: reserved_mem: skip late scan when no regions are reserved
Date: Tue, 30 Jun 2026 15:47:07 +0800
Message-ID: <20260630074715.4126796-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

When total_reserved_mem_cnt is 0, there is no /reserved-memory node
so fdt_scan_reserved_mem_late() have nothing to do, so return -ENODEV
directly from alloc_reserved_mem_array() in this case.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 42649dc3613f..e1bd35115cc1 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -76,7 +76,7 @@ static int __init alloc_reserved_mem_array(void)
 	int ret;
 
 	if (!total_reserved_mem_cnt)
-		return 0;
+		return -ENODEV;
 
 	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
 	if (alloc_size == SIZE_MAX) {
-- 
2.43.0

