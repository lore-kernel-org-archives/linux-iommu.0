Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B7185D
	for <iommu@lists.linux.dev>; Fri, 29 Sep 2023 03:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695958885; x=1727494885;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zsCU52fX3PPt8P6v3VMwtZ6PQQEa+bGuLeJMS+b7hmI=;
  b=lDiE8XGzKpoaBs0I5hlrRqUXVazsY37ksUsR2zvmh/sXxC3WPVPuaMri
   kURJ1gqqSkVg74nbe3nGU1LAQbBYDXL1RZ8tvKy+JaBhbSVLdwEOeKmVE
   BrwH5FrfNY8HZF+ly0IhF0z9dGipSfAp4K8jNzOeDoJP+UCelezb5HS85
   J5ICj1LgGcla3BOI1oBw7AeGwPkXjIzyxrIV2m6t31+BA8nabrS5Djez3
   xNWQbTGrqNziGBiqKgqN7v07v+PyITX4jDNzv0NnnRHT8hDwmqYZaToth
   rsZ5bwPc1euRDlOZlOlHy9AkKC16gSvz9BgZLl+r8Dbkoez6Ai/pS6adp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="382128856"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="382128856"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 20:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="923490902"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="923490902"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 28 Sep 2023 20:41:18 -0700
Message-ID: <4eb2cbf4-e7de-421a-5d27-1d287632ef1e@linux.intel.com>
Date: Fri, 29 Sep 2023 11:38:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 6/6] iommu/vt-d: Add domain_alloc_user op
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-7-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230928071528.26258-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/23 3:15 PM, Yi Liu wrote:
> This adds the domain_alloc_user op implementation. It supports allocating
> domains to be used as parent under nested translation.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
