Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BCA3803DE
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250878; cv=none; b=WRPawNXCCy79d5yd3TSWgOuACB49BgeN4Dj5QBgFJgLZi1gde7aJQvChpcxOLd1iA/RGYGNhv5rNb1jYP/7ZWQwxN4eA9BpydVTiPaO9xwllQXgQQNO3CbD8zVy0bzmVBI8drqlKeAFpOmM85AoY28mdmprgn3bxjn2Me4mGgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250878; c=relaxed/simple;
	bh=Tf++B65BqI9goJyWRFQD12XSAHLb8zatZrIZcNoy2zE=;
	h=To:Date:Content-Type:In-Reply-To:References:Message-Id:
	 Content-Disposition:Cc:From:Subject:Mime-Version; b=LI1w67GFMQ9wzWNbpsNN2QwTKEnpRSmMM4qzmNoKCP5UeTD3v3B0Zsusvm5MnsTM1yM+5WUJNDPw3JV4ukG9vaRnA+E1Bscdr/Q3wF0mlimoubeKDSGGOANREtXOzHO9hk9U8k4DQMuGDbKfH6s5JgGSyr8oDUn34eAf7u/xiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=cQYyEk0w; arc=none smtp.client-ip=209.127.231.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="cQYyEk0w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1788250867; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3EU+WyNrIBc1ywamQPHDaiJRGwSjOx0FUX2meGEGOtI=;
 b=cQYyEk0wRXOQMT7ddV9yVkLJiyNZ+GgGMtUXs4uDByN2KMrmd5aT1fEN/mfyGdsrYITkbP
 clkuW5YQuV1wfnptfGU2vFTlkfXr4hNuwxrlIykwcx6+yGYxvpjvMlMon+Drk47N2bxMKA
 dPbGk2iexOWV2sYaAE1Fs3315ZTu5qmZL8m/IIXN+ghIsmI5HFM0iEbrV7ZJGiqDrJALmJ
 mIP/cbTaHZRzpmgq/toNPeo1li+UbMtV/XCCtH9fx0/R3hdK76aYou5OQV+Cx2bSBkR+P0
 G5bEpC7WySbBbyGbJBQlH7RyVtXzXINDHeASlC2pvrMYt5hEiX4QGHwZnOUavQ==
To: "Jason Gunthorpe" <jgg@ziepe.ca>
Date: Tue, 1 Sep 2026 16:21:02 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260827131025.GF1449020@ziepe.ca>
References: <aoq8VGFL/Mdjd/M5@hostpc> <20260827131025.GF1449020@ziepe.ca>
Message-Id: <apaK7okXkiSLwspN@hostpc>
X-Lms-Return-Path: <lba+26a968af2+d210fe+lists.linux.dev+liuzhaoyu.zackary@picoheart.com>
Content-Disposition: inline
Cc: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>, 
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
From: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Subject: Re: [PATCH] iommu/sva: remove iommu_sva_present flag
X-Original-From: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Received: from hostpc ([183.129.139.234]) by smtp.feishu.cn with ESMTPS; Tue, 01 Sep 2026 16:21:04 +0800
Content-Transfer-Encoding: 7bit

Thank you, Jason.

Hi joro, will, robin, baolu,
could you help merge this patch?

Thanks,
zackary

On Thu, Aug 27, 2026 at 10:10:25AM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 23, 2026 at 05:24:36PM +0800, Zhaoyu Liu wrote:
> > The global iommu_sva_present bool merely mirrors
> > !list_empty(&iommu_sva_mms) under the same mutex. Remove it and rely
> > on list_for_each_entry to handle the empty list case, which is a no-op.
> > 
> > Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
> > ---
> >  drivers/iommu/iommu-sva.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
