Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2F26AD0
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730346189; cv=none; b=VyyMGnip8QAQTQpEpwEaJDGyApc7NItg6uGTZA1d4plIDbYR8dHF2RXqfHDOmAweM1btBWS3Vyn/IhEoiZiSOoSV96Xl1rt7V90akSQhybXwtoiQ9HBOpHq6fOeZLiaRI3ImS+83qJRAOA3+P5Q6Fin9FFqX/5tUJ+hpGPpa0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730346189; c=relaxed/simple;
	bh=9NF32TNj4ZYmr4oveqUOvSWtxMqVol++8yROTpzjYA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAMnCo+plYRgi2wM+uAR69Z3SD6EXE8mIy+MQpTkpNGsKf3Wn8e98bVTrnmKsDFBcT+xw6L0nTfMdDxFH/ezUjpM5TARfvwPixTsSRp028co/d8sNdfC76ZtDgT2a/UdzWoZtQpq4hrJys5iExS7XDxX+SKTrWp09fkPLik0b74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WS3UNF9W; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WS3UNF9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730346186; x=1761882186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9NF32TNj4ZYmr4oveqUOvSWtxMqVol++8yROTpzjYA4=;
  b=WS3UNF9WzCQbN7NWdK9WzIx4Jw9d14Hj7HkGTlCed0N6DcONSHE/3Lc2
   d3v3kwNu3wt2WKlVuAAsW8S4mj657HygyCHROIX6TJOFI3dWtz6jma5r7
   VfzY3THG8B5GjO3xHacJFet0lbeM5CC8Bkc06+AMPC3ISd4HlQ+lx9wYO
   ClVFbCIv+eAkGgMzaD8hRbmMasJw6XflQvpY8682RXmW/akQeb2v2f+3A
   sw9xSqH8fKbqq29LoOk0vV/NPQ0M3CihSwRl7UBgsSTenlKvrSZrXeula
   CYS4Ylvr3OGuZmBo+GYTkvGFQShc4J7lTREdSPvVsnYqbTnSdJm8P7QP3
   Q==;
X-CSE-ConnectionGUID: 2ny14P+gSxiysRndAfHb+w==
X-CSE-MsgGUID: l+JJdeX0STm9tp2hNntjIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29514045"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="29514045"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 20:43:05 -0700
X-CSE-ConnectionGUID: daw9IZ7ITHaqHf9TrL7mbw==
X-CSE-MsgGUID: g9mamfELTcG7K2r/u1X2/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82159153"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 20:43:03 -0700
Message-ID: <e4460731-a13f-479d-b092-649123fe079f@linux.intel.com>
Date: Thu, 31 Oct 2024 11:42:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
To: Joel Granados <joel.granados@kernel.org>
Cc: Yi Liu <yi.l.liu@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Klaus Jensen <k.jensen@samsung.com>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
 <ujexsgcpvcjux2ugfes6mzjxl53j3icarfbu25imhzliqskyv6@l7f42nv4fhmy>
 <bbd95589-f4c9-4dcf-939b-c3c407eeed21@linux.intel.com>
 <pdslu36mhfxbzs254tlte2wavfkmecm53xhdtdelm4nfnemt3f@m5ed4hn6zmbl>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <pdslu36mhfxbzs254tlte2wavfkmecm53xhdtdelm4nfnemt3f@m5ed4hn6zmbl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 22:28, Joel Granados wrote:
>>    /*
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index 078d1e32a24e..ff88f31053d1 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -304,9 +304,6 @@ void intel_drain_pasid_prq(struct device *dev, u32
>> pasid)
>>           int qdep;
>>
>>           info = dev_iommu_priv_get(dev);
>> -       if (WARN_ON(!info || !dev_is_pci(dev)))
>> -               return;
> Did you mean to take out both checks?:
>    1. The info pointer check
>    2. the dev_is_pci check
> 
> I can understand the dev_is_pci check, but we should definitely take
> action if info is NULL. Right?

WARN_ON(!info) is duplicate as far as I can see. Accessing
info->pri_enable when info is NULL will cause a null pointer dereference
warning. This appears irrelevant to this patch though.

> 
>> -
>>           if (!info->pri_enabled)
>>                   return;
>>
>> Generally, intel_drain_pasid_prq() should be called if
>>
>> - a translation is removed from a pasid entry; and
> This is the path that is already mentiond
> 
>> - PRI on this device is enabled.
> And this path is:
>    -> intel_iommu_enable_iopf
>      -> context_flip_pri
>        -> intel_context_flush_present
>          -> qi_flush_pasid_cache
> 
> Right?

Sorry that I didn't make it clear. It should be "PRI on this device was
enabled", a.k.a. info->pri_enabled is true. I didn't meant to say in the
PRI enabling path.

--
baolu
