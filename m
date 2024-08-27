Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7862E62B
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787079; cv=none; b=If3fXZswnODLYGU6UjQBmUkrGXcA4qP3n9RQVDwdzor4/sH1R+sgcwtei135Ce/8KHA7aIrYJE/qJ3Ce95XUkZXv8QLHc66IaBCUll9peDioEXVx8IVcWmOD8+Z1AqTXFBA2fJFJFS5FOL4ueyf52zFNFKuJhukGJG4KMAgkMTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787079; c=relaxed/simple;
	bh=FIeZRSqkSttQUUajSE2QJyrza/xpkARuY1BzlNk1wXw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gI+vzP7WD0e99yiWaT0nqW+o14xXGpkBVkztAf/Ir7qiuTpmpgIsFlQrke9U0AuuvhqLPuTCi+CpPXZ/QTvxEjJ2xGt6HapFNosJDb7CgLAfr2+2+vjW69sw9PZ9/9vh2O9KRIvpJz/Pz3VsxLdZ7w8ExOyPEmxKiEs8ymbkf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqVpVTpq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqVpVTpq"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e166ac5178eso11252113276.0
        for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724787077; x=1725391877; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9ngOCnzfaM6DU7nIOmke0NnjZ/DtnyxjbmtBD/BKIk=;
        b=bqVpVTpqySXv6LrzpeJMEqYdvj2BvPYTXQM/o1nCZDSnIfBfs3qiagJlinCCxipUYB
         tUy4uljatg0gGUHLbBn5Aq6+GOfeE2/pgwPxT/fEckUkb8vKwkouuLvlMn1HaTUO+n+k
         NnV/Gg0ct8Ut6vy+b2tDC2WWAFqGsaQP0Sqvw43NkXicd4wkAS5Zg8ujCNRFSD9YohSq
         3sgN5AJKqEb1gkxVmwApkaqx7a3dVu/uBBTaEyZnD04mXqU07khKTyDf7oWDGz0QbMxZ
         i7/CWQ6NVFBWII6Js2Bjhm6drL6pmTt+2nm0ZT6fSr9MFHF5lvmGhecTFV7efNnfAsa/
         ZMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787077; x=1725391877;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9ngOCnzfaM6DU7nIOmke0NnjZ/DtnyxjbmtBD/BKIk=;
        b=b4yzyYyWmfb7mvzHQyrPgkkcNBsSoaUWiAdc8IF/sDfasYJ1/2LDTu6qZACbNjxKDA
         WFl1Nu2JjY+DR+Ss1RzaVoScm8jGpwI13nMpMFMEXfxDbWg5h4KUWwNIpQ9ekRplQ/eK
         SNEv/k4Ln/tdoMKIrcvhRdKU5ADXpBlcezd6j9K2XjWe19H4L/w/KkwZgbRB5K7xA0xj
         rUxLGLUhpuxfnDBGD9kZRa92f92Fcki0dOXJfXvoOFDKjmEXYLojMu9qae7FQ4x0+E7P
         Vefew6TMXRRDey1sxQbqyTYsd3nz0GfUAw38Y2iOGRab+wgKQGcJ5tTEO4YouD4A54Oe
         jTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCURDZnB1IGEhaVUYwetuTv4/1cMb1xx55+HP2OCrbYsZy22jImoqqZosBZTEDTph3YhHtiK4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgMzZu4LStbwIYmuAIzBfhhJMxUT9XCJgvNDCSHEPLuLAm9RFp
	jLGGS7qzFP67/p8SD4qf9jDu6ePicUlfyuZq1ujl6eF+EbUQ6b0DBh2mUIg5fUH4JnQbJPqRKg=
	=
X-Google-Smtp-Source: AGHT+IFAUxqs70iiVDz2AcpzZ8TJAAstVNkkSUp2U2HwBaoxzDOaXuQylmJroyx6WuKmZ3It1GbIlxstsw==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:a123:0:b0:e11:ade7:ba56 with SMTP id
 3f1490d57ef6-e17a86451a3mr215330276.7.1724787077142; Tue, 27 Aug 2024
 12:31:17 -0700 (PDT)
Date: Tue, 27 Aug 2024 19:30:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827193026.3993039-1-praan@google.com>
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: Parse out event records
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enhance the arm-smmu-v3 driver to parse out useful information from
event records into a structure for better event handling & logging.

v2
 * Addressed review comments
 * Introduced `struct arm_smmu_event` to hold relevant event fields
 * Broke out helper functions to populate & dump event info
 * Modified the event handler routines to use `struct arm_smmu_event`

v1
 https://lore.kernel.org/linux-iommu/20240816211722.1404070-1-praan@google.com/

Pranjal Shrivastava (2):
  iommu/arm-smmu-v3: Print better events records
  iommu/arm-smmu-v3: Adopt arm_smmu_event in handlers

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 165 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  27 ++++
 2 files changed, 162 insertions(+), 30 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog

