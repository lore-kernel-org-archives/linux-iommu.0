Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4747C
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 01:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668560674; x=1700096674;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O2mVsPg3LqwYcxpBCQx5f47gOlqoxqZ6F1y9DhEnVJg=;
  b=deCQB9OQCUQoamUXbthQDMTBpBIgqJEaBzIG71/tVmAj36XY3XdIaRTS
   paGF6nbcL7wo+X8jfHm4UPd+qrHEP+iIVvt9HciAqNpKcHO9gxwnZIbDD
   I0AsRlm2VS3B/qWEjJCNnC772xPJq0D5gE0rnFkKSTYxDUlAX4mLD1bgy
   ZdqRnNJ3CFO4sAqe5x9nQhWaJV9I34VV9LZ+YsEVnVcwGYtHfipx5AjYT
   pvaIHtsWjk5ublkntJCaGW2l4EiWBeeMOVtj+/OOsFnpeSR4sJWLBITWL
   O4QlrD9/+cr7c9oZ1ECQmMTwhpw66aS8BRMJFUqsI+0ErpedwHOLKGt/L
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292804090"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292804090"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 17:04:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="641426798"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="641426798"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2022 17:04:33 -0800
Message-ID: <ea0b66fc-8c82-96d5-3731-531881738bcf@linux.intel.com>
Date: Wed, 16 Nov 2022 08:57:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [bug report] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To: Dan Carpenter <error27@gmail.com>
References: <Y3OOTla3Kp3521hk@kili>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y3OOTla3Kp3521hk@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/22 9:04 PM, Dan Carpenter wrote:
> Hello Lu Baolu,
> 

Hi Dan,

> The patch eaca8889a1ef: "iommu/vt-d: Add SVA domain support" from Oct
> 31, 2022, leads to the following Smatch static checker warning:
> 
> drivers/gpu/drm/msm/adreno/adreno_gpu.c:213 adreno_iommu_create_address_space() warn: passing zero to 'ERR_CAST'
> drivers/gpu/drm/msm/adreno/adreno_gpu.c:216 adreno_iommu_create_address_space() warn: 'geometry' isn't an ERR_PTR
> drivers/iommu/intel/iommu.c:4721 intel_iommu_remove_dev_pasid() error: 'domain' dereferencing possible ERR_PTR()
> drivers/iommu/io-pgfault.c:82 iopf_handler() error: 'domain' dereferencing possible ERR_PTR()
> 
> drivers/iommu/intel/iommu.c
>      4713 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>      4714 {
>      4715         struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>      4716         struct iommu_domain *domain;
>      4717
>      4718         /* Domain type specific cleanup: */
>      4719         domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>      4720         if (domain) {
> 
> The iommu_get_domain_for_dev_pasid() function returns both error pointers
> and NULL.  The comments say that it's supposed to only return NULL.  I
> don't really understand what's going with these iommu functions.

The iommu_get_domain_for_dev_pasid() function returns ERR_PTR(-EBUSY) if
the requested domain is not the same type as the one stored in the iommu
group.

But as the kernel-doc of iommu_get_domain_for_dev_pasid() states, type 0
means any match, hence, here @domain is either a valid pointer or NULL.

The same thing for iopf_handler().

Best regards,
baolu

> 
> --> 4721                 switch (domain->type) {
>                                   ^^^^^^^^^^^^
>      4722                 case IOMMU_DOMAIN_SVA:
>      4723                         intel_svm_remove_dev_pasid(dev, pasid);
>      4724                         break;
>      4725                 default:
>      4726                         /* should never reach here */
>      4727                         WARN_ON(1);
>      4728                         break;
>      4729                 }
>      4730         }
>      4731
>      4732         intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>      4733 }
> 
> regards,
> dan carpenter
