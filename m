Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129611EA73
	for <iommu@lists.linux.dev>; Mon, 17 Feb 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800378; cv=none; b=ElCOqNQuwsLy801f4LfRHpJ+prUC417geMOxABCRdnPuYM3yoEXcFIYA1iN4wry8oNsh0kIQqtumnt6pyNiUsV+q0KV0VXZt+Ngxux//o9492rdYFKVnVfypqlXNHToSypexDjvEJB2P94x5e1fLPkFaqKvbzxFEMxY7cZKtNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800378; c=relaxed/simple;
	bh=sdCmF9l7bbBamYYK1Iuac7leIv7bdMqi54XYNTep3vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ah5SZ4crHzkaockuNtGuL01xxdS8RYpNFy2O/ohTL1Y0RO41UIm977UfVS7pEKOmkKRMSFGCRjmB18k+UAF/cylYBxZpo9hqE6mx0ULLYbzAKe7GaFgtdmY6FTsGHYXaTGlGuk1lzL6bKlqU9X0FAKchgSU+vLa5QmewjknXe5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8114313D5;
	Mon, 17 Feb 2025 05:53:15 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 873683F6A8;
	Mon, 17 Feb 2025 05:52:53 -0800 (PST)
Message-ID: <dd57c3ba-246e-414d-a9c1-eb2cff032d83@arm.com>
Date: Mon, 17 Feb 2025 13:52:46 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <633274AD-E55C-4A90-AB72-33D3E176176F@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <633274AD-E55C-4A90-AB72-33D3E176176F@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/02/2025 9:40 pm, Daniel Almeida wrote:
> Hi Abdiel
> 
> I noticed that there’s no API to call `dma_set_mask/dma_set_coherent_mask`.
> 
> This should probably be included, i.e.:
> 
> ```
> By default, the kernel assumes that your device can address 32-bits of DMA addressing.
> For a 64-bit capable device, this needs to be increased, and for a device with limitations,
> it needs to be decreased.
> ```

Oh, good point (and I'm rather ashamed I missed that!)

FWIW we've been wanting to steer away from relying on the default mask 
in new code, so it would be quite neat to actually enforce that 
allocations fail if dma_coherent_mask hasn't been explicitly set 
(assuming it's sufficiently cheap to keep a flag in the Device handle or 
something like that - it's not the end of the world if it isn't practical).

Thanks,
Robin.
