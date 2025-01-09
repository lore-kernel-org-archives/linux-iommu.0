Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63274202C2F;
	Thu,  9 Jan 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412313; cv=none; b=FPtKgsF1hLl6FpOPxXaBtkLIkUoBbSnkhtpeOhkI6TV2ElMnSoB96TkJ4U3KDUSAKN3p4q2se4YQLEqVK7bb+VZ02uy5STgjoXQqn4W3TWfXiG4LTWRwpY5Xjr934rpEbKYbopOGYmoro9cS47Wzgc0p/o3fXBYBW7fM3RQ08z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412313; c=relaxed/simple;
	bh=Zg18fGBY5Wltr9dGWjEICu9TnaDU94PoiW5w1u3drXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UGYvU10COGYJFr14985P1lfVO1jL+QolWW6E6sejAqMZ6ev6MvFL8+cYvYkFV2rfx1yKMzF3dTCcmv11HdWK9+I8OpX2sVIC6d3FKDeZ4jOP8ZKjnYICepylq3E1AVF5j8LEBvaeyqZjlSYWff4hKlaRhVrra2Eor0VCvL6vj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgjVdO74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgjVdO74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7A0C4CED2;
	Thu,  9 Jan 2025 08:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736412312;
	bh=Zg18fGBY5Wltr9dGWjEICu9TnaDU94PoiW5w1u3drXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AgjVdO74LhG46SNJEyhB+cTZJJc5iRlkif/n1yf6IE54cPvZhEOrPFReegHSpklDB
	 klIzQ+F/JDnrzhCjtx3TbLA5TwhXFLqg8JeKN+dm7AZhD+1GhbKWvmjEkl/kdYnFII
	 Jb5noKfyJMH216yoxPidnHz8G9AaF/q05rI7QHg4Zo48UjJzsLzYe1zoYAmXV78jSM
	 ch45IYA+cSBauV4Q/YI/LgUrJ8hSDr3Z3DgrWoZ5oFbHA5pNq+FoF5uK7HLfeHkNLY
	 qcFI2N3qjdlX5T0J1yw7ZKnYpPRgq9W8ldgaM17JQPCjbGqIp5nyXv/M4Bqwr2tytG
	 z8Dz213tKBRnA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Valentin Obst"
 <kernel@valentinobst.de>,  "open list" <linux-kernel@vger.kernel.org>,
  "Christoph Hellwig" <hch@lst.de>,  "Marek Szyprowski"
 <m.szyprowski@samsung.com>,  "Robin Murphy" <robin.murphy@arm.com>,
  <airlied@redhat.com>,  "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
In-Reply-To: <0af017a8-8796-4552-aa16-bf2735f7b4ac@gmail.com> (Abdiel
	Janulgue's message of "Wed, 08 Jan 2025 14:26:34 +0200")
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
	<20241210221603.3174929-3-abdiel.janulgue@gmail.com>
	<7c8e84e7-a212-445f-bc4e-ef65dae7fb29@gmail.com> <87ikrflxxg.fsf@kernel.org>
	<0k_1eHyF09_Hn4WLvlbzmaIbGTLmT4STzPGaVtiCja_UJzRdnjaIjtpneL9ebBObsdpzYRuFOJEdvGKr_v8GLA==@protonmail.internalid>
	<0af017a8-8796-4552-aa16-bf2735f7b4ac@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 09 Jan 2025 09:44:57 +0100
Message-ID: <87seps9y0m.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Hi Andreas,
>
> On 19/12/2024 13:22, Andreas Hindborg wrote:
>> If you include the `Allocator` trait and the `Pool` it would make my
>> life a lot easier when rebasing nvme. For now I'm just going to use out
>> of tree patches that include the dma pool.
>>
>> If you do not have a user for dma pool, maybe just include the
>> `Allocator` trait and indicate that it is there to support other dma
>> allocators in the future?
>>
>>
>
> Would it be okay with you to have the basic functionality merged first?
> Once this is done, I will send up a follow-up patch that would then
> include the allocator trait and the pool.

Later is better than never :)


Best regards,
Andreas Hindborg


