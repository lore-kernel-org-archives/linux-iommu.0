From: "Cornwall, Jay" <Jay.Cornwall@amd.com>
Subject: RE: [PATCH V2] iommu/amd: Fix logic to determine and checking max
 PASID
Date: Mon, 24 Mar 2014 19:33:50 +0000
Message-ID: <99CB3FADB756624A867BE9481439561C334AC1BF@satlexdag03.amd.com>
References: <1394067258-5968-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140324154806.GB2775@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140324154806.GB2775@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Naru, Kim" <Kim.Naru@amd.com>
List-Id: iommu@lists.linux-foundation.org

Joerg Roedel wrote:

>On Wed, Mar 05, 2014 at 06:54:18PM -0600, suravee.suthikulpanit@amd.com wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> 
>> In reality, the spec can only support 16-bit PASID since 
>> INVALIDATE_IOTLB_PAGES and COMPLETE_PPR_REQUEST commands only allow 
>> 16-bit PASID. So, we updated the PASID_MASK accordingly and invoke 
>>BUG_ON if the hardware is reporting PASmax more than 16-bit.
>> 
>>Besides, max PASID is defined as ((2^(PASmax+1)) - 1). The current 
>> does not determine this correctly.
>> 
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Tested-by: Jay Cornwall <Jay.Cornwall@amd.com>
> 
> Applied, thanks.
> 
> Btw, is there any publicly available driver/way/whatever for me to test the AMD IOMMUv2 code paths?

We are testing on a kernel development branch which enables ATS translation from shaders on the Kaveri APU. See drivers/gpu/hsa/radeon at http://cgit.freedesktop.org/~gabbayo/linux/ for the kernel driver.

Testing requires some setup in user mode to construct a PM4 command stream and CIK assembly, similar to the DRM/Mesa UMD implementation. Even then, it is not possible to observe translations directly. Our testing is limited to indirect observations; e.g. modifying VA:PA mappings and ensuring shader loads/stores reflect expected results.

I don't know of a way to exercise the IOMMUv2 code paths without an IOTLB client.
