Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943956;
	b=ULMI40HtjcfVcR17yAdt9z66Z0diNVOtx/0HmMjmhjBal4QraURNQyKNtliIQ02G/1Xk
	 OAXk1wI49MF/eYzD4QuBnkwNYyv/1LIxHNWaSPA7DH0eaW+qnEynRMv088NcyUavBlVk5
	 hcbXC+mnHsGSM2r0RNlGs37qNHdiutIuRh0zvB3yrraSbjrJZVpkCGgnOM1Jp+R6VhusK
	 80bvbbR/y5Nl+1VGu2VvZtBko5ZC1h+AfKId3FCqkJJy3BsMmdMDZZ0H/TYx1xPECUVnQ
	 kMOBQ7fC2patvLG4imlFoQ9MpWZPB0nb+/NEa2TeEunSs2O1zJ2BkWNk46dcwUH+B8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=CWEIybWOyPQ+4rZV05KjYSAVt6nHfWxtoLBA9Fvcf20=;
	b=ae5TT7qkU9TH65ihPC2UsHd3LIBC/JhRz7qAJFw7Fc3v5LZtHavXeq/NOlp/JGFzctAj
	 B1UPWP6lj9wjeRh8mfsQ7EbL6a08J3CmXHtdaIEnfPsDI+m8lHAwPNxpBKMP5NcAAHkDg
	 /ShXftTn21z/H7nBKbRXxQJT1QzxYth0dtSwm6MxNaVOH4jcXVjjNIpRNQ310Zh0yjvkR
	 PaQx24+gB6KnFqEMMTkFzo+VEx9YP4vFF7E4yOKMYVQYzp9p66so/iLnN0aN8UQiavjsI
	 XXeQDpn8a6uyqzq8qKqRkTL9pL0WUOt7FElaec5Kz6BSiPhZuvQZkzIHN8QzxW1Vahg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=erC2qBuM;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE8606A33B
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DE8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=erC2qBuM
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4915ba023d4so73609f8f.0
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 11:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794943954; x=1795548754; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWEIybWOyPQ+4rZV05KjYSAVt6nHfWxtoLBA9Fvcf20=;
        b=erC2qBuMJ0ifQwdG7M4UBtJ/aL7qabygclQy5GVEy0N3zOcdSPlbZXWx7RxRF00bkg
         7VHxuYN8ZZnKJIrqduhjhunN8KTzzgHVcoL3pWENgme16CWlCpQp1l5+GPQ5xEy/wdQ6
         QTYPWz7w/hppOz5DP49+OzIIPKMkgWZ7l8qRQG/eyEv7VYl+Al83YnfLNF2Bajr9kIXH
         RxG8AxeojT5JL/jjy3Bm3AOTy00aJ7gpF1lZoTApLP0A0RK7uSZPn38/tETLQZ9v9ghq
         NrO/btQVpI/0ibxejt4+C5w5yh6pQ2ND8/hO9LuKFGw74yfTkjNLIoFRsvkcYHrcCdDC
         0lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943954; x=1795548754;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CWEIybWOyPQ+4rZV05KjYSAVt6nHfWxtoLBA9Fvcf20=;
        b=CGLOcMPhxMEmEt5BNYeFx5qICc9czqQPGlV9ZYfWRRl4JXbswT0wWaihKipox3YVUQ
         q6RVCaH+a/xk3VzCLTxtaJrkPUbRnS594cFHytYwP2NmfBSPvzL1JrLJvkzdlKzC2hKb
         js7lDJE1YlzarcngCje4gEkuPxIQxIDOoF+KJbkhnyxkcLU3syPnRjzVCCx78YyDdzwo
         ieU0wYTiU0AEVt6eMOjYDZZXaNV1DKy5TyiJOVf/Oq3WGeh0QOWvfgBeM74gI/dojLbW
         fcTAAoserllHF1vvPxJeMB0FgaDulrVAxm4UFi/8/k1AbCnzCWRQMSbbywFGQ1xp3vxi
         2T9Q==
X-Forwarded-Encrypted: i=1; AL+hErEAhDkAYoiM8unNaEp0ngvYxz5oUo3cLzbOoLSH34srP9Mxx4tOKIsPBsC7bdIkVfyeFxpHmA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8JYFxku9V9RGvgzOZcsHdISX9Oz5JYag9fGAMvgUvqR2ByCbyR
	FwPiP9Wtz1/YWGfUQ0FOu/vJjDYkwI6GROVWMWqRVMAJPPBtB3L1d20T9DlU1iCL52fIXKOStI3
	okJOpFx7Cbo/nT3B8TQ==
X-Received: from wrno8.prod.google.com ([2002:adf:eac8:0:b0:4a3:4620:1d69])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e193:0:b0:48e:4300:c6d8 with SMTP id ffacd0b85a97d-4a63de52730mr1008245f8f.35.1794943953550;
 Tue, 17 Nov 2026 11:32:33 -0800 (PST)
Date: Tue, 17 Nov 2026 19:32:17 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMKr/GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mz3ZLKIt2i1NzEAl2j3CRd80RT4yQLE3PT5LRkJaCegqLUtMwKsHn RsbW1AOkuzV5fAAAA
X-Change-Id: 20261116-tyr-remap-2mb-7a53b8475cfc
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=vSb8dcnD2eG8K9E1baNk0JXzV820WUHmszz9zfbL9p4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/KvIxRmUX8ES1X5aoMSyIxD/DGyKY46COBIZk
 l3WJbGYM6KJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCavyryAAKCRAEWL7uWMY5
 RlBYD/9LZxWa1EOICrXfCQo6+2FEaGCBTsGLsBCGNZt1aDkE705pnOcpv89yKcb61oL5jKTgTnW
 xpQGfS8/AHinHSIETT2reeDB4YrpfzKFFlHy+s5uCvqaMrDkS0xGr3eeSsaIDFJWASvdkEippTS
 96axYSKcL7IFwFLAmgcG6sX6tc0b5GG6YfPj75KMsMDqJ3kzAy4GDySRre+ze+MkIPI5rPoSdlC
 bDZ1yQZ+MrXVRxE2tuP33TmNT2izHdDsTxsdkPvzk7AGQ+oihOvv6lzCMkGxAhW+iBy91sIchkX
 /ewCL9ObYoq8wv3Fo0015JzMRoffi43yZVGOgl2jWFo/tAfMB0Q9JHTVRlIC6z2Mqwx6cGSbLJq
 2y2G/r950f+7EEb0Sk8FQDfRZbzval9lsEozVfD+HmJhsjPsowLG2Ts6hYCYggj1F6apuPx05oK
 bGAWMT2i3wIdIs47VBY+0nGf7hM4dTIQ8gTLYTtEEv3Uqup3mp+APnE3UgC20V73mFjgF+a+bd0
 ct/HDow4DEd8WlnxgPELic8aqxm7FxfePM7Mmc0Z9EsXXPs5ntYG4v696CXy794wL5Ab7FxxOSq
 vghzvQB8amoJ5I6nF85Ee23Zss/K18MPB4vI9M4+qLYN2grL4wfzZKk3nCZkI9DsMoWR6CGB/8j /nHigx3AoV+EAnA==
X-Mailer: b4 0.14.3
Message-ID: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
Subject: [PATCH 0/4] drm/tyr: fix partial 2MB block unmaps on GPUVM remap
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
	Deborah Brouwer <deborah.brouwer@collabora.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	"=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Tyr configures its ARM64 LPAE page tables with 4KB and 2MB block sizes,
but arm-lpae rejects unmapping part of a 2MB block. As a result, a
partial unmap or overlapping remap that splits a 2MB block in
GpuVmData::sm_step_remap() fails in __arm_lpae_unmap().

This series ports the remap fix and supporting accessors from tyr-dev
onto drm-rust-next, along with a defensive bounds check in pt_unmap():

1. Add the GpuVa::data_ref() accessor.
2. Add the IoPageTable::iova_to_phys() accessor.
3. Expand sub-block unmaps in sm_step_remap() to 2MB boundaries when
   the swept head/tail fragment is physically contiguous, widen the AS
   lock over the expanded range, rebuild the surviving fragments, and
   take the preallocated GPUVAs before mutating page tables.
4. Check the remaining-length subtraction in pt_unmap() against
   underflow.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Sami Tolvanen (4):
      rust: drm/gpuvm: add GpuVa::data_ref accessor
      rust: iommu: pgtable: add iova_to_phys
      drm/tyr: vm: expand sub-block unmaps to 2MB boundaries on remap
      drm/tyr: vm: check the remaining length in pt_unmap()

 drivers/gpu/drm/tyr/mmu.rs               |  13 +++
 drivers/gpu/drm/tyr/mmu/address_space.rs |  29 ++++++
 drivers/gpu/drm/tyr/vm.rs                | 152 ++++++++++++++++++++++++++++---
 rust/kernel/drm/gpuvm/va.rs              |   6 ++
 rust/kernel/iommu/pgtable.rs             |  23 +++++
 5 files changed, 209 insertions(+), 14 deletions(-)
---
base-commit: 8045d0e7d208ad389a387f1407ce0db9070805af
change-id: 20261116-tyr-remap-2mb-7a53b8475cfc

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

