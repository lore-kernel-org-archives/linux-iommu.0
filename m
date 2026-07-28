Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78130D40E;
	Tue, 28 Jul 2026 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205625; cv=none; b=JRZ7dkxIp/iLsftOvewpqhYxtS9hRe+7Z9p5ACFHQh5+jG7kLBH0ce9cTEVtHD6Mupl/iu9Ige5otk3Cy8KNyFt7VkzXyROZMPPvVEBB+wSA4zwWE9FPST5yOrlOV7zdWfsQ/m+gsmr5ks3+2dBJQcLN+F8ju6n8rG6OtIWqqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205625; c=relaxed/simple;
	bh=mBnZqNs6JRbn8ZTHIehoByB0RFlPD7Xyr3hM4naS8lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8guAAsgNV8NGCzLoFcAop8pkAvALYekKBgVudyEQlUIxrF/ATDsNMOXpvvvkYfd/PkrHvvcuwmRqJrbNxkZSaquCVqshnXFDAoRYX3g16x7GX2apsnZtLseJ8nJHF1YJv8OLIDPd0sHX+Dn4O1GyMk1ukuVvB1AZSyuokfjsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cohC8hKQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cohC8hKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785205619; x=1816741619;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mBnZqNs6JRbn8ZTHIehoByB0RFlPD7Xyr3hM4naS8lg=;
  b=cohC8hKQdaoAdjMzqf5xpDnhIu5eA5DCAuA8F93IcdtkWHGbJFQQnapU
   qe79ZA5fiL4qR1eCQZHiNap8RxoCP/CpUcgangnOUVnS6SI+SLxrAaqHy
   upneYqaJfaVp6nTH/nXEXWYx7aInD4pCSpahXmnp25AtLm8hyxLR8pU9h
   u0bKqDUoHpI1L148eI2FsQoupXI9tv3qs6s8QG29iR9kHbetufHy+LnxH
   3KzHrFW2awByjHiX/9hXaj13KZntJAqfcGKmObiLpWKUe0Fw3HNRiqjHc
   vsDMNaoTzoX5XzHyLqeyU0r983+IuY3dPDIfX91ANKQ7k3bjGCkYEeQo2
   w==;
X-CSE-ConnectionGUID: Zfnig3KkTRC0rHf4Mc3WfA==
X-CSE-MsgGUID: OZoNs4ciRSKYKMqpqoHM2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="103191408"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="103191408"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 19:26:53 -0700
X-CSE-ConnectionGUID: iXPpEx2/TC+DNrHRNLlCaw==
X-CSE-MsgGUID: XEmm/+dZSgmdd5WlAsvn1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="256222764"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 19:26:51 -0700
Message-ID: <275dbe0d-0b2d-4ec4-9c8c-9bd7ddf06070@linux.intel.com>
Date: Tue, 28 Jul 2026 10:25:00 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or
 a98db518dde2
To: 70sp <70sp@protonmail.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "regressions@leemhuis.info" <regressions@leemhuis.info>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com>
 <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com>
 <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com>
 <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com>
 <7ec374cb-9a0a-4e30-8410-3a028e46cacd@linux.intel.com>
 <5bVscg7a2_H1PPW3HmVtrYv_Xwtti2hzjD065W4OdwsD9rC2gw7sGVEg-2U596VZn8O2LAEfhWeZklRk63ymqNW9220R6R_jjif7BaWol9o=@protonmail.com>
 <82662a17-f9e2-46dd-9881-792412c1dc50@linux.intel.com>
 <X7nc9tQqVxmuR76GYNJnMRkqUTwNVlXTWpH0wGvJeiAHlcLaibPZHRN037p0359GpdmopB_wI2tF2x6EqZF4oY9J697tcTGYwfYMK96FcUs=@protonmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <X7nc9tQqVxmuR76GYNJnMRkqUTwNVlXTWpH0wGvJeiAHlcLaibPZHRN037p0359GpdmopB_wI2tF2x6EqZF4oY9J697tcTGYwfYMK96FcUs=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 05:20, 70sp wrote:
> Hello,
> 
> this regression thread became abandoned unfortunately.
> 
> In case there's anybody who would like to help me (or generally) solve this regression, I am sending all information about what I've found out.
> 
> I had a private conversation with Lu Baolu regarding this issue and we found out several new facts about this. I am currently working on creating and testing my own patches to add backward compatibility for hardware affecting this issue with my limited knowledge of C and IOMMU.
> 
> This issue consists of improper GPU passthrough into VM on a specific platform (Haswell) or a specific GPU (NVIDIA Maxwell - GTX 970). I personally believe (could be incorrect), that it is caused by the GPU being too old and becoming unsupported by referenced commits. The GPU doesn't seem to be using all levels of PTE properly and some data need to be trimmed for proper passthrough but the patches seem to remove (or alter) the trimming functionality.
> 
> The issue is caused by one of these commits:
> a98db518dde246e01ead53617dc0a30d6aaa3752
> c376a3456d8bef43ec556a98c0a04c35086c2737
> 
> The IOMMU code changed a lot since these commits were merged.
> 
> With IOMMU DebugFS enabled these messages appear in dmesg on affected kernels:
> [  107.365019] DMAR: DRHD: handling fault status reg 3
> [  107.365021] DMAR: [DMA Read NO_PASID] Request device [01:00.0] fault addr 0x37fff1000 [fault reason 0x0c] non-zero reserved fields in PTE

VT-d hardware implementation reports a fault with reason 0x0c when,

[Table 30, VT-d specification]
"When legacy mode (RTADDR_REG.TTM=00b) is enabled, a non-zero
  reserved field in a second-stage paging entry (SS-PML5E, SS-PML4E, SS-
  PDPE, SS-PDE, or SS-PTE) with at least one of the Read (R), or Write
  (W) fields set."

In this case, VT-d blocks the transaction and returns UR for the read
request, which probably could explain the passthrough failure.

> [  107.365023] DMAR: Dump dmar1 table entries for IOVA 0x37fff1000
> [  107.365024] DMAR: root entry: 0x00000004034fc001
> [  107.365025] DMAR: context entry: hi 0x0000000000000202, low 0x000000008bda5001
> [  107.365026] DMAR: pte level: 4, pte value: 0x00000000846ce403
> [  107.365027] DMAR: pte level: 3, pte value: 0x00000003c0000883

I checked the PTE values against the page-table format definition in
Section 9.8, "Second-Stage Paging Entries" of the VT-d spec, but I did
not find a clear violation.

There is a similar report at:
https://bugzilla.kernel.org/show_bug.cgi?id=221545

That report also sees DMA faults with reason 0x0c, and was root-caused
as:

"... the BIOS DMAR tables contain reserved PTE fields, this generates
  continuous DMAR faults (fault reason 0x0c) on device 00:1b.0, silently
  dropping all DMA transfers from the HDA controller."

> 
> I would be grateful for any useful information or help so I can finally forget about this and freely use newer kernels. I also know that there are several other people experiencing this issue, and I would be happy if we solved this for everybody affected.
> 
> Thanks to everybody,
> 70sp

Thanks,
baolu
