Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19F1CD2B
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741238322; cv=none; b=WzqgsvoIxShoEt6ygA/yKjVVe2HpwI002h8UYv+TVvUHFLNdONF1NBkSaSBNMXgnBOuVDeKFo1v0u0c8CVYXnydj7VtVnw0Y/g/gm16mFcgEIWKFlMPNwv9HW+J+9VAwkaiSUqsW9HAw+u55u904TUCMh0WCuUc7Pzn94PPId2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741238322; c=relaxed/simple;
	bh=bqnnQoj67Yy7FVaCgMfaUiRBSx45piKOGM6OjRIjMd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/RtgCjM5/tAJP5MFidZM4hSyAYGg+l/UB7jB+swneTYTOb83VpJW21bm7W6wqmYlmFtXRLB68AsUnzgG8v5OOfveBs6vIHyRVVuXh7GWb7Y8JLs42ZfnOt4Pnwgoxbw5zlVCKwGQz5yRbwqaPX5HDN2WUJrIN1QBLNAOxL+Ivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky8SVboe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky8SVboe"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22398e09e39so3190305ad.3
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 21:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741238321; x=1741843121; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNP741CtQxhlrtQYl+bTHrt0/2VLrt4PvoQqY1xd1+k=;
        b=ky8SVboeMxgj65bzictv6LI0VTHwlhvHRzbVUXQxKPIYQcFJe0azoJjxgnI+yW3HcH
         6cxtSebGt2xQCYTG9xKQCp5WMLdKlDua4yW+0UQma4ImVwt2fSCR56vWzLmp7pA0LrKN
         1HvgLmeCdPhj9onuyVkFtDyXCQzzrcH7B7GNfHJPfZmlSKketZBH1FAVfwkMRsKSusrt
         ClgdUFd2LPbidrA8jQXR56Dqu8H/4QFNCT/YsPzHK8dkJfwVnk8VEtdWtLJvH1kPXrvT
         DVxU9s/jlUXnstleC61BVqFNgVxIA1Z7OPCC2rbTKD3B6iCmKL4j8amuxb6pwqIUHkwo
         FIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741238321; x=1741843121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNP741CtQxhlrtQYl+bTHrt0/2VLrt4PvoQqY1xd1+k=;
        b=TqkyEtIC1IzC9Os2b3EPfcjQQrqhyZ8DJ0S+uA4a535IZeDXtvoGs+ngV2jC3J25nE
         65mjybQlmM6DDEGn7tUJGdzSfspntnGQc/Ay+ZlUZZzxUZhJcOrnO7NgM4bQM1hDHyPD
         kbr608bmjLEP7k6K5cCyQrv2L0fsMvZuoPA9WhO13wuIh2Xs9KeBctbLtfbbXfYAwlT/
         KOAvOEDP+odX+hsZUMDMiVYluMpb3aUh6Kmy46rMSgPYCEdF6gpdOH1MXYbxW/caRjQD
         U0UXE0iwLd3F9FqsqKLxFdurc2k4u2fSNBOU7WaD+OLrMgFLL77QIRMfVH+XaPRX/st6
         bYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6yGZPKLpdbE/WAgqbsMpoSbap1zoSaIquGs6cMjuJ0qMW0p5pnfHmf+n8mOCn/Xnnpv2O2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpUaF8c+8YMRl0h7241k92owTqwEUW/he3E6WGhw6nXaV69EZp
	oLv+8c7bfXEvv5fr9AxmA1Zq6gTE+8DY+LafzJJbBZz77+v9KOc7
X-Gm-Gg: ASbGnctbouIgLk29nY/R1A0kKzQ5/B+M95OVNQ+I5/bR+VxYhYYHFqjw+Qi5BWyklBR
	07BQy9tIiBic0zTHhideCQBLmd9bItlxnBs2t6UuP0OcNshut24xIOqMd7dvR4kxI14I5vt/ghi
	aXPUIvqXXL6S2xNzu/0ofSe+ii9Cm/bP8tscBQsBnRiDm9KSXtl+UE53IPO4OROVftHUCLqDJCi
	NjHzF3L7SjH8p7DUBCWJrfr4VqYBGaAAPQq2jwDbu0pEeKIBXwHh2rkHfR6FahThTfzp6woit8L
	ZclOLQR9D3jgCBxEQjNHdT19GM4vFxF0EFNt+JzYzPdUzmmb+JuIFEjwKUuyAbfVHAYgGAZmWfL
	b3Mex8JaOqF64jQ+tiv80rum3OwNNO7753FNybk63mu5KUQ==
X-Google-Smtp-Source: AGHT+IGmB5z3KokiR0t+qvpxsDCS1ZtXYiH0T0OZsd2nmtwUeBX2F4OmXpBlbHbee6eDUemX0A/peA==
X-Received: by 2002:a17:903:191:b0:220:c4e8:3b9d with SMTP id d9443c01a7336-223f1d0ff79mr79888065ad.37.1741238320728;
        Wed, 05 Mar 2025 21:18:40 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([20.120.208.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddcfesm3332345ad.29.2025.03.05.21.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 21:18:40 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: stable@vger.kernel.org
Cc: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.huang2@amd.com,
	apais@microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH 6.6.y] iommu/amd: Fixes refcount bug in iommu_v2 driver
Date: Thu,  6 Mar 2025 05:18:22 +0000
Message-ID: <20250306051822.4267-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix addresses a refcount bug where the reference count was not
properly decremented due to the mmput function not being called when
mmu_notifier_register fails.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/iommu/amd/iommu_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 57c2fb1146e2..bce21e266d64 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -645,7 +645,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 
 	ret = mmu_notifier_register(&pasid_state->mn, mm);
 	if (ret)
-		goto out_free;
+		goto out_mmput;
 
 	ret = set_pasid_state(dev_state, pasid_state, pasid);
 	if (ret)
@@ -673,6 +673,8 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 
 out_unregister:
 	mmu_notifier_unregister(&pasid_state->mn, mm);
+
+out_mmput:
 	mmput(mm);
 
 out_free:
-- 
2.43.0

