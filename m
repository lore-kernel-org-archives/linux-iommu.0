Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653123D3B8
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698535; cv=none; b=awuvDaKRKJjWE3C4abAGbxMgBeukM6tha+ZNCYBkHwsEyXkYNO8GQLJHn969ivPWc2SOS+Qn9qczO2plo/6JyHlWXF4OEbLPvhdQAjDcjPLFR8JaYiqpBEgNE0/GtBuzQGZ2hPRwxXss9OOZpwIZCi243FkffEnDlmut6IqqAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698535; c=relaxed/simple;
	bh=NY1wpa0KtsBaIPbsx0L2RVvkqMHjLmULXkYd5FOpTXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el1OClrU1wCM1qUUOUu7IF2uO9bIvoxuWAVwOSCOMyByoFOZafFgDCRUgcyqGhVcqrDXoCfZ9DiNQS3tKYHWEDUvsBd+QVPCJ50ZqsMuf0QBhzsZUAmDWudWKFIBIC5OcDqXO2bq/eoRQstFtIVotlWlKoJe4hVpvMGrk/rBKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJWA/FpL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJWA/FpL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741698532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSr0TDQLJaYD83EU6zHlB1nKsxywhTiBP95UqC0cvIM=;
	b=iJWA/FpLY4ALcVQWvmhM7z571xx3XbxbOnBN7Y62P8yNIYMvQRYnDRlPns1aGrgAtc6Sw2
	YNFuBqw12QjDYf2iCprl2fHokKe7bnCjYBnoWlU8+zDlVo5FDn2SK9XYNKCjS/ugeRIDab
	cg64px5RP0SXe6TaHgiKgjSa7/komIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221--BP_ykByOvmCXw9YsAWAPw-1; Tue, 11 Mar 2025 09:08:50 -0400
X-MC-Unique: -BP_ykByOvmCXw9YsAWAPw-1
X-Mimecast-MFC-AGG-ID: -BP_ykByOvmCXw9YsAWAPw_1741698529
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d08915f61so549325e9.2
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 06:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741698529; x=1742303329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSr0TDQLJaYD83EU6zHlB1nKsxywhTiBP95UqC0cvIM=;
        b=We1GUHr4KGuHcS+C/koA4/wYARee4MGdTb31mHA5epyN2HWa2ZlSj9bEPQyn5JWJal
         QUQS8FZ2PNMW4kdU0Gvrj68dIX8IWlie29qAa8wJ19651UDoHODfpktypksq/hfT2/3v
         xuyGU0xzye4v6eiUp+UUk2y/SpqtGige/0euI2QKzzHXzW8oRL2P2M9Be+Du8eLk1R9z
         haoh9PJn2vijb9MTyuVZ/dGxWJJzLnmXDvMs5EhquTaSmajyb1jMCIDYIhtlEfuFMPut
         Ro4Etv4p8Nv8HCjQ3zenCaJr+f54St6Gsv3JKjgq6+AF2d46lZkyW+E8cWfKdS+b1m4i
         6DQA==
X-Forwarded-Encrypted: i=1; AJvYcCUYCBsL3KfEuK/vJlzGBnS2qzcuwRkWq7G2ERc99IehYxoT7Qt39mnyMNwj93wUj1nV/SvDtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiOWLPkQWAIMd2W1VW2tnbnC5boQRIadnFhAqcNHWfk7hMUR4o
	UaA1XpsZwuQFGNGG4U4JG70gj/ZzjfZQBck1uRucyNyVMloddIv1alamJWtL4LGAOK983V6tEsE
	FpKYHWgwTMNty0fl7LsdZsrTRYmJkPpsLL8i7SrMK9pvcYcOxML9A
X-Gm-Gg: ASbGncuStvZSdKWpOstUtZpRw82AcLMlRa+o/LKdiLc66XGVTihuQUJap3Sq+q/i8VB
	zb8227u9RlX8jjDlW9Gv5JypmSChr69/eeK5uWmqXcD2cMSSw/d6+0Uua7hjNALRL7zrEoaBDbB
	3JMFhOO6gQFuwCXDAbsyeSiAGQT9c04/+yeL2EGIxroITlsEG0vGYfYDMw5ccOFoMayJAaAV0tM
	PZMH/+PZ13F0qp6aiTPQHX4MW0TEEyClmVe6SSq/+FNr0VwRod2g3746AKS2id87eDbgNMUary3
	CXiiEiAw3Wq8BxgOMFCT3r7Xu+ncxP1vl50KurX7wkuBiA==
X-Received: by 2002:a05:600c:3b04:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-43cf44c7703mr98398975e9.14.1741698528859;
        Tue, 11 Mar 2025 06:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHg2xJEtdcFy90P2VzdKFh3p/fCZJcgu7H/volTSsPrNEA8I4PMuG+4jYjYdTWL3xOUsvL7A==
X-Received: by 2002:a05:600c:3b04:b0:43c:f44c:72b7 with SMTP id 5b1f17b1804b1-43cf44c7703mr98398315e9.14.1741698528418;
        Tue, 11 Mar 2025 06:08:48 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf3ca4f5asm82801875e9.12.2025.03.11.06.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:08:47 -0700 (PDT)
Message-ID: <72cd7f5a-ab92-494c-b7f8-4696d23ed4b1@redhat.com>
Date: Tue, 11 Mar 2025 14:08:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v11 0/4] fix the DMA API misuse
 problem for page_pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <yunshenglin0825@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gaurav Batra <gbatra@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, IOMMU <iommu@lists.linux.dev>,
 MM <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Eric Dumazet <edumazet@google.com>
References: <20250307092356.638242-1-linyunsheng@huawei.com>
 <87v7slvsed.fsf@toke.dk> <40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.com>
 <875xkj1t70.fsf@toke.dk>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <875xkj1t70.fsf@toke.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fvcWYJNqzCRR9VFbV9pVXBBlXHrLEf1JdbjIb-K7jao_1741698529
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/8/25 3:40 PM, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>> I only took a glance at git code above, it seems reusing the
>> _pp_mapping_pad for pp_dma_index seems like a wrong direction
>> as mentioned in discussion with Ilias above as the field might
>> be used when a page is mmap'ed to user space, and reusing that
>> field in 'struct page' seems to disable the tcp_zerocopy feature,
>> see the below commit from Eric:
>> https://github.com/torvalds/linux/commit/577e4432f3ac810049cb7e6b71f4d96ec7c6e894
>>
>> Also, I am not sure if a page_pool owned page can be spliced into the fs
>> subsystem yet, but if it does, I am not sure how is reusing the
>> page->mapping possible if that page is called in __filemap_add_folio()?
>>
>> https://elixir.bootlin.com/linux/v6.14-rc5/source/mm/filemap.c#L882
> 
> Hmm, so I did look at the mapping field, but concluded using it wouldn't
> interfere with anything relevant as long as it's reset back to zero
> before the page is returned to the page allocator. However, I definitely
> missed the TCP zero-copy thing, and other things as well, it would seem
> (cf the discussion you referred to above).
> 
> However, I did consider alternatives: AFAICT there should be space in
> the pp_magic field (used for the PP_SIGNATURE), so that with a bit of
> care we can stick an ID into the upper bits and still avoid ending up
> with a value that could look like a valid pointer.
> 
> I didn't implement that initially because I wasn't sure it was
> necessary, but seeing as it is, I will take another look at it. I have
> one or two other ideas if this turns out not to pan out.

Another dumb option would be storing directly the page address in the
xarray, and avoid entirely going through an ID. I guess it will use more
memory (the array will be more sparse) and will have more overhead, but
could be possibly simpler?

/P

