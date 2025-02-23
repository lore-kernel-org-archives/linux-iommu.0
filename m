Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D418EA2
	for <iommu@lists.linux.dev>; Sun, 23 Feb 2025 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320669; cv=none; b=fssnY+PJSJ05Ohr+XrmPP/XzKkhDIYhxyzMu7on+39TeooihUv6So9fIParvUSy0hPCAGnphsWTib0oA3Q+7sl0AhhvpryYcil57x6gHIGa5TYuOe9JI0kAkkJSDCs3mOyd9jxTWsp9sz25xi1WD1Jweioe9vD1OOy8mQ93qvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320669; c=relaxed/simple;
	bh=3jEPQtafbljSOcGs+AcqPyVavr/lR+evcKVRQcWnLHk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OlN9ryvP5mvt8HJNXgsHRFfshRAWGhV21YZe2GHP4w8ow3yDERv3d48xNM8E8HhIk2OYcX/KfxyfbVcMwAG/7SGJcUUtdxw0mNwx2jh7ED4cbjISe19C4ya17vkgULvqiG3ZBzZbHMSm85tJSUPKqgxw0ekVkw1wl44rRKmjl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OptkVnYH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OptkVnYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740320668; x=1771856668;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3jEPQtafbljSOcGs+AcqPyVavr/lR+evcKVRQcWnLHk=;
  b=OptkVnYH3dyZXwNpj9u9uXfd2h1i+01ImNvgTmxhJlzwf8DEXl/RxKLq
   5UNIGDcSv8yv4aheEk+3gduB+W3sF/yjtBybCmfIqcpL03yPaiSVr3W8d
   M9UPJREgu//xZuLZAOKiVd2TFiONRXdOkY7FqKjdNEXRsHo7WedqDZ6Ug
   +rM5L+VxzINrV40mEd4lrFKkfwBnT8BiuUGuVU6ZbgRyECUOajkVeTz3D
   nBKMWjI2WMZS7F+6rhxw+2fydftkqtxqhupj4Lu/Uu2O0/DVYuoVHfvjM
   o5U7T+J8uMZsck0i5FlAJx4Luat9XDw6QGBzyrGv+KsQ7IHNiapo7X0eX
   A==;
X-CSE-ConnectionGUID: g8rZ27ckTRS+y9QmbcwJwQ==
X-CSE-MsgGUID: HcENP6+5RcKIKCwYcTsk3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="44863873"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44863873"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 06:24:27 -0800
X-CSE-ConnectionGUID: 27A9Sw/HS96B/FIwTKoR3w==
X-CSE-MsgGUID: gcHFmGRqRGKYA6vaXfq9Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115792235"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.93]) ([10.124.240.93])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 06:24:26 -0800
Message-ID: <82499eb6-00b7-4f83-879a-e97b4144f576@linux.intel.com>
Date: Sun, 23 Feb 2025 22:24:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux.dev
Subject: Re: Question on context setup for passthrough
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <rz4kc2zxi4fritsbmjsa3ekqncguvnmeir5se3fhu7pzhtgipk@2u6ps3q3gsqz>
 <75f4867f-99b9-4ba9-abf4-f0dc29d08fca@linux.intel.com>
 <v7quonl2qcsweqd4r6e2badd6bdhmzgo4zm4v2k3bxkg4zkffi@zpxi53ai4qme>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <v7quonl2qcsweqd4r6e2badd6bdhmzgo4zm4v2k3bxkg4zkffi@zpxi53ai4qme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/2/22 2:26, Jerry Snitselaar wrote:
> On Fri, Feb 21, 2025 at 04:40:42PM +0800, Baolu Lu wrote:
>> On 2025/2/21 15:16, Jerry Snitselaar wrote:
>>> Hi Baolu,
>> Hi Jerry,
>>
>>> In context_setup_pass_through_cb there is a check that bails out
>>> if dev != &pdev->dev which doesn't exist in the code that sets up the
>>> context entries in the dma domain case. Is there a reason this check is
>>> done in the passthrough case?
>> The check "dev != &pdev->dev" was added to prevent setting a context for
>> a different device that has its own probe path.
> Hi Baolu,
> 
> Why is it different than what happens in the case with the callback in
> the dma domains case? Shouldn't pci_for_each_dma_alias already be
> deciding which devices get called with the callback?  This seems like
> it will always skip setting up the context entry for an alias when
> there is a pcie to pci bridge.

This appears to be a regression introduced by commit <2031c469f816>
('iommu/vt-d: Add support for static identity domain'). Previously, the
context setup for both identity and DMA domains was handled in a single
path, where the condition 'dev != &pdev->dev' did not cause an early
exit. This check was newly added by the commit.

> 
> My initial fix was just the dropping of the check in the callback,
> but I wasn't sure that was correct or not. So I decided to check
> with you, and go back and read some pci spec bits. 🙂

Can you please post a fix for this?

Thanks,
baolu
