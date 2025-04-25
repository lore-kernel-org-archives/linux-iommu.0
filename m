Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA922AE71
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566665; cv=none; b=P+TGV2Dt6sIMRwA0A+sgYEDYtWJy4a3ul1gKYArxMfYW59mGOYfK0EkHxryDuiQRe0/PX+OXfp0+kF3DjfFXzz1jNLhUMObJHXRZ2uHXKoST0+LOuvlkyRI+0PwFz9/Eh/9Wlm+FEfnE5VziFfQMmTl++wp541R24JzhBmv58Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566665; c=relaxed/simple;
	bh=WqzuZjN2OlAEP5U+WrT20wORev7uTKByfRxp1ekMkR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2aLLm/hFJzdV3fdhn6r8UEppdjOQokxg1KZ2OI4ePfgVmiee1H4gNDNh9ESLbCPGFKP9ZltDvEZIlDtRHTkveB/1GrKA0qK9dVMGluAB7/4oA4YbeKtpIT0iSNh/VRcqr2ySyE5o50i95mpWn/T3ypHVdlxxAzg38DmeWxpcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sas0sFms; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sas0sFms"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-310447fe59aso22687541fa.0
        for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 00:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745566661; x=1746171461; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4Cn3iGXk2B43PzN7CtJiYrgGpJ21xhd2OrhojDiLX8=;
        b=Sas0sFms0bhiQXa8cF8MNkyJIIJnMV24NwSqmLAoDOaC3DoVsLt+SofdVu+Sew0+55
         tDwg08XSPtOTqtVDJvHGoxokYqr9016+ceoalgfMsqUxIrHMI0mvPuFQ3CR1lbal6/g2
         BBAxPY4uGV+r0f/UX5T/Gpy4/OsdvKQYQCatDV4jRtlasdJL/90NFoNIbkNnG72N1IWk
         6uKcI+vbFNadaew7FtIgvcFJMFdQwTLUKU5KmQSFraaNrCoTdQsAW7VFBWFY3Py10H1Y
         btrdxIspk0Sbwc0vkRFklXYVBUXQgZlu+kKFMbIy+nvxwLrhcTClI0NON5pLmsk2l7j6
         4eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566661; x=1746171461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4Cn3iGXk2B43PzN7CtJiYrgGpJ21xhd2OrhojDiLX8=;
        b=OxjmhrMlVptWCAzKOP43c1NZVVCfOGzoPS75m7jIiM9DXUrDm4cG0vt8oF0uWGMdLf
         iSV8YQNSn8kedph7+OiDB2o7cerhOwZfyj/BqYXHKsHIcjodR/rd7MCSwD8A+SZVq/qr
         PV/wgm3Hi+6Z84raMJH4golH4/Kve9SCrXqaFtzKQ2Pkrtych4RXFZofYKEB0OdNTMwP
         XtQ8L2KnDv9DTV6lcAZpfZpFQ4jG8QLK5yvqNCifw2TZSSeh1ok1Elty2rzrZ6GiEHJW
         P694/uXPf4PuewAlSN+va/8mLF/5Py7DUV+ALSpXMdyxGgUA/FmjzNYgUxdq9hji1heX
         iwLw==
X-Forwarded-Encrypted: i=1; AJvYcCVUnzOElg52/ney53EDi57EATEAyKIr0yjC+psBDpHKJFn22He9LZ+qJ+7otDYTCH7kMVwxtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSKNxb28Ug5st8jJa2iTsTojWYh8avxOXkNoM6OJjYhNW03nTU
	pC9/NoANUWpyTYFPChZxslc8yy9OqxOEtCjfblHaWKV0bHALtyFS
X-Gm-Gg: ASbGncvsFMWQTleTrwd+vr7cKbZAZ0Ct7Fb5aTFjNQr+6jMcXfEfX0UiZpbOiQCiyRH
	ck8EWEKlHcYweR4TKIBSp3p7MRNxdsXVaKvoT2b9Js6y/+S2z5HVg0q2qMwOziQx+G02ZK5t9od
	T4crA/DWFRrOMneXVKLqqaQKD3WS+MQTydGv9W/HevbTiJJzno48C7BiuIAsad7/76UKTODJktE
	fWu+k1Fem5WIL8g4VH9DwgBuXsyTvA2cfLOOMvVPPkCsajgGrtntpLV2f/IKLdPVXBQmzQ10mPF
	E1+W14/F2zP8M7YrB9BMW+HhwyaQA2XZNqvAGR5yPlKN7g42tnaCL4XCGeA4Opc/XFA9HlEfxJj
	EGb4sl0USS9h+SMDdTMxMPMe1TO9s
X-Google-Smtp-Source: AGHT+IE2pq4NMC62iFfUfxNncOQ4QYZVoaBSclW1fBNBOsWB4SrRHwoy3yvkk2RaMxEl6RrMrQTP+Q==
X-Received: by 2002:a05:651c:3129:b0:30c:dbf:51a5 with SMTP id 38308e7fff4ca-319080e469emr3639321fa.35.1745566660941;
        Fri, 25 Apr 2025 00:37:40 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cc9e9a5sm504391e87.132.2025.04.25.00.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:37:40 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: dakr@kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 1/3] rust: dma: clarify wording and be consistent in `coherent` nomenclature
Date: Fri, 25 Apr 2025 10:35:40 +0300
Message-ID: <20250425073726.1027068-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425073726.1027068-1-abdiel.janulgue@gmail.com>
References: <20250425073726.1027068-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel, `consistent` and `coherent` are used interchangeably for the
region described in this api. Stick with `coherent` nomenclature
to show that dma_alloc_coherent() is being used, in addition to improving
the clarity in the DMA mapping attributes documentation.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8cdc76043ee7..d3f448868457 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -89,15 +89,15 @@ pub mod attrs {
     /// Forces contiguous allocation of the buffer in physical memory.
     pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs = Attrs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
 
-    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
+    /// Hints DMA-mapping subsystem that it's probably not worth the time to try
     /// to allocate memory to in a way that gives better TLB efficiency.
     pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs = Attrs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
 
-    /// This tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
+    /// Tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
     /// __GFP_NOWARN).
     pub const DMA_ATTR_NO_WARN: Attrs = Attrs(bindings::DMA_ATTR_NO_WARN);
 
-    /// Used to indicate that the buffer is fully accessible at an elevated privilege level (and
+    /// Indicates that the buffer is fully accessible at an elevated privilege level (and
     /// ideally inaccessible or at least read-only at lesser-privileged levels).
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
 }
@@ -105,7 +105,7 @@ pub mod attrs {
 /// An abstraction of the `dma_alloc_coherent` API.
 ///
 /// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
-/// large consistent DMA regions.
+/// large coherent DMA regions.
 ///
 /// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
 /// processor's virtual address space) and the device address which can be given to the device
@@ -115,7 +115,7 @@ pub mod attrs {
 /// # Invariants
 ///
 /// For the lifetime of an instance of [`CoherentAllocation`], the `cpu_addr` is a valid pointer
-/// to an allocated region of consistent memory and `dma_handle` is the DMA address base of
+/// to an allocated region of coherent memory and `dma_handle` is the DMA address base of
 /// the region.
 // TODO
 //
@@ -138,7 +138,7 @@ pub struct CoherentAllocation<T: AsBytes + FromBytes> {
 }
 
 impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
-    /// Allocates a region of `size_of::<T> * count` of consistent memory.
+    /// Allocates a region of `size_of::<T> * count` of coherent memory.
     ///
     /// # Examples
     ///
-- 
2.43.0

