Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367411BBBDD
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271804; cv=none; b=IUh+APwxccOpNM7CtrW1FNYyiYRhncvY8brlr+IjJTvfL5ErsoNy2K22AsFKqD9a+iTXYTm3tNIHdfGeH1ECLt7CYZIcX/wI8WlqeRITGzEMLztesp7xFsgkGvy2xOLYTmH3X/buouod2j7bpk+uZ92lrXZmGJKYYKbYrxTGxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271804; c=relaxed/simple;
	bh=HKl8DYXudRkj2nEiXmQj8vs+8XvlCafs7fYfuFr5khk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SQWnfYerDNa7ZevdnoKGKviTUFlw/V042kwSzI803Me9FeHbngFqlZFPlR8NLqhcJ+5u99SBMxCeRIGyCjv+SjhzRDEmLBxnduhG5kyK+Btz2l2/YnaA4o7iA8bQg6KsPWvX7rMpHaOzRC2fLG29Qrlrfbe/BDI1ADXqGj1eLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOHVeS7Y; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOHVeS7Y"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-717b045b0a1so3866113a12.3
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271802; x=1719876602; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZG4i3dx3G3awn1LpAYu9cuCTYByH4EPhFHcmFTw+5I=;
        b=jOHVeS7Y8KBGQw31qLwzN0VnjY+S1Y3XB0ZHXhU+UsOOxAGsI7H9730UuC7J6qUPc8
         +HGo4MTnUFW4xk/8iivhOA5MRTOCUYvKRZ5+TxHect4ng5K2G30Eq4HpLyN+TkvHIp1C
         R7m0xJxvKWR3t6CPwW60I+2z6QbHeo6gesx3bNtx+LFJH2rqKU0FCAW/uiFVbq1itX0D
         fQe8aBwooXpPXlmHV8M2Zxl4MAnEvBVOgOwnEhNk6tclmj4XwHAN7GOZbgZ+AgUEq8cF
         SYkC9VfTRR08kYIrmXoiecQEuezT+XIdN0DYWuJ7BrInPOZpcMN2nGdUNehkYDJbRvEi
         5IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271802; x=1719876602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZG4i3dx3G3awn1LpAYu9cuCTYByH4EPhFHcmFTw+5I=;
        b=nY+4zvASeN2UaDxOHbH+LyHh0il+tG7v+rBLiIfyOBKT10fNKtrZmAK/EOBpWpPA8i
         e8QzzflLfMuY1995ieb63pjGnXZZMlcjTaJJDpigOs+FFvECmE5ypYlA20JXDbOK4443
         XAXa+pTWTEdDuCoMRJx3LGnlRNJYm7TQ+zugZs6TqJF9fsL9Df7wulfnpMjj0osvDMk7
         vT/VFAju/GjBMP6ewIVk9prgMFg90AO4DkPYGJyaC7mvNZNBbRyr2BaExJRMGgvqX4vr
         VOneFcb0mmuUrJxaR3cB1mzLMN4BM9Ui8ljSiSCOHMWqYFmpA5lARJt1MLA3U3At0bU+
         XseQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc7/u//wmS7JEHS8IwB+zOwC30o0wljvXHw3yZogbbbA1rn2aZ2v14Ia64bMJETBwGuebrBfIJD4GvKz/Nzebyw8YkobQ=
X-Gm-Message-State: AOJu0Yy4TXqSxlmtpYbiV5VTyLYLXNzABPBXtI9VBBT7VWVWQTMFQ2aO
	/G2DH9/rh1VKx/psTeHAUvdzPszp+6Pjbo8pr2XupuvVrxfRajeXkT90OfNdKOm8ZF2mrgNOODm
	XyA==
X-Google-Smtp-Source: AGHT+IEfb9KUh1OpOD8DwIk/54klv7dSo/nLX1YPQZQ44FjQ7tb2FCGqwu/ay8BBa1IDIHl2DafOvSF/pwc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:654f:0:b0:6e9:6c12:3523 with SMTP id
 41be03b00d2f7-71acda64918mr19622a12.10.1719271802360; Mon, 24 Jun 2024
 16:30:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:21 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-13-edliaw@google.com>
Subject: [PATCH v6 12/13] selftests/riscv: Drop redundant -D_GNU_SOURCE CFLAGS
 in Makefile
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
 tools/testing/selftests/riscv/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..4664ed79e20b 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
-- 
2.45.2.741.gdbec12cfda-goog

