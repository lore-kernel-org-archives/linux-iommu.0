Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181FC29E11B
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834859; cv=none; b=o1raXEAWs4sSb9b6qf7O1SXw2eaQqZfLq2hz7VpnatpuIpFup74g+NasgbJLxZiQvOzoRjzYr1AEyrN8cdHQRS+V3QqNoHEeJvYP/8oGNb9VXJpc+5aKe0XCBvAZlJPHd61iW9i9Ukqc11sk4fvNakw88BhUCYMAyAcnGKOf3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834859; c=relaxed/simple;
	bh=4UCl6FS57UCFT/s/Aivc682IiT93h/tyVCbhlXGRimA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNZZP4DoD6kqDD96aXvpzJefsfPWeFqsUwJSxRuAEHhrkbOM4lnZ4AvIDqHrZOknBHWs3oOvQ9+5Rf+wF+myeSB1YLIuS3AwOT9L5tIg3pO/1tao41E5884LufiYJ3F5T8pFx02yEFJ+5JhFY439JSQAqE6BI6uOKkCZSZ4NUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvmLylpQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvmLylpQ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55622414cf4so1711129e87.3
        for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752834856; x=1753439656; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzlFHqVKjDIXq/LtuH9Hs9lvB/GYoPKi83M+H3+XBI8=;
        b=dvmLylpQg68orYI5mq0vQZaYrTQWZ85ANt8LihhsnKyqWtC/+rRgQFePmtezgw61d/
         VMnJjImd5K7NNhSNGv6/+StHA1CwKs6+0n3fsDfkis3BMOVygfzepZWzHl0QAdweTadD
         IM+EAe4TlLPfGvLzxoGHn6uUbavVrf2836D3oawz+xRC5HxLQabW+21AXL1zU0XuCApo
         OPnkd8ojofH/92AfACnPuMar02lEVfBeS7vexlem3pOwWX0IWlpAGMA6fVoGk3IOCBuD
         Pu53M13Wdrw11nfYVVN+2JGMirwHH3Xj4HFiaIUFBPLRP4sMYbmhoFG8qeHTYc/4V274
         XfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834856; x=1753439656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzlFHqVKjDIXq/LtuH9Hs9lvB/GYoPKi83M+H3+XBI8=;
        b=xKlRTWXYqQntrAzLBRdncfdzX4kSkW9oiFdozld+S6TO+Yw2YcZWU0ybwzGZmSu3Gw
         JPdVxgONYSTCPJqHDtuPkcr0MplOCdD45ZgRJMpWBXHBTkLh8WawVOlwbMva0V64Txuk
         H51zP//itMSA5w+zskKYk7SPdro8gPMolEFyoEcJEE4yy4CKkCKi4TvivdDhGnp0F4Zp
         UA7h5qQLbt16gZqEVkgiO55+xKUhACTQ7UVb2pdMjohiG7IPWpc+ZJQMEtOG1/LRR5BQ
         iaVNSBJnQvmYEoh0vAFfqt857FylD16bbLtTkaGoBFhpipALhql2FvuwnX15cAk03duI
         oDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRswwDvwz/fEa8g4HzDyfGNMSz7dsabEe+mIC8CDVrkoTz8SmQVC9heij4pseTk1qU2YePZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfPJEPfN465nrgEsp7w0VgRBP/G1TztcYcAaUwKfn0R6uwturx
	KP5038fuKlKbGyF1zGD9gjNdMeU94misibDVBn9eJlP0+pGQvM6VYfxR
X-Gm-Gg: ASbGnctHHDVia5qMLbuHvocJLi6BQnMjhbA/QAPV4QGDrnwW1eS9eNwiYrg08C+73Kb
	H0N4UeIH3u+hJbynFQRPtjSa7OdQNRgnQGP5thIu0hrIuUimufMIgEWxBqougykZ4OqDNzgJ6s4
	bDcn7Hwi2F02FjbknD188yUpYkRXM14aU124vRXejp4Kcrx5UnyKVyGDxjpZ9RgCJb4ceqqnLH5
	T30oR8+wpUTwMbRu9LYsvmvyyCAOMVHhKahVXRgd+oHOVM0B5MTJ8Jcxf386oH1typkbKRKznX3
	VQdLHCEh2nBdJiYjWdzKkxjaYdN9cLDXweUxTrRQPC8nDSdi1YkyERbxdU0pxSHuZ12LOajzKDi
	r01rR+Cil3LvD/IK+Ht5AdmBJTe3aOYnYKWkzVcMy9ovQNn6cSGjGdzY5OygC998uQt6AiukGjT
	s=
X-Google-Smtp-Source: AGHT+IETkfeWsfkDgGn5zaFSkRgty7i8AaeFUMfqlETXa8lb3zxyT+iSPj59nmDtalUMWW0luET1Xw==
X-Received: by 2002:a05:6512:39d5:b0:553:d702:960c with SMTP id 2adb3069b0e04-55a318aee3cmr550121e87.56.1752834855813;
        Fri, 18 Jul 2025 03:34:15 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d9176bsm203689e87.161.2025.07.18.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:34:14 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org,
	jgg@ziepe.ca,
	lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	rust-for-linux@vger.kernel.org,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 2/2] samples: rust: add sample code for scatterlist abstraction
Date: Fri, 18 Jul 2025 13:33:35 +0300
Message-ID: <20250718103359.1026240-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple excercises to test the scatterlist abstraction.

Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 samples/rust/rust_dma.rs | 49 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9e05d5c0cdae..1fa278e8e29a 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,11 +4,33 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, types::ARef};
+use kernel::{
+    bindings, device::Core, dma::CoherentAllocation, page::*, pci, prelude::*, scatterlist::*,
+    sync::Arc, types::ARef,
+};
 
 struct DmaSampleDriver {
     pdev: ARef<pci::Device>,
     ca: CoherentAllocation<MyStruct>,
+    _sgt: SGTable<OwnedSgt<PagesArray>, ManagedMapping>,
+}
+
+struct PagesArray(KVec<Page>);
+impl SGTablePages for PagesArray {
+    fn iter<'a>(&'a self) -> impl Iterator<Item = (&'a Page, usize, usize)> {
+        self.0.iter().map(|page| (page, kernel::page::PAGE_SIZE, 0))
+    }
+
+    fn entries(&self) -> usize {
+        self.0.len()
+    }
+}
+
+struct WrappedArc(Arc<kernel::bindings::sg_table>);
+impl core::borrow::Borrow<kernel::bindings::sg_table> for WrappedArc {
+    fn borrow(&self) -> &kernel::bindings::sg_table {
+        &self.0
+    }
 }
 
 const TEST_VALUES: [(u32, u32); 5] = [
@@ -58,10 +80,35 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
             kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
         }
 
+        let mut pages = KVec::new();
+        for _ in TEST_VALUES.into_iter() {
+            let _ = pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
+        }
+
+        // Let's pretend this is valid...
+        // SAFETY: `sg_table` is not a reference.
+        let sg_table: bindings::sg_table = unsafe { core::mem::zeroed() };
+
+        // `borrowed_sgt` cannot outlive `sg_table`.
+        // SAFETY: From above, we assume that `sg_table` is initialized and valid.
+        let _borrowed_sgt = unsafe { SGTable::new_unmapped(&sg_table) };
+
+        let sg_table = WrappedArc(Arc::new(sg_table, GFP_KERNEL)?);
+        // `refcounted_sgt` keeps a refcounted reference to the `sg_table` and is thus not
+        // tied by a compile-time lifetime.
+        // SAFETY: From above, we assume that `sg_table` is initialized and valid.
+        let _refcounted_sgt = unsafe { SGTable::new_unmapped(sg_table) };
+
+        // `owned_sgt` carries and owns the data it represents.
+        let owned_sgt = SGTable::new_owned(PagesArray(pages), GFP_KERNEL)?;
+        let sgt = owned_sgt.dma_map(pdev.as_ref(), kernel::dma::DmaDataDirection::DmaToDevice)?;
+
         let drvdata = KBox::new(
             Self {
                 pdev: pdev.into(),
                 ca,
+                // excercise the destructor
+                _sgt: sgt,
             },
             GFP_KERNEL,
         )?;
-- 
2.43.0

