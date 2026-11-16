Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858736;
	b=jAdgyThipUHGOSInJeqD4sKJIw2u6CjPuPaWdZdaN3JoFEyjXnQrRtwtLSe4QSoBNoWg
	 Waaug30parEMnTevqBOhcP/kR8hiR80WV4Fuk/tiLNYGxmkyMDmlbVPRTvP0oa9fZT6VL
	 PKgr6HxqQ03XncdTc5WyfGA/SynJMIAWdUjU1seuK0wiwdX9+NJVwjTmOmYPE0WTq33rO
	 1DbQd461KIHukwR+k1ldmaJUnyYtueI7JXN8OtljeZzIHkKBkpt7ZsjosuM8p5WID5j2q
	 vA6s0xtzInvDm8Uo1lmWZHJfDDNER/zBgsbcRA1oYeO9AUKPmCMkfBND0yj9ySIiP/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
	b=tmMQpF5CU7hXcUGwgKsuYsCK+MuzkZO2zPdUUqNQH9Do6CMKH5v+LgLapN9DslyDD8Yv
	 jNPNPM3xMl1G6LvwQEaATzkpwbflw+RlnH+Q+sTBRjPcyx3Af/eEw7b736BhDFJr7nzYv
	 N2gQM/Ni37WaVtjYpKOfUcqE86AO+i1iA9SkEmj6kMnES/dGob/QU704FVw0kHpd9TsPC
	 0uGlCKSNtnht5rXt6GK91GxFZi6AfctdK0pYvxcm9SyQWvlJ8OPR5+votz67I9f1ZRb47
	 2bPsq8AXkNpKq4/8fQueFPz7j519SzsiNonJzsKwO7VngMIWWfwGEk/XCG6H20kRZuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kpxOkCT+;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB32606A333
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB32606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kpxOkCT+
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365f9a04c5so65776811cf.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794858735; x=1795463535; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
        b=kpxOkCT+pWM2TGyut5O2+Ru+0lOZm56CgX7wTMMvKGwvUXf11CFtEKxq+aJt3Dbwwb
         pvOcAl30XQLNNLN456CuvUMdJzRpg2P3QlewFHSvcj1qZgx5IarEN/mM7mW4G3kPIlMJ
         Xk+/LtSvsv3sL3luFKFKbVqPL1CxE03Rrqma885QibbVysOD4cQxD+AXO5312yA7/A+z
         qOAYmBHj1xiiGhLeJt9PTH6DwlTnn6CPBvfwAgfQfyJQRp3yPja8F6avaClCHgfJzV+a
         sbTKc6jQyAODlgldvzvlcEwENNU/h+KKCELkDNGLXHCafRzmZWnD+ZqUU0lPkZzigPdq
         fzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858735; x=1795463535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
        b=B8wiY86WYSVFqlFDyEMtczFNRz227/mWmOjptvL48KBsbCc8LJQ6K5W5tpf9XEGXkm
         Ux8wd3Z5gr8rhjOMcFeHDgp5gXyBDJDuXm5jMCS/iLyozsVjFLAwHUlalCSdhPdSK3II
         zJhh81bp/tFLjf0F+wDuwxSmekt/bB9sUfWc3L/qS/8++vOfP7kZNwmopl+9BN/l7Hcc
         7FPwinJ/dF1hj/RIt/amMKwp8hOPkL7VcW8OVZIkXmVIfwnzQRBMZwZfebXzp0BzvUOJ
         puJgZvErJXtMO2hWo79qwh22gM+pf0TUyBvwByrUZAxhYOXj0fa0Grji+g/I2LOKJcDz
         y4IA==
X-Forwarded-Encrypted: i=1; AL+hErHG/7ttusG6z+D9avtCBRrB9cUd9pjZVjT6BsNs8cB/g71ORqa3b0LsZZqyxkNm0WTx+DvS4w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8yRNTgOwb8Rrqo+6ZVTyR5CdDzRETHY5Qxf+kl4GMbwgRHn7nk
	oKszhqagd6dCkGuH6kL2vKw3+9rcUX1ryl00D6JOyqtq89vsJHWb1DI9Y/FLm1dFvPE=
X-Gm-Gg: AYBFou0w6IPQ4tox5Go93FjRmcEvg/9tDc07i6LEUOuVxJgBw5PmbkSEReOZVzu0dZl
	N/CXjEAYQ4c3qxSKJjXTeSJ8gylcRof5h0RRGH2QqGC0XhP1ZJyr83+/9JTC0EpoO0KDBCQaVUg
	aYyWd4dmnzjGzoD2l2YQ4HScALi0JdTgCLRR6cQi2l8PPNmIYpw29v6/FrrXHGGP8P5IwJFeELO
	RBmFvuQaSu5CjKBoRXkBurnejUe7JAuV1u0epzcPAVP1PR6jmY8XxT1bQiDbLNH83P2MnmHxEsO
	NFxrLXGEiJGWFBcaz3pPk7vKbw8BXHQUSkkGsrhGjxRMQ0uFTvo/QUtmflCxwh1VjN4d1JoG6VQ
	WrngtAIUjmDAxLN6glYrw1XOPTMkTY1tIVJozXjFr8WSifI0WSGsDCEEGyrBF+p1H/owQaQO4c/
	zRJqAEKGbPo3HjSiUoV8P57Du6RpluOSjAnzNKlRUXyKCyzFOKEz+Vj4HDJ/GY4wlv+7ZKBrsgl
	tMv5I2c8swy/weq7VTP/jWoWcJ030+ufKUBH+hnFjokG4M4nvvZyieRXjnb0hI4cTM1YcmLYwIy
	fCOLtw==
X-Received: by 2002:a05:622a:13c6:b0:55c:c7ab:4445 with SMTP id d75a77b69052e-55cc7ab469bmr121785021cf.29.1794858734926;
        Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f8319d44bsm48973876d6.4.2026.11.16.11.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2kP-0000000ALbT-12cG;
	Mon, 16 Nov 2026 15:52:13 -0400
Date: Mon, 16 Nov 2026 15:52:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
	will@kernel.org, linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
	mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
	harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Message-ID: <20261116195213.GF2452510@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
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
In-Reply-To: <20261106131829.3228926-6-cui.tao@linux.dev>

On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> that a user supplied queue region is physically contiguous, and the
> page array for that check is plain GFP_KERNEL.  The size comes from
> cmd->length, a u64 that is only overflow checked, and the array is
> freed again as soon as the contiguity check fails, so the allocation
> can be repeated concurrently: a 1GB region costs about 2MB of
> uncharged memory per attempt.
> 
> Every other iommufd allocation that scales with user input is already
> charged, and the pinned pages charge the mapper at map time.  Charge
> this array like the rest.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  drivers/iommu/iommufd/viommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
