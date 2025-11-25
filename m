Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF071EA65;
	Tue, 25 Nov 2025 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764034283; cv=none; b=amSiRA9x7gft3vIgSZQGicG3Y2uZFM8Aa3G5JgBUkWdU/9efjQYXTXfhnPPiZA9cC9RbS1SGwmvAx8wICipAH9PQzN/wPwrS98kE22xjL+iQH716qhvzMfvQVqiDpbMX/Pp2ymOQQ/b1PTAVYsu5R/Xi5+sTi7PPNXsIm5Qm/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764034283; c=relaxed/simple;
	bh=Ufs24gFM6Yna5y9SMCQ25E059KRuVZmzXUZxS+rkKbk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gJaf3Yrds42nDNtGFhyhG44CSS6JiUIGdHefMiPk+GRHbMNwExX/dN9ND5RjZr83QBe9msxjiTQ5avh9lGzH1i0+qH1Lh2g5zivBqnfbI9rV6xcfmetnTuQSYLeuNfIeLUMrcksVslT1zPgzHd9Fo2HmPNqnDxKPY1/OhOpx9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OXgJojMQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OXgJojMQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=E/7Q0+NNPU1ugUqXJ8My1rsvUBzyDEgTTxYG70tvPiM=; b=OXgJojMQJNDU0TprFLXGDym2iO
	6WG9AIzLRbHv0FuWoA7ilSC/hXp5OCP2zQTMAJA5E00EJZUcCV7dcy1kLV/dPHnc5eDZztPKWLcWz
	GtQbboadBg3nSefp9+3x3iPPnYRA+Px7MeuY0RHgS1KXGaP7brmvcng1hKvuQ3CMDwaAXprTbjTzV
	HlH5M2a2S7FnBZJ8uBZImyIqxcJrUpl+GZC16nNoqTDS1U9psmIbcMjPINuiA8bZL4ZaZCfG3pS37
	VbriFWzu/49aAlsnrevclTkEeONtdWxRateMHZcbzEUkmkRyYv6mrv1OaCpEevmigLfwLWig76aAp
	cmjalnMw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNhth-0000000CZ79-1tqo;
	Tue, 25 Nov 2025 01:31:14 +0000
Message-ID: <5d7a305e-d6b6-49dc-ab1d-bddd1339d4a7@infradead.org>
Date: Mon, 24 Nov 2025 17:31:12 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
From: Randy Dunlap <rdunlap@infradead.org>
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, xiaqinxin@huawei.com
References: <20251124200811.2942432-1-smostafa@google.com>
 <20251124200811.2942432-2-smostafa@google.com>
 <7854489b-bc9e-4bb9-a19d-cff96badc180@infradead.org>
Content-Language: en-US
In-Reply-To: <7854489b-bc9e-4bb9-a19d-cff96badc180@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I missed one other thing:

On 11/24/25 3:13 PM, Randy Dunlap wrote:
> 
> 
> On 11/24/25 12:08 PM, Mostafa Saleh wrote:
>> Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
>> page_ext.
>>
>> This config will be used by the IOMMU API to track pages mapped in
>> the IOMMU to catch drivers trying to free kernel memory that they
>> still map in their domains, causing all types of memory corruption.
>>
>> This behaviour is disabled by default and can be enabled using
>> kernel cmdline iommu.debug_pagealloc.
>>
>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>>  drivers/iommu/Kconfig                         | 19 +++++++++++
>>  drivers/iommu/Makefile                        |  1 +
>>  drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
>>  include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
>>  mm/page_ext.c                                 |  4 +++
>>  6 files changed, 79 insertions(+)
>>  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
>>  create mode 100644 include/linux/iommu-debug-pagealloc.h
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 6c42061ca20e..dddf435a1c11 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2557,6 +2557,12 @@
>>  			1 - Bypass the IOMMU for DMA.
>>  			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>>  
>> +	iommu.debug_pagealloc=

Please note what format the option parameter value takes and possible values,
like iommu.passthrough above here in the kernel-parameters.txt file.

>> +			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
>> +			parameter enables the feature at boot time. By default, it
>> +			is disabled and the system behave the same way as a kernel
> 
> 			                           behaves
> 
>> +			built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
>> +
>>  	io7=		[HW] IO7 for Marvel-based Alpha systems
>>  			See comment before marvel_specify_io7 in
>>  			arch/alpha/kernel/core_marvel.c.
> 
> 

-- 
~Randy

