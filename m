From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v2 7/7] iommu/vt-d: Remove lazy allocation of domains
Date: Fri, 22 Mar 2019 10:07:01 +0000
Message-ID: <48D45E21-9B4B-40AB-A698-5386E08A6646@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F4D76093-3F9F-4184-9F92-191A01126D0F@arista.com>
 <20190314163501.2f414a78@jacob-builder>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190314163501.2f414a78@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hey Jacob,

> On 14 Mar 2019, at 23:35, Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> On Thu, 14 Mar 2019 11:59:36 +0000
> James Sewart <jamessewart@arista.com> wrote:
> 
>> 
>> -	domain = get_valid_domain_for_dev(dev);
>> +	domain = find_domain(dev);
>> 	if (!domain)
>> 		return DMA_MAPPING_ERROR;
>> 
>> @@ -3914,7 +3624,7 @@ static int intel_map_sg(struct device *dev,
>> struct scatterlist *sglist, int nele if (iommu_no_mapping(dev))
>> 		return intel_nontranslate_map_sg(dev, sglist,
>> nelems, dir); 
>> -	domain = get_valid_domain_for_dev(dev);
>> +	domain = find_domain(dev);
> This patchset looks like a very good clean up, I am wondering why we
> can't use the generic iommu_get_domain_for_dev() here, since VT-d has a
> default DMA domain after your patch.

This should be possible, only downside is we get an iommu_domain from 
iommu_get_domain_for_dev and will have to check its not null before 
getting the dmar_domain from it. We will be able to remove find_domain 
though.

Cheers,
James.
