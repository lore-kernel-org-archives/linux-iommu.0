Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5E1A38DD
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271799; cv=none; b=HDG4+0GI6MrLMTB8q24uo9QKW4jsewdPLvu/UhJ+90YPxwchZq8yJ3OVSKSYjgqN/5G6z0ZMGK/Pa8pcyLjp6xCNvCrml0M8NYfhfHGslbF7OD8ze2KeogJMEdkVaKRYEtYYhjNVq3rpPxJg7kyXH8w2V25HCTFDF9ifMBLL+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271799; c=relaxed/simple;
	bh=VPZXh7x1OhxAHC0bXKoLWNX1SyyNKVGyVHKLwXltTVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ColKe604TBzGDjTgaTGnMVyDQMnb8s4TR/xTd58XVjdwN+U+an3U/PXb93KEYTPWw4lcZHc++ddfNRJIsihO1bQq5llpkkM7Kh1/yccgpeNL90ZAWriYb0AOm8VqbcWOKBhsMkzJ3KhYtuOQXwJlvtz7tnNz/knNnfH41ZgF+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2Iqelx/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2Iqelx/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f998f5e5fdso52769975ad.1
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271797; x=1719876597; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/nRYsPHuTaGMizrWA3B3ZZLI9bMolsQdLa0Lqckx8I=;
        b=p2Iqelx/X4IJgN15hOL//Hof7cQ3APzE6ow2qdutbAUeKN1AJbQVjg/VNW2H2Y/IzJ
         PY22ZbZltOKd0gyIb6f/gOe8jTWide9b3ArkPZQz/kw0p+p6wCVXgAtWxm4CaD/F62qI
         SEpwaLN4okw5Jv9D7lBXtlthw0fiD/dh1b1+sdsMY/aak1n0cSJCo/77yLdG3iWiQd38
         0DL3eGq7VWPuRSEfnduFk73tNvSaAKYWzQK0mosYyCcVqAL9IINvN60Y28hKWr3ZK60r
         MIaluzBuPaJZXxyZsHSH1CnTocADjtPK278BCZZlWLbVhpK1VaJ1tc+8Y94M8EJwPyUn
         Rm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271797; x=1719876597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/nRYsPHuTaGMizrWA3B3ZZLI9bMolsQdLa0Lqckx8I=;
        b=v4z3leEYgR5Q0SH4k7ycIcF0lS2i+gB17ddvusElLI0ErLndIyFAT/x5pUC4hy5Yot
         KCvgR/DBUfelyI4u/2shlzlClOrc1GHirFgAqU2CbS8ZS4CsOh8ZbJl19wxz5S7Cla6H
         dOKYts60cLG664XTbXquFYNZJBBVHCrlp5gwDgTfc2MaOHBQ9oJTpVBWUdDrG2ntv0Ym
         XDg930QnHWx9LMMVOK0k5XJVllz/O52dvY0YpXuFT+LFzKfllythmoVynU7IDAV+tArO
         /U39joMKHyLhDc3H13sTXSbMJN9TImfWCv8bq73a18m2RekH8eXU/b/71pWjKoRJCgTh
         ZgeA==
X-Forwarded-Encrypted: i=1; AJvYcCVAcA5o/zqNpYbuOj+pRrSl7hMx+fldWfWn4HEF1g/XRlRJQTnoEeA4wX2wVaI79g2n2vgcb1taiSiVWYSelB+q2iagZy4=
X-Gm-Message-State: AOJu0Yz3RNYjIlZYhWAu3b2zjciMtE5mCmb65RNKWGo0IzwC5hzk4DWX
	uIJW4FqXVTUp+DVZ4hMVy/fkNiwZlUdwgEh9tuE1Z4KryO7fmtZrx2KgYUVjGiby+Jjy5Y7XUFi
	3lA==
X-Google-Smtp-Source: AGHT+IFZmU35y+9sHVYjgBtLmkHsjpVEfz9mzouhtaAmWQwnWgKPMl1MuSAOaM0VtiMXYbYfw881ubbrmb4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f707:b0:1f7:3170:5c4 with SMTP id
 d9443c01a7336-1fa1592da1fmr6098675ad.10.1719271797169; Mon, 24 Jun 2024
 16:29:57 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:20 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-12-edliaw@google.com>
Subject: [PATCH v6 11/13] selftests/ring-buffer: Drop redundant -D_GNU_SOURCE
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
 tools/testing/selftests/ring-buffer/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ring-buffer/Makefile b/tools/testing/selftests/ring-buffer/Makefile
index 627c5fa6d1ab..23605782639e 100644
--- a/tools/testing/selftests/ring-buffer/Makefile
+++ b/tools/testing/selftests/ring-buffer/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -Wl,-no-as-needed -Wall
 CFLAGS += $(KHDR_INCLUDES)
-CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS = map_test
 
-- 
2.45.2.741.gdbec12cfda-goog

