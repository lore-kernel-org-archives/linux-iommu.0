Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0243F58DC
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879750; cv=none; b=pTnWUBuKZoT8VKImsQyLNX4K/BrDguRKT3bUs7IAluiUT3iU4ELj1+/+03+3/d4GjXRHfZmCLkiRtXzOMnUpeS3q+jXCcI/Db/2y4YsGtZO0lsZtXqaAl6sE1yWGx4IEnt+8X1l6/DhiJwbV+HzfxHZnmrt65iuii9ojc3Cz+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879750; c=relaxed/simple;
	bh=lguMqdiHzuRecBR+f+YcsvaeXBnj2IIKNWDOALqRyPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/HYTmJQI9MDgsK+3eo6rGM3V9IqR3COuuQPmLuoyw4tlz1gBpmlI3Ms/YaobV+605c19jmMyGDc6xqaw2abChC/G2xQ5avzzn6B2Eg2Alnqi1OIBeF/YKDoJb7tznS74i0yl1j5xdqU+Cuc1sIa41fhYSV8HHZ+KhY3yaTVoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMT1s/68; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMT1s/68"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1355402eec.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879747; x=1779484547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ermZy1JOQ3bL4uNXgDw9lpn60RTdyK+Y6D8PtSjZ40A=;
        b=hMT1s/68o1AC6qH7eSRcaNAkEPdQmTfAcTKcmGcU8t9InHPYxeaRdKbdPZyfZ/n0Yv
         lriWcJFxw/fUQXKWfVfoca2vCqaCTJWj81YhscMw3j4ZlUe2i6akFX6LRmEl64kI/peV
         /NXNFEtFz0cEWNEpL2q5TOqxIz2LBN7ZRUa0FrwXVXN5EvMkBmroucXs81h5EtlH3wgr
         8EHOWvPxmNXqbcy6r6/836yeEljo86G7iPstiKVXlVUH8q2khWsbPwp5KDDcuIjkfQ43
         ocNW0wBxsxtt6sZorBSm1AOJaOwysecDLHk1xQoUUeCeQjHYZuPpAzBB0jzPTG3SctEc
         r+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879747; x=1779484547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ermZy1JOQ3bL4uNXgDw9lpn60RTdyK+Y6D8PtSjZ40A=;
        b=Kwl/zT6q/WcZ16icsHdJByrKcLga7tlnbk5BDG3SurdpN63mmnk76eg1UYN6QQcmND
         iY+KlxSVWnUlxPKAMLM4bkZX+Itl3YYnkg+dORfJjz+Dm4P+Sj+FVauNbPiuF/fnPVjj
         XB1TMTLVw7qXJ8QkpOm6YvszGPet59+pL3Uu0QvmgsfxUoyMAqlIScXMtG7uzCTkXMhQ
         56skCm1FkhzFevJc5WBuikh5L8bEksMORNuO2UhDKDPC0rdAboeInPF57zP+5lbi8Hue
         kpzb4UzPrZwOoKLa65iDtjHYErKsS09ZX3eVOY/U4JSe3cA4PUMyBXA9361+ij9DZ9L3
         OuTA==
X-Forwarded-Encrypted: i=1; AFNElJ+Gjy+cxyjtZC4XtL44YiCXJIlpJ1YAf2WnZ24TWVVdQThcbKmtRG0gOFe+t3MbrhnQ/UTUCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp1SpJMN4ofnMiKl1/P85Pakb9cX3GJuSdyrgPq1AFkAi66AaF
	QwM1p2VyOhv93MH+pKnaCHvZSiqzev2TImJo5V3SpDEbkjvIw/PbhvmS
X-Gm-Gg: Acq92OFN1GsZDEemH83O7wEo12i/X10ztKu3k6ML7u1aenEouECVwJtxaSeLZIJq6A+
	OrHMeehFtnbmev0p8kWyc1UMfKkJ5aFwZxVy4eJpWGMAVeQFKmCTaRdm9zYGT0JT8BTRmTWm6pU
	NINICmZqh0fQzeV79raVX4js0zHtbpahmPdPcDsguQhmcPhUPdzuUlZ+hxPN/6JUZLxn/smWEOl
	eMfYSe3mLuLkjlmlXWm5ZfZtzGFheNU7sOK54paQu0K0s6NlIwxcc+jn+F9J1cHwrTOov6WXg8a
	uh8NqCKccx7jU84wqsh+1GB50uuKW6yHFsOCjnbQ6pJ9qme1pcvdYV5SxW5lg+zekzolJxJfLNU
	8obBcvy4y/bTMU6fVp4kRATwGeO97G5bIi0MX8VZn229N5Yuax7gzSedPxUNjtyIeUm+4QVU8zi
	Q5+Mbd3SVQkkXl9xsZ0w1XUDlRxIdejFktGWDqpvTzlQ==
X-Received: by 2002:a05:7300:d706:b0:2d3:f43c:d684 with SMTP id 5a478bee46e88-30398191408mr2749976eec.2.1778879746758;
        Fri, 15 May 2026 14:15:46 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e69esm9916134eec.1.2026.05.15.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:46 -0700 (PDT)
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
Subject: [PATCH v16 33/38] x86/slaunch: Secure Launch SMP bringup support
Date: Fri, 15 May 2026 14:14:05 -0700
Message-ID: <20260515211410.31440-34-ross.philipson@gmail.com>
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

On Intel, the APs are left in a well documented state after TXT
performs the secure launch. Specifically, they cannot have #INIT
asserted on them so a standard startup via INIT/SIPI/SIPI cannot
be performed. Instead the early SL stub code uses MONITOR and MWAIT
to park the APs. The realmode/init.c code updates the jump address
for the waiting APs with the location of the Secure Launch entry
point in the rmpiggy image.

The rmpiggy image is a payload contained in the kernel used to start
the APs (in 16b or 32b modes). It is loaded at runtime so its
location and entry point must be updated in the long jump for the
waiting APs by the running kernel.

As the APs are woken up by writing the monitor, the APs jump to the
Secure Launch entry point in the rmpiggy which mimics what the real
mode code would do then jumps to the standard rmpiggy protected mode
entry point.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/include/asm/realmode.h      |  3 ++
 arch/x86/kernel/slaunch.c            | 26 +++++++++++++++
 arch/x86/kernel/smpboot.c            | 47 ++++++++++++++++++++++++++--
 arch/x86/realmode/init.c             |  8 +++++
 arch/x86/realmode/rm/header.S        |  3 ++
 arch/x86/realmode/rm/trampoline_64.S | 32 +++++++++++++++++++
 6 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index e406a1e92c63..e3336c49d26b 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -38,6 +38,9 @@ struct real_mode_header {
 #ifdef CONFIG_X86_64
 	u32	machine_real_restart_seg;
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	u32	sl_trampoline_start32;
+#endif
 };
 
 /* This must match data at realmode/rm/trampoline_{32,64}.S */
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 0179ff855b62..f6e6f1b7e18c 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -511,3 +511,29 @@ void __init slaunch_setup(void)
 	if (boot_cpu_has(X86_FEATURE_SMX))
 		slaunch_setup_txt();
 }
+
+/*
+ * After a launch, the APs are woken up, enter the DRTM and are left to
+ * wait for a wakeup call on a MONITOR address. The block where they are
+ * idle has a long jump to the AP startup code in the mainline kernel.
+ * This address has to be calculated at runtime and "fixed up" to point
+ * to the SL startup location in the rmpiggy SMP startup image. This image
+ * is loaded into separate memory at kernel start time.
+ */
+void __init slaunch_fixup_ap_wake_vector(void)
+{
+	struct sl_ap_wake_info *ap_wake_info;
+	u32 *ap_jmp_ptr;
+
+	if (!slaunch_is_txt_launch())
+		return;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
+				 ap_wake_info->ap_jmp_offset);
+
+	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
+
+	pr_info("TXT AP startup vector address updated\n");
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 294a8ea60298..16a0f2718a38 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -61,6 +61,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
+#include <linux/slaunch.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -989,6 +990,45 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
+
+/*
+ * TXT AP startup is quite different than normal. The APs cannot have #INIT
+ * asserted on them or receive SIPIs. The early Secure Launch code has parked
+ * the APs using MONITOR/MWAIT in the safe AP wake block area (details in
+ * sl_stub.S). The SMP boot will wake the APs by writing the MONITOR associated
+ * with the AP and have them jump to the protected mode code in the rmpiggy where
+ * the rest of the SMP boot of the AP will proceed normally.
+ *
+ * Intel Trusted Execution Technology (TXT) Software Development Guide
+ * Section 2.3 -  MLE Initialization
+ */
+static void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+	struct sl_ap_stack_and_monitor *stack_monitor;
+	struct sl_ap_wake_info *ap_wake_info;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	stack_monitor = (struct sl_ap_stack_and_monitor *)__va(ap_wake_info->ap_wake_block +
+							       ap_wake_info->ap_stacks_offset);
+
+	for (unsigned int i = SL_MAX_CPUS - 1; i >= 0; i--) {
+		if (stack_monitor[i].apicid == apicid) {
+			stack_monitor[i].monitor = 1;
+			break;
+		}
+	}
+}
+
+#else
+
+static inline void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+}
+
+#endif  /* IS_ENABLED(CONFIG_SECURE_LAUNCH) */
+
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -998,7 +1038,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
-	int ret;
+	int ret = 0;
 
 #ifdef CONFIG_X86_64
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
@@ -1043,12 +1083,15 @@ static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
 
 	/*
 	 * Wake up a CPU in difference cases:
+	 * - Intel TXT DRTM launch uses its own method to wake the APs
 	 * - Use a method from the APIC driver if one defined, with wakeup
 	 *   straight to 64-bit mode preferred over wakeup to RM.
 	 * Otherwise,
 	 * - Use an INIT boot APIC message
 	 */
-	if (apic->wakeup_secondary_cpu_64)
+	if (slaunch_is_txt_launch())
+		slaunch_wakeup_cpu_from_txt(cpu, apicid);
+	else if (apic->wakeup_secondary_cpu_64)
 		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip, cpu);
 	else if (apic->wakeup_secondary_cpu)
 		ret = apic->wakeup_secondary_cpu(apicid, start_ip, cpu);
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 88be32026768..ded4dafc6a0a 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -4,6 +4,7 @@
 #include <linux/memblock.h>
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
+#include <linux/slaunch.h>
 
 #include <asm/set_memory.h>
 #include <asm/realmode.h>
@@ -213,6 +214,13 @@ void __init init_real_mode(void)
 
 	setup_real_mode();
 	set_real_mode_permissions();
+
+	/*
+	 * If Secure Launch is active, it will use the rmpiggy to do the TXT AP
+	 * startup. Secure Launch has its own entry stub in the rmpiggy and this prepares
+	 * it for SMP boot.
+	 */
+	slaunch_fixup_ap_wake_vector();
 }
 
 static int __init do_init_real_mode(void)
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 2eb62be6d256..3b5cbcbbfc90 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -37,6 +37,9 @@ SYM_DATA_START(real_mode_header)
 #ifdef CONFIG_X86_64
 	.long	__KERNEL32_CS
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	.long	pa_sl_trampoline_start32
+#endif
 SYM_DATA_END(real_mode_header)
 
 	/* End signature, used to verify integrity */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 14d9c7daf90f..b0ce6205d7ea 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -122,6 +122,38 @@ SYM_CODE_END(sev_es_trampoline_start)
 
 	.section ".text32","ax"
 	.code32
+#ifdef CONFIG_SECURE_LAUNCH
+	.balign 4
+SYM_CODE_START(sl_trampoline_start32)
+	/*
+	 * The early secure launch stub AP wakeup code has taken care of all
+	 * the vagaries of launching out of TXT. This bit just mimics what the
+	 * 16b entry code does and jumps off to the real startup_32.
+	 */
+	cli
+	wbinvd
+
+	/*
+	 * The %ebx provided is not terribly useful since it is the physical
+	 * address of tb_trampoline_start and not the base of the image.
+	 * Use pa_real_mode_base, which is fixed up, to get a run time
+	 * base register to use for offsets to location that do not have
+	 * pa_ symbols.
+	 */
+	movl    $pa_real_mode_base, %ebx
+
+	LOCK_AND_LOAD_REALMODE_ESP lock_pa=1
+
+	lgdt    tr_gdt(%ebx)
+	lidt    tr_idt(%ebx)
+
+	movw	$__KERNEL_DS, %dx	# Data segment descriptor
+
+	/* Jump to where the 16b code would have jumped */
+	ljmpl	$__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(sl_trampoline_start32)
+#endif
+
 	.balign 4
 SYM_CODE_START(startup_32)
 	movl	%edx, %ss
-- 
2.47.3

