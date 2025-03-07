Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C6217663
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346231; cv=none; b=qIzyNy0k8JJ5lBTjUud5Sv1NCuvguGRSNADnFGZpS3qjiheRlUu/RtDusmfp4pJxIkGUzAzFTuFZ/X+7btldXpfpf9IIB52cvJwuE+tPdjEYIDfJqZR+NqAKMFJ2uDdQIu5riDAybF3wyHdKWyYP+CfXSW061z6J4A3Id9UUcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346231; c=relaxed/simple;
	bh=phHfA6KQhI9tzLKWRyLl5Cm7ekKU7mLN5aentr1Yft8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qqF3qv59ZZ4EyHaqO+FcNN4zHAe4Tc11FtTMM8mYIdVAaGIPHh6UauglYJ8KeTJAUaAIDY3M+OYfa/JIHql+dvM5p21WwQsVZD26LzXYc2oH381YTIOxTHFTITPx5W15Ia8eAHoRXMmA/lbyj2/vQcBtDp30tnBy2qcm1tmit0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ty7PPhW9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ty7PPhW9"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so8133255e9.3
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741346227; x=1741951027; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NCud3YDrS8rMqDriMRjnUp9EmgptAXkjuXyMh39DeE=;
        b=Ty7PPhW9ayJh+Jdn+qeyvCQIsF23PPmi3Z39BbrkltRoOMrht49yftRyqjUTrsXeW6
         PuRx8aMSi5IEvTaNpAzKba7xa78FOCY9scsEiQbhtSWe0mJtQ3CzFRhcKhplTwSOLeLT
         kUG56GHKBGYpJs8LvWmDCGvGNYR9ruZqqIUE7iDGshYiw7AR0FFvXkWhs0fOFyJyfi7A
         pcmk3EwfCtoIX48jyApBF3hCmGleuKLAnG91vbkhxfSNkcdVyUCOQQQKXzbBjbz6qQbO
         4Z/HY+PU0frcMTWnr/Xxo+CUWLWqx0fPqfhvz/syL8hU6X/WUPmxW/qxeHiGrXIDJFEV
         0bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346227; x=1741951027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NCud3YDrS8rMqDriMRjnUp9EmgptAXkjuXyMh39DeE=;
        b=NqoIH4sKWslt3g92b4Ccj9ty2GqYcHltFzxUgV+V8xFAN8kG/YVfGXVUw/z3bQ6EAh
         Oulxt/eXOzlKeEaHbYP+kG9hgHBE2FPoFWxM1uym70t8UZ6XN0EkX9KIHG2bB+8iTtoj
         t/9ZgxHtg7oVug060dSWfsvZjkSPRl15NqTYD4p/CBf0TA1+TEPeAteDBcByUNlrEU0W
         Ia8CCTGQS/ZKSijGSQI8Gt1NaypTZq9zSd/DT0e2VDZSD5i7BQt+MwY4gTkPfDvNWIuN
         tQluHUGOizXIpgFhqND4gwq88n3v45UtAlCbLRJSC9cDMiNsQqhHxnIfT7QMEvWiYzxW
         xXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMs8/x7Hou/LVuHerV8rZ2dsSMK0yF2xo4rYGbkgu3iehR5rX3xMA9PBdDk0sWi6iyAmHWGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0Z39LjnZ4w+OR3LF2kNzU+h1lYEcyM6SH5G61ELiji81619ta
	cvrB/AF9WTaeIFbznbvMCbgrO1Wc43H4c1AC25JOWavvM8D0MFUouEAoczmr2YfQ1I8wnZtfStf
	y/qpSzxtXVCc+4A==
X-Google-Smtp-Source: AGHT+IH5/jQh6E6kSDoYmzpqJhrOtDcnc6+Obu9PZ9gPPi3bYRV7MA4XFxyIILhgKXpg3G8LM6+X3I03hodwVqU=
X-Received: from wmbfl11.prod.google.com ([2002:a05:600c:b8b:b0:43b:c7c8:d3ae])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c9d:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-43cb91c5830mr14428465e9.3.1741346227107;
 Fri, 07 Mar 2025 03:17:07 -0800 (PST)
Date: Fri, 7 Mar 2025 11:17:04 +0000
In-Reply-To: <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com> <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
Message-ID: <Z8rVsH_Hl34GUjOo@google.com>
Subject: Re: [PATCH v13 2/7] rust: add dma coherent allocator abstraction.
From: Alice Ryhl <aliceryhl@google.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"

On Fri, Mar 07, 2025 at 01:06:19PM +0200, Abdiel Janulgue wrote:
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
> 
> A CoherentAllocation is wrapped in Devres which basically guarantees
> that a driver can't make a CoherentAllocation out-live driver unbind.
> This is needed, since DMA allocations potentially also result in
> programming of the IOMMU. IOMMU mappings are device resources and
> hence the device / driver lifecycle needs to be enforced.
> 
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

You might want to add #[inline] annotations to the various methods, but
otherwise LGTM.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +/// Helper function to set the bit mask for DMA addressing.
> +pub const fn dma_bit_mask(n: usize) -> u64 {
> +    if n > 64 {
> +        return 0;
> +    }
> +    if n == 64 {
> +        !0
> +    } else {
> +        (1 << (n)) - 1
> +    }
> +}

You don't use this method?

Alice
