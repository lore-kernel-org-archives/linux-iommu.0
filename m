Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA913B59B;
	Mon, 31 Mar 2025 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423391; cv=none; b=rCiCRK5/PufHWuTvxoUwUQW6IhbpgslCLVstIdnGx4cql/Hq7lcDiUULoqmFmU++OEhUKs2PmE2axh+guK+LjeFBVVHkH87uK/u6wNn+T11znqgPAp3jtUlU7dOzd7rtd7qoUwlILum3QXLUNG4kz5Tboz8LgthtF1ohKXhqLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423391; c=relaxed/simple;
	bh=zJTay3xAb5dtFcK3r4htx2NgCsJ3KI9zGjSE/+ix0Zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2Erv7nz1+/vlId3mXCqjV5w1KDEvVR4Tav0TeaOuj6q+4jnik20yFG7mPThtflX5bJ5DlXG39DEeLyNhVh83neK1uE+L2L8M/6oN44yWZcRzgkUmL3zUtPypbczvDb921VVYNEwS/5VSzJIt0MxRhbKWvyuGbBOx0Y/6AJUIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORACmZDY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORACmZDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31C7C4CEE5;
	Mon, 31 Mar 2025 12:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423390;
	bh=zJTay3xAb5dtFcK3r4htx2NgCsJ3KI9zGjSE/+ix0Zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ORACmZDYZ1RpkfMpjymgwj+rOhRBG5YPvulFGMjEOChUGSv9KjRCe/YMEL+5CZAb/
	 5nYCsJ1A2YSlpmOF155B96iLeabd4V9N5VzkF3uInMkhaJWDqH0ntzq059XER2lWvD
	 gHWMI4FQVTe2ilt6wO5kbtA5eIlLQ6V1ECkuFTqNDRgRXO5cPEUreRTyqtSUKr06Ek
	 Ss0Abed1BCpHXTfevQRuxWYFRTC6RzmCnRDx66kxE9yXXxN16z+2Emj+rWSwVfP90e
	 6BNNH26OQKYd3YS8vmDtRJizjxfGan6E7px+zIsHGGiBUHBw/q3FpJfUJeT54fXX0d
	 BH8P+NPhGsz/w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,  <ojeda@kernel.org>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Robin Murphy" <robin.murphy@arm.com>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]"
 <rust-for-linux@vger.kernel.org>,  "Marek Szyprowski"
 <m.szyprowski@samsung.com>,  "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>,  "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return
 Result
In-Reply-To: <f2c36d1e-cde0-420e-a19a-fda479d79572@gmail.com> (Abdiel
	Janulgue's message of "Fri, 28 Mar 2025 13:17:06 +0200")
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
	<20250326201230.3193329-3-abdiel.janulgue@gmail.com>
	<CANiq72mjGf1pBG7PM7fKJA_EZkphp5he2H9pvg1mxJYZb-WGxw@mail.gmail.com>
	<4ExNXCC9wJEcRnCycEYLmYcVESzw3nj4i9GT7hkHizBzV9GDwKSGyj13RAaU7Y4nYUR3oxQxwA6DjntsgwMQAA==@protonmail.internalid>
	<f2c36d1e-cde0-420e-a19a-fda479d79572@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 31 Mar 2025 14:16:20 +0200
Message-ID: <87y0wl4cq3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> On 26/03/2025 22:48, Miguel Ojeda wrote:
>> On Wed, Mar 26, 2025 at 9:13=E2=80=AFPM Abdiel Janulgue
>> <abdiel.janulgue@gmail.com> wrote:
>>>
>>> As suggested by Andreas Hindborg, we could do better here by
>>> having the macros return `Result`, so that we don't have to wrap
>>> these calls in a closure for validation which is confusing.
>>>
>>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>>
>> I would suggest:
>>
>> Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Link: https://lore.kernel.org/rust-for-linux/87h63qhz4q.fsf@kernel.org/
>>
>> Maybe also consider if Co-developed-by etc. makes sense since he
>> provided the diff.
>
> Thanks! Andreas, would you be okay if I add the Co-developed-by tag?

Yes, fine with me =F0=9F=91=8D


Best regards,
Andreas Hindborg



