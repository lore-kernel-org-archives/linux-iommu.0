Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946859;
	b=e527n6SpXuHxHHvivc1Lbc7TOHnb4sDFmSrebUlYqnpug2Yg1MKMV5UjBtQ5qQMLxxm/
	 uHI/Lzk+Bsnv81tA6tMUQ4Nj5z3PbZX1N5Owc/ErO9hOG3LT8kAFRLnaIQo5F2NH+g0i4
	 8g848CKcU3UmjebUOoLaX6sYQj97eYLnRtFbsgXBa+07AqUQ3TKKiwci99XugFRVJDwr+
	 sr4SXqr51m8AqOl8nkDcTa/Gs0OgRZwBhqJPkvwA9hKCUGNg394I/Caal9nTLS4vqzeVJ
	 YM+uB6btP8wcUHHiQ4nlymptsKKWjrceIE5lPsOg/vbrJHJbbs+j5Rw3BBhvhgKSelw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=wJnPRAtsIC+/lFKvaSJITyDCcMmwBTIjrSEQdzWYjus=;
	b=ISnQs2QHgzTpEmfeAeU/Zs1f2pE2yr3ePqfU3loHuW/kD2qnsmx1/S5M+Occbhsm+iT+
	 4DWLD45bUqpw2WYWVUejobv9PykKoKnq57/Pwst+Y8VwEqwqejrMluEEUoMX6mTcsXGHs
	 vo9FmxRkxCewgAMaWFizoGam2GLKPeq8dcbkeJwsevgJja+VEeYVnENscqbwtZ4luGQov
	 iWyHROQMAJ4uvLYKbfAikY63DDlhpUGp8EpfnPBaqCFscX84htrzaHHFbQhMUbvWA92sq
	 kTDy7D9k/uWkTccxIhDLXhSIxKNcOY4lZN117DFoW2bNSYjENFzXHZpRXHksOYSDNxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iwmZCCph;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F6606A31C
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 20:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE8F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iwmZCCph
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91e8938fd01so976576d6.3
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 12:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794946858; x=1795551658; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJnPRAtsIC+/lFKvaSJITyDCcMmwBTIjrSEQdzWYjus=;
        b=iwmZCCphdPD1x9NpKAGRAkLHGnlZn3QfyJv3qfvp9XPhhRSewqxyZI7v73r3RSgDwH
         WoCzvgoEyD66b82fUx5PV0mYDGtZsqMB2x08McWwSU0bVPqDCdkvt7gmhwsn2ZkLJcsd
         JhisddqNJ1wjNCqZR5B3+1OENinsuBPGUZJtwHsfJ3TuNMs/WtwZ/bFXeiOcVEyEAaTF
         t60LXKwXWB06ooE+0kMS6+Fj9THBJm8GS/SWf4hOryW4k9HUoyjOfltj9X5R7uYCcy6w
         6vLWNZQ9NufRM7LscjCTN5MzdlmcbwtG6NSy4iFk7XiQscs8jvj99KZFGuuf4mwcq0dS
         2EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946858; x=1795551658;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJnPRAtsIC+/lFKvaSJITyDCcMmwBTIjrSEQdzWYjus=;
        b=y4wDZWaYH4lvSuIoIMVbNbHEyqXfSUAXPqP0GsLc6dJ3V3bItv7/IYPm6FtiMZHEQi
         b/M2IAGh6PJzw8xI0cvNzwj73ZTNTQ4JiHtxdimmH1wCHd4V5dPOND+kgmZp4NRBNJKf
         uBAQfFQfuVqCKfBDc4B3iEyA9RLTqTF6tqt8RH1WCC7FynKC853JYHUe1Av1TrRqfqIl
         DVj5YQZDiUMDIqPr+wzVjFX4ABeefAoLsAeejsQsgRdznyT6r0cveY7Byksx4mf3ejgH
         0q/vpt3FcQ7qiktWL5Uc7NGmT90PzIU/gF7BP9GzTpy4JTMz+jDRb/xiWY4vtylRHRgZ
         DF+w==
X-Forwarded-Encrypted: i=1; AL+hErENOaIk/hqzReYgHaYOE3LaOx+hwqGMMIPawLRMWrKV4s/MMzW2DY/vmlUWFccEg9LgL+5Spg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/dVaR+ZI+lXrMyes8xNVBRYLbah0rqi9ikl2hmjkguM585+L6i
	/qn26XsQiAKIYCoy914ckhXNOiHrkPXq0gybnb0dwAvcdE1VXE/DuAcbS5vKVCDSItW8QdOR+j3
	M3C3z
X-Gm-Gg: AZFdTZdSFwvzqQlTPgmN7bwABNfYanOoAEE36Zx+djmKPBgGRL5YBWyyvm/XV6Ewfkx
	Bm4UAf0Sv0J9GxKw47IhWUdgNlUpgkiBplUUw+0Zq3T5/v/gn5yo83y4Ko2wG58EwApi4Duc066
	HDfjz/spqDzRKKsQQhGo2wCnzF9QUi9DrmNHkhHapGjM4aeAzyQ6blRmchAGVFJP5smFWC9hIMx
	cSzLorMvK83diDfzfxBl8AT8IcLLgr2DxsQ0XapmN2pZLNSirfPlKBTF8aT9Gkx1p7nxZmR4k4A
	/Lb9OugT3I5jvPC37x0taOHL9jXp/O8YnrUD8uvTip7UnqTPO1vRdrImqbXt/06pFyriDF9/urN
	pmYXDgpsHKRt4szmlJnGCbCulajUk6ZsN8u2ykO/T8UTHo8rvgMRZxOPmQQ5yBbUVNQMgmINT+3
	fmDHl+AcSpYb6kjRyp+c8DoAJMAWak4JwkNJBceaJV0oaFtCSe4NV68xGbddHcpSPZG1sAuLbbH
	GUTVzpOqOcl4bEvO8Zqq19SBnLUPnIdmn9HBN7slp+GtyFiQAkCXMX89bgdu4m/okNv8JVVGISD
	tNNJdA==
X-Received: by 2002:a05:6214:3018:b0:91e:97a9:cf02 with SMTP id 6a1803df08f44-92114d84a69mr5475416d6.11.1794946857364;
        Tue, 17 Nov 2026 12:20:57 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d70c72sm2569566d6.33.2026.11.17.12.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xTPfj-0000000DL2h-3OIS;
	Tue, 17 Nov 2026 16:20:55 -0400
Date: Tue, 17 Nov 2026 16:20:55 -0400
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
Message-ID: <20261117202055.GA3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
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
In-Reply-To: <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>

On Tue, Nov 17, 2026 at 05:09:11PM -0300, Daniel Almeida wrote:
> Hi Jason,
> 
> > On 16 Nov 2026, at 16:38, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Thu, Nov 12, 2026 at 02:00:07PM -0300, Daniel Almeida wrote:
> >> This series adds a Rust abstraction for IOMMU paging domains. A driver
> >> can allocate a domain, attach it to its device, map pages into it, and
> >> install a handler for its faults.
> >> 
> >> This will be used by the upcoming rkvenc driver that my colleagues
> >> Detlev Casanova, Nicolas Dufresne and I are working on. More details on
> >> this driver can be found by watching Nicolas Dufresne's talk at LPC 2026
> >> [0].
> >> 
> >> As part of the security model, each client will have its own IOMMU
> >> domain. This is needed as the submission model will let userspace set
> >> most of the encoder's registers directly, so the kernel cannot check
> >> every memory access that a job makes the encoder do. With a single
> >> domain, one client could make the encoder read or write the memory of
> >> another client.
> > 
> > How do you plan to get the paging domain in the first place?
> 
> We plan to alloc a paging domain when a video encoder session is created. Then
> we call iommu_attach_device() before a job runs, and detach back to the default
> domain after it finishes so the next job can attach its own session's domain.
> This is so each session is isolated from each other.

If you do that you can't use the DMA API at all in your driver as you
have to set 'driver_managed = true'. Is it OK? If it is why not just
use VFIO?

Or are you planning DT horrors to get yourself a DT created "DMA
struct" ?

> > Using paging domains directly is very complicated, I'm not excite d to
> > see DRM trying to do this at all. IMHO there are many unanswered
> > questions how it could even do this safely.
> 
> In a very simplified way, this is not unlike how GPU drivers currently work. In
> fact, from a cursory look, this seems to be how rocket (the NPU driver) works
> too. Since we are merely porting the same ideas to video codec hardware, I am a bit
> surprised by your discontentment.

In my experiance any place I see DRM touching the iommu it is
immediately suspect. We keep uncovering horrors that people buried in
there. Yes, you can point to some DRM places doing something like
this, with a convoluted struct device scheme and DT hacks to make it
functional, no you should not copy it and certainly not entomb it in
rust. :(

> In any case, we need this isolation due to the submission model used.
> Most Vulkan drivers know their hardware pretty well, so a level of abstraction
> on top of it like V4L2 is unnecessary. Therefore, in order to achieve a leaner
> kernel driver, userspace programs most of the encoder's registers directly, so
> the kernel cannot validate every address a job makes the encoder access.

Sure, but you haven't explained what the iommu gets attached to (ie
where does the SID come from), how cache flushing works, who programs
the mappings, who is managing page pinning, etc.

Are you sure you shouldn't be using iommufd for this, tied into your
driver? It was intended for exactly this use case, to allow drivers to
delegate their translation to userspace. Though that doesn't relly
solve the questions about what it is even being attached to..

> The fault handler is used in the same way it is used in GPU drivers: to kill
> sessions if they fault. This way the driver can simply refuse further work from
> a misbehaving client, for example. It is also the natural place to enqueue a
> reset if the codec hardware is frozen as a result of the fault.

IIRC no GPU driver does that, they hook the obsolete fault handler not
supported in new iommu drivers not the new PRI based one... IDK we
have even wired this up to work this way.

It is nicer if the HW can tell you it faulted rather than expect the
iommu to do it.

Jason
