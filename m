Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27881E5B82
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759042730; cv=none; b=sQt81uzKoy0Ts8uhLkGikexLuy5R8wmZs1mMsUrclj8gU8ctmcKKyIifYb8ZSPg11UpwVW2zkGCnbyughaYSibtb7MguLpgtFCeqaFYK0BVc8ROLF/8CQyWj5J5t93HsvHOQKFqFCS5P5OwcL918i+n+sYrGQuqmExo0QTULRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759042730; c=relaxed/simple;
	bh=9Bla6r5MFodPMwhxVQ7tWLS8XbjrbVJNG1aVVLSnnwg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KVDmpP7orOO0bMEL0HY/I7uz3blNTuRk8V9AaJ1OHfxwbAusK5hu2GgGscN4Is2tla3Nx6owGVvkY2ggUnm6/K0AMN0ESMfVByt2JkHiINIU3opnqGZ6637vp6f3Z8F/4A2nfpasX9YMQ1s1djPexRo0KGvagGSZ3XznV3AJZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GpRdFzGS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GpRdFzGS"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b58445361e8so1039556a12.0
        for <iommu@lists.linux.dev>; Sat, 27 Sep 2025 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759042727; x=1759647527; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9qb4Xv7S/9iKlar3U/z3W5+/6qCV42UQ7G2sXllZfY=;
        b=GpRdFzGSM28RVbWTS1dkBd34H/BfNdpe14fmiGrThg2vsGft4CprnPltKljmd7JhFF
         utiWZAY9bah2D0zUZd84hB42a49bZVVmNk2G0mUipUR1rAqlcK9QKT9pb2+rH+0oCqpB
         OznIRdyd042T6WUlRg+/pEha123TORqqoUY2VQ6uMn3shWMJ2t8BVmWCYkWQ4FX8p+U5
         aL8wzQMYS5RlCVDzPOKNL9nhKuEbF7z/iXCqZn7d8Dp+RNu25LoojiOtjxfM50u1LTZk
         JIYItvGtjxY0Scn2Wn+iGuIaTWH5JLLiP+jiauxXxFjPFnokb0/zE0jkyqjKfjxygLNA
         ZgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759042727; x=1759647527;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9qb4Xv7S/9iKlar3U/z3W5+/6qCV42UQ7G2sXllZfY=;
        b=ZNgOCCMphIdgWU/th0IzCvW0rrfwkvzwQlyl9HlwcGfsYvutBkdqlavInJ4Srg1tXj
         ++M0K8b140uF4irKaZGEPZkriauY2uaN39WAh6GqLCjNzxc2/bMOSXdu+Gkktlm8YKcZ
         a9jsM7G9DdDs+2Rcif5eQJNap85Uyr/2/kWse7VMn64ZxxUJKNJsIbaQV+CY2Jtns8tS
         nGAzY7t0l9PzUG9aPkGV5DZ22yhBaYvyj7S9hw+rNTfjHAwSijX04VbRivzFUMIYkwEr
         hu7Dsi5XL9HZeDGfJU2gZOJ+bIxlPJMuYTMwKRkAd6dHDJa3MSQf6C3VVZH68PGHJ/oP
         a3hg==
X-Forwarded-Encrypted: i=1; AJvYcCW/geRA2jImR834VxxwnXCah/GWk5ui7Cd2ceV/ttQ+DR8ATP3aHC0u3o5TeqrAU5EThBQTow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKfP+v6KMy2rdJ2rBszCA7KRUQGDo6Va7oP9xklw0y0nQWSk3d
	2i+BubSFyovAwKTxfmLlU4D5fxcSSji8tALB6yMxyQ7vOEIwPKiC6Ujcwu92Kh+pbLU=
X-Gm-Gg: ASbGncsI/eK9NDdwyEPCLBKNB2WWf079ay1DAEhlNkgw9PSe9MOUQ2dw4u709aeR9fe
	NJWcRC8MuWKlqJMUden1/MGzS80u492gbb2sSDvQms83ZSmMnW279TMvd9v1JNilJY1xc+JWwSU
	KMBZbISIkzG0Vqbq6nwTtz3Sj+9bURRV4nWHOKRKwhNt11jpCk27U/VF1nC3xKrKLHqZN92NBc4
	sNBu4EXuldTMsJuVgO1znLzvdrumFjntqVUT//7OE8KMg8XPeR+SjV2HsW6nIyE9AMwQxF1V1fo
	XdpwH1gHd4PFEW4STFsc1RvtrE7zH/C0dKvcnyF9x193muYZYYICJX8M+4O2LUqdqpyCUBctzzu
	gsr64SVUnrWfGGePNwNIBG0rjjlxerzhmnWhZ1xUjqU3bXMkkXyX9cPv6
X-Google-Smtp-Source: AGHT+IGzyRlP0aMu8WsFbE3pNjkGGB8M5OH35YpWtQqlIpwvlvTcJH1LjOwEOd1Ttxnx3O+rBgJR8g==
X-Received: by 2002:a17:903:4b4f:b0:267:8b4f:df36 with SMTP id d9443c01a7336-2818ba15c86mr54104835ad.29.1759042726783;
        Sat, 27 Sep 2025 23:58:46 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d32dasm97959615ad.27.2025.09.27.23.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 23:58:46 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Enable PCIe ACS once AMD IOMMU initialization succeeds
Date: Sun, 28 Sep 2025 14:58:17 +0800
Message-Id: <20250928065817.1279-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Enable PCIe ACS after the AMD IOMMU has been initialized
successfully.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/amd/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ba9e582a8bbe..b695efc54d5b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3212,9 +3212,6 @@ static bool __init detect_ivrs(void)
 	}
 
 out:
-	/* Make sure ACS will be enabled during PCI probe */
-	pci_request_acs();
-
 	return true;
 }
 
@@ -3284,6 +3281,10 @@ static int __init state_next(void)
 			ret = -EINVAL;
 		} else {
 			ret = early_amd_iommu_init();
+			if (!ret) {
+				/* Make sure ACS will be enabled during PCI probe */
+				pci_request_acs();
+			}
 			init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		}
 		break;
-- 
2.20.1

