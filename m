Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAF7F;
	Tue, 26 Sep 2023 03:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695699144; x=1727235144;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j5sV+dy3BVav18WZOciO3rS/x/PvG9EXKQ8HyMFJTGc=;
  b=bRou+LWXf+HA9LV7zpVUYLGDIenRxtqtk8UBiOir6rYMM/aQN/OD5c56
   Ig1wi1ParRBUqJEJonJGgx8atR2SePBUU4jCbZ6oDjcr/u8cxunqNysTw
   EU0FKEp6hsIW/RczYv1y369R1qWWqVQ0RAicySs1eZ9pCtsGittQIPFUR
   +a+cpE6F3dw9KeFdVM2ZdBCeD2mn0ZHAV4sgG4LhIy9A1CGFswCSvnfGO
   fCz6Mevx91Dhq0vScVva5Begdk0mtOwU67lcb5O/BgDTLgwHRVf8QWC8d
   SNlwpV91FiCLDPqQQ/LRIQRh3M+OQRfvYu5jdCnGjTPYB0mPIpwOAkNjn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360849976"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="360849976"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 20:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079535961"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="1079535961"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 25 Sep 2023 20:32:14 -0700
Message-ID: <c43a44bc-1134-d420-459d-1a99a485e333@linux.intel.com>
Date: Tue, 26 Sep 2023 11:28:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 asahi@lists.linux.dev, Christophe Leroy <christophe.leroy@csgroup.eu>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Hector Martin <marcan@marcan.st>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/8] iommu/vt-d: Use ops->blocked_domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <3-v1-8060f06462cc+c0a39-dart_paging_jgg@nvidia.com>
 <ad9644a2-e8a6-d0fa-ad55-f4e0564c39a0@linux.intel.com>
 <20230925114142.GU13733@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230925114142.GU13733@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/23 7:41 PM, Jason Gunthorpe wrote:
> On Mon, Sep 25, 2023 at 10:29:52AM +0800, Baolu Lu wrote:
>> On 9/23/23 1:07 AM, Jason Gunthorpe wrote:
>>> Trivially migrate to the ops->blocked_domain for the existing global
>>> static.
>>>
>>> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
>>> ---
>>>    drivers/iommu/intel/iommu.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> P.S. We can further do the same thing to the identity domain. I will
>> clean it up after all patches are landed.
> 
> I looked at that, and it is not trivial..
> 
> Both the Intel and virtio-iommu drivers create an "identity" domain
> out of a paging domain and pass that off as a true "identity"
> domain. So neither can set the global static since the determination
> is at runtime..

Emm, yes. The early hardware requires a real 1:1 mapped page table. The
recent implementations are no longer needed.

> 
> What I was thinking about doing is consolidating that code so that the
> core logic is the thing turning a paging domain into an identity
> domain.

Yes. It's not trivial. Needs a separated series with some refactoring
efforts.

Best regards,
baolu
