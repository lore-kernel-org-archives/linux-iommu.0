Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48235404892
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879731; cv=none; b=TYqLvdhhBjF3tRpo1ZnJQOBxtfxiILRYvrBW/YXLUYxLV+qwD+sUQcGh0lj1RpcRUrAXuUfIeMzXs+S2PvwxdZcZegpsupD0wgibLWDddjFbDRfUV3kGhYZ1qTTp6J1U3pLg770KMMtJ8L+qGKKdRkQE6P2m5l2CIf9lxSdxl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879731; c=relaxed/simple;
	bh=kbvK6cuaNQpZn6Q9g72Q+TOpf/2ROUnAJihI0oZoubo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXxa+lL76pvLTsaTrYRbqID4PSBUfaxVoVEj/+GjlTWDm6w2lRtz+jESTT6WI/6QB7+ZbLV/9Xz0r/4AUpqlcOk0hUlTT72ZbSdbgYJ38BqoDdSVDNx6sWF27hdMqkEUc+qz21kLmT2y4DE3WhwRanw6ux6IlxrYRwrwt95nGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWsTpdyB; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWsTpdyB"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c156c4a9efso374982eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879729; x=1779484529; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v1a1pQ4RntgauZdGQ/AgmAZlKsDK24ag7JDuVxfuOw=;
        b=TWsTpdyBdkTkEIywYHRPcM1BuXHAZeDWC5YMpP7RqQNzlFAgfYlJXCWarOjzJV71WJ
         RGzozWmJ0/Ei0DGbZOvYGKHrUTYHl/WWFtYL2TqmyJmtchT7qhcZ5gNXjgdmsDa5/pVn
         IPBMbacue3bznhTNtjkbOW6zhojwSbN3PNJSH4CC8LGJMct+xjryp11rkJpJAqv4zLVj
         0ijA84I6YFNZtyccgai8wJVZed5FsRRzQFoF4OlxFe7cr+54ZtQlvNQ5CK9kzzlunG/d
         7BhmkUVCntJ+3bgVgSbIIYV+xcyJhfA3m5TbYNTJ5cenrFtL/U8xy31p9R7r9ojQFyeu
         KpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879729; x=1779484529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6v1a1pQ4RntgauZdGQ/AgmAZlKsDK24ag7JDuVxfuOw=;
        b=rETal0ShUsh/8Z6QPlYI8qib5ACKS77wrDKj00QjsdAt0ObH1MNzMvICiUELaAY8GS
         Ll+bNQmKyUmMCnWz9ah/IyoE/NGCffnZhViRfJxigK/RDlEaVXytAzthqTHYs9nGzwp/
         5qpE1idg1gLokXrH2o9oodbZCV7QIaTAd4yrgpLPafk20k5hr311Wzc0b41UQiIAM98+
         uOj09k9De4cer9lIyHv+HKXm2evMpnPYdvEQFPoIhwcuG13bc3wuPOZ7lhg1e8cxyACh
         5fvFfs11dIPxr4+XyVc754a6V4Ql76hy266+ZhcXichjFdubncArWptGM+bcUp2ebh+b
         2LDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0CnVLteRzuT0wM7bnxRngHYneBz7nRTAnyIMnt6IDA0sc6qkVdTe1KSXHj5fTduP1WWH+hQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywol2UNfA96n2pVjlItMLpIze9rzBFeKF24jCzKzbwlImDOVPrK
	MstbpI6I6ijvom0okA08CtXm3fUfQ7POwsrPSXwHI7LQWSnCHGG5+Uye
X-Gm-Gg: Acq92OGkosSt+YiLD3GaVghoqBSWTKfnACm2m9a+RRvEs9CClFG0Mlu+VOuuqNDl/Vd
	UHAoLXjEWh45xg/qxHoln3V1efI0s4zGk+aHLQDjNbpY8QrK6sgaF+lwYBK8Uwn5cYpxZtOyH+h
	nXNde/09Mc/Y6ZIA7BTRBgYWok1z0v6E969adVqpgPiSDAU7jxyyCpEJB5Mblorf0auBRrzdnh3
	mCvUNnsAbXGWVQMShZ/aI8jXRHdEb7fiQL8iXvN5EttHmRRcIkeA8jv2i/CM9jcnDq//TS/AqXx
	zrwYsQbJpIVKWaa1PunvPoV/REpSrVxz0hf326F/4YLaz0Q7v67d41eyWszQBd7A10qgyHBBSA1
	X6W28j+oWpVolE+pdRgYVdp9LOhtknCLz3geBIbz6MnyLk0td4PN2Xz7eQKI4fmdz1i4A6dhL5c
	WzVBHHmzQUa3duz4iddz8wS+pNrkO/1u8=
X-Received: by 2002:a05:7300:818b:b0:2be:7885:31df with SMTP id 5a478bee46e88-30398618b3fmr3091136eec.17.1778879729276;
        Fri, 15 May 2026 14:15:29 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm8268038eec.4.2026.05.15.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:29 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 27/38] x86: Add early SHA-256 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:13:59 -0700
Message-ID: <20260515211410.31440-28-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The SHA-256 algorithm is necessary to measure configuration information
into the TPM as early as possible before using the values. This
implementation uses the established approach of #including the SHA-256
library directly in the early boot code.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile     | 1 +
 arch/x86/boot/startup/lib-sha256.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha256.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index e283ee4c1f45..071a90f23ae0 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 slaunch-objs			+= lib-sha1.o
+slaunch-objs			+= lib-sha256.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
 
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
diff --git a/arch/x86/boot/startup/lib-sha256.c b/arch/x86/boot/startup/lib-sha256.c
new file mode 100644
index 000000000000..f60df97f9244
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha256.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha256.c"
-- 
2.47.3

