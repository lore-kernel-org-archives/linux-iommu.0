From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH 10/11] powerpc/svm: Force the use of bounce buffers
Date: Fri, 24 Aug 2018 20:38:54 -0300
Message-ID: <87o9drxrld.fsf@morokweng.localdomain>
References: <20180824025933.24319-1-bauerman@linux.ibm.com> <20180824025933.24319-11-bauerman@linux.ibm.com> <20180824060055.GB13689@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180824060055.GB13689@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Anshuman Khandual <anshuman.linux@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Mike Anderson <andmike@linux.ibm.com>, Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: iommu@lists.linux-foundation.org


Hello Christoph,

Thanks for your quick review.

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Aug 23, 2018 at 11:59:32PM -0300, Thiago Jung Bauermann wrote:
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>
>> SWIOTLB checks range of incoming CPU addresses to be bounced and see if the
>> device can access it through it's DMA window without requiring bouncing. In
>> such cases it just chooses to skip bouncing. But for cases like secure
>> guests on powerpc platform all addresses need to be bounced into the shared
>> pool of memory because the host cannot access it otherwise. Hence the need
>> to do the bouncing is not related to device's DMA window. Hence force the
>> use of bouncing by setting the swiotlb_force variable on secure guests.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  arch/powerpc/kernel/svm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
>> index 1af5caa955f5..f0576ad65cd0 100644
>> --- a/arch/powerpc/kernel/svm.c
>> +++ b/arch/powerpc/kernel/svm.c
>> @@ -17,6 +17,7 @@ static int __init init_svm(void)
>>  		return 0;
>>
>>  	ppc_swiotlb_enable = 1;
>> +	swiotlb_force = SWIOTLB_FORCE;
>>  	swiotlb_update_mem_attributes();
>
> This needs a comment.

Good point. Will add one.

If in the new scheme of things (with bus_dma_mask?) dma_capable() on a
virtio device running in a secure guest returns false, then this patch
becomes unnecessary and can be dropped.

--
Thiago Jung Bauermann
IBM Linux Technology Center
