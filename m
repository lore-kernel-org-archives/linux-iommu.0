Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C615488
	for <iommu@lists.linux.dev>; Wed,  8 Nov 2023 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SQMdF13hbz6K8sn;
	Wed,  8 Nov 2023 19:03:13 +0800 (CST)
Received: from [10.195.35.156] (10.195.35.156) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 8 Nov 2023 12:04:14 +0100
Message-ID: <41c0baf6-ba4d-4876-b692-279307265466@huawei-partners.com>
Date: Wed, 8 Nov 2023 12:04:12 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
To: Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
	<petr@tesarici.cz>
CC: Niklas Schnelle <schnelle@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Ross
 Lagerwall <ross.lagerwall@citrix.com>, linux-pci <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Matthew Rosato
	<mjrosato@linux.ibm.com>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
 <20231103195949.0af884d0@meshulam.tesarici.cz>
 <20231108115207.791a30d8.pasic@linux.ibm.com>
Content-Language: en-US
From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
In-Reply-To: <20231108115207.791a30d8.pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.35.156]
X-ClientProxiedBy: frapeml100003.china.huawei.com (7.182.85.60) To
 frapeml500002.china.huawei.com (7.182.85.205)
X-CFilter-Loop: Reflected

On 11/8/2023 11:52 AM, Halil Pasic wrote:
> On Fri, 3 Nov 2023 19:59:49 +0100
> Petr Tesařík <petr@tesarici.cz> wrote:
> 
>>> Not sure how to properly fix this as the different alignment
>>> requirements get pretty complex quickly. So would appreciate your
>>> input.  
>>
>> I don't think it's possible to improve the allocation logic without
>> modifying the page allocator and/or the DMA atomic pool allocator to
>> take additional constraints into account.
> 
> I don't understand. What speaks against calculating the amount of space
> needed, so that with the waste we can still fit the bounce-buffer in the
> pool?
> 
> I believe alloc_size + combined_mask is a trivial upper bound, but we can
> do slightly better since we know that we allocate pages.
> 
> For the sake of simplicity let us assume we only have the min_align_mask
> requirement. Then I believe the worst case is that we need 
> (orig_addr & min_align_mask & PAGE_MASK)  + (min_align_mask & ~PAGE_MASK)
> extra space to fit.
> 
> Depending on how the semantics pan out one may be able to replace
> min_align_mask with combined_mask.
> 
> Is your point that for large combined_mask values 
> _get_free_pages(GFP_NOWAIT | __GFP_NOWARN, required_order) is not
> likely to complete successfully?

Yes, that's the reason. OTOH it's probably worth a try. The point is
that mapping a DMA buffer is allowed to fail, so callers should be
prepared anyway.

And for the case you reported initially, I don't think there is any need
to preserve bit 11 (0x800) from the original buffer's physical address,
which is enough to fix it. See also my other email earlier today.

Petr T
