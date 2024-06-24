Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD2A1A2FC2
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271743; cv=none; b=GFQvIZH74eEpIN9zrtI4rlQsVQhjNlY/ZzVcLVcTWlp4EvfFQan9kn4TstJU9e61nLqcYaHqF+YK2H9tz8InHLuVrMPBTDcSTW74E2kzoDaRbIIk7lKbhywJK5RGsYvdK+lYgOSe0w7+dXPJQ7JsCWCCX22koLffXWfq3PZ6Kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271743; c=relaxed/simple;
	bh=NqMqA7QWqr9/+mHOdPi0hG2A/sBfX5GGxqySZ84bEFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f45qU6+9zCWopIcTu6BNzFq2Hv2gMECBGg/5Mjv30eKySzA+xNTYs9PdIm071IRwNVLHzhvXhjYDoWkwN67YVg8vbWI2JjvnC6W8Jx8SLGB3EhwAzDurV/v927yMMy2VkqHT95WwdQG1HLVMLNup7BkXNYjxlEBNfAnnNia1SaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zINWzyOK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zINWzyOK"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6507e2f0615so6233478a12.1
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271741; x=1719876541; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FvMNQZepmevKVYCWA5Mvt/tIAvZEAV28z8ZXGZ1r5A=;
        b=zINWzyOKL2C4M/mUwOtNPHa1CqYytEh7PsBtketUvYBsYgP3OIgNmugByO3m6k1NaL
         O8ca5C8bVK3qZJCLk+y25Rf18u5HRhLf1qtgPjwLdCw6l4eJ/LdGWwxZZfUItunVJ/wy
         4kuuh77ellbdAgC9b/loT0zGDqYsgvdVr7m/oNKv+4bX5yYROutbMa9gQTNdsiF94EGV
         IQzd62d80hLqg9DhARCsIVE1DAU2OjrUarhxCut54VjZYD897F59Gsecs8FXXaYvvyUo
         /6dGjipxUaFwolzP8Qr7veh2p/9hZL3yAwrNb7zwqGhE/RYdpWdgSSq36d6AsVNXLH3z
         KK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271741; x=1719876541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FvMNQZepmevKVYCWA5Mvt/tIAvZEAV28z8ZXGZ1r5A=;
        b=BEb1DubOgiR1k7oEJK5OutPO3oElddQfhZrH9iuug4cJjn/4uZDESM+gc21pn7VPIq
         AWsg1gJ7lE/AkBTLQvLH8BL8pM9iK6ld4I+DDJ6onyeg+XhHNm9TMIMwNYPiNRvp3e2b
         bNOqNvnultc+SiIZ5DPkZ0dJM9C7tXA9OH4b3ixcH6d73MxNCUprzKMJqnE6N4YyCis7
         hkHRun+kN9kL3dfuE/jJm+Tt90bl0eA8oWDzvZcDxn3pXop7KNlDbn4kVqObbCDFBkcw
         YZPLReKAg03wvejsMMXv31PgtT8OEgnD7ij+49GR1zifnXSdYjmY8WvFWs1n1BHrAmNF
         L7wA==
X-Forwarded-Encrypted: i=1; AJvYcCVKFrhuUC9RuXcW9D6n7uuFi7UVOuiM9M8gTtbIyJkJm/OvZPpKGRHZxxLq3T8njrh85Md/I34+Xo3uPWgKh14oCfxekOk=
X-Gm-Message-State: AOJu0Yyl3eMtDFdDf70H9pYarMTjmiamXsaH+KmlTAMPrjNZ0GhFXp5t
	PB3oGMId4yHSslAEYmRcrghzo/FSUfE6W1RJDG1vuKpSOaeQjM+DanGjBh0vC9SYxOJ7lG4EeIB
	Fyw==
X-Google-Smtp-Source: AGHT+IEk+3lC5zdyxifyt4ii+6a16n1y8uZeO7DOAPkbXtiVBPE0qfgp7g0LpuESyv8BZuXBXF4M/RvaOF4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:4a7:b0:655:199c:eb1b with SMTP id
 41be03b00d2f7-71b5fe10537mr20071a12.10.1719271741168; Mon, 24 Jun 2024
 16:29:01 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:10 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-2-edliaw@google.com>
Subject: [PATCH v6 01/13] selftests/mm: Define _GNU_SOURCE to an empty string
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

Use the more common "#define _GNU_SOURCE" instead of defining it to 1.
This will prevent redefinition warnings when -D_GNU_SOURCE= is set.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index d50dc71cac32..e4370b79b62f 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -13,7 +13,7 @@
    sudo ipcs | awk '$1 == "0x00000000" {print $2}' | xargs -n1 sudo ipcrm -m
    (warning this will remove all if someone else uses them) */
 
-#define _GNU_SOURCE 1
+#define _GNU_SOURCE
 #include <sys/mman.h>
 #include <linux/mman.h>
 #include <stdlib.h>
-- 
2.45.2.741.gdbec12cfda-goog

