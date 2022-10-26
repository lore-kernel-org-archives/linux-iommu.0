Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747661374;
	Wed, 26 Oct 2022 12:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666788326; x=1698324326;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ABNx+msEoxiE0Up/NA4YUsZE1sxvOirm9dovIGgVQBY=;
  b=GsfuvhjMq0LAcGVBYYqZ8RF3gOofcKmG+H7yuvSamKeaObrtlBoZFyvy
   O9K0s8Usw0CE2aPGzwLZBpxibdW/8PJyYkfGvmFT9GLsFr+126aq5fK9I
   Ylp1nU6V7YnNhtu8CTpRj9fQsBvd++PrBPHbAvhknnS9e4m4bUXpTFsxF
   verHGZdKxMVICbg1ayqggCfx/McS3J0vImPAT4lhaybTRjsY36OMtReX9
   qKvShGC60PbPqknZPXkcGVTVZa7gdc74MHGALCL742H0ZcBJr2evCyPJL
   ixby2Hh4oG3UqVewDXH1y9msIvrUY9f8eWt9iIe9k1gNamAzcL5C7lkDp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="306663669"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="306663669"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 05:45:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="609938092"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="609938092"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.188]) ([10.254.213.188])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 05:45:17 -0700
Message-ID: <2bcba1f1-e142-a752-eae5-69249f5a1021@linux.intel.com>
Date: Wed, 26 Oct 2022 20:45:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc: baolu.lu@linux.intel.com, Alex Williamson <alex.williamson@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Auger <eric.auger@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 01/15] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, bpf@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
References: <1-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/10/26 2:12, Jason Gunthorpe wrote:
> This queries if a domain linked to a device should expect to support
> enforce_cache_coherency() so iommufd can negotiate the rules for when a
> domain should be shared or not.
> 
> For iommufd a device that declares IOMMU_CAP_ENFORCE_CACHE_COHERENCY will
> not be attached to a domain that does not support it.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
