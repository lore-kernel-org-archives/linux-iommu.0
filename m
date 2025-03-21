Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6E22F389
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577837; cv=none; b=uOW/HoVoDY00OdoyMKZHXnfXEqcgQg+ncsPvOKSO3BuPqqiJLJPrvJoA8dAIKzooNN6LXXxnA80KM0GkOGaka9D+MN/+iizRYKOeNXua9C16NKO5YpmycVrX+9iczSoKAhfCS7tvXNQgop1muDCbCTxCRIXbGLcdB7FaA3T2r7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577837; c=relaxed/simple;
	bh=63kUb6i4KPgRFntoZv3miaEIb8TL1peyDSzJmVeDWRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnEFE+Iyey1JCF97oQj0QETCTwCs7fVyNqF43d/JukeKTUkXbdW9X2PP8Q3nTbX7Jfh0g4VCaoqsJwScbC2EGr+bS1cEsvm9guPBGTDdPzY59yaG/5qbJiwmnPgyvcO9YfYomAsK4gtkqyDqrAK5uSn8n89ChuXoH5FmB4cbbEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hWOwmNx3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hWOwmNx3"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8ffa00555so18345586d6.0
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742577835; x=1743182635; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7cUBiZB6rMMBQ9cEsifqHUK/CE90uznVL1fa3h2l80=;
        b=hWOwmNx3SorsRpKzz7pKRuCLa7qeMkNct2Z8oqfHgcy1DkRQj/YLVZ4kuT7cRe9CQd
         89qAVm1T4NeMpj3H1CbkUlf7Jlv6GDnhJb14ybaQJmXf+mJYhPLdFWFyX6jig/RaSGsI
         EaM/De7YhaUzKV+3dJgCAg/jHFMe89CKZXOX/fd4P9sGw+E9sks0riGu+OnoZ7FDPIAK
         12OXZV13iT01WfaX9GcBAB3GXJLOxTaCZbxZeut+1qycFgoIeMcUhBdIN9QRDle39HX0
         GRdNGF8mVfpKe8Rt0UOq8Zub/ONNEdrLs1+GbmDjURJygVJ8JAQUKuYjLr4UU4BSkzF5
         SjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577835; x=1743182635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7cUBiZB6rMMBQ9cEsifqHUK/CE90uznVL1fa3h2l80=;
        b=Ts/qw6rFRIvCJ3hMwvudMZs9F2YO6n+vlkUHuB0JM3NoqoDS8NFWjSHCel3BsyZ1Wa
         IxQchmNLajvAdKNjQEPu2ZNPfi+PzyGXxfQMxU30RN/5Pfi6eBxt6xLrQV5UrOhbJ3Ea
         g9H7Yvg1eY39R554YTV5gnAIcTbTGGtXx1E+hfDm6Oz3XwNvMQsG3bzPgesV1kBLsQRO
         blQQvh8QcmR9OfigDi+W9tG6n3e35d3Xmh5YqGVFT+zLX6569x+SNB9Z420mVfnHMYbd
         FCbs6TPl+MuvRwRY39v9ypoO99nQa3e/JmFvL+pkHtG1eU8eShOSqFQOxGEK9XFEtpSs
         WNRg==
X-Forwarded-Encrypted: i=1; AJvYcCV6zUpGM5AD24JBKkfI4YcOi/+Vm328T84VVyeez1vea4Ugq9HuOR9VA520CU1MGqZ3Ba0JGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXQxvXd8s9TYWwjYi3fbIYznkcNu5m1vyJcC/XYZKu/Xnm39uC
	m3aouLSp8A32DsU27+xjKJ79/WRJmSyey/gXSejAfkKT6OW8GVsFsMWSLFt/fW0=
X-Gm-Gg: ASbGncvs5AKqjXYHZX6/AHMO/iEEIAD9YIVPCUZ9KZmmB/wp5C8TQGwwsvZ4SoKKTQp
	8fFQCfJ2rnVr880ZzqVBNW3klEzVylHcTLgnVbgedXeYhiuwsK2kqK3cnAWthwkbi0eFf94Kdrg
	7xF2Xyo1h/WKVB/gc1FjvdlhJYX5L/BV25U/7czk51vzI0BOzFcSn0gpFpZ7KnEmynfo2oDDtVo
	BSdPYuUR0u1CxStLXHTR5tCV8HHmuOg+ID+QLSqrakRryn7znL95yBIETm5P2ow1BYuN5gvP6Sn
	ovAB8T1X88l3Gm4ugjl/BPX/EioNhCCd5QGZf5aocDNwjucos0fAZBpl+N/tKNCYREQrAInfhWt
	B5kOaMdgbKdMgXhIRBD84cfg=
X-Google-Smtp-Source: AGHT+IG23S+1v4mPh1NGe2HYPhjeqBlMWVod6kGobo7eDwLg9We7SFMHsjxiwrS7ZSg/ehqUcUu3Vw==
X-Received: by 2002:ad4:5cad:0:b0:6d4:19a0:202 with SMTP id 6a1803df08f44-6eb3f339763mr68882316d6.33.1742577834870;
        Fri, 21 Mar 2025 10:23:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0e76bsm13237786d6.1.2025.03.21.10.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:23:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvg65-0000000161t-3Xbk;
	Fri, 21 Mar 2025 14:23:53 -0300
Date: Fri, 21 Mar 2025 14:23:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v13 2/7] rust: add dma coherent allocator abstraction.
Message-ID: <20250321172353.GO126678@ziepe.ca>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307110821.1703422-3-abdiel.janulgue@gmail.com>

On Fri, Mar 07, 2025 at 01:06:19PM +0200, Abdiel Janulgue wrote:

> +        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
> +        let ret = unsafe {
> +            bindings::dma_alloc_attrs(
> +                dev.as_raw(),
> +                size,
> +                &mut dma_handle,
> +                gfp_flags.as_raw(),
> +                dma_attrs.as_raw(),
> +            )

This is not the correct safety statement, the device must have a driver
bound to call this function, a struct device reference is not
sufficient.

I belive Danilo was suggesting to ignore this unsafety for now, but if
so it should be documented correctly.

Also think the use of devres here is going to be very problematic for
drivers to use as I said in other emails. :(

Jason
