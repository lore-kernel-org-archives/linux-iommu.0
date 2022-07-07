Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338D368
	for <iommu@lists.linux.dev>; Thu,  7 Jul 2022 02:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657160557; x=1688696557;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ma0fFXFw3M8lIkxpmBs0YMy6P2ngSlPcwZQt0WJ6T3A=;
  b=J5VgCn6scDc+YsrUa7jCztYYPkHpHGfKtXSZN2xbY8jXgZ2+oNOQS7Bc
   gS+F01H2rYRWN+i79NaLybuBPEsSmdfvW7QM2TNAbxcVwSiu9rrXUvhGT
   Ez0MiqFu+kFPD8lDyKE1rmuNWSSc4tmRuO98RDG6rUjok15gF+BCaIlpG
   cO3LuvuXbrhaqGm+0Kc4ho+pokjZHjoeUPvt9LyeQy2VOpjsAbK0H2Rip
   csnZTMNpDzGksxDyx12kzZo6koqyjQrTRVfBJOFBLNz7V6kaX6b1Q75c6
   Hpsv32DWSeos1xqS0swzxxZFPe1GwpfaeSth7fe9yeXrH1j7J+Rnz2M5Y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="282664371"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="282664371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 19:22:36 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650925601"
Received: from hualiu-mobl1.ccr.corp.intel.com (HELO [10.249.171.209]) ([10.249.171.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 19:22:34 -0700
Message-ID: <c2a378eb-0107-ea10-1b9a-a8bdfd7ec71a@linux.intel.com>
Date: Thu, 7 Jul 2022 10:22:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Mike Travis <mike.travis@hpe.com>,
 Dimitri Sivanich <sivanich@hpe.com>, "Anderson, Russ"
 <russ.anderson@hpe.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Refactor iommu information of each
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Steve Wahl <steve.wahl@hpe.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
 <20220702015610.2849494-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52764D1132C2AB21B0A2A1B48C839@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764D1132C2AB21B0A2A1B48C839@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/7 09:01, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, July 2, 2022 9:56 AM
>>
>> -out_unlock:
>> +	set_bit(num, iommu->domain_ids);
>> +	info->refcnt	= 1;
>> +	info->did	= num;
>> +	info->iommu	= iommu;
>> +	domain->nid	= iommu->node;
> 
> One nit. this line should be removed as it's incorrect to blindly update
> domain->nid and we should just leave to domain_update_iommu_cap()
> to decide the right node. Otherwise this causes a policy conflict as
> here it is the last attached device deciding the node which is different
> from domain_update_iommu_cap() which picks the node of the first
> attached device.

Agreed and updated. Thank you!

> 
> Otherwise,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Best regards,
baolu
