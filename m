Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7E2BE631
	for <iommu@lists.linux.dev>; Fri, 31 Oct 2025 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761890130; cv=none; b=ic/B31Kh9lX9N4dCxHjSoCkbXyTPwjqFiLVyLXvAYAcNeTs+t6cfbAwEFS+hsObjYXzxAxfW8c76+eExz61gYAxYYenq01N9ZKbzVcpOk6+AVI2+ln0D1RdWvTsjdFybEHp8B1rahZxcl2uYlU3v+R0kkhsX29WxKmzFfqYZ+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761890130; c=relaxed/simple;
	bh=fDWAynXxxMM8wnZgiOP8yS88DMzmiyKLjs9SaH6/bks=;
	h=Mime-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mfTtNi4wd2iRQVE87TtZWhXGSBX+TDE85o6tnR+jRy6a44dqtWjga6vQbFevyeaLVGaqiCCKhcwuUbtxqw1GTDEyRExHuOZJ/z3RYf1DUbK8weKS4d5RRUtSnB/oIAMKZU4Dr703h+Mf4mPF9nM07Svvi0TCQWxmeEA1dgbR8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YQjdbBJE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YQjdbBJE"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47117f92e32so15486605e9.1
        for <iommu@lists.linux.dev>; Thu, 30 Oct 2025 22:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761890127; x=1762494927; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2uphxqo8Dq0ahPpyMVVXeMkMU/LtFsk0B3ztz4GQpss=;
        b=YQjdbBJEHvoQ6WvREVzbded6HmTiFokIIJiBykoA+JahHGFOHhJu6xj2LaCC5BwAhI
         FTqzTlt2aWQrmWxa0X5yGMNkaF34c5aUj7p7zhQHFKpGLR18ttByGGUmbnFqwtJnzQoU
         Uu5yJJY01yu0EHgxsFkkZYL4zJDRbweM5NSMu4KC9uDDj/AqVJt21f+Ia4CuYOV8otiz
         stY1UyrzQbRPrVlLdxG89Ky7633ZkNw9xbr67L3LQVmZNv0scD/RtdhEMoN9dwSLBjkd
         JWL2mO2Hkv6Bs0sQE9xqmLHiKA73ehdPKqjjyY3gT8y8jxAuyzvBIbNBp/BCCDX/HuIn
         nKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761890127; x=1762494927;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uphxqo8Dq0ahPpyMVVXeMkMU/LtFsk0B3ztz4GQpss=;
        b=O3z47KVM5VdaEATMVzBPRB4REULx85zrXnMrdI9zM/upKCuBypnOFUbUpKBfbqdZ1f
         8h47EhJL87bohCYWdSMrqlcwIeanxe7kgm3Lt+HRpJC0T6FWACjJGS68Q5D1All2KN5v
         UbzWpTWLG4wNAX+Gt9vy8DCkokT6d1IGyaqmEoYvh1Kxom7J7whyIyZVtzpQBp3xBmHS
         2zYoC9BeWzR8yYxoEV/sCzkVgNTnk9i6sfcC0mGaGptoSOIuATvo6c0wzrqoP1BobcgQ
         0W/W8szT8tZU7wn7icxDRWFPO/ImEEcFO0i/pAJSarIK92kLO/xeHUUH8y5VMadrj37S
         AxNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4ATKo2hB14r38YW7rkOiAOuELWFObiT8L5nKQkri0EqkeJu3qNRM0cN+UXQyBYCVAIikRSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzf+w6kexEtYb33uCUvXUyfXNgeojBV63D9Ng338PhrUErRUtx4
	TTpuTqLB/4MTABHhjQRVs7rpkLKE0hztlcIkPKQs1w2ZAGNOalNKuEkN+Q2RwVkbhgw+tPEu/h9
	lRGx6G5eg8YrAp6h/U72VRfUl38MoNssNvLiMHFXkfA==
X-Gm-Gg: ASbGnct58Le4davL2r/kba5I9KnKfJjfsLr1HSMk3KfwzzQduXXOmFecv2QpA0vZln4
	1vg1EO5SEk7WFgWCAj5SAQcn8q/7Iv0prOJs9l9y9RefFN7u+QnJd+cikTksBJH2dA5nPXWTk6F
	6dXAe+rP5N/Ct2zXA1Wpj6sVYukCBVmDZq74vgyFyioxqWgEsnq/OXbWcrw8fjcsWyjmHE0T/M/
	jlq/kiQhdXTBIu+BEb4esA3weIsg0jOMGJ31M6HLsCYAXYsB1Yc09Y4aGFz/Rj+mdLfLoi0rEmd
	BF4CEKfX
X-Google-Smtp-Source: AGHT+IGDAX1QJAUds5j8mh9BlGLC/RzUnQ2O+/rvAlteja6L2AmrFOaouCasKY8HaV1blDSmNC2uSsBnfY89IV8MWt8=
X-Received: by 2002:a05:600c:3d93:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-477307c5826mr19478055e9.15.1761890127090; Thu, 30 Oct 2025
 22:55:27 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Oct 2025 22:55:25 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Oct 2025 22:55:25 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: Songtang Liu <liusongtang@bytedance.com>
X-Mailer: git-send-email 2.39.5
X-Original-From: Songtang Liu <liusongtang@bytedance.com>
Date: Thu, 30 Oct 2025 22:55:25 -0700
X-Gm-Features: AWmQ_bmT0mQkM9jWP5x80J13JcQ5hhRJh-KzQJq6kRpJ-yLJjjXwcuhaBH2v7Gs
Message-ID: <CAA=HWd1wtM3QkqLkLC0-GtMNykB22jkd5rSYj=PchKFVT2m+Vg@mail.gmail.com>
Subject: [PATCH v2] iommu/amd: Fix potential out-of-bounds read in iommu_mmio_show
To: joro@8bytes.org, will@kernel.org
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, vasant.hegde@amd.com, 
	dheerajkumar.srivastava@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, liusongtang@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Changes in v2:
 - Add Reviewed-by and Tested-by tags from Dheeraj Kumar Srivastava
---

In iommu_mmio_write(), it validates the user-provided offset with the
check: `iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4`.
This assumes a 4-byte access. However, the corresponding
show handler, iommu_mmio_show(), uses readq() to perform an 8-byte
(64-bit) read.

If a user provides an offset equal to `mmio_phys_end - 4`, the check
passes, and will lead to a 4-byte out-of-bounds read.

Fix this by adjusting the boundary check to use sizeof(u64), which
corresponds to the size of the readq() operation.

Fixes: 7a4ee419e8c1 ("iommu/amd: Add debugfs support to dump IOMMU
MMIO registers")
Signed-off-by: Songtang Liu <liusongtang@bytedance.com>
Reviewed-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 10fa217a71199..20b04996441d6 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -37,7 +37,7 @@ static ssize_t iommu_mmio_write(struct file *filp,
const char __user *ubuf,
 	if (ret)
 		return ret;

-	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4) {
+	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64)) {
 		iommu->dbg_mmio_offset = -1;
 		return  -EINVAL;
 	}
-- 
2.39.5
