Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42633507E
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495906; cv=none; b=dsvcCnhAM4+g6mcm1JI3UpChRkG9Ak7ZTdtbHPhgBsXLrQWBgnBph7VPWamnZlfQW//+IGxe4viEYHi/bRUO8q/yUf0yLBiUNDQV9u7jEt5lDAyB0J+5/ZhDXWKoKhoaiV/IwkP7JzcjxhU5LnM6it6WNDsqTNv8uS4oXMivzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495906; c=relaxed/simple;
	bh=tExwCrlQi12nQx7UkSsrhpcEHdMii7nWl7VBNzVsTvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klpnYqioQw4eNbwnIh6hvRQsHb6VGS5wtcwjPmloCgo1jfeAJygvBjVRrDsWGUV66elz3gjZXxzqMdpRt6of8z5tfxv5UvDrAEY/oUs3iH6zfPhYbZME3xYlpwr+5/70yTCeGeziqxsrPcMOY37mDNbHNpFrByd8iDA8WlkVWb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FjuxtJCA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FjuxtJCA"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cbb2329e7eso524008885a.0
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 15:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772495904; x=1773100704; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9pGflp+DwWVxkpRGVZHn5Rq2Zi9Zui031IX+gYAIi4=;
        b=FjuxtJCA3mp+eNhOXTbu0WxiKylsoXT+32BnfzlcIzOjiUtKcP47kMzJPVn0iLmPUG
         gzxy4m3LI/Gevz/ch9+bG7pFuU3kDvaZnJka9qsU3DMXTMMXiURejpkdV51FnSkSdLzL
         ehnRuY2eQJasI++DOu7Rq9ymkIgPwq9bYuGHc4UbPuZ26rSnl7IBYqrSh/N8qYpZUdZv
         eS7OVTBFAu7/JxgOQA2x+Uuk+JMuHWYzzw1YTD8N3Q7ARueHbq6adRRq2EZ1i4qrKMpg
         C1hXnid7dV9R5ORajkDwJU+jZBY1bFllIMRCCBPCF9Tj6EtBWpIXFWZGOupf2/nHjBJ+
         QxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772495904; x=1773100704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9pGflp+DwWVxkpRGVZHn5Rq2Zi9Zui031IX+gYAIi4=;
        b=w7iJppxbWyhXRmPmqaJ0cmmbNlG9lvwdDkfVLNkk3OggTZhKIsGwyuRTNo84YPdIbq
         /kBLb2PgO6aWEG6smfqzOrL316ThxOWDrW6dQws5PGNrZ33go9qkDDH3GmIPHNq0EvaS
         +eRA6c65UZZE+fvRZl0W6CayVOyxdXlNuyc7vfTtKCwwuSJWLgsAmgakfTwazDykrtGx
         X1/YnKmv/9b7T60VtFZJoHAi/A7SU9M9cr4tj8BiQfwguKEVWPSQrog9+rNZqKzRLSsu
         TvCcfmRA+V6G0tzI6xjn5y4THly8I2elP4Z37r6x/exXs/hUm/p8Ekqb4XeusdyBJXVY
         Exhw==
X-Forwarded-Encrypted: i=1; AJvYcCU9lJo8bmDKJcD95IX/K/H5LE2mkAzeIw2g0n78rSd8E8vu3rFatphpqfcNThikvxs3XSID0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3Ytseh9xXapdyseHrTBy49PZrZYu4+ucTefT/lAEKjBCp768+
	JQnuqF5c48fiYLvMQp9D2p1PA8hDXsXWVWMLZLcX+QqKIOyuejpw4Ob1h5FbJf6azZg=
X-Gm-Gg: ATEYQzwZ96WHu9tvDkeNMyg+cHoblMwuPCP49NrlUOTIx9ASaLkPcs87NJ3IvJpfCfh
	+sgjBGIYDQXljJwMcrHjNCdGLHcU9wZfPdci42X44y0/vfmRBTHVl2gt2SR3l8SDENwNIhcAOhQ
	56D8TsIf/eQyzmKCO2FXwDDbUpshSzDSMFcZskv+NS0GpcavBm4C3mNTNXKgAkttYw6HB8hjVgJ
	w4gCtx15WQQLyhY1CIWn+WdEvgTfNTCE8JnP7eyK/ZfDwUyt4UXZ6ZQMAx3u7Y67GhEoMGpYt81
	B9oAuDlFRgDkQ/qhIErqcUJntl/ld0Xax+2dL21p7PsxqUjiXNDln69X2YAzs1zvutjXeUqAnfB
	Av8xqdum6kqcoRDsrQWN8vVIp/xwZSqOaMZW3+VKFHxSUwPzyr03Pnt/7MSuSnlOmakPJcqtGwQ
	iMjPF/+Fu4xq4l5mCuqKsGxNyCYPWtJlx7CejuiZG65z0anJk19wwh+/pcs03IlB+DQMbMxGPDR
	jKEJm3V
X-Received: by 2002:a05:620a:4801:b0:8cb:4066:7acc with SMTP id af79cd13be357-8cbc8e4b74fmr1770386285a.50.1772495904463;
        Mon, 02 Mar 2026 15:58:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf66f31asm1236972585a.15.2026.03.02.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 15:58:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxD9b-00000003wmd-1qhh;
	Mon, 02 Mar 2026 19:58:23 -0400
Date: Mon, 2 Mar 2026 19:58:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/io-pgtable: fix all kernel-doc warnings in
 io-pgtable.h
Message-ID: <20260302235823.GZ44359@ziepe.ca>
References: <20260302005214.3469521-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302005214.3469521-1-rdunlap@infradead.org>

On Sun, Mar 01, 2026 at 04:52:14PM -0800, Randy Dunlap wrote:
> Avoid kernel-doc warnings in io-pgtable.h:
> - use the correct struct member names or kernel-doc format
> - add a missing struct member description
> - add a missing function return comment section
> 
> Warning: include/linux/io-pgtable.h:187 struct member 'coherent_walk' not
>  described in 'io_pgtable_cfg'
> Warning: include/linux/io-pgtable.h:187 struct member 'arm_lpae_s1_cfg' not
>  described in 'io_pgtable_cfg'
> Warning: include/linux/io-pgtable.h:187 struct member 'arm_lpae_s2_cfg' not
>  described in 'io_pgtable_cfg'
> Warning: include/linux/io-pgtable.h:187 struct member 'arm_v7s_cfg' not
>  described in 'io_pgtable_cfg'
> Warning: include/linux/io-pgtable.h:187 struct member 'arm_mali_lpae_cfg'
>  not described in 'io_pgtable_cfg'
> Warning: include/linux/io-pgtable.h:187 struct member 'apple_dart_cfg' not
>  described in 'io_pgtable_cfg'
> Warning: include/linux/io-pgtable.h:187 struct member 'amd' not described
>  in 'io_pgtable_cfg'
> Warning: include/linux/io-pgtable.h:223 struct member
>  'read_and_clear_dirty' not described in 'io_pgtable_ops'
> Warning: include/linux/io-pgtable.h:237 No description found for return
>  value of 'alloc_io_pgtable_ops'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> 
>  include/linux/io-pgtable.h |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
