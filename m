Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071C1AB35A
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271760; cv=none; b=BPs6lKuUtB2xBnLs410ibW6AJ4JY1R0S9DrnGTQUzzcCY2sxWt00NBLou/BD/6uWO7wnFpMhxnhCGZ514k2ZtEmeYE2CIxeLYmkePijOKhcng8L5tFZON9gjK9GtuyaVhfm+FdUlg7Jpg7t+BhhgKOjNXw58iB/XyWmdk1buGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271760; c=relaxed/simple;
	bh=pWNExpY/MivG68WT1LbkW1rwtOz84qP9M9G1/+5QF7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZS3+dSA6eQlqQhQYPxToXjeP/FOkGgeLjvxBsAI45g9KbefxSffmK/z7o3xX8pHkP3bqeJkAOtHlW3gOdaNZ+1cgTJugh0RDeH7Q9tezkTtJDofCoad4qV/0isz3eGFYd9sPm0f+g3fa68QNKddTz115w3Elg/UMsl1gmNiLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8vKXgP6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8vKXgP6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c559235c6eso6427216a12.2
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271758; x=1719876558; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdSDNYLWJB5rZ7zGFIgNmO8T8+rT5KpGbZz7pQfLV3k=;
        b=e8vKXgP6KmrwAOyVOyZQUbrmyFLAMN56qCPAnSGotakV8NYl1MsCTDy4gOY3DQo6Zn
         4nrzTtXUHIhmj2VYKwhv2Q2vAsjuNmDQnDgBu6mq8fmEQAd62hqFis0kjg3gef6B7syS
         pi2NTEzXdVhoGl/SMtid0tnPHRWNy96GGyhk+mGBcsqGZkZZtZtcKZDYTuuNwbZ69ioZ
         QH+dFDIqXy5qGkmiCeepk48+s8heCz/LI199SwbD6/ygpFQcmY/AM7CPikuiRvN9n+9f
         9FAX8XpT3nStzr1n5i+0kgMNZpa02ECbZZoeSlt/qIEso62PTTxtf+2dip2cVjeG69Ez
         iuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271758; x=1719876558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdSDNYLWJB5rZ7zGFIgNmO8T8+rT5KpGbZz7pQfLV3k=;
        b=hIKmPPZy6OSeTZ8V/txz7meeHcmMCkY7Utr+XcN/Rk22FkZxGVDot+ww+87bineYts
         YYekxD0ftBWc5ekJ5HpUzod2NbeqHwz9iIYUDYxvpJ1Xbk9+hWPGgkcCL38F/imHhsYX
         u7agB+vy4l9IR1CK+tm3rDTCcgG1tBmCJ5J1PI+Xp5Dtsh3QQXP5MSzCZ4oIRRVEfENA
         aOnheMDmTiqgRQ/JFe8e4AVxLot5akWYG5UcBtSSp5JwfPwGueQmQQofjuXwhOTWMejA
         erWg303A/TOXiaiyxAxYDTBmQlNfJk39NtCaracrTIYQ1Io4c/m9AgfiEHXDg+/uZ6up
         bZEg==
X-Forwarded-Encrypted: i=1; AJvYcCU+AZTQB19MEpgN0/cEXlEJrG0veHdUUQL6JMtYQXDuUwpxiJRjUIJTXK6+AQOdb1E5/FTz8M6T1q8iNaRcLMmq8VSTGKA=
X-Gm-Message-State: AOJu0YwHH9J/2VrUUdMa2T7w/CyNV20heEZRMS4DmiwOVaNoVM6sUxi/
	lpZ88PeXzaN316/iyk+fPw+x44kNqJQZ6x7PrGyInNOwA7L7GPcXlvXjTtKz1Ncqw0ztHp0YmMc
	YWQ==
X-Google-Smtp-Source: AGHT+IGHwhaq3SpDsE/oDwZF6fJSdoqdJu1qur3CUdYhennVxCDTZQrp6vr5HFtn29b7yImBHRAcKRn1tcs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:3d43:0:b0:71a:1f6f:1d0f with SMTP id
 41be03b00d2f7-71b5c3db10amr17532a12.6.1719271757877; Mon, 24 Jun 2024
 16:29:17 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:13 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-5-edliaw@google.com>
Subject: [PATCH v6 04/13] selftests/exec: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index ab67d58cfab7..ba012bc5aab9 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 ALIGNS := 0x1000 0x200000 0x1000000
 ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
-- 
2.45.2.741.gdbec12cfda-goog

