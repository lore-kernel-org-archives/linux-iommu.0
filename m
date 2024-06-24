Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DC1AC234
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271766; cv=none; b=V/Wbh0sqXnkpaNFqQEn3xpccl6aIcjI1QyDbcEeGV/tY1lWOdWcKAgHQw2sZ1g/FYu3T0njRp3Ht/ShNghYTSEaXNB2jrFae5QzQuAnNcK/fXVo+1iudft25o7ryfiXMG7WCThzbnKyFnxR8OsSNLrFAwKof9+01+BQ+rA2/nkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271766; c=relaxed/simple;
	bh=J8ziRZLZ6OEx+woE/eS0qKgArMtBUzmObf9KlKhPFtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=je6YuAv14Two59ZIeBmAHrZAYHciEuktZzghGWTP0uetHnWGHAqjDPDMTaad1DMzsvrKEeZhOXfzDi9NFX3by8n5RXuT8bNipRt1RaO8NIIKZtj4u6TajXLnf3beSaqY2QtptCkZFjRGIQZivw6eqpDT5h3HkSHO+FfkrAAgLLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDdr74s1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDdr74s1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-706698fe5b4so4226011b3a.2
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271763; x=1719876563; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fldosNIASu5foth+y++2astaddaovQjRCjbJvozT8Ew=;
        b=rDdr74s1XoPNP8cRqw11KRgWBFy2+gfC1D/V6JKNJ8bmyfjWEBt3CDaYmnVBg7VBBo
         JZF917/ovyRv/BaOpYX8fqQ9eFUCMEFXTapSQ0GkOkXRy3/xtduO8BGUdcrHQ2ZkX1I8
         ChWqu5rt2HcaDwrqb1WaR/SH2hP77mu8pk84GcuKcNPXJsSShIch8yYeswot5cZwDB4p
         vq20rO+aaC5SC/Hk/Mmr6pql3GE7ZrGu8R8NLpYlnC4C++lH0+Y4BwRfznEWRIfX4cBz
         2OK4IpFcawFq8iWbqJ3Lpe/SwMQMR7dE3U1ULUXZ3fELi18UjrCAwDoCcQ1iZv3vtQR8
         veRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271763; x=1719876563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fldosNIASu5foth+y++2astaddaovQjRCjbJvozT8Ew=;
        b=aBuszWSeq4tKVJ/1oPZwAhe67yIbNy4Pszcm3wTR3DunL3sHEUXpaH6BOAEECB3SjH
         Lbu0a9p0X/bZjTY/aFDpZC+bHf/439g6KIPSP+FCTUCuV2ORbTZBJZw7Wrb8uTo5zJhj
         Id6k7rCPyXYjLhLoIFA76ywv5HfQYhAkVQACF8Yog7ca7HmS/UGNFMl5r7BJwLRsWGsB
         1xzDuEwXMyCMRQK37MS1IoKWYQYe8JIwK7mgkjHSWoBBaxIQeQEVFmNNNxFGVhcQ0grA
         d63pxRNN5DM2854OmjEOllzFwShGJXkdSWCISbT7lDXucc3s/G/sarYBpyTSYkEPUbUP
         gy0A==
X-Forwarded-Encrypted: i=1; AJvYcCWlBe5oZGBKblunmsV/SAMIkGshOLhNXC1le5gW9kEJ1PMETLLZNL8SbbMEcE2mh2GBMqSLLzzuuSjd3ik6cFf0Y2F5zjA=
X-Gm-Message-State: AOJu0YwD5NkOUvEdHBeu8TkbIEt6SG9oojKdtq0JNq4EpPsOEkhHPIwV
	OVA0oFYP46ST0+X8DoOS0M71kTi/okSt6W91bOzr1jMDwyU/SBAVPZ8XKfZ6JKsLNv+L/VFCeFS
	BVg==
X-Google-Smtp-Source: AGHT+IHgIjs0ZNjmgMymaYfJ8/9bZ93vYmLowFGFa4rCwsJRE0/Jc/du7SfPX0zd6RD0YkkBKKfvO6Hly8E=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:908c:b0:706:3421:7406 with SMTP id
 d2e1a72fcca58-7067454bf95mr299109b3a.1.1719271763360; Mon, 24 Jun 2024
 16:29:23 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:14 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-6-edliaw@google.com>
Subject: [PATCH v6 05/13] selftests/futex: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 994fa3468f17..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.2.741.gdbec12cfda-goog

