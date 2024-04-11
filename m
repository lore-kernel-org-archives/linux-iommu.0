Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211261419A6
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826339; cv=none; b=pomWM2IYhACL0P7w11YXVK10X6+8vFMlJaeZxrvJfvizB0INgAtgpl4qNwgfiy6QvQkxXEcPP8PTSjGDh5mBDOBOQUe0jJag5q5xl3SPlQw82MGMBAQcl7Y5QchJSRk+1Ovr+T9Gu8rGkbl8YSTe0VCxgZhR7LHocJNOlskMnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826339; c=relaxed/simple;
	bh=h1ECHJrI6yDGWiq8/tzickwJ+lsJ6Lz0fibT2Qel/bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UMv9SpGoUGahc0S7f+0fvPWN2YbAFselh3sO6rvJUpqy9rUB0hjRUCtBc0ll2suXCUYPWJKPVtNA9u/5FOw4rlcZTntGyHN34r6/4zRP49b+qgShvQDRhR64pH8WHCeS+iixeDjJBvWiRG31lZRVd6iM/dBlh6cj5dP/MAtrv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXQKWdpK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXQKWdpK"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343f62d8124so4150484f8f.2
        for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712826336; x=1713431136; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ThLGpbeHjKHISy6v+wWhWzlM1AmHv+Kiehy1oJijdu4=;
        b=nXQKWdpKim4/MfpK3rGoNJI/IDm0kskMznjYDTKplK6+in6OxdDFoy1Jm3q8bbhwTN
         aD+aspMcgMuR2YQlG98szUqnydn+QbikWQGlSGZqe6r17QKyuIRyqkGD6Da5tGA6JEFX
         6no2TpIPwGDPnc1teUifkXYEywplS+GHwrqQMANbobNsyN1MX40TFiZBVFnhRuk8dS/X
         SWr0ZDgC2OGjcy6elgczjbsE5+Ap1Eu4FLzspcLDdW/TvTkPUeFxLn54WV+kjv1oB2ug
         YrG46qg8iNGYu51vVZhmCrkNB30AESJ/h6DH7nFFEro1KjD4XTNDFjOqqchtxnmSF+Zk
         s6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712826336; x=1713431136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThLGpbeHjKHISy6v+wWhWzlM1AmHv+Kiehy1oJijdu4=;
        b=DZomIvyfDgGK758dUq8pQ7ARNKtZw/G8xh3GPwpm8fajx+IPY9NARdMHUQ4Uoj2LPQ
         JtDkpfOwt5UHdKxv15Qo5JMjHebh/RxCQIUFW0p2LApuR+NQlmPCsT6hkwuwcdoWYD96
         tYWgNIpt/ykNacgScvUq4JdiEPTpF0Ktf0Mss6t2QqvvtiUt9w+4kdHjYiuJfxWNbRe1
         n3BeW7vswyLVnssnqTGmscq6k4bgwdDjKnBJCtcmM21vljILck3ulJCeU38ozQ9o3E5T
         PF7vOEw4FtTY+zssSizW920Fwp863fTXl3fEqOmRmF8XyFDUOtbsVqgZUHioxBdlEnFb
         WktQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHnEgGZdHxuiO99ngNYAi0y8KJTgkyJzL2lQPSmNOL+ESj/ol6NwOcEo16Y8qe3Dakqj1FakGUJtQyD4AcyGRxQuTrijg=
X-Gm-Message-State: AOJu0Yy2kj0dTLEezMsXRBEtkM0O+flg/3onj8Kungk4daDz1nRP8toE
	rtUyD8Jds+YuLmgCooUjX7Cvfy0OHjqzIZQ2kLcZiUVWznAUlguI
X-Google-Smtp-Source: AGHT+IFTY79T++ZLVntjb/YvHujT/vlh2HyBVoWR1sjZgibIrmibZdxv2OPUYMdSc/Jlz/ExOtnfFw==
X-Received: by 2002:a5d:47c1:0:b0:346:bca2:6184 with SMTP id o1-20020a5d47c1000000b00346bca26184mr949714wrc.0.1712826336250;
        Thu, 11 Apr 2024 02:05:36 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id m4-20020adff384000000b0033e7de97214sm1279914wro.40.2024.04.11.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:05:35 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iommu/vt-d: remove redundant assignment to variable err
Date: Thu, 11 Apr 2024 10:05:35 +0100
Message-Id: <20240411090535.306326-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable err is being assigned a value that is never read. It is
either being re-assigned later on error exit paths, or never referenced
on the non-error path.

Cleans up clang scan build warning:
drivers/iommu/intel/dmar.c:1070:2: warning: Value stored to 'err' is
never read [deadcode.DeadStores]`

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iommu/intel/dmar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 36d7427b1202..351be9455214 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1067,7 +1067,6 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		goto error_free_seq_id;
 	}
 
-	err = -EINVAL;
 	if (!cap_sagaw(iommu->cap) &&
 	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
 		pr_info("%s: No supported address widths. Not attempting DMA translation.\n",
-- 
2.39.2

