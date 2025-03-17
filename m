Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7D1EDA1D
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237655; cv=none; b=JhVu3hNqTdOIaPJdF5H80BXZ77i7xpxUrsOEjUgjsJsdb0GHjjIpdbsySiP89EmuzKY2d6bQt2QsdaBkpIiiye7ySq12Q+R+qLeNRwUO7gMefUcBavUpPYaJllXRgHcp2QffmKrSJbtje8dqwGmo6AHatOymtd7/aNOtChubcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237655; c=relaxed/simple;
	bh=NPurUptvYolnP+zwLTc8xyODM40c1STXAevHbBUYyUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKFvyl78du2rZLsHo3KD0YavBd4ACXhDcTc4I4aEO+jKb1mTLXO8zay6wa1hOWyMGEEk1e29vKjW47l4M9mo1wtwyI48TTb9Emo3JlLnxCtAHv65sFCLj2syHOPIDIjCX5mq6MOZP5CDQOq1ofOMJPKddGXHt6qvJPCRiJGkDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEG7T4JG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEG7T4JG"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54954fa61c9so6013708e87.1
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237651; x=1742842451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY0a+7Bd76kNssAI216pzAYL/YAAvUS9w1O5DEvCouw=;
        b=SEG7T4JGz676XYz/bjodyfIYVrfqLBJyNiscTD+oAiJG7pH2CugKPhl8K6idBQyeab
         8umAY1pSGcVySG1/TvoMwt88HPFLGpPVcpB4NPGDODGb4AOj6PKPtmuR+Op4isoWPg9Y
         LDYmXMYD02nfnQq8QD8J/LnKp2d9LnhtjPmxyvgmizr/p/QgevMJ7061gsMmx5ET2gSi
         E5m3aFgtkUwhzpGjMV0qQq27mipN25dKFEzMaJ2ZgX1Z8LrxmeDzS/LK2x9ukYNRJJEk
         Qi1C4nAZpHuHb086O8azFjAlRaN2DhEq0Y1Nrm3LKmkiKaTIhyUdLURYOLlBrQLVrXZQ
         IVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237651; x=1742842451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY0a+7Bd76kNssAI216pzAYL/YAAvUS9w1O5DEvCouw=;
        b=fmQ3x01GjwbqT/cytrrHmVhCF4vQhhjus5/z2XEv7u38PshSIbbCoHwrcBfdjZ6GOK
         UbvdblZvfUSxtdB/5RvoIlaKuYkJA7OXjXG5abtn960uEg3ZvyoX6jktIbdl1Me3Tf3o
         WQ6VYhIjcALjrZyqACHSmBnR+ZfDxtfoCWnqmcmqFlxxf3hJ63Gn7+QlBTG+BxBWeBsr
         q6beKD+7NybqY9e+ctd0yrv1e1eyt3ZqM0G6xWlErdu2Yr8NJ9mqiUvgbcdaFQ4QvRnE
         7BG53khbLdT4NUW67TziIcCraWRd6GR0Z/HW0P25UBFriNPxq4YLViThbok7Psz9G3JH
         LIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMf+dR1+apO6B9u7W5Jsja3lfW+McJb6cIW1tHrV3dRtbsFauJ8R/Vp8/C3eb0x0/sTM0jxw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/2xhsaHIFmVicbp3PJ9QC/E1NpcBafu3QXBEjiLPN7gXxLwgl
	yB70AOL8xBfrwq1+vX6v38+0deDOkPO49OL4nvJSRAECxrtLkBq+
X-Gm-Gg: ASbGncu6t0FFwhCo43jh8VX6LTsJye42hAiX+pGhT8uwkkohodmkDn/x1Z2Y4sToMYn
	jXXE7uR0bp2mkbKg9nkJAlwmTstiTeGE/4hab28Bi44jwDNHEQar9PaENEyG7q2y7Cp7wu8C7ns
	xl3ucZIJM2QtglohhJawyTE9Rd7FgwRybqf52ApzM7mnJn0hjiogTDrq2TlmiFlvpkQne/aVRcC
	hdXGCi2rhLo/QiTcp6oYhzm6khRmRYwdmsaRJYBBSFjMQciYs0Co5t8CAVZLRWIxJuTizCn2HqG
	lZDFm0XJo6UOf6UXWsp/HNfYulajxKHpO9xGXuTWZaMzcrepzP5iKkVuErHhzNo4BElUi9gE4Ve
	nC/u5zjt+EqmK0JwlsY7CUixlztY6yo/6
X-Google-Smtp-Source: AGHT+IEoHmWqOEUAbFn1XAQ9ghX1d5uNsCm0ipDw6XJoieye2FBFqVI/P9sH7ueMp48dHZ+dyTCaAA==
X-Received: by 2002:a05:6512:6c7:b0:549:b0f3:439c with SMTP id 2adb3069b0e04-549c39122d7mr7333101e87.21.1742237651131;
        Mon, 17 Mar 2025 11:54:11 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:10 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v15 03/11] samples: rust: add Rust dma test sample driver
Date: Mon, 17 Mar 2025 20:52:10 +0200
Message-ID: <20250317185345.2608976-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple driver to excercise the basics of the Rust DMA
coherent allocator bindings.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 samples/rust/Kconfig     | 11 +++++
 samples/rust/Makefile    |  1 +
 samples/rust/rust_dma.rs | 97 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 samples/rust/rust_dma.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 3b6eae84b297..e2d14aa6beec 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -78,4 +78,15 @@ config SAMPLE_RUST_HOSTPROGS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_DMA
+	tristate "DMA Test Driver"
+	depends on PCI
+	help
+	  This option builds the Rust dma test driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called dma.
+
+	  If unsure, say N.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 0dbc6d90f1ef..1a9aff6e8d6a 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_DMA)		+= rust_dma.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
new file mode 100644
index 000000000000..1740140faba6
--- /dev/null
+++ b/samples/rust/rust_dma.rs
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust DMA api test (based on QEMU's `pci-testdev`).
+//!
+//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
+
+use kernel::{bindings, dma::CoherentAllocation, pci, prelude::*};
+
+struct DmaSampleDriver {
+    pdev: pci::Device,
+    ca: CoherentAllocation<MyStruct>,
+}
+
+const TEST_VALUES: [(u32, u32); 5] = [
+    (0xa, 0xb),
+    (0xc, 0xd),
+    (0xe, 0xf),
+    (0xab, 0xba),
+    (0xcd, 0xef),
+];
+
+struct MyStruct {
+    h: u32,
+    b: u32,
+}
+
+impl MyStruct {
+    fn new(h: u32, b: u32) -> Self {
+        Self { h, b }
+    }
+}
+// SAFETY: All bit patterns are acceptable values for `MyStruct`.
+unsafe impl kernel::transmute::AsBytes for MyStruct {}
+// SAFETY: Instances of `MyStruct` have no uninitialized portions.
+unsafe impl kernel::transmute::FromBytes for MyStruct {}
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    MODULE_PCI_TABLE,
+    <DmaSampleDriver as pci::Driver>::IdInfo,
+    [(
+        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        ()
+    )]
+);
+
+impl pci::Driver for DmaSampleDriver {
+    type IdInfo = ();
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
+
+        let ca: CoherentAllocation<MyStruct> =
+            CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+
+        || -> Result {
+            for (i, value) in TEST_VALUES.into_iter().enumerate() {
+                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
+            }
+
+            Ok(())
+        }()?;
+
+        let drvdata = KBox::new(
+            Self {
+                pdev: pdev.clone(),
+                ca,
+            },
+            GFP_KERNEL,
+        )?;
+
+        Ok(drvdata.into())
+    }
+}
+
+impl Drop for DmaSampleDriver {
+    fn drop(&mut self) {
+        dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
+
+        let _ = || -> Result {
+            for (i, value) in TEST_VALUES.into_iter().enumerate() {
+                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
+                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
+            }
+            Ok(())
+        }();
+    }
+}
+
+kernel::module_pci_driver! {
+    type: DmaSampleDriver,
+    name: "rust_dma",
+    author: "Abdiel Janulgue",
+    description: "Rust DMA test",
+    license: "GPL v2",
+}
-- 
2.43.0

