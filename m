Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D46ED8
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 08:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676277288; x=1707813288;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cwbWY0MYycEcAmZ1WT+ohW6HXdmMTj+4gVFJ3q+KyUo=;
  b=RL9BEic7lDYb6c9dMqyKdwZujDjmA0q3qTM1B4vIBUEmPNuQ3oCgov9n
   z4VkjMmD17DhpbXD4YW/hDcoxhbXfd1C36b3UXo4HpKguXLZogT5Fk5B7
   wM3/YyOO1Lg9djKiPZ6vgY062dfNP9Rsnm0NlPEMM1rpcOqtWMF2d42xt
   vBHAA60L4Ffv41ePoP3iL+SLJa3H2X0+eSzM41+CZ+rLgSLQlkYk88OXn
   ylQuE0ZjZz/DsB9QB9ixmc8qZ+01vlM+oM4aNzHUasEXMpIPSaz16DsI8
   mN83Y4P2WZFPwin+NeqPuXgAg5JvNhRwQHEIPhJVxFx8USjty0NkYupRH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="329468494"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="329468494"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:34:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="701185884"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="701185884"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.207]) ([10.249.169.207])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:34:34 -0800
Message-ID: <ff0b2a68-8aeb-426b-0fb4-010c5e7b20b8@linux.intel.com>
Date: Mon, 13 Feb 2023 16:34:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc: baolu.lu@linux.intel.com, Nicolin Chen <nicolinc@nvidia.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "shuah@kernel.org" <shuah@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <20230210165110.4e89ce55.alex.williamson@redhat.com>
 <Y+bk+GSCPKOJfr1f@nvidia.com>
 <BL1PR11MB527176BE1F6DFA3D2942664D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB527176BE1F6DFA3D2942664D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/13 10:24, Tian, Kevin wrote:
>> From: Jason Gunthorpe<jgg@nvidia.com>
>> Sent: Saturday, February 11, 2023 8:45 AM
>>
>> On Fri, Feb 10, 2023 at 04:51:10PM -0700, Alex Williamson wrote:
>>> On Tue, 7 Feb 2023 13:17:54 -0800
>>> Nicolin Chen<nicolinc@nvidia.com>  wrote:
>>>
>>>> qemu has a need to replace the translations associated with a domain
>>>> when the guest does large-scale operations like switching between an
>>>> IDENTITY domain and, say, dma-iommu.c.
>>>>
>>>> Currently, it does this by replacing all the mappings in a single
>>>> domain, but this is very inefficient and means that domains have to be
>>>> per-device rather than per-translation.
>>>>
>>>> Provide a high-level API to allow replacements of one domain with
>>>> another. This is similar to a detach/attach cycle except it doesn't
>>>> force the group to go to the blocking domain in-between.
>>>>
>>>> By removing this forced blocking domain the iommu driver has the
>>>> opportunity to implement an atomic replacement of the domains to the
>>>> greatest extent its hardware allows.
>>>>
>>>> It could be possible to adderss this by simply removing the protection
>>>> from the iommu_attach_group(), but it is not so clear if that is safe
>>>> for the few users. Thus, add a new API to serve this new purpose.
>>>>
>>>> Atomic replacement allows the qemu emulation of the viommu to be
>> more
>>>> complete, as real hardware has this ability.
>>> I was under the impression that we could not atomically switch a
>>> device's domain relative to in-flight DMA.
> it's possible as long as the mappings for in-flight DMA don't change
> in the transition.
> 

It also requires the mappings in old and new domains are identical. In
another word, any IOVA should be translated to a same result no matter
through the old domain, the new domain, or hardware caches.

A similar replacement has been implemented in the code. For example,
the Intel IOMMU driver dynamically transforms a large range (2M or 1G)
mapping from discrete 4k pages to a super pages to improve the paging
cache efficiency.

Best regards,
baolu
