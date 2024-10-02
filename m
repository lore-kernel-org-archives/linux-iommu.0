Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362823BB
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727834043; cv=none; b=kTRuYb1kNOhVM24aUMSLYP6oou8psJXc42SZf7+6Rh0h1yyJu8GM5Lks8qT5uzabBlO95QyJ1xWFJC9mhqc1HYeWEQbcKkfHlPPS5VNhGS5ulZnZTE+v0HcaBvDrCs1Dh2qCTJ9IxMbbSy0KSbZy5s2sIDfKouFPtDtRpuL2APo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727834043; c=relaxed/simple;
	bh=iPmQ53/8uwlzl108KEIavw7gfZhKpeC9rw9spHywT/M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZPzj8ICDA2Q7fx0q122Jkflv/+XJ8XVAow+gXoKxAj+O4n2sSAfIlw/txgeUT0wrsTdudRtF2bB3N3gET2ERXnCPLhxyEZA7Td4ib1hwC6DyAKEVLHCEe9BcZEns08yTEEvjvxM94mscrqR4sLxIFydh21bLdmPyfwasv72i9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1Rpos2J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1Rpos2J"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e28b624fc6so38063417b3.3
        for <iommu@lists.linux.dev>; Tue, 01 Oct 2024 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727834040; x=1728438840; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwNwLD5VPrrbmrHEO02rJObyH9FboBGpkB8LL0CUjZ4=;
        b=b1Rpos2JbVTSEAR25LbpChW4/h4c7Lzk06tfGuJPJjEIGh9TIyEXWKH8Ut337zhVSl
         f+xOy3Q/mPGuvn0LZbI9BV7B+LGKA9pmgW3tqM4DDy9cRn7iyEQfxYqrJRlMPw4Igo5s
         I8CuYfIe84c1VcHQm5JThgJLiN4Y2XdMHJKUgKb1zRW7AGt3qJe6x2kdQlbLqruAh/MY
         WlMXROw6MVoCWbeCl3uFeIdZP5HHg/qRMbrimn+q0EMgJ0R7HdCPTVxe2es3aGobtKuj
         210h1smxDwe7dp/qx51r06Mk62jzqMCzjTkZgqH2iMz7Hprm6+WejOgvPK8t08IOpj1l
         dCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727834040; x=1728438840;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwNwLD5VPrrbmrHEO02rJObyH9FboBGpkB8LL0CUjZ4=;
        b=tai5UZf0IZMhHJb6k3lzrj3kX+zSctXlv0DnKCBsAOnaZSFNizrpEH0qcdrjLtIBbB
         A+PfVlmyLQRN52tZuNCWXbK/3BdpbQ4K8RWnOw9MbIU7N44Wgsl3p+Bi40YnfvOxmLCD
         BNgkX731t2FxrHQAHbzaM18pL6aGTEmotVAO4q51t9YsbwpiJBHo1YTDWKHx2hcSB5E8
         EVJcZOj9/+NtQ9Fxis67OaEE3bXFTw2H064+TdF7dCBoK4qNgI8d+CBcMLQR9gZ8cmiG
         V2QCf1rP4L3ZIpreNO3hOBuVWzmmMB/RsUxFD2xA/MM80nB1YJHskTVwplF1OJQkLCXf
         KQFQ==
X-Gm-Message-State: AOJu0YwOBcSy0ZNmmbx4/TIBSf214eglu3RCDNzRS8e4ANwWG8zGCU+x
	vF0em5QqZeGg4tIjNhpThRh00AuPNDsuwC6ifVmdRmUF6JkB0onh6lez6NVx1CARIyw7sTB6Lnk
	6QtjbS/9o3Sc3r7IcmQdFycbxYUp0/Vdwfbl+CnR3DDgAaSZuCcrKU/LQV8fGgOeCJmhP/hFsSd
	qZrYnqsr6e7i4+FL/d30BJURlJW4GHRFy/jDVz3zOjreUWlNR934yfa1OkCA==
X-Google-Smtp-Source: AGHT+IEreRxj3UJ+eyKPDi6Sf4q3fIvXsjlvsCIK555j7t8s/9KSqq6Ritz7lEozWnEFR990rByVwRgkzbJfngDmfw==
X-Received: from danielmentz2.mtv.corp.google.com ([2620:15c:72:202:bd57:7475:38c3:b469])
 (user=danielmentz job=sendgmr) by 2002:a05:690c:7090:b0:6e2:1ab6:699a with
 SMTP id 00721157ae682-6e2a3064928mr211467b3.7.1727834040420; Tue, 01 Oct 2024
 18:54:00 -0700 (PDT)
Date: Tue,  1 Oct 2024 18:53:57 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002015357.1766934-1-danielmentz@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix last_sid_idx calculation for sid_bits==32
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, Ryan Huang <tzukui@google.com>, 
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

The function arm_smmu_init_strtab_2lvl uses the expression

((1 << smmu->sid_bits) - 1)

to calculate the largest StreamID value. However, this fails for the
maximum allowed value of SMMU_IDR1.SIDSIZE which is 32. The C standard
states:

"If the value of the right operand is negative or is greater than or
equal to the width of the promoted left operand, the behavior is
undefined."

With smmu->sid_bits being 32, the prerequisites for undefined behavior
are met.  We observed that the value of (1 << 32) is 1 and not 0 as we
initially expected.

Similar bit shift operations in arm_smmu_init_strtab_linear seem to not
be affected, because it appears to be unlikely for an SMMU to have
SMMU_IDR1.SIDSIZE set to 32 but then not support 2-level Stream tables

This issue was found by Ryan Huang <tzukui@google.com> on our team.

Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..b55327d6058e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	u32 l1size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	unsigned int last_sid_idx =
-		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
+		arm_smmu_strtab_l1_idx((1ULL << smmu->sid_bits) - 1);
 
 	/* Calculate the L1 size, capped to the SIDSIZE. */
 	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
-- 
2.46.1.824.gd892dcdcdd-goog

