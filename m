Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1841D6BB
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165551; cv=none; b=RxSuCynzvPNG+vZrTIHXQaXBPXjyxoMsT39eqwR9wu5Y4tOkjUEpzPioiJsFsY9mphSEmFoSJ87U+P18c/J6iFGIrB053gaig43+YUx6nwhuK8K9qDBrZ4o6sgYllgcXtXLZLpz3BIQpWQBgWMlo0gbZJqjcmLtlPU+bEomFUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165551; c=relaxed/simple;
	bh=SKR0y4ke7g6uJ3VfaXAV4HNn1trVq7fWIQgt9S4Hft8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcdvutw0Ot8O9uXbofYdUMpA2y2ZUQ4ClEjYp1nJYsJNhrYOuI+1P8ObvZWarDNZzC08z9HoTUc6Jw5wHKpQvj+xLi/fuTV4YW1s4Lgfr7rAWpriKBoZVLY5XKbeU+6PSSgaccIDlBe+cZ462rygZIAnkMIIDM4OI8HgkIZGXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eDx8OK7i; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eDx8OK7i"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-888310b91c5so26425736d6.1
        for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 09:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1766165549; x=1766770349; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hC/VXab9lpTCQATnomkfbW2pa0Vc9kadnS6vaPWuw8=;
        b=eDx8OK7i4vlB8KV0DkWrO9pyNs2szbf4YVipmlEk1h8h6oxe/EPDuTGtri/a1EQwV7
         nr99rMwTpkbaSot1RO5Fi03pgHgSfskjhl2x1sdmzF+5mv7VJlV6QGjMEIPpGB4IJMc1
         vWlPumTiyiyBdvAt4tjNK7PznLfvgHyDMjEO1GuXIdMTVfo+hoo3VWoYl8iB8oDSC1hc
         6Pdu6m4uGa2PR9Rk1uCEt4GS27cdFSezvKTbFD6ML+Lt/STnmmzURCaEA+ZLnrC4iy4r
         A8fUq8rDlSEzVcMNa0O3fHTbqLI9Aaxh3NoQpLNA6uHZUWR5eeY8FbF4GhblLqWgg+yh
         v5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766165549; x=1766770349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hC/VXab9lpTCQATnomkfbW2pa0Vc9kadnS6vaPWuw8=;
        b=supUlmNM4en5QoYZ8DmwdVFF61qOo/vvv13BD9Pwn0cx1N5pH9JpFzqACzN4yOgFJo
         JO4xWcSaD8Mr9p/Zy49Un0umLVw1aSrzZdvRw9pfrplzCySmSEWXD+mKngmqRpUc6DZk
         BJflRozAawuf7vJ8zV5p+1P2XQwpMkhz0wtD8AlAN6Dzj6fkXPQ4ICdmKtejqKJ+d85+
         JxRWw9arUbsRJnd3kUy8IAzzQwz0zNOjMdpcRHWPbyXfKSxSzRJA/CgiR7Ob+U9pmFk0
         3rnHxvnLrBbTzw+4eaSvf0s3oR19Km1FOnW7rTammuUcsqL6HPAo9x+dmONvo43z36Mg
         vNuw==
X-Forwarded-Encrypted: i=1; AJvYcCUSO+fsg4zXbWSQrCJykMCwsd+5Y5PFhOtEsHdTPBWh9EoSR7sbmOvzdpUmw4IVgOSBUfh2Nw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7qS9kZKtxgeROtk5yRjU1lAV50zmieBw04k6l0i088wTcL1Bm
	l7sgFIS/aDGGrtbcf/56KZGDRSrYmbbUhivnb2LWszkvu/+cQAeMVwIo+iFpIZ3ZJdY=
X-Gm-Gg: AY/fxX4gwl5qb1hhHiAPTFkh5WS7lEyh8DThwd7FM+VuT7giH2W6i5QLwjRfnE3MqJ4
	q2W2Muokhp+Cnyjth8wxfB7OgWfD+I4t+JB9Z6S6QXqWrZ0nq0Fwuou58t4tHsQsOtAf7WtxNyk
	JOhpYXhZaPwK/fAV8ZWDd5oLrIstCJtAdL05nYMocbrm1grS/PJeA4vwzE9K4LvMHnR8WllGPxH
	4deLaYH563XgPzrMmYp+6XLIe8iPJVzNsGLp5huS3HlWSCil6Xk8gtdj4VTXwpHkMCyZBvu2XST
	n2y8exr+k/yPUkRflArfDinKFOeFsVAqhgY9OQrkg4x6VO/7Amy7jB5RoQDuzioefSQWOeo8MdM
	ofM+dGXnDAxkr6HzhXp5+3uyG8gs2hw2e8ar9qm8gzujy93eCEqjCbhOAF8tMV92qc+i7bDoxXI
	7wj0IvC5VJe3PHdB8V/DKtSC27uTkNXzXY3CpGWuZ4jWl56NA8/bI6GJWSgXO2ll3GNO8=
X-Google-Smtp-Source: AGHT+IGYAWh2sxLwizpTExt2w6pCX2ECxkldvqQUVe1MFbSK91RMxz7SwBO+heTsOJkJoalFRECn7g==
X-Received: by 2002:a05:620a:c50:b0:8b2:3484:8e22 with SMTP id af79cd13be357-8bee5dcdd8cmr986687885a.0.1766165548739;
        Fri, 19 Dec 2025 09:32:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d925f935asm23424216d6.0.2025.12.19.09.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:32:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vWeL5-00000001b6X-0xBQ;
	Fri, 19 Dec 2025 13:32:27 -0400
Date: Fri, 19 Dec 2025 13:32:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Will Deacon <will@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v4] io: add io_pgtable abstraction
Message-ID: <20251219173227.GJ31492@ziepe.ca>
References: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com>
 <20251219140557.GH31492@ziepe.ca>
 <aUVje_QZvJ9rjedp@google.com>
 <20251219161153.420d1c46@fedora>
 <20251219151434.GI31492@ziepe.ca>
 <20251219162734.46f3aa9d@fedora>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219162734.46f3aa9d@fedora>

On Fri, Dec 19, 2025 at 04:27:34PM +0100, Boris Brezillon wrote:
> On Fri, 19 Dec 2025 11:14:34 -0400
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Fri, Dec 19, 2025 at 04:11:53PM +0100, Boris Brezillon wrote:
> > 
> > > There's actually a confusion between TLB invalidation and L1/L2 cache
> > > flush/invalidation. The things we can decide to flush/invalidate around
> > > map/unmap ops are L1/L2 caches. The TLB invalidate, we don't have
> > > direct control on: it happens as part of the LOCK+UNLOCK sequence, and
> > > no matter what you execute (map or unmap), you have to surround it with
> > > a LOCK/UNLOCK to provide support for atomic updates (GPU is blocked if
> > > anything accesses the locked range while an update is on-going).  
> > 
> > That makes more sense, so these GPU drivers just flush the entire TLB
> > every time they change it - built into the UNLOCK operation?
> 
> I don't have implementation details, so I can't really tell what
> happens internally. What's sure is that LOCK takes a range, so they
> might be optimizing the TLB flush to only evict entries covered by this
> range, dunno.

So, I'd probably just simplify that comment:

 For the initial users of these rust bindings the GPU FW is managing the
 IOTLB and performs all required invalidations using a range. There is no
 need for it get ARM style invalidation instructions from the page
 table code.

Jason
