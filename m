Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55E3F5BFD
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879728; cv=none; b=OkRkKcmmJTMVz262l13Cl4Hr34VXvLxEf5jmA4SqRc+PWc2jstJqzP1SEe6Ew5LyPz5gJF5l03M2CVoHfS++8EQuAAtcGHUDZvl8EY2tHi7PA5H7terDnpZsxjMjTTZBiJs22xH/vfHw7yec2KzXlzD8y1FdYnTWRLCdHjsZMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879728; c=relaxed/simple;
	bh=ws7RALHIgZvmMfHxpeYb691c/xou17qPzYNIPgpKvkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewvaPHIQkMMYry01zkysQki92pTQfASN3+9t/+PkBZKK/MrOVHoYm7Kx5o1vbKFUguP0ZzkGveh/VWTMWSv56On0l3xvIPDZeNKV/0/EFfVaXIMClIo3qqDB0OMayOMTeBLygXUymjTcBaj59BeKsQBOfubelOMh3yx92oIQJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5+SEkXL; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5+SEkXL"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f7020a928eso392758eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879726; x=1779484526; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqo7CRqxUyGu2ximwHeynWdE4uCktJ1VQ9YKgYjfZfU=;
        b=r5+SEkXLOHE7fcxD24F8Ur/ceQnd+XtFRGjRLHvuB7Rhz5jPfzp5rjaTs3wgFHjh5c
         gi4wGppVvVg9jGVinh4lM690WHd7lRwjHBUhgXD4R//5zT1R2g3l2RWJAftJ7tglh/Ml
         /qcWTfssjWtoEl6AnYjJXg3qlCvolTjt91edz9PQJoixK8JVIr7XnZQEyTVmDnFam1J/
         Tgokc0xB+GejJC27IsKmSpE3TZXeZuOwFHo/sYo2Swj+tz4GAxkBnf6nSKKt3nHvQtYk
         uwcHL7SX+YQNpo44NENRD6FSvR/Z13mmRrHhframtq0lSBhtwESuGTQXmLKx3G0jAXaV
         QuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879726; x=1779484526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqo7CRqxUyGu2ximwHeynWdE4uCktJ1VQ9YKgYjfZfU=;
        b=OlHgX6RSKOenqAVBpx2dgCApzPwaUPLjUrCHpUK908lWxvLOpyDjXKpSaTozNwwegg
         bC3GUVhL7uvPBTze6FECD1QNV+tkwNqIBcdrGyfPbdhpo6vCQwKLyS3ItwtdhXvtCUU0
         yputOtqZf6JNwImbgvMm/rwq9CwnIQnWKUs5VIqI466VCcYQX7ltNcTkslFkyTF6IS6M
         KyTAMH43CKu5yLG/jlcfIz0nvGYLMR6DxNKZqFBCDHwrRPbYRhwfj6QBwQMbLZOYbib3
         DTWKUfV9Df6t/zSOC8yk4N7XC4MpGUO9n4Zxo5b4ftAKNWGxgbBqXNPNHGVt8lQZbpxw
         7wPg==
X-Forwarded-Encrypted: i=1; AFNElJ/pCoEaNmC3aEVuIbFtuW65VURxsKKDIRFX09xAj2Px3G3GXrL+pazZjh8HYuY/F/8QM/0XSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrpofX4OE+5j+gsH1p6W+ihxGXf3cr5dn25BLz+J/iIKdbY7KX
	X/XaBcjb1dTbRKf5ny9t9p/WNus5fm9IZy+9Gk3Ucc/yYlXhkWcELKeh
X-Gm-Gg: Acq92OEJA+1K4igYPI0bYATNlri++tEAJKQ/YjGrA0Ju4ZvBouHaWX6Prb8TdGONlTS
	TeWu7MG4Tlu5XmzPI4AqJcK9HAqEOHCubiY5mPZJPggyZvtNgls1tRlrbFrx8qq0uUhv7rUirEW
	trwTKpfxpDNZyTGoUuUVj0GCX+QASCtmF1DrNrWXBc7qUUdP/SI+YCKY74os1bfzOpsd7O97cRF
	umFlGEosl9egX8X98rnnAtQZk91E0DI9zRtiYZanDUmAt4KTztFHyCCnJd2Ben9JMY2ZiJtM20j
	fCW6Bk+TlkQShAM1r5H/zvMVG9f8F/r1bNC+z9NlZzaCu0alyBjmhaXtzcZofYMY0Xn1iRnhcbI
	m9EwjJQ+1j2YDyyy6TCWbFvwrHVdSlJuVA7YlOmlat/gwgn/Ug5MpVjmHE4E7BHhUyuu1CO7EPe
	34WCbxsSgHlocywta6BUGksERBlKPJTiA=
X-Received: by 2002:a05:7300:fb83:b0:2de:cc07:e8b with SMTP id 5a478bee46e88-3039818afa7mr2863582eec.1.1778879726369;
        Fri, 15 May 2026 14:15:26 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302977a9474sm8155633eec.25.2026.05.15.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:25 -0700 (PDT)
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
Subject: [PATCH v16 26/38] x86: Add early SHA-1 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:13:58 -0700
Message-ID: <20260515211410.31440-27-ross.philipson@gmail.com>
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

Secure Launch is written to be compliant with the Intel TXT Measured
Launch Developer's Guide. The MLE Guide dictates that the system can be
configured to use both the SHA-1 and SHA-2 hashing algorithms.

Regardless of the preference towards SHA-2, if the firmware elected to
start with the SHA-1 and SHA-2 banks active and the dynamic launch was
configured to include SHA-1, Secure Launch is obligated to record
measurements for all algorithms requested in the launch configuration.

The user environment or the integrity management does not desire to use
SHA-1, it is free to just ignore the SHA-1 bank in any integrity operation
with the TPM. If there is a larger concern about the SHA-1 bank being
active, it is free to deliberately cap the SHA-1 PCRs, recording the
event in the DRTM log.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile   | 4 ++++
 arch/x86/boot/startup/lib-sha1.c | 6 ++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha1.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 5e499cfb29b5..e283ee4c1f45 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -20,6 +20,10 @@ KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
+
+slaunch-objs			+= lib-sha1.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
+
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
diff --git a/arch/x86/boot/startup/lib-sha1.c b/arch/x86/boot/startup/lib-sha1.c
new file mode 100644
index 000000000000..8d679d12f6bf
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha1.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha1.c"
-- 
2.47.3

