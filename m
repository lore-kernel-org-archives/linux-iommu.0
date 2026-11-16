Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794866084;
	b=pUupQk4eaADxKadwOyaH+mhwlMUBmBSnl4Ptd+Xuavr961/kKI5rK+HxdU0UddZmTxsP
	 /NevPKmJs/vi5l1adKlK77Pm1Jz8hBxKQuIZFdQCMm5S3mc9A7Tnsvq3VpYlhUulMH+1U
	 26Qlttwd9WmtFLNn5Jg7rSOQCG23oRNKC7OqimsULDgIkaFjRz/W3Db1jsxqLcdQOTblO
	 SHUxX5RTl0YZV/A2d2K0TYoeiAFywSGZ39FFtsXCwvgxfNa6kWqtjOO2szhEOv1Gwg+BG
	 /2BJcjMhcEax4RElQLeJgx/K5JvBo1uyAhQgKwVaEDTh5JcYTMcogYOghAmwgzYSs1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866084;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ZohoMailClient;
	bh=dfvy7wSiuAwFa7w0F1KM93+WCu7GdYO/v/QrAqXAXtA=;
	b=o01qyNLs+DWdOuWWTyDqDOmyWalHdaJu2OF3E864UHK/MoCL7qMS7VA45A9/dmezM92v
	 WIF1Y/IHGZ4hrzIfjcWkbVKxnkNUBP98f5xvh2S5i7TKCEvs6cUmgWql3xfHJBj1DDgir
	 5bI6XxPkGp8wChupbTzbAdSNdBM/sqVXfvb7yHLBpwGnjyUR/KXo5iZf8kNi5gwbTaAtj
	 dYck8/2UlFOHkkY6R+rWg1mcOleLiKXi24XWPkL3XfXE+K4ycPTl+r1dpRRBcA5XkDQQu
	 bSSE32GpO56SCOqlTpuA0qhBgTizoHL4joYWzZrixfQBUxLVlEEBFeYwy4Z4WDDPRmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=XfKSKxnh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07185606A31C;
	Mon, 16 Nov 2026 21:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07185606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=XfKSKxnh
ARC-Seal: i=1; a=rsa-sha256; t=1794866077; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WYpb/ZRvGP05Bq0/3L9kgmxuOTUvUuOdguZvow4yvH/Kgo0kWWwWl2kdI9MPLJifKhpGJfU1m6sZiO/561vuuoNmyTx03j24RbCBbH35YjktzgUsECRHtoYWM0KF51gtGJ0gJHUgu56LMK8a+5dH7/D0DbL+ZwScz53/0WPDdjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794866077; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dfvy7wSiuAwFa7w0F1KM93+WCu7GdYO/v/QrAqXAXtA=; 
	b=DrUilEdI2C516cDoikg2fomPfsm5yTm4mIobJERlTt6FfGncAGrW7AuiZEiP7IxDxOvKk/dEQ/dhTMJNKj8jg+DCiC5uGt/0EYH3R9/1mKn1i5dwV+pV6dHIBNspxSHY3z36BZ38dt0VZaMORxqeYNq3RoYg4Z+ZHg/YpJBsVOM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: a=rsa-sha256; b=XfKSKxnhJiPi6lAbogYeZjGrelM6+M7Vgo5t49NXpgOas9kuAONHjhkXKaseJA+MzVenSFir5JkAXVYskI4c2fPL+Ex3rIIbIW/6Wzg3ihQJ/36RZRkqtkQmQUkcxNKBZCtYYh3jQO3BIZfoPAp31El5nzEbvzX3jJi/PEsqXKM=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=dfvy7wSiuAwFa7w0F1KM93+WCu7GdYO/v/QrAqXAXtA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794866075582154.15241391048926;
	Mon, 16 Nov 2026 13:54:35 -0800 (PST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: iommu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
Date: Mon, 16 Nov 2026 16:54:32 -0500
Message-ID: <iSL9q6tCTCC93Iglr5SH1w@collabora.com>
In-Reply-To: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi !
On Thursday, 12 November 2026 12:00:07 EST Daniel Almeida wrote:
> This series adds a Rust abstraction for IOMMU paging domains. A driver
> can allocate a domain, attach it to its device, map pages into it, and
> install a handler for its faults.

Note that a domain is not attached to a device, but rather a device is 
attached to a domain.

Small difference but it influences how domains are applied to devices and what 
happens when a devices is detached from its domain.

A device must always be attached to a domain, so when the device is detached 
from a domain, it will be reattached to its default domain.

IIRC, you cannot detach the default domain (it returns an error).

Of course this doesn't prevent us to use domains for the encoder the core we 
want to use can be attached to the client-specific domain before starting a 
job. When idle, it goes back to its default domain (most likely empty).

I also belive the patchset still works, but I'll have a deeper look into 
Attachment and some rewording might be necessary to avoid being misleading.

Detlev.

> This will be used by the upcoming rkvenc driver that my colleagues
> Detlev Casanova, Nicolas Dufresne and I are working on. More details on
> this driver can be found by watching Nicolas Dufresne's talk at LPC 2026
> [0].
> 
> As part of the security model, each client will have its own IOMMU
> domain. This is needed as the submission model will let userspace set
> most of the encoder's registers directly, so the kernel cannot check
> every memory access that a job makes the encoder do. With a single
> domain, one client could make the encoder read or write the memory of
> another client.
> 
> With a domain per client, the encoder can only reach the memory of the
> client whose job it is running, and any other access faults. The fault
> handler added in patch 6 lets the driver identify the faulting client
> and terminate its session.
> 
> Patches 1 and 2 prepare for Domain::map(). Patch 1 moves the protection
> flags from the io-pgtable module to kernel::iommu, and patch 2 makes
> SGTable::as_raw() visible to the crate.
> 
> Patch 3 adds Domain, a paging domain that is allocated for a bound
> device and freed on drop. Domain::new() is unsafe: the caller must
> ensure that the IOMMU driver behind its device sets a domain up fully
> when it is allocated and allows concurrent use of it.
> 
> Patch 4 adds Domain::attach(), which returns an Attachment that
> detaches the domain on drop. Devices that share their IOMMU group with
> other devices are not supported.
> 
> Patch 5 adds Domain::map(), which maps pages at an IOVA chosen by the
> caller and returns a Mapping that unmaps them on drop. The pages come
> from a MapSource, initially a boxed SGTable that owns its pages.
> 
> Patch 6 adds Domain::with_fault_handler(), which allocates a domain
> with a FaultHandler installed. One handler can serve several domains.
> 
> This is based on v7.4-rc1.
> 
> [0]: https://www.youtube.com/watch?v=75E15eHY7ac
> 
> ---
> Daniel Almeida (6):
>       rust: iommu: move the protection flags to the module root
>       rust: scatterlist: make SGTable::as_raw() visible to the crate
>       rust: iommu: add the paging domain abstraction
>       rust: iommu: add Domain::attach()
>       rust: iommu: add Domain::map()
>       rust: iommu: add Domain::with_fault_handler()
> 
>  rust/kernel/iommu/domain.rs  | 425
> +++++++++++++++++++++++++++++++++++++++++++ rust/kernel/iommu/mod.rs     | 
> 18 ++
>  rust/kernel/iommu/pgtable.rs |  16 +-
>  rust/kernel/scatterlist.rs   |   3 +-
>  4 files changed, 446 insertions(+), 16 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261111-b4-iommu-domain-f46a6e450c0d
> 
> Best regards,
> --
> Daniel Almeida <daniel.almeida@collabora.com>




