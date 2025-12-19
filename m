Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4AC342C8C
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157280; cv=none; b=Y8hx1/ioI8V72DHsizX7des8B/1NB8s3EbORMXW0a2o3QezC0Dzd+JKg5qSMd385Yxs9GSvwD1+8ajExKvppemqJrgOcmjubz1kAitip6GP1SKoNQYCTLt4k/X5AYHFbe+NM9gn8yN8lRAaykgDoQR5D/ufjA1FypjaCLttKKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157280; c=relaxed/simple;
	bh=bu+2UhDyr8oNj3zxOVAf6TDIA6PfTPU1OUzVkwJ0dNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7cOtqREn/Gobgm8oMJUkeSwl1k7WzbGpRj5DyV7iY1FUtG+ANGKPOURdhl9kE1fdFwA1KmGFIBV4iO/ymodzw+1ZNsPjECRZNfV8CSiJWuuGLhpPtPJ14qpbx5DJ/P4CoHBORfF7sKA7mTOJekKtER7GLBrBv5hJNVUw5ux2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nmU22FE5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nmU22FE5"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88888c41a13so20595636d6.3
        for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 07:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1766157277; x=1766762077; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bu+2UhDyr8oNj3zxOVAf6TDIA6PfTPU1OUzVkwJ0dNE=;
        b=nmU22FE5zue6JJi77178M/2ykXNfpIvgujAkozcNoJXGyga4osogPGY8I8YHgOnhjq
         SkXfn6tPCQFr9w7z7LB+lUb9W+sGpF0L7nBvZXx0A3YPBvgk+R1KWmCsLFYpPoqDjFTH
         UUSGk+UlrKF5+pGCiEKgRUE5AYJ9DGPutPqqr8gSrI638M91WbF0rGQFtF8tKIewS0wC
         +G+ntfE+mdD9WifE28XD0AWOLsBuc9/oNMdc99w94JqRBNfs2cbdODi8VrpsZP4PX0VH
         K5KLIxxB7UBbUF1ZPdNIulAqRU6CD1VKm1vOeahUz3hfYlSNklizKLEisJJcO3o1KIDu
         iHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766157277; x=1766762077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu+2UhDyr8oNj3zxOVAf6TDIA6PfTPU1OUzVkwJ0dNE=;
        b=kl8PLKQGYD9/JpkXy6Tp3FwD4RrUOvslfOnwiNJ3+Wr9JFP99XjWWTPi0Ul51Y17U2
         Sjrgorlo0zxv2L3ttN+Dx/VIRg3XBS0G4gZJMUKGK+0qNAj7dzaL9XGcBY66DM1HQ+9W
         7FGJf+tAmnmwuKD9EXFQnzNJMT/M73pcGaG3d+zqxxgBRggurqir9AUpi5QnYCEI9vFW
         WuMpQvpI0ozv1nXpOaFwbv/QesdcBvzMqVfMuH0B4vLOaTXRxqcH7CQfsTcHW6493II8
         XPrzoZKdOBtduQnh0BNFd+uHukTPdcPhiE5vMGcusYdxHLs0ym0etivzlS4gLwkGTLIt
         h+8g==
X-Forwarded-Encrypted: i=1; AJvYcCWTNtGNQcWqO2zDiOWSaX/nuQPzkZXTsQtoNmn/1A5N4TnH5A3O5rjZQiJQ/nSHPl/WkQX0iA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzUCeO2YIi2C69Na7SIbP6YgtfUM1w/cE5LvgnDzZTOlwjZrx9
	gbibTvMNedHXXIfC/1aI7+QxP/VSbxwk2GUlft2tgyW3mHobfnACAQbISgyR7ebDhSk=
X-Gm-Gg: AY/fxX5eOGWqDSiics1Xzx56fd8sX+OTCcTk7pR23Gg3WTmW9GZsef41lrviLzmU4zD
	wUSHCo7yMAUWgq44QCdZgt44nqTucUbxBXnInWxOv0s6HQSIeSwyQ39cLh/yrOsMLMINS21HLCU
	nb/BtQiz1byBeEHypWjxvpC8Vo9qAPl02slUYPX8JxS85BUN3tPMI+ioLThS7Pca7MLPBlYlWOW
	neJNMHrqLWdtUhLmnU5mSZMbATRu74hVhlrDTIVAJ88764Lpr1PRJ08sG4PCin5TFJ5vHNU1xYm
	6okRRBKu42CcGwerkYgyGVmFLveobo/7lRUxaxCGAHiEnzGHeUOdBPYF3mbEE7CMPunhOL8/mIF
	+jaYLWJoBA17948lN54SNTMgg4DK8qT5V/zvOyjjOQzYXdE3/27RcBwzpVCXLKb9iO/bakM79Dg
	GkdT7/jQ10J4sMCpfLyKD9RDpnX1dBBMTeH+UprVRSYD4wj8Hc1Ty5d3g1
X-Google-Smtp-Source: AGHT+IFpccyEL+iZKcyKf39srRplzey4v4m0ObAaVXPx8Si8//BYqbNk1PZ+iX8dYDJiLgUevufXLQ==
X-Received: by 2002:a05:6214:23c6:b0:88a:261f:6af4 with SMTP id 6a1803df08f44-88d8404df6amr54276446d6.58.1766157277272;
        Fri, 19 Dec 2025 07:14:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fd14sm20785516d6.8.2025.12.19.07.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 07:14:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vWcBe-00000001YYV-2m7p;
	Fri, 19 Dec 2025 11:14:34 -0400
Date: Fri, 19 Dec 2025 11:14:34 -0400
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
Message-ID: <20251219151434.GI31492@ziepe.ca>
References: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com>
 <20251219140557.GH31492@ziepe.ca>
 <aUVje_QZvJ9rjedp@google.com>
 <20251219161153.420d1c46@fedora>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219161153.420d1c46@fedora>

On Fri, Dec 19, 2025 at 04:11:53PM +0100, Boris Brezillon wrote:

> There's actually a confusion between TLB invalidation and L1/L2 cache
> flush/invalidation. The things we can decide to flush/invalidate around
> map/unmap ops are L1/L2 caches. The TLB invalidate, we don't have
> direct control on: it happens as part of the LOCK+UNLOCK sequence, and
> no matter what you execute (map or unmap), you have to surround it with
> a LOCK/UNLOCK to provide support for atomic updates (GPU is blocked if
> anything accesses the locked range while an update is on-going).

That makes more sense, so these GPU drivers just flush the entire TLB
every time they change it - built into the UNLOCK operation?

Sounds slow, but is a reasonable explanation why they don't use the
callbacks.

Jason
