Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042A17A5BE
	for <iommu@lists.linux.dev>; Sat, 17 May 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507170; cv=none; b=C+4sLMXlIscOs8UqbLYfKwPaKEDcp6lsrk0/1cfHuAP2zRBHh6l+zRChnOhyN2YRzEGQd9eBvJKlof5OEzCpOxvmsPoWJTVJTESIVHXIjmT1ZvoXI8JEEy40o5UbN4nZiXEzBTSvg+/3l83miqd5cx9ZqI/xfFmKBdKykxpGdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507170; c=relaxed/simple;
	bh=6n6vtPPpy1jIatp/0sOElN1VzMiWlrrits4IaDsbbLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hi43i8snltCdSS01LyMo6z6Z87eKDl5oZ6YrhGjP8u1gIXbB2lNof0gfzx4fqkPsNq+/N+j02X16xmAKPqh3WPHPLtHILO6/aXGUUK8t0kBFm8v6/3GV+83K6p2X585BUYc+MQV04mm3fNCoEHMgBAq7JcQnC6SSZkUbpERVC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOwJAsAE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOwJAsAE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so32761465e9.3
        for <iommu@lists.linux.dev>; Sat, 17 May 2025 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747507167; x=1748111967; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rLp3fAoKmMhFEj543FiT4J/bez6Qh2zBbDpq1aPZoc=;
        b=KOwJAsAEVe5NsH0Ne/eDXCL9JoKDw39LOqku93ASBuv/cQijNbcFEA55hR6G6mXo6Z
         QWnzjfO32KduUcKUFf823ORatjnLpBGABRqYYMFGLMmhHwmOJoLkeihqF1fhvDFZPKpy
         Ckc8eMhf40UELyTnXR3YEmt6OPrLGL82yuQx/obsto37KjAyx5jPetzHuSSN32BHpwXH
         39yjg+lFvx3ijp6LO19I3y5JM6Oo7v5k7ioURLm41czTExQlmvw/qoM/bHR/ef1UeGYB
         /ProcqjcGgkyg/zKCQrbieCAIgGSSZtiyJ+ZPdHYb5OHpDqVZOI/TWs3Am+Aq6bZ9Q7r
         +oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747507167; x=1748111967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rLp3fAoKmMhFEj543FiT4J/bez6Qh2zBbDpq1aPZoc=;
        b=QXsYOSMXRsV+ozGc3Ao30teg8OPShlD0Lr20B1IFD3dukV3be4v+APmslfZ/aJSgl5
         V1e5xgBqO+9DLXsvOwfQ28qL2c88wEKPb89sGDcTtYrwrPMsiqIJTKw6B/uru4Ap/K9N
         EeLtUGwEkpJyKycHJdTMIfLvfozRDQkRB7Yl7WEs4Ri5fnhfNhbqUcJjgkVICEDsCBJd
         mH9Qu7ALkC/2zxA1Iw98C6vw+VS2OewUcABbDKAlCri5HxL8rFO0rgu+oTNtk0NbP0mL
         aFfPAHnFI0BxeG3bUo/Jr+jiT4mU13K+sPd3vI8OxpXSxlQjxpCTmqX47H9/oX2mc1Bh
         gRvA==
X-Forwarded-Encrypted: i=1; AJvYcCWI3p9U4GlQnUBzctwuOYeu3pHNcW89rKkgPlxKfPMur910SajXQChfBRy3JiSpF1it447fag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo6snC87BxcXVDd+KRWU/EtKEt9NN9NtPuwV4iujpHoxoEn5s2
	IBDOqPdcjHDAnV1qAj6S1+ZepYXPpR8lWwAErzk9Qmr5XTGP5b+7xxXx
X-Gm-Gg: ASbGnct+ev/ObAKgrMtEd7qCtwJ+mXXPXZOJ95ltNh2xvgH6tE6kSAG9+l2Pw1qRgMz
	4F6Wnnk+O4Zw1PneAV1CwL1BPwAqZPar+xzeFT3eT67zI9Az5VSY9EConKw2G1ccv/jC24FwtS7
	x2s8xOjCkrB2Cz/aojev/N/uL9ftm9r9CO/QLEV998kg64pisn9iH8pSrHGCAemQaD21/q8aa/Y
	N9IpTkSldZtLbvz7UyUi28O/J4DJETGnrTBGA8++mC9+vSieD5vk1bsnTyElamZCzHypKKc5CW2
	CC5QWblPzBSS0qwTPt2L8PUwWPg6rkBTcB7W2s7Q6fLY
X-Google-Smtp-Source: AGHT+IHRlAl4uzkKtXrPtksBU7hfyP7MmBY3rnU4nmSgOwh1hGxpcP8yZXd+fx3IAqyEOwuUhNIGzg==
X-Received: by 2002:a05:600c:3d11:b0:442:cab1:e092 with SMTP id 5b1f17b1804b1-442fd618f88mr74762825e9.11.1747507166849;
        Sat, 17 May 2025 11:39:26 -0700 (PDT)
Received: from hsukr3.. ([141.70.82.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8caaasm6908922f8f.83.2025.05.17.11.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 11:39:26 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: chenxiang66@hisilicon.com,
	zhujun2@cmss.chinamobile.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Cc: Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] kselftest: dma - fix typo "mininum" -> "minimum" in comment
Date: Sat, 17 May 2025 20:39:01 +0200
Message-ID: <20250517183901.165631-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a small typo in a comment; helping to improve clarity in code comment. 

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index b12f1f9babf8..ed5522061dd6 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -80,7 +80,7 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	/* suppose the mininum DMA zone is 1MB in the world */
+	/* suppose the minimum DMA zone is 1MB in the world */
 	if (bits < 20 || bits > 64) {
 		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
 		exit(1);
-- 
2.43.0

