Received: from mail136-20.atl41.mandrillapp.com (mail136-20.atl41.mandrillapp.com [198.2.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93119995B
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160109; cv=none; b=XJNxJ9fTMtQNoJLYQPsmqIofA2zdT8zi+wcvrk2HPbQ1aBZ2w+WC/fvh9OFiZ03cHr3oekCr/azJ/RqsICmmHt57+w020qutDIeT/wyvzy9Iri5DF9jAqAuDkcDq2C0R6Fz1HG06bp8qc8NKjy4maQjtmsgtLtcWAS38FFguVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160109; c=relaxed/simple;
	bh=15c4NQmMhX7O/lLntNh05+5nyQLyX5I/hV8b4lOLUA4=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=HLlxsLstbU7u3BgSsBitcvul6JU7YG9ESvGuBy7dpvp6AXZOAYUzXZLjPgLvT9tijF/pHp/mf7eX4Deyisu5LWVmrmjeKe6AfRsgS3HDjoTpd/7Bwfynayb73Np9fcmG7OtmOeQ8WK/cas6mzm/1TRdHuBocrIn5JwwHeKl/KRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=TJYc7w4N; dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b=qnbSV9su; arc=none smtp.client-ip=198.2.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="TJYc7w4N";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b="qnbSV9su"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1733160105; x=1733420605;
	bh=IauL8Qp0YWYvkAARRtO9cDCFO2BMI77KcbI4z8abZFI=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=TJYc7w4NRxGk6MPQUE9jI6jgbHmWSm2V+ZytN5Wtn08PPdWeiCYQrLsklgDRCx5sO
	 WVj8PJMLUwky6gh67HNu8abeMQfbBE99c9eC5QKlo0pO8UpulMOVx5qC1E/afJwgBB
	 ovtuGZeq2LZQyjrymxAdbkkgzGvQOniOrNcZxLonW5VqO85e0N0Ecj5Y4ygVGPiros
	 h/x1gGYE2L8wh641vUKYDOckcgSfRDwy9c5Dnx0VNPEIh1dkeu5rtcBGcBSiwWsS1s
	 MTuKhIGa1ziWeeosRSJr0/tloxYXQkrG10aTkq5HjdrPkb6XnYy6S3sixGcBt9PkTQ
	 FhuMlION6UL2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1733160105; x=1733420605; i=thierry.escande@vates.tech;
	bh=IauL8Qp0YWYvkAARRtO9cDCFO2BMI77KcbI4z8abZFI=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=qnbSV9suHL9D9gVxDNxH6dKUO7oSiJ0TlwhWjgh2dgAp7ebtGSyzvr1iBTFsGNbj4
	 7jp9WMn+hueO1+suofQyezozU9A/+IL6ubTu+C3Yc110R70VaaiST4+nvGHEl5i0fS
	 9cJeeilsLWUmCRxSFttLA+5zm8Jje1M1vFnuqZpWqpMBzOOW3r6W6jYCYk7T2+4UwD
	 A40zjaWHUhUq/osiVjtw3eqxPOvzpbEBPqbfq/dPS6MMIknq0FNxd+hRFHExaB61In
	 t7iiRjgg232yE+6BMJfDWu0z4rYTXrMs3qHzivAUCzs2npJ0HIV+bdKxq9nrndBL8y
	 2Ly8ok8JqhS4Q==
Received: from pmta11.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
	by mail136-20.atl41.mandrillapp.com (Mailchimp) with ESMTP id 4Y29Z1344CzCf9MQJ
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 17:21:45 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v2=201/2]=20xen/swiotlb:=20add=20alignment=20check=20for=20dma=20buffers?=
Received: from [37.26.189.201] by mandrillapp.com id f813d138deac4b64b04d84a0fbb2ec5a; Mon, 02 Dec 2024 17:21:45 +0000
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1733160104462
Message-Id: <c9eca3df-d1ba-46f8-95c2-2da0b8c25803@vates.tech>
To: =?utf-8?Q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, xen-devel@lists.xenproject.org, jbeulich@suse.com
References: <20240916064748.18071-1-jgross@suse.com> <20240916064748.18071-2-jgross@suse.com> <e6ceb22d-3fa7-430c-9410-3c5ffd9ded2d@vates.tech> <2d4fd45a-2461-441e-a116-3b6cff18ee9e@suse.com>
In-Reply-To: <2d4fd45a-2461-441e-a116-3b6cff18ee9e@suse.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.f813d138deac4b64b04d84a0fbb2ec5a?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20241202:md
Date: Mon, 02 Dec 2024 17:21:45 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 02/12/2024 09:27, J=C3=BCrgen Gro=C3=9F wrote:
> On 29.11.24 18:36, Thierry Escande wrote:
>> Hi,
>>
>> On 16/09/2024 08:47, Juergen Gross wrote:
>>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>>> index 35155258a7e2..ddf5b1df632e 100644
>>> --- a/drivers/xen/swiotlb-xen.c
>>> +++ b/drivers/xen/swiotlb-xen.c
>>> @@ -78,9 +78,15 @@ static inline int
>>> range_straddles_page_boundary(phys_addr_t p, size_t size)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long next_bfn, xen_pfn =3D XEN_=
PFN_DOWN(p);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int i, nr_pages =3D XEN_PFN_UP(=
xen_offset_in_page(p) +
>>> size);
>>> +=C2=A0=C2=A0=C2=A0 phys_addr_t algn =3D 1ULL << (get_order(size) + PAG=
E_SHIFT);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_bfn =3D pfn_to_bfn(xen_pfn);
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* If buffer is physically aligned, ensure D=
MA alignment. */
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ALIGNED(p, algn) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !IS_ALIGNED(next_bfn << XEN=
_PAGE_SHIFT, algn))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>
>> There is a regression in the mpt3sas driver because of this change.
>> When, in a dom0, this driver creates its DMA pool at probe time and
>> calls dma_pool_zalloc() (see [1]), the call to
>> range_straddles_page_boundary() (from xen_swiotlb_alloc_coherent())
>> returns 1 because of the alignment checks added by this patch. Then the
>> call to xen_create_contiguous_region() in xen_swiotlb_alloc_coherent()
>> fails because the passed size order is too big (> MAX_CONTIG_ORDER).
>> This driver sets the pool allocation block size to 2.3+ MBytes.
>>
>> =C2=A0From previous discussions on the v1 patch, these checks are not
>> necessary from xen_swiotlb_alloc_coherent() that already ensures
>> alignment, right?
> 
> It ensures alignment regarding guest physical memory, but it doesn't do
> so for machine memory.
> 
> For DMA machine memory proper alignment might be needed, too, so the
> check is required. As an example, some crypto drivers seem to rely on
> proper machine memory alignment, which was the reason for those checks
> to be added.
> 
> Possible solutions include:
> 
> - rising the MAX_CONTIG_ORDER limit (to which value?)

Looks like the quick and easy solution. Bumping MAX_CONTIG_ORDER to 10
would allow 4MB pools, enough for this particular driver. I'll send a
patch if that sounds reasonable.

Regards,
Thierry

> - adding a way to allocate large DMA buffers with relaxed alignment
> =C2=A0 requirements (this will impact the whole DMA infrastructure plus
> =C2=A0 drivers like mp3sas which would need to use the new interface)
> - modify the mpt3sas driver to stay within the current limits
> - only guarantee proper machine memory alignment up to MAX_CONTIG_ORDER
> =C2=A0 (risking to introduce hard to diagnose bugs for the rare use cases=
 of
> =C2=A0 such large buffers)
> 
> 
> Juergen

