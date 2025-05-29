Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B422F37
	for <iommu@lists.linux.dev>; Thu, 29 May 2025 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748479554; cv=none; b=udtSOGvkbsK8RkVd4P88yJOmij2EsDp8Cep+DY4RYH5uaZg2LvbN8tQ444ZyhqaId/ZmMQSSo5JaE7vacYtEEbHg30d35o6p/8Q9UVlzFlrlsV1Ln5sz5E4QkMPVxRP4wIrU+BDn7KN9VlayvYGS3k5GZAD3mC1iTHjCx5iqBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748479554; c=relaxed/simple;
	bh=RBRQJtrU1o/5GEIK3NL3AuJ9HmHI6MTEnzGsJ8BgC+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrLfFNQZbf+I/pVzPSuFvnxnlPU7EwUcZMwXof7+5cNZaxKqgGDqdZ6MHCd4izWceqTbmSYbNNfKZyTp9piLa74fuLa3Ac4LkXMpuEPd8EghUTw+lK8QfTSeHAmbmEMu56P3rBaCzweTZjyUi345cy5g6X1+A0Jxf+DaGsHH5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NKAQB+vp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NKAQB+vp"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47692b9d059so5181951cf.3
        for <iommu@lists.linux.dev>; Wed, 28 May 2025 17:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748479551; x=1749084351; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3lirCGQK/pK/dwoYb1WbV7HzR0WtFCYVJUxyqG54gc=;
        b=NKAQB+vppv8DQ87KtdYR+SEIKevDU0krs2pY0lznstJfbDxMC+fzhK6VPeoqIWwPWq
         Nd31MT+cquwnJNBL+U6ZMiFzFBdJzntvzhrNByVdB4FBDswPL6PSmR/fKfi6VeVPmD/r
         Sy02AWvhNduY/0E3VA1RwlkuoRBrPvAYsAISDRVx6/fSYEptGM0bo0v44KCACTDBvKyK
         oEbWYgoZkhpIn+mwqCpxXxGE2uAyNFFTQS8HK9ECe4i5JdO9czVLnQ2gML5qtaXgmK2B
         ZvTiAY4x2vkVRc95s4HcowVg72ahaFVgfgKY2UNNOlYlSDrECsO+jaxuq4N158Bsr6XX
         +Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748479551; x=1749084351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3lirCGQK/pK/dwoYb1WbV7HzR0WtFCYVJUxyqG54gc=;
        b=tJODycgaDCb1Fw+DCylHP6I1qAckmnTWpXE416z9kiNt8IxNU93+vfaivVYBjzTFV/
         ChSofxnrAYeUzXh2LBhKcpiqHewIxFyvTKVweJ2qaAeretecOwu01kAvThs2wrjXKkkS
         SoBoUEpuRTM4jIa3XdUiRFCo63q21i4PWhd9lTrvPsei5r4Jul6Isj9PkcSEHkYt4Q/Z
         H52OTY5ltQLr8lvr9BLdfqnJcNiYvTIt/nT1qDYsH7KiinQuIZq7YKbZHTXafb5py0sT
         MTiuVEEDMVuA6Et77UH5O+8moMbdB59ZzsRKewHV6GaHduwdRn4LyJNBGsrnVoCXkUVX
         p42w==
X-Forwarded-Encrypted: i=1; AJvYcCUJtS344KjdK44qOHIvwX+gJusFItJJZdAswNzaymFz52Lyd2S5h1jqiUASA1XuJ1xlwCuFpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWhq3QcyA80WlfPqgCg2t2IMCreZCuKEDN3GWcrzQXhPjwLrVm
	b9BfaSGOhVJH1rkWE3SDVWPbV8eIwfWKMIBmC56UosWdfDKrPi+UO+mj0uST3E6s9dU=
X-Gm-Gg: ASbGncumA1wvTUNioyIPMwfzTkZbbbJcLl65gkB5xTo7QBWvadGn6yWY8oT5saofyxB
	UTGPAhUaxe9EBM4ugOdK6oelrhILQ8abaXqSec4/ynGW7b/PveDiJgpYzpjabxP/7kADp9NaigZ
	cbBP+XynrRpzBrQn7mzR1lBQNzQnnEzsFvzoRv5TMxAL60y524zINFooWokBmKd1FjFfwl3Fm8w
	LWCkMo3TtMW0GJ9nKryEITr7JRWcCpdHnsMwgdXrXcz9UANRt3ovk07rm0YjzpKMYH9Mw6vKghh
	MObTMqOVowTBlKsvGaSeWKzIwOLeX60pPLy1TZtadxteHdlKj15SnX+rb3ToAH3AbC9z29ftO8o
	CYZjkZ7yxTxaaLFxHWKdbTrTXj5M=
X-Google-Smtp-Source: AGHT+IHnqnRTolKjMO7lt2c7vFTmLmTqjyLGW4orbu4JZw/Ke3zfhB9aPh390EN0T2RwX/GWqU+5fg==
X-Received: by 2002:a05:622a:6107:b0:494:7e11:fe59 with SMTP id d75a77b69052e-49f46d32fdbmr301749631cf.25.1748479551637;
        Wed, 28 May 2025 17:45:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a633c8sm1683561cf.70.2025.05.28.17.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:45:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uKRP4-00000000qoo-1zjw;
	Wed, 28 May 2025 21:45:50 -0300
Date: Wed, 28 May 2025 21:45:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: acourbot@nvidia.com, dakr@kernel.org, lyude@redhat.com,
	Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <20250529004550.GB192517@ziepe.ca>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528221525.1705117-2-abdiel.janulgue@gmail.com>

On Thu, May 29, 2025 at 01:14:05AM +0300, Abdiel Janulgue wrote:
> +impl SGEntry<Unmapped> {
> +    /// Set this entry to point at a given page.
> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
> +        let c: *mut bindings::scatterlist = self.0.get();
> +        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
> +        // `Page` invariant also ensures the pointer is valid.
> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
> +    }
> +}

Wrong safety statement. sg_set_page captures the page.as_ptr() inside
the C datastructure so the caller must ensure it holds a reference on
the page while it is contained within the scatterlist.

Which this API doesn't force to happen.

Most likely for this to work for rust you have to take a page
reference here and ensure the page reference is put back during sg
destruction. A typical normal pattern would 'move' the reference from
the caller into the scatterlist.

I also think set_page should not be exposed to rust at all, it should
probably only build scatterlists using the append APIs inside scatter
tables where the entire model is much cleaner.

Because this is also wrong in the sense that it destroys whatever
sg_page was already there, which may have been holding a page refcount
and thus it would leak it.

Jason
