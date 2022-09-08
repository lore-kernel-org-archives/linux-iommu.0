Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C1B3D65
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 15:23:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492E514BF;
	Thu,  8 Sep 2022 08:23:22 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53A8D3F7B4;
	Thu,  8 Sep 2022 08:23:14 -0700 (PDT)
Message-ID: <7b30a064-754e-0528-5142-8446ab5bdc95@arm.com>
Date: Thu, 8 Sep 2022 16:23:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
 iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com> <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com> <YxneJ2RqaatKmoYT@8bytes.org>
 <c11bd109-65cd-39b3-6d7e-2b29208ca2ca@arm.com> <Yxnr1gBIGwdinIkr@nvidia.com>
 <YxnuYTrkC5yoHH84@8bytes.org> <c48211fe-00b1-e679-21b8-00a85bba599a@arm.com>
 <Yxn1IcWk+61ddiCn@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yxn1IcWk+61ddiCn@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-08 14:58, Jason Gunthorpe wrote:
> On Thu, Sep 08, 2022 at 02:47:11PM +0100, Robin Murphy wrote:
>> On 2022-09-08 14:30, Joerg Roedel wrote:
>>> On Thu, Sep 08, 2022 at 10:19:18AM -0300, Jason Gunthorpe wrote:
>>>> What is the use case for having PASID nested under another level of
>>>> translation?
>>>
>>> Virtualization. Basically having a device access process address spaces
>>> inside a virtual machine. That got never put into code, but it was the
>>> rationale behind it.
>>
>> For SMMUv3 it did actually get as far as a prototype[1] before the iommufd
>> work interjected. I believe there are cloud vendors using those patches in
>> their deployments :O
> 
> This is a bit different, this is just normal nested translation stuff.
> 
> AMD decision has effectively nested the PASID under the RID, while
> typically nested translation nests PASID and RID equally under a
> parent table.

As far as I can tell from a quick scan of the AMD spec, it seems 
effectively identical to SMMUv3's S1DSS=1 mode, while the "Guest I/O 
protection" feature is the same as S1DSS=2, treating the RID as PASID 0. 
SMMU has just always had both options.

> I can't think of a use case for nesting the PASID under the RID, in
> every scenario this seems to be problematic. Glad to see it is undone
> with the new HW.

I assume you mean you can't think of a use-case for having the RID 
bypass stage 1/guest translation, since "nesting the PASID under the 
RID" is basically just how PASIDs work. AMD phrases it as "An upstream 
packet with a valid PASID in the PASID TLP prefix contains a canonical 
GVA; an upstream packet without a valid PASID in the PASID TLP prefix or 
with no PASID TLP prefix and an untranslated address contains a GPA". So 
GVA->GPA is per-PASID, then GPA->PA is for the entire RID, which is 
exactly how SMMU stage 1/2 work as well. As far as I'm aware that's 
standard for Intel too, until SIOV where they can carry the PASID 
through to the second level also.

The use-case is that you assume people care about performance, and thus 
are only going to use translation *inside* a VM for PASID-based SVA 
which can't be done any other way, and let guest-kernel-owned DMA 
(without PASID) operate in GPA space to avoid the extra translation 
latency, invalidation trap overheads, etc.

Cheers,
Robin.
