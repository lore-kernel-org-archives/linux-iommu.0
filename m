Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C60367
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 06:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656396807; x=1687932807;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p0bnmQCen9WNeg7tpcCymPDSOB5Bd4ApV3pk2UCSGa0=;
  b=S7QuSgcULxAB4sa3qel0pyaoJKz3mAEQ6TemN/DnERSeur0+Jb2P3M6f
   C9YzKS1DVmP281smf++rSlY9QydiUSRYdzg2bIzizVF4K5zxmHzwiuGj7
   vITWYIq/UCDH98FxKPnSrAnaEHVPdo3JJ0o4dZ0WYW+MVwcqlpNIw6VUH
   vArNzha38dybs3PTrgNXSsGrzN/jE1tUT3PmcObnyggoX7gSxailNhj5V
   Qtvzj1Cre8WwEzdtrWTdh/k5kPQbOPVg/JOP8TsnbBO+yo3ShdaR5obnl
   GDmIRYJPYlvNgZqpafOiW5VgakmFm8yu5S5W8GrIV2P8kCcpmvTTpKtvm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282739062"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282739062"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 23:13:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646769755"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 23:13:22 -0700
Message-ID: <5f5f7518-415a-ba21-07b0-15f526bbf045@linux.intel.com>
Date: Tue, 28 Jun 2022 14:13:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v9 06/11] arm-smmu-v3/sva: Add SVA domain support
Content-Language: en-US
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 tony.zhu@intel.com
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-7-baolu.lu@linux.intel.com>
 <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220628061320.fO64w9OKwlRPx7q8d7WcmYj51fSaKjFssX2qRZdyO-w@z>

On 2022/6/27 19:50, Zhangfei Gao wrote:
> 
> 
> On 2022/6/21 下午10:43, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Have tested the series on aarch64.

Tony has been helping to validate this series on Intel's platform.

Tony, can I add your Test-by as well in this series?

Best regards,
baolu
