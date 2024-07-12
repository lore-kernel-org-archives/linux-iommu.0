Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3CC13D619
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770005; cv=none; b=HENLBmfmNyF9H5wt1a/vqEXVL5FaAWjeCK/yLYRM8gXCuBKEoplnlsI9OKW/UB+VoggkMWVAM1dBSQakHFVm1kozjTDfWPT5hsz8sLIVTJS9t7y4Ub97iRPA5iz9F0M7//xlf1FMrH29LULVsj0yt+47jY0dM5TM21IN6LPSHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770005; c=relaxed/simple;
	bh=GtGQloxfK5LgILQY13R+z3F8Sj57kv7kh5oCjohfRzw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=faV9QooZzB0WoVqBNjJDhuqIzp+J0URuVxRDRosXZOQFHCqPrkcCgRnPggGiBj23lEN5/Hsblf4xbpwyPtdO47RwWQYlaIfVY6zhAJ74Mt1d6E6hFPZlGp/uf0L63nw0ERvAcr+PUqbhQne2xqreoZKUHnD2nwjZGjYj/24eLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQEqG4xG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQEqG4xG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720770004; x=1752306004;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GtGQloxfK5LgILQY13R+z3F8Sj57kv7kh5oCjohfRzw=;
  b=TQEqG4xG8O6WTiNTZI5JR+TRXerIGbpL/ypIy+1BaziuJwgbshQMh/J0
   /SxVN7eZCZctZM1Pn3JXMDWUb73PtcaVPxAWGsACeOZjF+i2KH5mHbkPa
   ZH77yXovxWCY78anl6DSTJBMWyMrOeMV4WtBrJ8QwkNXJ/Qxhwgc32Xiy
   8q9CpOO/EeftqyOG+qath9JfZCEqY0TAy8324ZRZPE51Hd2i+gNt9oapa
   8X2co2r9l566v+THmjcau6xTuAxCnw9oEskWKP+x12QZfWBcKsjWy8j1D
   PCgIMbt0wrec7mV1lcZMt3KKELyQQJ2M9b7aCmP7POPF5gMA8kbf29N9T
   w==;
X-CSE-ConnectionGUID: UIU9GaN8SZazCtP6ai1+JA==
X-CSE-MsgGUID: ISqZtsA8R4KnWIyVggkR5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="22069020"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="22069020"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 00:40:04 -0700
X-CSE-ConnectionGUID: Mu7QuJ7UT7a74nw0opFkJA==
X-CSE-MsgGUID: aPR4Fm0LRNK17V46R3LpBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48746370"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 00:40:00 -0700
Message-ID: <d00bd03c-9354-49d1-9a52-67091bb01980@linux.intel.com>
Date: Fri, 12 Jul 2024 15:39:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "H. Peter Anvin" <hpa@linux.intel.com>, Tejun Heo <tj@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Sudheer Dantuluri <dantuluris@google.com>, Gary Zibrat <gzibrat@google.com>
Subject: Re: [PATCH] iommu/vt-d: Fix identity map bounds in si_domain_init()
To: Jon Pan-Doh <pandoh@google.com>
References: <20240709234913.2749386-1-pandoh@google.com>
 <b3401333-76d3-415a-b2e4-b148c44b13f3@linux.intel.com>
 <CAMC_AXXy+2Fc8RcGGFh0abL0BRLHwnR-9BmypFNCJpVuPoHmJg@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAMC_AXXy+2Fc8RcGGFh0abL0BRLHwnR-9BmypFNCJpVuPoHmJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/12 15:05, Jon Pan-Doh wrote:
> On Tue, Jul 9, 2024 at 7:45 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>> Do you mind telling me on which platform did you test this fix? My
>> understanding is that modern VT-d hardware supports hardware pass
>> through mode, hence this piece of code won't be executed anymore.
> We tested it in a VM using an emulated vIOMMU setup. Hope that helps.

Okay, that's fine then. If you send a new version, you can take my

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu
