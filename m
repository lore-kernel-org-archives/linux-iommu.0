Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7221891AB
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616630; cv=none; b=MNRWAdywV37XKZZtbsUVHJBh4ZRwvqshHT1IHr9ivGMY2rDOWalxLAAICVQE5MAOm3WaRFBH9CL2RAqYwISbOwNiC6CVoNqZ/Q1O3G4LLRA3jM67/+lKLkp30mOybnSQ7rAxxUTsYd5DkTaZ7lNBFSHAXXYs0BHpU2TjxyYQxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616630; c=relaxed/simple;
	bh=HGRPVLu6Tlbf8okATr/kZX+v/mGty5hiwEauJPQTAPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X78SgZe3ufhlpd5FHP5FRiXJXHiqq9ymMAU1pg4T5k2r0irmpMAv7gAqzX1YfwSZZFkuP7YhttzAr8tCftx+IhSaJOUkXGx8jVJiqXfWzxpfusenwfRdhpFU8ZLwHli3aCSj4Wk7ClAHlAp6wEAzEWdsWztelFooP4QYlQ4yZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kTwbjCnJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kTwbjCnJ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476b4c9faa2so26969211cf.3
        for <iommu@lists.linux.dev>; Fri, 30 May 2025 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748616628; x=1749221428; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HGRPVLu6Tlbf8okATr/kZX+v/mGty5hiwEauJPQTAPw=;
        b=kTwbjCnJvP90V/KsbkYG5MlaCRHYKYvcG6qyYbCgZkeToTWVdh+hsy1jwTkaRem+k1
         qPDN3iFZ3t7GPmLRLufbpMQi5/hmr8DxfAfHjAgnXRjLBUiKIaWAs5POWO06AdqPzuKO
         5YRloCDh5tAN+piluvvVIUIKRdy9Yk1uyMXkegwTemUdDVDnlKQdi4CYD/+pTlXc0GXk
         8KOAZ6bRdPn+0vRky53+ftJCpoSG+TIT1rCgkluGJj0YasJGpCZyqCOVvpI/CiUwfm1R
         fJkcM6zLavbpV9ChCXF4/lqPdwRILjyYMJvxNzVhi6+OC0+R3G+EtuElS6ZwLn1gK8mK
         h8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748616628; x=1749221428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGRPVLu6Tlbf8okATr/kZX+v/mGty5hiwEauJPQTAPw=;
        b=lR66Es6ggO/ypTBfaRpeXEC+UunsdRBrPCNz/HQm/W9oLQNjoxZ2GLkmvMN6g/RxoL
         GM4eA5sJrm8iKa6H3Yc00EfcHoDco/nIchFcrrS3VsL3kKP2HIy4f1YoPejXC1C1wwXB
         swXAVJE/WEVWykiTq0LhvzDmA0asZQgLR0jYonfcbWi9hDAPdYbi7hKcVsZ8Vlhp30dD
         UMvo5I4UpmMboj5czWLaTQ8HIwTochDWpJQFBGpBPGyFT9u2VlFFkZT78Z3N1r/8+erN
         yEdSyNnV7ilUW8RyP4GDaiVaHGLgnS1FDFxW7YDQ6wREvFNQn5LqWvbMXPDmBearG8sW
         yRNw==
X-Forwarded-Encrypted: i=1; AJvYcCUekX6e2pdU0/O2+xARc66k/BmxnPWdM3DL+51/6XsMgzZwh/KiaBVOrcI56I783VW7ahbR5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0zgq/ti/E3KFY26O2Q1GMUjZE4heuCi79PUXlY6u+vO31b1jm
	GhHfBc4z8qcAra4VXmARxUkeeTxjQO+9RC1tRIXUJUG6si2bAfkJiUFM2HCwMAz3gcg=
X-Gm-Gg: ASbGnctYarlg5IttjgWfF4kSScEw/bYD7EXL+r7g4TYFLX09CLY6YjgmWH9miA7YNAc
	rfCtuFipunmOn4lH72ozR8VDPkyvjgn2m0EvGSCBCXIr1e5HCjHkg1MgJhlpJDSRrsWGithFtu/
	0z3kZ/KrdPBJTagEDOZuoPoovpj3GwF9DyNzieN2/MnMGGd/CCcF03rP9BKKtXips5+uoAcDoVq
	k7mJqaeVZqTEawV7qiCNeuTfF6H9Fnmeba1baeCWwiln0j4AIybvC6S6kJsDpO4uGdeWrr3DyVS
	VTyeXLF/C7qTMsPHMjQePSTyzA/tdHZENsC8ZagJQvju/j1RveGdy6HIkvDHoPm29jtKX1P94qI
	y72IX2hsGOx31diKCouto6aTtNZFPU2UxTieTnQ==
X-Google-Smtp-Source: AGHT+IGBTeaFU7Lun0cxRzLoVYefmxYGwMLzyx7A2cdWFaW7Vade0KEgRRURnWiOg3n4NiLrm3GLmQ==
X-Received: by 2002:a05:622a:229f:b0:476:8f9e:44af with SMTP id d75a77b69052e-4a440074887mr56369431cf.29.1748616627920;
        Fri, 30 May 2025 07:50:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358ada69sm21450411cf.29.2025.05.30.07.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 07:50:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uL13y-00000001F0K-31WA;
	Fri, 30 May 2025 11:50:26 -0300
Date: Fri, 30 May 2025 11:50:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
	lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <20250530145026.GB293473@ziepe.ca>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
 <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <20250530141419.GA292183@ziepe.ca>
 <DA9KQF9CY77R.77PBMU8Y1FPY@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA9KQF9CY77R.77PBMU8Y1FPY@nvidia.com>

On Fri, May 30, 2025 at 11:44:26PM +0900, Alexandre Courbot wrote:

> I would be fully on board with a simpler design, definitely. The reason
> why I've tried to keep some doors open is that as you mentioned
> scatterlist is used in many different ways, and I am not familiar enough
> with all these uses to draw a line and say "we will never ever need to
> do that".

I think it would be better to grow as needed. It is hard to speculate.

We also have the new two step DMA API, so it may very well be the only
use for this stuff is very simple mappings of VVec like things for
DMA, and maybe this all gets rewritten to use the new DMA API and not
scatterlist.

Having a rust user facing API that allows for that would be a great
thing.

IOW I would maybe reframe the task here, it is not to create simple
naive wrappers around scatterlist but to provide a nice rust API to go
from VVec/etc to DMA mapping of that VVec/etc.

> Like unmapping a buffer and remapping it later sounds like a plausible
> use (say, if the device's own DMA space is limited), so preserving at
> least 2 states sounds sensible.

I don't think so, there is no such thing as a "device's own DMA space
is limited" in modern HW, and if it was a problem you wouldn't solve
it by swapping the same scatterlist in and out..

Jason
