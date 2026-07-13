Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D72857CC
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907822; cv=none; b=TgP8rZwptmPs6iRxBYrBrB/fM61HbU2H6cv433q5sPkNcl6qmheNyIGNgQe2wktw5at33g8NIwGFOKVJ+VfuXJpMqBSEsBCK3XnTJ+09ooFdAacFrfD5UpqlVT7usGy1PHnE8kdSA9zBDbSc/zu7qc4APQihKVSewi8EmrbDwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907822; c=relaxed/simple;
	bh=x16NHzTAXMochQ5afCRZ2hNgR3hhog0+bvy7u90uH8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZUTOdVbLKSW9GAIWfOaOxNkFd273BJG1/opxjwPNnKCvjs9K+3l2lT8f9O0m1iQk/1q3RibHvjD4JZYbUTGIiB74xEHC5oTH4gxPwx+mu405uKuR4CfNwNcT2hZiopVhZn9lGu5PwkyG9CJT7shkyJ9apRvAoO9j3xVJCoxrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+G5W2r4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+G5W2r4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783907821; x=1815443821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x16NHzTAXMochQ5afCRZ2hNgR3hhog0+bvy7u90uH8Y=;
  b=N+G5W2r45KTVdGvq1VDDEtVM0UyxehKgAVzKOtQ1AlCnjAEG2s3amgtj
   zdE7chWSInncCyc8zFWWt7k8Fp3vBnMcqM/PloLdeyzfTG3d6iDUzLLTR
   vYP91NxsN5rhBoeCUxCyPavjvFYG0pNIuxSco1ySVcTTNlKA7sfJTva/G
   NwTGiyVoO6DFdaHSWBmBygLchF+iTpYDxZKTeOktXKL13cAeWQkKXCSo6
   DLV5NXhIja62gLKdcu+u0SlLeP3oCEFdOV07ZxdO0EO/5f9y0YUUtgfX+
   4svn7yK4KHBFt62d9z3WqDlwyQoClv6cI1ueSWi4SJXdRlccA+p4yKixA
   A==;
X-CSE-ConnectionGUID: WjAorA3PRqyFx295Lszh9g==
X-CSE-MsgGUID: nOenu9U+Qz6+9znyyq7asg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88340081"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88340081"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 18:57:00 -0700
X-CSE-ConnectionGUID: KHL5G0gCSwu610MMDkoghA==
X-CSE-MsgGUID: HoCWIW4RSNe6gEKpwAEGXw==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 18:56:59 -0700
Message-ID: <775d3d16-f43d-4a5f-9629-4912a4cabd91@linux.intel.com>
Date: Mon, 13 Jul 2026 09:55:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo
 ThinkPad P50s
To: Oliver Lin <oliver@liuxiaozhen.dev>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
 robin.murphy@arm.com, will@kernel.org
References: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com>
 <20260703092348.17583-1-oliver@liuxiaozhen.dev>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260703092348.17583-1-oliver@liuxiaozhen.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/26 17:23, Oliver Lin wrote:
> Lenovo ThinkPad P50s exhibits firmware issues when Intel VT-d is enabled.

Why not fix the firmware issue instead?

> With IOMMU enabled, the system reports DMAR DMA faults during boot,
> TPM 2.0 (tpm_crb) fails to initialize with timeout errors, and the
> machine cannot shut down or resume reliably. Booting with
> intel_iommu=off avoids these issues.

So the driver already provides a command-line workaround for this
firmware issue, right? Why is a hardcoded kernel quirk necessary here?

> 
> Add a DMI quirk to disable Intel IOMMU by default on this platform.
> If the user explicitly specifies intel_iommu=on on the kernel command
> line, do not apply the quirk so that VT-d can still be enabled for
> testing and debugging.
> 
> Signed-off-by: Oliver Lin <oliver@liuxiaozhen.dev>
> ---
>   drivers/iommu/intel/iommu.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)

[..snip...]

Thanks,
baolu
