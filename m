Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ACA1DF96B
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738237769; cv=none; b=ILFrrxdFoIM2dd91s1omvDWYCC1DDgBo484hq8QzrHt5woFEZ/OUILTLek/oN/RU59oStPQF0QsGLl18jCbevSfOxZ3T4yTkgNeRIU3iPa4bDuvwo/Zru9VaIh8tuMDX/mDIyAlom3eToGTW9iyUB1f5Q5ni/pfRtNHvmchytg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738237769; c=relaxed/simple;
	bh=Og/TG7a2UMrYoDQB89lzUGfNrdqnU1iZjXUjNOqO36k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QR16B8misBXyX3BZms2m9Sa+wjTNQB07RaoaCBjv0J4NUIh1PydxMxJIjV3uyphkdSpFUDQhq5DEcd825iHQioA66heex+zvy4jYOG7w19N6oQtKyXn1vVCBLVUYRs4+SzOC6NQQCeI+tfq9P3b6owEVsZlbdvZ+ZSNci8ztYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB7B497;
	Thu, 30 Jan 2025 03:49:50 -0800 (PST)
Received: from [10.57.36.50] (unknown [10.57.36.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4A6A3F694;
	Thu, 30 Jan 2025 03:49:17 -0800 (PST)
Message-ID: <4956d01e-2d06-4edd-813b-9da94b482069@arm.com>
Date: Thu, 30 Jan 2025 11:49:12 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/3] MAINTAINERS: add entry for Rust dma mapping
 helpers device driver API
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-4-abdiel.janulgue@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250123104333.1340512-4-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-23 10:42 am, Abdiel Janulgue wrote:
> Add an entry for the Rust dma mapping helpers abstractions.

Can't really speak for the Rust side of things, but I could be an 
additional reviewer to keep an eye on the DMA API angle if that would help.

Thanks,
Robin.

> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index baf0eeb9a355..4808c9880b3e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6822,6 +6822,16 @@ F:	include/linux/dma-mapping.h
>   F:	include/linux/swiotlb.h
>   F:	kernel/dma/
>   
> +DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
> +M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
> +M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Daniel Almeida <daniel.almeida@collabora.com>
> +L:	rust-for-linux@vger.kernel.org
> +S:	Supported
> +W:	https://rust-for-linux.com
> +T:	git https://github.com/Rust-for-Linux/linux.git rust-next
> +F:	rust/kernel/dma.rs
> +
>   DMA-BUF HEAPS FRAMEWORK
>   M:	Sumit Semwal <sumit.semwal@linaro.org>
>   R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>

