Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A2205E1A
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068649; cv=none; b=rFSdNj9OQYMwedodlszac28a7Y+l6XTDbCPF46q8EX4OsZg3t95hXhvYb5kF6Vgw4YBHF5cY1I2NXsxqwHxXGs6xhA2m4/iDNMcx8+Rq4f5RIPDuIm0QjE1j57MdmjeiEFbbk7Hbl5LlK8UR1oFUiKDMEeRwsGnOF7lmtHGpUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068649; c=relaxed/simple;
	bh=A98u9Pi7cA4PP0YNnK0cMws0e33F70bGk0qUEsxsUgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnIb0azLSTCi/8uV3tfoUHfFPx5v7t2k78hWtmlbf4zWf0olaJIq4Ary3gxznK6HiNL6kCc7R5/AyZP/ogHbB6Hsp+9ENFNyelOwJ9kE99lEzAkBJXm8BP6AEGsUmE1/qH95/rL9yeD/OkmSNg1gQUEjOOwsfVeaiHlNtWNL+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=KAY/PmNg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KAY/PmNg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so7440305e9.1
        for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1740068646; x=1740673446; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHNQaW7mzEdCd/TPuQOkmBComqEtaa6hiKEAKod6XVI=;
        b=KAY/PmNgFF4lYIPypzDQrQ+gmcjHuakqWqsAcAKj8aiskYOAU9pxsMIwCcOrOFG6k2
         g4D32qmXbx1nitAdY58JOv2lBUgL+JmQkhug/PkTsxUloNnGIYoqOw5wIo1tSyC+EjzF
         SsJiXUZNO4kBTP3j3ac8eh7Y9YPBezxIpAlGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068646; x=1740673446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHNQaW7mzEdCd/TPuQOkmBComqEtaa6hiKEAKod6XVI=;
        b=KYIxrNrN5YdSKUEfg/I/+Tdi1bci0F4OEe/WLgBC4tslllEZIPy4vgCx4nYok+5hB6
         gybdy8tMOv/LbN6rwZFhCglKS9NwJGkuaDHoDOnUpa4qWWMhl1ukM0rtQpX6vCP3jpw5
         +Yy4dm/qJGOzkwr+zYqsjIEKS9qO+ImtWM1YSXrDbPbThak92irwiltPGqshT2mIqXtY
         i06HuJ2jiE4eg2zehyjPesaE6qw8ElK49aL/EVDJejgQNewsSJut2aJEprlNOgnx98OH
         lvDO/FxFeV1B8QLy9GLQuUKefSEABEhSjD4LjFOQFA6kGgh/CPS/+LDeEDqNvMlvMnjq
         8JtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Dwo6+VOXbuSt1zpfPvdTdc/toBW4nIOfkegU+LnYFhiHhdE8YTuPaOCyyquYIjhH7ElFFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnBKi3dIp8c/FD7mA6ZGNgaVQ73wYSk9S0CwfQIoX7FgTkde0l
	lNEnsuWlcqt0zCinyaGolr0qYYELK0euQS19bhTkQLylzcANuUsT4Yunlfl0uQo=
X-Gm-Gg: ASbGnculfZ4Hz9usTs1H9ZlO+/2h9IF5+Q8jahrlHlgAkiTDRxFJ0rICfmqijvzjTHP
	fzbTOLtDad2dprSCHmDH39PlE+wCdojhd5rEaRp5CcQMcvQEiLBBglMnj/hjE/cOHTZQT3mmhwW
	U9+R/UnFfnklFOQGPhkrk+7peUNLzjPT8RVjgPnUlXL4iUL7o4wBr33tlAlY2MxzRGcJ+KVLSYd
	MySG/gRt7LCASrpZgMpdrLX2D41mluyaKARL9APnvsMhDrZ1gBVEdQjqeVYSMK1YJ86aW6zzq4y
	FFBfRXJRmj80u9qUe8CrW0rnrjg=
X-Google-Smtp-Source: AGHT+IGO2UBg3ppa7TE2D8LMax0SXOyah2tNEU1Go0U95uL3vj126aJdb3xWmggfe65ARa8Fbl4nTQ==
X-Received: by 2002:a05:600c:4fc2:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43991ddd158mr132576415e9.10.1740068645761;
        Thu, 20 Feb 2025 08:24:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7c7sm249594765e9.27.2025.02.20.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:24:05 -0800 (PST)
Date: Thu, 20 Feb 2025 17:24:01 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: David Airlie <airlied@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>, "Dr. Greg" <greg@enjellic.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hector Martin <marcan@marcan.st>, Dave Airlie <airlied@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
Message-ID: <Z7dXIfFJ2qXNKtwT@phenom.ffwll.local>
Mail-Followup-To: David Airlie <airlied@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, "Dr. Greg" <greg@enjellic.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hector Martin <marcan@marcan.st>, Dave Airlie <airlied@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
References: <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
 <20250207121638.GA7356@wind.enjellic.com>
 <20250208204416.GL1130956@mit.edu>
 <CAMwc25pxz2+B329BArDQMpxOvpMtvhop1u_Uwc0axn2LqNP0vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMwc25pxz2+B329BArDQMpxOvpMtvhop1u_Uwc0axn2LqNP0vA@mail.gmail.com>
X-Operating-System: Linux phenom 6.12.11-amd64

On Thu, Feb 13, 2025 at 08:20:52PM +1000, David Airlie wrote:
> On Sun, Feb 9, 2025 at 6:48 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Fri, Feb 07, 2025 at 06:16:38AM -0600, Dr. Greg wrote:
> > >
> > > The all powerful sub-system maintainer model works well if the big
> > > technology companies can employ omniscient individuals in these roles,
> > > but those types are a bit hard to come by.
> >
> > I'll let you in a secret.  The maintainers are not "all-powerfui".  We
> > are the "thin blue line" that is trying to keep the code to be
> > maintainable and high quality.  Like most leaders of volunteer
> > organization, whether it is the Internet Engineerint Task Force (the
> > standards body for the Internet), we actually have very little power.
> > We can not *command* people to work on retiring technical debt, or to
> > improve testing infrastructure, or work on some particular feature
> > that we'd very like for our users.
> 
> Just as a courtesy to others can we not use the "thin blue line"
> analogy in this community, it has had some bad connotation thrown on
> it in the US context over the past few years, and I'd rather not as a
> maintainer be aligned with current connotation/interpretations of it,
> despite having family involved in our local force.

Agreed. I dropped a bit the ball on this, because at first I thought this
was only posted on part of the thread that wasn't cc'ed to dri-devel - I
can't pick a fight with the kernel community at large for everything that
happens. And then I let Dave handle this, because I couldn't come up with
anything that's not a nuclear table flip. 2 weeks later I'm still not
better, so let me instead express positively what kind of maintainership I
strive for by linking to an old talk of mine:

https://blog.ffwll.ch/2017/01/maintainers-dont-scale.html

> I'm open to suggestions for any better analogies.

Better analogy aside, I fundamentally disagree with understanding
maintainership as a gatekeeper role that exists to keep the chaos out. My
goal is to help build a community where people enjoy collaborating, and
then gtfo so I don't hinder them. I think the talk I linked above is
holding up quite well even years later, but the last part really embodies
that idea, so let me just quote that:

    Be a Steward, Not a Lord

    I think one of key advantages of open source is that people stick
    around for a very long time. Even when they switch jobs or move
    around. Maybe the usual “for life” qualifier isn’t really a great
    choice, since it sounds more like a mandatory sentence than something
    done by choice. What I object to is the “dictator” part, since if your
    goal is to grow a great community and maybe reach world domination,
    then you as the maintainer need to serve that community. And not that
    the community serves you.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
