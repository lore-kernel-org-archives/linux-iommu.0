Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D398D202F86
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148383; cv=none; b=KnLyeDSFtyZ1I+pwyIj6cTOgZqeyzBbAUVJ4HB1LiTrz0zrNXFNLFtfdmpbxbNTynBHfU7pXOFJhlHCWOI4l66bRRU2jOkw2kRTw22PnrdH0kzT00xVaqIf/eMnHVmRTbXJTW/P2Foptn5gvfl/s9zBEb8ODqZGpw2Wh4TdAxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148383; c=relaxed/simple;
	bh=RS5dr1hHxTUr8/PbRHGRwHOPVlRAKcXynximH7VTw/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M11xnWGuAamUPQQMw00gA2Ps5J7EGaY/XZFhm58l+EspNbTSd1+0eDs4oJlH0nPsm/MXj2k9hZpwVgfguhEExJoTz/itRb+5FeYG/S4Ev9j1KUHFPhN9IW9S9iTn1eOPpAHtarCXkSJeBTYxR2nGqxQbHlVszrr6LE1rCCr7XzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3dQ2apRc; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3dQ2apRc"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385d52591a6so1823022f8f.0
        for <iommu@lists.linux.dev>; Mon, 02 Dec 2024 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733148379; x=1733753179; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SqoU25aoCSve/bqILVNe5yfkPK3ql5ja78CYsjpArZo=;
        b=3dQ2apRcUgTlexImrb3vUL8Bosn+bzDzfEZ+Ecdme0HjTInqe26gDCL4Qgown/tsF8
         pZYwCz9gnNoLFP/7H2Pd2//Y8JEJlDNp5rgBFI9n8w92gsKjhX+Nn1HcsJEoVCUDc6mI
         qWFHQoR6Sj1ZcqX6dcuCjA33hfi1GHSyuzJJiuMjblXRnGc/c/2SJSxHpCFFA00BkJv0
         JY97LYPfJKV8vOKSACLCmDYO0ZlndpKPUu+w6Sk3cPY/KJs/3xJavMBznuAeMpaZVW8X
         2YPkXu980/B+o1dUaoMTuM86eoHGNtsxmjrGWJ6plsGJfyo9B45tSBxOIBYE1vvf1/zj
         REDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148379; x=1733753179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqoU25aoCSve/bqILVNe5yfkPK3ql5ja78CYsjpArZo=;
        b=ScdZOWSl50v/UVgnzAZW2KcG5P/QI54HFY3KQ7G6RBEoQ2ia3q05CEkiHRA5aF7g4o
         6bpQ6SKJ+cw59w7LGi33FejE47WB2Dv5tpHP0bXU4QzrsgrFCbocvxV6khT1iltsgAep
         eFdq1AIsN4ST5ASEFui+3vkFC0bLQFkQ8c2BRPhpvP00U7BukLVIsEaQSrdeFPZKCvrH
         1aUzAVQ7OphpmbZ8PTrNd4P8IUbbxXqU+v/6Xf9inC2Ipulo2zOtT/kdQcb78xBGIVAE
         hKyP6uzZIJ0ij3R0bFHslvML6WECFqNLgJlcAi7imffYSWMv5Ve1x54uHd7/jOBLY7xD
         eW3g==
X-Forwarded-Encrypted: i=1; AJvYcCVy0rbRojWNerikKh6M5HqP3SyMgSEfFr6TdyOzNEtpk1jYcNLe8lHS4+yPKL/qIYhyNwFhFw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyty9SVMlddV8eTFOsyHn3zrJC1obKsV4JLyZl2gSNcbPngxBPH
	P/HWhhLjP7zhnjq4wxaYitrPXEPQ3j1v0qAZOplCJp/hTVq4Dru4fyi7EMHJfBP1NfmAnogx/zd
	AtP4criu1vA==
X-Google-Smtp-Source: AGHT+IH/mcK3tOpThA64udYzGszDC0pmnTz2cupPs7OsiOzbR6kdalDJmGWvQ114eQhwNcd5X6wcHbn/kIuGcA==
X-Received: from wmrc18.prod.google.com ([2002:a05:600c:ad2:b0:434:a059:b358])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4916:b0:385:eda9:a8eb with SMTP id ffacd0b85a97d-385eda9aaabmr4970041f8f.29.1733148379252;
 Mon, 02 Dec 2024 06:06:19 -0800 (PST)
Date: Mon,  2 Dec 2024 14:06:02 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202140604.422235-1-smostafa@google.com>
Subject: [PATCH v2 0/2] Fix missing case for concatenation
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch fixes a missing case for 16K granule and 40 bits SMMUs
where concatenation is mandatory but ignored.

Second patch, imporves coverage of OAS in selftests to make it
possible to test all concatenation cases.

Cc: Daniel Mentz <danielmentz@google.com>

Mostafa Saleh (2):
  iommu/io-pgtable-arm: Fix stage-2 concatenation with 16K
  iommu/io-pgtable-arm: Add coverage for different OAS in selftest

 drivers/iommu/io-pgtable-arm.c | 72 ++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 24 deletions(-)

-- 
V2:
- Rely on OAS and don't assume OAS = IAS
- Re-write the comment and commit message to be more clear
- Improve selftests
V1: https://lore.kernel.org/linux-iommu/20241115172235.1493328-1-smostafa@google.com/

2.47.0.338.g60cca15819-goog

