Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857904;
	b=1YH3IDYAIR2WlCt5nIhSJ0ohEPIChwAK0zt7oSu3ZFUUBB7EySKg8ZK75iJ/rn94Z5mM
	 aYJPLEf+bcsHzhEtpguulB18SJ6TAdQ/nH6QqM4Q+v74P+K50VdsT1Oon60hAgZmJiiyH
	 3MxiQPOSqPPaW3Ax5cZwGGZcanUopcq83fcDH2MB5Sf3PgXDf0jU2hQdvV7E/dWCktUAc
	 c/NO5YjZu2Ref0TMVX+mqppmNh08i6/omVLq676UGSL77RofY4QuLYCcGi1ADVTe4Hb1K
	 NtiQyLiW/4QrbNusLgfZEsven+RYJGudFpFHq4Jb/tcEl5U3IBXtVUmELj1Oy4svTrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xatal/xzM8Wu83lbCyLkMOJwyZhivB3yqJ6pyXmU5Uk=;
	b=SDUe+8tL3X5teQ57Vc5q9HDTtdVj3cyTWp8JLAZzCIuGJpxq7wuJTgkeJ+0yZKSIttZf
	 EzM6v9G3Zi7K4tdYmOtL45u1Y0GKNyUwq++1CVhu+ssE6HHiF5D48MMqXQxm7xRbpo2lW
	 +caFsBzcV2Ttuj1jvk9jbIkUYnYaeAM/uAdzZJPOgm+UijntZi1C59uxTslaY6oJwPXn2
	 uZVlYbuXWfeFrC/oBjnZqmNuOCm1bZT+WUxYFk+BqCLt2AwnRaA0P1v13ImiAeDl7uAbm
	 o37sRIuKBmnGIbuQ4giA/45AXj2IE9MPQnxjIadp5kmhPoUWFFDxPIMefgASY4s1deA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="Oz/pqUsW";
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF52606A329
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF52606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Oz/pqUsW
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5365d725440so42019551cf.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794857903; x=1795462703; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xatal/xzM8Wu83lbCyLkMOJwyZhivB3yqJ6pyXmU5Uk=;
        b=Oz/pqUsWGsKAilIf/MKBWa2zhzyGIlo5Bcw1f3vJgRtG16ebwCORr65FErvalnfvvq
         sMg2e5RfEROdqxqtXmZ2qZipErL6GjlIGPcJTQ5PUg3xsz0J+hmcoBLI1K7HR/MyobTQ
         BzhDfZ9b1DkJS5bABU9nONIH6faEHtGGxXV7CYyMteacD71NLrTxrsNToD63K8fek8iP
         MmoBfBlVxlVns/CxXDFsoTfUH9qGVnsBShQIczMtVx/oLpunBRd+ip/BDrJN97Cvez8Y
         Mnr/07KXFVovDN2bjs2K1Nw7FCgDr7KWkqq2rDZbi1jTW0eIslZ0ACC+ohUlhh1jVl/Z
         Lhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794857903; x=1795462703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xatal/xzM8Wu83lbCyLkMOJwyZhivB3yqJ6pyXmU5Uk=;
        b=sny84EE/pSh7cxkR68Rgm1lYp5md7oQl1WbeFID1mJ/JXaSJ9jodOkQF7w2W8Tmt0N
         CO+IVwGxUzGs0c72ECmozdHN5EfUffz9lHexvTQtPGmJ0d+abmghSOOHWHs+6yaH8o4c
         vtG7ptuDoPLLcLX3jIegGM7A2PA29o5XUcHeh4a4kGeMw50t8VstNn/R50TuMOUsEckE
         w0GAwHeOYpxGwiwT+0ghFQLNRDMM5fLrtWEW/TgjyCUKX8aLdpczAadLr8qwvJZi380x
         vJ22zRjuYn4qn4Qv1POvQdSWOu4So1LzRMFviH7kyFoW8TV8/iX5fzj2+AkZzBg2/ClT
         s5mg==
X-Forwarded-Encrypted: i=1; AL+hErGRmAm7wrWNrz6WLjzsStfnJyv7Aqdj8b7hAknRHKlF3VYBZWarA8HUieWiL8YAWsP6Ksu+5g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/q+A5w5isszDmi5j3Qfv4ihejXF2Nsg91KqmzkaXl8SqNSLdBE
	yAmPO76CzlHLl5rHFHxMcrr2Ajfouxnqk8N97Vq8PwJTHFEzxgwGO1f0zFQ41wuaGJo=
X-Gm-Gg: AYBFou3WdcESqQrhg5+EWrq4IIEtAnuB3aZazlbtqFq/ivLY5tCFBY1OhvFgssr5zdz
	9WViX/qYQHu+tvacb4wKBKkAZfOOyJG3/Nwr8zcMTrHHv4avl796udHJZ5IUxyguKAjJ/tYREiG
	FmRyGNH5C+z10DKavfshJ7VOpWRb099Dx33MXBoWixHfaiTfS93DMu/nCwEQtgAKJI/OFt6cEc/
	YFRQNs8bJaocm0z6Z8hrW2fhqbCE1SGhIRx50TIQeUnn/cOcjFr0w2izzjrJC/rUSuKB2DFW5Qt
	9dFslKQyowBz49PWXvda6F/Hqn54tYmY42Ij4QWUkoeeQBgthTHH46RiHdKf78N/sTCUzKagCe+
	WMKrkMiJcm5T1Osm/kEC1IGsIX+JmUk7OLLMzA1K6FSkcQ4/p/4lLGl22bvvwhG0U2d4EszlGB9
	HTYdXDwICRKUUZulfsyrE6ffYYFJH3D4hyD6tpbzHSeLamyg9lyU2vs9XoBmPfAAVDF2+TgzIRd
	VF81oI/wOEUQDQRXOvvpiTeG5d9b7/yYeD+wWww7x+w308PzbVcJHlT1r2ar/XW8xj7BTuvZUzf
	sGHmaw==
X-Received: by 2002:a05:622a:1f94:b0:53f:8b7e:c0e with SMTP id d75a77b69052e-55ac755ea54mr198728171cf.24.1794857902540;
        Mon, 16 Nov 2026 11:38:22 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d3610521csm36870131cf.23.2026.11.16.11.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:38:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2Wz-0000000AK3c-0tcq;
	Mon, 16 Nov 2026 15:38:21 -0400
Date: Mon, 16 Nov 2026 15:38:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
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
	Detlev Casanova <detlev.casanova@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
Message-ID: <20261116193821.GC2452510@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>

On Thu, Nov 12, 2026 at 02:00:07PM -0300, Daniel Almeida wrote:
> This series adds a Rust abstraction for IOMMU paging domains. A driver
> can allocate a domain, attach it to its device, map pages into it, and
> install a handler for its faults.
> 
> This will be used by the upcoming rkvenc driver that my colleagues
> Detlev Casanova, Nicolas Dufresne and I are working on. More details on
> this driver can be found by watching Nicolas Dufresne's talk at LPC 2026
> [0].
> 
> As part of the security model, each client will have its own IOMMU
> domain. This is needed as the submission model will let userspace set
> most of the encoder's registers directly, so the kernel cannot check
> every memory access that a job makes the encoder do. With a single
> domain, one client could make the encoder read or write the memory of
> another client.

How do you plan to get the paging domain in the first place?

Using paging domains directly is very complicated, I'm not excite d to
see DRM trying to do this at all. IMHO there are many unanswered
questions how it could even do this safely.

It would be better to come with a user so we can try to understand
what you are even planning.

> Patch 6 adds Domain::with_fault_handler(), which allocates a domain
> with a FaultHandler installed. One handler can serve several domains.

You intend to use fault handler?? That's even more esoteric.

Jason
