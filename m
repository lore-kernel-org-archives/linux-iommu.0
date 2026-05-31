Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A732DCC08
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246979; cv=none; b=kFrv2U5SBH//xfKcDMYjUdzfrywrnuFdYv9m/Qk4WnTRumolWPtEF4BzuulFpVH0eGE2BGjAzmiyLWLRr554rTU7FkHFVwYVuMAzvZj/tZ0crTgRbW5mNtcd02dAHVlI/CkCW9/9l4O9XMYUiPy5ngx5woBZXN3HieIZuEb21dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246979; c=relaxed/simple;
	bh=h2LShkgTS4F6cLrC17qtgcJSfn+9wJYzg3Z0SdOtgEk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q9gK3DnrmadlkRuwaKHndnfMvJXPOIrbRtofIfvH5gtqt9CwZO/H7l0A5Vllc7sSKCKo9GTcBCtQMXSqRDhKqix15fZLNjaWH0JsKwuUzCMJwfJ69zpJKVvAniNn4QbiGwRGGfNeqvjwn5hAZfweibDX5cK4gr/QjyS+ZsFOieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFE4sRee; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFE4sRee"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so387810a91.2
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780246978; x=1780851778; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f5OhZ1yeh0sgmy7BgKOMHnhO6M1dzf06o5FBbczTnR8=;
        b=BFE4sReeZ9S7z9gYWkf+BEEFqub24voEwiK07UvUWvwdN6YSqlBpBJ8j3l/6LAlUf8
         MH4FTOPiuUTsw58PlmzTGXRVnemwafuDq5XsE8eikil+N+oGHASxM1FHhbzgMRsiavJh
         YnnP+Tufvgi5tL6raO/8N+8qLBkaVbBZRSPp/TBfQAJ3o+bGQ0MRpJjaiz6513S+nK84
         il+vco0EV0OTlO9o0h6jqjj9sy69UpFa65xf/do0LfuKHuXX/1KFbnithILekC0jO/qB
         yAM6VgQkK1bA0UONC9uzqAnBiMc0EaK3FzPAwBazNkx0fu16EPPYixCEhIv3mf5DGHeZ
         n7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780246978; x=1780851778;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5OhZ1yeh0sgmy7BgKOMHnhO6M1dzf06o5FBbczTnR8=;
        b=ZD2JYfKI3At0DvrVcgx0b4QSpC5kcS5Fg8ZipCmv4L/nEze5rXqxGSVa0qnj8dtX43
         jcsoYxZ9oXvKlrrwWnCK+0BZFZ4T3kRBdJPzFmIjXrq6+YQ/3WNKh3P3AdkJwIYdruwl
         2TFLMqhFRRPjs8CeKa0f2wlWv3PavwcF8HorCIAht6nJF/a/pauBsyKaU62p9uLcMEVz
         VhA+qwUe+s0i8qC0JhzwG9ALnYDLISPCvd7PS59IjklWAetb4akPTuBTepQs+AKMaiel
         xOptxmAwUOigKQqeD7J9yb2UQgbwuineskFETvimfngikGwxy1ON30eDyl+zcLsSulnx
         N0Dw==
X-Gm-Message-State: AOJu0YwiP14Qjzuo90d0ofpPocg3m3bpDtfRmR8iFEgwtEAgfScAnQ2i
	MAnUurYZZ4wnd5d6WQH3pRgb/WKdgPMtLav2sX9iu4n36j4R6ZibRs9EFo48xEWOUoI45Hzif4c
	xnhCYsNmryXTFREoE/qWAFZV/DcLQmNdE2FXvqTpx2Pab4MuSKBcmgBc3W2adRwrggez5E4ZBef
	kijleYk8uQAzrUTlfQN6GKZAZyv1VZ4A==
X-Received: from pjbnb13.prod.google.com ([2002:a17:90b:35cd:b0:365:d006:6df7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2247:b0:362:e826:cefe
 with SMTP id 98e67ed59e1d1-36c5afb8e7cmr7852408a91.23.1780246977491; Sun, 31
 May 2026 10:02:57 -0700 (PDT)
Date: Sun, 31 May 2026 17:02:52 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531170254.60493-1-praan@google.com>
Subject: [PATCH 0/2] iommu/vt-d: Fix issues on probe error path
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses two pre-existing issues in the Intel VT-d driver's
probe error path. These issues were identified by Sashiko during the
review of the ATS series [1].

The first patch fixes an RB-tree corruption that occurs when probing
non-ATS devices. The second patch fixes a UAF by ensuring the per-device
private data pointer is cleared before freeing memory on failure.

[1] https://sashiko.dev/#/patchset/20260525184347.4059549-1-praan@google.com?part=4

v2
- Updated the Fixes tag for Patch 2 based on feedback from Lu.

Thanks,
Praan

Pranjal Shrivastava (2):
  iommu/vt-d: Fix RB-tree corruption in probe error path
  iommu/vt-d: Fix Use-After-Free in probe error path

 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.54.0.823.g6e5bcc1fc9-goog

