Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E2239283E
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055683; cv=none; b=CXBvyrZ38ba9Q4mFt6MtzKl7WY9OGqQSzbu5uOEardlkzfUpvOyvbTzI2P0ef2FvR9Rwss3IeCSR+0bEf7pHUo2PXar0nO5fCi3Jg0Op259nAznJGQZPcCrovdndqZEyyercMAOXF3vjo+l/q8OVrZRV9g5nxtjhv5w31c0WKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055683; c=relaxed/simple;
	bh=Ad4l2ZL1e0oe6iMxHaILa4qa2bycHMZQUcso/Be8Gho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0vfU2MTBazI+/rcP85PDioQApvRUE4+eqNwFYKeWWQ0ykMkX0A0SvA9AXVtZ6EEx0zfJMFt6xZpvIfqbiLrbL2L4eYMxT8feBhELv2UDMoaX8meY3XveYS0gvJAncrpb6OXf53qp3VhhyBgv720sXyQzBevpe1z63hzG70S7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MRQyC2HE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRQyC2HE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773055681; x=1804591681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ad4l2ZL1e0oe6iMxHaILa4qa2bycHMZQUcso/Be8Gho=;
  b=MRQyC2HE5HdTULcEpZFQTBZw1o0rh1yBv9XBru5MYurZhlkDmm4j9ojB
   BEAzNbQREHy055mtiMr3xVvlDJg1rlXVgOj6/sRrUtcQ4MP1L7h4WkB5P
   E2qY3OGAEax5OjB116a0iE5L8ZjBC2e8P+7F7UcUaHJxVOYCPKbrlqc7g
   sXSRRf+1Y+JqfLwX/MVXWN8RU0aINg4jSHtJzNDhNf+CBxw21Fg4DqZaM
   8usmLqNvPc7myhOA++Kgjt1QGEl40CIjKCXF1t8U/01jqSdCedByxN3S2
   rYj2ysQmfLz4BY1jqxK1mvcDMvOACNyGgS0YjZ6dZOs7P+5MtoXXzi3Ic
   Q==;
X-CSE-ConnectionGUID: GgjouKe6TGiEGC8WoCzHvw==
X-CSE-MsgGUID: Aq7QvF3cSBiXqxFrtj83aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="61644144"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="61644144"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:28:00 -0700
X-CSE-ConnectionGUID: 7pUrleTiQhWJjr5Prs5z7Q==
X-CSE-MsgGUID: //Z8YxZXQPuS9At+IRGC+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224648872"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.243])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:27:58 -0700
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: UBSAN: shift-out-of-bounds in drivers/iommu/intel/iommu.h:1101:17
Date: Mon, 09 Mar 2026 11:57:07 +0100
Message-ID: <4867153.LvFx2qVVIh@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260228003405.GP44359@ziepe.ca>
References:
 <11145826.aFP6jjVeTY@jkrzyszt-mobl2.ger.corp.intel.com>
 <20260228003405.GP44359@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 28 February 2026 01:34:05 CET Jason Gunthorpe wrote:
> On Tue, Feb 24, 2026 at 12:16:32AM +0100, Janusz Krzysztofik wrote:
> > Hello,
> > 
> > Please have a look at 
> > https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15478
> > 
> > For me it looks like an IOMMU issue.  I've added there a comment that 
> > summarizes my findings.
> 
> If I recall there are some error flows that will push a 0 length
> gather to the driver, it is supposed to ignore a gather where
> start == end
> 
> Do you think that is the issue?

AFAICT I was observing unsuccessful mappings related to OOM conditions, 
followed by 0 sized unmap requests that were triggering the issue.

Thanks,
Janusz

> 
> Jason
> 




