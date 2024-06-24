Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948951B9ACE
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271793; cv=none; b=s23cRPcmcU5llA9i4TZUxG8D4u3Acnp4QsMjIPkttTQc5JZEMhS5OUZoEJ4BeZd5fl8aVJB/ffhOXPyjgIbrGS5ltMHQR5u8GgUwcyXizczI0TJ15Wv0OrtzNaIFJG95LFq25voCxUidNGql8tHnXyRk2b1V7lA7yBvWIRXpBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271793; c=relaxed/simple;
	bh=zjwLmup1M2qfYddBQWwqHOLkKVhU9xZCCBONsOyNtQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rWkiSfbMtPD+kBuEtXXWtI03M5M9BadG9hTchkLm+aYc/4XzSsNYpUPK46z+XvQIb1CWQI4hGldNlX3roO0r9Z5jMN+EQe4R/z7CMhBPVwBQ5yMLWYtadcKpmhZPTz7XF4Y62TFlKP9MFq/oJGqObzzQwWFNlHmW3VxLNd2Rtlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9vsNLFT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9vsNLFT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f9ae0b12f3so53580385ad.3
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271792; x=1719876592; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=diaj5tFwwNQVaMCQX5T2JTz4mfzyRWuO7s480xW0M7E=;
        b=D9vsNLFTI/5rDujsh1RCZXJbvgxYs5CsZFUXLqbH1TpD6YITPBuaqZZTTBbOkTXhbQ
         vJJzSn1MSr6iRvXihEJI0HzKBa22pVdGsPOdtlUpCjOgJUSkBYzoa65IvgDn5x0xdwjw
         7nk1NsOPfP632ywMczXLKLJeaJ/lxL1Dtg5y3kINhp9twogEHtqd7LtmvOTRu3C9DrYI
         kPhcJ4sJFa7c33MwPd8IyreSYbWUvjZidaJqmhLcr4lREnABu7u3xjzcJ3trICD6QBuL
         q8SqK5DvHd6pEuWa5fwo3OZZAjKn2tkzU3b6iF4PiEkip3+XYqdwKF4DU76ylioNt42g
         mdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271792; x=1719876592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=diaj5tFwwNQVaMCQX5T2JTz4mfzyRWuO7s480xW0M7E=;
        b=Gm7fys6t8UKsCOCG8xjAioHDsCkAXIS/9zQ3BhksodRYWoLRMV00wKzfbVzeaUnt6X
         p5iZzWMeFF9Eaq/BOCQAHmoV2tknFWyUdGedlAkw1tCF51OJYuxicLU6XWU3xnkGaHVP
         rjxil2za9eF1ul/B6aEJc0ZO78as2deVtIGhtOK3X9p0AES7IOSQHKJ7Wpx1STwG3DMS
         AbbvCmRKTeT2UZFNlkoTBFrGRv4z+5UrKEZz4r9voDHvmHySgbTUB9kJGJ2YXml7lYEJ
         EeMCkU5DlTY7rSazUnEx2bovBSoklxx6tUWXye9q7Llc9rButlgpfta434AMyqMoV3L4
         +sAw==
X-Forwarded-Encrypted: i=1; AJvYcCWWzCA7f2w1Rycxhzl8zFYSCj/FOSXi1tr9dHH3z/eSWvW4GDerUyq4G3mLG/8/aRMvXaUJPFNFGeI3xttV939wDrrxTFs=
X-Gm-Message-State: AOJu0Yz6ghtcAejeXCdYc2VN6LO4MF5S1XJ/8jbBaBC4tzirE/GpBkCI
	yuhPvtQZEE4NFcBzY/b8Si6tAkH/Tg8K60KKdjNsj2gZAgjzw4Dl8UPigFI79sLex2/rFiL1OM5
	mZA==
X-Google-Smtp-Source: AGHT+IFAHsy2vEbD08I44y0v3BWNlocV2o4z95Fg4teVzqZkoUDKjX2v6KqYVtDHhi51zA7DQs3radXmbQo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ea08:b0:1f7:3bb3:abe2 with SMTP id
 d9443c01a7336-1fa15938adfmr8753425ad.12.1719271791633; Mon, 24 Jun 2024
 16:29:51 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:19 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-11-edliaw@google.com>
Subject: [PATCH v6 10/13] selftests/resctrl: Drop redundant -D_GNU_SOURCE
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
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 021863f86053..f408bd6bfc3d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.45.2.741.gdbec12cfda-goog

