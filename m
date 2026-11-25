Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588305;
	b=4gsOhHSZg58ZQkj1T7blN++dCF8OdQZRYVAq5NilYo7kX0FNtxxwr6xeHEjuQ2AyT5YY
	 ISXPci8ws8rbOPP0iuu5GbnpIRD0guYlc4foQ5VQiRGTQw/IZ89jp/s2fcnbv9YuRPEmO
	 LW4BRYK1IZt37H0JglU++GMUIt4d7tC1jUW8zQgKe8mP9EAVzk6l/Sp37hc7BmHmsQdxC
	 Pat/g0VMAvqttWa03CBsxTnPjMC8FYSe+a6GFm9yguIh5amDIHkNWyDUBpS3YqjI8EF9F
	 5tQy858Q5t1pyfruNP3k6wXcfaoEgsw+ZwqAO+zp1GiF1E9T69zJvLYsGSJ0+2F6/2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588305;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dNNow8pU0EgspMEvDUxBJ5a9af5PUjY1loG/b00zoNY=;
	b=SkgjjTxZR7gJOuVURPmWcdvD/4KilyZtPqnRqlzJRi3B4lu5vPzfL6GRDeZd81Yy5RtJ
	 8BTtEgsTUmujFNIpulHAN7BAGAs+tmOJGvWiRbTxTbXXyb0Otq++kbxfF+xgwZ3s4HReI
	 WUwGlDEUI6Yx8ZGFR2X0FS01rFdG7Tc91lnNPIXCH5HZuK5rK2FIfhJphnMyZhqsecH0c
	 Pm1BEtPnyQekr5gSJo08z7TekihWkBq45ew4Du2aldaJTWdTD2tQx4HeP9+XpEWf8DCuR
	 FQUS666yd4D/PwWsxDjlvd11Fpklt9ujJLkSR40pAoeutSbTwa5738/4O7n6kBm5Dbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KlJoSCPE;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB125606A32C;
	Wed, 25 Nov 2026 06:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB125606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KlJoSCPE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795588304; x=1827124304;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AY2ItQH4n8SPEJWuIkbJCQ/t2DnGTrUZX9TmGLTjYU4=;
  b=KlJoSCPEiDzy09tD0QlTtsFxK/ThykZgsGMo8pYf0dOdKzl3EYzvJ4KC
   DllEL3HVNORKjkXhc96r0qGICglHDgMQu4mnxafSx4ZGfle69Zcmo51nx
   REXy/90oNl59RrQcKzze1iwU6P3jFZElbf0anNKFnXfl31CowsS3QSm5H
   /Cb/qnStC/tD71rCq4qFOyKgBNJEaMItfgVCLnIx3309SEs8U67pYFLIs
   MHA1Y566VN612CJX2cN5IsiQ95iI5o9AMLtKPn1+P94ugv+qUk91oS+Lm
   OiOhT2U0aWaaRdab2nOW7tafZDBM8x0HlPRHPIiQ8pj0MQzudWzuBKGhl
   w==;
X-CSE-ConnectionGUID: ky8nqpBsT+euNtZBqzAPOA==
X-CSE-MsgGUID: bkczVloTQRSc0+ozlqmWWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4467693"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4467693"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 22:30:11 -0800
X-CSE-ConnectionGUID: Xa+KThYJQ/mz0e8mRQ2i5w==
X-CSE-MsgGUID: 4vr1ggl2Q1GgBnGRFyzm0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11891600"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 22:27:06 -0800
Message-ID: <9ce9d375-4a95-4e00-9d62-d6a0b2875a2d@linux.intel.com>
Date: Wed, 25 Nov 2026 14:27:02 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kiryl Shutsemau <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] iommu/vt-d: Refuse system suspend while acquired
 by the TDX module
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-7-baolu.lu@linux.intel.com>
 <CO1PR11MB4835B7CA0A21EB68A2034C108C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB4835B7CA0A21EB68A2034C108C432@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/2026 12:01 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 12, 2026 12:31 PM
>>
>> While tdx-host has acquired an IOMMU, the VT-d driver blocks its GCMD
>> writes. TDX disables S3 by clearing acpi_suspend_lowlevel, but that is
>> only checked after the syscore suspend callbacks have run, so an S3
>> request, e.g. "echo mem > /sys/power/state", still runs iommu_suspend()
>> and then iommu_resume():
>>
>>    suspend_enter()
>>      syscore_suspend()
>>        iommu_suspend()                  <- runs on the acquired IOMMU
>>      suspend_ops->enter() = acpi_suspend_enter()
>>        if (!acpi_suspend_lowlevel)      <- TDX's "S3 disabled" check
>>            return -ENOSYS
>>      syscore_resume()
>>        iommu_resume()                   <- runs on the acquired IOMMU
>>
>> Register a PM notifier for each DMAR unit that supports trusted DMA and
>> refuse PM_SUSPEND_PREPARE with -EBUSY while the unit is acquired. The
>> suspend then fails before tasks are frozen and before syscore callbacks
>> run.
>>
> 
> what about directly returning error in iommu_suspend() if any acquired
> IOMMU exists? at this point all other processes are frozen so no contention
> exists at this point.
> 
> or introduce a new flag or counter (intel_iommu_suspend_disabled) which
> is set/cleared or incremented/decremented along with acquire/release,
> then just check this flag/counter in iommu_suspend().

I'm fine with this. It's actually what I did at first. The only downside
is that iommu_suspend() runs very late. By then, every device has
already been suspended, and suspending a device that is assigned to a TD
may affect its TDISP state. That shouldn't be the IOMMU driver's concern
anyway, so let's start with the simpler approach.

Thanks,
baolu
