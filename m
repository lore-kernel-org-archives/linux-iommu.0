Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C22E40E
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076943; cv=none; b=mahU7mO8nRmwzK2UuwsXWkrEshW6aPzu/pEojYiEMXBN0kbcri/DSm1Lc/sCnhsFd23qkbCrekHZQwCWYUEFHqVri59+QwEBRkQUk97qukSmhouN2Hr33WxNsO/3xGLIKbZqVLB2ehCnhMUjxfm5x0hy8Ds/gkgLoR/Jr1BBFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076943; c=relaxed/simple;
	bh=bIAEQw9SEREN9bN/g6nTYd3Lo0K9K/nhKhTuWQSKYiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmstzaZFNbqio68mbwGRVdR2HVPxwrCfjY9ruObDXP8n7YjhLDLKczH9dugMedBxlci7j7o0eOESm6Ya8gDm/D5QlpEd71o56R5zZOs8z4oTqDT9Q0ldnrWuJlMnIMoqH3Q/2ZSqcLVBr+vfFY19aCDOMADWOswwKJRGHNqHv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNft5BqQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNft5BqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737076942; x=1768612942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bIAEQw9SEREN9bN/g6nTYd3Lo0K9K/nhKhTuWQSKYiA=;
  b=lNft5BqQpAz4g4yhiemBcKmeCoOY4F4zUNqZshBuJxTD3XOKY7izyKJU
   2d3P6y+aZxNygxKM7q9Rb//HmOOyI531GA2zUnHfwyO1NGa2qwLggu+MS
   D2h9k5ZeYRkd/T20v/7esqScDodn34Q9ckDIf4NGg+PYrbdasZoPzCcoO
   +zPO9B2zWkPXlCT/OG8L8mvFTdoXSvFCqhdc/cfXduMMwOxcjsZCVLIZI
   BD2HdXzvR/4UnCloFcaAXUTxRYfq+5BvZbeIeHZzMH7/uNVSSc/SA2e0c
   gM/vQDRni9cyGVd0XwKXSIuZ2b0q0JG8vLcRgGZgzkkW5NG9Iy9ybyM3Z
   A==;
X-CSE-ConnectionGUID: 4Dew/0LdSz28MTbETe52nQ==
X-CSE-MsgGUID: zCkTEiyQT5ecJTnbhZub7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37729910"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37729910"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 17:22:21 -0800
X-CSE-ConnectionGUID: Z5IBcVErSEqWGPuVqJ7rRg==
X-CSE-MsgGUID: B/z4v21jT/aA4DPJiCZ95A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110295406"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 17:22:20 -0800
Message-ID: <18804ca2-bb8f-46ae-8cce-4c4c3443e027@linux.intel.com>
Date: Fri, 17 Jan 2025 09:20:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Suspicious RCU usage in enable_drhd_fault_handling()
To: Breno Leitao <leitao@debian.org>
Cc: Ido Schimmel <idosch@idosch.org>, iommu@lists.linux.dev,
 dwmw2@infradead.org, tglx@linutronix.de, peterz@infradead.org,
 linux-kernel@vger.kernel.org
References: <Zx9OwdLIc_VoQ0-a@shredder.mtl.com>
 <a45ae593-20b0-4604-bf2e-2870b2c7f11a@linux.intel.com>
 <20250116-ludicrous-mature-ferret-8956dc@leitao>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250116-ludicrous-mature-ferret-8956dc@leitao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 21:34, Breno Leitao wrote:
> On Tue, Oct 29, 2024 at 09:15:55AM +0800, Baolu Lu wrote:
>> On 2024/10/28 16:43, Ido Schimmel wrote:
>>> Hi,
>>>
>>> I have recently enabled CONFIG_RCU_EXPERT and CONFIG_PROVE_RCU_LIST in
>>> our debug configuration file and started observing the following splat
>>> [1] on one of our machines during boot. Searched the archives, but did
>>> not find a similar report.
>>>
>>> Not sure what is the right fix as I am not familiar with this code, but
>>> I can easily test patches.
>> Thanks for reporting this issue. I've been able to reproduce it locally
>> and will work on a fix. I'll let you know as soon as I have an update.
> Have you had a chance to look at this problem? I am still seeing it in
> 6.13-rc7.

Yes. I have spent some time on this, but I haven't yet figured out a
simple way to fix it.

I tried to add the rcu lock or use the dmar_global_lock instead, but
neither proved successful. Perhaps it's time to reconsider the locking
scheme for those lists.

Thanks,
baolu
