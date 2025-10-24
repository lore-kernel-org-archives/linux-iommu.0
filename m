Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557682FC88C
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292959; cv=none; b=WyOsIHdlkgVb+Sk3Bv0XVFSU1osDNISLUpF45rU2vMj7XNkQqYALgY4iYnzXv7EYZy5ONeGBWdtNqSK4eBhIUkElpLuaoxyZGNARcW+U7/Yven+RIQvWHhGdUQJhvLF732eT+YOKWHB+B7Ze6TMguQm+b5XtqkO+upyyCRE4zNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292959; c=relaxed/simple;
	bh=WyWdMElonDGVN0iFKYKqXrLPkR+tQfERlo9IF3HeJD0=;
	h=From:Mime-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=NcPDsaDcElhhnKiPwX+d2W7sDFhpSXuRXqGtJiKg87w/LXfhDYkHz0GAaHmhZyQy2GfUP6vDdZtSdZinnsazk8z4z2taUwWzpiGX0VBir5DAQDyuB7Kt7P9oh+Nrz/baMxbNT4B2DYR6fjDplATcbBUiol4PxrbEqSkYo8N6UbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UkYjZwx/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UkYjZwx/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42966ce6dbdso1147170f8f.0
        for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761292955; x=1761897755; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QVkfvNOE05bgFyjQFvQ8jxU+LxgCYyMiozDi6BCH2IE=;
        b=UkYjZwx/sKge1iIzITURn6kgKBam8OWCIq9BnmLpotzJ9gTyitBTHnaPq5wZQwLNPV
         2AfUtvUZsmI+8fMu9huO2Ckn/E4ZxvlW/OZnntdtOxOy6nmWK83QGpwTbL+x+OiNV+IA
         6Cp4dp37j9m765APFbHES2UuXbmf4eWHkVa+DkJVs7ipmv7HVtQ0KttsRJ9J/FPjqmos
         7yntbWlrg4nKGMOGYKH3KQb1GrA/FaVA9wEJ4kIoRbQzGYcMjR33+ARgV/T7jyDhgOgU
         0lk90VQKKTRYhdXaI2d/MR8oPYUkk6y1g9FzYgeSPo12QiCsT4ZSGCnc6yUG6i2+Ufr0
         9BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292955; x=1761897755;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVkfvNOE05bgFyjQFvQ8jxU+LxgCYyMiozDi6BCH2IE=;
        b=aPkjfRPOY0EyaZrkOBSujgluqdcCWtS9/J2PRnxxq6NPxbK9TtdTUTVX6KAe804nWl
         OLAAlojMAhZ7NfCJz7BGP8xbMAIsH0I6SS+xuUZPsbYzdj9/x/anrLV16Pdy1H/zeanS
         HJkxXeUaBre39ocq++WlnHumVcT643tgLEekjIcNAV3mlpx7e1h2ZLthxdYTT6vptj1f
         A8DDlBwwdO5dq4msX5zqIeyNR8xRPDK07AZQJKcsPuWwgo7WPcUX0Coj4mG1VeLdjAUA
         mbE7MRgdL6zw6CePE4KneWXhZ/LP9Pgk2jE3ZEQ28zr7XDgUZMuMe/p2nLYbScRQYnos
         U9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXvaalbHv/nnphrcedQdqzkyR/AEbjRL8RJXXE0G0UW1r15knS7TF6+6nygOUDZDD2YcGuojA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybPmLH2RZkSfnMTp6WtF62g3dFmXDvLZ5O4VdM++6fEYyGjU7d
	HYsVXIv5j0gaEAMa6BebnqIq+4PlemA6T989ES/yjTSNTbG/5OlKHBaVSXXESOLkZhUxB1K1EG9
	7PcyQRwlBtmYuJGpDXulbABkx+NkgCisURL7eWIQzMA==
X-Gm-Gg: ASbGnctOPi60ShqSilJJhrXC7EhuOR1nRWJCbQGnymKCummiLnsjc8OfCZfWDiPPKIs
	3ZrFDabEO9i9Tgd1YNUUA3K73dsups1L5dQ/Pg98z3E60QnlmUuvso2JqQyHECW3NRgD3pp5QQM
	3hhBz44TDJhPAh1dCbHAt4Ki73Ra4t2P6HgTW6YVhFE2gaIqt6xqQl6DVx12M7Sgjrti5atKZwL
	6BIw+uxyflU7+Gq18HibqcU9TvpZ5lZfrBWQd++Heszb3Xkd43cvIUVdX7ODIM+PRVvRkWYfAth
	vjEaBzXy
X-Google-Smtp-Source: AGHT+IEDMvcKtfBgWfrP3ZyctUGsfciyGaBJ5AzyE+b5gOTpk78Wf06aMuH8uJW94/vjXjqIP3j/1lisp+qXxvTWYy0=
X-Received: by 2002:a05:6000:2c06:b0:429:92bf:3a3 with SMTP id
 ffacd0b85a97d-42992bf0644mr98922f8f.11.1761292955312; Fri, 24 Oct 2025
 01:02:35 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 24 Oct 2025 01:02:34 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 24 Oct 2025 01:02:34 -0700
From: Songtang Liu <liusongtang@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: Songtang Liu <liusongtang@bytedance.com>
Date: Fri, 24 Oct 2025 01:02:34 -0700
X-Gm-Features: AWmQ_bmgfhEOQj2FZh2LiWfKD8MoIdgjL5VT1xU_C_QJQWPA7IczJX34PTJBxTc
Message-ID: <CAA=HWd3_nKzKguK4JAs3aX7MhyX3mxFPLNLzEqwRPiSPTwvm6Q@mail.gmail.com>
Subject: [PATCH] iommu/amd: Fix potential out-of-bounds read in iommu_mmio_show
To: joro@8bytes.org, will@kernel.org
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, vasant.hegde@amd.com, 
	dheerajkumar.srivastava@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, liusongtang@bytedance.com
Content-Type: text/plain; charset="UTF-8"

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
---
 drivers/iommu/amd/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 8b4d7db7869a4..5d85c47478a57 100644
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
