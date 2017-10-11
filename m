From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 01/16] iommu: introduce bind_pasid_table API function
Date: Wed, 11 Oct 2017 10:17:24 +0100
Message-ID: <a8a6079a-5a58-8c1c-af3d-ab709ee02219@arm.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1507244624-39189-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <59945b24-ace9-f0c1-d68d-ccd929e1fe28@arm.com>
 <20171010144218.735d1f58@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010144218.735d1f58@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Yi L <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On 10/10/17 22:42, Jacob Pan wrote:
[...]
>>> +/**
>>> + * PASID table data used to bind guest PASID table to the host
>>> IOMMU. This will
>>> + * enable guest managed first level page tables.
>>> + * @version: for future extensions and identification of the data
>>> format
>>> + * @bytes: size of this structure
>>> + * @base_ptr:	PASID table pointer
>>> + * @pasid_bits:	number of bits supported in the guest PASID
>>> table, must be less
>>> + *		or equal than the host table size.  
>>
>> "host table size" is a bit confusing in this context, especially if
>> using multi-level tables. Perhaps it's clear enough that @pasid_bits
>> must be smaller or equal than the PASID size supported by the IOMMU,
>> and we can remove that second part?
>>
> Not sure what is the second part?

"must be less or equal than the host table size", is confusing to me when
you're talking about max PASID bits

Thanks,
Jean
