Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9520B7ED
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610554; cv=none; b=ePk+SZJpDb8N/GaPb0tvAMaLp6swFj5askeoOAFeUPoL0yBrNSUxsKrAxjsKwlBjUJEJFlVDqyjeQ4srFRMcVkH39Cb/KbSWeoYqjxijEpb/q160q3a5GbBPMwRO3iLWOgQijC91zpjpDjMKbQZV+tX8kjBIKWgjVxXKdzQU3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610554; c=relaxed/simple;
	bh=47I4W/OdFRdOnxyJFooCrp1d9zqBf6rBozHIs8h9RnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHeQIOMZGHPZqyvT4J/A2KM9/fwmiFayb/s2INXV3+Tg3ILr3j+4APZAlS0Ec34op78EPYuprEVpU5Ogfi82ptbT7KaSdzFImV/Srd8oTHzuDvSITndLPDlMuGS+iRxpluj7rywZiKYkqyfRgSnCuCrHdkmuZaXEWmD/VL0IbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cx4M+6wj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cx4M+6wj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738610549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8JzCvz88snSnAVNQMXnklYQMU/jabK+PbGj82gu/vrw=;
	b=cx4M+6wj5cfvk9accn0ptGtG756AOAuYWbPy6D0IxpaGgpqqCa4+ZX8mWRiMO9z9UM6jxD
	Ko2q3wqdeVLbdgn/id3WQBRHzaDgCHIb42xG+pIii8TsRU2IEJlC3IwS4Xp7cy9nOYNm9I
	/SSjQD2fH77W/7pKGdbZPlZckpfbu2E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-Wete-p6SM6usiqOAviFGlw-1; Mon, 03 Feb 2025 14:22:28 -0500
X-MC-Unique: Wete-p6SM6usiqOAviFGlw-1
X-Mimecast-MFC-AGG-ID: Wete-p6SM6usiqOAviFGlw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso38382445e9.2
        for <iommu@lists.linux.dev>; Mon, 03 Feb 2025 11:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738610545; x=1739215345;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JzCvz88snSnAVNQMXnklYQMU/jabK+PbGj82gu/vrw=;
        b=iPDjc1LY+53rb1k1giI0xtHHV0erMKALi6uj4D4jKhPfaa5Almmw3fU/gsIBgcSvSH
         e9rpD5ET1RKwVxeccYSfwVQHvEvwIa7I1LHi3PgoT1Aymcbp4xlliLJ7In66fxxkH52O
         8xYYVRH7PLmz/AZY2hUHXI491oGASjXliSVRCRezCW3t6H/dluSMb+UICnc4z/PBuIuZ
         7Ho4Kw1OMS5+u2llumb9K2evnciiJaWsWRkarTK36cOP83uqgRSR08uVQqQ8LMOWiyhi
         drvRoEDqnk79y2+oSkyGPoLuPe6t6d3LsoxFpOtXFcQDQcIPz6B0moiDWpRDSpbTFmwK
         go4A==
X-Forwarded-Encrypted: i=1; AJvYcCVnTCYU6xW23QdI2lw1sULYCInJqhSJjWuXhYqcIMWhKSzF6Fhh6fVdeB+OtjerR+6RQCtEDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzMOh8yunZzkiWbUDP8ufGcufty2CciGCrDceasBD0PW71vqaB
	mHmsqYo4/nmWzwX0lf9OkZ8IReUjzRe3JMDQv9UsCLqLOyT8JoFs7OeDeD1Bgvf6s5tpwP6A+EF
	eC/kbnRpTgSRxPEuxhY6qgJgDOeT/mSOSFyR9k/tUNlUb3CqmIyg9
X-Gm-Gg: ASbGnctaol6Jrs6rP0nWZX9thgcSylGeBkvgbsW71DRZ3eJPDI+hC5aoqSOM+Yi8gPg
	UpOpkefsz06pmYF7SdC7lvi8xXubxFvAvxAwvz7mxySnyWdC18Os/3o+ZAOdBFuMGundlxD/2ie
	7F1mWjI5Me9XGK5b2KvP5Mk6gD6ElX+e8Y/ySajWL0OOOqA5r16AxfpJ4ceAkaQeQv/NEgkMQEm
	nt8Di4EUUkAmhjLf8iqBBnnBJMTlsj8agd7SZcGDtRAwgAmzwD0fsEgbn107pycEiswCNuBVlQT
	06Cl/A==
X-Received: by 2002:a05:600c:6c44:b0:436:fb02:e90 with SMTP id 5b1f17b1804b1-438dc48aa14mr222541265e9.10.1738610545568;
        Mon, 03 Feb 2025 11:22:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBlGAFDIU1GLvsSC3pDPLeHERpJ5yoHpiUEpzS4SGlu1H0ypOa5OhIad8hucJaADA6QYw8AQ==
X-Received: by 2002:a05:600c:6c44:b0:436:fb02:e90 with SMTP id 5b1f17b1804b1-438dc48aa14mr222541065e9.10.1738610545216;
        Mon, 03 Feb 2025 11:22:25 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-438dcc26d6fsm197969255e9.14.2025.02.03.11.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 11:22:24 -0800 (PST)
Message-ID: <5d5a6640-2f14-4d80-bc5e-4d8274251793@redhat.com>
Date: Mon, 3 Feb 2025 20:22:22 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Hector Martin <marcan@marcan.st>, Jason Gunthorpe <jgg@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: phasta@kernel.org, Christoph Hellwig <hch@lst.de>,
 Danilo Krummrich <dakr@kernel.org>,
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
References: <Z3-NqwAG_96yq8VD@pollux> <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N3eovNI6GczZgXfa5FYrUEg4Ek4Q71Zhcu-uRLyPpGE_1738610546
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/25 19:46, Hector Martin wrote:
> Adding Linus
> 
> My 2c: If Linus doesn't pipe up with an authoritative answer to this
> thread, Miguel and the other Rust folks should just merge this series
> once it is reviewed and ready, ignoring Christoph's overt attempt at
> sabotaging the project.

Hold your horses...  I agree that they should just merge the series in 
the unlikely event that Linus doesn't chime in over the next two months, 
but I would very strongly suggest that it's sent to Linus (assuming he 
doesn't jump in now) as a separate pull request.

This is almost always a good thing to do when you have commits that 
merit specific attention (example: 
https://www.uwsg.indiana.edu/hypermail/linux/kernel/2109.2/10311.html).

My 2 cents as someone that is certainly not any kind of VIP, but has 
been in MAINTAINERS for quite a while.

> Rust folks: Please don't waste your time and mental cycles on drama like
> this. It's not worth your time. Either Linus likes it, or he doesn't.
> Everything else is distractions orchestrated by a subset of saboteur
> maintainers who are trying to demoralize you until you give up, because
> they know they're going to be on the losing side of history sooner or
> later. No amount of sabotage from old entrenched maintainers is going to
> stop the world from moving forward towards memory-safe languages.

I have a question, which is unrelated to my opinion of Rust for Linux: 
in what way do you think this tirade is actually helping?

> FWIW, in my opinion, the "cancer" comment from Christoph would be enough
> to qualify for Code-of-Conduct action, but I doubt anything of the sort
> will happen.

FWIW I agree that it was borderline and probably on the wrong side of 
the edge.  But I am happy for one that Christoph has since expanded 
beyond the "cancer" comment, because that's at least a technical 
argument, unlike yours above.

Paolo

