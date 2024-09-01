Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB04A1B;
	Sun,  1 Sep 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725181939; cv=none; b=V0wkBXRTRckpO/yVurQFWFuBYLLdyhDD61f1+9izcJgnw/QTO4e68MP5i9BEu9KKWbRZUQNzWHk8g/TD8XaJ9ja5IZ1YN2dOKe4aV+AnIXuF5cCiiK3k0REcXG2n9kE8gRB46jqSQhd2I4mR6NxSboljWegLbWostvq/Zuzj0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725181939; c=relaxed/simple;
	bh=vhbxosuo5ppzs+Cd1QVJhsR1FrFtWypTTMALXVWUgLQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=smogtzTczgSW6HofVf0scSqnVCU9W9LuhfA5KOlrfek8jSS05Hgi6m56bsdp2KrNdCYSRmOp28PmcvKkcoMo0eEWivUasaaU9l2l/NEfIjPLA12PmSWoFmhybDyHGOLv9nVTB6PcXXj4+MO7uAmQhjjsNdH2MceJ5jBmV20iPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbvmsaGp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbvmsaGp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725181938; x=1756717938;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vhbxosuo5ppzs+Cd1QVJhsR1FrFtWypTTMALXVWUgLQ=;
  b=RbvmsaGp1Bnho58b3b+RPQKwnPc0XlyofsA5VYeZfi9Qvw4lN0fnx3P1
   SwY9OqbvaxCRoHMksHq+kRxqD6OVICiACsbMM/cYCXv28Twawmxb5MHfv
   79OQ+2aAzh9IZkJee5tJJ1EjmfZJk1vmSU1+kim7cWwX80UNowJKLrDJs
   VGV5qC9suj/qsYn8CqyrirTATUZb+O4X/q1VF+YfEujUUkCuR1FliG5ft
   4NkeXsSSORDYtH+/nQNWKa22rJU3PK0ftKVHdZLe9Z+ZZ7Hu0KGniYKrR
   EACo9ek+4g/GaMl0JoLJ7msUunsyROXp52Inc5UkrVU1ASgwZFena8J/i
   g==;
X-CSE-ConnectionGUID: PDklBp9WRn69wGjmh9cQGw==
X-CSE-MsgGUID: uZkMRB1VQeep8N3PHjp2Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="41255345"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="41255345"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 02:12:17 -0700
X-CSE-ConnectionGUID: y+ZH+4fGRbeU3GeLx6KDtg==
X-CSE-MsgGUID: wH0QC7YrRkWPjftf2f6bZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="87554229"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 02:12:15 -0700
Message-ID: <b909bc01-327a-427b-9900-8f324a229770@linux.intel.com>
Date: Sun, 1 Sep 2024 17:12:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Adam Williamson <awilliam@redhat.com>
Subject: Re: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
To: "Tian, Kevin" <kevin.tian@intel.com>, Markus Rathgeb <maggu2810@gmail.com>
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
 <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
 <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com>
 <CAOcK=CM4Poawy2AN3f6C2ooPdoT=dg4J9Bg1Fu=gsFjvkrBpQw@mail.gmail.com>
 <CAOcK=COEd0njBPGhJ8idaLbaqvATr_zSB1O9dyzwi+fbU8GhqA@mail.gmail.com>
 <BN9PR11MB5276F533DC882B182F1A4C268C972@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F533DC882B182F1A4C268C972@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 8:29, Tian, Kevin wrote:
>> From: Markus Rathgeb<maggu2810@gmail.com>
>> Sent: Thursday, August 29, 2024 4:34 PM
>>
>> With respect to my previous comment I tested to fix it myself (I am
>> not a kernel hacker and do not know anything about iommu etc.).
>>
>> After applying the following change to the v6.11-rc5 it seems to fix my
>> problem.
>> I can connect, disconnect and connect the dock and USB is working and
>> no DMAR error.
>>
> as said there was already a fix posted which is similar to below:
> 
> https://lore.kernel.org/linux-iommu/20240815124857.70038-1-baolu.lu@linux.intel.com/

Above patch has been merged in v6.11-rc6. Please try the latest kernel
version.

Thanks,
baolu
