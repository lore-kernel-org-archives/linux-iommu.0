Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047D11711
	for <iommu@lists.linux.dev>; Sat, 28 Sep 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727484724; cv=none; b=sBFn6jRl6Y+6svAjgRqHp108E1NZ++tfjWqP0BORhQsxIfVKkmgnjGWe86LMPo1J+Rk4lC947Cwk7GIJlRUrmbN5u0aby16pRJ7r10EGruQo9xt2GvYrvvM5lHur5aHpNXCnjqx1tdMat/p7ttQmOK5qkXGTJT1fluO9g1TBDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727484724; c=relaxed/simple;
	bh=8IKB1Bof6ihrud0XlB/8YdaT/tNQuUX1fcUtcCGoLk0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UB0dCztV7j4W5SakUVgBTiHEHaKVLGvjSlvK5uPQUadCB7g3h0RvMlybKujvYw9DFRyOpVhfpyna/6EGL2n2NW+i/NfFgugVO8nUDNAvBrYgUq6+WUUZqkAaT5ooQuJUZfLA8GZjttcag1Asw6wVryYDUpi6Qsdj/EBZh1Df00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9wlrVCc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9wlrVCc"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so4324156276.0
        for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727484722; x=1728089522; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4DfQA9kJ69Zd2DQCw/8X21quTydK3CDFF0mutF/an/Y=;
        b=h9wlrVCcyE2riLbckBiSV/3L3sBWPPQVbLLeGjF1miD7HvLYswgRMdRNw/S/Il8UZI
         +5eVTsKtzRREsATgijzCWiED4Nap+NX5zTeUgAVdOcDSI4ZHfDmX1wHbqkxbvcCkiT+L
         Wi3q5KWkHwYAHjkIBaWN6t5/RZb5mY6sXpR3qRS9VbUCeuAUt2otIwCyFIf85DPbKo8n
         xo9ioyoJeDSMRRqRx2W1XNQQbe6cSTbkEuu+g94JUj9AFGS3dg488J8wPxvu96+Uk3XW
         S96BUrtN4wVXoUfJGSUt1HPgBWM5tgd+PcSSsm2htAbiyoNENWIzwMOJz/aTSapNY540
         QDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727484722; x=1728089522;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DfQA9kJ69Zd2DQCw/8X21quTydK3CDFF0mutF/an/Y=;
        b=T02seSTqoha3/jgWOjFXHWCOJCfh6yXKJCeNIDs/6CG0acqqn8RkIXgKolv4TBXBaI
         5Hk7ypt+Kezcfy985dndFChxtDYw2zcwkXeJ7hAxHFx0CzpscVkgG5WO42Pu0jf+//lb
         EOds4bgEaNRewQP2lAYTHc8pjMish+TeMTqK5wmCj3VNRFFkIphRc66gsz8L9rIjGtns
         mFp6FrM7hdJz6ckJ4hyAZpc8RJIyxcQnWrOTLIHSeNM5Q/qoveoBtA4KnTEMxvQInQdD
         Y/xUDGcvAUGZuSuVGOv3i7wT7nWp7kLMntcOD6I984gjUnTmdmJOTCASzXFQ12cdgZzl
         yZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4AE8xkUMG1a+cUsoZTo/WgF+ZlzGuf0W8pkdc4xG5EVts+9OiSt5j5Oowxb7nFKuneMUjFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTsGUuLk5AMrfV8yJZR3XlK5K0lu0g8aA+p2mVmLRV6yf0W5Im
	wuP41sOIVRETQFq2/O05O4jBO2OgkTxCY87zjyiufKrFOpIgmA7DLXMNOuxRofxRNTq3nzHDNQ=
	=
X-Google-Smtp-Source: AGHT+IEwKlolVLdiZZVs87colfNwsTnbNr8Lmqevm1dAGhcPQoj3FnPQdJYs7z9yLRW6ZH+7v2QiWwgmTw==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:dc0f:0:b0:e24:9ec4:7297 with SMTP id
 3f1490d57ef6-e2604ca6cddmr6563276.11.1727484721917; Fri, 27 Sep 2024 17:52:01
 -0700 (PDT)
Date: Sat, 28 Sep 2024 00:51:41 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240928005143.2378938-1-praan@google.com>
Subject: [PATCH v3 0/2] Parse out event records
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enhance the arm-smmu-v3 driver to parse out useful information from
event records into a structure for better event handling & logging.

v3
 * Fixed a potential race and null pointer deref for arm_smmu_master
 * Improved the logging approach by using multiple strings
 * Added logs for STAG & STALL fields for relevant events
 * Invoked the log function within `arm_smmu_handle_evt` routine
 * Rebased the changes

v2
 https://lore.kernel.org/linux-iommu/20240827193026.3993039-1-praan@google.com/
 * Addressed review comments
 * Introduced `struct arm_smmu_event` to hold relevant event fields
 * Broke out helper functions to populate & dump event info
 * Modified the event handler routines to use `struct arm_smmu_event`

v1
 https://lore.kernel.org/linux-iommu/20240816211722.1404070-1-praan@google.com/

Pranjal Shrivastava (2):
  iommu/arm-smmu-v3: Print better events records
  iommu/arm-smmu-v3: Adopt arm_smmu_event in handlers

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 161 +++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  30 ++++
 2 files changed, 167 insertions(+), 24 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog

