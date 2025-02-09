Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278013B2BB
	for <iommu@lists.linux.dev>; Sun,  9 Feb 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739118510; cv=none; b=qfVixioOBw7k9Pqbd9X9SEE7l6ojaQ7mNlS8jsOK5bXbN4dFLrxzjg/hhQ3vr9AvgJsxAzGACCPMt/5NFpKZtNbywrwOr9LpLAkYImsLnqMTFQQlGpADE0gM+f50Mr9i89rWOwhLpI2VcYjbCQhuqblp8kT+OIoQ7V1wdPw5Gzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739118510; c=relaxed/simple;
	bh=nQQGWFIz4kSqnu1kGUbVo6y3Ae6KjA9/WE3B2NnCO9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EtAOJXNo5DfW8iyXyYPO/SXZ7xlQyLAmAEK3ztvLFtvzG7TGDga2pD22EL29ARJFl8GLWibYk44brQXCK0xKUYROSZ8V/c5vFTY+iM/ASMpdTmr7TxVhOqB+Tfn78M7Avr+zMOPUKocyg6SHclHZw8bXOTzyrN3MF6CDgqCT9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu; spf=pass smtp.mailfrom=vt.edu; dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b=P6tZjGYC; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="P6tZjGYC"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f3aaa9cdcdso174861b6e.3
        for <iommu@lists.linux.dev>; Sun, 09 Feb 2025 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1739118507; x=1739723307; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nQQGWFIz4kSqnu1kGUbVo6y3Ae6KjA9/WE3B2NnCO9c=;
        b=P6tZjGYC5I2QDOQfLIyImX7bkt/peTzFCWufPDxBZW3nwV0k7eL+NeQYLRUzmzZhb2
         8tawUXotfTLCNj7+k36jvOfQXzahmiuv9ttTvIqZd2GtuEaFwsoJQS3e7un2LFUaqgn4
         n99wlT2Tiq2wR24FJTaSD724PlGXo02dURg16At6eqdLsvZMBcYKYRIyYvtfogiEZivY
         sHuB9U+QTm+bEo6yPregXsmjpeVKlPYBZ/rLRqAyQuKQUsdnXFqT3sAPbRXYL4JEpX18
         KNc272walZM7BOnXQOvrTTZ8aNFapBPY1OO8aV6guEB/BmrpfDjd1B4Aaejw1wxyQo5K
         7mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739118507; x=1739723307;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQQGWFIz4kSqnu1kGUbVo6y3Ae6KjA9/WE3B2NnCO9c=;
        b=j0TFM5c8kgcLuH05ljzpob3P8YMJ9MS34LualNoJ8V2wJFrbGo5Zuyq2vZoKXy+jdd
         qVAXehNZA1cmYA0MVBPvQQ60zF8YJHcid28vDwQAnMZzs3StowcBR8yAu/awC8ppvgpX
         j/HN5NxQtQG6cMawESP0liMIMF2r6BjrnfUBsU65KptaOwqn54/7bNjqpdV/VWOQ1OoV
         4YjHUcT5GGzUKeSHsIaFyWzBxnCJ3Ka5YFN7Aq1bGgmduGpxp7IxN1EEXau1SOt+MZ9A
         cb3oazxZkA6QM0+tSCEXoiUaqQyC7xvnKC+Nv6+8hiMpPAl/DF60+H7z81N1x15Oq0ya
         j62Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEtKWYqyL8kEOXBkuYtxDDtRN1R9xzwTDPhWvmXdeitODxYdgyKizO/FS4EJfopMtXZAkaKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyO9wAXxy5l4VDJ3n/QM+mcfy1v0d9R95V0+j/sgrkHQtycAx/L
	mS+6qun3wfDVQ5YKcs0WJn0DOIMzWM0wJwOAuc6dSMRHKotwRtY90vYZZus7/Ro=
X-Gm-Gg: ASbGncuCew7Suw62o/Yr1GqaRNom70uAfeeoL1nauSWbFQ1saGY1gLoapXFDB7QErLS
	fNbHEXA5C4ck4JvhKbIMBCFSGSt7je6VI+hCZC/Fw1MhgP06EqFccKYsxPiOQnAbV5jg+bFVLig
	g/AS7Qdk3aUk5qiX6rNdT0us/u3bJusNgLTrAzBC1HAvyp0pZWXlr1fUaKl0nKT6V9/TcDIXXPl
	u2nYVvj7y9yyCZmifk4dpcUrOvXvxH6c5E1iuv2rGp9nPU8+9FUH+ea4ts7uoeyGLI1FDZ4suHa
	pwpTHF/it+nAn1E9bYULmBDZMXTAqhVXWiq/oTFzqwJUUJWmrx+GOE+32A==
X-Google-Smtp-Source: AGHT+IFNMNWYl1WupTtff3rH3xveYZ/zBgh1j4QRo8cZQGBw00E8/IkGzma+E84CDwsDvfT0eK3wjQ==
X-Received: by 2002:a05:6808:4482:b0:3f1:cd30:d692 with SMTP id 5614622812f47-3f39237a1f4mr7611873b6e.26.1739118507407;
        Sun, 09 Feb 2025 08:28:27 -0800 (PST)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389fd5d48sm1799868b6e.42.2025.02.09.08.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 08:28:26 -0800 (PST)
Message-ID: <d7944fbd-f9ed-4d5f-892f-5afd72c3c6a1@vt.edu>
Date: Sun, 9 Feb 2025 10:28:24 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
From: Carlos Bilbao <bilbao@vt.edu>
To: David Airlie <airlied@redhat.com>,
 "carlos.bilbao@kernel.org" <carlos.bilbao@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 daniel.almeida@collabora.com, aliceryhl@google.com, robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <1894f095-e93a-4def-a223-d5c089ecc2df@vt.edu>
 <CAMwc25p1kGHjy7z19Kg+vv7yVc0bF2taA08hBKhk72e4HiK5xA@mail.gmail.com>
 <42efddde-9fe0-4984-a903-c89328a726b6@vt.edu>
Content-Language: en-US
In-Reply-To: <42efddde-9fe0-4984-a903-c89328a726b6@vt.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/9/25 10:19, Carlos Bilbao wrote:

> Hello David,
>
> On 2/9/25 00:44, David Airlie wrote:
>> On Sun, Feb 9, 2025 at 9:55 AM Carlos Bilbao <bilbao@vt.edu> wrote:
>>> Hello,
>>>
>>> On 1/8/25 09:16, Miguel Ojeda wrote:
>>>> On Wed, Jan 8, 2025 at 3:00 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>> No rust code in kernel/dma, please.
>>>> What do you suggest?
>>> This is it. What do people suggest? This thread has received a lot of
>>> attention -- maybe it's an opportunity for the community to brainstorm.
>>> Here's an idea:
>>>
>>> Some maintainers clearly hate wrappers/bindings to Rust, while others don't
>>> mind as long as the R4L folks commit to the maintenance duties. Depending on
>>> the subsystem, it will be a completely different conversation. It seems to
>>> me that right now, every time the R4L folks interact with a new subsystem,
>>> they need to understand the maintainer's stance. That looks like an
>>> exhausting process.
>>>
>> That is the process we are committed to, everyone has a voice and gets
>> to be heard, and we move forward in the appropriate manner with each
>> maintainer. Bypassing maintainers is the last resort, not engaging at
>> all with maintainers isn't a productive way forward either. Your below
>> attempt is trying to create a technical solution to a social problem.
>>
>>> Would it make sense to have a C middleman that Rust calls instead of
>>> binding directly to the C funcs? This dispatcher would provide a simpler,
>>> stable API with fixed function signatures, even if the C functions change.
>>> If a C func is removed/changed, only the C dispatcher would need to be
>>> adapted, but until that happens, a new error could be returned to the Rust
>>> side (not ideal, but Rust doesn't just break).
>>>
>>> This would obviously impose some limitations on the Rust side, but it might
>>> be less conflictive than direct bindings. Also, in Abdiel's case here (for
>>> example), he'd explicitly take on the maintenance of the Rust abstraction
>>> and its DMA dispatchers, leaving no ambiguity about ownership.
>>>
>> This just adds overheads for everyone to little advantage for the
>> cases where maintainers are fine with all the other approaches.
> I'm not sure there's a need to worry about overhead in this hypothetical
> case if the dispatcher is merely a translator and doesn't validate inputs,
> copy buffers, or such. It would be less than calling from userspace.
>
> What I meant to say (I wasn't clear before) was for this solution to apply
> to cases where maintainers are firmly against all alternatives. Obviously,
> if all the parties involved are happy, direct bindings are preferable.
>
>
>> Also the bindings code in rust is usually pretty trivial to change,
>> it's not like you can really abstract things that far, changing APIs
>> is hard no matter what, understanding the nuances in every C driver
>> can takes months of work adding rust bindings to your changes is
>> rarely going to be the limiting factor. We have learned over the years
>> to not make API changes that are subtle or hidden, and can leave out
>> of tree or in development users broken in subtle ways and as long as
>> we keep making API changes like that, updating the rust code is the
>> least of anyone's worries. This isn't like having to learn Mandarin vs
>> English, it's code written with a different syntax, it's not even
>> perl.
> I'm not sure there's a need to worry about overhead in this hypothetical
> case if the dispatcher is merely a translator and doesn't validate inputs,
> copy buffers, or such. It would be less than calling from userspace.
>
> What I meant to say (and wasn't clear before) is that this solution could
> apply to cases where maintainers are firmly against all better
> alternatives. Of course, if all the parties involved are happy with direct
> bindings, that's preferable. But as you said, this is a social problem, so
> maybe it's not a one-size-fits-all solution.


I accidentally copied this twice after rephrasing, not trying to be
annoying x).


>
> I agree that in some cases, abstracting the API could be complicated, but
> I’d focus on keeping it simple and providing Rust with the minimum subset
> it needs to keep things moving forward. Abdiel's PR is a good example --
> by keeping the functions in his CoherentAllocation, we keep that option,
> but lose the granularity of DMA mapping attributes (which would be some
> default in the C dispatcher).
>
> I agree that making subtle API changes is risky, and it would def. be
> something to keep an eye on.
>
> And yes, with this approach, some Rust developers may eventually miss
> certain DMA functionalities in the future; but that would still be better
> than the current situation, where _all_ Rust devs are missing all DMA
> capabilities.
>
>> Dave.
>>
> Thanks,
> Carlos
