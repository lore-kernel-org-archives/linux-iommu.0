Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D61EB9F4
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268668; cv=none; b=Kp5EZesH9k6MBdmNanxr9gnQ7O4vIj1YYoDmQ/Ewx0GdyqHJplzENVlk7RJrDmVL7s4dFWSF3v+Xx0wZXX9F6XBmBd2HIAynktM/9VQBkT99AGnWpnAiTdbIfzRQ8Z3UgxxOIz1JRCaMH4xNwL3HSgZfrl91V/T21+vho0YS1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268668; c=relaxed/simple;
	bh=X6siT8s3CW4k9IseePL4rlwYw7+Wmv7NLEATN9fI0LI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LshPJyzfT4OCr+fg2+JJ84yVrbgz1PT+oZO21deuox/cYAXnqfzg9XTOOrEOceaa3hWK27f/gZ7csruL1JD0doYCcJpCzRMdiKvQ7gi5NQ2QZ0UQg/3Ldy1PDffCMCbWNPesQ/FFRPlPjXF3KSub0eWQZEjLe8DkZUXJD3V3H3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOZQvDP1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOZQvDP1"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21648c8601cso191831905ad.2
        for <iommu@lists.linux.dev>; Tue, 07 Jan 2025 08:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736268666; x=1736873466; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BF5DOEWI/PTgR8pE1GNxutAGzAPA3gIRL9SYSMASzC0=;
        b=GOZQvDP1c5VXLiFxhI4Uo+g+Ec4D2gPij0moPGTEOJyhxi+I/JRu4Shtz7IE1ey0zm
         i85HBddaTHrxEFirGMzmkvlnNokZob0Iik+088LJTES0zixTL/ony1+R+knKtObWx+pe
         /0GjfjF5WzjKjZJJXPXx8Qo8FvfYJDOysAGSHf/u8guFTD2tsG5sNMXGXc/di+5DxhH5
         Nelb+vS+qY1U10iO4bSUuT8npEAidCnbQLzZbgvXHP9zHutq1rv0SBZf3D/U5MBRWdrz
         zjRclT0cNhP1z4wnSIFjaC97d2zlWNoGWtpj9cQL0XBXwR+D5uh7sM+wEfp8vxrCzmIr
         hyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268666; x=1736873466;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BF5DOEWI/PTgR8pE1GNxutAGzAPA3gIRL9SYSMASzC0=;
        b=oHB7sFKocpol+XFz7/FuF5CfszbbQgGnS0BeLzS3JsI56r3dvOrTafOXUbEjqGHD3X
         roIB8scKec2gXWPPeI8DfUm+3G5qN4HiVBgiB+oZZzmby2MBMX6OE+NqQkSyzVjZ6Iz5
         vgbejHNZL5ma1exlJE5Vt3GrLdiqZOUz6gn9PDb/SbXI4D/qBoWTWBw+A3U17gqWFSEO
         XkZP0itZqEhRosuTrudG9Jy7SOmyqRYUQXjQW4jAduQCtH1kJ00sYdGEv8U6WJQU+nxT
         RCOXenWKGT0QfqLjQsYqJHqyT46zh43VhNgwNU+7IkQa/SCTeW69M0Ae6sHx6jff8QFj
         dpkg==
X-Forwarded-Encrypted: i=1; AJvYcCUvHkyBU/e62Fgd/9adPcAuUWr3tvCmDVVQJCi+HG9xVMjSUxsIM4Xi4E6ZpkYPKknDCJx4IQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaeUQZY94BpIeQ9LiPDUIOWI4Sx6xLcz2TxI2oPtPfu0wg0qtx
	+MQyOaZ/UG5O3B3RG//QME8i1ZXGGjyV/rl4QZTeWVMks3TMPzykegwGuQYoRg4klawgSDAQqw=
	=
X-Google-Smtp-Source: AGHT+IGm/2cPrpciQ4F7mrZAdIN8QQ472BxDr7XoDXcaqTtzSJt+z4ITnrBOrvKzams/AwPQYbwPqKkiOQ==
X-Received: from pjbtb7.prod.google.com ([2002:a17:90b:53c7:b0:2ea:4139:e72d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c9:b0:216:18f9:528b
 with SMTP id d9443c01a7336-219e6eb63c2mr924122755ad.26.1736268666053; Tue, 07
 Jan 2025 08:51:06 -0800 (PST)
Date: Tue,  7 Jan 2025 16:51:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107165100.1093357-1-praan@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Use str_read_write helper w/ logs
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	Daniel Mentz <danielmentz@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Adopt the `str_read_write` helper in event logging as highlighted [1].

[1] https://lore.kernel.org/all/20250107130053.GC6991@willie-the-truck/

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 34b424c87be0..0e4cbb2c64d7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1907,7 +1907,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
 		dev_err(smmu->dev, "%s %s %s %s \"%s\"%s%s stag: %#x",
 			evt->privileged ? "priv" : "unpriv",
 			evt->instruction ? "inst" : "data",
-			evt->read ? "read" : "write",
+			str_read_write(evt->read),
 			evt->s2 ? "s2" : "s1", event_class_str[evt->class],
 			evt->class_tt ? (evt->ttrnw ? " ttd_read" : " ttd_write") : "",
 			evt->stall ? " stall" : "", evt->stag);
-- 
2.47.1.613.gc27f4b7a9f-goog

