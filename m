Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292942;
	b=iwmBHkbNrcR7uE0qYfskmv0o2aW4PGBrtsyBHEIDAfQfyjrc2DRf0ZPRvACCJOqJlgi5
	 63J++/5DCwwB8b/YJjgvtqRnXh7BFje0SBpqF2sY1mUl+JTQEnX85POBHjPq7jqUdlnOf
	 N0dETIsRl4NXqVOKRyc75s6RAx3YVfiSsnM4HxqYkaoFRhlq9yjY2rvRhatkixJ2L0601
	 HBFPPBW4UHbsLhjgX4OFjfKGAFNpRDWWGnZP48MPLCSNI20kvbzdyK6xiOrECn5m9FEGo
	 l0J4UIEbj8jq88tFAhxnG7HSglFZbMCDw1mbzhc61/iXYDG7ubdzDquQaGkxMy3rpIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292942;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=F57TO+AstGhE+8yyPnbLyDBC58ekYQDOf3bFWDVXPWA=;
	b=zYEDmpXuFNY2pu7bqmEkxaDOejokTjEkJ3B6NI78ssPe/3JRbbEqVsoEnxZ6lawcRDgh
	 Id0z8k7GS5HY6y7k4Z9V1Eou+rdOZBDehA1JnImPBNy7IG4nOdD1yE/Rs+s2f7HtId6Uf
	 yP29vNeBRmwp+JR8T0vh42EFRxgMGtwQsoRinXKIMwd4frq8fgrp7T8frm/pCODmYZ0S+
	 ehYqmlYDBg/wQsmREqKGWxVXU+8DUvcAmQJ1gl/ovAc0A+ALI//67ZgJzrsVLclb7SjO3
	 ZqBBljHFnnc/L+ZXo17KZwPiNBFGzjdNOQHxnzhn7dgBm+EdegyzJuslLUBYd9m5yWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=C8Wsglcb;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C53B606A33B
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 06:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C53B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=C8Wsglcb
Received: from localhost (unknown [52.172.102.219])
	by linux.microsoft.com (Postfix) with ESMTPSA id A15B020B7168;
	Mon,  9 Nov 2026 22:42:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A15B020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794292938;
	bh=F57TO+AstGhE+8yyPnbLyDBC58ekYQDOf3bFWDVXPWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C8WsglcbnXPSgdhdM6HbMd8j5x0Csmou0rx5S907S2s5ioXYln/Cq66k66bHBNY3C
	 jI2K1ederaGkjCcb4AhdBs5h4J7v0cnBz3ztf1iD6Lq4Fuso+RlcEJMJuCfijiOpZO
	 YBB0kwiPUdhf2w9vJaNEKhXruliV//UyMD0BaOqU=
Date: Mon, 9 Nov 2026 22:42:00 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, Nicolin Chen
 <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Wei Liu
 <wei.liu@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, linux-hyperv@vger.kernel.org, Joerg Roedel
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K .
 V" <aneesh.kumar@kernel.org>, Mukesh Rathor <mukeshrathor@microsoft.com>,
 John Starks <John.Starks@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@microsoft.com>, Yu Zhang <zhangyu1@linux.microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, Alex Williamson
 <alex@shazbot.org>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <20261109224200.000033c6@linux.microsoft.com>
In-Reply-To: <20261110005259.GU663069@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
	<20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
	<atiakDqtuED2cTM5@google.com>
	<20261026161003.00003b71@linux.microsoft.com>
	<ausIn5Txiy1uRjkY@google.com>
	<20261104170816.GS3889730@ziepe.ca>
	<20261106130352.0000638d@linux.microsoft.com>
	<20261110005259.GU663069@ziepe.ca>
Organization: LSG
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Mon, 9 Nov 2026 20:52:59 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Fri, Nov 06, 2026 at 01:03:52PM -0800, Jacob Pan wrote:
> > I am not stating that it will break UAPI because of blocking domain
> > is used. What I am trying to say is that with the blocking domain ->
> > external transition, we do not need a new UAPI for external attach
> > for non-CC. It will just reuse the existing UAPI.
> > VMM:
> > 	do_ioctl(vfio_cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT,
> > &attach, "VFIO_DEVICE_ATTACH_IOMMUFD_PT");
> > hv-iommu-root: external_domain.attach_dev() will do the hypercall.  
> 
> You've basically described a wonky NESTING domain.
> 
> I think you should just use nested domains for this. Even though there
> is no S2 make it possible to create a nested domain through the
> viommu..
I didn't use nested domain since the current parent hwpt is a paging
domain which cannot be used to express the external attach semantics.

Are you saying that we create a parent-less VIOMMU (in Aneesh's patchset
and my RFC), and modify the iommufd core code to allow nested domains
to be formed with an externally managed parent? or we expose a
opague parent S2 that is not paging domain?

> If hyperv ever learns to support VIOMMU you will need this anyhow to
> pass vSTE/vDTE/etc to hyperv.
> 
VIOMMU support is established between guest and hyperv directly, where
vSTEs are passed via SMMU emulation (by Hypev). There is no host iommufd
involvement, I think that is different from qemu.

> For now the nesting domain creation can just accept an empty struct or
> something which means identity?
Yeah, identity or passthrough should work.

But if we go with the nested domain route and let hyperv iommu driver
handle the nested domain attach, it still would not work for pKVM.
pKVM's root SMMU is emulated, so it cannot do the external attach
hypercall in the unmodified SMMU driver.

So I am willing to entertain Mostafa's approach to park the device in
blocking domain, then use hypervisor provided viommu/vdevice ops to
invoke device external attach hypercall. Basically, move the
attach_device to external S2 operation out of iommu driver to the
hypervisor code. It does not need domain ID or anything IOMMU specific.


Thanks,

Jacob
