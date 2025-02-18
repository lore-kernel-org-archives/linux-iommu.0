Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2212500A7
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882697; cv=none; b=C0ElD3ROcY2UqyfCkRi4/kdJegEJlVMb+Rcsilu59tSmzt0yb5ZMxfcBcLMNLQPphImuTV1PkHuVl0CKaz7ikoHYaZc2hdFJU1ApSVsNheW8xCoTrm+HY20o+rgruxUkpp8YuZMYUBNR4J3Mj4VGfccfJ87fZbTStm35U3fC5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882697; c=relaxed/simple;
	bh=SLEG1NMoLrdX1Aw1CSXmVF23VQoV4gcupTERGEEsR/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uD5SPhTFJr1rI1v9hlDiWT/x7TqhKgEBT/VUFfM+8yYMIfcfN9IVE/NAbg/laPaBDPMJYOOQDGIZ+jGb/a/FhWwskb8D28fSRD5FhWwTTzD+mjMegj2XwO/J7b3dX5GYVFD7xpRpbmdCNP267lsDz0aIEqMjPFqLdaUnuK/WaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62068152B;
	Tue, 18 Feb 2025 04:45:14 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E4BB3F59E;
	Tue, 18 Feb 2025 04:44:53 -0800 (PST)
Message-ID: <60701cf8-f00e-4f95-a89a-b1970775f868@arm.com>
Date: Tue, 18 Feb 2025 12:44:51 +0000
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
 <dd57c3ba-246e-414d-a9c1-eb2cff032d83@arm.com>
 <2b019479-2d32-433f-af78-c3378dee4e2b@gmail.com>
 <E4FEFE5F-77C4-4ADB-AEFA-2580CA75BCFD@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <E4FEFE5F-77C4-4ADB-AEFA-2580CA75BCFD@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/02/2025 12:19 pm, Daniel Almeida wrote:
> Hi Abdiel,
> 
>> On 18 Feb 2025, at 06:58, Abdiel Janulgue <abdiel.janulgue@gmail.com> wrote:
>>
>> Hi Robin,
>>
>> On 17/02/2025 15:52, Robin Murphy wrote:
>>> FWIW we've been wanting to steer away from relying on the default mask in new code, so it would be quite neat to actually enforce that allocations fail if dma_coherent_mask hasn't been explicitly set (assuming it's sufficiently cheap to keep a flag in the Device handle or something like that - it's not the end of the world if it isn't practical).
>>
>> I just had a quick look on how to possible approach this and indeed would refactor the Device binding a bit. If it is okay with you this could go in a follow-up patch? I was hoping to upstream the initial support first - at least with the dma_set_mask/dma_set_coherent_mask put in place already.
>>
>> Thanks!
>> /Abdiel
>>
> 
> FYI: I don’t mind a follow-up patch.

Agreed, as I say it's far from critical anyway - being able to make the 
correct dma_set_coherent_mask() call at all is the only thing we need 
for sure. I just see a slightly selfish opportunity here, that if the 
binding layer could make it impossible to call the API incorrectly then 
hopefully I should never have to review any of its users :D

Cheers,
Robin.
