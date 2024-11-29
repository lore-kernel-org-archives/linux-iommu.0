Received: from mail180-27.suw31.mandrillapp.com (mail180-27.suw31.mandrillapp.com [198.2.180.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAD4087C
	for <iommu@lists.linux.dev>; Fri, 29 Nov 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732901803; cv=none; b=Ll8u4UdTJWMDDQ84xScvmeqsPhL+ITQ75XruOfV8+rCaYDDAjtDpA4tb/Lacum4y538ttwSZb/PwEiObwela+lMP9RnRFVB5RDpALHAjOMUMQzSvWdO7jvOhbOITn7VaSI+/5HAEQc0uZIpeC4y3rCU6exI8kBnBnK8pjmV+Iqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732901803; c=relaxed/simple;
	bh=5zCWXC9TUj94GjK/21Ix29jy73icDrRa/bMqvLhV2Ko=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=jB8DgX9sF6O7U919ubTS5Y30hIB7j1c+uUkuA92c/UHT6jfDU/a+BhGeGVy0taL9VOdzM5WpHhiJTXBf0/STY/7ikwptVJMadx+9rQOpPSAqk+LNdB834pG7VzUoUBZtCa+p1CLO1e8pM1g7fj2jin/1HBxPr8Qxp/pHRytL/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=s1INISIY; dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b=jxkEMexO; arc=none smtp.client-ip=198.2.180.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="s1INISIY";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b="jxkEMexO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1732901800; x=1733162300;
	bh=2DFaOg6NuCFtrE/G4yKsOhsAMmOaVP7yOxEacPXZjy8=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=s1INISIYP/IHfVou5iQHjgmprx1eTUUqSAJM1KWGdTmPcYhMsOag6MlnWO0hzD+BY
	 +m2hDdfbpBM8Hi2NcNxJGyzbuahaXb1LFuf1DwmZL7FdKUM1naYki/GxAvvaInbDlF
	 486HnTkPmXMiivMl7e3GLY9yENGil8t5U40i0l+4AsO5VJKk+firKXyT64yL6jxR3p
	 ZHQa6D2QXJGl2GNFxohWpb7g/0NctcEi+LlEq+5lJPxjfqY91cJwSnZ+MwoEmroBvD
	 fR1WHY2U0gwEK+n86/bFMbZvyFFeayWBvh0e7YWPfMgDDRzxMK20Fkj0GaY07emRYm
	 Jr5J+wWMAolTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1732901800; x=1733162300; i=thierry.escande@vates.tech;
	bh=2DFaOg6NuCFtrE/G4yKsOhsAMmOaVP7yOxEacPXZjy8=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=jxkEMexOZV2EThyhjNcIgNwSTjApyxiZ04JoqYFIOPE0Iq/g+GYKaMZNg0Uz1QmqA
	 iCrV5w8zZODlaOnct4hFSKZRD7YF55M55/uvQDrbCTx7TOTbHTc12y0/0LFalD8uzy
	 MzA1620Hw0Ui5UjWxBwgV5LsWtV+2FTriOK/DkVbkI/pAC4g+YjYJbNa/r47ZXUvM4
	 ZXj2baLnxilk3OZsJmj2jM3BLvMx+obwaYTziRpj6KPF9yBVMYYq7JhbUbqf0h0PUv
	 JxHQNMvhiYQR6NePl7cTJQ2pdlu3HUV9RAiHOH0OAEA7XALA5VkbqA4bSlxDei/wSE
	 KACnhY7TgRJGw==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-27.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4Y0L2c6nhNz6CQBvS
	for <iommu@lists.linux.dev>; Fri, 29 Nov 2024 17:36:40 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v2=201/2]=20xen/swiotlb:=20add=20alignment=20check=20for=20dma=20buffers?=
Received: from [37.26.189.201] by mandrillapp.com id 5c125d4db3c54fa5bdeb2a3a77c71909; Fri, 29 Nov 2024 17:36:40 +0000
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1732901799832
Message-Id: <e6ceb22d-3fa7-430c-9410-3c5ffd9ded2d@vates.tech>
To: "Juergen Gross" <jgross@suse.com>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, xen-devel@lists.xenproject.org, jbeulich@suse.com
References: <20240916064748.18071-1-jgross@suse.com> <20240916064748.18071-2-jgross@suse.com>
In-Reply-To: <20240916064748.18071-2-jgross@suse.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.5c125d4db3c54fa5bdeb2a3a77c71909?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20241129:md
Date: Fri, 29 Nov 2024 17:36:40 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

On 16/09/2024 08:47, Juergen Gross wrote:
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 35155258a7e2..ddf5b1df632e 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>  {
>  	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>  	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
> +	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
>  
>  	next_bfn = pfn_to_bfn(xen_pfn);
>  
> +	/* If buffer is physically aligned, ensure DMA alignment. */
> +	if (IS_ALIGNED(p, algn) &&
> +	    !IS_ALIGNED(next_bfn << XEN_PAGE_SHIFT, algn))
> +		return 1;

There is a regression in the mpt3sas driver because of this change.
When, in a dom0, this driver creates its DMA pool at probe time and
calls dma_pool_zalloc() (see [1]), the call to
range_straddles_page_boundary() (from xen_swiotlb_alloc_coherent())
returns 1 because of the alignment checks added by this patch. Then the
call to xen_create_contiguous_region() in xen_swiotlb_alloc_coherent()
fails because the passed size order is too big (> MAX_CONTIG_ORDER).
This driver sets the pool allocation block size to 2.3+ MBytes.

From previous discussions on the v1 patch, these checks are not
necessary from xen_swiotlb_alloc_coherent() that already ensures
alignment, right?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/scsi/mpt3sas/mpt3sas_base.c?h=v6.12.1#n6227

Regards,
Thierry
