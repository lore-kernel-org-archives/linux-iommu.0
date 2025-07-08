Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313F24169A
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009549; cv=none; b=CEZCdz3jV20M4VCkFeM14bAmzSNvBbVYZuUV3WT3AA0GHtpq4Nj0klpllfwzLla0eFiukfZ8NlKxTVEC6Y7fmEorxgCDHilOAsIAbgxTs/M41o94YlhG5o2bw1DZM2R3djylAZ1hujPp6ywkvhwu2OveBF5ha8AMH+6CyH8KTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009549; c=relaxed/simple;
	bh=/r2lCkVpHjNdcNoQl75PHhSNBW+eTSqrGZ8u6lL3il4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bDRdQQNZtvWpYR8jvs4bEdCjPlgQOvn6nZXjX0T2dtTpGaYUwzWMyDKOXlt/fzlLxA1HlxtUVvGrAKVYKeqMreSQQv3F537ltY8YWk1kb1UUJeDk326AdxP4x249iWgIKxDnX13P2UYF93Df1DPfmWP8c7uHSkpJkYmvDdsT7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KKSzTNbQ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKSzTNbQ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36951518so5785073a12.2
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752009547; x=1752614347; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N9ppbA3Dziw9f+Gq7+g/lqzO8ZWjV1AZzCW5sxUxza4=;
        b=KKSzTNbQ5TNnWjYXEN3JL1GlePTLIj6odPZySpWGUcqGS9W+GC1RApL8F/HR4RXbyM
         HN/icTrlYIWUwkNKzGZ7t4yYre0t+1ibq00Iup5/1xKNV5hDpDmB9gh//ypi4MxuHI2H
         5TbymDMzUonnEtvm2gsAM+aiZohtreVuZ6KbdQll5gx1IxWdn0wZKIdFHG624yF/jJwG
         H3VHfTkMLmZqPrzrEUT76g6ROE2N3ZvCZyhDR5WPlUAPq9dY5AoHitKYdrIVOK5W6fhR
         oSSevSehOFu4/KRDbtp+oVLg2LMuVelx6z1CBtKWFn/CxW0HtaXwnc5PdJI7QJQaA0Vz
         WgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752009547; x=1752614347;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9ppbA3Dziw9f+Gq7+g/lqzO8ZWjV1AZzCW5sxUxza4=;
        b=b1NGwu/NZMPvZQEM3oNB8pP58LWDwiHlJaXjbtqvmRkW2IG1kTgWov0ze9Xd6eIP9S
         doc4vVQD8HjBbrQH5/J2jlST6FEK2+09da0HkqsL9v+DBqm6x+shZ9qe2hT1jwY5tFfI
         i9WtyAgx1g1OQqiPnYnsMaQhA32W31QFOSoJBsYz8NcaEnQ7V0X+lpdO/tLYQnmKD15w
         KSRj3wiwEbqWpDiiJtd+QYfll8UqTwJa7Qj0BzMluRpyuWC1tYxIZtWOmwFhSw0cpwWF
         hbmIv2gJrg8coNofxsuAl3CyfX5zoOVI+U1sOSKV5BKkLCGAN/Nyz3ePeaeGomaqHbrl
         OkFw==
X-Gm-Message-State: AOJu0YyiIYafM6+O+jIK+6LymTepq+usn2TF20/oSKsqSgbH8xj4O7vy
	RP7Crjez2g0dDYQ2Arhy5dpuV8tkKyOwgbJgEPyyy07U4rphipg+R4IKNMunZIKd30HHzqRvJyX
	9+iCwMCy06sTGSg6BVrA5JGrVok50flxthTx6fbuVzz9QqQtdU+uyKpC9b7MgwN9NeT2bgzbfds
	I3HXyzPGZzhy7tC282WIe28BjhyIzsdK2oYtr+3AoW2jwF61SuGWGlAycwySU/SA==
X-Google-Smtp-Source: AGHT+IFRfw4pTGFX/9EXPFjhu3f/ZefIS2qykEOeZXJTgQKNfsuYTs/2F1brghTX77EF0NOj3G+FJnQVPa3iukxtjg==
X-Received: from pjur4.prod.google.com ([2002:a17:90a:d404:b0:2fc:3022:36b8])
 (user=danielmentz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc8:b0:235:f77b:4b0e with SMTP id d9443c01a7336-23dd98c1b3emr17254305ad.41.1752009546961;
 Tue, 08 Jul 2025 14:19:06 -0700 (PDT)
Date: Tue,  8 Jul 2025 21:17:05 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708211705.1567787-1-danielmentz@google.com>
Subject: [PATCH] iommu/io-pgtable-arm: Remove unused macro iopte_prot
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Liviu Dudau <liviu.dudau@arm.com>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap
behavior") removed the last user of the macro iopte_prot. Remove the
macro definition of iopte_prot as well as three other related
definitions.

Fixes: 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap behavior")
Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 96425e92f313..7e8e2216c294 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -85,11 +85,6 @@
 #define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
 #define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
 
-#define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
-/* Ignore the contiguous bit for block splitting */
-#define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
-#define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
-					 ARM_LPAE_PTE_ATTR_HI_MASK)
 /* Software bit for solving coherency races */
 #define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
 
@@ -155,8 +150,6 @@
 #define iopte_type(pte)					\
 	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
 
-#define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
-
 #define iopte_writeable_dirty(pte)				\
 	(((pte) & ARM_LPAE_PTE_AP_WR_CLEAN_MASK) == ARM_LPAE_PTE_DBM)
 
-- 
2.50.0.727.gbf7dc18ff4-goog

