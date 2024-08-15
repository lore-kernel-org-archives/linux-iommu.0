Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7D1714CC
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725689; cv=none; b=T5K0R3gzcAsrvp8308QFOCNX9gLDRVhN/Ad8HByTqTpWr2U4+pxTl+LoRH9Z6dUSmbQa8djJ4zgTSrp0AQsStIua3onoEjaMLwM9oynAPhzwjWwG8/YEn7kWcpF6IaTVBjylujSmi5lWKJ6DPw//ZVaZ/8ZT1IdZKtYv4I+L1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725689; c=relaxed/simple;
	bh=ZwHCZxVrRXzqfloVd0bjXYNn3gE5iZuj4Zrr2fE0tEM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gseq1fYBYFFiRjguGTCinp3L+mNN8GIOMqGiyxF0hYjeldcvCxn/GYn5QtpeXrRBF85Zz0VncqqHkFk6Rk9gcr2AmYGTTAMpX11IrG6jXjY78z1/YX1q8n5RusVGACCcqMm+bpeuoCS/kEwPaPLz4BNSIzGuim3yE7v/AVDmcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeokyTN2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeokyTN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723725688; x=1755261688;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZwHCZxVrRXzqfloVd0bjXYNn3gE5iZuj4Zrr2fE0tEM=;
  b=IeokyTN2qZPPHn3BTGG1+uYCbry+JocLYYbsTTBeUbLQ+kA49Pf0VOb2
   ynsn3rvceFRysjI8jP1MybgNQMcJP9VQnBbIQjySOX1EWGYbBItmssWmj
   USGQZ2KFjE0bHMEYIOYzub6uczj4BNMld1D3eZCwXphTsUgFTc8VMwUZa
   GCgajkrj9XqgcL01pdxWPUS+enfp2Xsk339Px8stZkfBMXRbKrSZZRSPp
   IOY7wJBbgFiGoRVPBjW6ez50kpe6cDDjuT3WIappvcE7b5/P1fH+4NEoo
   xSIATGA9GYwCego1uleykFskG6JG5scde/xLPmn88N5V2A6GbHwJ5a2aJ
   g==;
X-CSE-ConnectionGUID: lTr4L2xgQ5iys9V+Q3gPfw==
X-CSE-MsgGUID: NKJgEQbEQSuj4gAmr5PEZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22147633"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22147633"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:41:27 -0700
X-CSE-ConnectionGUID: Lemrv7uyRFm9tRUaao3g6w==
X-CSE-MsgGUID: pY51f5IVRGCxflCu+QdLdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="63493118"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:41:25 -0700
Message-ID: <569a7697-4e5b-445d-a886-41c0dac1a375@linux.intel.com>
Date: Thu, 15 Aug 2024 20:41:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/vt-d: Add helper to flush caches for context
 change
To: Alex Williamson <alex.williamson@redhat.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
 <20240702130839.108139-7-baolu.lu@linux.intel.com>
 <20240814162726.5efe1a6e.alex.williamson@redhat.com>
 <4ff133f3-e541-4a0f-a72c-ce682720e6df@linux.intel.com>
 <20240815063430.70ac9b00.alex.williamson@redhat.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240815063430.70ac9b00.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/15 20:34, Alex Williamson wrote:
> On Thu, 15 Aug 2024 12:47:58 +0800
> Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> 
>> On 2024/8/15 6:27, Alex Williamson wrote:
>>> Hi Baolu,
>> Hi Alex,
>>
>>> This appears to be non-functional and breaks device assignment...
>> Yes. This is broken. Thanks for pointing it out.
>>
>> Perhaps I can fix it by passing domain id to the helper? Something like
>> below:
> Hi Baolu,
> 
> Yes, I did a similar quick fix to prove this was the issue.  Thanks,

Thank you! Then, I will make it a real patch.

Thanks,
baolu
