Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FEA20FA81
	for <iommu@lists.linux.dev>; Tue,  4 Feb 2025 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679034; cv=none; b=s31BtgzUfWdIajYYe7Xi6qOl5BD8f4+mroMsY42dqO90KwrGifrhiuM3lLMRT0+5JiWZ0q33yqAtot9eRybFRjcp4e1Y30uW7HCpBhsfo6/5M13N9baiLwD6KPnFl9eJpGwiWx1T+ZVN/mfGo7gHTGUOe+U32Kf3EiFSbwT84Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679034; c=relaxed/simple;
	bh=GkanHTg8YJfOIYZPl5qFaUDX3s4sbctMSazV6gA65H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bx/UDXWSQqb1VtZZ4hQ+eLnvaiKgfiCqSMf3hiYQM0CMk8i4MncXUk42WXdT/BD6d0BjzTFPiSIBsFJeJcbpxsDXuzBN+/8IEK1q0gv7KH+LxqWsPMMi/PggR4/3lMLun3v/u2BYlmIcV9z98NlcpmKA6QpURgUNJZSAk5jrkxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3+YRBC3; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3+YRBC3"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2f9c3ef6849so1239146a91.3
        for <iommu@lists.linux.dev>; Tue, 04 Feb 2025 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738679032; x=1739283832; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QyhfawIW6BL9ao0Gk2vDilOwFrFbnNBUuoOSGGmZbwg=;
        b=c3+YRBC391ZPHUbZcdj111DHcVqnqhkqbqKC7s7FkwZINGmPgnE1aWf0GM5SaREUbD
         wbu4+7TfQSwnVvBlUrPvgImRZtiX5yhoZ+Q8FELhW6yhNPzNESoGWzvGy21fU4MslD2A
         Lx8uJO1hhRgc2tRuX0XlJy6Lj0tYWpmEYkuWS0a+KRHuTFvlG85O1CtlnKcLreWRtD1h
         wjzmJFVbbeEUG8tkZYWOCmCxDWQdqcSxzP6kZVSGEFw5eG+v8XALh9+bls4IJD4rcURH
         HrUmt4zTyilGofOLb8eEiT0GFBLqaIqBT9iGu8ZQoTh9Iq/tkaM+P1VvA5YW+Im3z8jX
         PUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738679032; x=1739283832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyhfawIW6BL9ao0Gk2vDilOwFrFbnNBUuoOSGGmZbwg=;
        b=FBj6uf/h34UoLFkyDqIjDbYtBdM3tk/DakWhwnaDxmt+HhA3CcsjZH8+BAll7zmItt
         Hi1kmSvNChsg7hxCS9zBMVGHH7cUsE2FKPPfUItMvjkhLA0g6hSzw1iZvzqQYTI8Wqjs
         c7vmWun3m26kI94JudnO0E1cJB3fOVu/5YaZYyKnrGTi3oRfLEZBjcxGS2Q27JEMEgLR
         qjIV7QmwgvU0Rkl8WaQo861aezROcrW7QwVHYCcGK0PPqaoe5RZoS5D4HoIFj/ghgko+
         DNYqh72jfuWzc9t53Qv2uzjmq3ht4QZ74nf5BlKcxN/JD4J1puzgaQ85lR31zB0tlcQM
         afHg==
X-Forwarded-Encrypted: i=1; AJvYcCVAttQtkhpHA3hi+rYFuxWxn2mS43E7/o7dKQ+2cSPpHA7wsh/7VLEyFTphskWllj9OmJVlpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFdHIrnLHDUkxzmj6pgfa7LauhBfgK9UyaNsUXtjJIvyc4sUzD
	FgRkcj3/Gtr2pLhQ6gAdnDakFG3G8dZ5FmR95y9ZkMGHhWmqsjwR
X-Gm-Gg: ASbGncudloqla/N4M56V5u2qhC4YtUJpKlt1vwD6cnx5WdFrWrLbgxBaRF4rnLM1MbF
	d6V649a3xWhQeeXA9SrUBF7ggiKQSAVJQN3wQihvut8Q3tKPliRYfh0sKnqNzD7x/jXn2XPcwNE
	Y8hD8D7giZQFyzwuPc1rcb0PBandvmdcy87sT3x4P/6JnstCiLdqo5qzhobuELkhdQmPIig/x/K
	1KxSE+bwib0y+D3qvpuxbPBAy198LhTEqAmJcno0DME+ypEw54otKy+UBiNN8x0XOfw/DjSmXPl
	zOuPEOwll0DpMZ+Cy6piCubGQGHn75ftKmzvmfiRqW176rOMBNZ+xxN2Mo0ggsXdysP934y1svf
	3ZDc=
X-Google-Smtp-Source: AGHT+IF0T9oZQc1Tw7DdE7b1zk1AYdK5JS5KIXLtSzoJadaSG6bKYNHl/8toZwcR/pyHhtDXi9GUPQ==
X-Received: by 2002:a17:90a:1189:b0:2f9:c56b:6ec8 with SMTP id 98e67ed59e1d1-2f9c56b6fb0mr3538171a91.10.1738679032080;
        Tue, 04 Feb 2025 06:23:52 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:3936:dcf4:dc64:c1b9? ([2409:8a55:301b:e120:3936:dcf4:dc64:c1b9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bc97d95sm14927006a91.8.2025.02.04.06.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 06:23:51 -0800 (PST)
Message-ID: <c4b8f494-1928-4cf6-afe2-61ab1ac7e641@gmail.com>
Date: Tue, 4 Feb 2025 22:23:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 3/5] page_pool: fix IOMMU crash when driver has already
 unbound
To: Christoph Hellwig <hch@infradead.org>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250127025734.3406167-1-linyunsheng@huawei.com>
 <20250127025734.3406167-4-linyunsheng@huawei.com>
 <Z5h1OMgcHuPSMaHM@infradead.org>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <Z5h1OMgcHuPSMaHM@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/2025 2:12 PM, Christoph Hellwig wrote:
> On Mon, Jan 27, 2025 at 10:57:32AM +0800, Yunsheng Lin wrote:
>> Note, the devmem patchset seems to make the bug harder to fix,
>> and may make backporting harder too. As there is no actual user
>> for the devmem and the fixing for devmem is unclear for now,
>> this patch does not consider fixing the case for devmem yet.
> 
> Is there another outstanding patchet?  Or do you mean the existing
> devmem code already merged?  If that isn't actually used it should
> be removed, but otherwise you need to fix it.

The last time I checked, only the code for networking stack supporting
the devmem had been merged.

The first driver suppporting seems to be bnxt, which seems to be under
review:
https://lore.kernel.org/all/20241022162359.2713094-1-ap420073@gmail.com/

As my understanding, this should work for the devmem too if the devmem
provide a ops to do the per-netmem dma unmapping
It would be good that devmem people can have a look at it and see if
this fix works for the specific page_pool mp provider.
