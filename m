Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364625662
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679664688; x=1711200688;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/EaCGOcI70PVNsBUwHcXREhGFKrzM8ZBTlBxP/TaU2M=;
  b=h9WqsM1RTqqv8ZrElv1LiwzA60ko7Q0IcIKyT/CYe036oVpZrjyKSFPc
   eKJugoxZg0ShOfunl13e9rZvqeh7zvcMdRQSp6KRsE/2D9sICKHqtuyOK
   tJ79SBP1gGnIM+/lDNHo1JJR/YU1WkekFv49nxRnv2TO9vX4Atb9i0s9f
   9i0QCs+ZrgMZLy83rtvFezYzdAiOpqhBYZA5r6h3tlY4d/1/M7WGAdhpt
   q8WBnP0CfYSQhf42OBa0UUEXYXYirZlxfeHrlENA32Mnqif0VWiah2r+X
   S3jpvpNR7ocO90QTYlzT9Py1zc7lHUcT+mSnV/sM+QxhcW31kdTaCnMJn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="337279734"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="337279734"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 06:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="1012247751"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="1012247751"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.177]) ([10.254.215.177])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 06:31:13 -0700
Message-ID: <b5a4a200-e988-99b4-2efc-9dae3a1cb97a@linux.intel.com>
Date: Fri, 24 Mar 2023 21:31:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Content-Language: en-US
To: Steven Price <steven.price@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230324111127.221640-1-steven.price@arm.com>
 <8fda817c-98e7-1988-325d-52d09f3e61a8@linux.intel.com>
 <859ef16c-bf31-78f2-f3df-cf0ff9493b3c@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <859ef16c-bf31-78f2-f3df-cf0ff9493b3c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/3/24 21:24, Steven Price wrote:
> On 24/03/2023 13:16, Baolu Lu wrote:
>> On 2023/3/24 19:11, Steven Price wrote:
>>> Similar to exynos, we need a set_platform_dma_ops() callback for proper
>>> operation on ARM 32 bit after recent changes in the IOMMU framework
>>> (detach ops removal). But also the use of a NULL domain is confusing.
>>>
>>> Rework the code to have a singleton rk_identity_domain which is assigned
>>> to domain when using an identity mapping rather than "detaching". This
>>> makes the code easier to reason about.
>>>
>>> Signed-off-by: Steven Price<steven.price@arm.com>
>>> ---
>>> Changes since v1[1]:
>>>
>>>    * Reworked the code to avoid a NULL domain, instead a singleton
>>>      rk_identity_domain is used instead. The 'detach' language is no
>>>      longer used.
>>>
>>> [1]
>>> https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com
>>>
>>>    drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
>>>    1 file changed, 39 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/rockchip-iommu.c
>>> b/drivers/iommu/rockchip-iommu.c
>>> index f30db22ea5d7..437541004994 100644
>>> --- a/drivers/iommu/rockchip-iommu.c
>>> +++ b/drivers/iommu/rockchip-iommu.c
>>> @@ -124,6 +124,7 @@ struct rk_iommudata {
>>>      static struct device *dma_dev;
>>>    static const struct rk_iommu_ops *rk_ops;
>>> +static struct iommu_domain rk_identity_domain;
>>>      static inline void rk_table_flush(struct rk_iommu_domain *dom,
>>> dma_addr_t dma,
>>>                      unsigned int count)
>>> @@ -980,26 +981,27 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>>>        return ret;
>>>    }
>>>    -static void rk_iommu_detach_device(struct iommu_domain *domain,
>>> -                   struct device *dev)
>>> +static int rk_iommu_identity_attach(struct iommu_domain
>>> *identity_domain,
>>> +                    struct device *dev)
>>>    {
>>>        struct rk_iommu *iommu;
>>> -    struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>>> +    struct rk_iommu_domain *rk_domain;
>>>        unsigned long flags;
>>>        int ret;
>>>          /* Allow 'virtual devices' (eg drm) to detach from domain */
>>>        iommu = rk_iommu_from_dev(dev);
>>>        if (!iommu)
>>> -        return;
>>> +        return -ENODEV;
>>> +
>>> +    rk_domain = to_rk_domain(iommu->domain);
>>>          dev_dbg(dev, "Detaching from iommu domain\n");
>>>    -    /* iommu already detached */
>>> -    if (iommu->domain != domain)
>>> -        return;
>>> +    if (iommu->domain == identity_domain)
>>> +        return 0;
>>>    -    iommu->domain = NULL;
>>> +    iommu->domain = identity_domain;
>> Where did identity_domain come from? Is it rk_identity_domain?
> It's a parameter of the function. In the case of the call in
> rk_iommu_attach_device() then, yes, it's rk_identity_domain. But this
> function is also the "attach_dev" callback of "rk_identity_ops".
> 
> I'll admit this is cargo-culted from Jason's example:
> 
> https://lore.kernel.org/linux-iommu/ZBnef7g7GCxogPNz@ziepe.ca/

Oh! I overlooked that. Thank you for the explanation.

Best regards,
baolu
