Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0263C1D44
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787109840; cv=none; b=jQtH+Y/F/nSAX64wewJKBID/owADeubvyxbWRDISkXr233+HsQgqeC9kNYdui9oc6E18LBj8/d3RCwx9g1lz9BdKblMmXcRydOigGzAfbm1r7V1lODg+tf8Mmp1MYmFBkmw8/U9x38+KE7RoYIzLoyWS2Phgc1oHbhos64+pQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787109840; c=relaxed/simple;
	bh=twctStMz2glKuytOng+MjWv8PPpTl8oQ8U1GCHp2qPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqIBmRMmhN68pJhzkpy+gqfr1USvpVote/XI19yYy4mDhgz6ey3P2Xl4m6+Kcpy6fVK67cb31zYfIE9HxkaaI0ORMZrOlu2CP2si7adZ4c9TpBlVeV7HZvUMk469Ju7q5FX55oE1ZQMuyqTXyVNkbDkj/Lt+BSUNy2FVvCz4SX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp4KNLXx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp4KNLXx"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso3808095e9.0
        for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 20:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787109836; x=1787714636; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtEvtzniYxx4klPLqQdqNe7N2Kiz89koYkf1e8fhtdk=;
        b=Wp4KNLXx8tyW3NVnYz+Go8S/487V94DTKBy3uGo1LmsqDaYnF+fL7b0dnIPOIHtXLT
         0BMFhc5mJmmnh/6FtY6UIqVjWLahnIbevBbUfnWydn7nrv2m5TDsVmTIKgXsbLZ+RuxY
         o2oGV7FbgLpJDAS6WsLz/NvufBMH3JLqZ+qDqdgvFxw516KoKsAoCJdl4gdjjderoNn7
         jl6BEGK3sg6CMf7ORQUyfPycCcR2Ag8i3GXA8XYM6OXvtKnjgmsQaPlH5l+1snsplXOR
         BBbgUMktxS4cS9QD11/cO5kSA3ncA7G66dIIUDuR5wqNE/eAUKNcp8RmLHFNJGthWzEb
         DfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787109836; x=1787714636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtEvtzniYxx4klPLqQdqNe7N2Kiz89koYkf1e8fhtdk=;
        b=L47B3FRQYFKgVWr5RFxNtZ3lUz1NDm7nTe6MgFWQ8/6PTgoidfS0dt++ZedD/k2mlM
         prDMc4ka18AG/QQnaQ2lkJcN52S7lK3gnSww6rTFBJixGg4M4iAIxY8xBXvlc0zWUkto
         F1KuzZSQhTq+g2MZ1JsnreJD7Z/mMonA/5khMPP9kKwBTUSGFTeu1W79iknUmuNNSBHE
         vKJi+fNcZIHghlspfdBMEkuq4BP28RwTDN4oCaMGadShd+Hrh2w6f6Fe8LryXfs7FQXr
         VUggtmpCdSB5ewmdYMAAEIGw8f8LFl8WbHrRGE/Yy+OY5qAvR8NLYoP3mk55of2h/MXo
         cN6w==
X-Forwarded-Encrypted: i=1; AHgh+Rqrp5XySiudQi3DHrgPbLyOwgkbpAMsgbiMrWvykTrjg1Ov4K4/v1TEC5w6dKeveFPHdBJfFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRZWgjJz9I3kux4YPga9fDzY/6ujnTaV52UQSWKHGo+RTWUEMG
	zaE7NAur72ihCGAvHnz+faSsjGt76eMxBijeSd6HdU92Wu2q2KttQLVa
X-Gm-Gg: AR+sD12EKU3U35RlRNaFyJJP+ISsc8z0mvJ77ehD6UpbF5eNx5dqUTz7ZZNvhcdBdGR
	leE9mIHmqOwIhadyEkopMjSzSWHjtXQBGnDNxw2lHV5UUYGsAe+uJHPrHH4v+BpL4wV1MWGdLks
	1z7RLqONBwgC//nSAGa0X6FrF0zfBmVT6u/JAHaHiWuedEd1PzWbUFKynoEWwLkT+VIeaeSh2JS
	sdhnXd5pPf3cw7c4HOhrOj12gOfuMid6tBxcXHBna6v6NTZnvkP9GooqKoJKV0w7LuHb2KvngOh
	YDNWbsCB4kpJkh04vQt5F4A3+3eZqPiyte5RIGCrVdBd4Mfmj2Y5EduUP0yPl6ugb+vh4JBQGjk
	dUUMgzNJ0xtAlhNqkwR/KyRwSorsNYPp75SFxWdfhEOY7hfxIOn7zT3zNylnKOXzB0trh4O53CZ
	SI7JOuREFGeUZ0hnDpYjoYfRiFLV55WbGRa94rwIrWNwme8hWFbTbhUgN+xYJjN7Lf8x3t7fJP8
	NvuQH30Bu3GRY5E6qAQu6RSJyxEnmoheOPAB4TAf7g+W5OZgjh91Q86UgXROZCEq3rsatZj3Jrl
	WsrPdIyMAXRNQDHhVrJRMVOBAqlwyk8lcBce+uxgcGlLkKFUfhIZmzbPTNCYjeZzYpxtOruNvaF
	rha213zQAp/M=
X-Received: by 2002:a05:600c:1385:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-499aa17dcd0mr23267545e9.7.1787109835651;
        Tue, 18 Aug 2026 20:23:55 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-ae9e-1d01-58d3-443d-4fa6-01cd.310.pool.telefonica.de. [2a02:3100:ae9e:1d01:58d3:443d:4fa6:1cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa09b199sm21248595e9.0.2026.08.18.20.23.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 20:23:53 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Do not reallocate GA log buffers on resume
Date: Wed, 19 Aug 2026 05:23:49 +0200
Message-Id: <20260819032349.20354-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC
(AVIC) Enablement") moved the GA log allocation from iommu_init_pci()
to enable_iommus_vapic(), which is called on every resume.

iommu_init_ga_log() assigns iommu->ga_log and iommu->ga_log_tail
unconditionally. Each resume therefore replaces the boot-time pointers
and leaks both old allocations. The function also uses GFP_KERNEL from a
syscore resume callback, where interrupts are disabled and the non-boot
CPUs are offline.

Return early if both buffers are already allocated. Clear the pointers
in free_ga_log() so a partial allocation failure cannot leave ga_log
dangling.

Fixes: c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested with custom QEMU with GA log emulation. Stock QEMU does not
advertise GAMSup and cannot reach this path. After five pm_test=core
cycles, nr_iommu_pages increased from 17 to 25 without the patch.

Testing on AVIC-capable hardware would be welcome.

 drivers/iommu/amd/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 40726dfef2733..c6b106d5921e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -909,7 +909,9 @@ static void free_ga_log(struct amd_iommu *iommu)
 {
 #ifdef CONFIG_IRQ_REMAP
 	iommu_free_pages(iommu->ga_log);
+	iommu->ga_log = NULL;
 	iommu_free_pages(iommu->ga_log_tail);
+	iommu->ga_log_tail = NULL;
 #endif
 }
 
@@ -956,6 +958,9 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
 		return -EINVAL;
 
+	if (iommu->ga_log && iommu->ga_log_tail)
+		return 0;
+
 	iommu->ga_log = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, GA_LOG_SIZE);
 	if (!iommu->ga_log)
 		goto err_out;

base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
-- 
2.53.0

