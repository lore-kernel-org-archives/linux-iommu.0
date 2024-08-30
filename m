Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980FE1917E2
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015840; cv=none; b=p5vjzAZbb53OdYZjF1aofgy8yzXxQxwQmiisYkuMUsX94XkkdWbRDtI84GhNs2SAJb3dwHitcKrWW/ZYuJsVwI2xK9fzf5uELYYBVPzk3c1b3F1N5UlC4cjFkvyida9pmlEIVTr7LuhTyNn8cHd9cF0DmDeuTkPUwjOgJSc9oKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015840; c=relaxed/simple;
	bh=0ffy6KqD2ZsBlubMNAmxaGladd4Gg5hkg0zx+QhJMCU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AtQkWMTgvlgoYLAgGFud+DzQ37gLBBlSxjhAo80HntGdQqy0dIXUK4gjItn+NqP32qLmw6fDv8LpRA8YUhiUzNcjwSJlI/Bx70FnpMZ1XlM4f26arVPMb91Caru3JZMwIiXaHCH+DFVl8hkWLbtFmf+ybo+mEmVVSfinNmiB7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F88OOpB3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F88OOpB3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3e062dbeeso8805097b3.0
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725015837; x=1725620637; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obthWJJQx048EnN2AOC6zuK5QgHhreZNXc1GxoMBMd4=;
        b=F88OOpB3owARNEWHHNSEiemCmoWZtzCi7j93sIIl8kO1gx+ndcBke+kcZe5BtBawNM
         y4ecodbsaUK4Dvawwt6zndd0rkz8urLYRF1IjxRg03LmtswU7FYDsduQ32yml4hxn9pL
         PmzJXKDhtzbNjPZlLX5rviTC4MIoxYKddFUPPM4qI/kmVnp29S8i+kSrkav/j+W4/BXM
         IUGJjMFGdpSfc3cSvSiEavdofo+01o1F6fi0Ign0h3ON1qc1WO4ZZ8xiy5atWdK6rTHX
         DkZa71HGYP4vvpgS2aaQH1G60E0kJ2LAn9QBHk5RtAylZOCu+rN8/dY95D7YeUV85ssA
         mJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725015837; x=1725620637;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obthWJJQx048EnN2AOC6zuK5QgHhreZNXc1GxoMBMd4=;
        b=vFu946KJ86OMtRJ3ZYaaMG0zY6YHDde+arK2zNb9QDnSTduUQ7qEl8HoQbVbn78/1k
         bOBoeMkQuRGrWJAecpm//KTKcjQhkTMuBeUq7GFO2Z6+OrdfadLRqLSzkKGCl5aKdu2O
         5MLVutgI2tip0ZonPpN+WdEiLqTc0GEisa0uYVP2BGdHDozxCTdK28nV4JgdNZ/oAJp9
         4Jfh7HiKBMaItNhZXmGovEqY+i0PHFjjNA+oS4OraJ6s5U6yAXnmmwWsXbbjTju7H7M8
         UB8rq/Tonc79wroFxQqPgKmLoHTgaVr+vTP6jWSyCoFLpqIrcVDrP3cYebMDptBIZ3qD
         /+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWMd04Df9p+wfd0DazqEVbIS96Az91zCKMjI68OrWooJDPQsEbhO3IKqEVtfxOXEtyCaEmlnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUXpv3a+nYf2sYjotIqfDLk5hzBuoho2M2Jvs1NWsXTTQaxYI6
	SOJhtj00NMNA9TSml2lv5bQYwH7VkLaFFtnNUbuCWOhG5B7S0bYzADlLEe4IpRuHgfc7nM3B50M
	xUXa5Xmeh9w==
X-Google-Smtp-Source: AGHT+IHkyHjn4rwsHHaBZz13oCcDK5Wif55SRe6/R2eIzxGkPl4d+94YtRJamqf/F9SQM1XvqVn7meehMJtJLw==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a81:cb0d:0:b0:651:2eea:4dfe with SMTP id
 00721157ae682-6d2818a64f4mr1646297b3.0.1725015837461; Fri, 30 Aug 2024
 04:03:57 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:03:46 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240830110349.797399-1-smostafa@google.com>
Subject: [PATCH v4 0/2] Fix handling of S2 stalls
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jean-philippe@linaro.org, jgg@ziepe.ca, nicolinc@nvidia.com, 
	mshavit@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While debugging something else, I spent hours looking at hexdumps of
STEs, CDs and commands while comparing them against the arch specs,
where I noticed a minor violation in the driver regarding handling of
S2S bit in the STE.

This has been there for ages, so it=E2=80=99s highly unlikely that any HW (=
if
it exists with such features) running Linux is affected.

I don=E2=80=99t have access to HW with stalls so I just tested normal usage
and (terminated) translation fault events.

Also, add some unit tests for stall enabled masters.

Mostafa Saleh (2):
  iommu/arm-smmu-v3: Match Stall behaviour for S2
  iommu/arm-smmu-v3-test: Test masters with stall enabled

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 83 ++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  8 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 3 files changed, 66 insertions(+), 26 deletions(-)

v4:
- Add S2S bit to get_used for stage-2
- Add unit tests for masters with stall enabled

v3:
- Set S2S for s2 and not s1 domain
- Ignore ats check

v2:
- Fix index of the STE
- Fix conflict with ATS
- Squash the 2 patches and drop enable_nesting

--=20
2.46.0.469.g59c65b2a67-goog

