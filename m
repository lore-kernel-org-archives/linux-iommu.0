Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6802FF656
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716602; cv=none; b=EZggicuT6xMhL2WUpQ1WQ2+BrLou3PV31UNfKj9z44RQ5wa7MM46YNpzRlGyIcLmlhVFBpB3WVQY+09nHdx1cSCQ+VvFroZJBKycRD/AdaQYj1c5Ukh+zmVkb0mLcAw8FfBpC52NPPhWTFtIBoFaJJh4zglnR/3Fxvm3mWHk8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716602; c=relaxed/simple;
	bh=TK2EFF6Ag12e+ejnPMv2kVPsFdgJaI/cRmxcuiTgpJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4PnO7aXT5sa/ZScZFVlg1aSLCcI1Yg4YVZuf89p0mmQ5yFlNgJmx2iHD5w35gZcde+j7vgd6e/H7DJnqlJAXiLdEIBlTsir1B1RrUHfikurzFTnffHcnUB4q/MLxbKtYOgX9GpJSwY9guseqMq/KwjsB30030VTKO4fQ3S0MDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSlBi5IB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSlBi5IB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295952a4dd6so3302435ad.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716600; x=1765321400; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dZbKC+fAmBmi+80jHPBDIRcfD9xd6VgsQkdzdniEfU=;
        b=ZSlBi5IBiGWepkVrdtCHqN+Z1S7gX+sbkzfZ7BBIa77rpqLExuWRgzMBuXihXf2cGU
         6Gj0uLPQkLZwITnjka5DfGYkeLFYFtIcZSzZMrLvGIEZiGWKFYJE/6wvGvSNb0DbV1BW
         zlxq8JEqsd5A4vvaVuodi0YJtOLoIIdc0S2luzZzQvZxaN/Ht46NBTVLQELUDjuO6HIU
         Ot/f3hyZbn5vq7SK5isssEpDRVSGoInd81UXPqOlhgeA6QmgoXp+XbZEHwFZ4WguqJoC
         KMSIZ4w0J2Dn1qWVH2jiMP4bcJUZGGXUQN18/LkVwVMDTAZRCX/yjUA5/Qc8JxSPVbfF
         l0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716600; x=1765321400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dZbKC+fAmBmi+80jHPBDIRcfD9xd6VgsQkdzdniEfU=;
        b=VCBf3pzCHqw1lY3VjFS/7F8VQTXj7JvyizKKGGbkMrBW9NtekDbj+rWF/ls3s4+Ktv
         hCkW9AqVEsN1SVdGFZuYm3x/ouysZ1gCv5YiyonfVaR9eRPcR0hc1iAisxYxtTlW9MhH
         5Chyz7W9INkDFocFXTIEPboNEE+wfyMZmo1IXAHea68zplTHBxk2c3py69+jQSEBlLdu
         oSsFvC8tF4Hh0XJj9HYYQyNzdH3Mbzjp/M+7zkO2Ko2aKLMJ/8ZqCHxX5FuNnPwCaWi8
         Fnxq7WGPFDpMeMs5jgr//Najolxpvjap/y0ARQPt/MnagRCoIg8Bl5OH3LCr4vX5lcjA
         Y/mA==
X-Forwarded-Encrypted: i=1; AJvYcCVL8AlwESnYh/pt5yTDIY5NFPUw6VBSjmz+HLJ9/NVE4Fv9HJ0OYnakYZEFLZugQkAI4+RW4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4uh/FS5o/E59LJAJaSTTYD26jxAOFumDu1io88WCF6yCmpzU/
	Ftz/U9BktAV/nQIEVi8cNJu/MVeyGUczTQC/LpVoStodSjeerl2sg0KcAJLc4itgKm0OHXJGyXG
	JnXt+epp6Qtc1gw==
X-Google-Smtp-Source: AGHT+IGwujbG6vyR53fAv+matIEUXsWWOhe2XPEeNEAqwdMuXWgmYMDGf6q/rBQ1n1lfvJWuQLXHJrE9Iu2A2g==
X-Received: from pgve25.prod.google.com ([2002:a65:6499:0:b0:bc3:cbd2:e0a1])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:40c5:b0:297:f2c6:8e05 with SMTP id d9443c01a7336-29d5a48b0bfmr44974725ad.6.1764716600146;
 Tue, 02 Dec 2025 15:03:20 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:40 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-11-skhawaja@google.com>
Subject: [RFC PATCH v2 10/32] iommu: Add iommu_domain ops to preserve,
 unpreserve and restore
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

These domain ops can be implemented by the iommu drivers if they support
iommu domain preservation across liveupdate.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/iommu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8c66284a91a8..f681d4d27d6e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/iova_bitmap.h>
+#include <linux/kho/abi/iommu.h>
 #include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -749,6 +750,11 @@ struct iommu_ops {
  *                           specific mechanisms.
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @preserve: Preserve the iommu domain for liveupdate.
+ *            Returns 0 on success, a negative errno on failure.
+ * @unpreserve: Unpreserve the iommu domain that was preserved earlier.
+ * @restore: Restore the iommu domain after liveupdate.
+ *           Returns 0 on success, a negative errno on failure.
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
@@ -779,6 +785,9 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+	int (*preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
+	void (*unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
+	int (*restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
 };
 
 /**
-- 
2.52.0.158.g65b55ccf14-goog

