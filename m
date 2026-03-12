Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151733AC0D0
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301916; cv=none; b=N0z3K94yATsBqXkQUyHFvnygss4tMs4kr1VjW0CZEXLpMqbJ+MwA1Qklqi/wxpQrZSYh669HfC88WRBPbnnUzzOGqEKDmjKr/NLwgfEkaJQBCrfHnoAxYjyGHKwUDCAu9PDbI+vQyafzcFHgiZ4/oqf119yI9sZhN5EuHV9m+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301916; c=relaxed/simple;
	bh=KERvVSnS2NkCh4FnuAO/TxRyClMi4pcbBrAqbJBB+c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toI4fv+sRjAkzvaOBA8LLpgB29gWg8em2h5pzmIdjgEmGPzNi6jHKc8h6aYFHhIbaQmp/UjLIEuIVM6BETYv2lKwqcRexJU6hHnTlgETOLzd5kPN5g55Ucxay+CtoDaiq1D6i3bFcBT2Ye7SJcAEbXCqqHY3MXc3xViU7pSXQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOJZuevE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOJZuevE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773301915; x=1804837915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KERvVSnS2NkCh4FnuAO/TxRyClMi4pcbBrAqbJBB+c8=;
  b=XOJZuevERXjq4VvijdiUxKWEg/xrBtzOra+deQnVEiNS/nqXnD1A1zss
   cQ8+lRoDlLFmfSePYo3gCtAN0XPeE/s5z8J+EeuyGFm7jFiCXD9NX6+3h
   wN32lm7q8JTBHHfbiHSJlBxCjhGo7S+PcON7uHyqifOvWDOU45mm8bwIp
   Q4cvJ6oRvYQws8I1ZqB60j9UELaEQXz8Kl4oQbzPb4LAe8Oik77WiiCyy
   4CL7nP5nX9ips5Ds9JxTbryx2CcJRWzcXGexQDaCjwzKOSHQlXx1IFk2m
   fDKqjfkWWemBW8ug+HUXQoYVX35fal9AQb8D7Gsd647n7UX6ApczM6dJj
   g==;
X-CSE-ConnectionGUID: akPek9NdQNamz/2/NYGQQg==
X-CSE-MsgGUID: ForFk4zoR5CPxseRZCsHyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74263530"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74263530"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 00:51:54 -0700
X-CSE-ConnectionGUID: u8M3AqYHQnGaP1U6M1qyWA==
X-CSE-MsgGUID: md/z93TMQK2zQdm6C8SvJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="258643175"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 00:51:52 -0700
Message-ID: <04c6629b-8846-4d4e-98c4-f66e4d9e45b5@linux.intel.com>
Date: Thu, 12 Mar 2026 15:51:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
 <skhawaja@google.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
 <20260309134116.GE3717316@nvidia.com>
 <5b4fc87c-6fce-4388-8a03-8c483c5fdcb5@linux.intel.com>
 <20260311122356.GB1448102@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260311122356.GB1448102@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/26 20:23, Jason Gunthorpe wrote:
> On Wed, Mar 11, 2026 at 04:42:37PM +0800, Baolu Lu wrote:
>>          switch (pgtt) {
>>          case PASID_ENTRY_PGTT_FL_ONLY:
>>                  /* AW, PGTT */
>>                  ue->val[0] |= SM_PASID0_AW | SM_PASID0_PGTT;
> Probably don't need the comments too 🙂

Yeah, the code itself is self-explained.

Thanks,
baolu
