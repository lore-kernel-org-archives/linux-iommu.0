Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E816B725
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495990; cv=none; b=e6tcHaWNlnB7MYjHyxgf7lKzH27Vr3dE2P7r6OFgSL51c+udvL3QE/zND+vU8VEu62eUJ0Iv1Q8FD6A8yunVCsxGB5pxyuaz8JAKTMYuJNFE4XRAx1cKQIlNi0bX+u3Dt/ul3m5qS1qDIuEeGEp42kfT+fayzKqbFgSm3Xm6YHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495990; c=relaxed/simple;
	bh=nIOrVokjny/dHg7RBav1tg1ajJ6o6gO3zIt0EtRORw8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qBLqdf/BACcv1BvMNfBGxEU8M/uyMa4buuXrPnPN16xmgfbN8KSYoHXcAluPoJAIg1wA7pdURsvc5QfH01bYiq7t26Pn0k2ztxLCVDzmipujdovQdBfzt+imUVZojTbrBkmFBJP9IIVybt02mz8TZ+9m14GpjWOCsUqZQzcDEsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpMsqYmR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpMsqYmR"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so8099508276.2
        for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495988; x=1724100788; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88bVHoRsxbRrvGL5pbopsa/PY4mJcz4Ns16/n4GjTEM=;
        b=MpMsqYmRwSyJXrEfvm+cXZSkmYQY/SBPxCD3MwHzfJ1W7e1J0/cNjB6KPdQKjmOSeh
         cuHP9leQZrCDKHE6urGAC03a1Ljp4tlebYdChYbR9xasH/QpAjtcwN1pq+uLxMI3+TC+
         wQACMkEH4z9Gc1KmyvlKYOhawtXDSb65/o83+H7GhyFKVm0PTNc6KFK/qqwQ23LJHmjK
         tK5znKzg08j5gz2CRA2CWvqi/8EG31bPQzxM4X5a9/fRtI2IV8ZsasMsymNA/SK1VVyX
         zxMSTD3nSoNjjeAyYHKUN23fK9JgVERQymiGRMxcCSp1uCosryQC7U4h7RVF7+G0Ruqk
         GcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495988; x=1724100788;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88bVHoRsxbRrvGL5pbopsa/PY4mJcz4Ns16/n4GjTEM=;
        b=f3QeXTfRFxz4le/bmrFfjyI7dzSA7z1W9qZjAu/Du7D9jKvpMTLgXVl430ITfo3+WE
         TtFqoeCaJ9nFqpdliRb4FXI+XEN0m9gUnPlZyGs3qdi64QHPw9K57gzFsgiajVrBuw30
         iJ+q/zLhXPHjfB0zjQ6jER9rQDmRlIU0eIKbkFDj3wtCdmWRYPCld/FOCQDYvNjBkgK2
         RPvFLOdzg1OXfsqgiOJjECw0QfQJwLRY191a+Ufqg3Mfa3edzset5QxZDQpdzNkWPkok
         r51NetVd8g0arxHER/vJeawfkH7yHGI/op3RDLTcCm2m7SJjy26EsVED7hRIYVMGJK25
         TEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCZQePXhfOlQgYLFlVSTNEJQR0LKEaOU79v23o4XsIV9C8PaWioPSlmGwRqzYEJMtJ9XtbcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTyS1ZhZ/S8l1ojsVBR/jig1tGzyKtksoJMZvQQPES973YkeqR
	2J7YS9P9eKvuRqKZoTiuX5M6BIIJYKMFPtkENGq+Tsxtky5yiylq9hUlqeXUiNmlLorBsle3Y6d
	y8jRvaykatw==
X-Google-Smtp-Source: AGHT+IE+M3ZD7kW5OEAx0JM3HgxM7/yZxSBsb3zBQBn1c1T3spqqB7uD0VloVa5DqUJLt3JAncTwC2KgNLBnow==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5b:483:0:b0:e0b:f69b:da0a with SMTP id
 3f1490d57ef6-e113d2c151bmr2350276.12.1723495987868; Mon, 12 Aug 2024 13:53:07
 -0700 (PDT)
Date: Mon, 12 Aug 2024 20:52:53 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812205255.97781-1-smostafa@google.com>
Subject: [PATCH 0/2] Fix handling of S2 stalls
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com, 
	Mostafa Saleh <smostafa@google.com>
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

Mostafa Saleh (2):
  iommu/arm-smmu-v3: Match Stall behaviour for S2
  iommu/arm-smmu-v3: Report stalled S2 events

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 23 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
 2 files changed, 21 insertions(+), 5 deletions(-)

--=20
2.46.0.76.ge559c4bf1a-goog

