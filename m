Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA331BD007
	for <iommu@lists.linux.dev>; Sun,  9 Feb 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739118002; cv=none; b=lr/E+J2fwWrfGbVIfwAaZmee8wmzFHxBtyRosqkrWKoBki7KIHXBzv4Eczy8mEVQIMcISPpuYyRpt6UxtarqZccLyd0A6+sfxL4BhFeITE2J2TvYlTaAVzC8ASH+wTvh5auAMwVRXY/jxrqUmXYpCNVjsfV9IH2AwtspGJ80QOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739118002; c=relaxed/simple;
	bh=ifjluPUakW+96MCIWqdQbZnHzkmiYmc/U3OkyX77Pig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocI7xlqnFAogdXXT+Pq+pd6bKyT+ztkdyAxXlIIEqq3Qi7b7llKlLOXYXjm9jckzR71E5mHs/d5FwvLJO5N9Y8TSK9hbvcmrWYUevMkLD/091ypA68U0002j/aFmliGkEzTCTPZMT/Ombg5waV70OnP0ZVCEoaLfFOXm+Bfaeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu; spf=pass smtp.mailfrom=vt.edu; dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b=E7K3HZ5i; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="E7K3HZ5i"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fc7ff03209so251965eaf.0
        for <iommu@lists.linux.dev>; Sun, 09 Feb 2025 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1739118000; x=1739722800; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvvEwD0sTJthbBM/YD3kaZ7WUn0gz8E22WCyOMue1ik=;
        b=E7K3HZ5iRAZ4dXe1JZZWSZV1LU4XdJMHOD4NMIM/XyZKz33jQwWWcR2pX8MMZlL4Rk
         aRL+bAEz3R5tQmiGUz+ABd4NIcqEqhySUwZoVcPX6G+vFK6j2XDdiCdcbivWButmZ6yT
         sNuHBBaGEUZnk3PuaaCs50RTujELpQg1UZb7ZLRLCD7jPgVoPS6s6+Scg4TmAhlVjjI/
         QdKGdA8rI4fviP4d7U3SuFJJ/W2fvq73GAo38AISimh1UQwW8/4yBvJ63uMmirabGgCV
         Dp+PyWx2emDsUPI/UGyz0kKfbGJQEJTdrmbWbFMMRGnT9rNrD3c39KaDb/srSMNzjQPm
         negA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739118000; x=1739722800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvvEwD0sTJthbBM/YD3kaZ7WUn0gz8E22WCyOMue1ik=;
        b=fAmOJOPy05I6996EBJbdONRKmjIEx3Jyk5SWUba6bnvjJBqop6pGx5LMFQjKHoWS/q
         Z2JOZIszi4Pjz2Kg7ZZ3BLrUESb/uls0J/LHxNS3AJKFxLyzokedw0azPxaZEhWU7mIm
         o9fLZVIPsaMoVEoALrkNWHawHXWWsPbFmbtsWRVsiIdTasw7KWp4unMiHXK1FSuAvooM
         wZ8w7jIw0Dh+dkKN0MAi9NZrpoIepiw7J65XFGpHcAw6iNenokZSia7gWaX0FAdskSmR
         0Te5lP08P8xB2wPQKAyzZ0NxAjZ6Q+pTpmbx4FdpWB7ZZyUgiOICo5mtCr1wu2GTaik5
         VLqw==
X-Forwarded-Encrypted: i=1; AJvYcCWk3HvK8lhdH2ON23rRE5jHvbIszeKE4hJl0bEgqmXN9yPwAKO7fyHKR3uhu97Cvzmsunwb8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz2sjGfWhhY/QvngWtO77es/QC/fyLrpe1LIiwO72b68vGEuq7
	RgbUGPsqITa9uyrAo+jDE9uAwbVCcX33kX+NYGMd5WtJRs/HH+kuxqs8z9wVcyc=
X-Gm-Gg: ASbGncvzyWU+s6y8gUcE//RiEXH9ZL5YL/yzOcUVIWYqU8mdWKWdNNJc65ayMHn8utk
	e4T2Tg/us9zkAnuBSR64qLGo8jTYxqVXv45JpKgEd4yzQ8z/2JJPuKcHGiNSGmZ+Mkb1Gc9YFXw
	becSVmNzXYodE6DvRVCDV+Xz+tj8VJBPEKKtyrWdX3Cld0XYtdOKMoZxSWkzKRsKkyehOFEOn+b
	aqMcA9hCOsjZNz7WA1R8Y8dNk75oaSlJfTILNllAfMcTgZsI84bViYDbZyVRzfde8MgUuVjTvPt
	t1G1Cd3mFJoxVHRzDAdIlJ/w9eIZJGpQ2BfUbBhVfLhey6bxrsWdYoK4Ow==
X-Google-Smtp-Source: AGHT+IEPbHpU34hW2fuOTfUZssneFgJQCeacANatw+//XNFvaeoOL3OjufV8AgclHjY9ynCZqH1OUA==
X-Received: by 2002:a05:6820:134f:b0:5f6:e60a:776f with SMTP id 006d021491bc7-5fc5e5ff7e9mr7297600eaf.1.1739117999599;
        Sun, 09 Feb 2025 08:19:59 -0800 (PST)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc6f2764e7sm801647eaf.17.2025.02.09.08.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 08:19:58 -0800 (PST)
Message-ID: <42efddde-9fe0-4984-a903-c89328a726b6@vt.edu>
Date: Sun, 9 Feb 2025 10:19:56 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
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
Content-Language: en-US
From: Carlos Bilbao <bilbao@vt.edu>
In-Reply-To: <CAMwc25p1kGHjy7z19Kg+vv7yVc0bF2taA08hBKhk72e4HiK5xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello David,

On 2/9/25 00:44, David Airlie wrote:
> On Sun, Feb 9, 2025 at 9:55 AM Carlos Bilbao <bilbao@vt.edu> wrote:
>>
>> Hello,
>>
>> On 1/8/25 09:16, Miguel Ojeda wrote:
>>> On Wed, Jan 8, 2025 at 3:00 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> No rust code in kernel/dma, please.
>>>
>>> What do you suggest?
>>
>> This is it. What do people suggest? This thread has received a lot of
>> attention -- maybe it's an opportunity for the community to brainstorm.
>> Here's an idea:
>>
>> Some maintainers clearly hate wrappers/bindings to Rust, while others don't
>> mind as long as the R4L folks commit to the maintenance duties. Depending on
>> the subsystem, it will be a completely different conversation. It seems to
>> me that right now, every time the R4L folks interact with a new subsystem,
>> they need to understand the maintainer's stance. That looks like an
>> exhausting process.
>>
> 
> That is the process we are committed to, everyone has a voice and gets
> to be heard, and we move forward in the appropriate manner with each
> maintainer. Bypassing maintainers is the last resort, not engaging at
> all with maintainers isn't a productive way forward either. Your below
> attempt is trying to create a technical solution to a social problem.
> 
>> Would it make sense to have a C middleman that Rust calls instead of
>> binding directly to the C funcs? This dispatcher would provide a simpler,
>> stable API with fixed function signatures, even if the C functions change.
>> If a C func is removed/changed, only the C dispatcher would need to be
>> adapted, but until that happens, a new error could be returned to the Rust
>> side (not ideal, but Rust doesn't just break).
>>
>> This would obviously impose some limitations on the Rust side, but it might
>> be less conflictive than direct bindings. Also, in Abdiel's case here (for
>> example), he'd explicitly take on the maintenance of the Rust abstraction
>> and its DMA dispatchers, leaving no ambiguity about ownership.
>>
> 
> This just adds overheads for everyone to little advantage for the
> cases where maintainers are fine with all the other approaches.

I'm not sure there's a need to worry about overhead in this hypothetical
case if the dispatcher is merely a translator and doesn't validate inputs,
copy buffers, or such. It would be less than calling from userspace.

What I meant to say (I wasn't clear before) was for this solution to apply
to cases where maintainers are firmly against all alternatives. Obviously,
if all the parties involved are happy, direct bindings are preferable.


> 
> Also the bindings code in rust is usually pretty trivial to change,
> it's not like you can really abstract things that far, changing APIs
> is hard no matter what, understanding the nuances in every C driver
> can takes months of work adding rust bindings to your changes is
> rarely going to be the limiting factor. We have learned over the years
> to not make API changes that are subtle or hidden, and can leave out
> of tree or in development users broken in subtle ways and as long as
> we keep making API changes like that, updating the rust code is the
> least of anyone's worries. This isn't like having to learn Mandarin vs
> English, it's code written with a different syntax, it's not even
> perl.

I'm not sure there's a need to worry about overhead in this hypothetical
case if the dispatcher is merely a translator and doesn't validate inputs,
copy buffers, or such. It would be less than calling from userspace.

What I meant to say (and wasn't clear before) is that this solution could
apply to cases where maintainers are firmly against all better
alternatives. Of course, if all the parties involved are happy with direct
bindings, that's preferable. But as you said, this is a social problem, so
maybe it's not a one-size-fits-all solution.

I agree that in some cases, abstracting the API could be complicated, but
I’d focus on keeping it simple and providing Rust with the minimum subset
it needs to keep things moving forward. Abdiel's PR is a good example --
by keeping the functions in his CoherentAllocation, we keep that option,
but lose the granularity of DMA mapping attributes (which would be some
default in the C dispatcher).

I agree that making subtle API changes is risky, and it would def. be
something to keep an eye on.

And yes, with this approach, some Rust developers may eventually miss
certain DMA functionalities in the future; but that would still be better
than the current situation, where _all_ Rust devs are missing all DMA
capabilities.

> 
> Dave.
> 

Thanks,
Carlos
