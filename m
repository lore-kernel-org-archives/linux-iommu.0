Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA574E3766
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879720; cv=none; b=LkTEQYQaqe8O+XYS4pnETQFoh9BVvp3KXceLAYxzo6EJdE7UWLpX/75YTflRWTeMnGKWhIpSkYIQ4kW5ykI3RG69sxaqF0p55j2foB6O4blzcCoCMjsztBjcuU7oQfSvQqyxAoaEcXkkgMJLCbiHhJMTIdtjDW1ZbkcEhiWkWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879720; c=relaxed/simple;
	bh=Zcwz++VNrXh9y6soBYCC7hxdmV5RO3C0KhJ6H3w36Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwhSXwa6UekuEqDk09j9LL/7TnSH4IMedKgx2olbsQ6HNzhxRxGo9zkidAK9b/HgrPD4G0gb8v1S5wGKn548kM4UxJBvksJ2ZOaSnQFOF0Wi2jlZmFnvzC5cefK1Pt5UgB19C7rKpYLAZcm67ggIsZBf6AqKPklt4cxWlXFY6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouJuB3Qh; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouJuB3Qh"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1352958eec.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879718; x=1779484518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8RkPwRSQGNgtwFGhMa45mhqNtBX9nLmlB3IzWi1i0E=;
        b=ouJuB3Qhzk+WOtcGCHz4VnNAsPrLUJqP8Fk/q+SpMHwCyRpaloLeUSDiO+AIrOZz2p
         jQgs3hSE/qyut309tlW5W3+s8rui/B2dx6xKEhO8NzQO8A8CYRIB8LxMmxeriFQlBve5
         UrKQRPBmm4QhVr8UUK7fpsWMRBxSYwDI6SNTSKXizj6dvUPTfhEYtHk3cAienc0mbncL
         aj+aoWO1oLl6uiGDQZUaV21Q2yfij2D6BK3WayzovAb2dvMgW3OseSh3wj32XdtlpVmZ
         PPtBSDUO+cyyFpEZtnnE+WQXcQgYJfiifMmI4BmXAB72bIBmISltF7vrw00XK6m6p9Hy
         Uxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879718; x=1779484518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8RkPwRSQGNgtwFGhMa45mhqNtBX9nLmlB3IzWi1i0E=;
        b=Dif76ncuyRA5Oh69sdCt7b94oYLQul07gbHEbAXXX5SzLSO3KewRgjx751z4F/JUiy
         6EkPj1V5Yi2WR6a0n1HYoK3FjJGes1NSbDqMGlG85Nu5dGYgzDEX0hR9qvU9s7aJOMge
         oSuq6XvMQfLxGUzrfps8OgSVUeE9rseqQ8rqaTkDN9zX46uOnwMjt4JdiG1p3Bh4v+Or
         SKX36pzoYq00T4anvb1VJ4vcASlDoTgs5Z2N8IVw18UrXjmlNVHlZdLOj1pkC4mI7dQG
         WU6ofuPyFwgOauCcIuQ0gY3DdicE/g7kWTs4H81IubzdVettFw87yKS7KZDamu1+HbdQ
         d4Hg==
X-Forwarded-Encrypted: i=1; AFNElJ/wjahh34JL3Dj1/YhLjwW4y3DuGBFA9UprFj0Bpamser5RaxQUyF6AzKYvxsv+Q8mFtCb21w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwYZCTZti0CDqNJ+h9NX9a/Ae7H2xehnVlBKNY4jp3xHDSLN2P
	GUZGaszXxXAdUVUGOnw3bUEcqNqoQoIw7h07wTaA6VFOSsKAS/7VtKaw
X-Gm-Gg: Acq92OELHcqi+Bypk/5CDdCDPxWi3PJp/SYOL0r5cQxB2rO0q0Guk19cfCmHKCTsQAm
	8EAbQwK8lqsPIWpARgRglzkxT0El184aV72mICrukjuqlG++FJ9X5sYVTqyDTNarq4fOIek0GxW
	vJrCjwA+v4rCPJ0g3Zbk7PLJrMy8C1K3281tTGbIPYsyTGbhl8XK479qYtoMf2kCTaMGlwece+2
	yLaktdc+v0rdEMPwUcYE5Rk1/t4/vKSiHasNtKTxxt72gxmn9/lJaUKU19tRQt6ZeCnHKM0jy2y
	YOQOiyTKzZVG4GrwuuFqr0Ab0IjBhySn8+m6QIPMFFIgfQR1ytcQv/qMu8hmcC9FdZVmo6B3JOh
	X9FEfceMjteounV7xKNJgGgVxw0UEmPLZQU9cHDVWH8zaqCRx+zy4QkMc1PZBueC65oLYkcPMts
	EzZhEuC2hnV00ZBrc7KXw8uV11leD3Zuk=
X-Received: by 2002:a05:7300:ad30:b0:2e7:5737:8364 with SMTP id 5a478bee46e88-303984e17ffmr3028118eec.15.1778879717789;
        Fri, 15 May 2026 14:15:17 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm8005268eec.12.2026.05.15.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:17 -0700 (PDT)
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
Subject: [PATCH v16 23/38] x86: Allow WARN_trap() macro to be included in pre-boot environments
Date: Fri, 15 May 2026 14:13:55 -0700
Message-ID: <20260515211410.31440-24-ross.philipson@gmail.com>
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

For pre-boot environments, do not use the static call definition of the
WARN_trap() macro.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/include/asm/bug.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 80c1696d8d59..7899768ae644 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -138,8 +138,14 @@ do {									\
 #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
 
 #ifndef __ASSEMBLER__
+
+#ifndef __DISABLE_EXPORTS
 #include <linux/static_call_types.h>
 DECLARE_STATIC_CALL(WARN_trap, __WARN_trap);
+#define WARN_trap(...)	static_call_mod(WARN_trap)(__VA_ARGS__)
+#else /* __DISABLE_EXPORTS */
+#define WARN_trap(...)	__WARN_trap(__VA_ARGS__)
+#endif /* __DISABLE_EXPORTS */
 
 struct pt_regs;
 struct sysv_va_list { /* from AMD64 System V ABI */
@@ -172,7 +178,7 @@ extern void *__warn_args(struct arch_va_list *args, struct pt_regs *regs);
 #define __WARN_print_arg(flags, format, arg...)				\
 do {									\
 	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS ;	\
-	static_call_mod(WARN_trap)(__WARN_bug_entry(__flags, format), ## arg); \
+	WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
 	asm (""); /* inhibit tail-call optimization */			\
 } while (0)
 
-- 
2.47.3

