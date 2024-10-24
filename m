Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891CE1CBA17
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787129; cv=none; b=UYAevTnNcgrTKckSk5ZK6J9WXRp/kO1NK7EsMFkLEiqpff1+ZgtHl+0iFosvgWZkqZVhT+1JGpH81s6L2fHD3aE19E5du2kuHXQBNrI/oxf/Pd1EAccFxsiatOpXkrzYOPqcKvSEdTSe9jMEShSkVQOnQf96cruD3MukrjOigjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787129; c=relaxed/simple;
	bh=jmlTYrYntbS4IGYc2EP4iWxxwtC5Jg9tZX0AcgAK4zs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d3roCOo16FWJUgdHDbt3Rea2eTRa154bItib7Ls7y424o/dNZx9QIurpBPx5S67hn70EqstqxOsk/Q1o+eBcTioeygIEnCsyk8E4LnemKIFU2/V5tPHCUOPzMPCz9KkfTrLk8uOyemr5pC3tadmXWlP3HOt2QuplcvrfOT9Y8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0owVbQF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0owVbQF"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso9127615e9.0
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787126; x=1730391926; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KR+B5L4cIU9DDdYRJ/PwALZk56liTvqbQa9wbDbtP2w=;
        b=d0owVbQFIYDW6YElXrIppJbVYvINUT/MvtDnlEE3wH4ZtNjd/vp2fjStz/o6nGCLGk
         TCsVaxX3hyB05BUA05/5UV5Sq6ghE7ibHHm912tqE7BbpFVCLNbE2i5uqI4PmTQbbxK1
         PQHbBJKTo1U2cZdJB5nAOLDdxi9e06HYa6rT2FX1095BU3RkR6XAAX+RsGtdkwY6AdWF
         KKYsL/FxqZpD8Eb5WXSIaiZiMHBwrLW3r1LsfVfPSfKGRBePOu9ay4bp/Vm3p6c0Wb6T
         qcDLqkY3cehr9aKw15EMxXcLpf/wH/R7EOqMDUg5Rp7YfNqfHFsE2y/0rNO/RgIC4ZrQ
         LeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787126; x=1730391926;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KR+B5L4cIU9DDdYRJ/PwALZk56liTvqbQa9wbDbtP2w=;
        b=CPNhxJXwr9/vSxB1Wq8uP0Loo1HY9kO0yjXA0IfjtQ3mBDrpYi6raQ4ms0hIiRUAw2
         hib5VjSesgKbleImTN1GeXrtFJLQuF5fxgoKGjM5N70JWnIJXC1V3hThGCn1/4rk+3Vd
         VnB7ovEZte80k4sDydsy0FYz3TW/ruNnhwiqwSeA7B2mvDLD+1dAtUe0obKZb3iOglPp
         HdAzpQEE0gIGufkIMx9gtIgw/xdDjUkblw3tYNEkA0m0ZP+pp8GSomTvjbW4o7ZjrCvW
         EUOBdFFmUaVA44u0YhhieXOvi0etLgmANeBPDXvstWhIgmrLeKTW0Euv5yTNIns4Ki2r
         pDPg==
X-Forwarded-Encrypted: i=1; AJvYcCV448WIbUkQv6jImkl7kozuGGnIldROwnaoh+1BQwVEz24gSgwQxBI9mjAjqmebeudE931Xlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH4HKzq4RHl+AmA7QRQkFtHyuVwy8Qjr3RMsMq244Gi40Y2V6i
	XIsdhyhYQ31aN/jy6Wu/ltx/opFS1LJfdh6haqW3HPOXLKFpQIGYwDcm8E4oHWDJTPWMIZs8cfE
	l+VSLUXM7Fw==
X-Google-Smtp-Source: AGHT+IEa0fdCs9TdeI1S154h4FVCg2RPzpPawn874ObbhYWCTqLcJW9Fp8UBsiTi8lK8mBxACgZ6DDCkYsBLxQ==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:4483:b0:42c:ac8c:9725 with SMTP
 id 5b1f17b1804b1-4318c76565bmr59885e9.8.1729787125428; Thu, 24 Oct 2024
 09:25:25 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:25:14 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024162516.2005652-1-smostafa@google.com>
Subject: [PATCH 0/2] iommu/io-pgtable-arm: Fix for stage-2 map/unmap
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

The first patch is a bug fix for stage-2 handling of concatenated pgds
that can break map/unmap for some cases.

The second patch is adding these cases to selfs tests.

While looking at that, I also noticed that the concated page tables support
is minimal and not supported for many cases (level = 0, 2, 3), I wrote some
code to support that so I can test further, I can send it later in another
patch.

Mostafa Saleh (2):
  iommu/io-pgtable-arm: Fix stage-2 map/umap for concatenated tables
  iommu/io-pgtable-arm: Add self test for the last page in the IAS

 drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

-- 
2.47.0.105.g07ac214952-goog

