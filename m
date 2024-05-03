Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05EBA55
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750780; cv=none; b=qh7K09EXoZVcln10g8wJ85szsallyxKUpI9KljaB9r8Lv/Hh/bZHXXRCzqGiKpbgozPNSP3iNob9tpmJBTenvX17D94DQe0I76NK5exJVQzw8VKEdi+CstNGy2kibR6cOVbyC55pLVVqQic2NHvWgUJZVf2LFEVmN0lhv/Lx6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750780; c=relaxed/simple;
	bh=V93HdGLwMZ7/VJVybupXO0YXtn+XaLniqbxkd+Milzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8pjIg0prTE6Bj9irfr+xMtx/0U/fH6Wph26QChSZEbgld119aD5ZWWjUdKEFlOcC0tkTg0MNq1PPyE6/nvQ68VfjjYsWISsfv0HxbDunKYDYGrA5/UUKmXO67+Rl1891GL7jxvMhLoP5oaxzZhQ+ZDeHzyMrnugLtEa08cC3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=AqzuWbvo; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="AqzuWbvo"
Received: from fedor-21d0 (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8E9B34078539;
	Fri,  3 May 2024 15:39:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8E9B34078539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714750774;
	bh=SpE7/+FxkwXnbNhXpVFjsvlzjuFu6B6sxg+PjjB7/wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqzuWbvoVk1jb0hT3lDNWLZwHevKst58XvtUZUkHItLv0sc+oP1ofyt6SMkJV26BD
	 eiMqjH8xeR/fgshO93w/XjvOdYQbTG1YK80quk52CJygRmCr1PUmlfgSdAXIO/IUjT
	 WArrQDfCfOQksn9zrLLulo2vRilJko5/3GsTCqtI=
Date: Fri, 3 May 2024 18:39:29 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Barry Song <21cnbao@gmail.com>
Cc: Xiang Chen <chenxiang66@hisilicon.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Barry Song <song.bao.hua@hisilicon.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: prevent potential kthread
 hang
Message-ID: <20240503-20a2c3986084e60eaac15672-pchelkin@ispras.ru>
References: <20240502161827.403338-1-pchelkin@ispras.ru>
 <20240502161827.403338-3-pchelkin@ispras.ru>
 <CAGsJ_4zKRSnpoepYsw8qiwVHY-ztWYixKjtD7D1SKbhYho=pUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zKRSnpoepYsw8qiwVHY-ztWYixKjtD7D1SKbhYho=pUw@mail.gmail.com>

On Fri, 03. May 13:44, Barry Song wrote:
> On Fri, May 3, 2024 at 4:29 AM Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> 

[...]

> do we still need to do copy_to_user(argp, &map->bparam, sizeof(map->bparam)
> after  do_map_benchmark(map) fails?
> do we also need the below?
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 02205ab53b7e..28ca165cb62c 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -252,6 +252,9 @@ static long map_benchmark_ioctl(struct file *file,
> unsigned int cmd,
>                  * dma_mask changed by benchmark
>                  */
>                 dma_set_mask(map->dev, old_dma_mask);
> +
> +               if (ret)
> +                       return ret;
>                 break;
>         default:
>                 return -EINVAL;
> 
> 

Good point, thank you! If benchmark failed, nothing new to be copied back
to user, indeed.

I'll add this as the third patch of the series and post v2.
