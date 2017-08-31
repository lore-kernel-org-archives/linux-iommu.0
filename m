From: "Sironi, Filippo" <sironi@amazon.de>
Subject: Re: [PATCH] intel-iommu: Don't be too aggressive when clearing one
 context entry
Date: Thu, 31 Aug 2017 08:47:03 +0000
Message-ID: <77293ECA-2B4C-496C-9DDD-A5A2618F00A1@amazon.de>
References: <1503929789-26698-1-git-send-email-sironi@amazon.de>
 <20170830085025.7027c9f8@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170830085025.7027c9f8@jacob-builder>
Content-Language: en-US
Content-ID: <7A78EDE5B774D64BBA7786D39150A1DC@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Filippo Sironi via iommu <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Woodhouse, David" <dwmw@amazon.co.uk>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

> On 30. Aug 2017, at 17:50, Jacob Pan <jacob.jun.pan@linux.intel.com> wrot=
e:
> =

> On Mon, 28 Aug 2017 16:16:29 +0200
> Filippo Sironi via iommu <iommu@lists.linux-foundation.org> wrote:
> =

>> Previously, we were invalidating context cache and IOTLB globally when
>> clearing one context entry.  This is a tad too aggressive.
>> Invalidate the context cache and IOTLB for the interested device only.
>> =

>> Signed-off-by: Filippo Sironi <sironi@amazon.de>
>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>> drivers/iommu/intel-iommu.c | 25 ++++++++++++++++++++++---
>> 1 file changed, 22 insertions(+), 3 deletions(-)
>> =

>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 3e8636f1220e..4bf3e59b0929 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2351,13 +2351,32 @@ static inline int domain_pfn_mapping(struct
>> dmar_domain *domain, unsigned long i =

>> static void domain_context_clear_one(struct intel_iommu *iommu, u8
>> bus, u8 devfn) {
>> +	unsigned long flags;
>> +	struct context_entry *context;
>> +	u16 did_old;
>> +
>> 	if (!iommu)
>> 		return;
>> =

>> +	spin_lock_irqsave(&iommu->lock, flags);
>> +	context =3D iommu_context_addr(iommu, bus, devfn, 0);
>> +	if (!context) {
>> +		spin_unlock_irqrestore(&iommu->lock, flags);
>> +		return;
>> +	}
> perhaps check with device_context_mapped()?

Using device_context_mapped() wouldn't simplify the code since it
would just tell me that at the time of check there was a context.
I would still need to lock, get the context, check if the context
is valid, do the work, and unlock.

Modifying device_context_mapped() to return the context isn't
going to work either because it may go away in the meantime since
I wouldn't hold the lock.

>> +	did_old =3D context_domain_id(context);
>> +	spin_unlock_irqrestore(&iommu->lock, flags);
>> 	clear_context_table(iommu, bus, devfn);
>> -	iommu->flush.flush_context(iommu, 0, 0, 0,
>> -					   DMA_CCMD_GLOBAL_INVL);
>> -	iommu->flush.flush_iotlb(iommu, 0, 0, 0,
>> DMA_TLB_GLOBAL_FLUSH);
>> +	iommu->flush.flush_context(iommu,
>> +				   did_old,
>> +				   (((u16)bus) << 8) | devfn,
>> +				   DMA_CCMD_MASK_NOBIT,
>> +				   DMA_CCMD_DEVICE_INVL);
>> +	iommu->flush.flush_iotlb(iommu,
>> +				 did_old,
>> +				 0,
>> +				 0,
>> +				 DMA_TLB_DSI_FLUSH);
>> }
>> =

>> static inline void unlink_domain_info(struct device_domain_info
>> *info)
> =

> [Jacob Pan]

Regards,
Filippo


Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
