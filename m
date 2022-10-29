Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C315C99;
	Sat, 29 Oct 2022 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667027997; x=1698563997;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FhmH3plE0BSGDSUDNHfqp0mdEEM+/mvoaPeadfpkBxc=;
  b=cKE9RF40HPBefhEUxUgjkJ26v2SD+MSP4qyLRq3UZ7ScWvRrzHfcwCM4
   7+PSZSNkJS1h5fHuIiwmVK7HZNCSJH1D8xPkUnH9c03He+3CeoQJQBcWK
   HDIVoxCAWV5OL0vhaNcsPDku7wYMwnhTrrPj3P1zNpiSfnPnAnzqif6w1
   QyaWF5/hNEb7+nqUi7C3Gwq3YVldCEMl+YMN4dVfYcFnyvHa4ux1sfCuG
   hJtiu/aZ8XE3fi97lvt7buoUsdU5nDNS/E1heAHioXBK9acghNrMHSOPf
   Hl7vFgQB55SiIKZ42mbnN4nRPuKpDv3Z5PTTv6GhOVJHgFcibMQjtHyyt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291938928"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="291938928"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 00:19:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="701992575"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="701992575"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.211]) ([10.254.215.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 00:19:39 -0700
Message-ID: <b43a183f-b06a-6abb-0ec8-498e2a62f92d@linux.intel.com>
Date: Sat, 29 Oct 2022 15:19:36 +0800
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
Subject: Re: [PATCH v3 12/15] iommufd: Add kAPI toward external drivers for
 physical devices
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
References: <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/10/26 2:12, Jason Gunthorpe wrote:
> +/*
> + * When automatically managing the domains we search for a compatible domain in
> + * the iopt and if one is found use it, otherwise create a new domain.
> + * Automatic domain selection will never pick a manually created domain.
> + */
> +static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
> +					  struct iommufd_ioas *ioas,
> +					  unsigned int flags)
> +{
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc;
> +
> +	/*
> +	 * There is no differentiation when domains are allocated, so any domain
> +	 * that is willing to attach to the device is interchangeable with any
> +	 * other.
> +	 */
> +	mutex_lock(&ioas->mutex);
> +	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
> +		if (!hwpt->auto_domain ||
> +		    !refcount_inc_not_zero(&hwpt->obj.users))
> +			continue;
> +
> +		rc = iommufd_device_do_attach(idev, hwpt, flags);
> +		refcount_dec(&hwpt->obj.users);
> +		if (rc) {
> +			/*
> +			 * FIXME: Requires the series to return EINVAL for
> +			 * incompatible domain attaches.
> +			 */
> +			if (rc == -EINVAL)
> +				continue;
> +			goto out_unlock;
> +		}
> +		goto out_unlock;

Can the above code be simplified as:

		if (rc == -EINVAL)
			continue;
		goto out_unlock;
?

> +	}
> +
> +	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev->dev);
> +	if (IS_ERR(hwpt)) {
> +		rc = PTR_ERR(hwpt);
> +		goto out_unlock;
> +	}
> +	hwpt->auto_domain = true;
> +
> +	rc = iommufd_device_do_attach(idev, hwpt, flags);
> +	if (rc)
> +		goto out_abort;
> +	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
> +
> +	mutex_unlock(&ioas->mutex);
> +	iommufd_object_finalize(idev->ictx, &hwpt->obj);
> +	return 0;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
> +out_unlock:
> +	mutex_unlock(&ioas->mutex);
> +	return rc;
> +}

Best regards,
baolu
