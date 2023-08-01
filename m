Received: from mgamail.intel.com (unknown [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184BB1C33
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690879223; x=1722415223;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=REn/Is4TBVpWaD5oECbSAASATiSAsFC/V8UYQ7o8W6k=;
  b=SSqWqan3Uty325x/MiCdWdEO6xsqjBLfOGu3ZYB+3qUBgz/BI4n44laI
   A/dEtj/9z35tr6Js4nykE3425o8vbJ24GaNXk3bPn8/Q6pFuTgktrqrVc
   TlTTH1auVOpqZ5ANWiOjRU+bfqK7h0ZrOlk0/0OkFmumtp415Wojruniu
   9A+q6USFZ0+RLq0o93iOkgDTeewDvg255wygG9Z3IRnjj0CDZMTVYTuKH
   vmkDebkveIX2lvIr6yuS1qpVAkXpbL77XpAY7OpieLX0s/w2kwJ8BRQ/1
   9lSNkDSjRQYdLqVTp6tTLsULqMjANNsPNHDMpQpqQiy7pG92yU2Zi2g8n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366708775"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="366708775"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 01:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="842637504"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="842637504"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.15]) ([10.254.213.15])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 01:40:18 -0700
Message-ID: <b67d6f3f-95f0-0421-49ff-471032de0963@linux.intel.com>
Date: Tue, 1 Aug 2023 16:40:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu: Move pasid array from group to device
Content-Language: en-US
To: "tina.zhang" <tina.zhang@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20230801063125.34995-1-baolu.lu@linux.intel.com>
 <20230801063125.34995-3-baolu.lu@linux.intel.com>
 <1254d61b-1f4e-2ef3-c3dc-95180f26f08c@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1254d61b-1f4e-2ef3-c3dc-95180f26f08c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/1 16:07, tina.zhang wrote:
> Hi Baolu,

Hi Tina,

> Although this patch moves the domain reference pointer from a per-group
> structure to a per-device structure, the domain life-cycle is still
> expected to be managed per-group (i.e., iommu_domain_free() is called in
> iommu_group_release()). Is this what we expect?

The lifecycle of an iommu domain is independent of the lifecycle of the
iommu group that it is attached to. The system domains, such as the
default domain and the blocking domain, are allocated and managed by the
iommu core. These domains are freed when the group is freed.

However, any device driver can allocate its own iommu domains. The
device driver can set/remove the domain to/from the RID or PASID of the
device.

Best regards,
baolu
