Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1831487F3
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339637; cv=none; b=niqEX1W5UPcoY8Sc+husdMQ0T9JcrSshKj/Lgha5Vj2wugjlxrRhjDOvUox6mgQFjOMnhNqPvi0sIOF85Z1x0L7SmPHnrYTTZoQlRGl/V4u2j5ole9PYFjeJgtttsNMhSTvRpROVU/sypYXaiuaxO+QhKkAAY0PokehSQAQzayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339637; c=relaxed/simple;
	bh=fCWkZIz40C66c8ZuJ4q30JGVy/DoIJa9iLkeIwQ83So=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qbLUV55O4OLwpZAw8TFzwPGtQgG9UgF4ruGI2UYONlsW4DQSv5Mz20ayNKlkg+8LOWnNG2bFXTPtxVMMVdgz57vGyqIwNEruFy8W2tMMyaaOaPpXTQgXXDqTWP1iWV2v3ovUGz08g5yzCOGPYFYmp4xS0CIhl2gSPs6KlBzS9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AC/FAnA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AC/FAnA"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61beaa137acso225143637b3.1
        for <iommu@lists.linux.dev>; Tue, 21 May 2024 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339635; x=1716944435; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rW5R596XV/BhyRO+Ck1A05EK/itIG2yrmFZ6NrHh18s=;
        b=3AC/FAnAFCh+aEJBzEDeaDXanF9dh7Ew3KbJtQl4YSdGQNQu7oSItel9dLeB3JoyvH
         1FWKwGNYx9rPXOvOU6ihlZT8DiYn2FoMKO1whhDRI4LEVvuMdekyTLqB/+0zcocvbj3B
         AYA19FygL6efSTKlEGnpq32HHsJHiceEFY01aXOieIta0S02erHYz09Kq69Sd/JPEVC2
         P5u4xU2qMalirncJ9XjtrdyMbe3KvoBgCrAmZgSF0L9fVCpuuS7R+IAj+zWR+zEa8r/L
         lJFX45POWJfoHVHnIr+TrMlqH0q29accdO1ir30bqWeiuge9VV62n/QKT2+i7yI4tJAE
         /rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339635; x=1716944435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW5R596XV/BhyRO+Ck1A05EK/itIG2yrmFZ6NrHh18s=;
        b=qFH11fbsGbAE5jHF7UmCmHErES7EzU52HM2s9CjQGzRbpumveYgYdujRhfF4vKZuAA
         U92smf+G/kGge8tvcxERxkn956MuEFiY6/HKhz0AuzheSW2sjgHiOvHfYTNQsaYj8R3X
         x5l6jEkIpt9aIP+uarMXCjFNtwqjzAXf+z7ZKGaZA4YkUpntbVpHpB4E6JcBjKLFp9BS
         pToR0c1b7i8PrlYW40kCwhkt0ufyavaJtDoeq4qD7PcGax2GzM1ulwOaMWKb/z0j50YS
         aZhiug0L4ECS3yYZyBmNpn5biyGqCZhDFH5XU1rDkKTY4vW8S8bwsJ5ygBtMLLOwRuPk
         kZkA==
X-Forwarded-Encrypted: i=1; AJvYcCUP5I0ZoxKxmIr1hB+s+nChsHZ+ErUDk7qOcI1BcV4r+FrduCbMIWCMjBUtfzVKsm/wuups2UtjF88Dmxoj9IuAQzHraVI=
X-Gm-Message-State: AOJu0Yw21u38Y12xnXNRE07z8f0oPTISej3Qxry0a5dDd7q3nskhGBeI
	DULdUs8F1Pxp+F8pX1dgX2narRcKysg+sNn57SY9JOBoDYqODZD35/dLOR/BtFWvmMITvOuaQn3
	6/A==
X-Google-Smtp-Source: AGHT+IGfBUkXH3c2aGY6dfFSwVcPLg4SGb/q7ma1iwiCk9LmStygJFAZaLHBuK+Wl9geeHgSjlAVdx8zQ2g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:e20c:0:b0:622:c8eb:6ffd with SMTP id
 00721157ae682-627e457c42bmr1733007b3.0.1716339635044; Tue, 21 May 2024
 18:00:35 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:09 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-24-edliaw@google.com>
Subject: [PATCH v5 23/68] selftests/iommu: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/iommu/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 32c5fdfd0eef..fd6477911f24 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -2,8 +2,6 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 
-CFLAGS += -D_GNU_SOURCE
-
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
-- 
2.45.1.288.g0e0cd299f1-goog

