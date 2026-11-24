Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531737;
	b=qjcfhOtxBYF7KcvD32tRWCZXTD9Ik0TZ1tVV4fYE2etqeux3rJteFSuhfe1orhkFPquV
	 uJdOceUwLjotfNOUR1tZCDwVDKCCGXEx6PsN7imtQfhstE9bgRBd5Up8I/8vYD6dE7Ko3
	 EJhWd4IBM9teQOwe4II1XMjwb4+0Rz1ChuCzIdGNEEn4WVC58umhF52QlmUJSaJm+uerI
	 gVdiDIu2XvEEEQkZO28OsEvLFKB+cy1Z0OUtKCDdIb3Y5Z8emdze8uNqNCju+4/ijuAQP
	 4us8f3ShfZD3RrfiUhKypZiAxNyl0QrSiQqREONvI7YszWVEekqiLhxipkeQpj1YqUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531737;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=v4XTDh7yGuOV+1Omye4+wgEj7R56IUboJQT1Dq56D90=;
	b=1SG4yJ7rUnQI/bvb/gHGGwlhF829x6n8PpNx37OEu0FUCHilDVP4m407MFbx6fwlD0Q3
	 zAuY6I5F7IhaCvMYBrjHzeqnyDSx6LaZoVpuJSN6OhErzXwcD2+dSDxEy3gPkjW0mOpPP
	 0hyLiMx2kuYodLP2wEkU8KReOBaSVogUH3hkaacF6NOYlsjSLUBNohDlUMS4O458/7ump
	 Fo9ATLfPW4kZNBZAY4rt/Ov5zl/7n4AYjd1fYqFhy92LtfkdfF5EGNRiLEmgt0i8LAEWm
	 YCifVO75auTkj7jb2xrG5tQpnuPA+NLnd8wldU/UI62N2bAKOHlKwO8jWe40Pxl6ekQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=QC6LhSui;
	arc=none smtp.remote-ip=185.70.43.167
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EF606A31E;
	Tue, 24 Nov 2026 14:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA0EF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=QC6LhSui
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795531734; x=1795790934;
	bh=v4XTDh7yGuOV+1Omye4+wgEj7R56IUboJQT1Dq56D90=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QC6LhSuij9JsD0p4k7g4vtDJMuupzflicUPjgue2+D31VNMDj2hMoYHFLQPBdrI71
	 eG/yYhxPN/zs/0HVWHwq/as1Bt5JOgkduEosOTMGFmumN2Qm1Zw/ocbgG0ECbtkoUd
	 pcoPbWGNoroiU33F4f7kOIGFlz09OL/Xrbm8bqhUIwpPcOMDmoKpNq1CpyR3oJagA3
	 cwpf+5ukC5V2YHI8OnyUEtaPCG4IX1M1ItOyOrdV6ltUFW88s75wfPPobKxIorXhfE
	 Xaq8JCwfz5H6QjGi2iw7JTqp11O2U0gqM5HpKwOP1o8D+/AxqGmAzuI/5j8Z6BXGHf
	 rQxlTrhcTj0Qw==
Date: Tue, 24 Nov 2026 14:48:48 +0000
To: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, Baolu Lu <baolu.lu@linux.intel.com>, Thorsten Leemhuis <regressions@leemhuis.info>, "info@aigeus.net" <info@aigeus.net>
From: 70sp <70sp@protonmail.com>
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
Message-ID: <QISmXFlpPMgvFUKmdIBDwqn4JHHXt2NZeJzerMLHF_5icLo0lPKVlN0Ig9v8Vb52NmCeSFdyrao4x8KoN1DCXtDlnZS7eRIClC6vZyu-hPU=@protonmail.com>
In-Reply-To: <275dbe0d-0b2d-4ec4-9c8c-9bd7ddf06070@linux.intel.com>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com> <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com> <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com> <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com> <7ec374cb-9a0a-4e30-8410-3a028e46cacd@linux.intel.com> <5bVscg7a2_H1PPW3HmVtrYv_Xwtti2hzjD065W4OdwsD9rC2gw7sGVEg-2U596VZn8O2LAEfhWeZklRk63ymqNW9220R6R_jjif7BaWol9o=@protonmail.com> <82662a17-f9e2-46dd-9881-792412c1dc50@linux.intel.com> <X7nc9tQqVxmuR76GYNJnMRkqUTwNVlXTWpH0wGvJeiAHlcLaibPZHRN037p0359GpdmopB_wI2tF2x6EqZF4oY9J697tcTGYwfYMK96FcUs=@protonmail.com> <275dbe0d-0b2d-4ec4-9c8c-9bd7ddf06070@linux.intel.com>
Feedback-ID: 144929603:user:proton
X-Pm-Message-ID: d520ef07ea37302ab1e531094c992b0d5f8b3ff1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I (alongside ChatGPT) found the solution and the root cause of this issue.

The regression is caused by the code improperly assuming that the CPU suppo=
rts IOMMU superpages, which it does, but only when the integrated GPU is di=
sabled (speciality of Intel Haswell).

The regression can either be fixed with a single kernel parameter "intel_io=
mmu=3Don,sp_off" or by modifying the code.

The LLM also generated me a patch that worked, but it was just about hardco=
ding specific CPUs to not use superpages. Doesn't seem like a great solutio=
n for this very delicate code. A much better solution would likely be makin=
g a patch which checks for superpage compatibility universally.

I am sending a working patch from a month ago edited by me and the reasonin=
g from ChatGPT (if somebody would find it useful) below.

the patch:
---
 drivers/iommu/intel/iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..dd49a4e37653 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
 #include <uapi/linux/iommufd.h>
+#include <asm/cpu_device_id.h>
=20
 #include "iommu.h"
 #include "../dma-iommu.h"
@@ -1876,6 +1877,13 @@ static int __init init_dmars(void)
 =09return ret;
 }
=20
+static const struct x86_cpu_id haswell_cpu_ids[] __initconst =3D {
+=09X86_MATCH_VFM(INTEL_HASWELL, NULL),
+=09X86_MATCH_VFM(INTEL_HASWELL_L, NULL),
+=09X86_MATCH_VFM(INTEL_HASWELL_G, NULL),
+=09{}
+};
+
 static void __init init_no_remapping_devices(void)
 {
 =09struct dmar_drhd_unit *drhd;
@@ -1907,6 +1915,14 @@ static void __init init_no_remapping_devices(void)
 =09=09/* This IOMMU has *only* gfx devices. Either bypass it or
 =09=09   set the gfx_mapped flag, as appropriate */
 =09=09drhd->gfx_dedicated =3D 1;
+
+        /* Haswell requires superpages to be disabled in the default
+=09=09   remapping unit too when integrated graphics is enabled. */
+=09=09if (intel_iommu_superpage && x86_match_cpu(haswell_cpu_ids)) {
+=09=09=09intel_iommu_superpage =3D 0;
+=09=09=09pr_info("Disabling superpages on Haswell with integrated graphics=
\n");
+=09=09}
+
 =09=09if (disable_igfx_iommu)
 =09=09=09drhd->ignored =3D 1;
 =09}
--=20

the reasoning from ChatGPT:
Haswell GPU passthrough has been reported to fail since the v6.13 VT-d
domain capability changes. The reported fault is a legacy-mode reserved
PTE field fault, and the dump ends at a level-3 entry with the large-page
bit set (0x00000003c0000883), i.e. a 1 GiB mapping.

Before commit c376a3456d8b ("iommu/vt-d: Remove domain_update_iommu_cap()")=
,
domain_update_iommu_superpage() intersected the superpage capabilities of
all active remapping units. An active IGD unit without superpage support
therefore prevented superpages in the default remapping unit as well.
Removing the capability update exposed the default unit's own superpage
capability to domains allocated for devices behind it.

The Desktop 4th Generation Intel Core Processor Family Datasheet,
Volume 1, document 328897-010, section 3.1.2, page 43, requires disabling
superpages in the default VT-d engine when integrated graphics is enabled.
The mobile M/H and U/Y datasheets (328901-006 and 329001-007) describe the
same restriction. This provides a possible explanation for the regression
even when the default unit advertises superpage support.

Disable superpages on Haswell client CPUs when discovering a populated
graphics-only remapping unit. Do this before domain allocation, using the
existing superpage-disable policy, so both allocation and attachment keep
their existing page-size rules. The check precedes the igfx_off handling:
bypassing graphics translation does not disable the integrated graphics.
Systems without a graphics-only remapping unit and other CPU families keep
their existing behavior.

This is a candidate fix; the reported hardware failure has not yet been
retested with this change.

Fixes: c376a3456d8b ("iommu/vt-d: Remove domain_update_iommu_cap()")
Reported-by: 70sp <70sp@protonmail.com>
Link: https://lore.kernel.org/regressions/275dbe0d-0b2d-4ec4-9c8c-9bd7ddf06=
070@linux.intel.com/
Assisted-by: OpenAI ChatGPT

---
RFC: hardware confirmation and a full kernel build are still required.
The Fixes tag identifies the suspected loss of the global capability
intersection, not a hardware-verified diagnosis.

Prepared against the inspected source at Torvalds' mainline commit
cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a (2026-10-31).
Only web-rendered source excerpts were accessible in this environment;
their indentation was reconstructed. Patch application was checked against
those excerpts, not a complete, byte-identical kernel checkout.

Validation performed:
  - All hunk context matched the inspected mainline text after ignoring
    leading whitespace; no upstream source text was invented for a hunk.
  - git apply --check --whitespace=3Derror-all, forward application and
    reverse application checks passed on a source-fragment fixture.
  - Added lines passed trailing-whitespace and 100-column checks.
  - The extracted init_no_remapping_devices() function compiled in a
    userspace harness with GCC, -Wall -Wextra -Werror and UBSan. The
    unpatched excerpt failed the modeled Haswell/IGD policy requirement;
    the patched excerpt passed 896 modeled platform/page-size cases.
    Kernel APIs were stubbed: this is not a kernel or VT-d hardware test.
  - The model covered all three matched CPU variants, unaffected CPUs,
    missing and sparse device scopes, mixed-device remapping units,
    include-all units, duplicate graphics units, sp_off, and igfx_off.

Not performed: a full-tree apply check, kernel build, boot, GPU passthrough
test, checkpatch.pl run, or get_maintainer.pl run. These require a complete
kernel checkout and, for runtime verification, the affected machine.

Suggested confirmation on the affected Haswell / GTX 970 machine:
  1. On the failing kernel, append sp_off to the existing intel_iommu=3D
     options for a test boot (for example intel_iommu=3Don,sp_off). Keep
     the other boot, firmware and VM settings unchanged. Retry the VM.
     A successful test would support the superpage hypothesis; failure
     would mean this candidate needs further investigation.
  2. In a full mainline tree at the base commit, run:
       git apply --check 0001-iommu-vt-d-disable-haswell-igfx-superpages.pa=
tch
       git apply 0001-iommu-vt-d-disable-haswell-igfx-superpages.patch
     Then build with the reporter's configuration. Also build the affected
     driver with x86_64 defconfig plus CONFIG_INTEL_IOMMU=3Dy and W=3D1, an=
d run
     scripts/checkpatch.pl and scripts/get_maintainer.pl on the patch.
  3. Boot the patched kernel without sp_off and repeat the same VM test.
     Expect "DMAR: Disabling superpages on Haswell with integrated
     graphics" in dmesg. Confirm the VM starts, the NVIDIA driver loads,
     and the previously reported DMA fault does not recur. Exercise VM
     restarts and a GPU workload. Keep a known-working kernel available.
  4. If possible, confirm that a Haswell machine with IGD disabled in
     firmware, and a non-Haswell system, retain their page-size behavior.

Tradeoff: affected hosts use 4 KiB IOMMU mappings, increasing page-table
memory and potentially IOTLB pressure. Performance has not been measured.
The change does not bypass DMA translation or relax mapping permissions.
The supplied report establishes a functional regression; it does not
demonstrate a security boundary violation.

Source references:
  https://lists.openwall.net/linux-kernel/2024/11/04/29
  https://intel.manymanuals.com/processors/cm8064601618605/datasheet-16448/=
43
  https://device.report/m/be82c9d9f78a11870a802bca7e42a85048a57a958523fed45=
96058d76f0c9e30.pdf
  https://manuals.plus/m/45f81faae3cbf90473b6edc6d16f7451659a1afeea58999fe3=
19dfe1fc07c5b5


Best Regards,
=C5=A0imon Posp=C3=ADchal
