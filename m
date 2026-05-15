Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74263FDBED
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879706; cv=none; b=HdzEa+7FSoqP+HqDp9r9uH9lOqeGQtjeelR/542/Vng1VOXXKWhHeAyHxWRQIgI7kdxlYDwyDFUsKCJiuM8PgvbCrH4SDMZXbOk/EZOPVyE6alVAHf6k/qxbwcz0kfY2w2VUn8a+cDQVKthODrJrD8unCKYxQycxzDWHmauVWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879706; c=relaxed/simple;
	bh=qtwiEWwByfHHxjTrlTyTKX/7jH6vLFs54iG3FoiDWyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KG6O350MNDk2K1M/4Gw2qs92PIUvaUb9HLuMIqOn+IxXMoe0A3otvbVa4DYa6mtkrJ3fGOHyJR1Nf4zlZWX/eJRVWAMOuDx8gk7g7eAiqp19fCzHnz7AmFsUxlHGg0U3VSQtny5hfq7f33BWRZKnyzlddGjeU/oSQ1gMgnrv0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzhHA7mP; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzhHA7mP"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-135200bc7d2so449441c88.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879704; x=1779484504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azOcaoqgBG4GOjXSMRG7UYVXI2K8VE7Oo8FvV1FqK6Y=;
        b=DzhHA7mPOpHP3zxySMKRBIFZ6lJD2VvedmPvxcbH4PSr80X65KzjJTPFcF0uKzhNtc
         2aDhWszmwMP/IPQWDEx0bZCn5rI0PhbAY1IXmhJK9k9DTHW+A05yQFsL/aG0tf66+B7N
         EF+SnjCq95UEgB4JOTJCordw2ouP4DH/T+6v4Kwezn0CDZm1aYBiGZfSiEobXyExyF3d
         vcbulyhajhw+ucFpiQXGkjTP+Xjw89unJ8gcgwgaIJ9H1x0LHQu5zTBt9m3izpjJ6DnV
         GN70QCTu3w+/zpE1SOpOfPBvOB0BuUeoX9YbyX6bFyxRW51p7bn7nCkY60vcIX+LeR7r
         rRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879704; x=1779484504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azOcaoqgBG4GOjXSMRG7UYVXI2K8VE7Oo8FvV1FqK6Y=;
        b=Kygc5vjDvi0n6HfHw5sdNwCTmXlv2snjk29EDtSCpWDx1NirrDJtc0GlXsPWQZv79a
         j4WOOXSl/CL1JP02oIMR4sUTky5DKmH6YiwkbR3LRxESUYoqOOenjKX+IfRrN7gYZ2NE
         w1Ki8kwd43jyYLyE+Fzw+XZzIquX84c6rm4tA2AGnytx3MEm4BDvDRhYnUhBqaicVJFe
         L3u7eX3cqaxm4FkWUX2W2OKvb8xFz8acqRD1pcG6KzxAKdRORVcWLj9z8fF9ltWvcU2f
         tkN4Cd+2I1FR+UU22tu76Cbmcav1zjCKlPOZ9eYvWmTUi14vDzexjZUVdtjEaFXDJs2P
         M4aQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KERqRLSEjuvLgXK6W2vgRzfye1Ez+2XbmGuQAAzqXn3eEe8Y/cKRGmXlh8uk3rbgFjdqy1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5c9R49l0lptuUjXcEr3kpdlbaqDzM6IqfjUSo6k4LnEoDzqNQ
	eB9u6EMekQ9jS3N1fd+6Z93ZMXLAccbJtZHSBQJdbjX9gyveNU6ofMBP
X-Gm-Gg: Acq92OHlFOwD/VeCsgj4TBVZEg3n4lmMLi4mO5Rm08qDkK3Em0iSMpEtsMwWVlok3PW
	uQcZGJXCJAWDypeLl2dbJv773AS0MIc55fIA4v9UCC6WVsw6ZkJyPSs7UglqZRS75niCS5GFFBy
	50+wQiIzu9OpYJ8u5TD9Id+9jruVlP7jaw24VH1rlQAxkjKnXJk6lkNLNTun2W6twX6vwD9rDZW
	CaCXhh0j3WbZyx/UWPBXKwGNE/6u4lVg0MUEq3U6BPGKkuV/A+70OQYJjEJvCrbrCxzpRlmdJlr
	U/Bwn0nT478+mw51HJWa+jrgwTcHS9WIO1GBQ+Pi0okrh7aRNvGQa0gIXDsKDEc1MyYZtqIM5PD
	tlmO74iEhhJxm3fsvrptlsEmSjg5HzvHKJ7Awo+jyJtRj8ja5WCk7Yon1WowsfJN/XG/zOlfGfj
	kQSfQmA8v03StaATKg3VEazi3prdExSls=
X-Received: by 2002:a05:7022:239d:b0:133:598c:2b45 with SMTP id a92af1059eb24-1350494e3f6mr2888720c88.31.1778879703912;
        Fri, 15 May 2026 14:15:03 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm9740638c88.15.2026.05.15.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:03 -0700 (PDT)
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
Subject: [PATCH v16 18/38] x86/efi: Secure Launch Resource Table EFI definitions header file
Date: Fri, 15 May 2026 14:13:50 -0700
Message-ID: <20260515211410.31440-19-ross.philipson@gmail.com>
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

The Secure Launch EFI definitions are contained in the Secure Launch
Specification. The definitions are split out into a separate header
file for compilation purposes for EFI vs non-EFI environments in the
kernel.

The specification can be found here:
https://github.com/TrenchBoot/documentation/blob/master/specifications/secure-launch-specification.rst

Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/slr_efi.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/linux/slr_efi.h

diff --git a/include/linux/slr_efi.h b/include/linux/slr_efi.h
new file mode 100644
index 000000000000..5de87a9b38aa
--- /dev/null
+++ b/include/linux/slr_efi.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * EFI Definitions for Secure Launch Resource Table
+ *
+ * See TrenchBoot Secure Launch kernel documentation for details.
+ *
+ * Copyright (c) 2026 Apertus Solutions, LLC
+ * Copyright (c) 2026, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLR_EFI_H
+#define _LINUX_SLR_EFI_H
+
+#include <linux/slr_table.h>
+
+#ifndef __ASSEMBLER__
+
+/* EFI Support */
+
+/* SLR table GUID for registering as an EFI Configuration Table (put this in efi.h if it becomes a standard) */
+#define SLR_TABLE_GUID			EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
+
+/* Secure Launch EFI runtime protocol */
+#define EFI_SLAUNCH_PROTOCOL_GUID	EFI_GUID(0x534189e0, 0x6fde, 0x413d,  0xbe, 0x91, 0xcd, 0x4e, 0x8d, 0x67, 0x2f, 0xea)
+
+struct efi_slaunch_protocol {
+	efi_status_t
+	(__efiapi *setup_dlme)(struct efi_slaunch_protocol *this,
+			       u64 dlme_base,
+			       u64 dlme_header_offset,
+			       u64 dlme_table);
+
+	efi_status_t
+	(__efiapi *launch)(struct efi_slaunch_protocol *this);
+};
+typedef struct efi_slaunch_protocol efi_slaunch_protocol_t;
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* _LINUX_SLR_EFI_H */
-- 
2.47.3

