Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B61A2FDC
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271783; cv=none; b=fYaMsBTN5N1Cfnw9wXDbqtV6iAm3LAb0ItLI/U48ZnQpFIqIV04yh6C5qZtURcgtiuqrMk2feL4QkRtQGpxOc5sz3ejIICywjLkfPN2utLgabZeIJz8xZ/2S+mHd1SZMaTY3LXkJJXkcwy5zEvn9rSMl2V+lG2zsw4GZbrhi1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271783; c=relaxed/simple;
	bh=Vn2wAzsGFTLvBvD15AbUZj/MnMw/n9DKUySpFM3EEW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CsJHowuSgoBj9WQTZmcJ8La0ihaFKZ1tQE8ZGKA9tDfYyDTzf9vd9yYE30+zPIPjUBRU3EGt6dbvbpqpTHozYq4gaN7xDT8zc+A9aF2VUoBOHOHPWQYFtRlqwigehiMzvk7JiNjJdgCDdD0roYXVEZndqKWwtEg2YgIQujdyfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKbv3KsA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKbv3KsA"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-706819a8390so1202123b3a.0
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271781; x=1719876581; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZ+5Kk2oEbgMtgXaDgXkxLOd4phuQ+pRNBukp2bFkg=;
        b=iKbv3KsAZO4BaZauALAwIYp4k3B8hr0VcEHxIWJvpC9VavwjU36sn8uQJ+P8/7LgME
         QB6wvhUrGOr3VFWoZo5JU26UgXtSl6kRrKJ7NXLhTCJ0fAv5FH+XS4JyO6R/7p69Sx63
         /jZJnXAcOiRvQV4PsZs3EPxAui2J3zGk2gGxr9IEM9tcwhyyrHOEE4r1oz+CA/KEx0wK
         DM1X9cUtbFiLeyVOYYi+JSyI6cpoeDEMsBR//F4NeJRg+dYIKtsNnDDNpzetPijOFTqO
         aOHZIro6fcNSn0tP0NXksaax1v2Ma+4dHUuE9UZxwPxiemAXJFAwuYarqp0vYrECFX29
         A7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271781; x=1719876581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZ+5Kk2oEbgMtgXaDgXkxLOd4phuQ+pRNBukp2bFkg=;
        b=xQKFEMTtdpNb/SGGI4XmiXnMsQLVZSR04MtvOnoLtyD29hRVt6w+h544kKjYAEN7Xc
         EuCBDpiPcoisFlHB59GYdLaURp+3+rPlrE/hOalmQkZvNucOEe7tSySwickn8s5QAfzR
         IUnjHklsS4tc68NQOp+WFus1ysAxS/SY2899GFXS9+Pcm74ZH4N5XzYtkIeXNhTn1amE
         qZMEP9m979xJ5WonbmJ1xawb88zxQh8UvQ4QBaMwQnc9j0WyRzvb5Br05CjnbQ3NzS69
         BhN/K0q4agtoFsJCRNKzrmNbWHxUxJrYnW0Rbdr17XEQtKJxhF/3Z14zbc5IEaGptcAR
         mLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgU1pzYfcd/kxllGxb563zVti5b8dOuUdg6NP+81y0zHqIYiNjUtpCePBVRsyda6roUy/J52a5dDAAsxiRYOxW5Csd1Rw=
X-Gm-Message-State: AOJu0YzdSFkkY9IEDhBI6M586v+i85FnTKTAyrhTUyS6QZr2SeLphvMR
	qVck9KU63xaC5QpSTWKKtX6vruAO27rnErWAFpEfJcMDk1MQ2xP70cigAZXryVS0E64IKjiO8Ue
	hjw==
X-Google-Smtp-Source: AGHT+IHpQrIc85Iwvne/JtUL74k7CtaEnEbXK9UND6RiBewc+A4BXz2SYDvXCOVunV74/hhFEZKy/c23brg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:4309:b0:705:d750:83dd with SMTP id
 d2e1a72fcca58-70669e5e132mr244774b3a.0.1719271780764; Mon, 24 Jun 2024
 16:29:40 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:17 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-9-edliaw@google.com>
Subject: [PATCH v6 08/13] selftests/kvm: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ac280dcba996..4ee37abf70ff 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -231,7 +231,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
-	-D_GNU_SOURCE -fno-builtin-memcmp -fno-builtin-memcpy \
+	-fno-builtin-memcmp -fno-builtin-memcpy \
 	-fno-builtin-memset -fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-- 
2.45.2.741.gdbec12cfda-goog

