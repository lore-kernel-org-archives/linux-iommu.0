Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12B263C75
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715397; cv=none; b=S/l/ENi6MbGmf0cEuR/6zoBIkYqRnQR6LnTKka1iS22xlmMeILSnEJk6zVtNyx69vVW+uechio/QIqFA3kLkyCRIBxZFuTysEiFsILrR+50D1y2Q1xCSExYBj+i8CuwxdS7ghPU9faPl2mcMuYfHtJKQTLSN6OVUNxB5Vm0j78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715397; c=relaxed/simple;
	bh=g2IUN8jCVllbF1ZiAJOX0NP0fmAmUk0/qWWI8VzUu7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sneDVswQwqEG46KbANzywvJIf5EWHt0N6Op7iE/6Nog5vLx54mARpLsSNXjIVSMaBxaNfAbuKhkFpwEVzS4IdMLknraLRFBpc8g4Km34a9FT3/+/CaN3H+sypLjA7zlsMGHlcQQXszSGwtI9Awqnq9DPg+5ZNBzElNjhwt/G64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgvtEq2m; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgvtEq2m"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so5948093e87.0
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715394; x=1742320194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4DDd/iic2hsiU29M8h+cyzkeUX9RCrQK1w4R9M79gk=;
        b=CgvtEq2m+Aaz1pxfWL9hhsj9bnHXrM1uUusUVO/71+cjUNkPuDMFrxmQUahR8S78FY
         MGTUHq8z0islZbhoeU59JO4mM94y4JTGy6mweqoR8Hi+CLnE+/+Z2tdwN0p8yZOZ6G1m
         jKoVd5OQf5JrJMxG1TPxgsx/ID97kloNWW2K1cbjbrYGAAmW5Epw7SaQstfBxQpSwhHE
         sPhLt1VuzXaokhHSgCVNWhmDirX5JBgnK5pDAMYA3cis/HyV/JvlSKJAO4cmReJ15ey/
         Zs2mpv5UBjokw7z1jH+XxhcUzTY4dW9fUYNS9awIkIXNJB4m64Uk8mLMcAWh5ljmIP7F
         ETIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715394; x=1742320194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4DDd/iic2hsiU29M8h+cyzkeUX9RCrQK1w4R9M79gk=;
        b=ALLZf8SLoKTKphaYCvmcJwSdCtdQbyCGmvFSOSdaswr28F73Dy1qwehA0yzuf/IzPS
         A2AUGNvvFJ07Djp2Zw6my4ENlHvM3ni31PNtts/tsAEgqr47cZ7KfwT44VenW0lJKzK+
         gUsRda7aGrEMhztDkRypSQSgTqKSz7/VVGIs3pFhuaYvEFNMJrsiZSJ+6quKt49loUoY
         V/nodj1zMCzogV/TsC3L88cd+xyEU4RFIRJ22S+CGHqxyhYDxBKrbHlNAhTv9xKWITXz
         /RlZiZaOJgYAVDJcTqXMPsJ3LCY0G8cXBMbNgAVpJ964hMZrAlL5t7aAupQjYf2wJsKF
         NBkw==
X-Forwarded-Encrypted: i=1; AJvYcCWzQYYGvxMaiR0I2VZz6ATsacZVA7ikq6b7V05XOwZtX66niBudvKJeORHtTtj16qh6CgB+eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZIJhgqByFNdVY25c9tToLejHjAY8nWN3JQiHwXDnq6Jhk2bwU
	F6pDmoOwfbXho8s0ynN9z0iR+j0+o6VtG05V11DvwEdea62nqIzL
X-Gm-Gg: ASbGncvIuYULwirOAb8Tv2c6I6Bn8VmD6KeOw8HG+9eWxpPMRo6L3Tq0nJ1yVd88MGT
	wmT8vvL6UIBlfksHaqrKnELBL3G53gDSFVB7l6VWJHCyEMwiv3t84mTfIM/kkjR7RTlTn2+iEYA
	p1Cyc4NW8hGHtZNybR+r9By1b34pCguAltG+lo53v6BMC6qzWebBExbmmdt8LnvIfcl8yRV24ho
	Ut8TDC4GLk0BPXvOhAdZmgwUQbTM1zMNuFsTvbNHvmYrx/dhONCJjFGBncYdOe/p6jZMI1hZ0LA
	Hn0sFrcXSQGioI3Tm4md3dVJNy/mon+QxChar69kBVO3yR1KC1XyW87xQVl4QRlzAo/LAK+ZLTI
	M7FFuhz8T+RmadmNGvrDdfQ==
X-Google-Smtp-Source: AGHT+IEK8bFyfeYyDu9u2ggRv4bnWCiWDFZdozZy4sv0fCHGsi/lf50Ck2X/Ydwr4axZ6CUhdcQvDg==
X-Received: by 2002:a05:6512:1116:b0:545:6fa:bf5f with SMTP id 2adb3069b0e04-549abaaaf60mr1682087e87.2.1741715393817;
        Tue, 11 Mar 2025 10:49:53 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:53 -0700 (PDT)
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
Subject: [PATCH v14 05/11] rust: dma: implement `dma::Device` trait
Date: Tue, 11 Mar 2025 19:48:01 +0200
Message-ID: <20250311174930.2348813-6-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

Add a trait that defines the DMA specific methods of devices.

The `dma::Device` trait should be implemented by (bus) device
representations, where the underlying bus potentially supports DMA, such
as `pci::Device` or `platform::Device`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 325b00fe7871..7ff797a7ad18 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -6,13 +6,20 @@
 
 use crate::{
     bindings, build_assert,
-    device::Device,
+    device,
     error::code::*,
     error::Result,
     transmute::{AsBytes, FromBytes},
     types::ARef,
 };
 
+/// Trait to be implemented by bus specific devices.
+///
+/// The [`Device`] trait should be implemented by bus specific device representations, where the
+/// underlying bus has potential support for DMA, such as [`crate::pci::Device`] or
+/// [crate::platform::Device].
+pub trait Device: AsRef<device::Device> {}
+
 /// Possible attributes associated with a DMA mapping.
 ///
 /// They can be combined with the operators `|`, `&`, and `!`.
@@ -130,7 +137,7 @@ pub mod attrs {
 // Hence, find a way to revoke the device resources of a `CoherentAllocation`, but not the
 // entire `CoherentAllocation` including the allocated memory itself.
 pub struct CoherentAllocation<T: AsBytes + FromBytes> {
-    dev: ARef<Device>,
+    dev: ARef<device::Device>,
     dma_handle: bindings::dma_addr_t,
     count: usize,
     cpu_addr: *mut T,
@@ -152,7 +159,7 @@ impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
     /// # Ok::<(), Error>(()) }
     /// ```
     pub fn alloc_attrs(
-        dev: &Device,
+        dev: &device::Device,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -194,7 +201,7 @@ pub fn alloc_attrs(
     /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
     /// `dma_attrs` is 0 by default.
     pub fn alloc_coherent(
-        dev: &Device,
+        dev: &device::Device,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<CoherentAllocation<T>> {
-- 
2.43.0

