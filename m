Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0403F5BC9
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879722; cv=none; b=E38hW0wZAWsbDdBYUSutEJStnk7rWyqMZEvIcDHDavs326/VB3znqHv5tfRAuR+SQ1innuO8LCSwGSBF5MonbZvNKNDOjQtC+2G6rTIfZwogDIoH6oCexL1uxB0bUY5mLkD6AkCnrjdjy8B2kSWCrefRm4+BOtP6Ec+vukAwF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879722; c=relaxed/simple;
	bh=EYoiytDPHAwrp//ZCSS8x2mbpMMq39lmGS1yWEcEk0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4ZteSkf4XrWP+zGTS0wLWYs5vs/ZKi2RhN6PkD9WFJ5mYvCSKtCfInULxWhMRBdk5O0x5AreH5/1p7i2mnIljvO/2VDlt0rPzRR6NDbiQ4RtmsNuhidzfVobdPwrgoCGSQARfmx7RGKdrX/OUei2C7mPRsRycKlXcxBqIJD1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8I9EEMz; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8I9EEMz"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso106490eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879721; x=1779484521; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjgxy9jrMUn+tA5MZsUkk9qLfIPrTHgv6m9jj+0YWR4=;
        b=h8I9EEMzhagKavfpdtXBxaf6SWLf5+SYcVj2oanBqNXC9Fg3GnXZDy/FNRhJq+8T00
         kyyORrQNdZ59KHgiNZHsgHVFa1VHm3ZQKKpeDiIbTe3686cTj9iES5TJ42eoj05DZIq1
         /huMAy6LayFUjhv2mA8vuUTNcHExsb4dGm8uqD4XOa367WfuXRrcIqlA1NFwKqh4uGOi
         y1W8FGIYFdzMtDy0DHThh8wksSLoqEPbpY4c5Rfa6e1bCGXjMB432xoBrDqo4C2U5EbS
         7Z9SkliEyrKmj/PGhHAmRN5Bw0d0fHf4uZxc//NoA47BOaTlwVuJJ0qw+TInuRfiGnGv
         HSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879721; x=1779484521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjgxy9jrMUn+tA5MZsUkk9qLfIPrTHgv6m9jj+0YWR4=;
        b=YNbD4T8dFTtoIlYZgfLB/PAr3nBQGjyN0ggBpPEM0PjAWYJhFhBR2O96JlFUPPcYeA
         52MGl/cDxqP0b8IPTJQAuVRTnTGhIf84/pP3FtJDYDSYP099fjiago8f3+JrHUvmxqvL
         TnWgBLr2z7tAFEQSg5GGLsA5AieXrKGbr9oKdreEzN4639RXsNlPURCftK9Mp4+YGlva
         C072bGVOg0bwtrKpkl/8xdE1PyxM4NZMU+7bzeBOOHV6iYnBz2od3kD0E90KhQBoxcJV
         qjhHmeKXgznsrY5wP9dNKGPRGzzqjaCNx/mPHo4F8xcc+i8EVpJ1NBUZ0QnfUgvQj+LS
         jmEw==
X-Forwarded-Encrypted: i=1; AFNElJ/IPHB4ROBHxH8iYCwQYinNPXiiMNi2NPQCK/UGhSfFQ/wR+uiEqHe7yhNbrlG74oown8/nwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqJ1knK6w9txSl0/t4+cfZw82jeyTB3Nj2DnwzQegvgMzBC5o/
	cVhOAhdzw92Lmdetuc6Jlb+8oLHS6wQPA+q9PQAtr7NoBB3/6Hz8v9Ph
X-Gm-Gg: Acq92OEoY8RlruJbWRKfxFzHFYUHyYRdvakunO7rozDWsEChtaKtpVQ4Gb1+o+2gqgA
	6uBMXF/YjqaPOyfso4LytJxuEcxzOmgsbovQ4T3sjklca/mhOWycacKF/M0gRNfrdmBgHy+YlDy
	H23QmwgKbX5lk7Z1sKVkeI5r3rx9kG8Dzf2HOj3Y9DB8lKu/OKBZ+479dnJ0XhuS3+d9PiS2vuT
	Xq/udv/sxwutHz19PY0jwqrh/uTEhkHPeujbpE9Fmy6PAEx5CvowpVs4w8YkFHsHBiR+RiL58IR
	myTynUmGR5PTgNC4B3idGpHz9T4Y2QrTei0MAzhyTMxrXNm/5g/0f4RRLHX680uI4/YeAamOTJn
	XLwRy6lB+x+L7tC2MxcumMg8XiHzgRD/JRAr4M1lnp3LxWjo0TfFAG9dbEwwzQDVgjI5qpVOL+x
	dnChkhHVxC7Auijad9E/inRQuzUalrrgE=
X-Received: by 2002:a05:7300:2316:b0:2f3:5d44:eeba with SMTP id 5a478bee46e88-3025fa54325mr4525827eec.6.1778879720563;
        Fri, 15 May 2026 14:15:20 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e3c0sm9975127eec.3.2026.05.15.14.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:20 -0700 (PDT)
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
Subject: [PATCH v16 24/38] x86/msr: Add variable MTRR base/mask and x2apic ID registers
Date: Fri, 15 May 2026 14:13:56 -0700
Message-ID: <20260515211410.31440-25-ross.philipson@gmail.com>
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

Add the MSR values required by Secure Launch to locate particular CPU cores
during application processor (AP) startup, and restore the MTRR state after
an Intel TXT launch.

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6673601246b3..2a95e3389622 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -408,6 +408,9 @@
 #define MSR_IA32_RTIT_OUTPUT_BASE	0x00000560
 #define MSR_IA32_RTIT_OUTPUT_MASK	0x00000561
 
+#define MSR_MTRRphysBase0		0x00000200
+#define MSR_MTRRphysMask0		0x00000201
+
 #define MSR_MTRRfix64K_00000		0x00000250
 #define MSR_MTRRfix16K_80000		0x00000258
 #define MSR_MTRRfix16K_A0000		0x00000259
@@ -960,6 +963,8 @@
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
+#define MSR_IA32_X2APIC_APICID		0x00000802
+
 #define MSR_IA32_UCODE_WRITE		0x00000079
 
 #define MSR_IA32_MCU_ENUMERATION	0x0000007b
-- 
2.47.3

