From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH 3/4] iommu/vt-d: Allow IOMMU_DOMAIN_DMA and
 IOMMU_DOMAIN_IDENTITY to be allocated
Date: Sat, 9 Mar 2019 11:57:27 +0000
Message-ID: <718BFBD9-F03B-4887-84FB-A21B97DAC9E4@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <171d70d2-5988-9f25-7e2c-cddb217f63ad@arista.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <171d70d2-5988-9f25-7e2c-cddb217f63ad@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Safonov <dima@arista.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hey Dmitry,

> On 8 Mar 2019, at 01:20, Dmitry Safonov <dima@arista.com> wrote:
> 
> On 3/4/19 3:46 PM, James Sewart wrote:
>> +static inline int domain_is_initialised(struct dmar_domain *domain)
>> +{
>> +	return domain->flags & DOMAIN_FLAG_INITIALISED;
>> +}
> 
> Maybe check it in intel_iommu_domain_free(), eh?

Good shout, freeing a non attached IOMMU_DOMAIN_DMA domain is now 
different to an attached one.

> 
> Thanks,
>          Dmitry


Cheers,
James.
