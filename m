Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F141E0E15;
	Fri, 21 Mar 2025 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742540185; cv=none; b=AdaIGnAc2PonzlV93hdrrpVe0++GmeGxUvN1jLTEh3hViLaCaSSU8juodhlLTk5UE2DXMJfpoTnEhbE293ZW7pCCZaBx9IeHxwrS3RQexWQ6WXMz/YprKBchONtJcS63JaOOSGc4AR+xP/f5jsSITl+MKk5FISbbN7aDm/yDTEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742540185; c=relaxed/simple;
	bh=HKi5VTkLFjJWETNHJNT0AA5w360AFs+b+M+pXrHipCQ=;
	h=From:To:Cc:Subject:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=q41UL5GOa/cauOhb7OtRGkM36h+ZxfO7lKuYsWFoGyc8G627XBxUI1d8gQmgDxiYrFN3poEKfwR96y1I9U8rbavuWGXrrTGToCRKMz9ZOQoM+i/IrVPitO/3AGjES7u6qeHRMIdMtBAkdK77g+DlU9GhgBJ+sQFTIwplR0egvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spvWqnqp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spvWqnqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CD3C4CEE9;
	Fri, 21 Mar 2025 06:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742540185;
	bh=HKi5VTkLFjJWETNHJNT0AA5w360AFs+b+M+pXrHipCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=spvWqnqpSmIDaa2nC7B2TVdLeQoLGM5h0xlsGKVqVaQJZtrIoYl4bB3F4Zjt+z1rP
	 0d5vQXhAtDDozh69X4mJFHvnjS6um1oRJUKaWL9iowCcgCxVht4L4mfYEypTDc3ydq
	 Hqut4h2wc5iE4TyflBw4/CueiE+hudLbHEAvHsEFT1KP3yH6OymBjmSRHgbdqPfnhw
	 t6W+q3TmOw9EGZkgfKPtNZeENnp5RWZijDTUDL4CTYNB6vtd53ZwYI25HNQwViRBnR
	 6e+MmzEi5Sarfp49TeRirh7bTjYh/MWuY45n6AF3Yopp5e0XXMjMvveTL340rU890d
	 /tsAXeIyAq7+Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
  <rust-for-linux@vger.kernel.org>,  <daniel.almeida@collabora.com>,
  <dakr@kernel.org>,  <robin.murphy@arm.com>,  <aliceryhl@google.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?us-ascii?Q?=3D=3Futf-8=3FQ=3FBj=3DC3=3DB6rn=3F=3D?=
 Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v15 02/11] rust: add dma coherent allocator abstraction.
In-Reply-To: <CANiq72k_2dknw9CWj=yxMeBBrvMjPp5mhu=H++BP_wTVCHtnew@mail.gmail.com>
 (Miguel
	Ojeda's message of "Fri, 21 Mar 2025 00:54:52 +0100")
Message-ID: <87a59eeuwm.fsf@kernel.org>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
	<UiefwZ9WcVV7q7YyERsbNIYqOxTWUWEO9aZNxThH7uRFkjE4LDSUtaVdiLeShk_JYe5RJLD5MgFC9IxGUuzTEw==@protonmail.internalid>
	<20250317185345.2608976-3-abdiel.janulgue@gmail.com>
	<87senajxlv.fsf@kernel.org>
	<QEvctNEvG4qrg2wb67KaDRAH9rV8zNNwU-ndUgkyjB30tX360Xi88B_WpcxXcoZuEKTcOhOv1eJDKEWodZ0bnw==@protonmail.internalid>
	<CANiq72k_2dknw9CWj=yxMeBBrvMjPp5mhu=H++BP_wTVCHtnew@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Mar 2025 07:56:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Mar 18, 2025 at 2:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> The wording of in the other doc comments is different than this one and
>> the two next ones. Consider aligning them:
>>
>>   Hints the DMA-mapping subsystem that ...
>>
>>   Tells the DMA-mapping subsystem ...
>>
>>   Indicates that the buffer ...
>
> These come from the C side and are copy-pasted, so I suspect that was
> the reason -- they may want to have them in sync, so I didn't touch
> them.

Since this particular doc discussion is about wording and not semantics,
I won't object too much. However, writing the docs for Rust is a very
good chance to get _better_ docs and in general I would encourage taking
advantage of that.


Best regards,
Andreas Hindborg



