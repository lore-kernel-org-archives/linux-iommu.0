Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F113C80E
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471880; cv=none; b=nZd9yYRzMo+h7YIkrmCp89zyMWh1ISVCrdhVdM/zmP+q++bOPR8uwngMZm0j/wYyhNmYVqBDtOGh0qoIp13oGrT+ZachW7pEzZQ9ppwCWbOL9p1XWaArVC5tZwmBudjI/lOZKnJZO+tgqVLnFMcz0L87a6qYnq2XUvN0OmNHVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471880; c=relaxed/simple;
	bh=vmS5DKfc2Mmr8SibsNeuvDmBmJX5E9bpBypBOCKOTMo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sGXG2rjx9D4WdQUF5h33gTShbmQ/sMLH2sCNZ4rV18b6xCmQwYK7doQD+QsOweDo4gomOD/pLYksnHzKLO/ahTeGfeLUrm7JfremmalXT+2HC75Bl/FB4/gMnGY9l2CS18H29bCyjNUu/IcPDDL4ChfuRsCInmxjjNfFyrkpiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEMshDrh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEMshDrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716471879; x=1748007879;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vmS5DKfc2Mmr8SibsNeuvDmBmJX5E9bpBypBOCKOTMo=;
  b=dEMshDrhBmOzLtg72AHCOmcNiOkSu0F+y8u3qP+J6SC0JMCrsrM9zHgQ
   9iZD+Pv8GXs5tzekSGlrVuKWDfjVCzGyMpYuvOMYa9V1qZg0bbOuD/0W7
   GwsDDxrEdQRkF5VYuImsuOgtI60Wq1rN+gFg+y2glCytNi29mBejunUlv
   sSuZKvqDdPzw6rOikXaTNTfiiyXHrjKbTxCE7cjiU4oKAJOGXGmJIcbqT
   0w10Hd2zijkdBCHO9O41UeUwDjkCSI2Gs6me3w7o2yo5zT6lj15JHW/s5
   qN5TGFPLMEq0AYHQdHR1uQfzAeJQ6hpMCaJrB5rX2LJplN7ctpx2O76Tz
   A==;
X-CSE-ConnectionGUID: viW5c7CFRdm8sh0tY/cveg==
X-CSE-MsgGUID: QV2Bt4eDTx6hDw1qPw41pQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="11661686"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="11661686"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:44:38 -0700
X-CSE-ConnectionGUID: qp+8+VJlTdybd6V3PCJHDA==
X-CSE-MsgGUID: ni+y7hlzTU+m6uwwtJ9VWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="64882751"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:44:36 -0700
Message-ID: <b100a3c4-e5c3-41da-8c02-3a4986b49eec@linux.intel.com>
Date: Thu, 23 May 2024 21:44:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in
 intel_pasid_get_entry()
To: Uros Bizjak <ubizjak@gmail.com>
References: <20240522082729.971123-1-ubizjak@gmail.com>
 <20240522082729.971123-2-ubizjak@gmail.com>
 <c1892ba9-4eae-40fc-b3ab-73d0f82a74ea@linux.intel.com>
 <CAFULd4Z=YkV1Hbs4DikPBwO-6rg8tfDLGeacSCnfbC02E5y+Cg@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAFULd4Z=YkV1Hbs4DikPBwO-6rg8tfDLGeacSCnfbC02E5y+Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/23 21:34, Uros Bizjak wrote:
>>> +             if (!try_cmpxchg64(&dir[dir_index].val, &tmp,
>>> +                                (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
>> Above change will cause a dead loop during boot. It should be
> No, it is correct as written:
> 
> if (cmpxchg64(*ptr, 0, new))
> 
> can be written as:
> 
> if (cmpxchg64(*ptr, 0, new) != 0)
> 
> this is equivalent to:
> 
> tmp = 0ULL;
> if (!try_cmpxchg64(*ptr, &tmp, new))

The return value of both cmpxchg64() and try_cmpxchg64() is the old
value that was loaded from the memory location, right?

If so,

	if (cmpxchg64(*ptr, 0, new) != 0)

is not equivalent to

	if (!try_cmpxchg64(*ptr, &tmp, new))

Best regards,
baolu
