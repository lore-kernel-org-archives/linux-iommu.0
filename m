Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794944429;
	b=D6mrv0FES8FRl1EVFv3fuX+MrO2jMmMf1ls1xFPEk9TQjfe5GNTtcffNLal1a8DDPgzz
	 wlf7a2n6lnIsENw+sUlERN3Fsmj3rf2OcBB3uUZ/l2KwKQx0/BpZ8gO5vwitxwMEot1D9
	 6x7v4okFjicbxduRxXXd4+bYW6z/nulOAG8IuTQipUB3/upnnRfh27cUemXUdMeBKXuoY
	 q4ileH0XTrURCIIBy4seBNqHMXoMH2YDPA1shrVxs0jqZmoGbXbZL68eUH4sYqNvrSwcV
	 N1dOXKZ7i3bssKrM/F3aER9WAV/hHIYWVeHFgOgKoPnCDcR/J3faHhLcF3rRT40UNrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944429;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AOjEhOx7nc0rqRDX2rEwBPS9rvUhLYdv9/828tsqc4A=;
	b=swIFxx1l2l8DDys/U2Q/wC+mn/5OQSWjnxmx/1+CcKzjXncHrVosf4jGCMqIvdcl+paP
	 u9jHHhHf+FE+0NBbazM1fIzlXmzNpCAKTxahJ/WICwUpUMjyyUqkSm75Eas7qDmO/Efcp
	 fp257Pt9bCDgnk0MIhmyhveGF3syHqgJ10/WRZ+GzsluPGV7Ubxx5FlRdMZOr4qpVeGqS
	 8UJpEHJbYank/yt1YNA4KgCK0TPlMqn+V93TgyL79qThMj+nA+IekPcf3i66NdRbon4ay
	 Vk/rVIDLRucgpMqjfvw6FFHPIv5QR+qdF/aiQWWvWVu2vOJgjqqFk2bxwiAbXJrcH2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgobXJXD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355D606A31C
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgobXJXD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9288A1F000C5;
	Tue, 17 Nov 2026 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794944428;
	bh=AOjEhOx7nc0rqRDX2rEwBPS9rvUhLYdv9/828tsqc4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XgobXJXDvGckquiUVKsb+cx5MclCraCHmODQZG8jNKDb9Z0k+m0k4vlERWooOHi4q
	 VYCDqvnw84ga2DIAPk6Kb44khrHMUnRX6y1o1/9yUeH5go0+uz+ZNWrgxUPA9Wq1OS
	 BQw9Eb0EzVytLqhSUXTrJxVNfl5C8V4mqCXL0GP5vexRApHohru+og52aNL3b4mj7K
	 R69CX6AklKRaUpWhs6tA9lPdHp48sXte7bzc3c2SaCc0WZ6ssljAQBxTc67ewKSbe3
	 DtB9jrwGZqZ4zFLJORkPKRi0qrsGmCtEsKbMuSJLLEnhNhYYTH8V0Bjx/p94m2Q1yM
	 yIh6xFxPH0Icw==
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfauth.ams.internal (Postfix) with ESMTP id 14028198003A;
	Tue, 17 Nov 2026 14:40:26 -0500 (EST)
Received: from ams-frontend-01 ([10.64.2.36])
  by ams-compute-01.internal (MEProxy); Tue, 17 Nov 2026 14:40:26 -0500
X-ME-Sender: <xms:qa38ak2l1VHLI0YjrkJ7yIDHaDvb6Umqk-AwnQ6qP9O5XwK_ITDkUA>
    <xme:qa38aqGgUmX-I6UAQqiyENe6ODIrETKYqGMkaTBLRlaj9JxFLb6Mcdc6oC5IYf6B7
    yICAo17ni_HBEu7PSwbBi7NI842BSJM604T9beT-oXt3CGA4BjVqLs>
X-ME-Received: <xmr:qa38ajhds-GI7AczEaBnMFKXeNbpcm0Cha7a2R-6GxMvhQUVPTiAKJ1R2YDaRsvxvg>
X-ME-Proxy-Cause: dmFkZTFsrfDeQ92qWVnVmv/A03PGHmgqhc+/VThcWI16PXDaqJEpPWMO/+iSRVlTIUIgeQ
    4UN4PEubZ/GbB0VxltHySxCGYpIwIJZh7tBpboDS27htJYCHkFY3YAsMwqF/FLnrwW9vre
    N0gz4IpdKEL2lQvFBb5QWAXkT6xNCFM12Ly1YGRP3yX/LgNVblCS3bWyoyj+M3+6UUnf+q
    owuSwdxA34D1vsEHC6QWUkQfRBnjeDd7Rau67zBDB6mDV+TmbKaS1FOYh4RkGQaodea0uq
    m5oYNwq/9EX4gLzM8slcZoAqBg3WwBmWaldbXOJlysT7VKdK026GF1279mOECcDhhLsRha
    YVnYOwEeUM4byvgXMx867f+fgVn1vHF0lM7iaHyBf+CmUisddvhPVr5NvKih1gUR8JaTWx
    2o0wur1GMX3A7a1kTypFPmA5RXjGA2tf9r7abOpaD0ch6ZBDVYoWUdrvAWetftF8U6MzPs
    y/SvdVu5WXjqWho9f5xCNj44szlPlaM3AiCXJKsDpYhTg/SXROIaIA8F7hWAw5iBY0z6+9
    G0zhmyax4l9LBTbWN682qWUDdrA8FgjKY/MatvOQxZ+GgKFSfgV5SrSnmIcjlED/nMHHxB
    x6bMlQOmlbHK8XkZzXOYe2Nw/AG6eZartAdwZQs6o2TZJiaazinPTjm6++LQ
X-ME-Proxy: <xmx:qq38arcSCL55LZZUuCVmjZCcHKgtDJQ7muAlpws1s6fRphm2AFPbaw>
    <xmx:qq38ahyI5WwkKXNtf6Ny5yg-O3AWLZSco8OeSZBwjMorO9NkRmJVZQ>
    <xmx:qq38atZKdrBWMl7p-2XnFjz-9MT0E75JkgX9cDxUkcNCef8DVfXLPQ>
    <xmx:qq38anJtLCPY-GQJJ6JPkOTEggK8NfIW0IP4a673UU6eBt1I5CFwIg>
    <xmx:qq38as2gszjwSBCUBDRIqunl6sqkTQZ8KZZC_WlxbF6t_Ficb2agyuJs>
Feedback-ID: i78584a88:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 14:40:21 -0500 (EST)
Message-ID: <0d26baaa-92ae-43ff-9a76-a81cad624dcf@kernel.org>
Date: Tue, 17 Nov 2026 20:40:20 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rust: drm/gpuvm: add GpuVa::data_ref accessor
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Deborah Brouwer <deborah.brouwer@collabora.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
 <20261117-tyr-remap-2mb-v1-1-2a8efd4c8180@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20261117-tyr-remap-2mb-v1-1-2a8efd4c8180@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 8:32 PM, Alice Ryhl wrote:
> From: Sami Tolvanen <samitolvanen@google.com>
> 
> Tyr's VM_BIND remap path rebuilds page-table mappings for the fragments
> that survive a split, and those fragments must keep the protection flags
> of the original mapping. Add GpuVa::data_ref() so the remap step can
> read the VaData of an existing mapping.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> [aliceryhl: split into separate gpuvm and iommu commits]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

One question below, otherwise:

Acked-by: Danilo Krummrich <dakr@kernel.org>

> ---
>  rust/kernel/drm/gpuvm/va.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/rust/kernel/drm/gpuvm/va.rs b/rust/kernel/drm/gpuvm/va.rs
> index 46493f0ec5a6..f81302faba61 100644
> --- a/rust/kernel/drm/gpuvm/va.rs
> +++ b/rust/kernel/drm/gpuvm/va.rs
> @@ -87,6 +87,12 @@ pub fn obj(&self) -> &T::Object {
>          unsafe { <T::Object as IntoGEMObject>::from_raw((*self.as_raw()).gem.obj) }
>      }
>  
> +    /// Access the driver-private [`VaData`](DriverGpuVm::VaData) associated with this mapping.
> +    #[inline]
> +    pub fn data_ref(&self) -> &T::VaData {
> +        &self.data
> +    }
> +
Why data_ref() instead of just data() or a Deref impl?
