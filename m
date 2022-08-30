Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC647C
	for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 01:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661823971; x=1693359971;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g/WWeE3dDMjzGcqcOmiQkfDtGDanYr/MP7cytR+qkDw=;
  b=izE5RVi+SKYgmJvFe99xf9zijGu3WmwpCEgAP0HGIsYOkcLeCtNDOvgB
   2fkhiFrKFWj7t/uusYvQCO8iSa7wu1fi2ySP1fCqrMkNoR3eUGEiuhEnu
   tL9BZrxAYxntHwpIaBpz9WPvCgB5xTQzL9fr7VR6EpuGM6s5AuUQVfSf8
   aMlPxNp8Yuitnkx1mNSSYxN1aeHtN2Vl3rF7bdk1Kyr9aAUFjs1dz0ep9
   N8v764dqCTTcyDd85mFVvxaRjDJqKPjZ4veVOtElDPVlNGk+6T6wA1Uwp
   v8+2/6Uz/lpGplv1RVZ5DDU7IXENdx8nH+WxTk8Zr3prCQ68IGl+tOFAM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293795233"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="293795233"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:46:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672621796"
Received: from hhuan14-mobl1.ccr.corp.intel.com (HELO [10.254.215.208]) ([10.254.215.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:46:04 -0700
Message-ID: <c7d71936-ea06-3a71-d13a-cedd108413b5@linux.intel.com>
Date: Tue, 30 Aug 2022 09:46:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 07/17] iommu: Try to allocate blocking domain when
 probing device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-8-baolu.lu@linux.intel.com>
 <YwjeL2SVmdRpoWb6@nvidia.com>
 <316f6575-59ea-08e3-aaaf-bc1e4f42a574@linux.intel.com>
 <Ywz3A3tHEzY+Sf7b@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Ywz3A3tHEzY+Sf7b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/30 01:27, Jason Gunthorpe wrote:
> On Mon, Aug 29, 2022 at 11:40:24AM +0800, Baolu Lu wrote:
>> On 2022/8/26 22:52, Jason Gunthorpe wrote:
>>> On Fri, Aug 26, 2022 at 08:11:31PM +0800, Lu Baolu wrote:
>>>> Allocate the blocking domain when probing devices if the driver supports
>>>> blocking domain allocation. Otherwise, revert to the previous behavior,
>>>> that is, use UNMANAGED domain instead when the blocking domain is needed.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Tested-by: Zhangfei Gao<zhangfei.gao@linaro.org>
>>>> Tested-by: Tony Zhu<tony.zhu@intel.com>
>>>> ---
>>>>    drivers/iommu/iommu.c | 29 +++++++++++++++++------------
>>>>    1 file changed, 17 insertions(+), 12 deletions(-)
>>> This seems like a lot of overhead to allocate these things for every
>>> group?
>>>
>>> Why not add a simple refcount on the blocking domain instead and
>>> allocate the domain on the pasid attach like we do for ownership?
>>
>> I am working towards implementing static instance of blocking domain for
>> each IOMMU driver, and then, there's no much overhead to allocate it in
>> the probing device path.
> 
> Well, I thought about that and I don't think we can get
> there in a short order.

Yes. Fair enough.

> Would rather you progress this series without
> getting entangled in such a big adventure

Agreed. I will drop this patch and add below code in the iommu
interface:

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3219,6 +3219,26 @@ int iommu_attach_device_pasid(struct iommu_domain 
*domain,
                 return -ENODEV;

         mutex_lock(&group->mutex);
+
+       /*
+        * The underlying IOMMU driver needs to support blocking domain
+        * allocation and the callback to block DMA transactions with a
+        * specific PASID.
+        */
+       if (!group->blocking_domain) {
+               group->blocking_domain = __iommu_domain_alloc(dev->bus,
+                               IOMMU_DOMAIN_BLOCKED);
+               if (!group->blocking_domain) {
+                       ret = -ENODEV;
+                       goto out_unlock;
+               }
+       }
+
+       if (!group->blocking_domain->ops->set_dev_pasid) {
+               ret = -EOPNOTSUPP;
+               goto out_unlock;
+       }
+
         curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, 
GFP_KERNEL);
         if (curr) {
                 ret = xa_err(curr) ? : -EBUSY;

Currently both ARM SMMUv3 and VT-d drivers use static blocking domain.
Hence I didn't use a refcount for blocking domain release here.

Best regards,
baolu

