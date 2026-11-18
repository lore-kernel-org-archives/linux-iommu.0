Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018152;
	b=xB6qyHLr4T1VjRuSJv7HrQONsCOOtxPDk78RHgsuFA5N8Mu1RUo6hQp59ArYtr70vPOn
	 hP/L/QQFValScC+qD7mkaypaTd4YqmTMlmZxpW33q1G/mKQg9yUVOd0wbNWnykLMY48S7
	 8rLUmgvGeb13i0iFTcNarOBoGIuiLG6mFWW1EIRWbey1Cpk3+vSfI7v4ylHJmJ1J0CR1v
	 4Rgp/nRC8IUqZxRdMo16rmL2YdGcC90xW5B63YRv2PLstSajt41QsH1inRU7f7o27HwoT
	 dy4RSCDkr9VfV1olWo/5unCFRve16LnKKTLCR9FWzijZbkbLwdDXyANNn4K01qqhjSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=gSW8M0rgpdj9ZidqbA7F4jvYRgDNFzs19pLdYBcG6XI=;
	b=DTwiZKiBLudH2cr09lt5TbVlYamUwL+tJYAa3TKQLu/9LcxddYP3ai529+RzpRwbf9bo
	 NcoVV3VieSkNOWxKZnNgBJcFpmBadWehDWcnxzgLEFvklQHfjlfny++69E+BS4pmCF62e
	 WRXPenyTgg5LDTkArba9PIKT4rNB3zxP6G4n4II62VmG3jOgxoX2feqv7csqnhD6A46FI
	 oDlQOlOazcZD+6sL3MtP2Hg7c37/msnM3dIbYL1nj4BMPZTGIaomoINo6BjmiCnixDIlb
	 zULdZ/Y3SZB6ik8AM0lZ79XEOiVdvqV+h555oGUuNsTmJ1qD5n43e7K45uX8FJFLXfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XoeDfZCO;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE79606A32F
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 16:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE79606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XoeDfZCO
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91f2dd5dddaso11154606d6.3
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 08:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795018151; x=1795622951; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSW8M0rgpdj9ZidqbA7F4jvYRgDNFzs19pLdYBcG6XI=;
        b=XoeDfZCOgySL+MQJ4yvi4ZYvFsvL3TWb6BI19wJBbVwHCwARgjZt7EhgMqDA16jQZK
         khU54fJbhkyTYy1I4WTfIdyI/EIt/i5dE7fNd0wAaTMHG9cUgfe2/0fVIg+5s4x6QuuU
         oIlLEQdRtlXgTmi/ANMvLPlyp/ncRDSU8n77gNdWywkrD+bX4wrjHTv+0y1YmDwp8u+f
         sdyG6WGmkZjLIEy0RQFZLT0AZNp3nJLpvQtvPF+Cu0ZZ5w8+Cq21Ty1bwFs8tCV+7MPr
         Y1lDAtv1gow0LuxkgyRMDWxpqiFE60mMeqdePdtu7GK0FnVIn112deXRCGNQRqZVH1oE
         /Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018151; x=1795622951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gSW8M0rgpdj9ZidqbA7F4jvYRgDNFzs19pLdYBcG6XI=;
        b=kBhQxd5P2T9g+W97bCGFCW0vL8yUQQ4q/A6hWtDM3lYwcVRzfUA6ETkALgG1PEAmZI
         J1O86CLcz3DJAz5hwEw9uFYOfXIfFzr7PRPOwSXtfkl+zjHkmHLCMffZ8IUjgfjDICoH
         xaXYYUo5wQCcNES+K+DQiTJeVlcyiL4rQVSZnrjm0/64j5nLS4EeU0D7TruZa3TEImDj
         3Wa3SqiQ1EKIuIsc1VrTY69ZuvIVZCTmkPnuDzNCUA+CzfrkoLohqX3RL9hnSIZa1a2i
         LVQYrdVzFOY4gwa9J40lSMw7NZeJD9Bnn4PmAV/VXjFw6m1GV35fRS+LVoC3+yx2nx/x
         qAXQ==
X-Forwarded-Encrypted: i=1; AL+hErGwAVPwfFxHnxLip6fDg67GHchi6Mzs6hNN9n6gpc4H1g/1qVbLIzOtc1U7ovWWt5FxQoVQCw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9olM2E1iXkWmW9eB6bR720npOgARYlKBezWK3dE0zhLWh66GJ2
	by0U0TgEYjqOpIF6d0wZlqOYnIeWX5b0KXhmuj3ThZ0OU0FjGG+6f3x3UV2RAO9L5XA=
X-Gm-Gg: AZFdTZdCKtrLfwZnvnYzvRiqtLFVNBlRwKQCiPKK7Tv/7/SdKfXv0ED5gW8hFx7CDmy
	xxZ63wD3V1+hFHbRyio0Ggb0ILQAoMg6rBI2nTj3I6ak/tbTQ2OgQYldRTSJD0JsS//oyJ7uvBf
	Wyh4IWjKuy5I4QnpJfdUlGOT+JwE1tu9l0QMtaretJLQjQT8DFyT/737PNAgzeX5JiScOrlXfUJ
	X/093DOveNNq6YTv4SGTer6ICP93N1/v5v+95YXqgn8EnIXZvew/2L/Qk80kkCSqQydEmMcWCyy
	fUr9TA9xSzWcFdL6tsjqEQdDpubQ8KRq8GkmSzskszInMWymz1cM9IBf30pYnszErjDIq2wIf4k
	eiJvysEs5yDujfeMCjQSoIXKL8uVp/yZyrHvMa5ew73vgL4+1YeAiwtf/HA28td+lqx06EQSWP1
	Gno7+YLccHhbwq/l+zmVkb3C1wg1oFg7TAnAwf8hRoG5Y02xX7P4Bq59o0eOSubPjCQ6/eIAB4T
	eFHwwycBkoTDUIMyblu5oIbWj7vpIyUahtIIyb91bKS9G/bnnD65Z92F1NJw8SsG70lgcelGD0I
	MJYKubsWlliNTjjDwEdkszWzcRA=
X-Received: by 2002:a05:6214:5787:b0:920:fd27:87df with SMTP id 6a1803df08f44-92114f78ab5mr44895066d6.48.1795018151035;
        Wed, 18 Nov 2026 08:09:11 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114db5db5sm24976746d6.43.2026.11.18.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:09:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xTiDd-0000000Fn0o-1uSd;
	Wed, 18 Nov 2026 12:09:09 -0400
Date: Wed, 18 Nov 2026 12:09:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, iommu@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
Message-ID: <20261118160909.GC3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>

On Wed, Nov 18, 2026 at 10:25:58AM -0500, Nicolas Dufresne wrote:
> Hi,
> 
> Le mardi 17 novembre 2026 à 16:20 -0400, Jason Gunthorpe a écrit :
> > On Tue, Nov 17, 2026 at 05:09:11PM -0300, Daniel Almeida wrote:
> > > Hi Jason,
> > > 
> > > > On 16 Nov 2026, at 16:38, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > 
> > > > On Thu, Nov 12, 2026 at 02:00:07PM -0300, Daniel Almeida wrote:
> > > > > This series adds a Rust abstraction for IOMMU paging domains. A driver
> > > > > can allocate a domain, attach it to its device, map pages into it, and
> > > > > install a handler for its faults.
> > > > > 
> > > > > This will be used by the upcoming rkvenc driver that my colleagues
> > > > > Detlev Casanova, Nicolas Dufresne and I are working on. More details on
> > > > > this driver can be found by watching Nicolas Dufresne's talk at LPC 2026
> > > > > [0].
> > > > > 
> > > > > As part of the security model, each client will have its own IOMMU
> > > > > domain. This is needed as the submission model will let userspace set
> > > > > most of the encoder's registers directly, so the kernel cannot check
> > > > > every memory access that a job makes the encoder do. With a single
> > > > > domain, one client could make the encoder read or write the memory of
> > > > > another client.
> > > > 
> > > > How do you plan to get the paging domain in the first place?
> > > 
> > > We plan to alloc a paging domain when a video encoder session is created. Then
> > > we call iommu_attach_device() before a job runs, and detach back to the default
> > > domain after it finishes so the next job can attach its own session's domain.
> > > This is so each session is isolated from each other.
> > 
> > If you do that you can't use the DMA API at all in your driver as you
> > have to set 'driver_managed = true'. Is it OK? If it is why not just
> > use VFIO?
> > 
> > Or are you planning DT horrors to get yourself a DT created "DMA
> > struct" ?
> 
> This seem to digress. All we want to do is use the iommu subsystem as intended
> for the case the iommu driver is not inside the DRM driver (which seems to have
> never been the case so far in DRM).

"As intended" means you use the DMA API and you do not touch
the paging domain.

"As intended" means you use iommufd if you want a domain full of user
controlled mappings.

> The existing infra for that (in C) is pretty abstract an simple in
> my opinion, and built into the DMA API if you manage which domain to
> attach to your device at the right time.

What does this even mean? The DMA API owns the domain, not the
driver.

All the cases using these APIs in DRM and media are troubled in one
way or another.

For example the recent revelation they have always been using DMABUF entirely wrong:

https://lore.kernel.org/all/20261009125338.GB13920@nvidia.com/

Tegra desires to undo their abuses.

It was never intended for things to work like this, there is missing
infrastructure.

> To me, it fits CODEC HW driver which are also simple. The DT horrors
> you refer to seems totally unfounded, you just describe the iommu
> and the iommu subsystem will manage it for your device.

"unfounded? You are not following along, I've written about this now
many times to many different people. Follow the links and discussion
from here:

https://lore.kernel.org/all/20260917144804.GI3196566@ziepe.ca/

If you use DT correctly there is no place to attach an iommu_domain to
and you can't even use these APIs. You get DMA API only and that's it.

You have to do something "wrong" in DT to create fake HW devices to
even give you a struct device to even attach something to.

Or you have to entirely give up DMA API and attach to your only struct
device.

Jason
