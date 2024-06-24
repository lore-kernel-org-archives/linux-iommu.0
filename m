Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F991A2FB4
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271771; cv=none; b=nyEh3D2zDifFguDVzM9hwjOcP5j+mEGc2N3HUb636w5NT1k87IbOEHS8tm6t1suuWuDjj/8auNqMaKXEhwFO3bZuuxBZTz/OVJyUldCvL9/ZYEZOGsF/kAaWCwDlggYVS8VgJqeM/H8YLPCieJHwR1KiMlAipft2Wik6oWKFn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271771; c=relaxed/simple;
	bh=X0lnJ8lH8/hxDl4Hg4Bojyv5HWdI5Bnk/QcwrFlBWSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OlbwRfeXjhzEPckMLVV8tmqXQvdbqFqWMOUMoBrPyEqOpthOf5cCyLkTYuT8pWCy4TRsKsayIIJGbgN3OEx6dzONjCVdcYD9G366fjrcU7S8v9Waa8EhT006wVTdWSC0zKCO9tje8/QAmXmT8Lk3k8aviwvD88YE9kdBui6ji8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcNl8gPe; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcNl8gPe"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-706694428e3so1770539b3a.1
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271769; x=1719876569; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ifr8Ya8A/Lifd4HdrItZMFbfd7FCXsltsIVIxxyLaY=;
        b=LcNl8gPeEZGrKW8/cOvd28kJSu+L9jU1KUC/RT0MYwkqndYxMvi0LuEicqZxResI18
         sXfUGXOHDo6sZXlFdNZLM1F6Uh4JRbximdp42S+JL+JZ7LiAiUWpfHHGB8ngjWJ9IOFK
         FUUu/PPk1ZETW9Re2p9mr7fLD31hC2rgXRjCsoRo1yf+HCEi+T1LV3YRWtsjm/K95jGG
         F4KbtpWcgkIgXBjL/OHA6A6hhYSU9RdqP9ZSl0FGXK78ncx07Xp7TAum8hqIb9cg02RF
         GavJT33Gtnb93H71uzPzLW3X2R63cS03WrHrx5QhjdN3xryQ1R73Rm5z3mLCWDqeEJdR
         5EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271769; x=1719876569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ifr8Ya8A/Lifd4HdrItZMFbfd7FCXsltsIVIxxyLaY=;
        b=KoY5zTNLob246T12OEMTQ+ixXa8c3cWOuhGchkd1jziixHemvMfu7ZefD5c0/jRiJB
         5kfp0xvqgAqD9X6/EG/mlDmQbVKWxtySMy51EgH/DV2Xo4GiOkXOIc//0iIqCTwOlxBb
         zZ//60+nj9OcOblnh1dzE2Rg8U/UAG+UO+gX4HHH95P8UxOgYgjZknMcnRvikBt3QbWI
         YpkqtSJkAd9owLcyqcmP3EKXlQCfdIHfR4xxcMUn8M4QVdJPQgQHbPpNwgbHEMZKCcD0
         kOJiNY7A/0eZZ6XNpJleeX9eNdOfPRxr2heOIwVZHWWalPZ6GxCGbdLDzM3Nm9LHepiV
         /oxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/a3PkQnDlSBtNZWupGj90C/3S9cw9VHpTDPdoIIZr8zziz28dtNBr8cqofJfeEm+8B8D1bQ806WMtCEfIL2Zq1/IiU4o=
X-Gm-Message-State: AOJu0Yys9IM/Ht5h0rnGNVonUcEhjhbxAJVUW8gumRwKyYP4p4tFhLN+
	7Ll/vMyO/l1iq1BYxStofRZE8DibrpJ15JIZymlrOR5daXXa3doxciNOOHzeluBLjbRNIDEUE4D
	bJg==
X-Google-Smtp-Source: AGHT+IGfwxTfgoKpQbwyVdHdeu4Fayfp12bseSCI+21TX1FuKt23v8wGVL/xanJWyhgjJiFfoB7TugWlGLo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:898e:b0:706:3433:bf21 with SMTP id
 d2e1a72fcca58-70669dfcfdamr31477b3a.3.1719271768844; Mon, 24 Jun 2024
 16:29:28 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:15 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-7-edliaw@google.com>
Subject: [PATCH v6 06/13] selftests/intel_pstate: Drop redundant -D_GNU_SOURCE
 CFLAGS in Makefile
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE= will be provided by lib.mk CFLAGS, so -D_GNU_SOURCE
should be dropped to prevent redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/intel_pstate/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 05d66ef50c97..f45372cb00fe 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
+CFLAGS := $(CFLAGS) -Wall
 LDLIBS += -lm
 
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
-- 
2.45.2.741.gdbec12cfda-goog

