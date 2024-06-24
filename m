Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228CD1A38F6
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271810; cv=none; b=qdDnILy0SHh7HoT2AWLQZfb8xcm7nFmwaHSq7ahdHpNXB3Ej6xmFsg+ZVO0BmFjdJGsQXL8MHDolU/BQlX26LB7RTUusfDq/vNK5b+BNlYMendv5rhL/mYsKA77IMnJgZXYkqLGHqF9F4xl9crw9G1Kcy1SXIECVpSZX7uEh5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271810; c=relaxed/simple;
	bh=yboJ131KH75Qql/fVo88i+jFE+X+ykOpyD/H9YpbbNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qz7UADWxOiOXN+2i2UZ9K3Dc2KUrmVFsp31ax8kqBu9PdxN7jiX/nd8T3OnrkuDtSylAKFXePxApTHT4KohjPw8120B/pXROw3snuE2QJCr6mIWE6EWS7GdgLinr/D8lLCnTa0LrqG/mLTEnFeYBSL5wW4FuXv9VFYMgl55VTwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjJ8pHy7; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjJ8pHy7"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6fd42bf4316so3896121a12.2
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271808; x=1719876608; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmF+q3rwrhR8UU+6OXTpwv5GaDaD/Y47DiJtkxDn41A=;
        b=RjJ8pHy7/SdvKzUQEzSWDlTDbYrg14B8NSQjSD/qImiMmMR0POhNZJr2zFJY7Bm8qq
         +Ypx50UFuPQMR6Qm2+FPdfvjrF/kAP1PNTAIfV4El8J35z4beaBi8bjGRuTswLivgwqQ
         3XOQkNMayWByvXvw0ltBRwPmHReOVZ/2UVyQAkrrn/6BsHuxn4Xlvu+1jJtXsccyoEA/
         vujaJMlI2VHGIaNXyzY3Kf+ciukj7upWeR5PgM4dvnRHILV8qbpW6EHxdjeOKZVPX/Dl
         7TfjDLKp4eKUHHtgza7tXsFqfoZCvV2eZ7z/L/gsgQI+b+EG03luO/fies5fq6Rtius/
         FatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271808; x=1719876608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmF+q3rwrhR8UU+6OXTpwv5GaDaD/Y47DiJtkxDn41A=;
        b=irfWFiZnXKd6tb3gKz1t9cwgbd6GQ7XHEy+d5YbE8Jomxa+pMfqnvkGIH0QjZZQhYy
         HPNe8qtkHfbkjwmvt6JB7zyPMy8ZSq8hXYmkslPVh+uuDKzEUO7N5eqJYAvmXGZDiAi+
         TgrSOz62IPhmM89xQrIqPBmXUcky0rHGH2uj5BDoOOEnDej1FQuVKLD/2gklbMxWoyQJ
         IRl3YoPiPFGOXUHQ9nbvSK2xlcrMfUTR9avlNR+NrGu9NZb/mNcI0PhinugDTMOZNE7x
         yFGUBuLLAkYm4HlUARuTLDb6JFX0LBMxUV/bxZtmSTHAuLL4oNsh2fsUyKBiSRBwezF0
         9F+g==
X-Forwarded-Encrypted: i=1; AJvYcCV/EB/xazlEEcXA8kNNuzv9X4/Yogy4aQT/ojLVnET7JnO6noSiZv+jsxGyBQInC4WQ7fK6dccKQ4moPBhxpAjK0z3Gm0A=
X-Gm-Message-State: AOJu0Yz4T9zc4louIoKe1Ak2cj1Y8uMD5noJ8iUJYt4FbDyZhOLtCF7z
	hr8e4bNixqiTfGa8p2t94Uq7RUNZlIpcGyrvtV8fGkjo67O7tX7s529SUZM287G5q9CdwwC6nLo
	DIg==
X-Google-Smtp-Source: AGHT+IHcaOj/Ro9h0704QE00MFW9hpEi3kDY+mehE3/RAXufwF49RwalyubuviiuKxGcrX2qWa70mRNXqFw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:9d83:0:b0:6e9:8a61:b8aa with SMTP id
 41be03b00d2f7-71ac38a3772mr20790a12.0.1719271808040; Mon, 24 Jun 2024
 16:30:08 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:22 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-14-edliaw@google.com>
Subject: [PATCH v6 13/13] selftests/sgx: Append CFLAGS from lib.mk to HOST_CFLAGS
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

lib.mk CFLAGS provides -D_GNU_SOURCE= which is needed to compile the
host files.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..03b5e13b872b 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC $(CFLAGS)
 HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
-- 
2.45.2.741.gdbec12cfda-goog

