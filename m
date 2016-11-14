From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
Date: Mon, 14 Nov 2016 17:57:35 +0100
Message-ID: <1846cf2b-b988-be6d-368d-7991c0bdbe5e@redhat.com>
References: <20161110154606.GH2078@8bytes.org>
 <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
 <20161110161331.GJ2078@8bytes.org>
 <f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
 <20161111114223.GP2078@8bytes.org>
 <79da09b8-ac1e-cebf-5393-7d67f002b3e3@redhat.com>
 <20161111162211.GU2078@8bytes.org>
 <634ac375-3507-6926-164f-e67f7c798c98@redhat.com>
 <20161114153149.GY2078@8bytes.org>
 <295feefe-014b-5669-7f5a-e04b09ba3454@redhat.com>
 <20161114162037.GC14829@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114162037.GC14829@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: drjones@redhat.com, alex.williamson@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, christoffer.dall@linaro.org, tglx@linutronix.de, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 14/11/2016 17:20, Joerg Roedel wrote:
> On Mon, Nov 14, 2016 at 05:08:16PM +0100, Auger Eric wrote:
>> There are potentially several MSI doorbell physical pages in the SOC
>> that are accessed through the IOMMU (translated). Each of those must
>> have a corresponding IOVA and IOVA/PA mapping programmed in the IOMMU.
>> Else MSI will fault.
>>
>> - step 1 was to define a usable IOVA range for MSI mapping. So now we
>> decided the base address and size would be hardcoded for ARM. The
>> get_dm_region can be used to retrieve that hardcoded region.
>> - Step2 is to allocate IOVAs within that range and map then for each of
>> those MSI doorbells. This is done in the MSI controller compose() callback.
>>
>> I hope I succeeded in clarifying this time.
>>
>> Robin sent today a new version of its cookie think using a dummy
>> allocator. I am currently integrating it.
> 
> Okay, I understand. A simple bitmap-allocator would probably be
> sufficient, and doesn't have the overhead the iova allocator has. About
> how many pages are we talking here?
Very few actually. In the systems I have access to I only have a single
page. In most advanced systems we could imagine per-cpu doorbells but
this does not exist yet as far as I know.

Thanks

Eric
> 
> 
> 	Joerg
> 
