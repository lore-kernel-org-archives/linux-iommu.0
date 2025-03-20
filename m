Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C91A5B97
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481255; cv=none; b=If8y8fO+wk70ce6/CuyeFIOT6bIUB5f2ZJUtQSqZMX5t0m+365YjQY16Ur/qycCjqi+im54n2kwtuilKm9a5aM1TL15xwN94ZOh/QSB814CQE3+Yp1cEh088jt5fIqKIIrlJyJAD30ZOLS1oMJUy/lRtYBqOh6ECsa5NqBC20pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481255; c=relaxed/simple;
	bh=7iLhCsEgmriA0Arg3aT+EM1OvQ9q5N2Kzwt92zewZ6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8qklubHKmMCT/wZdoUUO0S737WOLbvlrHT7ub6xFXP2yYlKSXN7E36JIDaCNmohNYG5uwiuagNCxVEi9vN5KTg9iZ0uG0t+sTnqD4aKt6F7y5d5fPQeDLAbf6kuC+tcHInsC/FbVUth25Yk8BkD+aiPf2h0hnEpd0oBQYge8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOtD9RE4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOtD9RE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742481252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iLhCsEgmriA0Arg3aT+EM1OvQ9q5N2Kzwt92zewZ6E=;
	b=EOtD9RE4XUeq4NwTnM2FMwwGbY7WFIYtWr6AfLAr8dzgM5gicVQN3jTGXaKodcExlmK8a4
	6Sw0/4AujEzOYHefauyNLs5bOCbAr/RI642xw1rbVmSCLJmAcJCJomLKu6HWlctwKpQe3k
	VLuKWtJLPWQH4ZAEgPWmwSOZMySdP8g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-4R3Jj0B6Mw2_Ezc0lIeBFQ-1; Thu, 20 Mar 2025 10:34:11 -0400
X-MC-Unique: 4R3Jj0B6Mw2_Ezc0lIeBFQ-1
X-Mimecast-MFC-AGG-ID: 4R3Jj0B6Mw2_Ezc0lIeBFQ_1742481250
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5498f71580cso372604e87.3
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481250; x=1743086050;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLsT93dSweyrf+qk2uXM1EK4iaVizTPbN4c8paMt31M=;
        b=UX2brLGSlbb9Rboiae0+C++tbJYu61YFXTmYXg8QyDd+Es5PSzN2ISXCH3lPPuXGMx
         WKq1ba/gNG6O64DSKrOu2BHNWUTZ4ao72F9Cf7qHZn+ZO6gRIKlLtk3Yav17WNDcyATF
         liPlIlilKezkImTOACWVpoOW5sjWwxF0QF9IWRcjMJ4b9cqsKIll0nTf81ShqBqrWbl1
         BUMIuZWYpOe/zuY62aFPL+HwIyArAkha+1Xnte3Zk6lDaNd4/0FvOyoQ8cKZoo+sUxob
         lFli24vt7H45vposit087WdX8lewMv7qw5UU/TDd6vfUBZ7jpyRVvygJ7YAxNi/td+VE
         ab/w==
X-Forwarded-Encrypted: i=1; AJvYcCUMJOH0VPDfZN6oJD0WmKdpTqIW4hCyZmagUP8A3V8MF0rx5+2as/UK0lSlBFaux0dibgHR4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyR8QiZGAecaMXLJtKb/SZHB76vFkzsAiPTVuC6bJFfCnq5GaIE
	oulz1qWozQhc4qalh/kkTxW8N7TS61FuSZZ4PbQAW6MN7oUuVziTC66AebcOQRl9AGPlIxX0tkQ
	QjfKUhdFh6mZtGvL2L5cLt/6p08F8EwVFhX+w+dcbQHzNPy/KkLDH
X-Gm-Gg: ASbGncusrYj8SAeteKAWZSnMo2aNPt0dBSKMFrW/oChIIpq8a6X80KS61RRKEMnrl6k
	xBgvd7KR2iFtoM+thm7eVTxLViukPx423LAEFIm0tK61fqHeVhesXGW/7R4Xs4pyiImhXjsVa/M
	fb0qWDoJCSxk+gJ6iNknPPBFHFhF5DgyKHXzpdxuR53wHpZHMlVcdd/XZXPhr70yonc3nDljIQC
	kKqaA5OoLzri8+lLDjm9l3tWtomeVKjw6XEWB3/jmqd+ZGYczZsBmjaObl120F78HCybJEKbpCw
	bl8DknUmdHm4
X-Received: by 2002:a05:6512:2392:b0:549:8e54:da9c with SMTP id 2adb3069b0e04-54ad0619d9cmr1163974e87.4.1742481249716;
        Thu, 20 Mar 2025 07:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5MKiRxkFgKG3EdSlhgqaV6W6DjuZ/y68FT+nnGB1qw2EVv6jr9Oog18ux0YhIZ7JDKVH0g==
X-Received: by 2002:a05:6512:2392:b0:549:8e54:da9c with SMTP id 2adb3069b0e04-54ad0619d9cmr1163951e87.4.1742481249052;
        Thu, 20 Mar 2025 07:34:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a9219sm2230109e87.249.2025.03.20.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:34:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 202DA18FC2E6; Thu, 20 Mar 2025 15:34:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>, IOMMU
 <iommu@lists.linux.dev>, segoon@openwall.com, solar@openwall.com,
 kernel-hardening@lists.openwall.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <7a604ae4-063f-48ff-a92f-014d1cf86adc@huawei.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
 <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com> <87wmcmhxdz.fsf@toke.dk>
 <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com> <87r02ti57p.fsf@toke.dk>
 <7a604ae4-063f-48ff-a92f-014d1cf86adc@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 20 Mar 2025 15:34:06 +0100
Message-ID: <87o6xvixep.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xD2pkB1832ZHx11MOKl8gneTSDzUew-gVqW67U5JDcM_1742481250
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/3/19 20:18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>
>>> All I asked is about moving PP_MAGIC_MASK macro into poison.h if you
>>> still want to proceed with reusing the page->pp_magic as the masking an=
d
>>> the signature to be masked seems reasonable to be in the same file.
>>=20
>> Hmm, my thinking was that this would be a lot of irrelevant stuff to put
>> into poison.h, but I suppose we could do so if the mm folks don't object=
 :)
>
> The masking and the signature to be masked is correlated, I am not sure
> what you meant by 'irrelevant stuff' here.

Well, looking at it again, mostly the XA_LIMIT define, I guess. But I
can just leave that in the PP header.

> As you seemed to have understood most of my concern about reusing
> page->pp_magic, I am not going to argue with you about the uncertainty
> of security and complexity of different address layout for different
> arches again.
>
> But I am still think it is not the way forward with the reusing of
> page->pp_magic through doing some homework about the 'POISON_POINTER'.
> If you still think my idea is complex and still want to proceed with
> reusing the space of page->pp_magic, go ahead and let the maintainers
> decide if it is worth the security risk and performance degradation.

Yeah, thanks for taking the time to go through the implications. On
balance, I still believe reusing the bits is a better solution, but it
will of course ultimately be up to the maintainers to decide.

I will post a v2 of this series with the adjustments we've discussed,
and try to outline the tradeoffs and risks involved in the description,
and then leave it to the maintainers to decide which approach they want
to move forward with.

-Toke

