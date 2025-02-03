Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219931FFC58
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738626121; cv=none; b=U6Y85dn/MtlIbX4EuBYagQrOmMf/+If+BHw6bej7c5G6g4xtBgjZe4zXsWGEEQbXvV8X7dHoxnbXDqRAMQRmorc+Rdg2k1BzZjRB/s71Fk3r7Ri7OatVRaxGeYodu1TTWKAgEgJIgNSWAHhYrcTDYgSyhqReEQtM9oRDXJFkgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738626121; c=relaxed/simple;
	bh=vpjt6yA4ON0H7iKkBTOAkWhIqBisVMTqr6VB0FVYmU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeNiw7+D6LV9eKH5T5Z6jFR2ekGFb78bO4PbPIz8C94OHmI4CJePdmhvEL/tb8hyC8HHtUF6u/cRBjbOgyYqWrDY6jD0JV5t4E2q7LbCtmSXxhIZ1rU9FYWYLuSOCg1K3tgHXjbAI9Qe93ww1Z2XMy/S28f5fhOL1iYMdxUzxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=su5SBZXO; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="su5SBZXO"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 732DA41F5F;
	Mon,  3 Feb 2025 23:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1738626116; bh=vpjt6yA4ON0H7iKkBTOAkWhIqBisVMTqr6VB0FVYmU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=su5SBZXOBgGB4ifft5WcVZYMqJXsRBS/hxMsYhf02OCjQKp3qjALdQdbhGC2yhrIi
	 FFvu7CSo5ULQm9NB8Wmw3XRNfMhWJ7Kfr4v/BmtL8jFBpgBT0ht9vBmwZtGg3Dxkjg
	 9MnwXO86xlP5b4jK8OqOKAST/PZ1rTyqfWApcuQhxpwxz3RC/3iNwwvDHoeicdCAl6
	 mRjHnUGIJ5vBXaFHYAPE1XfTgiqeTIU8oSCFBP0zZT0F1xlZQ4Y91Dei5xjvveZrrz
	 pamdPYTornlBLZGmJS8y3dhvWvxnYjn3xVujuu8of5okjLfvNMRb14t+D/Z625wB+F
	 IUKscptSkBYjw==
Message-ID: <d93db7ea-7ab4-49bd-b3bd-8055c62ff0cb@marcan.st>
Date: Tue, 4 Feb 2025 08:41:53 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
 Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com,
 aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <20250203191608.GX5556@nvidia.com>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <20250203191608.GX5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/02/04 4:16, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2025 at 03:46:14AM +0900, Hector Martin wrote:
>>
>> My 2c: If Linus doesn't pipe up with an authoritative answer to this
>> thread, Miguel and the other Rust folks should just merge this
>> series
> 
> Please don't hijack this side thread.
> 
> This is about Linus's policy for merging C code that breaks Rust
> builds. You should put this comment on the branch with Christoph's
> NAK.
> 

Sorry for the thread mishap. It's kind of hard to redirect to the other
branch now though...

- Hector

