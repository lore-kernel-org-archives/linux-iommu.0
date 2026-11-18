Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031493;
	b=2tkOHfN16A4PgzosfVfB+D/AqHfMc2puWIag/m3riwMOYNDo14d0dO1HjvAns5xv2Ys3
	 hPIferYJ6IdcfFJhF3stEFkuXD/rA/0/WypTMzgI2hzt6GBcofqvSnzdYpEzY/9TJfMLu
	 +WU2gNntwO+1Upe09tHb774XngBEdCRWtCKLEPdy5w0ji/pHcQ0TtMBu1f7sV95qeRNNu
	 JVtf1YKl2bGI9VzxzwX4ojKViBocgpaS9EHqEGmAhJJSxrxnCYw878Z77lO6QiAEhgfsa
	 rtzTruSXS0ObSzsISDVOWgfKurYpsNDi76B1wqperVM2pArFOKm/WIWVpCivp6qhJqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hFZIFuBcLJ0vIHcol0BdyKUl3oPu8AoNqdKHILyKuII=;
	b=hqnNJjiWyje/KvaCUMO0wSn0IyIeLtKjGiqL5NK9LREsg6JQQuJTXaByhsbMm8NYpcaP
	 n/ElgjxI5Yhw6KUl0zQ76FV73nsEBqOCJqebTT0/Em+NZgZgRUwb5jJv+Ef/2NSivbgtR
	 ZnJ7/Uxu5HwW5oV3ey5MVJmE0qxqbvvwsISJzHD6xeM1t731S1LwyhDxJieSjJ9IaZtc6
	 RJla5K8fNcUQlAvvOaz6UzYoONGG0APMIBNRFg69/GXdD00xor0Qvc0epL9Bk+ld96WAU
	 mdu0Bt+gnaqBtPVzUqYpansuex32g9zWgf5tYvHw8K58i3afSercwAnZnxMqvtU7bLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iZUyw8R7;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40400606A330
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 19:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40400606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iZUyw8R7
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55b8cd4e2abso14032541cf.1
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 11:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795031492; x=1795636292; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hFZIFuBcLJ0vIHcol0BdyKUl3oPu8AoNqdKHILyKuII=;
        b=iZUyw8R7phULKbi0WNODuzP1wM6HLfsE2QcuQR1l7EwsSLcPHegqmMGHZJQMEt+nis
         s7AFec34U3H2jXCbac004U3tqqW/P3kMQfJezhOM5OwM4L4Ps0VEORAEM0FE4QrMVnt0
         tMeQLHO0riHjYjVPzfi9Dcsdk2eF/AL1OAsM36GjliG+3PJjGsrCUSdZdDu0r+PDgo6B
         2dqEqk1OStV8vJNQlNef4YC5dlzOZD7aOt9USeeW9ZvFkTaGskw3YlY8qHZQ3VwSyEs8
         YqnLUsmCXdalZH8idKrCq1EEvP6/rzJkILOe20COXVO837/ebpkxkMfwYmNSFD3SbhLU
         f+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031492; x=1795636292;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFZIFuBcLJ0vIHcol0BdyKUl3oPu8AoNqdKHILyKuII=;
        b=YV0YQKhNGHnPftdI00xEANmtV6y/7Rvm17ljq3gFZaDDiErM/MjEuMsydPOJfrT5ED
         ovKiHeSKloIm84G/gHqBaj0+BJ0FMgBNTCYSyyytn5ezAZSK3xUCRVehBzHxA7hf3+MH
         HMCAsW2nfXbgqeepn7/2MUH3OYaYZPYKOQyVYcAvocVcpHefO+XgyXAXwyQZfIZ8KG2y
         xkuvEHANaynZ6RWX1oJMS2Yj0LLqvak1f2AEOUTcK7wkwuFX5IIvZt5g//HrZJKDL31Y
         5l54eIUjkJVRWQGclFOIyph+Ms91bJDZjfBe0BFlaoVS77TM3G71kp6kVyT04TXqYo6S
         Vm3A==
X-Forwarded-Encrypted: i=1; AL+hErHXaVpiD2VGdK7adoMzJzEobeOQghf7+ya68UOM1RqwP/V+JlQQtXKyXzYsgOMUwI6su8WxZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9+fkJ8Wbi6fTCKhCa4HYKKInf4O4P1uXtTOfJKWBB9xJa6OW7u
	nRzdw1+cLI0TFwJZf4fVEZRtRBLTZTciHlLK3WqqGF/DZD+dSsYkQlG0rVgtxnTVim4=
X-Gm-Gg: AYBFou3aB3bNkXx44V+rttaD0fSejvl4hr5WYWAfpdMkOnxHCgsVdV/u636kyNFi9o3
	lYm7tWKsyBVBp1l3RPXrQIxgsMZYMIllEZlKwmDyE8muCTBD1v7w7MLHATrbrS3ca+XnoFbgJhs
	gdwpJrQucHBQyx3p1DODzPzUcqFZhz0hqGOaTmz04p8tPtro0GGKFWHxQ1UurTHtOX0lBea+d6q
	tH1E2jEr6CrojN+wghnGndEjdihyZ99WGksHaXGpQjdMzCsATc7O41mhjELYDW+xL5W5ezCGuzn
	YPn76wvhRigbQ//SCpu8+m7ZrNm28aTQCKY4q1AwYxKMXVGelnYFDBU/T+SZ33tIH9PWx90w3SQ
	615xwNWeKGZuRv+iaDtL3uF47C26JX4jYW+j6p2X27HmIYTnw2G5JDJSXZlju2kJ54PWuICvOei
	4nQHP4kqH2BfU/mvqo5Nsx3LeN9KchtiwDpGVww+5fpKbMSJwC4YpYpzd6J/salQZ/4iknFnKJt
	euEXkfy/RuLNku+WsDpfJeS7IY7EVvaDJHFK8qYc42yqBcpkrzeZOYEs182Nh3TysGxgLEc22O1
	aUiI5Q==
X-Received: by 2002:a05:622a:14c6:b0:535:24f8:fe3c with SMTP id d75a77b69052e-55d5a34dfa4mr59779801cf.5.1795031492124;
        Wed, 18 Nov 2026 11:51:32 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d98adbsm29661026d6.40.2026.11.18.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:51:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xTlgo-0000000GIH6-327U;
	Wed, 18 Nov 2026 15:51:30 -0400
Date: Wed, 18 Nov 2026 15:51:30 -0400
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
Message-ID: <20261118195130.GE3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
 <20261118160909.GC3115493@ziepe.ca>
 <ede3b421d419a35c115ed584e60e74bfd6b91dff.camel@collabora.com>
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
In-Reply-To: <ede3b421d419a35c115ed584e60e74bfd6b91dff.camel@collabora.com>

On Wed, Nov 18, 2026 at 02:31:28PM -0500, Nicolas Dufresne wrote:
> > > This seem to digress. All we want to do is use the iommu subsystem as intended
> > > for the case the iommu driver is not inside the DRM driver (which seems to have
> > > never been the case so far in DRM).
> > 
> > "As intended" means you use the DMA API and you do not touch
> > the paging domain.
> > 
> > "As intended" means you use iommufd if you want a domain full of user
> > controlled mappings.
> 
> As discussed at LPC, we believe its pointless for this type of device to give
> any direct page choices to userspace. Can you explain why you believe
> differently?

This is what was asked for a few messages back?

> I'm not sure how this applies to our work. But since they are all broken
> according to you, let me give example of cores/iommu mapping we are using, and
> perhaps you'll be able to explain us correctly? I've picked the Rockchip video
> decoder, which is upstream but expose through V4L2 stateless API, but from a
> hardware point of view is pretty much identical:
> 
> The DT (which I read you must be broken and in violation of everything, yet all
> reviewed by DT maintainers):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi#n1400

You linked to a clocks line, I have no idea what I'm supposed to look
at in this file. Can you explain what parts of the DT apply to what
you are intersted in?

> The multi-core support proposal, its not doing process isolation, its not
> strictly needed in higher level abstraction (though could be better), but its
> using domains so that each core can actually see the same memory:
> https://lore.kernel.org/all/20260810-rkvdec-multicore-v2-0-986f89d22cdc@collabora.com/

IIRC This is the driver that had the weird not-quite-an-iommu issue and
there were many complaints about it doing things with the API that
make no sense because it's HW is bad.

                /*
                 * To rewrite mapping into the attached IOMMU core, attach a new empty domain that
                 * will program an empty table, then detach it to restore the default domain and
                 * all cached mappings.
                 * This is safely done in this interrupt handler to make sure no memory get mapped
                 * through the IOMMU while the empty domain is attached.
                 */

But that doesn't excuse this:

  As each core has its own IOMMU core, buffers must be mapped in each
  core's IOMMU so that any run() call can use any core without having to
  remap everything.

  To do that, we use rockchip iommu domain's iommu devices list.
  With that, one IOMMU domain can be mapped on multiple devices, meaning
  that each call to iommu_map() will flush the new mapping on all devices
  in the list.

We have DT for this already, you use iommus=[] and list all your
iommus and it sets everything up for you. Going around and changing
domains behind the scenes when the core already attached DMA API

Then WTF is this:

-                       ret = iommu_map(iommu_get_domain_for_dev(core->dev),
-                                       virt_addr, phys_addr,

Seriously? You cannot directly map to a DMA API owned domain. It is
fully illegal.

> The DMA abstraction that is used by the above driver:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/common/videobuf2/videobuf2-dma-contig.c

Thats DMA API so it looks OK?

Jason
