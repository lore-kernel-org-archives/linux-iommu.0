Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609D134B1
	for <iommu@lists.linux.dev>; Tue, 18 Jun 2024 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674685; cv=none; b=n7kIvCeyOLgFof6Lx0uWmXumX/SzdMrZwUD84emPVgMrLgjfVFnvzN3qg3Xrbe2gxu1Y+C74UwEv+NAueAvfqOqpJg6EB17YTRV0A8Y6Nlc4ZbOm3Lkv6xaRMJs8GtpGMImQMa35de8OPZfJKUF7lWzO+E+U5xf4M8uIHWlyDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674685; c=relaxed/simple;
	bh=4SfRuGLXuOtfgs+VhCcT8scU2Nzh8VcPuJvjNReQd84=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FsBM7cQFmqK6NmDsDVDiyELJKv+6ZiSFju8wefdI8lIU3Dj/bffxyO1ZEZj3rrjUVVNk5wopCNs54GkU6FdZbsvs8r/q2j7LYZgxkhg1rTQUsb4ypcgOdfARABn3Wi1ROMUnhUZqKKIzlHniAS2T3YMApyBbsO0HCHqAnR+xGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lI0yUzCH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lI0yUzCH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718674684; x=1750210684;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4SfRuGLXuOtfgs+VhCcT8scU2Nzh8VcPuJvjNReQd84=;
  b=lI0yUzCHVwEuF+BzJJIs5kDFHt+SKXTVzeF7RbvzHcRQl19Bz96zfxZx
   v6/zAGv5akfLG5V7EqFD4V/XFeOJlAx6pbL7xZj4d+PTmlJcC791MfGQz
   RS15ekdM36JNlW1M4qIIVe5mSvbkZTNt/T4f4RLMcdqzOyWmyHPS+YU/N
   3FQtq+0BNdd/t2PqnQIs1R5l5l0hhhZpesF37PofiXeoQyeBSl7m/xX6s
   mNjnnHD1VgeFHz1sLqo383lk6sC6QfZTG7g8OBWpniQU5rOEj9m5lU+Q6
   hYHT9bwVPaO5MKfRoGU1jJkZ8/xQCXo0/rtJv2v5Zlwc2WyTSUr1yQINQ
   w==;
X-CSE-ConnectionGUID: Fn8F8wShQxOkKC1+VHRTIw==
X-CSE-MsgGUID: FOivSR5FQyWNjggs26XSWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26158145"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="26158145"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 18:38:03 -0700
X-CSE-ConnectionGUID: Ddl5w9urQ/iFSVCmAUcTRg==
X-CSE-MsgGUID: kIYlmEebQyW7v5j/rRk+lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41481150"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jun 2024 18:38:00 -0700
Message-ID: <dea1adb9-2980-4c7b-8ddd-c7ed800f983c@linux.intel.com>
Date: Tue, 18 Jun 2024 09:35:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 03/10] iommu: Add attach handle to struct iopf_group
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C5ED6E9CEB0B22B0CC108CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C5ED6E9CEB0B22B0CC108CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 3:41 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, June 16, 2024 2:12 PM
>>
>> Add a new IOMMU capability flag, IOMMU_CAP_USER_IOASID_TABLE, which
>> indicates if the IOMMU driver supports user-managed PASID tables. In the
>> iopf deliver path, if no attach handle found for the iopf PASID, roll
>> back to RID domain when the IOMMU driver supports this capability.
>>
> 
> above is stale.
> 

Yes. "a new IOMMU capability flag, IOMMU_CAP_USER_IOASID_TABLE" should
be changed to "a static flag in iommu ops".

Best regards,
baolu
