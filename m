Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FD17731
	for <iommu@lists.linux.dev>; Mon,  4 Mar 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541568; cv=none; b=olvzCJLkOk3fS9SI4dETz41YQjalYXL2kPDPU1kIV8mFFvKPbmeSXFjXeRL5jvoQvcwVsxVldtPvoUwmCL7iQ9YoNSAkQMHFx2I59s6MtHGZwtuTchy8KHjQiR3s+Op4OFi7O05mQKkJIinP6wJPaAI0GDXWEuxYXFyCFk9ZElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541568; c=relaxed/simple;
	bh=tnbuylnWDXP+S1B3cukYKyI8V5xN6rznZpSCdmCUPNI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ng1Ab8OtyTYxJVOeqdZhDkwHKHbtIdwppkJGggmNYUVgBeN43brPoSX0ppSCu02xnxLLHigizu3Vy0vtBXjA8ti/acHQCyTy7NvH2W4KZ+gZcA5zk2sjrxUx0Gfq7fkg/2tc0rUdkZrRaWH7qgr7zwnkc1RDlfd2ZAcPj6PdDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFdBIVY3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFdBIVY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709541566; x=1741077566;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tnbuylnWDXP+S1B3cukYKyI8V5xN6rznZpSCdmCUPNI=;
  b=aFdBIVY3hJhY2jtwxoAkpkrUrvZbVSxfI4ELyUv/nKC6Y7KUqPH2b3TR
   OrQfU2arm/pZ+X+aliJifffhhBoKqckT5ureC6yUqzG/QTSIpkgQ7wghF
   M6k00KTZ0azLt/0ZcNAZbEz5LiHxns/vBwRzz5pIrmrr6q/9Ja1e9Wo5j
   k4zkUUb9NtWcgk0Cil3ljh9hm/Kj5FC8m69JNLFmEvIQJhfMsq7aK1Xwi
   FrEPG7nyLfSRaP7W+46GrD+buAbvj0gZ2f9Cr3Pb+GXx0+30D4y1+Erua
   VIERGsMjXn+bndsOliM9kmqxcqJ9Hi9+1tjQZyKQC5WRZ+LXxYvJSAqZ3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="14664912"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14664912"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:39:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13609098"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.18]) ([10.254.211.18])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:39:17 -0800
Message-ID: <31054869-9373-481b-a002-5200e26a7bba@linux.intel.com>
Date: Mon, 4 Mar 2024 16:39:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu/vt-d: Remove scalabe mode in
 domain_context_clear_one()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
References: <20240229094804.121610-1-baolu.lu@linux.intel.com>
 <20240229094804.121610-4-baolu.lu@linux.intel.com>
 <BN9PR11MB527694903CD8E8FBC6C1FB168C232@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527694903CD8E8FBC6C1FB168C232@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/4 15:53, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, February 29, 2024 5:48 PM
>>
>> @@ -2175,9 +2175,6 @@ static void domain_context_clear_one(struct
>> device_domain_info *info, u8 bus, u8
>>   	struct context_entry *context;
>>   	u16 did_old;
>>
>> -	if (!iommu)
>> -		return;
>> -
> is this check only relevant to sm mode or should it be removed for
> both legacy/sm? If the latter please add a note in the commit msg.

This kind of check makes no sense. I didn't take it to sm mode. So only
need to remove it in the legacy path.

Anyway, let me update the commit message to reflect this change.

Best regards,
baolu
