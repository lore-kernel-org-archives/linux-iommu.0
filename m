Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37A409E0A
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879752; cv=none; b=Dqm4O6MYmJRNiysyU1aidgVZzrfzpm/6Bw88X5fsf04FRgWjz0evTVH0goCGzBusNq7ASNf2N162oX3kgzciTYdFSIXR1wpEmDxCQhqCZTWvGlW6eTAwUKezMh/meaSKmzPFZOOKXONRNEQgJ0eZw0EWvF1DpyvzME/5Yp4VEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879752; c=relaxed/simple;
	bh=XbUQZxHpNqBquc7KQic463MCIdXLrI/jlIpArje4CQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGhmf1yuVCp/zy5UPBVdeARmYohdYk14lQm7ARokiceEyFVy5BhguB92033wx5wQL1cav2k53DDg9cqPhXsJ+pUrkQMSNkWwg2qWGF8XT3F8nxkPX+bwLX3pPK5kHLt/1g79RiZrMJ+xg2oUVTH/zfaGT1YakYXAxSBnOOUhgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF7Jm+g7; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF7Jm+g7"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f3c623322bso1046736eec.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879750; x=1779484550; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XRl4qspUk2kb6S4/X/JxR4OkIHL9zexMUP1DlnAUlQ=;
        b=AF7Jm+g7h+OQASWaXh2avjpr5gqrDPJf4oY/AvcWkvyyxuCAfM3z6MI1S9AeYd4s/s
         p+oso7lH8uuCKNXFDbX6hS/T7h03Pd65fb7PnOzv7JCdIGg19602/PYmvNk+ZrP4u1s/
         CIhcVVfHC8F85a+FDm+w2+QYlL7MZjYacps7oWgllAG0fGUvKzrjLRO/HFb+3LOJTakq
         fJnqqBuDe2JLRH2raBtzySF6GpNBOh7OTxZeRCY2iX+DNIB+mh4ICK8JtW4e+0si52rA
         hYX2K/QHK0rfhTWa1A8mFxdibDxturGDGsMsA9XYyRxIUjtc2YdFhGZJJbYzlxkiNRbl
         DziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879750; x=1779484550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+XRl4qspUk2kb6S4/X/JxR4OkIHL9zexMUP1DlnAUlQ=;
        b=jeNETYaTuNcmN463xxrjwMb7DCzazeCbjrPaX/hSBMMM4MuYkUDAaud8VTPc0g1tck
         0NSxgnqKcZHOr0pZ39B95be4ja7aS7QivYbeAGFI4RCJJb/J8SfsNfgjEX0M2PiBiKYH
         EsqDksuijCz0Gyz+EqCsQTWk3tfUgbk0zxNDEk0GbNN6n3Rc3/4CMVJEkQaxVS2fF9CE
         JnuxTCpAngOKhCP2jhWy0HsPwHJt8+K7BFAI9NR8Xz55UTFAGMORXWGqOqjOMl27O+bs
         jjdvFRZNvQarG6vGnJY92xL7euHGb4gGdDQawhMLdzc6Viv4OX5wZj8ycgnrPd1Byus5
         swuw==
X-Forwarded-Encrypted: i=1; AFNElJ/Xu0B1mHxeawe2n+rg6cEil7Bdv+OEKl0FesrjJm3MM9xfC8vHyLvd4zZfF7PPDqreMORFqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSkNy7x3WSgPIdvVuMKcoXev8m3fhv8BidCPRWSYMS14MX0bbP
	OEM12EPNkjDJSMLIbPOE7P0pUY8tLV4yhKJjAMTfmuANZSQbHjz6T/yW
X-Gm-Gg: Acq92OHX7MKI7TChNUkdJ2ilg//Y2aLRCPRB7WpDnUMA4UpGcsV3aUnHcbb7yxN+4Cx
	WzI2Z7QNdgwV3yyGojXrM4c7gevKqB9cdUKywOEDzCT22SUCcSXJ2SReZE2AB7HkBMpNL8ozCWO
	YuUqcTwbXBKaBjr/n0FzovD4M5iHUs+5Eto2bGUttpC5UaCEMg9Ebr7OIvbIaff0gvZMGf/oZAJ
	6pCus9bdOXIeHSq0Vliz/MG2xuGI4uj32kpzSQvkOopWABWnfeZ+dAal9Cc9+KbNP31VpBXkVrW
	zYqikopWvk3JJDRzt4andeG/JJ8Szdg83CDiuU0jImuf9NuFrLt6K0fLZAQ9C7P+Q1Tk8pc+J3e
	69c+PpD8jtE5+yTMfWm3Wh+h9vYkFET9pVd15RsXNgrQH79PuFgBkuYDkh7S2eZWPD5tcTEJety
	5UhZKO70PDQP/usiWqw/bxiaPeS+IbRZ8=
X-Received: by 2002:a05:7300:3252:b0:2ea:5057:a31d with SMTP id 5a478bee46e88-3039818a864mr3228730eec.1.1778879749634;
        Fri, 15 May 2026 14:15:49 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm9461192eec.5.2026.05.15.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:49 -0700 (PDT)
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
Subject: [PATCH v16 34/38] kexec/slaunch: Secure Launch kexec SEXIT support
Date: Fri, 15 May 2026 14:14:06 -0700
Message-ID: <20260515211410.31440-35-ross.philipson@gmail.com>
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

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally, effectively exiting the DRTM
environment.

The function slaunch_finalize() takes a boolean argument that controls
whether a GETSEC[SEXIT] can be issued. When true, the finalize code can
completely shutdown and exit the DRTM. This allows another kernel to
start normally and in turn can re-establish another DRTM session.

In cases where the machine has not been fully shutdown (e.g. when
machine_shutdown() was not called), the SEXIT step cannot be done
(SEXIT will fail if other processors are busy). In these cases SEXIT
is not attempted. This normally occurs on power off or reboot
operations where it doesn't really matter.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/kernel/slaunch.c | 80 +++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  8 ++++
 2 files changed, 88 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index f6e6f1b7e18c..b34997a5f541 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -537,3 +537,83 @@ void __init slaunch_fixup_ap_wake_vector(void)
 
 	pr_info("TXT AP startup vector address updated\n");
 }
+
+static inline void smx_getsec_sexit(void)
+{
+	asm volatile ("getsec\n" : : "a" (SMX_X86_GETSEC_SEXIT));
+}
+
+/*
+ * Used during kexec and on reboot paths to finalize the TXT state
+ * and do an SEXIT SMX operation, exiting the DRTM and disabling SMX mode.
+ */
+void slaunch_finalize(int do_sexit)
+{
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *config;
+
+	if (!slaunch_is_txt_launch())
+		return;
+
+	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!config) {
+		pr_emerg("TXT: SEXIT failed to ioremap TXT private registers\n");
+		return;
+	}
+
+	/* Clear secrets bit for SEXIT */
+	memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Unlock memory configurations */
+	memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Close the TXT private register space */
+	memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/*
+	 * Calls to iounmap are skipped due to the system state this late in the
+	 * kexec process. Local IRQs are disabled and iounmap causes a TLB flush
+	 * which in turn causes a warning. Leaving these mappings is not an issue
+	 * since the next kernel is going to completely re-setup memory management.
+	 */
+
+	/* Map public registers and do a final read fence */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("TXT: SEXIT failed to ioremap TXT public registers\n");
+		return;
+	}
+
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	pr_emerg("TXT clear secrets bit and unlock memory complete.\n");
+
+	/*
+	 * Mostly finalized but the system is still in SMX mode. At this point if the
+	 * system has been quiesced, the APs are halted and the current process is
+	 * running on the BSP, a final GETSEC(SEXIT) can be done exiting DRTM/SMX mode.
+	 * This cannot be done on certain boot paths where the system has not been quiesced
+	 * (e.g. where machine_shutdown() has not been called).
+	 */
+	if (!do_sexit)
+		return;
+
+	if (smp_processor_id() != 0)
+		panic("TXT: SEXIT must be called on CPU 0\n");
+
+	/*
+	 * In case SMX mode was disabled, enable it for SEXIT. Clearing the bit
+	 * anytime during DRTM operation will not have an affect until the next
+	 * GETSEC() op is performed.
+	 */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_info("TXT SEXIT complete.\n");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2fea396d29b9..dd284e5043ab 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -43,6 +43,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/sysfs.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1201,6 +1202,13 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
+
+		/*
+		 * If a Secure Launch is in progress and the current kernel is
+		 * running as a DRTM with TXT, finalize the Secure Launch state
+		 * and do the GETSEC(SEXIT) returning from SMX mode to do the KEXEC.
+		 */
+		slaunch_finalize(1);
 	}
 
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
-- 
2.47.3

