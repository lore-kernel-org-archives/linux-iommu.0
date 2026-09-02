Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E774AD4A6
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376409; cv=none; b=FBzdror03J+P+SbPmN7k/B22iJm049OwOk0pa65Zy+vHw3OXC9haKyGNnvNUuiH8T80/7gFAvcPFXnfu2o54YB5dXE4Ujzv2GiSjXPgvhpypyzKQV+p7eGrJ0OLjEBktxw3K2RHM1dZJX0vfWuD4aU9mCH8+QgohenNOwW8xl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376409; c=relaxed/simple;
	bh=PFLrtI8FJvq4Xkwov+zqiL8iQ5uTOI2l8tCCPKjbTGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oJRayeJfHDX62jEjXQE9DbPfOqEQBmKVEdzxOtkFJxIcrpLbruWtJ3mlVP8jLK0ZXPat1Cn59/+NTGulVr1GpLgPR9jkrEAiVJj55hgEeKiEwCR1c0MuhQ230/A+tnj/k+UdyuJ+D7I7aNh0plT0k9eDWQzNpEchcN9CBvHBVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3/cOTXL; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3/cOTXL"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so3384282a91.3
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788376406; x=1788981206; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S7KYRpQb2qK2BMI5cWRKmHlXxuXkcNUnDHM16soIFqI=;
        b=f3/cOTXLGMNjdcU0oU3bLhBMgY0cIJEYw0Xx6gWsJhKjperWRyoRoxtjlSNtTUgw8G
         6zzgZveuSp2ZlKKOyOZPZZzvmcOPfGV05QTDEO5KOAYqdMdsisHqSOeRuXaDiu/FWTrY
         Mps5CeDqRI/H1PSQN0nnvxI/3v2Z7kKTg7i2mJPgjdNU3+ppLx6BQq7adCmHzhdTAode
         ycCzC49iXPymwt8xFl/nh+FB5cByqQ/paYN26CUcS8ePB/dy2/bBHJK843mpliaVulMb
         vKd/Ueafwqq2t43Hc62mzzNJ14qCAOkPDScFdvLeD+qoloaNe1AbV4F0xetefhxApLTf
         UIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788376406; x=1788981206;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S7KYRpQb2qK2BMI5cWRKmHlXxuXkcNUnDHM16soIFqI=;
        b=D4fLTJmh2fHn18g0Rus2OG/QhYWWHuAderp0osS7+hJk+J4Ep029+AakQwnyLCbxPv
         72fejHFePS51z5/FPgynVf9sST71ugDK835//14/Ai9CdUJ/UbhQxB42QmMNInPB7JnD
         iw3hDZICbxdrzYQj+3JRpFz2hwonVpEjEmugFs24iZQkxldbb2v/BPIK154V6Sw4lm9J
         rpXzjpnEkAHM37Rxuymla9jn0EwOuYtVbwP8zrHsYJjGVXo9+kXSwvdDPTbRdHTBYIkL
         9ejAfVkHzGpgJXCpfG4Z20LLsR6hxXtRxH071sT11whikKHFt755Cbzby0HiBracDvzT
         eAoQ==
X-Forwarded-Encrypted: i=1; AKwUvBykNMJBS4XTh8enoQvzjstcVZbYlMa2EuvNvbV2rOrP7sHdNvgdroQPKE7+8WVh6G3eADAjYA==@lists.linux.dev
X-Gm-Message-State: AFuF++lwL7kLnOdZx4JsTYrJW+aVFxvM004daUN2A8RvnsHaKWoc/API
	rISJjybeNR57g3oT3R9nUGDKXR8+kW4kbqa4aF+IFynbblDh14qMgo1w1V6um4CMqjVIujLoOBo
	XGVbwUQ==
X-Received: from pjbhk14.prod.google.com ([2002:a17:90b:224e:b0:398:cd79:3b48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8b:b0:398:9be5:b419
 with SMTP id 98e67ed59e1d1-39aee1c9b76mr7984963a91.20.1788376405725; Wed, 02
 Sep 2026 12:13:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 12:13:20 -0700
In-Reply-To: <20260902191321.2644150-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260821-stable-item001-snp-builtin-kvm@kernel.org> <20260902191321.2644150-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902191321.2644150-2-seanjc@google.com>
Subject: [PATCH 6.12.y 1/2] iommu/amd: remove return value of amd_iommu_detect
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Gao Shiyuan <gaoshiyuan@baidu.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, Sean Christopherson <seanjc@google.com>, Stable@vger.kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Gao Shiyuan <gaoshiyuan@baidu.com>

[ Upstream commit 5bb494d5cbb9a3403ba8b1c8bc145b42fc119078 ]

The return value of amd_iommu_detect is not used, so remove it and
is consistent with other iommu detect functions.

Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20250103165808.80939-1-gaoshiyuan@baidu.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/init.c  | 10 ++++------
 include/linux/amd-iommu.h |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 36a814b6c4de..0e270533bf12 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3484,25 +3484,23 @@ static bool amd_iommu_sme_check(void)
  * IOMMUs
  *
  ****************************************************************************/
-int __init amd_iommu_detect(void)
+void __init amd_iommu_detect(void)
 {
 	int ret;
 
 	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
-		return -ENODEV;
+		return;
 
 	if (!amd_iommu_sme_check())
-		return -ENODEV;
+		return;
 
 	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
 	if (ret)
-		return ret;
+		return;
 
 	amd_iommu_detected = true;
 	iommu_detected = 1;
 	x86_init.iommu.iommu_init = amd_iommu_init;
-
-	return 1;
 }
 
 /****************************************************************************
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 2b90c48a6a87..062fbd4c9b77 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -31,11 +31,11 @@ struct amd_iommu_pi_data {
 struct task_struct;
 struct pci_dev;
 
-extern int amd_iommu_detect(void);
+extern void amd_iommu_detect(void);
 
 #else /* CONFIG_AMD_IOMMU */
 
-static inline int amd_iommu_detect(void) { return -ENODEV; }
+static inline void amd_iommu_detect(void) { }
 
 #endif /* CONFIG_AMD_IOMMU */
 
-- 
2.55.0.970.g62bdec98f9-goog

