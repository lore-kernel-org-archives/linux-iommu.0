Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854C3D63
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663936926; x=1695472926;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=clNq8dpfrkH+SH9w6jXyZ7MWDXW18Peooue3eo5KpHE=;
  b=Pv7IFWsTrQFdYeYgp7ur8nPKMFSnIAhRJF5Ok6PHhI2ODbUu9hYY+YNH
   oHt5XXWZAGrRdY/odrNxfnpluRjwbel9DsNlfdpEbuAmeSm2K+iNVEyGq
   1eihWtD8Q0RAS1HWUKKBery3SiTng1aZRPaeLfRhxjl5XlRv4VuiCjHGc
   7kXHp+/1Y9b1RmEFmvUysQXHfNOM649rIajoWO7eCRVPlwjVMu57lEQ7p
   stYFzHnX3JHZSN3U3+Nd5sgLfJ8XlcAgy0eX+bJd1M7yXyEWUX0DuYgdG
   rqGcx/mx5odHcA9NG6x6KmlbHIJJ7kjP207CDIZE/kt2JLAxRzAihsW0s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="287698531"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="287698531"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:42:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="653387301"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140]) ([10.254.214.140])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:41:58 -0700
Message-ID: <a0b43338-183b-3ece-c85a-e904bee27eef@linux.intel.com>
Date: Fri, 23 Sep 2022 20:41:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
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
Subject: Re: [PATCH v13 07/13] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-8-baolu.lu@linux.intel.com>
 <YyyECCbmfsaDpDgJ@nvidia.com>
 <075278e0-77ce-2361-8ded-6cd6bb20216f@linux.intel.com>
 <Yy2jbsaXuoxgR+fj@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yy2jbsaXuoxgR+fj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/23 20:15, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 10:21:51AM +0800, Baolu Lu wrote:
> 
>> At the beginning of this project, I wanted to consolidate the mm
>> notifications into the core. However, ARM SMMUv3 and Intel handle the mm
>> notifications a little differently. Then I decided to do this work
>> separately from the current series.
> 
> It doesn't look really different..

They are essentially the same, but slightly different. For example, arm
smmuv3 provides .free_notifier, and I don't think it could be merged to
the release callback.

> 
> The SVA iommu domain needs two new ops triggered by the notifier:
> 
>   - 'stop using the mm, subsitute a blocking domain' tied to release
>   - Cache invalidate a range, maybe this is just iotlb_sync_map()
> 
> And we could even think about the first as the core code literally
> attaching a dummy blocking domain and releasing the SVA domain. There
> is no reason we need to have every driver do this tricky bit of
> lifecycle management.

Yes. I have similar ideas. We can further discuss it with the real code
later.

Best regards,
baolu
