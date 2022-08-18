Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EB3D88
	for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660823734; x=1692359734;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DD+pip86U2bqu7K4Tuuk0WgzgcsZjPfeOIsmlcT149M=;
  b=Rg7dO67DyS+Vr0XE3zcFUSCA9TOJfNxmQk224Js2RsaromYkjoRhjjpj
   gEPot7PD1ADkw9pVYnmF0IyADJE5A/Spr+RD1+OaOerqpA8XDU0V0xnne
   +0KnWCeMXCougRHQ5zJHOxc2drstdG2lzY7ZFq+TnDv4sKhkU4INSBVnq
   GPOST8XmD3MvzCGTGmVDTSCl7W2BqsqcOQe9MtO9q2ZIRvifl2yLv5MQs
   roU3fAdezjQDscNd/iemcQ+aOPVWU+GeXozWxBa1GWPyN+ja1exDDyJDc
   6eOxA2d1S84YweBiu6SwTjl32ErjJ7lEi7ZZ0C6MyawqJ9EPDz1o98bjh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293528906"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="293528906"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:55:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="668072477"
Received: from gaoshunl-mobl.ccr.corp.intel.com (HELO [10.254.209.211]) ([10.254.209.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:55:29 -0700
Message-ID: <c0de76f1-6b8e-2fc0-a7e7-5d2c29df4509@linux.intel.com>
Date: Thu, 18 Aug 2022 19:55:28 +0800
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
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on
 upstreaming path
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20220817012024.3251276-5-baolu.lu@linux.intel.com>
 <20220817211743.GA2274788@bhelgaas> <Yv1wVfCWHnTdvPOc@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yv1wVfCWHnTdvPOc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/18 06:48, Jason Gunthorpe wrote:
> On Wed, Aug 17, 2022 at 04:17:43PM -0500, Bjorn Helgaas wrote:
> 
>> Does the PCIe spec really allow TLPs with PASID to be routed anywhere
>> except upstream?
> I think yes:
> 
>   2.2.10.2 End-End TLP Prefix Processing:
> 
>   The presence of an End-End TLP Prefix does not alter the routing of a
>   TLP. TLPs are routed based on the routing rules covered in Section
>   2.2.4 .
> 
> Which I read as saying that routing is done after stripping all the
> prefixes. PASID is a prefix.
> 
> Lu, you may want to quote the spec in the commit message to make it
> clear.

Yes. Sure thing. Thank you!

Best regards,
baolu
