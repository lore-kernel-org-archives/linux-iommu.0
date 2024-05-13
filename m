Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D4145FF9
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 04:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715575450; cv=fail; b=NXW4LYxJ/jqaluiLKqA7CayoFJxGBxf7xcBZFBid+9nh2ldRI/R4L+g4EdNocztzSi4VzJF9sgzLBX3uigbVuzBh2MbC45jOf1i1feUpVUvXgcEn0f9Nq7JHMegiNlQZ1Lb2ITlR/fdHksWqYsPR6ze24aplGfOW2W74HrFUIlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715575450; c=relaxed/simple;
	bh=B+wWCO8Gc+gDULRxi4sAg+Q20zDtLN4sqGD6eO/ePH0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0CKNUWkIbeFN/Y4S4nnQTYj+40B7cMxnnF2H3IMA9yXtwtkI+P3YuM449NKUqu6HFPZzlAY+e/d6VlNLA3uT8rNcHSOlp0NEoYQV7ghMabv0n/T3b5utMoKcCAD18Ad6B3ABjJRn81X35A+kGEgiQwgMpJowimhsbVlp0MkjeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dkhwcucj; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dkhwcucj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLwmU2Gj655tHGWOxk4AuGF5wMb0Nd12xNrmbElRrnHUpPO/TDOLtTov+/ufUyORNQWmr9yhMqxYLe2Qbd1olFTh6FS7zQU47OsKPZFQAp3SvHHElIF6+LmC4mkMbdJhR4ljdzdBu/NJjFWY7TQyl0QCQzvmTbG0Rc9yB7waZNSPBnt3iLX7PBz4VIGIaLLQ/cTADIyaSxXDxArD9LoNOfCVYjhGQwyxYxVCzrTsvjKjIBWzzMcacVTkN3zAReT+lmfaNenuLK9BDgWn4Dvl6V9pxFpDt+kNQWfgJ87ExGnnj4lr9aJOJaWf4Hb0ugENq0ue2CI2cmEuorCBu4sinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZVpGCVOQscqtZoDF4QVIBZt6BKJ9Fmo0aKcmpeYdFE=;
 b=dfCzY0zMXJnNvGmhnEH6QCqq079l7EuTE9ZpPXiYH+dwm9dlDBFI83jsB+E7OpuRMH9tWV4vS4oyb/Kuh6y5a1whTtMHLAEGAeb5y9AObXYSjXG4QPWPq6nYrbiJD2uvv0m6TUKUY22U7dWNAEm+/x3jriy6oFh84mPof0CD3dZr0TOMTru4nCzXW4rlP1JIYWtdy86dJk/g+Aek7VcdKNtSGrV2eP/5fKqAICLs5uZDbRQwzobC7eKJnvyaVsz4ITeBJkFLBzYzJWVFYh2FWw3Ymxoa6qyX2IVHX22F0aHPTjpAwCMrdJ4gs+MX5NU44Ma6TpR6v/oOrWZIFDJOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZVpGCVOQscqtZoDF4QVIBZt6BKJ9Fmo0aKcmpeYdFE=;
 b=DkhwcucjXtbN7P+FB3ck8/APq60O6hnqzEuPcGvETt3zaxNidYC/U2OLOoHVgM/7lE7xCDnvz3+NBqtixEBAbq+onLHvPBhDUF27f2CejNbgYhXVqhH2SsTnITMPdr9ryLsT768aO6x5G88IlFfTmZQy6RUECvoNwOCUXIkeQz1rNT7wo2dAHA1/iIfmxy/0B2uRcTA0X2yjIrVaIzlFhyM/g2O9VfMM6xb7mPkhzPTNgGKQCvZd7eqDPzUhoRjYUH32AskoP63jc8ETuLJSykSmcQS6Iiz1JQivwD3h9FIYrFgk0hN/5j2WC2wwWy6XUTUs++FYnI7/L2gzlvmw+Q==
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 04:44:05 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::24) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 04:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 04:44:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 21:43:49 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 21:43:49 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 21:43:45 -0700
Date: Sun, 12 May 2024 21:43:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 13/14] iommufd: Add mmap infrastructure
Message-ID: <ZkGafm+qAe77bvIW@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6fef9ff9944381d51dd18f83ec03785a26754dcf.1712978213.git.nicolinc@nvidia.com>
 <ZkDd8A2qAYnuxGJQ@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDd8A2qAYnuxGJQ@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: c4aeb330-ebae-4741-861e-08dc73075190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fuOdM6dktizx1i5TkTv7EUoN/RLQoKVpowEiZFIWNp9mJT73q+F8EqKEucY5?=
 =?us-ascii?Q?0Jp9pkZtjCUpM72npCsMZO7QtLAPNaxocHYmRp5WUXn/jOOF0TX9rGdNdH+i?=
 =?us-ascii?Q?zbLcNOeKMe7z0wzObVp3IYk/3s0woGC7T3wEKvpbw5+cKHoICXyLe1gOxAwS?=
 =?us-ascii?Q?SOIzKQdJcOyHc10p/J8Z/68pobTlD5750MsNveKBvQ3D0IVcnQSn3OfxICuS?=
 =?us-ascii?Q?bGoZzqDVUgwQylJK3ndDDOaFYnWUQKWH3RRU0BoKv1XvCP0towlw2mDUsy/7?=
 =?us-ascii?Q?hBDkSwHr/6hOvu1cZYcEzb5pyNQEzcDxWHoQ6Gcb12VUE5lDBtXBaONY9a2a?=
 =?us-ascii?Q?kQOS/c2pyUXXTVWk4LOyPnm2in5hm2qRZE3/mhMGarQewryaV3Bttcsu0GGB?=
 =?us-ascii?Q?Xdap0Ds0d2Z5WHA0/xm1V9g+FmqWKwAnx3NBcUAEgjWM/r+Xhg37ZNJHWQ8D?=
 =?us-ascii?Q?zts1sEl+bak2E9os+lp2csmqWgUf1Ln1bCED9ksWgeDihZPoaEP7YMHGl5RV?=
 =?us-ascii?Q?aLSJEtG7Zn92708D+GyDKlXFBlEvPkQKQxsA/r5o94JQ1R7/2Oq7tKQRjPZi?=
 =?us-ascii?Q?0DjsvprOdRF4KT3yj9q03C+YIO/s0r56Gg9wOnrUSnCQbNmM4Pm8f65mm/yu?=
 =?us-ascii?Q?825DyjZynEr/SjBkDzu5fX0SDnAQLEv9rvFB5s38fxPfzf19Ahy758XYOKsN?=
 =?us-ascii?Q?On5UHes9vfEmffdLRuoa4Hb6U3MUAYXW+dJ4h30FJXQs7OztetK4yR1WtywC?=
 =?us-ascii?Q?jVwwx2QzLukSYGZSJ+SRGDRzAZ0lBeHh66wgE5tO3WOa9ALyldiqAzHrwJMs?=
 =?us-ascii?Q?2qIHJwiuPokKVOUTbbNXHo42HTZd8DPxSaLLO4w5S6Z2iQk4leLwP35MtfIY?=
 =?us-ascii?Q?lDT536VrnsBZGjVVvpb5fv3v4xMt4KPHrFZedNtMyU7Cvm9j5NaSOsKeT3oz?=
 =?us-ascii?Q?HD1VkW+2Ug1WCnsD/4rJXB8PxTrPPbommwfMc7At7Pb3Yn9wQGezgD3R5hpP?=
 =?us-ascii?Q?RL+EbQvkckMaKweCZczSbHGQW0BHjGZShHicAWcLDzZL2kCYTuYZ5c04EFqD?=
 =?us-ascii?Q?l+NiHcKJAp+/FUw8VG5+BruGWETpldEY7iRA8h2mN2wGfNKrQqcfHHpo4IM1?=
 =?us-ascii?Q?bINZpkbDTu3ZVdBI5crSHpv/DAqlx+zYoHnHD3iTsKXHXiVKAxN13TMeY8qC?=
 =?us-ascii?Q?mt/xFdP0kgMXi8DAX+IZhihaWLOxRNa1UpdVkqG3NLhsMX0Nkp0ppdrYsm9q?=
 =?us-ascii?Q?SZyiDemcCavDvQwH7ALYjfQD+VO52x4SvfRssQJj9KInkDgJsQtwi+F+A3L8?=
 =?us-ascii?Q?5fIwt1Q2kKDtbYvttZpuTiA8YTwk1P1QlTgiHE0KID6ujEhnb3cJL17BYTDj?=
 =?us-ascii?Q?yING/vaPnctJuTOfAVmYUS72w50V?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 04:44:04.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4aeb330-ebae-4741-861e-08dc73075190
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290

On Sun, May 12, 2024 at 12:19:12PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:47:10PM -0700, Nicolin Chen wrote:
> > Add for sharing the kernel page with user space. This allows to pass
> > through HW resource (VCMDQ MMIO pages for example) to user space VMM
> > and guest OS. Use vma->vm_pgoff as the carrier of a viommu_id.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/main.c | 40 ++++++++++++++++++++++++++++++++++++
> >  include/linux/iommufd.h      |  4 ++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> > index 96ef81530809..5b401c80cca8 100644
> > --- a/drivers/iommu/iommufd/main.c
> > +++ b/drivers/iommu/iommufd/main.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/bug.h>
> >  #include <uapi/linux/iommufd.h>
> > +#include <linux/iommu.h>
> >  #include <linux/iommufd.h>
> >  
> >  #include "io_pagetable.h"
> > @@ -427,11 +428,50 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
> >  	return ret;
> >  }
> >  
> > +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> > +{
> > +	struct iommufd_ctx *ictx = filp->private_data;
> > +	size_t size = vma->vm_end - vma->vm_start;
> > +	u32 viommu_id = (u32)vma->vm_pgoff;
> 
> Don't do mmaps this way, it doesn't scale well for future things.
> 
> The pgoff/length should *always* come from the kernel as some
> 'mmap_offset' output. I usually call this the mmap cookie.
> 
> In this case have the mmap cookie for the tegra doorbell return in the
> viommu's driver data struct, then userspace just passes the opaque
> cookie to mmap to get the correct tegra doorbell.
> 
> The core code has some simple xarray/maple tree to allocate cookies
> and dispatch them to the correct mmap callback. Usually I'd say to
> provide a mmap callback pointer when allocating the cookie.
> 
> Also look at the RDMA Code around mmap there is a bunch of VMA
> validations needed. Ie we must insist on VM_SHARED and check
> permissions, etc.

Yea, the vm_pgoff as a carrier is a bit of hack, as mentioned
in the cover-letter. Let me revisit the whole thing and study
from RDMA code also.

Thanks
Nicolin
