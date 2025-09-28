Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A33225D6
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759046001; cv=none; b=ZoMa8VtojpqsJjTzyEnSwJvr4aPC/BFs2WVRKUz9JyAeZ52cQapKBrguW++cqVGmbQC08VpZq6pAQxI+auyHAWh/GTqsrgpiGSu/sZFNRJEw1Y6FkaZj3w3ea4JOfxZeq2GjcGilMn8a71G9+CEecIGkSxrlrLxsu0z3nqaIhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759046001; c=relaxed/simple;
	bh=uYZ5IK1FTpOCbYNP61ldu2wAWMPnSD+m5gAYSA1y73M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OxVHPtSgf5vkrcFmcI3wcwHaQn9Pt46+THNLMFVPE3EMvK1mDYygGRWZD/ItAsrLoAHTVb+npjxAPNmcFqBQEo4npkTC8p8zkq5v7qGLf4y0rf9kQmCl/neHvGHHP3uUUZ8rYkJ0vtv7GsZUCdStOXiRdlwGfP0mrhj6pZuTgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Mu4xT5C6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Mu4xT5C6"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b553412a19bso2661471a12.1
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759046000; x=1759650800; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AwDk0uCNivTcVsDsRE5/fRsH4mSCZxsprGiICUsfJw=;
        b=Mu4xT5C6D3t+u5nIv2e/UuVs+zeKbKldHBT1l+ecwei+4V3QTxKLSivlKzN7fqEEtg
         F5MX+tllMv4U3e6k9FQXkLh+qwwpyXHcycQQlxAP8hwp5uPvob+uHFG2OT2vMCLIAjIm
         pGyXA2u+NSpFp58OtBNg5tMe0KO8NJ04FH/SSl9Oi4E2QmCmDIwxgrS/cbrne1b+uk2h
         0gxWSD48SUs0G4yZn3OhED5HsAwqZIPR7tAQAmCljclN5v/P3N2AuyLA2OsSLrWoWgmX
         +TSZVmfQnDepgsoSNByfafugF2r1oKGuv5sQUI7UE9At/i6mec1vnSBhzZmHRHFp7WVg
         GOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759046000; x=1759650800;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AwDk0uCNivTcVsDsRE5/fRsH4mSCZxsprGiICUsfJw=;
        b=j904AJ5RNcxr51bZV1HPNEeN9MysNeee5iIzoUicOrTBchEeBgtkDFB3MpQr5KAFkC
         rQCTAamz5Fovh9HfuTJfRwZEmnlKPuB1vcKHGXTBXjG65M5V9wqwq7ztH0Veustk+Xau
         Dqvc+oWyPvG2HsSjEeEBAXZq56cUan8yrcBs8tysyoxZFdmFrq+r3xa3JkXvMOzPjsgo
         GyNqldiRhhrYG/6NqZy64Vwv8sWd0V43ux2gYKPpEigzYZ3y9OyiEV0ffdWbr70pvXPo
         ngLH1BnNzSsUmjUWylhzCv63wjR5SjmTz6dar8YparW2PRpgW6cztGVhuCb+eLdYxj9N
         yc3A==
X-Forwarded-Encrypted: i=1; AJvYcCUo2FigGLl7ylmHTIDGHMT60ZMq7oz3WdpxgNT7wHNX+f0SEsJMsIyNp9I8b/Ib7Lj53kQNvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5SxYIM17NOxXCqcikOSBacvTi0Ej3UUOwJoaJd/4cvh4BbpAT
	Hao2YTaIsrMchxcWUcRkERMn0b6lCvfNqW2Bog+/9jVPpwEcnWu59KomL831KvlGzq0=
X-Gm-Gg: ASbGncvd+Tpz+SpKybRodEI9qarc9uICa79+t9AlnFnPpeB4uBeGsxWPb6739K05+fx
	es6uwBPbRUSneXWIl3gs76lVDjxR1lT0qACvQkd6VKVbc3fNBWF3sGOrBLjcub9CocSlzApqfFU
	Gt8uljL14jv2QtFV63cbpbd/zuoi89m1POmbRF2CGvqtQOZ42aWfJ04c2nS1BC0fn0Fsn0jeAGl
	2FvDnmoOrZwalfzm8cCzU4whkoYwHZpkoquhQUxdFo3s+CsJzwOq0On1Xv+GnTnehoTOnU3iGgr
	CZlGBx0jxCKF6lbzWRQDdtWfUuS4jvJMNVgJpiRtpluzLJ3KnC8/WsPK/sVRgHVvyYWeyiaj11N
	+DwMoSyZlheZt9MzjIRLWoL/uBvDSdleKr7xwi1kLY3UYjpFrRG5kLWNBMg3pG1roj94=
X-Google-Smtp-Source: AGHT+IHkVLr2GZuNjDyXevI+888VozHlhvOkrw3eWZlJjp5Td8JmDZsLN8RetVbQmgVfPUm/I4Rq/w==
X-Received: by 2002:a17:903:4b04:b0:271:479d:3de2 with SMTP id d9443c01a7336-27ed4a1a2cdmr126605265ad.13.1759045999607;
        Sun, 28 Sep 2025 00:53:19 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab640esm98722895ad.128.2025.09.28.00.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 00:53:19 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Enable PCIe ACS only if AMD IOMMU is on
Date: Sun, 28 Sep 2025 15:52:57 +0800
Message-Id: <20250928075257.1542-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

To preserve PCIe performance, ACS is enabled only when
AMD IOMMU is not disabled.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/amd/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ba9e582a8bbe..6e9eab365123 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3212,8 +3212,10 @@ static bool __init detect_ivrs(void)
 	}
 
 out:
-	/* Make sure ACS will be enabled during PCI probe */
-	pci_request_acs();
+	if (!amd_iommu_disabled || amd_iommu_force_enable) {
+		/* Make sure ACS will be enabled during PCI probe */
+		pci_request_acs();
+	}
 
 	return true;
 }
-- 
2.20.1

