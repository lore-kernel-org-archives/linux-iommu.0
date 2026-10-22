Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699952;
	b=VNCnFwtJbekoLHvt6wuPMr5wk6HSuRfgoptaAhY4mY+eT4a98J5exXTIIuhT6amBf4NN
	 5BZSbPvPeKUM8ipf1zmQYqAxQkUfPF94flf4bJoVKuvgjtsm1qcb38rLydw2yovWPmtp6
	 2mJv6c5A5xHYslfX0urUcYXPL8M67FKYXcHTGfwX4NmX+ymBa+/3uY3fgj7zu7Zh5leio
	 8SR9Semq9bvoPs71nPjwOg+xP3Brsgw3uwZYtppjKa69+FpUv8MuXnYoFmru5QdVFRRrq
	 6ULb8sPZRmm4HTwZw9JAH/HWm7zz5a6P9gNjcGt0Ku53oiYfWWr9BuvHhCWmltIeimw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=I8JrjL/Toni0rgHeKLxMi210agLPfR373jhOEmm9NDM=;
	b=uFQpdwjX9zZw7ACUBpKkDjAEVcKvdtARQAAu634M7Ip3V+x0KShvHH6na2yT2ks8LX+T
	 F2Z5b4tSOBdr6Fhzm+pnUgEExCybe4tradlt33lppUo8p745HsKY0l3N4kP95YDVVe+ff
	 S4s078A3kdjmHxfK8hP75sKzPBkVhfUkPrl6/4s76+AgBDuXkF2v0ghDH/YQeG9e0ypJp
	 G9Qf6vHC8+bXFZBtIukH8UfKxB+bzCpJqNLlDE0y2ifopAk0dJ5O/vq6/3XtphMEvjj5l
	 6+WYiKEyzkj2crMV2uL5Q7I8Ie/NbiBAgI3AyXMzy8svpfi+abVmSatQJ/ROd5FdDZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Hsz2YDwN;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A28606A31B
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 20:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88A28606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Hsz2YDwN
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53648215f9dso946321cf.2
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792699950; x=1793304750; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8JrjL/Toni0rgHeKLxMi210agLPfR373jhOEmm9NDM=;
        b=Hsz2YDwN1KVpLJBEwO4+oW0hjBqdWAlWi76PW6TyL2YIEYJ4G2KC3WlnsqdB304IUD
         Xhzk4XjaHT6vThGJqS/iFFY+afIbMR9u34e96o9CAamy251OOy21deiZNSXtW3r2bJLu
         U0+E1otjePmQaOWZA37BtUXcGP5jyz8SPwAQA2ZTaVPKkaviZ12aMynajyYcpS8zYkRw
         aAE+WvJrI0mzfJU9S3Je83CqBWnJ0aVbErjbPEuisb5K12PQUMa1Z9cV/wP6caaEjNsD
         IohyWDaa7jTOtHyUJDbS1+pY1GyRsJ47rQddyc5bzCflLztbanhYNuV+LKT5Sh0fnb9B
         w/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699950; x=1793304750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8JrjL/Toni0rgHeKLxMi210agLPfR373jhOEmm9NDM=;
        b=LNPYaT7K1Qm1j8GdxnCYHQih4N78NCPHl3AhXp8668oAujv7bLffe3EWxOk3FnRKHH
         vCmKZpEwDloonqK3JB1EBZGAtbVgpBRe1ezM2QAWSu4Wr7bPif+A7U4zE0UU7hp6i5NU
         YKt2Jo6CP5HZrpyg/QViIJUX4GO1YTTrGM+nMxFFEzxwoWQyg8zhMXH4tcofUEGGo/tB
         XWbPiXQG69X803qL+9bD0aXcKL3EjEqbCErGdyoLVjZhypuQj/nseDMo6nV2OK0EFYlQ
         myjvnCggpQeEUrpPj2SsI2FO5LV4l1arAv38FkiLKLdIrtOuSH3Y4do5nzUWSmlvQoae
         GOzA==
X-Forwarded-Encrypted: i=1; AKwUvBx8XccRpI7guy/xMQP7TfqNvIJ8yCtMGzGvCNiaKCspot9SMonknuNefNfxHLNlgjB0IYuh+g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIcavTo0id7RFJO+3fdxCq2wtXUKUNmEx5senunqPMhQ6fN5GSy
	HoG3+xTku7UtWlT3YHXkmIwOmujVsQjUCBDT8IUn5hhKcfSNqWmO+/86RUwg4DzPlKg=
X-Gm-Gg: AYBFou2qjvFhvxb04IoQ35SLZWfknXdVuMt+6dT2aSCzBrn08exgkAnV+cTNyo24TBv
	27n/IuJmnU7ArEmnI/puTryQc51stkctyU5iVSO8Dgf9cnEYt9NK8jlAX9l8c/aIej8TTOwMobe
	9iSxDkzxyTTEc9cFxJMieAbwlCMb6zAKKHK+aXTwKUtmmH62HSByDZtLTd5Xa34ze2g4Ygmdw0A
	tkjKBtoq+Zd7c27ELjXcD4eUKsmxOiocKDrSwuANEPCEFKvw7lu+t6jLd1ztming3bhD/Jxt0Hq
	RRXEHBTEMH+V8/aO0Uv+igZwH9UrbJaYnWGw4wtSG+M9jqyRAmu5fsmfR0vRZuRaRnTjaZZJ6uW
	2wCt71r+Ns4Ln3BGaCEUiv/6+bWW+7JOZG/IVE7D/QpsMTn5oTbectwjfdZJkVO87eruyqQDJ+w
	9IW517ttR3woRv6DC46Z9zao2Baxtgc8wGpvKlpww4fZcUvcMZ9SMRRAOhwA2RaVn8InzGPY98H
	ysFxUqJddB2iJL5MOLgZsseMejK+4yeI9CsjT6WPt3LRPHnA2ed+SU46mYuXyfRqeQpx0ysEA13
	nJDwiceY5qEiuG86En/AItq1SWc42wcQ1kC0Sg==
X-Received: by 2002:ac8:5a85:0:b0:536:6378:c7fe with SMTP id d75a77b69052e-5369b8204d9mr99553871cf.47.1792699950468;
        Thu, 22 Oct 2026 13:12:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c14da10csm1768631cf.0.2026.10.22.13.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:12:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJz9J-0000000FoSN-1XEC;
	Thu, 22 Oct 2026 17:12:29 -0300
Date: Thu, 22 Oct 2026 17:12:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Luigi Rizzo <lrizzo@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
Message-ID: <20261022201229.GH3381610@ziepe.ca>
References: <20261003212241.3432303-1-lrizzo@google.com>
 <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
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
In-Reply-To: <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>

On Sat, Oct 17, 2026 at 07:11:28PM +0200, Luigi Rizzo wrote:
> > We should probably just find a way to describe that this is a POOL that focuses
> > on physical contiguity in some configured granularity.
> 
> Before embarking in a global renaming, I would like to get opinions on
> acceptable alternative names (possibly with a short prefix usable for
> identifiers in the code). I could think of the following
> 
> DMA_PMAP (for PreMapped or Persistent Mapped)
> or, ahemm...
> DMA_PISA (Pooled IOMMU Superpage Allocator)
> both using dmap_ for internal name prefixes

Can someone explain what outside netdev would use this? And why you
couldn't do this in the netdev page pool?

It is not a common workload to have the DMA allocator be the one that
allocates the memory. Usually we are DMA'ing from memory that was
allocated someplace else.

I think Robin is right, this is just a special case of the dma pool,
and it certainly shouldn't be something as grandiose as a subsystem..

Jason
