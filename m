Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C51A38E7
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271749; cv=none; b=QNzYyD8YyNQOYcooeDRHsXJc7zJeFHpqKYRJZR4S7EdnusqZE0DMAjTi9WkMXIf8umkycV+D6+28MXrsSLFyOQlsItngd151fA1TA5grih3ACqHhghV0AW7Qy4B6Xo1LsDcpSlchRTheOTjIE2vGSA0OF6QMXd12CzaJ5vIGeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271749; c=relaxed/simple;
	bh=xwftBfRu5G8w7ol9IF7MUG9BSiGvoLKlVTWAOAeO/Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d/MoAaznA9Zwfg6KKsnziv3PUS8ABVk9ihM6zwnVAOLtJIx8kpYnqLZ8UQsxgTtFAzhI2rfC6TSxLAtOeLplAonUFIu7WhWzjjiaNs65B47cPuynK728aItGnupfeZXJJ2pdi28LZnhbZfy31Dl+wvQGr+pygEAH90IAaylsMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASLX6QRe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASLX6QRe"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f6174d0421so52226275ad.2
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271747; x=1719876547; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7F8R5HE+eZyxlB2ebQLwW1FMzverfSOUo2IuXKNmLY=;
        b=ASLX6QRe5xPWCtjVNBTNBzrVKuHPuNzT5Pz1p+q5bhmAIISotl+oC6jF3Nts+Ew3YJ
         iVoKpqJfCLtYeABwyevzXOZ4PdG7jY6VGAkBjU0WpVU0kKJpg78FRn1gTDTau3UW43KN
         ZBK5dy+ybIQ+Zta5hesdoy1fprLtvOO5mLHS4d6TmILoWK8BRCIeo0Bf3v+CBIQH8UBy
         E5+2QEVvtGjjRqVY7yNdSOKktRbVIXG8rVyNYex10lZsSfPZPNYQYEBoWPuXzstpsCtE
         TARV0ifE3pRQZNfelvrlV4oN37TPi7qrfC0QX0GO+eLhlzONPheNNg0OLDNd58QFWlpW
         A2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271747; x=1719876547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7F8R5HE+eZyxlB2ebQLwW1FMzverfSOUo2IuXKNmLY=;
        b=j4lDji4ZNaO/dz5al1lPyeRqgpOUP7DX9OUQ1F1c9+B5Y5E558kcgwR7BLiuXSZNYz
         18YtQon91nkKMXfoSL5VfENbcfLmNDFqLFjtp6iTibV++yJXFGrG5n5sZFMD2bwW+f+z
         v/bsk6QPKUOE9O0Oq1ufELlJ6xPEfb6hUj7PSJbq4pE3na0+0akIvtwFelBM9wYMxmfF
         ANF7/I4glLRkPLN0vzHwvVVgzFb6SoUjtwRCGcel53u1Qp8ENpRUORapZTxtkGpVAxQ6
         JCSrJG+zEdrj93McHnpbwJRWuBJt1IA1MQ+6j71T0Lkzep7FRHFrYH+DZSV+/URKnOca
         SWdg==
X-Forwarded-Encrypted: i=1; AJvYcCVbqPBPzruqSE4lGd+7YuHR9dlTuanVQDncybqwObh+pSm61sfYQcaFf9cqHVOGWtM3krFv6VUy5Mo2pK94PUVcLaX4dhg=
X-Gm-Message-State: AOJu0YxYjPhfQQNBFMf7wA4Te5dPpAn8G/lu6zZReyXPKa+4GPsQhel5
	aYqSG7+fsE2eQMt/Esg0TqNDphKfouHauKbp/c8mkuUeBNrMVQE7xuUX2HfeJwzuRc/PmHm6oN9
	uGg==
X-Google-Smtp-Source: AGHT+IFY6zwuM+fBRs+r7yFjUxfbkM+X5No4nRI5eUjSYyy4xzwRR2NKqiye6S+BJr7Hl1+KVMRcw6AW1Us=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f693:b0:1f7:3763:5ff0 with SMTP id
 d9443c01a7336-1fa158d034emr7382275ad.1.1719271746792; Mon, 24 Jun 2024
 16:29:06 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:11 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-3-edliaw@google.com>
Subject: [PATCH v6 02/13] selftests: Add -D_GNU_SOURCE= to CFLAGS in lib.mk
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
	linux-sgx@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Centralizes the _GNU_SOURCE definition to CFLAGS in lib.mk.

This uses the form "-D_GNU_SOURCE=", which is equivalent to
"#define _GNU_SOURCE".

Otherwise using "-D_GNU_SOURCE" is equivalent to "-D_GNU_SOURCE=1" and
"#define _GNU_SOURCE 1", which is less commonly seen in source code and
would require many changes in selftests to avoid redefinition warnings.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/lib.mk | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7b299ed5ff45..d6edcfcb5be8 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -196,6 +196,9 @@ endef
 clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
+# Build with _GNU_SOURCE by default
+CFLAGS += -D_GNU_SOURCE=
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.45.2.741.gdbec12cfda-goog

