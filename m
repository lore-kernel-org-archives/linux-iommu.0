Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF8F210F
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exERLmoz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702014742; x=1733550742;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2CgvhfqEe7oPS8iAqYFe0ARHhvX5HhGtxuEy7yZmrms=;
  b=exERLmozmdrKcnWDkm4/Cp8p6kipRcu19Ox5l66EM7+G2yaA8xzwiXZ2
   pD5CSSirBe3f0UHTEIfy+k6Bl1zyaHMUq0ZAj1LNnAwwQVWM/GQTWLZbR
   +IbKFpuSfAS0/Gmd96VwUCIA8APfbEAmnHj3evR4Pq1pONU6pa+u/ma5j
   SuakJNDNKu0wtpUnDtJZ/cbzkF886jX80eHG9AFBcyCYgR9gnQzCsD5LG
   nE0rq4Eft5bo026gCSNwEss86yeHxH3t7xU/05n1nlRdMs041Pm0p0TsY
   cymnEKO6JSz8gVoTqZiVE2Pbti95JVapYOdPhhffXzzpT6u0d5e7kBAez
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7685674"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="7685674"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="838016425"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="838016425"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2023 21:52:12 -0800
Message-ID: <c72184d8-693d-43ce-aed9-00a8fc684137@linux.intel.com>
Date: Fri, 8 Dec 2023 13:47:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
 <20231207171742.GU1489931@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231207171742.GU1489931@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 1:17 AM, Jason Gunthorpe wrote:
> On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
>>> @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
>>>   	WARN_ON(!list_empty(&fault->deliver));
>>>   	WARN_ON(!list_empty(&fault->response));
>>>   
>>> +	fput(fault->fault_file);
>>> +	put_unused_fd(fault->fault_fd);
>> I have resolved this in a naive way by just not calling the
>> put_unused_fd function.
> That is correct.
> 
> put_unused_fd() should only be called on error paths prior to the
> syscall return.
> 
> The design of a FD must follow this pattern
> 
>   syscall():
>     fdno = get_unused_fd_flags(O_CLOEXEC);
>     filep = [..]
>   
>     // syscall MUST succeed after this statement:
>     fd_install(fdno, filep);
>     return 0;
> 
>    err:
>      put_unused_fd(fdno)
>      return -ERRNO

Yes. Agreed.

> 
> Also the refcounting looks a little strange, the filep reference is
> consumed by fd_install, so what is that fput pairing with in fault_free?

fput() pairs with get_unused_fd_flags()? fd_install() does not seem to
increase any reference.

Best regards,
baolu
