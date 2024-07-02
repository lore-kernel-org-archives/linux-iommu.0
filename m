Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9666D1BD005
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935559; cv=none; b=HxqvEvpz2CYHf5Zb+D2YillRjHR1taiCNQPD2DavZIqXNFVL08r5l+kh5pEp3onYXQt+loShV/enHrpLqggj/KYmDdKzxhtrt+phzXhO5UIvZ6U/aZx3zGrgErTHecautO2tCXgLdiRcRgUZZJVjJHMhFF1CSH1/RzRkRvY/jlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935559; c=relaxed/simple;
	bh=wZPV+CEpgfvPai1e8+Vih+T/KY60zCsNw6OOzvBD2xA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYiDn4dNqe8uCurGB/sYZclMWJnsc3n2D7Q8wHTXqWnivBkZbJREJVjA2rz7g7FdzbDgDadAMq30G/399UpzCW5okkodlg5ULu6CgQeMZOvBi/0+v4cAP5VxTqCUJ3xQLQvEvJCaZ0l710guPeTup+EGKzvECzbJwSnW2g45ioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tg7f1Ocu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tg7f1Ocu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719935557; x=1751471557;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wZPV+CEpgfvPai1e8+Vih+T/KY60zCsNw6OOzvBD2xA=;
  b=Tg7f1Ocu1IwuyGRZcDgZO/55kY74+QmMxo4B22h5uaQX5Kgil6bWyr0e
   KUFGrmHzgLBG36ovUxq9/u3ipZKjgFiFb146fQ7+NFTC7hRZWEJvbPcW8
   lobwtv08QMIZ2hZB/JFVayl2nhxl3XWeH+s17+uI+VQlYOOF1wfrpw9ct
   C0imypvFiE3e52WsUQ5XnJwKnit+COAAD4nQyowT7or+WRs1amy+9Dj4z
   g+xC7fCVq+Xj6iJtTXldldjWXSWrxwj8qz4sR0rBZDYv1uTmnpwQve/wd
   RQ/ap0nxTXyZGUDH722qd5wDp6NnY2hkEMX5igmxPUCGyqhddLkL87JTN
   g==;
X-CSE-ConnectionGUID: Dxab8CFSQHaS23uhuptbxw==
X-CSE-MsgGUID: lkImssHERl6XfVlKVyP/hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27719998"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27719998"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 08:52:37 -0700
X-CSE-ConnectionGUID: +iPT0RxbT4+0+gwNWEGrQg==
X-CSE-MsgGUID: zviT4DVLRVu1wnVIJoHRLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50396978"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 08:52:36 -0700
Date: Tue, 2 Jul 2024 08:57:49 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for
 context change
Message-ID: <20240702085749.2e2bbea5@jacob-builder>
In-Reply-To: <28ade99a-13ad-4b01-aff2-711c006856fd@linux.intel.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
	<20240701112317.94022-2-baolu.lu@linux.intel.com>
	<20240701214128.5523a1ea@jacob-builder>
	<28ade99a-13ad-4b01-aff2-711c006856fd@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


On Tue, 2 Jul 2024 12:43:41 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2024/7/2 12:41, Jacob Pan wrote:
> > On Mon,  1 Jul 2024 19:23:16 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> > wrote:
> >   
> >> +	if (flush_domains) {
> >> +		/*
> >> +		 * If the IOMMU is running in scalable mode and there
> >> might
> >> +		 * be potential PASID translations, the caller should
> >> hold
> >> +		 * the lock to ensure that context changes and cache
> >> flushes
> >> +		 * are atomic.
> >> +		 */
> >> +		assert_spin_locked(&iommu->lock);
> >> +		for (i = 0; i < info->pasid_table->max_pasid; i++) {
> >> +			pte = intel_pasid_get_entry(info->dev, i);
> >> +			if (!pte || !pasid_pte_is_present(pte))
> >> +				continue;  
> > Is it worth going through 1M PASIDs just to skip the PASID cache
> > invalidation? Or just do the flush on all used DIDs unconditionally.  
> 
> Currently we don't track all domains attached to a device. If such
> optimization is necessary, perhaps we can add it later.

I think it is necessary, because without tracking domain IDs, the code
above would have duplicated invalidations.
For example: a device PASID table has the following entries
	PASID	DomainID
-------------------------
	100	1
	200	1
	300	2
-------------------------
When a present context entry changes, we need to do:
qi_flush_pasid_cache(iommu, 1, QI_PC_ALL_PASIDS, 0);
qi_flush_pasid_cache(iommu, 2, QI_PC_ALL_PASIDS, 0);

With this code, we do
qi_flush_pasid_cache(iommu, 1, QI_PC_ALL_PASIDS, 0);
qi_flush_pasid_cache(iommu, 1, QI_PC_ALL_PASIDS, 0);//duplicated!
qi_flush_pasid_cache(iommu, 2, QI_PC_ALL_PASIDS, 0);

Thanks,

Jacob
