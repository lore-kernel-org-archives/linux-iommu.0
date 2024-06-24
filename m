Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D51A38C5
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271788; cv=none; b=o4JxqFaPDmPkIFJ8prLIQjQZOM9UG8NPC/l2oEEkMktV8HxZmsVoey3H4q+FEVpyAd6VQCwoBdgzYdtOxrN5e1wcwY9af8K9Bewxk7PvCKRyrxvZeZ2Or94pccVrnlz7MxFRtVK7GOWASEfU8BxdjzSRIRZm4a/5iQhyc7a1rYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271788; c=relaxed/simple;
	bh=7x4LoDZgR5E/QVoS9cmfJRmJxj+4a44E8Ep8Vb6AuSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCtjwvYCjadLhkr+U9lBnjAc2Wzlxfy39McBkSqSgrIln5gjLXQmiKw52wtI5UEt3dHo4pctI5VfuCFA0ZIpuyArjF+QXyo4KlxBGfL9YqeNqLchSdNlomRKKuw47MBAoaxIMALgp+NPLyQvRZChUSqJXJOsSuVzr0jLdbREc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTp+VfX3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTp+VfX3"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7051baf0519so5302763a12.0
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271786; x=1719876586; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJFiGCZar+q63pIILXV1m5S/VTx8srfmbdTO812oVXc=;
        b=dTp+VfX36grmYC8yIXmikoRe4DlJzOc0O/mt5uHIi8A5Uujlnog/4LxMCaQh58G3qo
         r5usHuAcIEkO5aRIoVKuQfjd71+W1MFaa1kblDRMUFkdz5XgBJxF8TlHUqiym7bJHlDR
         J22GwYY4gFYvJn/AUAMlC+eMKzXaqf8VvkQegj6Kqf9PAJtnUFqooAyvS/ecgg2F+7Pc
         bpa/4ZGetZvKgTWD31wj7KwLrMdJCtog4X1qkjRwmBQBNdyHnXqYTimkqteM22zyfzSS
         9w/VqgbeJJNsffP6bbnMg99xmZ9SP51YKnAxX41Xsu9bSzcPXYsQF6hmGwfuUKpVJanp
         16Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271786; x=1719876586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJFiGCZar+q63pIILXV1m5S/VTx8srfmbdTO812oVXc=;
        b=oOWniURq7rmDqkjrw3ZnT+1eropAU66eU31u6lMKOV8Zpbg7wSTNUKiRM4IwhJVbMq
         WJ2bX1JMh5YzIxgX/ims2Lz3vAMycYvxJ5u/Z13B+yT6nv/tBErldVwdTpQPYjWttOfZ
         WWa1jAgW6SreaIkl6u1g3Uc2jTQ6FAQ7H36OzJYpuB8PoFM92FBfVYk+mx9jmaxGhL7w
         JiNaHZFK5QdlbRl/C/7wJeIKstlOVczjZtNP+BbJY60mExdTzcZ4vstndPggiawCavDC
         oCdYZIdIWx0xuyEqaY3XFO5BVE513gNXR4wcmnb6J+n5qesXyB07oqO643NrErr8kY0e
         ADDw==
X-Forwarded-Encrypted: i=1; AJvYcCWyxgH3LQ0/1OUHZ+SrQSNkmiOAQg7ErEKU2cKMEJLjge4iM8oHKUKbFZxJGCTJKqUpdVcSnhwoNTtfmKTtRZbqtYbl6rc=
X-Gm-Message-State: AOJu0Yx6JFUPalxeGTx4A7OTtXhUWtrrlbLaR55dCgLbCFadUyjVeztL
	MtTfqYl4PgBjIpxJB1SvEHBh1NkeU3YuE6t4B607uq8H6UO8a1x10ZWbKQ21gt1q3Ljs1j4LWzm
	iYQ==
X-Google-Smtp-Source: AGHT+IHZaXS4lSce/uBBUIpFuXCH7I0BpPEaAf3VbI7ppnPDWzJgDOW4eIq57gPJilnwaCJeffaGJD+7rCQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:6dc1:0:b0:6c0:3f:cd46 with SMTP id
 41be03b00d2f7-71b5b395b46mr19980a12.2.1719271786190; Mon, 24 Jun 2024
 16:29:46 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:18 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-10-edliaw@google.com>
Subject: [PATCH v6 09/13] selftests/proc: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index 6066f607f758..ee424a9f075f 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.2.741.gdbec12cfda-goog

