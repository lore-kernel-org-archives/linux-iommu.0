Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908717A2F0
	for <iommu@lists.linux.dev>; Sat, 11 Oct 2025 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760152517; cv=none; b=qYx1kUMtLQCrcFZ7DQ7XrgsqaZNOao3VimEYqOQvrAVVbhCP6Qu26Qap/68bUKCwm8kYh9pUKRftMxPTcyzAv8e8WZzKz6KYuZCZnWMTcFqZJ/genIxWWb7WPwNshK9DSNuYMRaJyIfkfm7abIYXvp7utWSwoWS1Pw60W6IGmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760152517; c=relaxed/simple;
	bh=T5m96n00h9j0rwBj2nC35ttbnxoSv61in8rfpFxj3fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FflVNB/6FLvftSygiSuUw+d0EPmKFd+LGfH2Ak9wGykU31KQe1wnrIcMDZtpJDDohL72UnQjcdC0jn0Q82Iph4piZaRWC6BR01oPBKF8qlEiL5EjnkZO4r06uBH4YTceu2GauCzqeFaJyLlG+hieSiXIFF6v363jmMaN3tsWG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GVS9ym8M; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GVS9ym8M"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-271067d66fbso25448055ad.3
        for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 20:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760152515; x=1760757315; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xC2iEqXbWN1thmmL3fYhGYvST5k9EmpT4WpUUIQfjzE=;
        b=GVS9ym8MD0r6ysS8nVK3/z877gQXQlzC+cTiCP/EfarvvHDRnZ9VbB7WyJYKIfrj9k
         zGWy2ZOYZAbff1AkRXbqEaNxhH9ZvHnqx1i73LdkdAGibU3vuTONVgB3VbU3kn6hKPdf
         J18unpib/3t0+4O6IY70sTUm7g/OEZfiE94Rl59ClVYCJyxHW2gHdY0bMRtkzCcRv6es
         bQBAbre3bFeSBeLCS514SZSZTROXC7noIXAzET2+lwQ3KrrtQCRRVbNxf7vJmUbdPeBg
         2NXIceWVVh+3OlaoRdF4akhLbhJtaVlHiSIyn3qFlReDJI9ECaxppvZI9Kci/JYxNvjk
         qAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760152515; x=1760757315;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xC2iEqXbWN1thmmL3fYhGYvST5k9EmpT4WpUUIQfjzE=;
        b=vWH4nPg9RXVcvyooFghp9MbYJHnxuAGwInOluTqaCVxaG/+1S7xMWxxGmx/W9f/HcM
         2pbDGHPFuQNZCaKLc99WonyJX0jgtfouaiodp7LmWiu3sotQ8jX+GWEDXE9Ahqpauz0Z
         3mQQpKKOHkXIg1j5qJ0r6OVXtET+3+SKlByr6AuCePF42/Z6vJzYuTI/9Z6Se2d7UmUc
         wHaVraxqUQ6Kv7wMZJpBQHEBVd/yPqNDbNKkQQbs6oTDoNX0G7Fx7OnR/I2VsEtk+LuN
         pjZcntS14mnS8ECm5PgG9rpxYvFw1cni518ASETEv1WMyROKlQIlmFW3VdoOnj+jfQOB
         N9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmr7O95Lvec7yKgTQSZoLSfckm38cJra2sqmkqQYib3iPKdAR7pl1hLSToJFGskfgMr4v1gA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQLMPVLVPS8EaRs9kQLUCvSRDDBSB4a84wUT43WYQAiNw/fQxa
	igOmEcZHFBch7+sLRyYRWkAUMu4nxAwl9qmhSNV9DMPNmB8+GXmf20qNGcR7rApgzb8=
X-Gm-Gg: ASbGncvLqRCNMQzu7AXhl/9XH+xGQdIzc/l03skXwOEBZP7UDtfXMOEzbUjsTRzt6a9
	hJyQc4WC/4ADKVRpkjR7ySGiWaiE7GHC2F/GFKl5DCM1KxpSjM0fnB13z4F4yC2OvfE1H+P1nT4
	PuhRtvqtd3fDiCEIJ4BiPsqK9cADB97eoONwUXpLX/8jKrM6O70lqBvPnOfArtq/vAB+UqO8J17
	np/gySabCThXHfAFFbyg6ZZEzdPv4tBNkFj9ZfjKm5KDko8/z8FrEBNxEezjR6DmaU/DetnGs7d
	qiW0yh1VpWw6THv2L/DviFHL931JnBuhcLuzyTqwQzkEw1YsQ/DSHMwoJYZMbTVRX2sWPgv6Omb
	sod+aASDMeBUKBqPnpLQWz9FXGVT1xJcpsi7ByPVsHF2sNTauR2i7dM7gd5Wa488THg8x8YVuFz
	yRByXCRpoWel90hGeyGA==
X-Google-Smtp-Source: AGHT+IGazKTZCuo3QvlO68e49AlCvJAUzg/nhX9t12iwUEoG/vrNKdi3oaHu1O2JRqQ12XuI+dvu1A==
X-Received: by 2002:a17:903:2405:b0:267:8049:7c7f with SMTP id d9443c01a7336-29027356377mr203066565ad.7.1760152514619;
        Fri, 10 Oct 2025 20:15:14 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6792f508c6sm3496863a12.24.2025.10.10.20.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 20:15:14 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/amd: Enable PCIe ACS only if AMD IOMMU is on
Date: Sat, 11 Oct 2025 11:14:48 +0800
Message-Id: <20251011031448.2699-2-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251011031448.2699-1-guojinhui.liam@bytedance.com>
References: <20251011031448.2699-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

To preserve PCIe performance, ACS is enabled only when
AMD IOMMU is not disabled.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f2991c11867c..38e8c38c5f10 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3314,8 +3314,10 @@ static bool __init detect_ivrs(void)
 	}
 
 out:
-	/* Make sure ACS will be enabled during PCI probe */
-	pci_request_acs();
+	if (!amd_iommu_disabled) {
+		/* Make sure ACS will be enabled during PCI probe */
+		pci_request_acs();
+	}
 
 	return true;
 }
-- 
2.20.1

