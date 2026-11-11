Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425060;
	b=e62tmruQq/g9/s8ojKKoi3k0sm3j1yv8+Wul4EF28UrVmAnIBH1fnimKz2iZxSIy5iOc
	 lKuGAr05QMsfe0TiCNszJUoScrnHe8GBY5Dw/nMNnHQoUH5F5gGoCyj7k8WPPVwtgyUiW
	 9jNWLS04so8iGBTPNPeD48wWEMj3/U9QyxiKCIjdk5f8v0ITTREJUMzab9xi/lOskrYWN
	 otVPaWZBnZPO860MGCXxp3+J0iGOayvZcO1pG/bVJg1f9jVsZYgUmVR6XiAgVCxjI6UKa
	 +rk87y22UEkgVjfrydKDzha0gskx2KrhDW2Rjoohsko7nAEIcZolIJLP+mUFKo0tjww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=s6lt1PxCFx0agGLbXpFKlY/hoUAzM5xkPqAiIkWnGNA=;
	b=FlHloNaZZT9zJXdPTeUTGUzJjAaa1VEES4xteAkn4i0qnLbQfWMP9ffuY+rmzzKEcZoD
	 ORftzQ8eZMYBXCQhC8/t5GcJux8TNKGTeiHm3xFToHPlHB32Zl7blqTLWp7bHOy/Uam8D
	 OVHZIpDZY42061rNUthq84Rl0wHSlXMkKhHlgv1tDUMdlJljlAsqBjlZMMjLLENh9BMwY
	 zq5s0l9gkerG+P+AlE77GkeDBA7XSiN0L1e6BtK2I15RHgq1fawBMH0UzSazo9OhPeFYC
	 4FCzCz5kQl7wtbxC8udtcRgF7UKdH6iUwZjABFuwnYJB8g/CgBuWb8MRGWAxUjrZbHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QsgVZeT4;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB29606DD5F
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 19:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB29606DD5F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QsgVZeT4
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c734afb8deso4002097b6e.1
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425058; x=1795029858; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s6lt1PxCFx0agGLbXpFKlY/hoUAzM5xkPqAiIkWnGNA=;
        b=QsgVZeT4YDsyKBQ+b13khmBBJrwr7JXkAfi0XDPPRqlCTByajyixHI0e9WMW9RICgM
         an/rgmyf7OrveI4unO5+Jw0Dr4AozlG7/frB2RxrtLBVVh14t33uW1oNi3clkGR++AuB
         PK035+HUX0z3OvvzPp6xjpZM1U6xPrGqAcQEcYQ7WfyFZWZGzrGig/Q3fJpavoEEzYLE
         pyfvus7/jQ9vdQBlHxUuTYccvuUu3kpAUwARs93UhQ/ooS+k7B0PdQk+p329ygtjUVDK
         l3Z4Zaky4XN3mOYyU7LffHo0/xoMlzHoOZ5LPbM5KCIWhTWcxnqIMR3FMNJRoSpcQdYW
         PL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425058; x=1795029858;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6lt1PxCFx0agGLbXpFKlY/hoUAzM5xkPqAiIkWnGNA=;
        b=vrTio12+6M3+uzUAh22a5+iN3D5SKjWoGvdTskOt0Fb+UuxDp6/QywouTjmBEUSQ5w
         GWo2Hqs1zXVoVykXuyhjZJILk55MYFaNYrUIS/4kB2oPmqwDf90n3C2QV581jY3XCWvX
         ricAdnT1FUUkBGlrA3t2AaXMb+sgBSxGDk5MoPo9gqXyfFB9ta1fHPWVATD56AGWHWg1
         S+0CEY5hl/tCZ0qGEA3So4Eb8s5S4hCrxo5rECSPVzU7jodiYjHxMykCLcRnWorWj0Xp
         9ZIqFP/XCP48tTeo/xq+GLtg57vcxmzH/a6N1I992eIl1T26/gA8dh/Y4QGuqSfDPoFX
         XJOA==
X-Forwarded-Encrypted: i=1; AL+hErE8JWoglkpN5LzAhXvs08JJBckrwwF2T04N8A9QHLu54ONIfSUUZt0SjF3KW3OEjwu6sanwRw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/3wJFa0dpaAIfcucbzNnPs3nMQeRqkCkUcqsiFx/xl4NFWmdbl
	Ib2HCqCCOhPwKAYLlzRMWGAWZ5s7Q6UQIe2KvFouE6c9Y9fF7GZ/a85F8j9n2adMUxt5l0aygND
	OY2uOHV9GPcG2pA==
X-Received: from iltr6.prod.google.com ([2002:a92:c5a6:0:b0:542:f469:6209])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:23c7:b0:568:e5f:5dbe with SMTP id 5614622812f47-56b97d0f43cmr3278637b6e.61.1794425058062;
 Wed, 11 Nov 2026 11:24:18 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:06 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-3-dmatlack@google.com>
Subject: [RFC PATCH 2/7] vfio: selftests: Verify memory behavior in vfio_pci_find_mem_bar()
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Write and read back test patterns before returning a BAR from
vfio_pci_find_mem_bar(), restoring the original contents and
PCI_COMMAND_MEMORY state afterward.

QEMU's pci-testdev exposes a readable, writable, mmap-capable BAR2
whenever membar=<size> is passed, even if membar-backed=on was omitted
and accesses are dropped as unimplemented MMIO. Probing the BAR upfront
lets callers skip cleanly instead of failing later DMA or fault checks.

Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index d5308fe61490..9840463594ab 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -13,6 +13,7 @@
 #include <sys/mman.h>
 
 #include <linux/align.h>
+#include <linux/io.h>
 #include <linux/iommufd.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
@@ -265,6 +266,33 @@ static const struct vfio_pci_mem_bar_desc mem_bar_descs[] = {
 	},
 };
 
+static bool vfio_pci_mem_bar_verify(struct vfio_pci_device *device, void *vaddr)
+{
+	const u64 pattern = 0x55aa55aa55aa55aaULL;
+	u16 orig_cmd;
+	u64 orig;
+	bool ok;
+
+	orig_cmd = vfio_pci_config_readw(device, PCI_COMMAND);
+	if (!(orig_cmd & PCI_COMMAND_MEMORY))
+		vfio_pci_config_writew(device, PCI_COMMAND,
+				       orig_cmd | PCI_COMMAND_MEMORY);
+
+	orig = readq(vaddr);
+	writeq(pattern, vaddr);
+	ok = (readq(vaddr) == pattern);
+	if (ok) {
+		writeq(~pattern, vaddr);
+		ok = (readq(vaddr) == ~pattern);
+	}
+	writeq(orig, vaddr);
+
+	if (!(orig_cmd & PCI_COMMAND_MEMORY))
+		vfio_pci_config_writew(device, PCI_COMMAND, orig_cmd);
+
+	return ok;
+}
+
 bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 			   struct vfio_pci_mem_bar *mem_bar)
 {
@@ -273,6 +301,8 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 				  VFIO_REGION_INFO_FLAG_WRITE;
 	size_t i;
 
+	min_size = max_t(u64, min_size, sizeof(u64));
+
 	for (i = 0; i < ARRAY_SIZE(mem_bar_descs); i++) {
 		const struct vfio_pci_mem_bar_desc *desc = &mem_bar_descs[i];
 		struct vfio_pci_bar *bar;
@@ -300,6 +330,9 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 		if (size < min_size)
 			continue;
 
+		if (!vfio_pci_mem_bar_verify(device, bar->vaddr + desc->offset))
+			continue;
+
 		*mem_bar = (struct vfio_pci_mem_bar){
 			.bar = bar,
 			.vaddr = bar->vaddr + desc->offset,
-- 
2.56.0.567.gdb80ae8cd5-goog

