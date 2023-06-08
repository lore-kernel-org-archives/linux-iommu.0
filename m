Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB75628
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686211668; x=1717747668;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dSAQH3qaMfODUo4p93PDtwLS0FxoeEOyJbm4yEGJPzE=;
  b=lyU+wzDXeIWGF7QNyqCEYwvT+r+/81e4SDTQ+0sCDU/djMM32d2IO0FX
   nbQpYhr2qEWbzaHzBnr9Z3l1ydtVedqgoO4qcTRiE6HfrWDyFv8XtRvIm
   vAqH6TgBA68RDygpGE0+dj6cAyOgX1iyfR9epMcNWxUcUbC33vtK72QNy
   p/lpaXWE+HffT1TmnNNm1BB+Mjtc5hg52uq6DpIX9hd+Ul31CKZFfPDuL
   k9UdcEouhj4vp9jIcOhuCP64Ed52pVoP8bnTXJ5+NKBYKBzyjinPi5fd0
   bYOxjDQUr3WIruogpMJHlzvR1jIPA2ogVG+2Pp84VYoYKz4oqaw+zKjq8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="356097236"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="356097236"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="687295041"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="687295041"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.30]) ([10.254.210.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:07:36 -0700
Message-ID: <097a2abf-e817-99ca-1f31-dbd439aaade8@linux.intel.com>
Date: Thu, 8 Jun 2023 16:07:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 07/10] iommu/vt-d: Add iotlb flush for nested domain
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-8-yi.l.liu@intel.com>
 <BN9PR11MB52768C95F6E9B943066F39218C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB752919431F624E8E3EFE1C38C350A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DS0PR11MB752919431F624E8E3EFE1C38C350A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/6/8 15:14, Liu, Yi L wrote:
>>> + *                                              stage-1 page table cache
>>> + *                                              invalidation
>>> + * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
>>> + *                           leaf PTE caching needs to be invalidated
>>> + *                           and other paging structure caches can be
>>> + *                           preserved.
>>> + */
>> what about "Drain Reads" and "Drain Writes"? Is the user allowed/required
>> to provide those hints?
> All other comments got. For these two hints, the two flags are from the IOTLB
> Invalidation descriptor. Per below description, the hardware that supports nested
> should support drain and does not require software to ask for it. So it appears no
> need to define them in uapi.
> 
> "Hardware implementation with Major Version 2 or higher (VER_REG),
> always performs required drain without software explicitly requesting
> a drain in IOTLB invalidation. This field is deprecated and hardware
> will always report it as 1 to maintain backward compatibility with
> software"

Make sense. Perhaps we can also remove below code in
__iommu_flush_iotlb():

         /* Note: set drain read/write */
#if 0
         /*
          * This is probably to be super secure.. Looks like we can
          * ignore it without any impact.
          */
         if (cap_read_drain(iommu->cap))
                 val |= DMA_TLB_READ_DRAIN;
#endif

Best regards,
baolu
