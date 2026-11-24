Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500778;
	b=X/BCqv85aaTdK2aY5dEFQwBW5hsRFzN7iqXUB2aAjifMb48rSB5SPTVGp8Tk/K4g9/SK
	 B77J9ohcJag3zpNtYTIahvqju301OVDOyRXYxlU3r3vZxIF1PN/Q8j8BDg2M+jmtp9jBR
	 IeaS8KRH+qW3NtCuPc1BW+PVTsWKYQD8YZ6DQhM8ZAYHlFCl8JPEWGmSYMIIzPLnzT2Kl
	 5KP9HF9WAcbzKD3k8I+ms+stxOlQyd3UEVVcvWkdNOh7+hOFjAMGHTRXV+1WCs8ju8AzJ
	 i5AvaxFGeiI3W5XWbYYk+x2iwnuv2JaKp6GzKq5g32H9XN4SIHi/IRkLttQaOOabI4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500778;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QzdUh4XotWO4fMpwdWgdpxjmPXBWaEs7LRNsn6Vs8uc=;
	b=KIh8/qI2UCdc23YxJg4fNq6h6tD7QIVhuPs6ubyGAaEBprLmuiRPTRDPDvs865UzdBSu
	 qXqC0hWHDkCmQ72ZVAdH36kGNnLdXoYjrYmqe+YshRcTCgLfUylxFdrILPF+rRK3GtXGd
	 apB2RiELNp41SPNVZrO+8ekOlJcZUAv4Cqv/xg2bxrYxvEN5QOdhtA9rDRL0xswAKFT3e
	 Bcz2AmBu3AiJTSgMNonpto4wmg2uijxjbsUHs9JFlqsdjiTTVeSAWWJEHZM1oxLVQOhKL
	 t9TLq3tz6pJsrXN6/WhdyGQgiy3+uY//RoP/xZqSKz33D+rpmR7qhVpTmCo+FtOhKWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PpMwdelt;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EFB606A33B;
	Tue, 24 Nov 2026 06:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2EFB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PpMwdelt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795500777; x=1827036777;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rdPPUatwCGdhqseI0PStwl7g1cIqszizyHH+SlMOlkE=;
  b=PpMwdelt66ywM82RwzODCocmVkLXnuPTbbvRtu1QTRSSgPn5OOIK3nbU
   6SPOqQgiShpba+B8RG620HTg3uzMbUT1C/EYPRK1PHgKH0DS80ooLf8By
   4vcnBwGdJRdFIwG3OHSi18oGRBi0lhM5w2fS3UeAf6ZhbQadm+5lHdTnj
   K8JBFtdPJynhO8TU/oyVFczt2k7Uc7jnAZ6nJL9JG1aXmGo2Caqdw3BZ6
   Xn/a2MsxdFDQ+T+LxoGZetAWUjvDiRW+BO4r4xYG1CLs0ebji5Mtxt06E
   3Dn6LRLN4yvO0/gogaGnV8w1s+kZsikMkOq6QxtDOG9zxhqcGykRGJQvx
   w==;
X-CSE-ConnectionGUID: 6g2TE4ISQVCVC24ZYpxIKw==
X-CSE-MsgGUID: PjdoIS7MSCS3ht+P3cHF2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4336473"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4336473"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 22:07:07 -0800
X-CSE-ConnectionGUID: mh6gCppTTdmWalw5M2OvVw==
X-CSE-MsgGUID: URJvYw2ZSbCyOJUPgQ8oPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11688573"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 22:07:03 -0800
Message-ID: <9e7e8ed4-8f42-418e-831f-293614ef517d@linux.intel.com>
Date: Tue, 24 Nov 2026 14:07:00 +0800
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
Cc: baolu.lu@linux.intel.com, "Gao, Chao" <chao.gao@intel.com>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "x86@kernel.org" <x86@kernel.org>,
 "kas@kernel.org" <kas@kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v3 3/9] x86/virt/tdx: Export Dynamic PAMT helpers to
 tdx-host
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-4-baolu.lu@linux.intel.com>
 <awQUsufmV3NipqGX@yilunxu-OptiPlex-7050>
 <305d702ec6b5ef383115d3da9767df1ea6860da8.camel@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <305d702ec6b5ef383115d3da9767df1ea6860da8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/2026 12:28 AM, Edgecombe, Rick P wrote:
> On Mon, 2026-11-23 at 18:25 +0800, Xu Yilun wrote:
>> On Thu, Nov 12, 2026 at 12:30:48PM +0800, Lu Baolu wrote:
>>> With Dynamic PAMT, any page handed to the TDX module needs PAMT backing
>>> first, via tdx_pamt_get(), and must drop it with tdx_pamt_put() once the
>>> TDX module gives the page back. Besides KVM, the tdx-host driver now
>>> hands pages to the TDX module: the IOMMU_MT pages for TDH.IOMMU.SETUP.
>>>
>>> Export the two helpers to tdx-host as well. A symbol can only be
>>> exported once, so replace EXPORT_SYMBOL_FOR_KVM() with an explicit list.
>>> Only kvm-intel calls these helpers in KVM.
>>
>> We are seeking for some simplified intial implementation without DPAMT
>> for TDX huge page feature. So we could also drop DPAMT support for TDX
>> Trusted I/O currently.
>>
>> As an temporary solution, we can disable TDX Trusted I/O if DPAMT is on.
>>
>> for example:
>>
>> static inline bool tdx_supports_trusted_io(const struct tdx_sys_info *sysinfo)
>> {
>> 	if (tdx_supports_dynamic_pamt(sysinfo))
>> 		return false;
>>
>> 	...
>> }
> 
> Yes, let's try to make DPAMT support optional for the initial upstream TDX
> connect target. We can add support for it in follow on patches and keep the
> initial code sets smaller. In order to facilitate this, we need to add a kernel
> param to control enabling DPAMT. I will send a patch soon.

Sounds good. I'll temperately drop the DPAMT support in the next
version.

Thanks,
baolu
