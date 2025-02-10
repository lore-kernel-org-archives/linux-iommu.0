Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B561BBBD7
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173977; cv=none; b=GMZDC/jTshzrGnSJv3t+uPX3urtDIbx6FIQ1R83S7FSYS87BmPwmLyrGcIgF/h+s3xSl413cPmDs71fwdaNlUFm250d8LjKVxjlvXNHXWOROJmM8clbIbyackA8KPjrw6T6egaGxyZ873/Fd/zZDcnuwJN4LU19gLpwL5CQWZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173977; c=relaxed/simple;
	bh=W8zdIY1rYsE45zOuPrzevizg1Izts5KX52qEocX1Sco=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eavzFlliocs9mmq/JpQtnX+u+PrQ045/HJ3q1PGGCg3rFmf01G2qUMxvNJEo5LWTc2lle8zg4dwqkGyBNEYRGQv6eLmqw4axRByTpKAPYXAnN0mCusU6FoxwpyBUZd0sMxWz1iGH33nUb9C8V7RP37FAGhg7f4dQR0xWbclzr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=UJB7a4c2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UJB7a4c2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43944c51e41so5617495e9.0
        for <iommu@lists.linux.dev>; Sun, 09 Feb 2025 23:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739173974; x=1739778774; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qkfv43O1g5zvAJXOqIcSrZ8ndK2BrDyyauC15WFvoaQ=;
        b=UJB7a4c2qNYdgmPIdTmfvkifuoW48k6rV1SYmyBPpzyKvgkioHeWu8MtWqbr6KSDEI
         zFyfD3MPeGoVbkWgQ4kc7smLIgUr+QUBewTt0qm7/qwYa5KqrDd5FOezAfzmaNh5cEpZ
         ru3uWaM69tRfhjZBOrtITernZoeHNzhFS3YZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173974; x=1739778774;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkfv43O1g5zvAJXOqIcSrZ8ndK2BrDyyauC15WFvoaQ=;
        b=iWDuhLgEZAkpNmpUjKd427maYqXflZ4vZZ5VIJuFX8p/CG255Wx5B1ABp+cJG46bxh
         jqFXbG4Y6jJARHJIWlBDRckx3XCP5Ux4NSd0hjivW33M3FuibLHAik3NeqmRCPLDVwsh
         aup1AOA9QcFdFId0R6Cv4ve3Gvw3bARLdEpbIqP5YIsbuCmEHPqBNC2pEjLybw3a/PSv
         qZndbdXEZK2e/ATaF0ITyX/SM9Iswm+hBGWOx3HEbdjG6iov5q5M8IcZM3nNWkIfUHK7
         z9ZgWRfcWWdKdbxO0Ntua/eczjcUKw0D7DMo0UzOjx1b29cF6viYr+DF+FeYZlHqJJIC
         LnXA==
X-Forwarded-Encrypted: i=1; AJvYcCXbTwj+AA9qTIVb+QTim+D9N0R3qy5RgTco2xQungrPKmHkYtJ6xDxYoWgEOiHOi7vxomxQzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwM4jMM1GWnqzyAx6sAAxyEdAvvCru0kQO++IqgOmcHJnBDl3A6
	vAePuZKrtS1sHYheBjVqJG06aSCcoDfw6ozdI/EIVbtYmIGm19mOljEYSqjWe9I=
X-Gm-Gg: ASbGncs3nb306eNzeP2Vqb13wDSSOINGIqUYdS4f0yz0XcTNTOeIdw/E+C7hQKuv6vx
	q+adtYY7TG5e+cxdbJTyED5QFL+0ZQOUWgPOSvTbTRznPDM5D+ZVRa9MD7YFnj0fIJFFlH5FbwU
	UHH8WchYcJx9C6Uf04EKThxuJQ22vHIl9F22yk2HiAiOp85kTHwf3DFWvGEFbQxS683X1SruJQv
	uAN7SoeYKrOlqzoHBtDSR55fo0GlLYjbTUXa0WJu1aH9oI0I/Gvlwt4D5KeuGo3Nw9kz+IYNeUi
	lAH1MmrO5Kt5/Q3LVVNwvkcf/jA=
X-Google-Smtp-Source: AGHT+IFDgbl8wGVpble5Zv0abCqTht8o2Ov+/uOG64czyzOx5fpcCwEyGABd1B3TPwQLwmivIDhgfQ==
X-Received: by 2002:a05:600c:4f8e:b0:434:a7e3:db5c with SMTP id 5b1f17b1804b1-43924989dbbmr123507065e9.11.1739173973845;
        Sun, 09 Feb 2025 23:52:53 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc565d62dsm10287702f8f.93.2025.02.09.23.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:52:53 -0800 (PST)
Date: Mon, 10 Feb 2025 08:52:51 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Hector Martin <marcan@marcan.st>, Simona Vetter <simona@ffwll.ch>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
Message-ID: <Z6mwU1Yiy-PQ4lXb@phenom.ffwll.local>
Mail-Followup-To: Hector Martin <marcan@marcan.st>,
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
References: <20250130154646.GA2298732@nvidia.com>
 <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <4c143b85-063a-4413-a6ca-e9d80e26da96@marcan.st>
 <c5a49bcb-45cf-4295-80e0-c4b07083df00@marcan.st>
 <Z6YPfsDSNdRUskvp@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6YPfsDSNdRUskvp@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.12.11-amd64

On Fri, Feb 07, 2025 at 02:49:50PM +0100, Simona Vetter wrote:
> When you're that harmful with your calling out, eventually I'm going to be
> fed up, and you get a live round shot across your bow. And if that then
> causes you to ragequit, because you can't actually deal with the heat
> you've been dishing out coming back around the corner:
> 
> Fuck off.

With some sleep, a w/e and slightly less ill temper: As I'd say in Swiss
German, this was suboptimal wording. Or in plain English, a disaster, I
screwed up.

I do not rescind the sentiment I expressed though. I cannot stand people
who punch where they're stronger, and eschew conflict and fold the moment
someone hits back.

> Or as Dave Airlie put it upthread in this conversation:
> 
> "Being toxic on the right side of an argument is still toxic, [...]"

The irony has not entirely escaped me. Oh well.

Remorsefully, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
