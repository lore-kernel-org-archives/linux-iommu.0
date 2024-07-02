Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82215884B
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926363; cv=none; b=tzpxxU18WtCtyQ+iEI/BCqYAbZl5wpJ/P5CLDNeRcycLkY4nezUxaXvP4C+KcH47UXI0AQsIzOnwMQ+XKaCfBtaB6K8cyeWeeL55TTGU9s/wG+mUnbH6iPI/dvJqIXiAfX2GUxOREP2caz/mDgUwS7xmiuvHqwBYy94t2Vh8wuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926363; c=relaxed/simple;
	bh=nREaJbN2N6IuOF7M5vJP5+l1uKx+FJkHJA3FZSh2O9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxUQwu56V9d7S2xS3kyV8aJVgzqjUJJc1XwFzv3AbYtXvh7vo+PZrf6vOpYAD41Cw7aECOLb1pV8dE2IPioFLG//c9CR0zS1y1BwsIoicRIyD+4NGOlQLq0QxNtvPJ7RX18Q8t3bSSrq1ZhRJUC64suzVfgVXCTZPCEhrwsyEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S22d9J9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S22d9J9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30851C116B1;
	Tue,  2 Jul 2024 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719926362;
	bh=nREaJbN2N6IuOF7M5vJP5+l1uKx+FJkHJA3FZSh2O9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S22d9J9wh1zcISWhF2L3svT041nDn7cK3WMFnNOQd2ID5Q3JWPcLAUwFw8BYdSJG4
	 2lmm21ejFDcX8QCRxxjCVFiyhRy9cM3jFaA2RWwO2Im4RxK8tBuUyZ3k6wug4Vc92Q
	 23SoVKjwJl77YzTkaCgUVW2m9c8ZX4VPdkjXVkNj6GUb5ZdUUFam0FqC4RIPfAUAH0
	 DYzfNA+GuP5oWfdJoAaJtLECNq99kYwR7aqFZls//E8C4Ojgr0HQ9OEgcuUHARr8Zu
	 M9xgZHPbawGHVwBX1cs/S1+aWGPC5HcLwf2DNT/ZKxOc+9yjVwTwFsXruWxR6JaNIq
	 aKXhW2pzxKP4g==
Date: Tue, 2 Jul 2024 14:19:16 +0100
From: Will Deacon <will@kernel.org>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Message-ID: <20240702131916.GA3691@willie-the-truck>
References: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
 <f88aeb0364884db994e4cba22b1e9ad5@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f88aeb0364884db994e4cba22b1e9ad5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 02, 2024 at 01:15:57PM +0000, Shameerali Kolothum Thodi wrote:
> > -----Original Message-----
> > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> > Behalf Of Shameer Kolothum
> > Sent: Thursday, June 13, 2024 3:42 PM
> > To: iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > Cc: robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> > jgg@nvidia.com; ryan.roberts@arm.com; mark.rutland@arm.com;
> > kevin.tian@intel.com; nicolinc@nvidia.com; mshavit@google.com;
> > eric.auger@redhat.com; joao.m.martins@oracle.com; jiangkunkun
> > <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>;
> > Linuxarm <linuxarm@huawei.com>
> > Subject: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for SMMUv3
> > 
> > Hi,
> > 
> > v5 --> v6
> >  -Minor updates based on Nicolin's feedback.
> >  -Picked up R-by tags by Jason, Nicolin and Kevin(Thanks!)
> > 
> > Hi Will,
> > 
> > Not sure you got a chance to take a look at this series yet. Hopefully
> > this will make it for 6.11.
> 
> A gentle ping on this.

On the list for today! Do you depend on Jason's "2b" series? [1]

Will

[1] https://lore.kernel.org/r/0-v9-5cd718286059+79186-smmuv3_newapi_p2b_jgg@nvidia.com
