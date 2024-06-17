Received: from mail177-18.suw61.mandrillapp.com (mail177-18.suw61.mandrillapp.com [198.2.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E31AB539
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.177.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631389; cv=none; b=htk4abUc8jioJvEHzxMVHEYbx2qMR/bvEQp5qlLTJQA7pBWZGRSuOC4ICExMxZT/5p6EPnB9mcLFyVXmEWXYKlKao/PtsY5KfnZ+aN91EPeA+ScIwIg4zpan5Y9CfQdCDsxH0qn/s2k+MFcPAWUUfB7SH0pqSHS4XouO2SrofRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631389; c=relaxed/simple;
	bh=dlpIz9pqe9DLQUjEyyFOte2v8iurHUanjdc8c6ML0Xg=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=SAUI+qwN4q85K1gw+Z/gFH/M0G5TrPm+6EiVivMqUMfpZGknAs3pxzGAN4kwLmkMYOQSMBHGLWVUfC7o1eL0MJVWnSdpvgqLFa6CxpoUbkoCxXfMaIyaaoN7f+ExYqZW1kF3jQLDn+h5qiOwfOPKksFheczA1clBW437D3kNEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=vVPXRYXP; dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b=KH2Jnvp7; arc=none smtp.client-ip=198.2.177.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="vVPXRYXP";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="KH2Jnvp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1718631386; x=1718891886;
	bh=ANoB2hVLGG/+0YUoUyUuDSxhyaDSfD0W7DFkZ5zOFpI=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=vVPXRYXPPiFH2OCXAZqdcxjNY4DgvShhBF2BjdWfNHuXVlgJUuax66yPEOWYP8xuW
	 ZcT0sZImDK8u41AYRWoxsBp85kyJ7votQF9T0Ri/2n2KlOkoPez1RfE3NqW6pYn2hS
	 j3AUo6pHG9o+6w5IXr+Wh3Jo13wMg6v94mfmO5yfsapQHBTtWNRPq/mLnT2UM/KQks
	 jZDC5nn8Nytx38tpANFwBwMcCkX7q8P+B3wZPahtYxqAeXYs8RDjrdsEAmAdv5puJ/
	 ozUwQkiuleDhTQmaaDNkW+/wo+uZ86z69Y/cscykgLFDO7h/mGjIixZjNTnAAee9A4
	 j/R/VME0Ni8Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1718631386; x=1718891886; i=teddy.astie@vates.tech;
	bh=ANoB2hVLGG/+0YUoUyUuDSxhyaDSfD0W7DFkZ5zOFpI=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=KH2Jnvp7N8SwtNomIlWXPofeORixyzzRU2PDJ59cKhz4UtgN9Withx/dTjs2un4e3
	 TF5FBifUfRFlEn6DqY8l3H1L+ovK2ctFcXXzTsQBBUInZ+ejqD/ZQSswnp9xIJBsvE
	 FiVqIQvN/GzzpH2PIJg132oI/WIUUSb0FAouSEUvfhs5i8Lmr7nMNYc4f/hKniRrK8
	 3gjQVqcSs6Wc/c8iRSGOxrL+CD8iU4t+0UoNs+Bs6Vsd5cuf5IZ1Vy+8OjzBHlZTfA
	 1v2u3us7CwOynZBRRj2nKr6Z5zS8878QsR7CyO2E/7XTe3x1gV8mVDZL4DPdeCeloz
	 7oiBXgihSZitQ==
Received: from pmta14.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail177-18.suw61.mandrillapp.com (Mailchimp) with ESMTP id 4W2rWZ6ZXwzCf9KFL
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 13:36:26 +0000 (GMT)
From: Teddy Astie <teddy.astie@vates.tech>
Subject: =?utf-8?Q?Re:=20[RFC=20PATCH]=20iommu/xen:=20Add=20Xen=20PV-IOMMU=20driver?=
Received: from [37.26.189.201] by mandrillapp.com id 6bf0bf7186334d4da354f2a8f89a4b92; Mon, 17 Jun 2024 13:36:26 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1718631384460
Message-Id: <eceaa7e7-d07f-4a41-b39a-0b32be6724ae@vates.tech>
To: Jan Beulich <jbeulich@suse.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, =?utf-8?Q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org, iommu@lists.linux.dev
References: <fe36b8d36ed3bc01c78901bdf7b87a71cb1adaad.1718286176.git.teddy.astie@vates.tech> <8b0151a8-2293-409a-8469-d9e73cf561a3@suse.com>
In-Reply-To: <8b0151a8-2293-409a-8469-d9e73cf561a3@suse.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.6bf0bf7186334d4da354f2a8f89a4b92?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240617:md
Date: Mon, 17 Jun 2024 13:36:26 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 13/06/2024 =C3=A0 16:32, Jan Beulich a =C3=A9crit=C2=A0:
> On 13.06.2024 15:50, Teddy Astie wrote:
>> @@ -214,6 +215,38 @@ struct xen_add_to_physmap_range {
>>   };
>>   DEFINE_GUEST_HANDLE_STRUCT(xen_add_to_physmap_range);
>>   
>> +/*
>> + * With some legacy devices, certain guest-physical addresses cannot sa=
fely
>> + * be used for other purposes, e.g. to map guest RAM.  This hypercall
>> + * enumerates those regions so the toolstack can avoid using them.
>> + */
>> +#define XENMEM_reserved_device_memory_map   27
>> +struct xen_reserved_device_memory {
>> +    xen_pfn_t start_pfn;
>> +    xen_ulong_t nr_pages;
>> +};
>> +DEFINE_GUEST_HANDLE_STRUCT(xen_reserved_device_memory);
>> +
>> +struct xen_reserved_device_memory_map {
>> +#define XENMEM_RDM_ALL 1 /* Request all regions (ignore dev union). */
>> +    /* IN */
>> +    uint32_t flags;
>> +    /*
>> +     * IN/OUT
>> +     *
>> +     * Gets set to the required number of entries when too low,
>> +     * signaled by error code -ERANGE.
>> +     */
>> +    unsigned int nr_entries;
>> +    /* OUT */
>> +    GUEST_HANDLE(xen_reserved_device_memory) buffer;
>> +    /* IN */
>> +    union {
>> +        struct physdev_pci_device pci;
>> +    } dev;
>> +};
>> +DEFINE_GUEST_HANDLE_STRUCT(xen_reserved_device_memory_map);
> 
> This is a tools-only (i.e. unstable) sub-function in Xen; even the commen=
t
> at the top says "toolstack". It is therefore not suitable for use in a
> kernel.
> 
IMO this comment actually describes how the toolstack uses the 
hypercall, but I don't think it is actually reserved for toolstack use.
Or maybe we should allow the kernel to use this hypercall as well.

>> +
>> +/*
>> + * Local variables:
>> + * mode: C
>> + * c-file-style: "BSD"
>> + * c-basic-offset: 4
>> + * tab-width: 4
>> + * indent-tabs-mode: nil
>> + * End:
>> + */
>> \ No newline at end of file
> 
> Nit: I'm pretty sure you want to avoid this.
> 
Indeed.

Teddy


Teddy Astie | Vates XCP-ng Intern

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

