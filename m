Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0F22AE76
	for <iommu@lists.linux.dev>; Thu, 29 May 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529398; cv=none; b=RWktbbVq0Pa8GONL4iwARHSmAE/agWDNJh3ELUyijYC6Sn/7N14CLh8TgULgXHQp4GvmWbTGzjlt9Mdy5Ns3HC852mzIwhQKebL6Vv7xzLX+ItELfakpZLSPjUXx5TYz3PK7frEH40rp3RV27Jny+KFLZ3AMbhEfZ3Rvn0N4QFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529398; c=relaxed/simple;
	bh=E1Hvr0aiKuXuUgEPMWVB//h7yGnjN0omlQtZf62bVm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIrI/nR/A/e1YQ/71wyRSJhOPnhzCrc7sRXeFAkqBg9XnSyevhF/eJCK2Txjm/wCgK8FIae0OJD/Xx8pNte8dBvLcBVvGmYZLJlVoBg0eWzDzth8seUP8lpX1zjjmscssf9yvTt4Q3//NQbqyIDiIy+EE3q/3U7mXhRsxKti3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TJOLSMYk; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TJOLSMYk"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c922169051so50270685a.0
        for <iommu@lists.linux.dev>; Thu, 29 May 2025 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748529395; x=1749134195; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E1Hvr0aiKuXuUgEPMWVB//h7yGnjN0omlQtZf62bVm8=;
        b=TJOLSMYkdaYGI90SikQYjjL9lwadbf70ZalfRK2+rDbYHXDOegf7MeL9IlB0zagRoH
         CYRJ6VKNmGWK+a8C7F8yrwHf2fXeBXg/kEPQoWfHU6wBDJc3TFcf6lKkiFEiYt9faMb4
         oS6WkkGCGBg+fHDafxBLZnXsi8oA6TDhRUenzNxV4soaZvgPpHjgCaoOF02NkuffhNOO
         3z9RG1U6/d0WPJ9XkBCG01CRu2qRIMBJv7YcdgPReLZbvI5mioqPh6JMM2s47y7tCCDl
         l/9rX7wSr0xRAT0HGMjKnNaoKPD8JmR2CjaiRul+d+NRfAu9BjKWJTPO2AEuFmpVn0vz
         X3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748529395; x=1749134195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1Hvr0aiKuXuUgEPMWVB//h7yGnjN0omlQtZf62bVm8=;
        b=jKHORVd+eFE46A0BxeTFIEWY5FRkyA+jMI1otxofmMNCsDDW6BA6oAwzTz48yyiQjz
         MLjZ09LabcKOiW+sep0GZA+lcn0FomqPvbwJlc782Ps7f0gbG4eJqhKhsB/oY7fS0Suc
         DpLUxCzrfgahtrOFSR8J6TEaWMMeF+eLOFoUQ4NQ0zezDJlm0aA44NLyl3lW1BDSMTPx
         u6eTZ6SMLH25M3aO6yYPFgKeCgiwdjoXiHG5jkIVce8JTgFonvJRQKUroMO0kV6jCBQV
         GCeWnc45lLJ2EIXpeVRNBMnelvfM5CuRbd8iFgUdn87AF28Fx/0L8JXeVaQZgKyJTDZO
         OpRg==
X-Forwarded-Encrypted: i=1; AJvYcCXjiFEZAPmFX0YrmFg1UzzuLjWfvNOSwZKs8zMhHMi0p+cGCOdDR27MJlakXHGq3GVPCoYphQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEvJRrVQ/SgJWQ2oDxbROYmfu54n9vCvR4OnMs/LN6dtrfkzc2
	U9gWfrnbTN07QOgdc8ol8s90MilbvjZLnVviPI4iL43015htZCmZz9DUpAl5n50Z1RQ=
X-Gm-Gg: ASbGncvIGcNuw9HRyxL4GRx2MQ/KC7azjlKdw956aVNj+fz73tsfI8PmECZwl5LO4tY
	GvDovPQvjLXzmXsnTyk4gSQKyaLp+fwyJ3W5/XguGYSUa159QH6XVPivj8TahkRmzrcaP+aXzTt
	JjLwOp8FmKPaOziK3WnJceavVq7+MKZrd3Ss8Iy0nH9hXLUxxwHYbQASakXOZBWM5uBQq9ZIDHD
	l6O/zv9G3prgvSmgWNtWp/6VzMxoOS/sOi+I9ht8RmBF/TxbkPx2BVEp5WTCn/CYuk0yKs062n+
	Hrrc775QL2CdjSKHDteQfic1q6T106FXSUzOiJ4dIeaLqzc8E0zWtF1BJz5D+pgf5+fFFu4tKEj
	EAKECaEdt/kKcK977+WlW9mzeM+mtznDHPeBnmA==
X-Google-Smtp-Source: AGHT+IGpcYVT5cYIdznQQc6oKOroKWgcBUMZpSmhMxRN4GrkZsGglFNBG5TKOZ7dmu0d8fNzvRGa1A==
X-Received: by 2002:a05:620a:3199:b0:7cd:92:9f48 with SMTP id af79cd13be357-7ceecbf94f5mr3319030085a.52.1748529395150;
        Thu, 29 May 2025 07:36:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a10e3d0sm99198085a.50.2025.05.29.07.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 07:36:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uKeN0-00000000wqC-0IaM;
	Thu, 29 May 2025 11:36:34 -0300
Date: Thu, 29 May 2025 11:36:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, acourbot@nvidia.com,
	dakr@kernel.org, lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <20250529143634.GD192517@ziepe.ca>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
 <20250529161424.5cd95308@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250529161424.5cd95308@meshulam.tesarici.cz>

On Thu, May 29, 2025 at 04:14:24PM +0200, Petr Tesařík wrote:
> Thank you, Jason. You already made this suggestion for the RFC version,
> and it begs the question if perhaps the underlying C API should also be
> deprecated and eventually removed from the kernel.

It is not "broken", it is just complicated to use right and doesn't
fit the sematics rust would expect.

Yes, it would be nice if more places used sgtable and append instead
but there are so many places and many weird special cases.

scatterlist is so widely used and in so many bonkers ways it is felt
to be unchangable.

My advice is that rust should not just have a thin wrapper around
scatterlist but actually provide a sane correct higher level API and
wall off more of the difficult choices (like set_page)

Arguably Rust shouldn't have scatterlist at all, but only sgtable
which is the higher level and easier to use interface.

We also just merged a non-scatterlist DMA mapping API, maybe rust
shouldn't have scatterlist at all. IDK.

Jason
