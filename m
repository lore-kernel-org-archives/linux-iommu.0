Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591C35E94F
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227201; cv=none; b=uEIqH6gsFcyKoQS11iN7Be9QoyEt1pIOjgjo+/7627t9eM3OhruE6I3lb4rwTLN9jc97Jv7HQ/0PATClI1YbODohPDRzH/+NZhPOD0zlsDO8+M2nfSGvIri6CAw2BCH4b1ZsetxN6qtFDgFAtObCPaGovNOUMoVdJCwvM4j/jN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227201; c=relaxed/simple;
	bh=R5gQPQ1kAWX/k2WrVQv0+R/oHESKRuvWGRRsmzpq3jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRvT2AjBqUdpVB32E6cSAh5tXgGKBi1+l3fP/KK/o7+7mPp0HaXRKHr5uUuudM2PFzh+rxdzuuKCM7s7ycD26WOJ4IlxnbZaquY7IU9SZBaMkBoBDZb2M+Mj/qTGG+rUjoebzc97nbRUgv6zMfde2hw9sNT33U/KtYSMcDQBAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3HYgB7f; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3HYgB7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778227199; x=1809763199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R5gQPQ1kAWX/k2WrVQv0+R/oHESKRuvWGRRsmzpq3jE=;
  b=C3HYgB7fTX/o0tI1Ug3/svY6MAI6/HWVS7jwIXNPFUA8782WZFbmg60W
   6Y1M1VMnoG46kxby9tindK3Dvo1IvhSl6amX1BuSxG8zHE3gV4a4IlmxO
   TDxOjea3ru/YARYS9T3vc1AZRoIWSupPgXMs8AV8uzbqt/GFefwC4RGxP
   olfJgVxAyjG3RuBiqnjXN43+klZfX4PV1/w8P0K/dZA2Z4tUaLAne5moJ
   faSDY8QHPs+9lp5F/BhCml4k/9cbuEh+6OVlDv7jexDS/YVzt6ZBqNVi+
   NqQv/O3ZVMU2XqHhbJqnUbExGugTw6H083uoudsboPPi+VY821RH8I1KM
   w==;
X-CSE-ConnectionGUID: 5etsoPTqR+23+V/qXjF3KA==
X-CSE-MsgGUID: P9L4HfmtTDKXwXvNnh82TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90570149"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90570149"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:59:59 -0700
X-CSE-ConnectionGUID: HbjD7DuVSrKFisCKZ130lw==
X-CSE-MsgGUID: +VdyzD4QRUmPsvuxTIUZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241049255"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:59:57 -0700
Message-ID: <d3708d4a-e232-47d6-b807-abfa40b6e93b@linux.intel.com>
Date: Fri, 8 May 2026 15:57:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Disable DMAR for Intel Q35 IGFX
To: =?UTF-8?Q?Naval_Alcal=C3=A1?= <ari@naval.cat>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20260410161622.13549-1-ari@naval.cat>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260410161622.13549-1-ari@naval.cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 00:16, Naval Alcalá wrote:
> Intel Q35 integrated graphics (8086:29b2) exhibits broken DMAR
> behaviour similar to other G4x/GM45 devices for which DMAR is
> already disabled via quirks.
> 
> When DMAR is enabled, the system may hard lock up during boot or
> early device initialization, requiring a reset.
> 
> This issue has been reported multiple times and remains
> unresolved:
> Link:https://lore.kernel.org/linux-iommu/20161205215841.GA20819@beast/
> Link:https://bugzilla.kernel.org/show_bug.cgi?id=201185
> Link:https://bugzilla.kernel.org/show_bug.cgi?id=216064
> 
> Add the missing PCI ID to the existing quirk list to disable
> DMAR for this device.
> 
> Signed-off-by: Naval Alcalá<ari@naval.cat>
> ---
>   drivers/iommu/intel/iommu.c | 3 +++
>   1 file changed, 3 insertions(+)

Queued for v7.1-rc. Thanks!
