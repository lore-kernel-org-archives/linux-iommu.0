Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B97C
	for <iommu@lists.linux.dev>; Mon, 29 Aug 2022 03:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661744433; x=1693280433;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oya5Hnsy4mm0/87tApeZ1XDEJ4Ant4xomrwmja1Ayxw=;
  b=VdjVF7yhcBk3hqyenZ6nhj053pZW7bfYGX2AlpN/HlENNpzDNFtckDlh
   UVbDT0zpTvnea2o2Edf/ZM1iW9WXmjniTOZMWSVAQLYBRI6YvweGq052v
   t0gTSmiH0tafFJXaGmzG29Lxoae2ay7GN5Js0KeSdOPSIlB+zwXuASzFL
   W4KJTN7riDxIClksP6eP2e1cgHx4CaxyArSfiH1PmYiG9OhNdYQ+nxzhI
   LsifYw36GHop+QyVyve8qWfKCjgUjvP1khP86RvWJPhrVGRNgndLXu91v
   JD1T2O+MfqGCzNi1kp/CXXuMYWvYcHBYeXV74x582I1GWKVh4EQi5PlRg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="296074143"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="296074143"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 20:40:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="644276121"
Received: from lizhipe2-mobl.ccr.corp.intel.com (HELO [10.254.210.26]) ([10.254.210.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 20:40:26 -0700
Message-ID: <316f6575-59ea-08e3-aaaf-bc1e4f42a574@linux.intel.com>
Date: Mon, 29 Aug 2022 11:40:24 +0800
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YwjeL2SVmdRpoWb6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/26 22:52, Jason Gunthorpe wrote:
> On Fri, Aug 26, 2022 at 08:11:31PM +0800, Lu Baolu wrote:
>> Allocate the blocking domain when probing devices if the driver supports
>> blocking domain allocation. Otherwise, revert to the previous behavior,
>> that is, use UNMANAGED domain instead when the blocking domain is needed.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Tested-by: Zhangfei Gao<zhangfei.gao@linaro.org>
>> Tested-by: Tony Zhu<tony.zhu@intel.com>
>> ---
>>   drivers/iommu/iommu.c | 29 +++++++++++++++++------------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
> This seems like a lot of overhead to allocate these things for every
> group?
> 
> Why not add a simple refcount on the blocking domain instead and
> allocate the domain on the pasid attach like we do for ownership?

I am working towards implementing static instance of blocking domain for
each IOMMU driver, and then, there's no much overhead to allocate it in
the probing device path.

Best regards,
baolu
