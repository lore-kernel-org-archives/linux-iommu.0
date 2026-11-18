Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794973261;
	b=pOnP2mzCnWXDY39BjvQ4OkeLiQywwwSOvJQlenN3s2gzN6Czmr9jck4BvmOX+GFnE4eU
	 hqjG0Ze+ULHfoDHmSMk0Zl4naEKFaE4ibsoV39m+4RRZTbXSvO9kQr33ayty6fsYuyjEn
	 xTZ/PQmvGx4krahHxa4DOUSLi+xCbYYEZMxV5ijkTRNP4NHKHDn2Od1eAh6YV5i8ZMVOq
	 3Ub4E0T1HXD/xEtMC+TQU4IREtF2eTAEhx4rkxpMcOAavo4eGRVOjBwwVo2lSVfdwg97z
	 bYnmOllX2d1LG6hy32bumkI+niO6YaKT3nj/6umLixKu5FzqExVDOflkWH/MfM2p4rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973261;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp;
	bh=gK5oI799Kz1LcEUaOW/mOdthpI3irhOwmjheiwtPG1s=;
	b=INK6/2kOjvXno5+cnd//Ti5aSvmadGc/cJkAEEQ2ekWZshwdIGNAl2HcQ6x6Heac2KUr
	 I4PEJ6YS+0JtWQXVDjgvtWRkXRzysqrYo97qxXWZpCmET5EvgxiwE0g94I3nSlM0OPnx8
	 byaaVKQf63e0jH4C4/orcyDYY+EMhcKgCFrLnqbYXgjS8xlktYhkQDpNUfKjkVhjPs2xg
	 7A5r+L/nMHO61bIiZkTxBu1iQbvAdrf42JwrLcVNWH96XAXqbziLIWnF2c35urO+ckw3V
	 Gjr0TgWcn8LYJJt+Z0cPO+YyyHdSEX+rtb3KbtpIvlHIxtE+wUfJ24qcDapoc0zoSSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DiuyTkmX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65F606A31C
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 03:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C65F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DiuyTkmX
ARC-Seal: i=1; a=rsa-sha256; t=1794973232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PLCpSpea4x3Fv/2NVljlVkxjca4XG5YWZoAOiCohQX4em1IYDAcn5WQxN8PwFdmhbnsB2XmB2T2idk1aiEVj2vN22ZNfcEVbY03WgwGai4Vm2HRJzcq5orIez243qu+1xYwVex4u3iZsDbifc32kHXnSPQXM7pE089kAz0EB4/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794973232; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gK5oI799Kz1LcEUaOW/mOdthpI3irhOwmjheiwtPG1s=; 
	b=QCA8qHMs+wT2+MZDN8XVUF3lDie1IKxpo8H+0yeyvJFWWaIzBtG25hx9ev3Y+/OTrQl/5LjfglaoW5NxGFisCigyqQLtpS5EtTLYpPuaTTrd4BgY8MdmjXAEkHI/lRQ0c+3wgqbmE0+FypPbFcxcekmQhtHwUIahXoqGpQ/GxS0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
	dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: a=rsa-sha256; b=DiuyTkmXReziehhTT97QdEz3z0Ay5HL2taygwOGhQ2ntwo1rDZ7n+T7wJys0AZqH0RpxLu3XhPNYYEZTGNNcmFlQj21LXe3AmR+vW0yva2JSCG/mSOI7CuJJoX0VfyhAB+T63K3tEhVPO8/LL++IRbSSP+YSoBT3Ny0i8f3ZMNI=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=gK5oI799Kz1LcEUaOW/mOdthpI3irhOwmjheiwtPG1s=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179497322883786.17035987788756;
	Tue, 17 Nov 2026 19:40:28 -0800 (PST)
Date: Tue, 17 Nov 2026 20:40:27 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 0/4] drm/tyr: fix partial 2MB block unmaps on GPUVM remap
Message-ID: <av0eKyWMqDWy1wHo@um790>
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.970.94

On Tue, Nov 17, 2026 at 07:32:17PM +0000, Alice Ryhl wrote:
> Tyr configures its ARM64 LPAE page tables with 4KB and 2MB block sizes,
> but arm-lpae rejects unmapping part of a 2MB block. As a result, a
> partial unmap or overlapping remap that splits a 2MB block in
> GpuVmData::sm_step_remap() fails in __arm_lpae_unmap().
> 
> This series ports the remap fix and supporting accessors from tyr-dev
> onto drm-rust-next, along with a defensive bounds check in pt_unmap():
> 
> 1. Add the GpuVa::data_ref() accessor.
> 2. Add the IoPageTable::iova_to_phys() accessor.
> 3. Expand sub-block unmaps in sm_step_remap() to 2MB boundaries when
>    the swept head/tail fragment is physically contiguous, widen the AS
>    lock over the expanded range, rebuild the surviving fragments, and
>    take the preallocated GPUVAs before mutating page tables.
> 4. Check the remaining-length subtraction in pt_unmap() against
>    underflow.

Thank you for this series. I tested it on my Rock5B with the latest Tyr ioctl
series [1] and I can no longer trigger the unmap WARNING
"Unmap of a partial large IOPTE is not allowed". 

So, for the whole series:
Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>

[1] https://lore.kernel.org/rust-for-linux/20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn/

> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Sami Tolvanen (4):
>       rust: drm/gpuvm: add GpuVa::data_ref accessor
>       rust: iommu: pgtable: add iova_to_phys
>       drm/tyr: vm: expand sub-block unmaps to 2MB boundaries on remap
>       drm/tyr: vm: check the remaining length in pt_unmap()
> 
>  drivers/gpu/drm/tyr/mmu.rs               |  13 +++
>  drivers/gpu/drm/tyr/mmu/address_space.rs |  29 ++++++
>  drivers/gpu/drm/tyr/vm.rs                | 152 ++++++++++++++++++++++++++++---
>  rust/kernel/drm/gpuvm/va.rs              |   6 ++
>  rust/kernel/iommu/pgtable.rs             |  23 +++++
>  5 files changed, 209 insertions(+), 14 deletions(-)
> ---
> base-commit: 8045d0e7d208ad389a387f1407ce0db9070805af
> change-id: 20261116-tyr-remap-2mb-7a53b8475cfc
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 
