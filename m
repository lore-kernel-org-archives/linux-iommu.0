Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0B7D405
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902531; cv=none; b=QmzG62XrZzQJC8cNRrZM5HXXXhYkgudtE0XmWMZIcnm26Rwisi+H4/HdVEkosphfiK1ywAi3RCZ5iNV8DeEiAaz0j5ch+mpvUAMn7XmM/aQZZ9gsMZmjZvcLyb661Oa0r4FnEoA/wiu4nwP1yHJ5hXpzMORQCPbolKgTcHb7LTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902531; c=relaxed/simple;
	bh=skiLNaS3OynVBSdw38XH6gPIue0IpenzfUX6kSiea30=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GOtQyQW6/uodpCLE6BeQi2R6AHJjFGUcMwTBK9snX1t4CIA5XHQcanEF78HGj66hDiiyVqLLWNXW2oI6p7fDqkyK5i5e4XOVGJNunMMjjWN4n0rfzR8g/H45JqqjRKmuBBD9tjLgWDkvg6xqBZ0jIvx6poFGg25QbjhwivSzU+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVrwdmrR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVrwdmrR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902531; x=1751438531;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=skiLNaS3OynVBSdw38XH6gPIue0IpenzfUX6kSiea30=;
  b=SVrwdmrRd37Jjri28XjgSD2ZYd4Z6s2O+KNq5AG7BoMmPmGcgjPMotCE
   k10UEAzIDQHiCJ3ZrNC8ZG3moK1tLRnolgKlC16oG5PiTc7++CTnVkFBS
   s3l0IIzLBUncAVxruNogOqSjMJmOfsKDIEENjADUvl6XEeGBhHi1vfHkm
   twoBXaMxcV9jRhqjGgNvuY+lPw7XKkxUxk5/VppxA3XleBeUU+V1iimOM
   gW6n0eCBDJp4wuGxXDZSg2ntyGxVhcDelHww9S8stNvRhRujUYqlzpN0b
   E7E5la8JfLG9AafNn7KkV5nXBZaCaOKTVStzBWhFi07LLEkVYbh4rVN7l
   g==;
X-CSE-ConnectionGUID: fB5AC4K3Tuehr/GJ7yvvjA==
X-CSE-MsgGUID: 3900Wa7GSc2Oh3LZS053JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28191019"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28191019"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:42:10 -0700
X-CSE-ConnectionGUID: SwpiZGu1SJ6+7oRuLo4zTA==
X-CSE-MsgGUID: HOHVsNC2RseI+/0lRuG0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76510909"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:42:06 -0700
Message-ID: <21baa9fd-124c-4ab5-87da-2b225c4b1efc@linux.intel.com>
Date: Tue, 2 Jul 2024 14:42:04 +0800
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] IOMMUFD: Deliver IO page faults to user space
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <Zn814+VwyCJ/okax@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zn814+VwyCJ/okax@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/29 6:14, Jason Gunthorpe wrote:
> On Sun, Jun 16, 2024 at 02:11:45PM +0800, Lu Baolu wrote:
> 
>> Lu Baolu (10):
>>    iommu: Introduce domain attachment handle
>>    iommu: Remove sva handle list
>>    iommu: Add attach handle to struct iopf_group
>>    iommu: Extend domain attach group with handle support
>>    iommufd: Add fault and response message definitions
>>    iommufd: Add iommufd fault object
>>    iommufd: Fault-capable hwpt attach/detach/replace
>>    iommufd: Associate fault object with iommufd_hw_pgtable
>>    iommufd/selftest: Add IOPF support for mock device
>>    iommufd/selftest: Add coverage for IOPF test
> Small remarks aside this all looks fine to me, send a v8 and I'll try
> to pick it up next week

Sure. I have updated the series and posted a v8 in another thread.

Best regards,
baolu
