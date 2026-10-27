Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116051;
	b=VKazKshk8+z7lKcKZC/pzj16Zl2ta3N4ogTcyzX60cWZW7ydFONZrO6R/upR7zPQawOj
	 Sol70Waq9+n23jOTboA3QJS0ya11sao8Qydg5nWPIqIWiwHcQJ9+ul1k5601ycPvad4p8
	 gTgMkSVbRyI+LTGkpzB4EL+WDKOr56fjSUw5vV12hzNCVEPhhhw42H/ROQ/oPxS6r0Rvj
	 uPuRno3T9Tv6slfX+hOz2CzsjNllM8kh2G/2TG/qNJaieRtfdKL3Emd0HDGiXRNPxnNva
	 td23ufea29eQhEMSjtdVhrqKowf3VjOExFwHPM6LmLxPSYniROU6JM28jNVk0zx7ldA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gS6y/3KjxOydBhZJSD+gtRhGgJ+Jkrm6htgWmalHK40=;
	b=pFgZ1ApPWRNTFvVA9a/5qcVHyRKBbV5qc+oFS6e9GUkWw3BqaGIt1+/oJu6tLUAIZ2XG
	 EwXIUic5e5my3i83VfodVZ3TC8w9kBcvu2gGvu9TdwwwVTQqPXxYiktDntKs6Olhe6Fd3
	 aUcWtlbHktdCofVo/hEiWABT3j8/7fPoO+nOGr/SJiiH/9tosi6cK5iLX1/AB+Vom1fvX
	 h6BStskHQzeJHDrLz2jZbzhhqjWVZwInXHsmQAnYVLt1GI7jm7xeQ3CmYwjInekLi/Rxu
	 nCpztD6RrsaQMAoCVgnOPA+9+MkDYgoDhWhTLYQug/7hsiIrO3EW5+L2oNuv1mhaqvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYK5siZv;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446760709EC
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7446760709EC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nYK5siZv
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e0d885929so2926992f8f.3
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116048; x=1793720848; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gS6y/3KjxOydBhZJSD+gtRhGgJ+Jkrm6htgWmalHK40=;
        b=nYK5siZvJyEvLoIIXtADRgwIqOweUXIlU02v+EQmwznpoxTpps+se9rhHZ/DXMfhjk
         bmkRHuqZt1+8+9OndqicoZx6p9uHMTN2ltAXJ0B1kFpOEZsqnjOtzHWf7Upw1fU/cG+v
         wolGkBqCGeCrAOJbi169VmImgi6AztTe+WmjHpULEt1FZXionroZ5CM1X/9pFBfqmkf9
         PWiYRCpaf1cHbUQQoOKugUc01mSoUnrkuK6lOYxekO/zTGyFccIvnHct9Lw7Ol2khDnX
         DJ9onriwHyOiEK9DhJDUw0dz7+kMwBhHfkBsQ6Fz8fRZAT6QbY5398EokflFn0adWHRW
         S77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116048; x=1793720848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gS6y/3KjxOydBhZJSD+gtRhGgJ+Jkrm6htgWmalHK40=;
        b=cC+jY3esBpUiem+JUbfPVODjHM/qDAG2plGUNfAB+BMLZnwSJjl9ExlRczFiWiTXMQ
         W6DN72A2sc1F+Dd06FrAyFIBOsuA8bwphkL/lw9iz+mTwad48GpMd6Lf83UlQY8cBIKk
         EMbMLJJQJQbrFint3Wa44n5fSM0uZjl5f3mEU8xx6UBsYwl30DXgU3K/Zk5xaax/IGAd
         qIlPIP6FOFkg5FnF47u1sJL9+FH40GiiLsuQ9ZqahDGm9Le6i80SdX/dpyYyzBoA48Ap
         yRpkn+wrf3ZCIqSV2E3u4cKUZU51dU6i2OCOTvkpMt3gGL3TfS+dAPmo0gE+xIZiloHd
         MqnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsCRdNB2+QQG1nPtpYXaka2F4pcLy+ZkxLUREGDaOBXSy0pCKleugvy36nMjNLRfMrBALVGA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJrgNklQk8SrAroft77XNe5drtZZB6KS5q0SDYT0tLL1kH3ug7m
	EG7bjIzAidiuqrXl+B1pGh+++q09wLTQGXRYhWkTI5RH3wnV+tTa42xO
X-Gm-Gg: AYBFou2foie2Q0VyBaTlKEl8NCgOkTX/cbENGLgabhL1UJMsxo7jJEv9XEde4QQ7eb4
	7iyEdsK6Q8DsI4BW1MhXyR+hYRAMM8MpdZa9EZEioRZNNB51KyOTMVXkPQp9myJWOZke4zhWNTK
	vcWrHsOCTRWEf+IVw8aBk2Q9PgjM590Bxp+lKDwdKxJDUR2VJGsMPumAQIMyW5PW3c29DV/dse2
	J2fVn73D0n9MWsglrAd8SvitkfoDKR45PMdlgO5AjaVHBno4SOvTGYLBwey07JIDubV256FRfQH
	Tyw8FwxDpN4Bopp/xPEwU5uJfW0BhNpW6oZ+TOEx4HlYb9dqlgwnhIkSj4sdamtsrQmF6CTQ5lj
	8hitvt0+LL1Wr1RacQRjxEXPpxFBldPCUIt2mi0LeRy8DtrY7AdXDT1VxpN4/GTqP/vt7CamYHS
	rV2/js9B62FpLFqhbhBnYoApUiUPKIZ+V0rGV/19zdT21UHth3xrHiPyFkHkLEJwRAx0hqU58g1
	gO7iA7Q13HoHJEBgiKQK8SEhK3vB1D+9Cdwkosjm3DGfW2rKmimmO9CPmoxrb+PqX+MrRpZd00K
	9OHJLe/t5B1qDK7DeRqGQMaOEA1RHM3+wPAntUzTARf+KfzvPqNLfuR3qiyFRBwoqCMlikEn4bY
	4uSe2uiD9it2HxXMp
X-Received: by 2002:a05:6000:46d4:b0:48e:543f:4467 with SMTP id ffacd0b85a97d-48e543f451bmr6160346f8f.52.1793116047466;
        Tue, 27 Oct 2026 08:47:27 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:26 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: [RFC PATCH 14/14] KVM: selftests: Test guest_memfd mapped by iommufd
Date: Tue, 27 Oct 2026 15:46:49 +0000
Message-ID: <20261027154649.91571-15-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027154649.91571-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

Nothing tests that a device mapping of a guest_memfd follows the file.

Add gmem_conversion_iommufd_test. A KVM_X86_SW_PROTECTED_VM maps its
guest_memfd into an iommufd mock domain, on native folios, a tmpfs
resource and the sample provider in PFN mode, and the test checks what
the guest, the VMM and the device see after each change: conversions,
allocations, punch holes, memory failure, and the provider's revokes and
restores. It is skipped without CONFIG_IOMMUFD_TEST, the PFN mode cases
without the sample, and memory failure without CONFIG_MEMORY_FAILURE.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/gmem_conversion_iommufd_test.c    | 956 ++++++++++++++++++
 2 files changed, 957 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/gmem_conversion_iommufd_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 5f7118bddfc3..4520c102b695 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -162,6 +162,7 @@ TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
 TEST_GEN_PROGS_x86 += x86/guest_memfd_conversions_test
+TEST_GEN_PROGS_x86 += x86/gmem_conversion_iommufd_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/gmem_conversion_iommufd_test.c b/tools/testing/selftests/kvm/x86/gmem_conversion_iommufd_test.c
new file mode 100644
index 000000000000..5d17b0e2dd43
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/gmem_conversion_iommufd_test.c
@@ -0,0 +1,956 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gmem_conversion_iommufd_test - guest_memfd mapped by iommufd.
+ *
+ * A software protected VM has its guest_memfd mapped into an iommufd mock
+ * domain, and converts pages between shared and private.  A conversion to
+ * private must take the page away from the device before the guest can use
+ * it as private; a conversion to shared gives the device the frame again.
+ * The same scenario runs on each backing of a guest_memfd:
+ *
+ *  - native folios;
+ *  - folios from a tmpfs resource (GUEST_MEMFD_FLAG_USE_RESOURCE on a mount);
+ *  - frames of a PFN mode provider (a file of the sample provider).
+ *
+ * The folio backings also check that the device gets the pages that
+ * fallocate() or a first host access allocates, whether the guest_memfd is
+ * mapped before or after, that it loses a page that memory failure poisons,
+ * and that two IOAS mapping one guest_memfd both follow it.  The PFN mode
+ * provider then gets its own checks: read-only frames, which the guest and the
+ * VMM cannot write and the device keeps mapped, private frames, read-only
+ * frames as private holes, absent frames made private, the provider taking
+ * back a private page and giving it back, a punch hole, a 2 MiB private
+ * mapping, and a provider that backs a whole 2 MiB block when one page of it
+ * is asked for and frees it on a punch hole.
+ *
+ * Requires CONFIG_IOMMUFD_TEST; the PFN mode scenarios also require
+ * samples/kvm/mem_provider_sample.ko.
+ */
+#include <fcntl.h>
+#include <errno.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/iommufd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+/*
+ * The iommufd mock domain test interface.  The iommufd selftest helpers
+ * bring their own harness, which does not mix with the KVM selftest library.
+ */
+#include "../../../../../drivers/iommu/iommufd/iommufd_test.h"
+#include "../../../../../samples/kvm/mem_provider_sample.h"
+
+#define PAGE		0x1000ULL
+#define HPAGE		0x200000ULL		/* 2 MiB */
+#define FILE_SIZE	0x400000ULL		/* 4 MiB per guest_memfd */
+#define GPA		(1ULL << 32)		/* the VM maps its file here */
+#define IOVA		(1ULL << 28)		/* inside the mock aperture */
+
+struct guest_args {
+	uint64_t write_gpa;	/* 0 to skip */
+	uint64_t write_val;
+	uint64_t read_gpa;	/* 0 to skip; the value goes to GUEST_SYNC */
+};
+
+static __maybe_unused void guest_code(struct guest_args *a)
+{
+	if (a->write_gpa)
+		*(volatile uint64_t *)a->write_gpa = a->write_val;
+	if (a->read_gpa)
+		GUEST_SYNC(*(volatile uint64_t *)a->read_gpa);
+	GUEST_DONE();
+}
+
+static int ctl = -1;	/* /dev/mem_provider_sample */
+
+static int mps_new_file(uint64_t size)
+{
+	struct mps_new_file nf = { .size = size };
+	int fd = ioctl(ctl, MPS_NEW_FILE, &nf);
+
+	TEST_ASSERT(fd >= 0, "MPS_NEW_FILE(%#llx) errno=%d",
+		    (unsigned long long)size, errno);
+	return fd;
+}
+
+/* MPS_SET_PRESENT or MPS_SET_READONLY on a range. */
+static void mps_set(int fd, unsigned long cmd, uint64_t off, uint64_t len,
+		    bool value)
+{
+	struct mps_set_present sp = { .value = value, .offset = off,
+				      .len = len };
+
+	TEST_ASSERT(!ioctl(fd, cmd, &sp), "MPS ioctl %#lx errno=%d", cmd,
+		    errno);
+}
+
+struct vmm {
+	const char *name;
+	int child;		/* the resource file, or -1 */
+	bool pfn;		/* the resource is a provider file (PFN mode) */
+	int gmem;		/* the guest_memfd backed by it */
+	int iommufd;
+	uint32_t ioas, stdev, hwpt;
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	void *hva;		/* host mapping of the whole guest_memfd */
+	gva_t args_gva;
+};
+
+static void vmm_create_type(struct vmm *v, unsigned long type)
+{
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = type,
+	};
+
+	v->vm = __vm_create_shape_with_one_vcpu(shape, &v->vcpu, 0, guest_code);
+	v->args_gva = vm_alloc_page(v->vm);
+}
+
+static bool vmm_iova_mapped(struct vmm *v, uint64_t iova, uint64_t len,
+			    bool mapped)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd), .op = IOMMU_TEST_OP_MD_CHECK_MAPPED,
+		.id = v->hwpt,
+		.check_mapped = { .mapped = mapped, .iova = iova,
+				  .length = len },
+	};
+
+	return !ioctl(v->iommufd, IOMMU_TEST_CMD, &cmd);
+}
+
+static uint64_t vmm_iova_phys(struct vmm *v, uint64_t iova)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd), .op = IOMMU_TEST_OP_MD_IOVA_TO_PHYS,
+		.id = v->hwpt,
+		.iova_to_phys = { .iova = iova },
+	};
+
+	if (ioctl(v->iommufd, IOMMU_TEST_CMD, &cmd))
+		return 0;
+	return cmd.iova_to_phys.out_phys;
+}
+
+/*
+ * Map the guest_memfd on a 2 MiB boundary: KVM uses large pages only if the
+ * memslot's guest and host addresses are aligned alike.
+ */
+static void *vmm_map_gmem(struct vmm *v)
+{
+	uint8_t *area, *aligned;
+
+	area = mmap(NULL, FILE_SIZE + HPAGE, PROT_NONE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT(area != MAP_FAILED, "%s: mmap(reserve) errno=%d", v->name,
+		    errno);
+	aligned = (uint8_t *)(((uintptr_t)area + HPAGE - 1) & ~(HPAGE - 1));
+	if (aligned > area)
+		munmap(area, aligned - area);
+	munmap(aligned + FILE_SIZE, area + HPAGE - aligned);
+
+	return mmap(aligned, FILE_SIZE, PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_FIXED, v->gmem, 0);
+}
+
+/*
+ * Give @resource_fd (a provider file of the sample, a tmpfs mount, or -1 for
+ * native folios) to KVM as the guest_memfd's resource, and the guest_memfd to
+ * iommufd.
+ */
+static void vmm_attach(struct vmm *v, int resource_fd)
+{
+	struct iommu_ioas_alloc alloc = { .size = sizeof(alloc) };
+	struct iommu_test_cmd mock = {
+		.size = sizeof(mock), .op = IOMMU_TEST_OP_MOCK_DOMAIN,
+	};
+	struct iommu_ioas_map_file map = {
+		.size = sizeof(map),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE,
+		.start = 0, .length = FILE_SIZE, .iova = IOVA,
+	};
+	int r;
+
+	uint64_t flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
+
+	v->child = resource_fd;
+	if (v->pfn)
+		flags |= GUEST_MEMFD_FLAG_PFN_MODE;
+
+	/* KVM: a guest_memfd on the resource, behind one memslot. */
+	if (resource_fd >= 0)
+		v->gmem = vm_create_guest_memfd_resource(v->vm, FILE_SIZE,
+							 flags | GUEST_MEMFD_FLAG_USE_RESOURCE,
+							 resource_fd);
+	else
+		v->gmem = vm_create_guest_memfd(v->vm, FILE_SIZE, flags);
+	v->hva = vmm_map_gmem(v);
+	TEST_ASSERT(v->hva != MAP_FAILED, "%s: mmap(guest_memfd) errno=%d",
+		    v->name, errno);
+	r = __vm_set_user_memory_region2(v->vm, 10, KVM_MEM_GUEST_MEMFD, GPA,
+					 FILE_SIZE, v->hva, v->gmem, 0);
+	TEST_ASSERT(!r, "%s: SET_USER_MEMORY_REGION2 errno=%d", v->name,
+		    errno);
+	virt_map(v->vm, GPA, GPA, FILE_SIZE / PAGE);
+
+	/* iommufd: the guest_memfd, in an IOAS on a mock domain. */
+	v->iommufd = open("/dev/iommu", O_RDWR);
+	__TEST_REQUIRE(v->iommufd >= 0, "iommufd unavailable");
+	TEST_ASSERT(!ioctl(v->iommufd, IOMMU_IOAS_ALLOC, &alloc),
+		    "IOAS_ALLOC errno=%d", errno);
+	v->ioas = alloc.out_ioas_id;
+
+	mock.id = v->ioas;
+	__TEST_REQUIRE(!ioctl(v->iommufd, IOMMU_TEST_CMD, &mock),
+		       "no iommufd mock domain (CONFIG_IOMMUFD_TEST?)");
+	v->stdev = mock.mock_domain.out_stdev_id;
+	v->hwpt = mock.mock_domain.out_hwpt_id;
+
+	map.ioas_id = v->ioas;
+	map.fd = v->gmem;
+	TEST_ASSERT(!ioctl(v->iommufd, IOMMU_IOAS_MAP_FILE, &map),
+		    "%s: IOAS_MAP_FILE(guest_memfd) errno=%d", v->name, errno);
+}
+
+/*
+ * Continue the guest.  KVM_RUN fails with EFAULT for KVM_EXIT_MEMORY_FAULT,
+ * which several scenarios expect; the expect_*() helpers check the exit.
+ */
+static void vmm_resume(struct vmm *v)
+{
+	int r = _vcpu_run(v->vcpu);
+
+	TEST_ASSERT(!r || (errno == EFAULT &&
+			   v->vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT),
+		    "%s: KVM_RUN r=%d errno=%d exit=%s", v->name, r, errno,
+		    exit_reason_str(v->vcpu->run->exit_reason));
+}
+
+static void vmm_run(struct vmm *v, uint64_t write_gpa, uint64_t write_val,
+		    uint64_t read_gpa)
+{
+	struct guest_args *a = addr_gva2hva(v->vm, v->args_gva);
+
+	a->write_gpa = write_gpa;
+	a->write_val = write_val;
+	a->read_gpa = read_gpa;
+	vcpu_arch_set_entry_point(v->vcpu, guest_code);
+	vcpu_args_set(v->vcpu, 1, v->args_gva);
+	vmm_resume(v);
+}
+
+static void expect_done(struct vmm *v)
+{
+	struct kvm_run *run = v->vcpu->run;
+	struct ucall uc;
+
+	TEST_ASSERT(run->exit_reason != KVM_EXIT_MEMORY_FAULT,
+		    "%s: unexpected memory fault at gpa %#llx", v->name,
+		    (unsigned long long)run->memory_fault.gpa);
+	switch (get_ucall(v->vcpu, &uc)) {
+	case UCALL_DONE:
+		return;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("%s: guest exit %s, ucall %lu", v->name,
+			  exit_reason_str(run->exit_reason), uc.cmd);
+	}
+}
+
+static uint64_t expect_sync_then_done(struct vmm *v)
+{
+	struct ucall uc;
+	uint64_t val;
+
+	TEST_ASSERT(get_ucall(v->vcpu, &uc) == UCALL_SYNC, "%s: guest exit %s",
+		    v->name, exit_reason_str(v->vcpu->run->exit_reason));
+	val = uc.args[1];
+	vmm_resume(v);
+	expect_done(v);
+	return val;
+}
+
+static void expect_memory_fault(struct vmm *v, uint64_t gpa)
+{
+	struct kvm_run *run = v->vcpu->run;
+
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_MEMORY_FAULT,
+		    "%s: want KVM_EXIT_MEMORY_FAULT, got %s", v->name,
+		    exit_reason_str(run->exit_reason));
+	TEST_ASSERT(run->memory_fault.gpa == gpa,
+		    "%s: fault at gpa %#llx, want %#llx", v->name,
+		    (unsigned long long)run->memory_fault.gpa,
+		    (unsigned long long)gpa);
+}
+
+static void vmm_destroy(struct vmm *v)
+{
+	close(v->iommufd);
+	kvm_vm_free(v->vm);
+	munmap(v->hva, FILE_SIZE);
+	close(v->gmem);
+	if (v->child >= 0)
+		close(v->child);
+}
+
+static sigjmp_buf host_jmp;
+
+static void host_sig(int sig)
+{
+	siglongjmp(host_jmp, sig);
+}
+
+/*
+ * Read @addr, or write @val to it, through a host mapping.  Return the
+ * signal that the access raised, or 0.
+ */
+static int host_access(volatile uint64_t *addr, bool write, uint64_t val)
+{
+	struct sigaction sa = { .sa_handler = host_sig }, old_bus, old_segv;
+	int sig;
+
+	sigaction(SIGBUS, &sa, &old_bus);
+	sigaction(SIGSEGV, &sa, &old_segv);
+	sig = sigsetjmp(host_jmp, 1);
+	if (!sig) {
+		if (write)
+			*addr = val;
+		else
+			(void)*addr;
+	}
+	sigaction(SIGBUS, &old_bus, NULL);
+	sigaction(SIGSEGV, &old_segv, NULL);
+	return sig;
+}
+
+/*
+ * Poison the page at @addr with MADV_HWPOISON.  Memory failure kills the task
+ * that maps a dirty page with SIGBUS, which counts as done.  Returns 0, or
+ * the errno of madvise().
+ */
+static int host_poison(void *addr)
+{
+	struct sigaction sa = { .sa_handler = host_sig }, old_bus;
+	int r = 0;
+
+	sigaction(SIGBUS, &sa, &old_bus);
+	if (!sigsetjmp(host_jmp, 1) && madvise(addr, PAGE, MADV_HWPOISON))
+		r = errno;
+	sigaction(SIGBUS, &old_bus, NULL);
+	return r;
+}
+
+#define host_read_faults(p)	(host_access(p, false, 0) == SIGBUS)
+#define host_write_faults(p, v)	(host_access(p, true, v) == SIGBUS)
+
+#define MAGIC		0xc0c0a000c0c0a000ULL
+
+/* The page that is converted, inside the file. */
+#define CONV_OFF	(16 * PAGE)
+#define CONV_GPA	(GPA + CONV_OFF)
+#define CONV_IOVA	(IOVA + CONV_OFF)
+
+/* Pages that only fallocate() or the host touch first. */
+#define FALLOC_OFF	(32 * PAGE)
+#define FALLOC2_OFF	(33 * PAGE)
+#define HOST_OFF	(34 * PAGE)
+
+/* A page that memory failure poisons, and its neighbour. */
+#define POISON_OFF	(80 * PAGE)
+#define POISON_IOVA	(IOVA + POISON_OFF)
+
+/* Pages of the file that the PFN mode checks use. */
+#define RO_OFF		(48 * PAGE)
+#define RO_GPA		(GPA + RO_OFF)
+#define PFN_OFF		(64 * PAGE)
+#define PFN_GPA		(GPA + PFN_OFF)
+#define PFN_IOVA	(IOVA + PFN_OFF)
+
+/* The second 2 MiB block of the file, for the large mapping. */
+#define LARGE_OFF	HPAGE
+#define LARGE_GPA	(GPA + LARGE_OFF)
+#define LARGE_IOVA	(IOVA + LARGE_OFF)
+
+enum backing { BACKING_FOLIO, BACKING_TMPFS, BACKING_PFN, NR_BACKINGS };
+
+static const char *const backing_names[] = { "folio", "tmpfs", "pfn" };
+
+/* A software protected VM on @backing, mapped into a mock domain. */
+static void vmm_setup(struct vmm *v, enum backing backing)
+{
+	int resource;
+
+	vmm_create_type(v, KVM_X86_SW_PROTECTED_VM);
+	switch (backing) {
+	case BACKING_FOLIO:
+		resource = -1;
+		break;
+	case BACKING_TMPFS:
+		resource = create_tmpfs_pool_fd("never", true, FILE_SIZE);
+		break;
+	default:
+		resource = mps_new_file(FILE_SIZE);
+		v->pfn = true;
+		break;
+	}
+	vmm_attach(v, resource);
+}
+
+/*
+ * Convert a page to private and back, and check the device, the host and
+ * the guest at each step.  The host and the device reach the page first, so
+ * that a host mapping or an IOPTE left behind would show.
+ */
+static void scenario_convert(enum backing backing)
+{
+	struct vmm v = { .name = backing_names[backing] };
+	volatile uint64_t *host;
+	uint64_t frame, err = 0;
+
+	pr_info("%d. conversions on %s\n", backing + 1, backing_names[backing]);
+	vmm_setup(&v, backing);
+	host = (volatile uint64_t *)(v.hva + CONV_OFF);
+
+	/* Shared: the guest writes, the host and the device see the page. */
+	vmm_run(&v, CONV_GPA, MAGIC, 0);
+	expect_done(&v);
+	TEST_ASSERT(*host == MAGIC, "%s: host does not see the guest's write",
+		    v.name);
+	frame = vmm_iova_phys(&v, CONV_IOVA);
+	TEST_ASSERT(frame, "%s: device does not map the page", v.name);
+
+	/* Private: the device and the host lose it; the guest keeps it. */
+	TEST_ASSERT(!__gmem_set_private(v.gmem, CONV_OFF, PAGE, &err),
+		    "%s: conversion to private errno=%d", v.name, errno);
+	TEST_ASSERT(!vmm_iova_phys(&v, CONV_IOVA),
+		    "%s: device still maps the private page", v.name);
+	TEST_ASSERT(host_read_faults(host),
+		    "%s: host mapping of a private page readable", v.name);
+	vmm_run(&v, 0, 0, CONV_GPA);
+	TEST_ASSERT(expect_sync_then_done(&v) == MAGIC,
+		    "%s: the private page lost the guest's write", v.name);
+	TEST_ASSERT(!vmm_iova_phys(&v, CONV_IOVA),
+		    "%s: device maps the page the guest uses as private",
+		    v.name);
+
+	/* Shared again: the same frame for everyone, contents kept. */
+	TEST_ASSERT(!__gmem_set_shared(v.gmem, CONV_OFF, PAGE, &err),
+		    "%s: conversion to shared errno=%d", v.name, errno);
+	TEST_ASSERT(vmm_iova_phys(&v, CONV_IOVA) == frame,
+		    "%s: device does not map the frame again", v.name);
+	TEST_ASSERT(*host == MAGIC, "%s: host does not see the page again",
+		    v.name);
+	vmm_run(&v, 0, 0, CONV_GPA);
+	TEST_ASSERT(expect_sync_then_done(&v) == MAGIC,
+		    "%s: the guest lost the page on the way back", v.name);
+
+	/* Folios: a punch hole takes the page from the device too. */
+	if (backing != BACKING_PFN) {
+		TEST_ASSERT(!fallocate(v.gmem,
+				       FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+				       CONV_OFF, PAGE),
+			    "%s: punch hole errno=%d", v.name, errno);
+		TEST_ASSERT(!vmm_iova_phys(&v, CONV_IOVA),
+			    "%s: device maps a punched page", v.name);
+		/* Touching it allocates a new page, which the device gets. */
+		vmm_run(&v, CONV_GPA, MAGIC, 0);
+		expect_done(&v);
+		TEST_ASSERT(vmm_iova_phys(&v, CONV_IOVA),
+			    "%s: device does not map the new page", v.name);
+	}
+
+	vmm_destroy(&v);
+}
+
+static void ioas_map_gmem(struct vmm *v)
+{
+	struct iommu_ioas_map_file map = {
+		.size = sizeof(map),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE,
+		.ioas_id = v->ioas, .fd = v->gmem,
+		.start = 0, .length = FILE_SIZE, .iova = IOVA,
+	};
+
+	TEST_ASSERT(!ioctl(v->iommufd, IOMMU_IOAS_MAP_FILE, &map),
+		    "%s: IOAS_MAP_FILE errno=%d", v->name, errno);
+}
+
+static void ioas_unmap_gmem(struct vmm *v)
+{
+	struct iommu_ioas_unmap unmap = {
+		.size = sizeof(unmap), .ioas_id = v->ioas,
+		.iova = IOVA, .length = FILE_SIZE,
+	};
+
+	TEST_ASSERT(!ioctl(v->iommufd, IOMMU_IOAS_UNMAP, &unmap),
+		    "%s: IOAS_UNMAP errno=%d", v->name, errno);
+}
+
+/*
+ * Folios: the device gets a page as soon as it exists, whichever path
+ * allocates it, and whether the guest_memfd was mapped before or after.
+ */
+static void scenario_alloc(enum backing backing)
+{
+	struct vmm v = { .name = backing_names[backing] };
+	volatile uint64_t *host;
+
+	pr_info("   allocations on %s\n", backing_names[backing]);
+	vmm_setup(&v, backing);
+
+	/* Mapped first: fallocate() allocates the page. */
+	TEST_ASSERT(!vmm_iova_phys(&v, IOVA + FALLOC_OFF),
+		    "%s: device maps a page that does not exist", v.name);
+	TEST_ASSERT(!fallocate(v.gmem, FALLOC_FL_KEEP_SIZE, FALLOC_OFF, PAGE),
+		    "%s: fallocate errno=%d", v.name, errno);
+	TEST_ASSERT(vmm_iova_phys(&v, IOVA + FALLOC_OFF),
+		    "%s: device does not map a page fallocate() allocated",
+		    v.name);
+
+	/* Mapped first: the host's first access allocates the page. */
+	host = (volatile uint64_t *)(v.hva + HOST_OFF);
+	TEST_ASSERT(!vmm_iova_phys(&v, IOVA + HOST_OFF),
+		    "%s: device maps a page the host never touched", v.name);
+	*host = MAGIC;
+	TEST_ASSERT(vmm_iova_phys(&v, IOVA + HOST_OFF),
+		    "%s: device does not map a page the host allocated", v.name);
+	vmm_run(&v, 0, 0, GPA + HOST_OFF);
+	TEST_ASSERT(expect_sync_then_done(&v) == MAGIC,
+		    "%s: guest does not see the host's write", v.name);
+
+	/* Allocated first, while nothing maps the file, then mapped. */
+	ioas_unmap_gmem(&v);
+	TEST_ASSERT(!fallocate(v.gmem, FALLOC_FL_KEEP_SIZE, FALLOC2_OFF, PAGE),
+		    "%s: fallocate errno=%d", v.name, errno);
+	ioas_map_gmem(&v);
+	TEST_ASSERT(vmm_iova_phys(&v, IOVA + FALLOC2_OFF),
+		    "%s: device does not map a page allocated before the map",
+		    v.name);
+	TEST_ASSERT(vmm_iova_phys(&v, IOVA + HOST_OFF),
+		    "%s: device lost a page across the remap", v.name);
+
+	vmm_destroy(&v);
+}
+
+/* An IOAS without a domain: nothing maps an area until a device attaches. */
+static void ioas_check_map_overflow(void)
+{
+	struct vmm v = { .name = "folio" };
+	struct iommu_ioas_alloc alloc = { .size = sizeof(alloc) };
+	struct iommu_ioas_map_file map = {
+		.size = sizeof(map),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_READABLE,
+		.start = -PAGE, .length = PAGE, .iova = IOVA,
+	};
+
+	pr_info("   a guest_memfd range that wraps\n");
+	vmm_setup(&v, BACKING_FOLIO);
+	TEST_ASSERT(!ioctl(v.iommufd, IOMMU_IOAS_ALLOC, &alloc),
+		    "IOAS_ALLOC errno=%d", errno);
+	map.ioas_id = alloc.out_ioas_id;
+	map.fd = v.gmem;
+	TEST_ASSERT(ioctl(v.iommufd, IOMMU_IOAS_MAP_FILE, &map) && errno == EINVAL,
+		    "IOAS_MAP_FILE of a wrapping range: errno=%d, want EINVAL",
+		    errno);
+	vmm_destroy(&v);
+}
+
+/*
+ * Memory failure on a page the device maps: the device loses it, and the
+ * poisoned folio stays in the file, so the host cannot fault in a new one.
+ */
+static void scenario_poison(enum backing backing)
+{
+	struct vmm v = { .name = backing_names[backing] };
+	volatile uint64_t *host, *next;
+	int r;
+
+	pr_info("   memory failure on %s\n", backing_names[backing]);
+	vmm_setup(&v, backing);
+	host = (volatile uint64_t *)(v.hva + POISON_OFF);
+	next = (volatile uint64_t *)(v.hva + POISON_OFF + PAGE);
+	*host = MAGIC;
+	*next = MAGIC;
+	TEST_ASSERT(vmm_iova_phys(&v, POISON_IOVA),
+		    "%s: device does not map the page", v.name);
+
+	r = host_poison((void *)host);
+	if (r == EINVAL || r == EPERM) {
+		pr_info("   skipped: no MADV_HWPOISON (errno %d)\n", r);
+		vmm_destroy(&v);
+		return;
+	}
+	TEST_ASSERT(!r, "%s: MADV_HWPOISON errno=%d", v.name, r);
+
+	TEST_ASSERT(!vmm_iova_phys(&v, POISON_IOVA),
+		    "%s: device maps a poisoned page", v.name);
+	TEST_ASSERT(host_read_faults(host),
+		    "%s: host faulted in a new page over a poisoned one",
+		    v.name);
+	TEST_ASSERT(!vmm_iova_phys(&v, POISON_IOVA),
+		    "%s: device maps a poisoned page after a host fault",
+		    v.name);
+	TEST_ASSERT(vmm_iova_phys(&v, POISON_IOVA + PAGE) && *next == MAGIC,
+		    "%s: the next page was lost", v.name);
+
+	vmm_destroy(&v);
+}
+
+/* A second IOAS on the same guest_memfd, with its own mock domain. */
+static void ioas_attach_second(struct vmm *v, struct vmm *w)
+{
+	struct iommu_ioas_alloc alloc = { .size = sizeof(alloc) };
+	struct iommu_test_cmd mock = {
+		.size = sizeof(mock), .op = IOMMU_TEST_OP_MOCK_DOMAIN,
+	};
+
+	*w = *v;
+	w->name = "second IOAS";
+	TEST_ASSERT(!ioctl(v->iommufd, IOMMU_IOAS_ALLOC, &alloc),
+		    "IOAS_ALLOC errno=%d", errno);
+	w->ioas = alloc.out_ioas_id;
+	mock.id = w->ioas;
+	TEST_ASSERT(!ioctl(v->iommufd, IOMMU_TEST_CMD, &mock),
+		    "MOCK_DOMAIN errno=%d", errno);
+	w->stdev = mock.mock_domain.out_stdev_id;
+	w->hwpt = mock.mock_domain.out_hwpt_id;
+	ioas_map_gmem(w);
+}
+
+/*
+ * Two IOAS map one guest_memfd: both follow its conversions, and either can
+ * go away while the other keeps following.
+ */
+static void scenario_two_ioas(void)
+{
+	struct vmm v = { .name = "folio" }, w;
+	volatile uint64_t *host;
+	uint64_t frame, err = 0;
+
+	pr_info("   two IOAS mapping one guest_memfd\n");
+	vmm_setup(&v, BACKING_FOLIO);
+	ioas_attach_second(&v, &w);
+	host = (volatile uint64_t *)(v.hva + CONV_OFF);
+	*host = MAGIC;
+	frame = vmm_iova_phys(&v, CONV_IOVA);
+	TEST_ASSERT(frame && vmm_iova_phys(&w, CONV_IOVA) == frame,
+		    "the two IOAS do not map the same frame");
+
+	TEST_ASSERT(!__gmem_set_private(v.gmem, CONV_OFF, PAGE, &err),
+		    "conversion to private errno=%d", errno);
+	TEST_ASSERT(!vmm_iova_phys(&v, CONV_IOVA) && !vmm_iova_phys(&w, CONV_IOVA),
+		    "an IOAS maps a private page");
+	TEST_ASSERT(!__gmem_set_shared(v.gmem, CONV_OFF, PAGE, &err),
+		    "conversion to shared errno=%d", errno);
+	TEST_ASSERT(vmm_iova_phys(&v, CONV_IOVA) == frame &&
+		    vmm_iova_phys(&w, CONV_IOVA) == frame,
+		    "an IOAS does not map the page shared again");
+
+	/* The second goes away; the first keeps following. */
+	ioas_unmap_gmem(&w);
+	TEST_ASSERT(!__gmem_set_private(v.gmem, CONV_OFF, PAGE, &err),
+		    "conversion to private errno=%d", errno);
+	TEST_ASSERT(!vmm_iova_phys(&v, CONV_IOVA),
+		    "the first IOAS maps a private page");
+	TEST_ASSERT(!__gmem_set_shared(v.gmem, CONV_OFF, PAGE, &err),
+		    "conversion to shared errno=%d", errno);
+	TEST_ASSERT(vmm_iova_phys(&v, CONV_IOVA) == frame,
+		    "the first IOAS does not map the page shared again");
+
+	vmm_destroy(&v);
+}
+
+/*
+ * PFN mode: a read-only frame is mapped read only for the guest and the VMM,
+ * and stays mapped for the device.  The guest maps the page first, so that
+ * marking it read only must zap it.
+ */
+static void scenario_readonly(void)
+{
+	struct vmm v = { .name = "pfn" };
+	volatile uint64_t *page;
+
+	pr_info("   read-only frames on a PFN mode provider\n");
+	vmm_setup(&v, BACKING_PFN);
+	page = (volatile uint64_t *)(v.hva + RO_OFF);
+
+	*page = MAGIC;
+	vmm_run(&v, 0, 0, RO_GPA);
+	TEST_ASSERT(expect_sync_then_done(&v) == MAGIC,
+		    "guest does not read the host's write");
+
+	mps_set(v.child, MPS_SET_READONLY, RO_OFF, PAGE, true);
+	TEST_ASSERT(vmm_iova_mapped(&v, IOVA + RO_OFF, PAGE, true),
+		    "read-only page not mapped for the device");
+	vmm_run(&v, 0, 0, RO_GPA);
+	TEST_ASSERT(expect_sync_then_done(&v) == MAGIC,
+		    "guest cannot read a read-only page");
+	vmm_run(&v, RO_GPA, ~MAGIC, 0);
+	expect_memory_fault(&v, RO_GPA);
+	TEST_ASSERT(host_write_faults(page, ~MAGIC),
+		    "host write to a read-only page did not fault");
+	TEST_ASSERT(*page == MAGIC, "write to a read-only page landed");
+
+	/* Writable again: the guest retries the same write. */
+	mps_set(v.child, MPS_SET_READONLY, RO_OFF, PAGE, false);
+	vmm_resume(&v);
+	expect_done(&v);
+	TEST_ASSERT(*page == ~MAGIC, "write after clearing read only lost");
+	TEST_ASSERT(!host_write_faults(page, MAGIC),
+		    "host write after clearing read only faulted");
+
+	vmm_destroy(&v);
+}
+
+/* PFN mode: private frames, and the provider's changes. */
+static void scenario_pfn(void)
+{
+	struct vmm v = { .name = "pfn" };
+	volatile uint64_t *host;
+	uint64_t err = 0, frame;
+
+	pr_info("4. private pages on a PFN mode provider\n");
+	vmm_setup(&v, BACKING_PFN);
+	host = (volatile uint64_t *)(v.hva + PFN_OFF);
+
+	vmm_run(&v, PFN_GPA, MAGIC, 0);
+	expect_done(&v);
+
+	/* Private: the device and the host lose it, the guest keeps it. */
+	TEST_ASSERT(!__gmem_set_private(v.gmem, PFN_OFF, PAGE, &err),
+		    "conversion to private errno=%d", errno);
+	TEST_ASSERT(!vmm_iova_phys(&v, PFN_IOVA), "device maps a private page");
+	TEST_ASSERT(host_read_faults(host),
+		    "host mapping of a private page readable");
+	vmm_run(&v, 0, 0, PFN_GPA);
+	TEST_ASSERT(expect_sync_then_done(&v) == MAGIC,
+		    "the private page lost the guest's write");
+
+	/*
+	 * The provider takes the private page back: a hole for the guest until
+	 * it comes back, zeroed by the sample.
+	 */
+	mps_set(v.child, MPS_SET_PRESENT, PFN_OFF, PAGE, false);
+	vmm_run(&v, 0, 0, PFN_GPA);
+	expect_memory_fault(&v, PFN_GPA);
+	mps_set(v.child, MPS_SET_PRESENT, PFN_OFF, PAGE, true);
+	vmm_run(&v, 0, 0, PFN_GPA);
+	TEST_ASSERT(!expect_sync_then_done(&v),
+		    "the page came back with old contents");
+	TEST_ASSERT(!vmm_iova_phys(&v, PFN_IOVA),
+		    "device maps a private page given back");
+
+	/* A page that is not backed may become private; the guest faults. */
+	TEST_ASSERT(!__gmem_set_shared(v.gmem, PFN_OFF, PAGE, &err),
+		    "conversion to shared errno=%d", errno);
+	mps_set(v.child, MPS_SET_PRESENT, PFN_OFF, PAGE, false);
+	TEST_ASSERT(!__gmem_set_private(v.gmem, PFN_OFF, PAGE, &err),
+		    "conversion of an absent page errno=%d", errno);
+	vmm_run(&v, 0, 0, PFN_GPA);
+	expect_memory_fault(&v, PFN_GPA);
+	mps_set(v.child, MPS_SET_PRESENT, PFN_OFF, PAGE, true);
+	vmm_run(&v, PFN_GPA, MAGIC, 0);
+	expect_done(&v);
+
+	/* A read-only frame never backs a private page: a hole until writable. */
+	mps_set(v.child, MPS_SET_READONLY, PFN_OFF, PAGE, true);
+	vmm_run(&v, 0, 0, PFN_GPA);
+	expect_memory_fault(&v, PFN_GPA);
+	mps_set(v.child, MPS_SET_READONLY, PFN_OFF, PAGE, false);
+	vmm_run(&v, 0, 0, PFN_GPA);
+	TEST_ASSERT(expect_sync_then_done(&v) == MAGIC,
+		    "the private page lost its contents while read only");
+
+	/* Back to shared: the device maps it again, with the contents. */
+	TEST_ASSERT(!__gmem_set_shared(v.gmem, PFN_OFF, PAGE, &err),
+		    "conversion to shared errno=%d", errno);
+	TEST_ASSERT(vmm_iova_phys(&v, PFN_IOVA), "device does not map the page");
+	TEST_ASSERT(*host == MAGIC, "host does not see the page");
+
+	/* A shared page taken back and given back: the device follows. */
+	mps_set(v.child, MPS_SET_PRESENT, PFN_OFF, PAGE, false);
+	TEST_ASSERT(!vmm_iova_phys(&v, PFN_IOVA), "device maps an absent page");
+	TEST_ASSERT(host_read_faults(host), "host maps an absent page");
+	mps_set(v.child, MPS_SET_PRESENT, PFN_OFF, PAGE, true);
+	TEST_ASSERT(vmm_iova_phys(&v, PFN_IOVA),
+		    "device does not map a page given back");
+
+	/*
+	 * A punch hole gives the frame back to the provider, which zeroes it
+	 * and keeps backing the page: the device maps the same frame
+	 * afterwards, and the host reads it zeroed.
+	 */
+	frame = vmm_iova_phys(&v, PFN_IOVA);
+	*host = MAGIC;
+	TEST_ASSERT(!fallocate(v.gmem, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			       PFN_OFF, PAGE),
+		    "punch hole errno=%d", errno);
+	TEST_ASSERT(vmm_iova_phys(&v, PFN_IOVA) == frame,
+		    "device does not map the page after a punch hole");
+	TEST_ASSERT(!*host, "a punched page kept its contents");
+
+	vmm_destroy(&v);
+}
+
+/*
+ * A private 2 MiB block of a PFN mode provider gets one stage-2 mapping, which a
+ * change inside the block takes away; the rest of the block stays readable.
+ */
+static void scenario_large(void)
+{
+	struct vmm v = { .name = "pfn" };
+	uint64_t before, after, err = 0;
+
+	pr_info("5. a 2 MiB private mapping on a PFN mode provider\n");
+	vmm_setup(&v, BACKING_PFN);
+
+	if (vmm_iova_phys(&v, IOVA) & (HPAGE - 1)) {
+		pr_info("   skipped: the file's frames are not 2 MiB aligned\n");
+		vmm_destroy(&v);
+		return;
+	}
+
+	/* Fault in the guest's code and stack first, then count. */
+	vmm_run(&v, 0, 0, 0);
+	expect_done(&v);
+	TEST_ASSERT(!__gmem_set_private(v.gmem, LARGE_OFF, HPAGE, &err),
+		    "conversion of a 2 MiB block errno=%d", errno);
+	TEST_ASSERT(vmm_iova_mapped(&v, LARGE_IOVA, HPAGE, false),
+		    "device maps part of a private block");
+	before = vm_get_stat(v.vm, pages_2m);
+
+	vmm_run(&v, LARGE_GPA, MAGIC, 0);
+	expect_done(&v);
+	after = vm_get_stat(v.vm, pages_2m);
+	TEST_ASSERT(after == before + 1, "%llu 2 MiB mappings, want %llu",
+		    (unsigned long long)after, (unsigned long long)before + 1);
+
+	/*
+	 * A page taken out of the block removes the 2 MiB mapping; the other
+	 * pages still work.
+	 */
+	mps_set(v.child, MPS_SET_PRESENT, LARGE_OFF + PAGE, PAGE, false);
+	TEST_ASSERT(vm_get_stat(v.vm, pages_2m) == before,
+		    "the 2 MiB mapping survived a change inside it");
+	vmm_run(&v, 0, 0, LARGE_GPA);
+	TEST_ASSERT(expect_sync_then_done(&v) == MAGIC,
+		    "the rest of the block lost the guest's write");
+	TEST_ASSERT(vm_get_stat(v.vm, pages_2m) == before,
+		    "a 2 MiB mapping over a block with a hole");
+	vmm_run(&v, 0, 0, LARGE_GPA + PAGE);
+	expect_memory_fault(&v, LARGE_GPA + PAGE);
+	mps_set(v.child, MPS_SET_PRESENT, LARGE_OFF + PAGE, PAGE, true);
+	vmm_run(&v, 0, 0, LARGE_GPA + PAGE);
+	TEST_ASSERT(!expect_sync_then_done(&v),
+		    "a page given back kept its contents");
+
+	/* Shared again: the device maps the whole block. */
+	TEST_ASSERT(!__gmem_set_shared(v.gmem, LARGE_OFF, HPAGE, &err),
+		    "conversion to shared errno=%d", errno);
+	TEST_ASSERT(vmm_iova_mapped(&v, LARGE_IOVA, HPAGE, true),
+		    "device does not map the shared block");
+
+	vmm_destroy(&v);
+}
+
+/*
+ * A provider that backs a hole with the whole 2 MiB block around it: the
+ * device maps the block, whether a host fault or fallocate() asks for one
+ * page of it.
+ */
+static void scenario_fill(void)
+{
+	struct mps_new_file nf = { .flags = MPS_NEW_FILE_FILL,
+				   .size = FILE_SIZE };
+	struct vmm v = { .name = "pfn" };
+	volatile uint64_t *host;
+	int fd;
+
+	pr_info("6. a provider that backs 2 MiB blocks on demand\n");
+	fd = ioctl(ctl, MPS_NEW_FILE, &nf);
+	TEST_ASSERT(fd >= 0, "MPS_NEW_FILE(FILL) errno=%d", errno);
+	vmm_create_type(&v, KVM_X86_SW_PROTECTED_VM);
+	v.pfn = true;
+	vmm_attach(&v, fd);
+
+	mps_set(v.child, MPS_SET_PRESENT, 0, FILE_SIZE, false);
+	TEST_ASSERT(vmm_iova_mapped(&v, IOVA, FILE_SIZE, false),
+		    "device maps absent pages");
+
+	host = (volatile uint64_t *)(v.hva + LARGE_OFF + 5 * PAGE);
+	TEST_ASSERT(!*host, "a page backed on demand is not zeroed");
+	TEST_ASSERT(vmm_iova_mapped(&v, LARGE_IOVA, HPAGE, true),
+		    "device does not map the block backed for a host fault");
+
+	TEST_ASSERT(!fallocate(v.gmem, FALLOC_FL_KEEP_SIZE, 3 * PAGE, PAGE),
+		    "fallocate errno=%d", errno);
+	TEST_ASSERT(vmm_iova_mapped(&v, IOVA, HPAGE, true),
+		    "device does not map the block backed for fallocate()");
+
+	/*
+	 * A punch hole gives the block back and the provider frees it: the
+	 * device sees a hole until the next access backs the block again.
+	 */
+	*host = MAGIC;
+	TEST_ASSERT(!fallocate(v.gmem, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			       LARGE_OFF, HPAGE),
+		    "punch hole errno=%d", errno);
+	TEST_ASSERT(vmm_iova_mapped(&v, LARGE_IOVA, HPAGE, false),
+		    "device maps a block the provider freed");
+	TEST_ASSERT(vmm_iova_mapped(&v, IOVA, HPAGE, true),
+		    "device lost the block next to the punch hole");
+	TEST_ASSERT(!*host, "a block backed again is not zeroed");
+	TEST_ASSERT(vmm_iova_mapped(&v, LARGE_IOVA, HPAGE, true),
+		    "device does not map the block backed again");
+
+	vmm_destroy(&v);
+}
+
+int main(void)
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) &
+		     BIT(KVM_X86_SW_PROTECTED_VM));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS) &
+		     GUEST_MEMFD_FLAG_USE_RESOURCE);
+
+	scenario_convert(BACKING_FOLIO);
+	scenario_alloc(BACKING_FOLIO);
+	scenario_convert(BACKING_TMPFS);
+	scenario_alloc(BACKING_TMPFS);
+	ioas_check_map_overflow();
+	scenario_poison(BACKING_FOLIO);
+	scenario_poison(BACKING_TMPFS);
+	scenario_two_ioas();
+
+	ctl = open("/dev/mem_provider_sample", O_RDWR);
+	if (ctl < 0) {
+		pr_info("PFN mode scenarios skipped: mem_provider_sample not loaded\n");
+		return 0;
+	}
+
+	scenario_convert(BACKING_PFN);
+	scenario_readonly();
+	scenario_pfn();
+	scenario_large();
+	scenario_fill();
+
+	close(ctl);
+	pr_info("gmem_conversion_iommufd: all scenarios passed\n");
+	return 0;
+}
-- 
2.47.3

