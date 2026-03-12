Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1CC2EBB8A
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318880; cv=none; b=C4jr+yRyOlMpTKCu7A9UM9/kj7jQirbrc9JKv22ciHij5OBCUVIQjzP1yz7CCchWze6VgIeMX17bWdIEV7YRX6euqnbdteJ8fXyhJx+tZ8D1kbbKfBbmASFh58tar2oROoHvGmWsjTx5SU7tRudd5XbdYSo4UhoIieymdX+/AkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318880; c=relaxed/simple;
	bh=APBW+HdbDJGC0qi66ebGpgzi6a/5pJAPmLFyIpoPoUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4dZQFz3XRnrwxZwbTuF6HbMOeIwqyvyARh1DaYk7J4g23j7KqL90iziVea51af7XKb2xeJoLCD9OEJs3PVycwG2Hn8hYkUTrzzDzEnCZcV/SstIZ33AHhPkWBztFSz0nlEs5TQqTA+STMbKGUNj0+YCq4Vu0gILSbeptwRxvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nczf3MON; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nczf3MON"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd8347d9fdso123626785a.1
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318878; x=1773923678; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULg7grqreMOX2MMOX7z3yI5zs+73GrCTo1UP0N+hYkE=;
        b=nczf3MONJUWYbuFuVaB7tcr9RLMJRoTGRIJkYGUyXK0ybNQHWNhRg0+/s0iG6pnFoc
         ttAeS329vXEIK5as1pnyZW2y2RVtyG4/dgaAt2bD3FyqMnns4ZUmjXEHuJ0LEduoEO9f
         uG8Vfzbdt3T1Uhg7H5+nPaIOgVy0HRwP7S92A2/O+x+DnBx66pH8fzqdjS845WlTHcZ3
         ghfsalJA0n3/TOZP3+k9Z5sKEc75t6W1zeQfhKa+zrwh4cmUUxHyFEho5+FgOrUvf6Tw
         zHlobmFUy2xZqeKWImlj2bs/CUl511geCguJd/ZRWa67D33I5E0SUp/s5F0KAjJKMS6M
         zowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318878; x=1773923678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULg7grqreMOX2MMOX7z3yI5zs+73GrCTo1UP0N+hYkE=;
        b=nBKxD8TLJoV71Noe71Jn3QlXDKd2xEADwRboDPYMFC6l4tkfofAYf/vQW9bgA9xYAD
         ifvLWKGC9C0gnjrQRBO5/9454RXAdAY2BsNcgBs6vzt/l1goOzZ53lIZiGsYhEObztmn
         sSY/wPetqlnNT8lLL6GQCIkAiczJ/YvOfF9QNZBs8jQNHd2afhouPVPCDg6RQ1TH/qEZ
         5cUjQI1JbHbPpIjUNX3IUM7KTc6s1xz/Zc2iSh7K1cWL/nsQAU90jp6gzJIdBqoT42DQ
         DB7AjLUBNT/HVsoq03zYwuohH1hM5i+SLS9qUn54ZGeRoWD67LXGooKHbBpnanol/Fhc
         Xy8w==
X-Forwarded-Encrypted: i=1; AJvYcCU5IGBBxU96edk1tows2Of1bY9Z51g3AmKR5floR0bhdoXD2SRDjlFnGggVUSYSwBE9oYmVhA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7jWbmjtDQii/fcbKJl5W5QJYl298RVG+KtfsRi5pkuSwEqNW/
	BzM2VACGmhOTwYspWFYDd0ZN7lf7sGCIA9+hLZo/o8r4TAWI5hFqaJBbM8SqPcvCl3I=
X-Gm-Gg: ATEYQzxIM67Wq1kXDCydzVMGHYsUziFBpWcU6FUN91bjl+cncObw8kqbyV/uZvblclh
	bKhyycxLW1L/S2ZlS7ZJj3u2j6ld5cM8U/cbJLrphFO4ch1GfoHc2JV9/mNyLXrrzQCWBbSpn67
	WcpxiIU6q+jaD+TIkV2N+phpAhqeS1m4ifR+U4uLsPYIFHjymqbVPBnUQ1jjk0lTV9QZeFh7knS
	MvVrSQ1b0yHSzXnOF5MRrg9HVQFwEK9bGh/P+nqtjX8UrtKVHNtj4+sIVpvM6fKjE2H9rOrCXyi
	5r3SY7fwHLAP6hw34IcItKkwIvjUrW8bm02nTv/jUdPfLE242Yn6TQRInNzJ2kEMp/hpIKzfZIG
	KizhVv355B+gYAJoc/HGhrz9XqKygkEl8bqillrZ+ZD4dUe6KMcoKx+kg/K28Eq/2yWMCv/vK9R
	gCHbOt/fRHjLnIf7zPv75FlSN903aOu1+A6eap6BRfvGahxC748auS4YDNW47zh3zGjTLHs7bq8
	+UVekF0
X-Received: by 2002:a05:620a:46a8:b0:8cd:8938:eff9 with SMTP id af79cd13be357-8cda1936a90mr737651285a.1.1773318877767;
        Thu, 12 Mar 2026 05:34:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21346a0sm323887785a.34.2026.03.12.05.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:34:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0fFL-00000006ezF-1zix;
	Thu, 12 Mar 2026 09:34:35 -0300
Date: Thu, 12 Mar 2026 09:34:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 7/8] RDMA/umem: Tell DMA mapping that UMEM requires
 coherency
Message-ID: <20260312123435.GH1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:50PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The RDMA subsystem exposes DMA regions through the verbs interface, which
> assumes a coherent system. Use the DMA_ATTR_REQUIRE_COHERENCE attribute to
> ensure coherency and avoid taking the SWIOTLB path.

Lets elaborate a bit more so people understand why verbs is like
this:

The RDMA verbs programming model is like HMM and assumes concurrent DMA and
CPU access to userspace memory in a process. The HW device and
programming model has so-called "one-sided" operations which are
initiated over the network by a remote CPU without notification or
involvement of the local CPU. These include things like ATOMIC
compare/swap, READ, and WRITE. Using these operations a remote CPU can
traverse data structures, form locks, and so on without awareness of
the host CPU. Having SWIOTLB substitute the memory or the DMA be cache
incoherent completely breaks these use cases.

RDMA in-kernel is OK with incoherence because none of the kernel use
cases make use of one-sided operations that would cause problems.

Jason
