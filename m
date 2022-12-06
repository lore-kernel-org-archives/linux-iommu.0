Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1529B2
	for <iommu@lists.linux.dev>; Tue,  6 Dec 2022 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670330205; x=1701866205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nX2ztclFO3qGwcE6COoMKeONQMhMiVDg3O5zQH9OE+4=;
  b=PStGIXRbyEyVCv0DLUqklGKy2TQrrbBM/acLcVdV7niO7U5eSjHTaMvy
   MUDzs+iPo5p2VaDSBuKecYkwOVbrQFufzNSoYXELX1SXZyU9sm6z0pD0r
   7ngploi8vqPXbIGVdGcnI6jgT7NCRfp6+d8JtT1oZGyNuHtb2ZgKnh3ak
   gySrdc3BBjWmJRIPA7fye5stgGM5anKRAK+XL4euL9U9xYbXjD6nv1Hvf
   6BxgItoPq9ItkGXDwTqYArFWDxVnWLn+M8iIHjzSIFBtNKW84TKoNPP//
   yjLL9OhS6xmEzUvPWzyrmIkcpyzNlf2cTnpSO7nuy+rs4srRUp51ioOJG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="300033923"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="300033923"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 04:36:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="646202543"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="646202543"
Received: from diankunj-mobl1.ccr.corp.intel.com (HELO [10.249.172.38]) ([10.249.172.38])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 04:36:25 -0800
Message-ID: <235bce13-9855-940f-d43c-cec60f0714dc@linux.intel.com>
Date: Tue, 6 Dec 2022 20:36:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 08/19] iommufd: PFN handling for iopt_pages
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Auger <eric.auger@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>, Joao Martins
 <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, Lixiao Yang <lixiao.yang@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Halil Pasic <pasic@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yu He <yu.he@intel.com>,
 Keqian Zhu <zhukeqian1@huawei.com>
References: <8-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <8-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/30/2022 4:29 AM, Jason Gunthorpe wrote:
> +
> +/* pfn_reader_user is just the pin_user_pages() path */
> +struct pfn_reader_user {
> +	struct page **upages;
> +	size_t upages_len;
> +	unsigned long upages_start;
> +	unsigned long upages_end;
> +	unsigned int gup_flags;
> +	/*
> +	 * 1 means mmget() and mmap_read_lock(), 0 means only mmget(), -1 is
> +	 * neither
> +	 */
> +	int locked;
> +};
> +
> +static void pfn_reader_user_init(struct pfn_reader_user *user,
> +				 struct iopt_pages *pages)
> +{
> +	user->upages = NULL;
> +	user->upages_start = 0;
> +	user->upages_end = 0;
> +	user->locked = -1;
> +
> +	if (pages->writable) {
> +		user->gup_flags = FOLL_LONGTERM | FOLL_WRITE;
> +	} else {
> +		/* Still need to break COWs on read */
> +		user->gup_flags = FOLL_LONGTERM | FOLL_FORCE | FOLL_WRITE;
> +	}
> +}
> +
> +static void pfn_reader_user_destroy(struct pfn_reader_user *user,
> +				    struct iopt_pages *pages)
> +{
> +	if (user->locked != -1) {
> +		if (user->locked)
> +			mmap_read_unlock(pages->source_mm);
> +		if (pages->source_mm != current->mm)
> +			mmput(pages->source_mm);
> +		user->locked = 0;

Set back to -1 is more aligned with the definition of the locked?

Although the value doesn't matter due to the end of lifecyle of 
pfn_reader_user.



> +	}
> +
> +	kfree(user->upages);
> +	user->upages = NULL;
> +}
> +
> +static int pfn_reader_user_pin(struct pfn_reader_user *user,
> +			       struct iopt_pages *pages,
> +			       unsigned long start_index,
> +			       unsigned long last_index)
> +{
> +	bool remote_mm = pages->source_mm != current->mm;
> +	unsigned long npages;
> +	uintptr_t uptr;
> +	long rc;
> +
> +	if (!user->upages) {
> +		/* All undone in pfn_reader_destroy() */
> +		user->upages_len =
> +			(last_index - start_index + 1) * sizeof(*user->upages);
> +		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
> +		if (!user->upages)
> +			return -ENOMEM;
> +	}
> +
> +	if (user->locked == -1) {
> +		/*
> +		 * The majority of usages will run the map task within the mm
> +		 * providing the pages, so we can optimize into
> +		 * get_user_pages_fast()
> +		 */
> +		if (remote_mm) {
> +			if (!mmget_not_zero(pages->source_mm))
> +				return -EFAULT;
> +		}
> +		user->locked = 0;
> +	}
> +
> +	npages = min_t(unsigned long, last_index - start_index + 1,
> +		       user->upages_len / sizeof(*user->upages));
> +
> +	uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
> +	if (!remote_mm)
> +		rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
> +					 user->upages);
> +	else {
> +		if (!user->locked) {
> +			mmap_read_lock(pages->source_mm);
> +			user->locked = 1;
> +		}
> +		/*
> +		 * FIXME: last NULL can be &pfns->locked once the GUP patch
> +		 * is merged.
> +		 */
> +		rc = pin_user_pages_remote(pages->source_mm, uptr, npages,
> +					   user->gup_flags, user->upages, NULL,
> +					   NULL);
> +	}
> +	if (rc <= 0) {
> +		if (WARN_ON(!rc))
> +			return -EFAULT;
> +		return rc;
> +	}
> +	iopt_pages_add_npinned(pages, rc);
> +	user->upages_start = start_index;
> +	user->upages_end = start_index + rc;
> +	return 0;
> +}
> +
> +/* This is the "modern" and faster accounting method used by io_uring */
> +static int incr_user_locked_vm(struct iopt_pages *pages, unsigned long npages)
> +{
> +	unsigned long lock_limit;
> +	unsigned long cur_pages;
> +	unsigned long new_pages;
> +
> +	lock_limit = task_rlimit(pages->source_task, RLIMIT_MEMLOCK) >>
> +		     PAGE_SHIFT;
> +	npages = pages->npinned - pages->last_npinned;

The passed in value of npages is not used?


> +	do {
> +		cur_pages = atomic_long_read(&pages->source_user->locked_vm);
> +		new_pages = cur_pages + npages;
> +		if (new_pages > lock_limit)
> +			return -ENOMEM;
> +	} while (atomic_long_cmpxchg(&pages->source_user->locked_vm, cur_pages,
> +				     new_pages) != cur_pages);
> +	return 0;
> +}
> +
