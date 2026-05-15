Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E4405C22
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879760; cv=none; b=iMf3kEr/dA0of9RbMFdYN2naFrP/NiCwP5QIGp7Q6iNqcbA9F2nvehuP13zTFh+LmljQIZT1idsLYBy0Rdkl0ldgaOIaI2thZoPs4iO9q5yKWqhGxtPSfZ4N7jlQrMNhL5X2Yh0fYkIVOj+FN+5hY6nWrRYV4To22GkDkZupSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879760; c=relaxed/simple;
	bh=UwbTsginbKatRYw5xm/hcVI6EpyOnfrhKVxHAkEoevA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKUYBCPT0/3/Wf1Ctg0Re7TWf7kOS02xr/T1LAx096H+OXcoN3S/O22C8DCe8aP8P5JdVVVO3qAh8l6f3ABasJdo93p3YYxVcMQWAJvS6KFtEqkzR0+001p3Cd14SZp36ckcRgONb8RFAVVdHNvFqIKWQjBr8c1Aif2dF3a9hxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+BQyBbO; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+BQyBbO"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f30a4601bbso285823eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879758; x=1779484558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh0gWGTCHr3HLLSp6B0/bzede+AfJuos48AZ5KwqkJE=;
        b=O+BQyBbOewYZf3b3usXZAR1kFTWchf7XRRMAxa19FeK6sb+lB2/y6Ufc539zvLK9L4
         V1+PCW1KHIpyDhwVWTxyQSXdg8MzHDAD+huqx5/4KRdTqULLl9t5EheicyrHfw0bGHYz
         mbF6DBLfMj4hdw9Jmz56blGlHNSYQM/5el49Gyz33VO9Pdlts5dFXPfQq0nOTTgYOpZF
         d9FXRxQU0Z4X7rCOppMb8v4F1ScGJ+i+7GG1+zzjdeODmxfWw/858rUnTb4wi4+0dABH
         S2Bc9SXx1L0jVDypWMsybJ5AziC0AlXRC2z9yKPtM5Zc8knyhW/OsoRMNQ7BRpuxsGMW
         sjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879758; x=1779484558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yh0gWGTCHr3HLLSp6B0/bzede+AfJuos48AZ5KwqkJE=;
        b=o6KQt0GHwpCgYE/2nBxH0VjYGAk/NQO/voihDuzY9NBu2UeoloFQx58hFW94Dxe4d6
         j3mlBszvjYzpp4qnQ63NTjeJE97guXoEcMzYTE1SXGFhtv3ROL8BEPc/IV8Vvhgn16/y
         vhXAD7Fa0WEEJ8MqiCV29ZPOvjOXAiOzcSy3bxb8bD1DoJT3x0WSE/6ahwkTvotIjv2v
         w7+lNlIot0HHNnP1j0/Rncsak2hQXHzkgDN7JOzUBrs7TuxPMTrDYZ/d8PTd7yOTXEwq
         pVApp3AitO+o8NqeipA/GmF8IxAmprfTWC05o6ADKNHUhzQEv1txtoFr/Eqw1Gt4KpnG
         DLYg==
X-Forwarded-Encrypted: i=1; AFNElJ+EgmbtEq5UOc6r/beNadzgt3Hl4163GJ4bWmuwrB7A0wwNgQntAtVmcOOagzXCEpgh+/P4uA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym9kLq4CsapeQh+rjJtXPVBcUQLORK7KwGni/ve9NXaPrlOzRF
	aB/QJEjoCpf+oJl69cyBzfig7YI60wtaPVQjvYNZCyX7zCI8O/ipuDhW
X-Gm-Gg: Acq92OFhPJq++RZlVENM7efQhGRRI/JC8LBH2jBLoawwxtgmJlKTdcaqZz08AUd7lPK
	ERQvP9wIfu9ZT9Xuuk+yM5vrY0LeN7j3CrWF4uZadyxgzZMHvW9vaqcGX9Rq09iHQR/0SM7fqZ5
	Jf2nFQM6JJbp6oFhMLrJkKWWlrWaYIOrxwjQ87+h+I/quBrjaI4ILUd908Zu9+NnHgHz0LfnglK
	2ny1PRDEtRzzdTYat5B+2PWMmzT6/DKPLYo6M7wVJyZ4IjOFrjmKC3/Q65cAz8EyokRJeA2cHkN
	Jhj0P5tRd4//+h7MeoNbzCOikChVXbC2sP+RnCiS7j5hUTsGR0VXsPc28pJmk/nvEAtYkI2ALzW
	oC+QG8wwnHeDTBmP0Xn4i4VuUuKJQ1JrH1lq+mjiR9ovSgDCI/Mz/1iR+dBc8j+Ft3TwygY/t5s
	faQARF0w8YJd5BdnZGuDGAge1h3sIlZDTti3Uwwxz85Q==
X-Received: by 2002:a05:7301:7c12:b0:2ed:e14:7f57 with SMTP id 5a478bee46e88-303986c651cmr3242643eec.33.1778879758108;
        Fri, 15 May 2026 14:15:58 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm8006639eec.12.2026.05.15.14.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:57 -0700 (PDT)
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
Subject: [PATCH v16 37/38] x86/efistub: EFI stub DRTM support for Secure Launch
Date: Fri, 15 May 2026 14:14:09 -0700
Message-ID: <20260515211410.31440-38-ross.philipson@gmail.com>
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

From: Ard Biesheuvel <ardb@kernel.org>

Invoke the Secure Launch protocol exposed by the boot loader at the
appropriate time to perform a measured launch of the decompressed
kernel after ExitBootServices().

Co-developed-by: Ross Philipson <ross.philipson@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/firmware/efi/libstub/Makefile      |  1 +
 drivers/firmware/efi/libstub/efistub.h     | 24 ++++++++++++++
 drivers/firmware/efi/libstub/x86-slaunch.c | 38 ++++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c    | 27 ++++++++++++---
 4 files changed, 86 insertions(+), 4 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/x86-slaunch.c

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index e386ffd009b7..fd5eaf3142b2 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -86,6 +86,7 @@ lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o smbios.o
 lib-$(CONFIG_X86_64)		+= x86-5lvl.o
+lib-$(CONFIG_SECURE_LAUNCH)	+= x86-slaunch.o
 lib-$(CONFIG_RISCV)		+= kaslr.o riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 979a21818cc1..18301ba3ae0f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1267,4 +1267,28 @@ void arch_accept_memory(phys_addr_t start, phys_addr_t end);
 efi_status_t efi_zboot_decompress_init(unsigned long *alloc_size);
 efi_status_t efi_zboot_decompress(u8 *out, unsigned long outlen);
 
+#ifdef CONFIG_SECURE_LAUNCH
+efi_status_t efi_secure_launch_init(efi_handle_t image_handle);
+efi_status_t efi_secure_launch_prepare(struct boot_params *boot_params,
+				       phys_addr_t base);
+void efi_secure_launch(void);
+#else
+static inline
+efi_status_t efi_secure_launch_init(efi_handle_t image_handle)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static inline
+efi_status_t efi_secure_launch_prepare(struct boot_params *boot_params,
+				       phys_addr_t base)
+{
+	return EFI_SUCCESS;
+}
+
+static inline void efi_secure_launch(void)
+{
+}
+#endif
+
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-slaunch.c b/drivers/firmware/efi/libstub/x86-slaunch.c
new file mode 100644
index 000000000000..98ff15f94996
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-slaunch.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/efi.h>
+#include <linux/pci.h>
+#include <linux/stddef.h>
+#include <linux/slr_efi.h>
+#include <linux/slaunch.h>
+
+#include <asm/boot.h>
+#include <asm/bootparam.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+static struct efi_slaunch_protocol *slaunch;
+
+efi_status_t efi_secure_launch_init(efi_handle_t image_handle)
+{
+	return efi_bs_call(handle_protocol, image_handle,
+			   &EFI_SLAUNCH_PROTOCOL_GUID, (void **)&slaunch);
+}
+
+efi_status_t efi_secure_launch_prepare(struct boot_params *boot_params,
+				       phys_addr_t base)
+{
+	if (!slaunch)
+		return EFI_SUCCESS;
+
+	return slaunch->setup_dlme(slaunch, base, mle_header_offset, (u64)boot_params);
+}
+
+void efi_secure_launch(void)
+{
+	if (!slaunch)
+		return;
+
+	slaunch->launch(slaunch);
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cef32e2c82d8..339e63ae84ef 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -833,7 +833,8 @@ static efi_status_t parse_options(const char *cmdline)
 }
 
 static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
-					  struct boot_params *boot_params)
+					  struct boot_params *boot_params,
+					  unsigned long alloc_limit)
 {
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	unsigned long addr, alloc_size, entry;
@@ -877,8 +878,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
 				  seed[0], EFI_LOADER_CODE,
-				  LOAD_PHYSICAL_ADDR,
-				  EFI_X86_KERNEL_ALLOC_LIMIT);
+				  LOAD_PHYSICAL_ADDR, alloc_limit);
 	if (status != EFI_SUCCESS)
 		return status;
 
@@ -890,6 +890,10 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry,
 
 	*kernel_entry = addr + entry;
 
+	status = efi_secure_launch_prepare(boot_params, addr);
+	if (status != EFI_SUCCESS)
+		return status;
+
 	return efi_adjust_memory_range_protection(addr, kernel_text_size) ?:
 	       efi_adjust_memory_range_protection(addr + kernel_inittext_offset,
 						  kernel_inittext_size);
@@ -914,6 +918,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 			       struct boot_params *boot_params)
 
 {
+	unsigned long alloc_limit = EFI_X86_KERNEL_ALLOC_LIMIT;
 	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
 	const struct linux_efi_initrd *initrd = NULL;
 	unsigned long kernel_entry;
@@ -925,6 +930,17 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
+	status = efi_secure_launch_init(handle);
+	switch (status) {
+	case EFI_SUCCESS:
+		alloc_limit = U32_MAX;
+		break;
+	case EFI_UNSUPPORTED:
+		break;
+	default:
+		efi_exit(handle, status);
+	}
+
 	if (!IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL) || !boot_params) {
 		status = efi_allocate_bootparams(handle, &boot_params);
 		if (status != EFI_SUCCESS)
@@ -974,7 +990,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_mem_encrypt > 0)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 
-	status = efi_decompress_kernel(&kernel_entry, boot_params);
+	status = efi_decompress_kernel(&kernel_entry, boot_params, alloc_limit);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to decompress kernel\n");
 		goto fail;
@@ -1029,6 +1045,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	/* If a Secure Launch is in progress, this never returns */
+	efi_secure_launch();
+
 	/*
 	 * Call the SEV init code while still running with the firmware's
 	 * GDT/IDT, so #VC exceptions will be handled by EFI.
-- 
2.47.3

