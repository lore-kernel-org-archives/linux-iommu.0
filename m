From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 1/2] dma-direct: set_memory_{en,de}crypted() take number of pages
Date: Tue, 22 Jan 2019 20:38:46 -0200
Message-ID: <87womwfhc9.fsf@morokweng.localdomain>
References: <20190122211758.8317-1-bauerman@linux.ibm.com> <bc09628a-d329-bb95-d737-b7c618860c6a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <bc09628a-d329-bb95-d737-b7c618860c6a@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Ram Pai <linuxram@us.ibm.com>
List-Id: iommu@lists.linux-foundation.org


Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:

> On 1/22/19 3:17 PM, Thiago Jung Bauermann wrote:
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 355d16acee6d..bc78c37220ba 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -166,7 +166,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>>  
>>  	ret = page_address(page);
>>  	if (force_dma_unencrypted()) {
>> -		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
>> +		set_memory_decrypted((unsigned long)ret, 1);
>
> The get_order() function will return the order for the specified size. To
> then get the number of pages you perform the shift as is being done. The
> change is definitely wrong since you are now hardcoding the page count to
> 1. The call to __dma_direct_alloc_pages() will allocate more than one page
> if the size is greater than a page.

<facepalm>

You are correct, of course. Sorry for the noise and thanks for explaining.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
