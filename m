Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B51A2FCC
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271777; cv=none; b=LLPyNtgOvJLPjwY9fnh6/YA1KPPtmzb8EQ/fII9/d6rXujV6VQIJodNFEv8MUcGGrErVeBKybbKSwxp5OOUktO/HgaHY24UAUxYRVeblLTkSREf5+Jc3I5v0il6lEqmap/6/sMJWzGSJupzJBDedl+Wc7KQqPdePhchWCdUpsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271777; c=relaxed/simple;
	bh=CSHVkY0x8U1pXoBBLz646/d7/XSIXGdSs1WvRtCcMQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V6HHNyQW+8YWULapsM7nctyuAMfOfG2mKdf5JEIfjz1GtHdU3O3lV6YrZlX0e/XzoZyaKVG1tjqNUu6tqc5414hQaYbaMYBWqfwK6PnNchtyxfm5r6EMuTtNKhQjKyy2eIOT9zGEfzfNbeEU4J1ssC4/FIYGJeAEcwX63T/Yc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vCgVPmIB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCgVPmIB"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-70d8b7924e7so5495130a12.2
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271775; x=1719876575; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCJX8+VvSnRphReKqOD6AqEhzLc1OgPwFHKFgJpo/3s=;
        b=vCgVPmIBjFvyHpNCxmXjBk0GNz1o9ELk9a1qdY38ruNw5juyfx49KjyLw1b2fMvXD7
         l/ZzZdCJC2Gk8gWNpRm3MtUw7ZWg1IA4fFk6kTkPuUnMuYIRlPv7iExUPCY9piFti36c
         oxyfn7t7W0mStnUGT190kuN77Y0QdaXtixAQsEHrKdmNazSEpGLKlAwGkpTiZ9lWeAvP
         RDaw7JSVjBpNfrcO2c+ArgeZnmI+ZNddhztxT1vo5lyY1kzBhzgjatYmDQEq1bWQucmY
         nUqEuP/llO7bwHBH5jJS7ek+9f8uonzlxjIJpI+sOutygPQzUH1qmndCqtx/AVyXxi4O
         PeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271775; x=1719876575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCJX8+VvSnRphReKqOD6AqEhzLc1OgPwFHKFgJpo/3s=;
        b=vEI6jEIqEb04TE4FHnC3kdiRZT8uC6W9tDyjY42TLLh6s4Qd98Ou6Bst+sTgFm/J2i
         5iojehxkuYtgZ0jcvANdPLfNoSKZdBv+7v4lSglBbD5dTKVy2BtI/l0DTXmoI/zfvHhr
         SZPH8sVkBkVTXY9YJqnaAPQaIw9+2EoLMrVlIqlbuV5gd+0Q4hDLuXWnK0TRmzZ+1p7i
         SmcsszRyyCELAZD8Y/0H3prLGb97TOLln/G+6boWvzihIREd0+7vj1dSYH135DOyrMZj
         bd1l6V+9jEnO01C5XKrym35BwAUvfDgEgEXYA7MqhqcdtoWbyj7h9uhlvzht9aKTybLR
         jlJw==
X-Forwarded-Encrypted: i=1; AJvYcCVURY6c1OoUSW0581Bu8rNYWy2Di2JNd70HYwkMieFKaotlZ+lb2nAG3kPMyp6jmmt4WWWkCiVxB3kUTf3H4JQE/XQSf5A=
X-Gm-Message-State: AOJu0YzgJwsyr2K622lRY6G9Shlo/ypBBmvRAO/J8mph5dI+au6qRfak
	HOjek4Fbs6A3kw4fIa1pwktIULptLwea7NsLjXRnRSdE27nwvHBmnXSrrlo9qkrQewX8fI8KayA
	baQ==
X-Google-Smtp-Source: AGHT+IFjD4+usXw1SHxX9b7ePdUBbw8ZgCP2CzCr9wFCk6wJU6Q5+R81P4uygwELRit2itW6ZnfR1hiEObg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:91b:b0:710:c65a:7e55 with SMTP id
 41be03b00d2f7-71a35642c51mr18906a12.1.1719271775000; Mon, 24 Jun 2024
 16:29:35 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:16 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-8-edliaw@google.com>
Subject: [PATCH v6 07/13] selftests/iommu: Drop redundant -D_GNU_SOURCE CFLAGS
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
2.45.2.741.gdbec12cfda-goog

