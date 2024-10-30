Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94091E6DFF
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289484; cv=none; b=q5dnF7MPANJgxi8K08ot7fUhlxqR9CrE5KfNJsziXqO1C++ZxzrBoIxdDLpDVuiI9zKGLNHjxA7aZwKs0wjjfvqS77dO/wspTS/4ppHlORMDKSQ9+/BnVqDS6LpIlX3VwvbhS3X3mSccjTezplfILPvINio4OjIDbfz/JLPYNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289484; c=relaxed/simple;
	bh=+unSjnXH5Cb2JXz2/L4dsEP7mbwUy2ht9QU3aEK55LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KqoV921jLNv1byTa/4ut4O4xWuljv8t9IMdl0/SgadoE41I5eq8i3Doz5+MCnRvAi77Zj1BeH1tRDZv6lGDdrYBTyxJeD/jQqk4lIRsb8CNlbS57yIMXO4mB7V7i1OIImkaxISkiCRm/vpFoad5S9NN6B2C6uqC6goDvQCHP25Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJowFtv+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJowFtv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730289481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+unSjnXH5Cb2JXz2/L4dsEP7mbwUy2ht9QU3aEK55LU=;
	b=TJowFtv+XZPYTXyBuWpBvUOKDVa47RBCq1EmNFakb0QDXQUcOWxz1/y2VViixwZ32WVL7r
	LIPCF7v7Lmvl2LettnyRz8xYqlsqRiORISKdKDYrafgcnKGDIU3A5Uh4F6ifc5RJ10hxyz
	FOu61+PWgmoi3EVIglVZ6/jR5ihy1Lg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-1mWOJxDrOCC_gZBji3a5Zg-1; Wed, 30 Oct 2024 07:57:58 -0400
X-MC-Unique: 1mWOJxDrOCC_gZBji3a5Zg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99f43c4c7bso433515866b.0
        for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 04:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730289477; x=1730894277;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+unSjnXH5Cb2JXz2/L4dsEP7mbwUy2ht9QU3aEK55LU=;
        b=kVoNSYRMIznzZeKOKOAdkCy2zXFSJSy76bWJoUe4svLLiOfVeC8We4ejFEHXPn5eU9
         CEauUreEN4fz9ckI1zdNtr8DAbH7JdZL3FY5DG/ANDLOuGWhz1JOLqXGE8+bjvTNgnZM
         +4xMFNZLjiAglbt6yTPW+Fkq29Y5+M+iDFHJYCg1qtMyilTtLdqLDwzWOFDWe3ctl2Kv
         2BWZv321JNCadlaMLHyfPK1YWNK69/v8EmFjlmeNq9MNoE03HhuIGhXPuEC4x6wE9U/9
         nWEIiR/VyMpxPkHWtxv5pqGFtIJ11D8VPDdnar9UC+WusiefvF2KrPUd2xJTWrgrthtZ
         vyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFXMr25O9bxobWbPRdirbjBraCg8YDzoVIsq5WDL+Ls3oQ3vUpFk8fRsbIEoL3e7dW9vFA1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3YLIPFuIshaBNSCzG0NxpDlm5UMYHo2Ug+CF149oqFwzHPNHY
	GHDj9c2faQ+eV1MiT7vG+VHmZM6sY+dFIj1X4MUUlXf+BXpFgsYfh2cjXV7Hx3UIFq971yd3of3
	CrXbJvg/SX2djgbthEDrkx9KWheQFknmJ/LiyYCA48j4Q2I+7pSSt
X-Received: by 2002:a17:907:6d15:b0:a99:ecaf:4543 with SMTP id a640c23a62f3a-a9de5d8272dmr1567689466b.25.1730289477277;
        Wed, 30 Oct 2024 04:57:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVLgw5rE9QA3Icf5YbgX5jGmETg3oQl1odAk1S8jhHGqLiYvv6XcYW/kBL6ZHibuCo5cMEsg==
X-Received: by 2002:a17:907:6d15:b0:a99:ecaf:4543 with SMTP id a640c23a62f3a-a9de5d8272dmr1567687166b.25.1730289476927;
        Wed, 30 Oct 2024 04:57:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2982e1sm568328366b.99.2024.10.30.04.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:57:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 49BAC164B390; Wed, 30 Oct 2024 12:57:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
In-Reply-To: <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk>
 <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 30 Oct 2024 12:57:55 +0100
Message-ID: <87o731by64.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

>> But, well, I'm not sure it is? You seem to be taking it as axiomatic
>> that the wait in itself is bad. Why? It's just a bit memory being held
>> on to while it is still in use, and so what?
>
> Actually, I thought about adding some sort of timeout or kicking based on
> jakub's waiting patch too.
>
> But after looking at more caching in the networking, waiting and kicking/flushing
> seems harder than recording the inflight pages, mainly because kicking/flushing
> need very subsystem using page_pool owned page to provide a kicking/flushing
> mechanism for it to work, not to mention how much time does it take to do all
> the kicking/flushing.

Eliding the details above, but yeah, you're right, there are probably
some pernicious details to get right if we want to flush all caches. S
I wouldn't do that to start with. Instead, just add the waiting to start
with, then wait and see if this actually turns out to be a problem in
practice. And if it is, identify the source of that problem, deal with
it, rinse and repeat :)

-Toke

