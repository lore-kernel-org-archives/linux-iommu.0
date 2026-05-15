Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAD4048B5
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879734; cv=none; b=uMYx0eMrUIEUE4b5fiFoRj40WCfrDZH4LBCP0qLBLvzAFpezBIbmNrn12BlCZNEbczT5jEkdSfp9ZASsIwTp9Nr8Ztm7G87THdC8vOVVXuTYb+J/X5UbBRwasxy7yoSvQy4S7VEk62+DHlYNqVzrYqxycWmEC7L5NjLXrBuqmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879734; c=relaxed/simple;
	bh=ILT1qaKW78nRQkC/CMCLSzr2h8dTPOcGoDMHkPnSKzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9OyhjR63ixrI5ybHRrtV0Ggo9oh5A5dMo2O4d7TF8rkhfFqJMURybQ9Y/Ym0pQVnUhT380FJjQ1vo0NoHGTU+mdrONsL+q5KicYxCwGuE3XRcNRtTr6dhWoKPuCv+eONr6jRQMKGfZNipJtgzROeuaOiiyHhRBL7RA+ZBAY+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA8kfawP; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA8kfawP"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c1a170a50so288794c88.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879732; x=1779484532; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF0BH6dZpM5RACWLo6N4NcvxHw87HpE9a7jatFY2Xnk=;
        b=SA8kfawPT8KH5Quft+CKzMHG8V/79Uy1qJ332ZoP5exFl+ixC3ttgVDDdkp6DrkNO9
         PPyneo7toNEA5GZ0Vu+RMG2EXMnyqfm9sdgvlAu/XZ8MBUi1eBQDjQwsn0HpHv6mAGiO
         GLBoWmej/t8LzXG9yveg3MC4GCYYRhMZn8sEVlJkf5T+VYw+doeZsi7ceAQx0e/RkGnZ
         TrNrtjfAygZAsHICS/0NVjhMIlZkZg1awVBkw+N1JmMTCcdP+5dmsxWzinorpyGbuSza
         rqByfFdTNVG2VtpPmue6RafWt8vZg/xQlLm+y9/Sc79JauUGrjzLYqAU7YhaHSJLwVPw
         oUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879732; x=1779484532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aF0BH6dZpM5RACWLo6N4NcvxHw87HpE9a7jatFY2Xnk=;
        b=WKShZgCIhTB+b3fE1w85pzkwoh2vV2mtt6WEmZINUgVYcIfHvu8FNv2FMdeH2ZkLF9
         ZMMe8nlhpsECp2RDkxX9zuejw+ZnNlBHX8r7OiLeBgOywAdBHplLHG45CCPqjWjwMBn0
         /ggz/TogGz4uV50VzwdCJqtHM3VzolhqbzyMooDDcWZzkR2CitXtx6uoW32PTxPCa9YY
         FSzno6zB4dGee200dSCIVnAugsRQH7yH5iNorbzicZhhJmAjTs5BlKbael1Y91649i0K
         OZTbap2qjn3p8kdG3NI+8ZaBLlekERopwAEeIE2LMlfeME1LC4ksm6KlpyA1O/i05g30
         3xkA==
X-Forwarded-Encrypted: i=1; AFNElJ++EYRwiIt1q7FUsYcJRs2uJGJn7AETB6vGMXVTOXpckau1TfSGhmp62MhGGYe69b+CYB6BHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8paOZ+PheHkKds74uMYzywQCvzhKqAIBfgsTJQ+iyCJhhuX09
	MwN8jnLsVUTrNhupBB5777M60o/0jvlmmAfEf95CDWQG9+t9nXKdFKDE
X-Gm-Gg: Acq92OEc3nbJwqub2PnFPgxZR+X9Ejkh0oelUDdu9Obv2C9tUcwGMZUg0i9zOUElcKL
	NgF5WeEvcxjRtkwN9z68L4D292Enc0HuvLrSEGi/7XX1EqOOZSZzlJXVgn4O5lmyGyigP1xVpbs
	o+sdwgliKjEdbbNrlRfAgozgfToUIa4uNMR8sB5wXYW+ljT2uuicccZE3R4oQPoWqQQZ/Y2luL4
	I5ou/GicIKWzM02faRoko9HO1fV1JRq2F6EDMUvyLjQyntBR4YJi42JuPAQriodwgkZtVncKm9i
	Dpmn78YUo9BIeP6U7UKd8LUDqZqdMZnPErnRJ2Lmug2X17ylpXsf2zyD/ACSe+Xs1E4qpArbD6b
	qI5er80YuiK74DxoEuqm0ZCqhpz5dWRC/4FI/1n1L+y9Icr6KvimBLq5zzkNPxyw33yjC+X9nWM
	pJHr10fyN20UrXZGQRdYjsQ1c7lCE/PYHzEljvNu4ySQ==
X-Received: by 2002:a05:7022:6621:b0:134:a710:d908 with SMTP id a92af1059eb24-1350451887emr2398095c88.13.1778879732067;
        Fri, 15 May 2026 14:15:32 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm11245224c88.12.2026.05.15.14.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:31 -0700 (PDT)
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
Subject: [PATCH v16 28/38] x86: Add early SHA-384/512 support for Secure Launch early measurements
Date: Fri, 15 May 2026 14:14:00 -0700
Message-ID: <20260515211410.31440-29-ross.philipson@gmail.com>
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

On newer TPM 2 implementations, SHA 384 and 512 banks may be available
for use. If these banks are enabled in firmware, they will be used for
the Dynamic Launch. The DLME will also use these algorithms to measure
configuration information into the TPM as early as possible before using
the values. This implementation uses the established approach of #including
the SHA-512 library directly in the early boot code.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/startup/Makefile     | 1 +
 arch/x86/boot/startup/lib-sha512.c | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/x86/boot/startup/lib-sha512.c

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 071a90f23ae0..527cba7e4560 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 slaunch-objs			+= lib-sha1.o
 slaunch-objs			+= lib-sha256.o
+slaunch-objs			+= lib-sha512.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= $(slaunch-objs)
 
 pi-objs				:= $(patsubst %.o,$(obj)/%.o,$(obj-y))
diff --git a/arch/x86/boot/startup/lib-sha512.c b/arch/x86/boot/startup/lib-sha512.c
new file mode 100644
index 000000000000..2afd5c5935cd
--- /dev/null
+++ b/arch/x86/boot/startup/lib-sha512.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ */
+
+#include "../../../../lib/crypto/sha512.c"
-- 
2.47.3

