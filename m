Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829434AB1DD
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947917; cv=none; b=iYGCsvIuiV5QbaP28+0Bh2uWd9bUfnKd8xYWNA6wKgRPLbSS8lc9DxIG4MI3Ti9bgemF3WiEfk5BObVZMtBaneIFfagF1lzjRzk6k5SAY9L3KIwvKIXeoCZos6oWHctEiyGNAjmOAeSJD/5Vu/CXyYAZ2GGNY//zO3THXAaxwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947917; c=relaxed/simple;
	bh=brthmMIhFTOepPGDXICFqqrSL14K4+Sr9qndgom0CTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkBE+cc3iTC++y/qUvclGxmJ44GFVNGVAID7chYhxlOZXmBSacRUXUqgnl7qGo6ugGTQCKvcu6sTxeBw8MLuzaG0Y4etJTIaBwjQxHEGWCi4gTDx+4iJEZQAD4sxFRCgq4wnr3aadD8C/2qasOrt/ViZ1sSyDHAEIW3FEbvosGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=KJrcuc3h; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="KJrcuc3h"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so450965e9.0
        for <iommu@lists.linux.dev>; Fri, 02 Oct 2026 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1790947912; x=1791552712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9Ano9xC6R+jtMAGzXzbGvkWFfYtvDDQfjL8dZJy8z0=;
        b=KJrcuc3h3qP3dx/M53QUumwOnajbNI1AhPFuCfI6p/5EYJvc7YCX8+l3s/8yIbvlwV
         LWb3VbMRnVTvxxmGOV4dpUhSTjbUjKBXylQJ/wjRiFfc3m0TNNxq5sdYioxBbZkZlfyK
         DWmh91DicImf6qLtrGVoVMLcS15XKogNHB4qzPLMD76WIt3u1puca+bnFFPkRheEh5EX
         z9Uw1ZeeZUS7JYzIl1MrUesMb/OKRtmvTzuh6h3coo2UhylSCPUCi4p/CrL/wOdsF/VV
         c1pE84OZgi+9xRRgis3md1REKhcMIPSShb4OzdG6jJBM7vQI5MBKIH7W4LfI/4Y5F2lq
         UHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947912; x=1791552712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M9Ano9xC6R+jtMAGzXzbGvkWFfYtvDDQfjL8dZJy8z0=;
        b=o82k4OqHwyYCyf3OIVSAWKsB3HRKO1epcwyrinbQaOsFQWZEpEJ5UlaFND7vfT+qP+
         SFC93FlRpZvugalYxTIaVld9DOy/yMniNe9qsjRKjF1Md2PHMLcDB7ACbwse1moAE5CP
         EEFhHo/05BowMWUiu2Tbbjnb/kAUcAI8MW4TjjVpzRsbC1dyTxPuNiQBqHCiKXPAJUC5
         hN/emk/wAbcFvcBqhRgiv+thRYj7V971tbQFhQ7hqX0Dh8xa5b91yDJ9a9EkQvJPS7DK
         THaloHQdWaND5tiXw2uK+P7ACRmXb4ryMdjMuLTcczpbqNv5/tx2NMf/C6y6Xw2MQIr5
         IPSg==
X-Forwarded-Encrypted: i=1; AKwUvBzhej6CVDI15znSp3jILkkl1002TW+gE89bOxPQ8cs7fIl7GVEC0Q2qNXoKlY2tQnBagac+Ig==@lists.linux.dev
X-Gm-Message-State: AFuF++nJCTQhGFTsnPDp4YNqQV2DECl7IFxAm1P2JAUdh5IqDlHCeknG
	2sFbBRoOT1z9oKx7NzwFQn6znWUGBkHUDi0nDenL9K9lU6j/GO6cPZ2vsO2GDwbRWXc=
X-Gm-Gg: AYBFou0qsp0CAvpWIYS8QphjAsL2krPlEsSwgxH2HPLf7vBriHb31mMPx/iV53cJnta
	Iqqhm9i/yeR9u9WmaYoAcXRYV0JYHKn6z/lQptrHEkAAEm+umQKqS1mgGGkp4uy4EUdtlebLbUl
	F6zIdg7d09QXUnmsVka3t5f8wAOcIkZfiHbHFzAkoIp/4oMogxchcugbG5HxqVkVt22R36qz3gv
	AFnT9+bMmLX9mgwRICQcsT8kxRarWDnmZ6AwNw8UsKsv8/41uqPQbVxZ8rKPf6LPmNxD3rahlvR
	8foPvXGLyyUe6dVOMFXEL12YQSZWuZo/j43iAiE1iB83OYpa8QgP0C0Twd0DXjHSVWkktSbcI6I
	nTz+FJCIHr5P1+0uGRe+doXaTWDenJOuRk/4oy+1K0XIOyhRH2l7BRIgbAWZIESIivIEK1rGG5t
	pylVUQcN8JTjPZE0QTZsOotnmx+BBJc2VKv0/g6npC+magACgi+ITNgNC+msfQod5yb6/6CkJsq
	ubXkSbkxyc=
X-Received: by 2002:a05:600c:4e93:b0:4a0:1e68:d28d with SMTP id 5b1f17b1804b1-4a02756715fmr52492915e9.6.1790947911590;
        Fri, 02 Oct 2026 06:31:51 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:ebe::178:143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm60543205e9.2.2026.10.02.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:31:51 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Baoquan He <bhe@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH 1/2] iommu/amd: Program device table when kdump reuse fails
Date: Fri,  2 Oct 2026 14:31:42 +0100
Message-ID: <20261002133143.3628181-2-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002133143.3628181-1-matt@readmodwrite.com>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump") made
iommu_set_device_table() return early in every kdump kernel. That is
needed when the previous kernel's device table is reused: the base
register already points at it, and on SNP-enabled systems the register
is locked.

But if reuse isn't possible, early_enable_iommus() falls back to the
freshly allocated table and calls early_enable_iommu(). Because of the
early return, that table is never written to the base register. The
IOMMU keeps using whatever table the register pointed at before, while
the driver writes entries into the new one.

Only skip the write when the previous kernel's table was reused.

Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/iommu/amd/init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c07c3a01b978..0572e1a674f0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -409,7 +409,13 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
 
 	BUG_ON(iommu->mmio_base == NULL);
 
-	if (is_kdump_kernel())
+	/*
+	 * A kdump kernel that reuses the previous kernel's device table must
+	 * leave the base register alone. It already points at that table, and
+	 * with SNP enabled the register is locked. If reuse failed, program
+	 * the freshly allocated table like a normal boot.
+	 */
+	if (iommu->pci_seg->old_dev_tbl_cpy)
 		return;
 
 	entry = iommu_virt_to_phys(dev_table);
-- 
2.43.0

