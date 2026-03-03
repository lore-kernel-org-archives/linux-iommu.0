Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4651F5821
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772497551; cv=none; b=Dx9JkAPghb2b2iCpxC/rHIy1vZzXx5xvHWyBx3swBXbxMjf5Foe6RgGQqMrmzV6Mffd9RFsiodwLs7eKXvE++xUT3vItFaklgSYZ76twr+BYpZWb9rC22rQ26TzrYMRqGHie7MX9IZuFOSc2DBOxyqSmJNdvyBz3VZZDBsyqUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772497551; c=relaxed/simple;
	bh=nLyM2oPF6xKEujjJE8IIxWN27GqEdQwUax+F8Aq6ZL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8h/36HVcW1JClEHohaBM2UktW3y6MygPE4zzK8Le3fivGrj4EsCGavDcATujBwM91/xfH9y7vtvEgxCC0lGs89w6aZHDA2doaQacttpAgnXu+8Iakm58PVfvLrIw6Yi8/iAXL7v9p2UU45xYY/T+KtPQ1PsWf5jCdhXzcP1VK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lVRix5nM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lVRix5nM"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb3dfb3461so509413885a.3
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 16:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772497549; x=1773102349; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zcILp77o/v0Omh/zmVdW5GGMG8Z/qp3ny5THHviWZmE=;
        b=lVRix5nMBsO593m07PQZgjBb22+j8bew72QHLwtFJroB0+DKXBV+Qc2KBq36NrJhCH
         dCU6Wxr+BW3hSpra7rEgrSPhNh3gt8G0gF4W3Ga4xffWSvQVDCfbYv8mccuvrwW/oBdQ
         JEsCD3rAqUDxaCnmaWXGNu4D9KBDYSFuXqrYgS45NDdXhu+YlUgQlQJf0sIWAKqk+dqk
         TiKsxu41mt4EeNPk/wK0XgXNm6q5UIMDBeApBAaEQjQbWrWO2zZfpxv17QRtZFjlXFJc
         vDBaWzAgw3HDxywKvrPkEn7L7W6Qr2XwQZ5aA+pxpkLslGHt7kUKvgH7B5p4HVZC3Acl
         4+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772497549; x=1773102349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcILp77o/v0Omh/zmVdW5GGMG8Z/qp3ny5THHviWZmE=;
        b=O+7pVqD3Ft6FUcSffO/MJGYm4FPX3Emc9ioXcV69ZiuHczLlhz31Hl+q6Nd3PjAWjG
         7g+hi4ODaCJ3ffuHaZJcsl6sdPIN0xupxhUoov/zv8jhHF8L6CyNoNKJb+tCGCaJnVaJ
         vcuLyoj9rI/MSk6xQIb3Coe177xf7EIv9clysv1L7Hj3s0DYVWpSysqXjLOl6X4PKgVK
         0RQcbYcGfk+rZXGCb5opYdAMp7b0kyCrbGkrWfD7S/yz3nJC3e6iLNi9ZjLMWhFLzasS
         ze2b6bStz1tbt33Y21KzArNt6qWjU7GiQA7/Wm3wA7YHCbFICW7o2Tm0v/bREAa9m7Bu
         4hwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkn+5t2aChKM7nkrQ5XTs681Diq6boAikrt/64HWtsJ+gwmep38suGGg3jOtfihf5hALonjg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywrf3w1qTzjZOQ59FlyCiOpgIVVys3fpnObULJQGMEJeaOtHOjc
	wn8YHqnKpZjdUekVt8QW/e1nD6I8F8FosH6gL8X8NV9KWyHDH5oQMD+wUyBzlJmhdZU=
X-Gm-Gg: ATEYQzxaOaykQh/kLr0FUCAM8BEeJDmeJk3yoIIaeBQd3wS7KnQMomHtKAOX+8RcDD7
	/vj4yxCXuKTNsVBOmAQeg7fo0OL5EPu7SAwdWDxIwheK6wDeCnt03NrZSjP2uMZUibeBgZq0NJ0
	bjg/9rv+empxxkT+0EkC03MMCUGvZ9if7q33BpykI6IjHc5Jnajm8uXoEx5o8aN1ehlB3itp3y7
	seroZJNg4PXZweCLSa48M3f07Rlf+yWCAoxTWCl7ExSMFKY2AUiu9ogOPs2vInn8n+wJjc/Cvge
	uYluqafhHKjjdkNFOh2RlU9d4/twQeevGGFqnHrVRCBltQEdL20x6ik1ABxh/aSCAsVDZNgxRVV
	3thHVwhPmsbEiwzD7/veM8X43RqgPsDND+3pR5ayuDMW8TkBfC9R54j1lT+AV0YDT2cnX3wBYu5
	6M4ez5yyMfEiecggGMtkrwdzG3BlvBtnHF6dFIrgcPwxHuSPW2Kg5+Q7DEm0X3mYCCjcgFQ6DOz
	a3kVVr2
X-Received: by 2002:a05:620a:29d3:b0:8cb:5393:20f8 with SMTP id af79cd13be357-8cbc8d70e62mr1797838985a.2.1772497548500;
        Mon, 02 Mar 2026 16:25:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f4fb20a3sm49401646d6.31.2026.03.02.16.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 16:25:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxDa7-000000043J8-1LBo;
	Mon, 02 Mar 2026 20:25:47 -0400
Date: Mon, 2 Mar 2026 20:25:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] iommufd: Constify struct dma_buf_attach_ops
Message-ID: <20260303002547.GB964116@ziepe.ca>
References: <67e9126bbffa1d5c05124773a8dd4a3493be77ac.1772139886.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e9126bbffa1d5c05124773a8dd4a3493be77ac.1772139886.git.christophe.jaillet@wanadoo.fr>

On Thu, Feb 26, 2026 at 10:05:21PM +0100, Christophe JAILLET wrote:
> 'struct dma_buf_attach_ops' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   81096	  13899	    192	  95187	  173d3	drivers/iommu/iommufd/pages.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   81160	  13835	    192	  95187	  173d3	drivers/iommu/iommufd/pages.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> ---
>  drivers/iommu/iommufd/pages.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied thanks

Jason
