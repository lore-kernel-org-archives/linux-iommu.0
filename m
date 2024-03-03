Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9A1E499
	for <iommu@lists.linux.dev>; Sun,  3 Mar 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484227; cv=none; b=rhwidLjYgJIzpPqt7k/Uh0QqBOrApdYgNs5He9kMeZXYPYkw4kVQ6eJ6sf46AVAEoR02DcBy5Z4ExSx5nhZe5g5OWf82W8rqkQfVuIDNcw6ClP7mOMs9gaJOUkHpRYUSw4MYvZvYzQqLAU7STcjbgIXAh6/gTq5Y9aNulWA2Xhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484227; c=relaxed/simple;
	bh=AylZCUlrBr6sCkdNJuqFPFI5HrOKw1Lt/qRw1U+EUO0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dzy8/M1jH8aKl90/HEd8QfO8Lm87/LcUlle611cIJX4SfahHgUeQ9egrUNLBVnhXa2rmXQlpB2058IzIARo+vJM6uZBzFWoSVZOAPxnZ9G7fFbGlh3lUptaIvZmQ1OlFUTKMFh6+RDA1VU9dsLELzcYYBi+WxtjW4Qmb+Xg2PhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc4h6wuH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc4h6wuH"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so1990085f8f.0
        for <iommu@lists.linux.dev>; Sun, 03 Mar 2024 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709484224; x=1710089024; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikfe6o+inj4dMrhzQCM91BE0ram1wt5jM+ElrBh+ocw=;
        b=Lc4h6wuHDoo622B06wWIroRIsnwWhOJzy6e/0FSa5oHzKws6r7CUCk4v5DDADdYslE
         IdIORoc+/BnZO82UrcNvif0AoT4/VMoOSwYbtlQ4prCCRSgzDhAWeEZgSFBc+SOf8RJZ
         sBtWONYU4XNe/tanPieD3KZVGJaNv6HdxGM/iwxjbGSmvLQuJVO/fRakU5Rw9kBZW8Kw
         xZYzF80Ke1ruVI8iSrBMVTkQXkLefmyfGcXHBbu4FFzlU27q2wBecFBCnZF/YqSWkw81
         1I6/IbVmH7EgbWcjGB1vuRX2Rsyhb81Ve7oS01O2jHc2zUNYtNLms4GVh+t2pFzcPpWo
         ylLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709484224; x=1710089024;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikfe6o+inj4dMrhzQCM91BE0ram1wt5jM+ElrBh+ocw=;
        b=n6x8io00FePb3STiQxQ6wqlbh7SJL6kiNxlsVXEdlfiWQNI/4+sYynS4TMlpRaLfJb
         +UeMdXH7sWQvLvE9RI3ydvzBO0Fq6NNTGvFzJyrZd15W5v0fl3iBmKhh8q+dINf1v7RG
         DbX50LtJ91E2Sk13Licb4MCpTCDYgDfMcU8H/5HJKi5Sg8/UPUt9Mfn5yBYyJbovxpqM
         HNGgWeDz5sBhFciQ8DC8B4IcqsyE74CxzQzYzu+SBTGzKNCvw1PkSgGBhj/NtZ9cbbzp
         ZG/U1bP9SS3Pm3baN36r2mCWhDGJkbiapZw9ySmcLM0ZjIqLV2rxWxHUVTCi/bsansuz
         9i8g==
X-Forwarded-Encrypted: i=1; AJvYcCW/j9Q5p3ll26Jc7XmYIAVSKCThU98z4DoXo6Ab022rg7mqPLPx9ug6ykDiZDJdWlDUEFnzg8akuKWYgMuxu851WvXdtHU=
X-Gm-Message-State: AOJu0Yzczp+LTsB0OrZYZne0p2UE87POxiWqm7ibazrwReNMhgRBjTG1
	BtiAK3L8fZEjce2ycWwr6m/GKak7yKatxUD5pyPX420ALmdTjbMQ
X-Google-Smtp-Source: AGHT+IEan7Mnlup0Dsmz/hl+Nfxoss34Q+iDIhW40VewxV5OR6PZ3luhS7QypruxneaihlG33uJrxQ==
X-Received: by 2002:a05:6000:12c8:b0:33d:747a:1e94 with SMTP id l8-20020a05600012c800b0033d747a1e94mr4376321wrx.41.1709484223538;
        Sun, 03 Mar 2024 08:43:43 -0800 (PST)
Received: from [10.8.18.71] ([62.214.99.74])
        by smtp.gmail.com with ESMTPSA id cr14-20020a05600004ee00b0033dd06e628asm9995441wrb.27.2024.03.03.08.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 08:43:42 -0800 (PST)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <be75fe5b-9901-425c-8dbb-771dcb084e2e@linux.dev>
Date: Sun, 3 Mar 2024 17:43:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA
 mapping operations
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <bvanassche@acm.org>, "kbusch@kernel.org"
 <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, Christoph Hellwig
 <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 "jack@suse.com" <jack@suse.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Chuck Lever <chuck.lever@oracle.com>
References: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
 <20240227113007.GD1842804@unreal>
In-Reply-To: <20240227113007.GD1842804@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.24 12:30, Leon Romanovsky wrote:
> On Tue, Feb 27, 2024 at 08:17:27AM +0000, Chaitanya Kulkarni wrote:
>> Hi,
> 
> <...>
> 
>> In order to create a good platform for a concrete and meaningful
>> discussion at LSFMM 24, we plan to post an RFC within the next two weeks.
> 
> The code can be found here https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dma-split

Thanks a lot. I will delve into it. An interesting topic.

Zhu Yanjun

> 
> Thanks
> 
>>
>> Required Attendees list :-
>>
>> Christoph Hellwig
>> Jason Gunthorpe
>> Jens Axboe
>> Chuck Lever
>> David Howells
>> Keith Busch
>> Bart Van Assche
>> Damien Le Moal
>> Martin Petersen
>>
>> -ck
>>
>> [1]
>> https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net
>> [2] https://lore.kernel.org/linux-iommu/20200708065014.GA5694@lst.de/
>>
>>
>>

