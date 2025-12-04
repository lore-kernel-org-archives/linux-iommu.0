Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E08220F2A
	for <iommu@lists.linux.dev>; Thu,  4 Dec 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872394; cv=none; b=SXBOcgYQRmIgjyuGiHlsqIKSjhtCjfKrXwVUmUIf+R8VpomQ2m1BBpEnueS75Mb+u+9/A/AwdMSYJ4t5cCJVYbsIWlD6FiLHXP0mYzUOQ26LQY4WtOcQrx0LCF1B3XmK8kXxyZk6n+2pO2qaYdBO4uaHDS2aJtKm6qBTVl9XACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872394; c=relaxed/simple;
	bh=mzsIcQ1Q2qE6810fGcMxl2s3YOBI5XNf7ZOHO/ngnH0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAHIxDHYLTmzIxwRcN1Bw1fHZmNiiC7Ay+4bp91PIKs9R60/lWSb7Xyy9NfxMn+yiaNayGoVaeJk672egzF9SfLXPtyqzJqCL+kw3y6XwojE5zrhq7yM+mbWMH0HqLqmKC9+wQcKlVBjEd9cG7WANnzkI63GGQs7we8rAZi+sRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dMjTK6gwbzJ46CH;
	Fri,  5 Dec 2025 02:19:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AED740086;
	Fri,  5 Dec 2025 02:19:42 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 4 Dec
 2025 18:19:41 +0000
Date: Thu, 4 Dec 2025 18:19:40 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Pavan Kondeti
	<pavan.kondeti@oss.qualcomm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <jean-philippe@linaro.org>, <praan@google.com>,
	<smostafa@google.com>, <robin.murphy@arm.com>
Subject: Re: PRI support in arm-smmu-v3 driver
Message-ID: <20251204181940.000062ab@huawei.com>
In-Reply-To: <20251125180353.GC520526@nvidia.com>
References: <1256faaa-e9cd-46a6-9a42-25aa74b984a8@quicinc.com>
	<aSXupxMeHLajOmDW@willie-the-truck>
	<20251125180353.GC520526@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 25 Nov 2025 14:03:53 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Nov 25, 2025 at 06:00:07PM +0000, Will Deacon wrote:
> > [+iommu list and usual suspects]
> > 
> > Hi Pavan,
> > 
> > On Tue, Nov 25, 2025 at 02:22:05PM +0530, Pavan Kondeti wrote:  
> > > I am trying to understand IO fault handling in Linux w/ SMMUv3. While reading
> > > the code, I understand that SVA domain creation allows taking IO pagefaults.
> > > arm_smmu_enable_iopf() checks if the master support stall upon fault
> > > feature or not. How do we handle page faults for PCIe devices, for which 
> > > transactions cannot safely be stalled? IIUC, The PRI handling in the
> > > driver i.e arm_smmu_priq_thread()->arm_smmu_handle_ppr() is not doing
> > > anything. In the SVA support for SMMUv3 series v7, I see the support for
> > > PRI via "Add support for PRI" patch [1] but it is not merged. 
> > > 
> > > Can you please clarify if we can support SVA with PCIe devices w/o
> > > pinning the memory?
> > > 
> > > [1]
> > > https://lore.kernel.org/all/20200519175502.2504091-25-jean-philippe@linaro.org/  
> > 
> > The only SVA client we've had for SMMUv3 in the upstream kernel is the
> > "uacce" thing from HiSilicon which is a platform device (rather than a
> > PCIe device) and so I think the PRI support just fell by the wayside due
> > to lack of an upstream user and no ability to test it.  
> 
> Right, we only support "stall" mode in the driver, not PRI right
> now. PRI has a bunch of differences at the SMMU level.
> 
> > I'm not sure whether or not Jason has plans to implement PRI but maybe
> > it's something you could help with if you have hardware?  
> 
> I've been waiting for someone who has HW to take this on.
> 
> Honestly, I'm not entirely sure what the missing gaps are, at least I
> think we need to get the PRI information and package it into the fault
> queue and link it back to a PRI response.

Long ago we did some testing using various 'interesting' PRI supporting
test setups (they weren't what you would call real devices but did let
us exercise the support).

IIRC the above stuff from JPB worked at the time. Given we didn't have
any real endpoints, we didn't push for it to merge.

No idea what status would be today though. It is on our list to come
back to.

Jonathan

> 
> Jason
> 

