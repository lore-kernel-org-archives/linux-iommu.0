Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C91F5832
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237657; cv=none; b=U6XreCcMwV4fjtwEwPIn1oU+E4rtWOZ31t0NtF1Gmihq/9f2yfEt+35MMu5bQvBmpSf46TJ75YTRJM3VI+wXvNXng1DZujVhTyjDGWm8Wm1oteYSvfS85sX4E2cHLukKbq8Sy0ZpP3BpIgBU0qXSbsHr1LVBCjZIkQD5yFSmMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237657; c=relaxed/simple;
	bh=O6iH5uaB2vnuCo3stdhQI+RIzmVOwagXzOMXjOYTBuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BY7HgO3zzb6gGhnG5Qp/UdnFkMant8OKBcRiSec0GwGXK7h8RmDKLus8CywstamyryBNhrQI2mBOLGtprWArTSSR2CNcF/GLx1sCU4kBlOAnvX2/TUuJLRvW85KvxMcAUdsfhhhf2PqYo1qR9rnUPlW3mtMFvqHTzZmNqkYXQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr+ycfE3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr+ycfE3"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54943bb8006so4431157e87.0
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237654; x=1742842454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQtPQvh7AOfNGyyJYgAlzNOC+RTx4D234UEnDx6A0Kg=;
        b=Dr+ycfE3m43uTzG8YPZpjKXop3DNS6XjXpuP64IdsFz1Wz/UyfZoPQdlf8DxsfmBAZ
         f9Yow68Q8Ff3V+pcy0rnM0gZv8xkZurYEkjQwKTpqgp+RxMeut7HjtvGaW8QXwWjcGHw
         YHvH2MEfY1T+7MPozG4uQtc6i4MRXaruhkNkHaBZUrVB1Nsz/GZOxnX8ZAb2JDy5HqpP
         B6/u/SyzSnwQECI/hHJFUbjFjVejVh6WEgKKPRzeEDF/6SUlI4gKmqzKDYXqdixAfslv
         rRAZLvyOmdKYn8Otr6nAlBuViQLvmRO11+bNlHWJABK5JtppAfSXaXIrSOfxtIdZTNzc
         Segw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237654; x=1742842454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQtPQvh7AOfNGyyJYgAlzNOC+RTx4D234UEnDx6A0Kg=;
        b=V9dsgozakKPvDo2OGatdnfYENFL8ET/d77fv3LAUAuGTSjEq0AgyiuoPKm62S5/Eqm
         Ikpygz6CI4eTgEA/t4XsnelnJDTxjf20Lr3CE1Ge/VlR+MepG44+ZvYLXZaLYEnTfwL3
         AL0d5kV5w6LdGe4HPKfOINhg0mF8u36Tm1dT/AMPc5xNXfRP/7UkYFkuP814dlGdQlws
         53qdU1NMiFgLXFjUehXpoWAdHH3s6d32Lbk0NzWovy4Q/2UDHj89aGjaXrM7KTPAetp6
         xLpPJ+pEqtgulenOZKzsWWCyO5x8ddy/bpbdjxL1qLYJ03UqQToIVQ5Hn5jLNdlAHfJK
         JAkg==
X-Forwarded-Encrypted: i=1; AJvYcCWwcMF4wfEo6XB+uVFcJot8+g7+5u9ml7jgk0gUMNOVYEgRPWn+3xkI7PBWgBlrlNim9u86Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJXy8QoTlYIMxff1VmyOXLzsivJnokmawkJE+mzezToebQ7ZZQ
	HQoVRFRFH0WuFZOpYDKti1X6A8bPbm2TGMB2ED1AUNIz/xv5IKr7
X-Gm-Gg: ASbGncuf7VI+j3ttD1NxRfw62jgHJQVu0kP86dRx92RPKyEk05NHu67gGR8m04gR6b2
	T/mKzDKPNgPcWmMsJ1tjkSA6VcUonRBNqlvbPz0FfYNxy3ir8k5hDmrjT8kX41HEj+PjPQ3hr0u
	/Z9JhqgyRh8ceme3FHo3hWCPTOtxrbXZKkj28ysfbZsOAuroZzMTW8HtzIcU4LZP6vwkHPfQ/R5
	g4wx7V1eqZ3bvlhlwTN5AMZt8mglPY260Tci+v0IlcNDshLygmRu0DX/U8uB29udijKDZkkJFXu
	jTZhyjZEg/ZVR6Pxx8luxEVqdKDbvjG7SyLQ1dtMBd/NjSn8fw2MbizC1RaU9lnKvvY117LjrHE
	mFhpsumRMZlM1227VNDiVAg==
X-Google-Smtp-Source: AGHT+IGT6zkWZzSsnWuUG/nW7dwX9DryRKc+ef3WR8hQSZbEMG3129wtNF8We2swDm+RCLx4OFZ36g==
X-Received: by 2002:a05:6512:acb:b0:545:2950:5360 with SMTP id 2adb3069b0e04-549c38f5ee2mr7499944e87.22.1742237654055;
        Mon, 17 Mar 2025 11:54:14 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:12 -0700 (PDT)
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
Subject: [PATCH v15 05/11] rust: dma: implement `dma::Device` trait
Date: Mon, 17 Mar 2025 20:52:12 +0200
Message-ID: <20250317185345.2608976-6-abdiel.janulgue@gmail.com>
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
index 9d00f9c49f47..834d00c1347e 100644
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

