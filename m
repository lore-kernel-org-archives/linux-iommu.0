Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D536122
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715527168; cv=fail; b=uWovns/OaU6fRSpxEVwjb6BorISC+kfOKzBeQkChpPXQRygTI1MYDf/RYaYBtZTxsL6b/z96du5aUCpKDujPfaFfveFk8gJ18m2YzlHnFbWaisNVY7JCGzZuuwXYJc0xueCPUh+cnrsVfM1I7tnDnlplqCNbXeAXMq6YJAQFjQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715527168; c=relaxed/simple;
	bh=qj12/CLtIVMBsBRX+qeCl69E6ng/G4a89+5aGr8hSqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CGiw8qRxKafl9qdlA9Sb0HmC6yZOzbOMB/VPfGQESOa0v6HAFNSTR1q9eXkFfDnMa6XB9VSKQpf69TU3SCEQtKoGo5bzUP2/UF3JKvuoGIhatYiuGmesygD0xGcpN/61t5qucEfRtbynEdj0sp7fReh88GAUYdDHXRZA3hxF0sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oxfoB7sV; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oxfoB7sV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FffIHaujIcGUqQQMGB429XVHng0UxKFLiW39zAaAw5eyo7+yGIY8vlHBFfYUiVFPGM1r3P4dNAGtu4ji5njOqBuME7TsE6HayMTOHuYaJYuV1zNPwwRxNL+sOMB9x6GtAeTd8lfkOtzXqenkbEPIpGbd8AWPQE7AAr5WYKPPeHqLXTVXsuCY0l7jYx4Ra1+vL7103q7GcxbUv0BHgXJzKpLjlmMRa5m+d2ocPrOfX0Ngk5K+FxPIJ59GdhDNKlBRstZ5W+RZLAb8YT0f9LOp7N2darsefIpugLPXPIleBkZm1QHqnbSgx0nn9VLfA7caytm0rSubP3Lx60HuW6qtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2Bs/S/b+0+F7vx+bhIPJRg4HUOGYWpfV5QCgsgizks=;
 b=HCpOEHVlRYmoi9rTLw6UrpHCVxXBer8OQfhI756eIv3Ll2+gHoiZNhJqNoIft0uPD6e37Sr7uExcTiOkvvh4v9CH6BR6pdhcZhSBVecTYFCjcevgDW9fpRkBmkx3wyHvqb8ff4lSMZjU6LfVv7U1E3gd3k9Jjui3mtdtZnLsxUqQjnZSt4D/3TKRxj1xd3WZc6aWpZzfubjlGgKwxpuWH4xF2/lql2FsPkWKCqbKQ9uc5QAV0lO1R0KRfnIJCiWH9W2B27iMzS63Z58wQuRKXhAO8bCdINj8KqvD3r6eUfsoalQFy6D8BxG9sU/yotZL4YQXNzbtmDnRDcb8mZhByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2Bs/S/b+0+F7vx+bhIPJRg4HUOGYWpfV5QCgsgizks=;
 b=oxfoB7sVRcEZ6zQKUonHkApnBcf5mZrwH6i9HOcetfzmjItmUKrenCP+qxucyDVlLy7uw/N2YZcXwALADj5ls8qJx1Dk83fTTAAU639JP5AtexvImISNbr/YIMGbSoZRWYQYa2Rdvw1ZATrEf39uhTrGetmeIYIE9ung1CY4vYqPjjwn5Q5RltAJZjbR6KfjZjE+xso+85B1w47ZdaPCDcqize/rwd9T2f+TRfXUFhAeNxN6M0AFfhm1SFHisqGZ9MzrurCVAnAVwLmaL7cfdzDqEZ9XBNPnud0zkkaLqW3nKQrq15tYInE4At+8BVgsw8sJM07jnlxBoZB5MRdpxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 15:19:22 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 15:19:21 +0000
Date: Sun, 12 May 2024 12:19:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 13/14] iommufd: Add mmap infrastructure
Message-ID: <ZkDd8A2qAYnuxGJQ@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6fef9ff9944381d51dd18f83ec03785a26754dcf.1712978213.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fef9ff9944381d51dd18f83ec03785a26754dcf.1712978213.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 556cd57c-84a7-4b52-f843-08dc7296e66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iZRoUQP/YUO5Vd6GCA8rkr5SQlXum1ebtZLmsmELokryOeKxWUBuuSqh3iSF?=
 =?us-ascii?Q?DTcdsVJ9Pmo70uwm2/foPJlLbq/cP5quHVPFgBFCDwYd5LLYnqk/3yKxFqXT?=
 =?us-ascii?Q?FQUiDV3q1kBvMF4K4KjtBO7PLD0XfcOquwkhkVguTaCWVlAch6p1en/rERlS?=
 =?us-ascii?Q?6IbBNP7amYAcSQsQxB8lRsV/DLZQTodEpoQTkeWFBuR1/mZFbSFdIj9RZ836?=
 =?us-ascii?Q?nfHQLvKE0N3Ly+PF6hinOCKzwCQj8bwwtuNAKOYA2vKGySckcnjJFUhjRsyb?=
 =?us-ascii?Q?RWXaijQULzqnbjsp/2bM9gXeymsDmpTcCEsK+61U0sdbfoRL2ixoIs1rLJIE?=
 =?us-ascii?Q?diDboUEexLF5bPYM82vSgubNtmMIpxkZboGo0+WLGEHVdu+uTfbaDYVQ6RmL?=
 =?us-ascii?Q?hL+8kHnwMqdDgQEqQMKaNxklKAgjI7cVzsGuAsmReDatXBBOLVLfbx5VAE9c?=
 =?us-ascii?Q?EVtXMuBUQ1R/5NzVbAvf4Z2M3KTUYzhmytW8YCe4fgvMuZae5rqntKB0K+Ce?=
 =?us-ascii?Q?btbKcsv6w9Er06KWPcqxLnoG9ZmFD5BA+v74hM0uITKHZnImzqKcidf78iIh?=
 =?us-ascii?Q?AJuCD7ugwjomHRa09/FHYRTcvxRDYZDIDKQajr5lmuzgNyIZcQg+N5z0Qrml?=
 =?us-ascii?Q?fZQ0jr12agUYOT/rACaVe4004nY57t8OHHtmknfN49KGdzSLmou4NQAv1lyJ?=
 =?us-ascii?Q?LWvzt6PvLdCE2Coqek6lV91/yBBO6uk8JAG3xBEMWsu0O0T0MWGXmNElHu4D?=
 =?us-ascii?Q?559UJh8FPM/AKaCMEGHyv9xuL3ep8kqutx5jRdKjiVptX+Mnrs02bkv9zrJU?=
 =?us-ascii?Q?o1WmuXufrvkoygARqx8yx502c+Lh5XcBC1OYLjTXyC5QRbwifx7w0dTiweB6?=
 =?us-ascii?Q?bKPdGVulZSfwiNTwIyOj1N1aojSLBggqjZA0u7l+NqW3jPdgJeaXpoMGcTio?=
 =?us-ascii?Q?KoLT7BqYEfn9vtS+Y1NKgW4ifJRsKmvLUVsZd3BeDSx4bntUpeonvgrjOShN?=
 =?us-ascii?Q?ir9+m8eK7+SbUUYq7tBpSj11JWe2GT+pVcFYWkV6+sSaCdNa0Nerf/SL7joS?=
 =?us-ascii?Q?tE9DCyrvlO5S6K+oScKXVPwgQe00TiwI9l7SHDWAa7WnrQ4itrud6Akzfx5E?=
 =?us-ascii?Q?lBmj1qO14XYcTXxoauScevMWg6jvW22MdGKjxAvy+Rs5wgq41qU7YBHmjl6A?=
 =?us-ascii?Q?SLXtN14XG6iXxxCG+WLyrvlSpbnytCbD9eOdS7x/NWfCcfGwe1SqBcWkxwkA?=
 =?us-ascii?Q?UhdCNbsXtzc9rnK9aMjOtTCsnHG8PRb4Zo3+NNqNCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3CdML4He5OmEdOQ4Q7tNVzx5xH5gUPeMa1jImmje5IzzW5ONUjgLef24fqHJ?=
 =?us-ascii?Q?T3Xe73OPVzBWfHEhizddmhKR2Y3S6/2hdVMmk6BHl7b1eyDK9V0mhPUjDGU4?=
 =?us-ascii?Q?uHs7Q/5dYlu1OkpUpqCyMgSht0E9DX3pTvJ4ss2OoSUeIXKCVP7Y9ZaDAxMm?=
 =?us-ascii?Q?A3M6Tu9nKbu3VKOlTlVmJRH0CQicdyANmPnQGFPGo/+A8jeGkuRomgtkhLQC?=
 =?us-ascii?Q?mCYwsTFrxDjEADM/l9msyfP1H1NzOTGNbCWhxj340AXQqlKD88SN8/DSIBRR?=
 =?us-ascii?Q?7oJenHn5+dX5nYXrZo8yi641iNSB1Qd9KxRzEIeWmijjXEmMYl24HsKyxNH+?=
 =?us-ascii?Q?Fcas24Pyup6Iot81KYA4QmAjwDQTdQ85YvzT0M+FMzSg/j2Nx7gKAn1xV0VA?=
 =?us-ascii?Q?F6FKnGQm9cAp0jz3MJwv2/J0FNSgdGPnWA8bOaUFaSNUVHOOtRENkdcnakAe?=
 =?us-ascii?Q?sHY6alRxunuHKpO5PP5KvEpUMihP+jBhZILgTljPS92IJrffonp4ITXwtAMv?=
 =?us-ascii?Q?HRCNCLqLCOAvrJ53Y+grkWT5WsvfZpVvC91AKPmuwR1A5yo9JaP5eqMZqQOa?=
 =?us-ascii?Q?IJ+Bj1kdyz4BcKeS26QvQRUR6mV1ZNcE9KIF4GgCt+KIMMmHbM9qNiDzpf0s?=
 =?us-ascii?Q?6Ix3ihdyPKS7mmR4ayqKHKbx02J4ELh2ZTg9mSn/FGEJONIgtMhLyVbS0Y58?=
 =?us-ascii?Q?YQeNq9W5RqMqVpocWxy2spBYJIKkyCRutwh20pCF31luvHPEg2AKM2CL+Aqs?=
 =?us-ascii?Q?afpY1KHB8OYiw3hwph+Sd7Lka+RA19OL9VUMUIcmSx3caBu3p5pc2aGecPGv?=
 =?us-ascii?Q?c8zp0fLzeCaPZih1olG9lZz9eAMUss0Q3udgLnc2P+S/a2gGoySvzCvGtjT5?=
 =?us-ascii?Q?U3TNuGR413/iOujaUERcKB2uua1pRy6TM/lFRvsGzZfNU+t9fBwK0ImwTIiB?=
 =?us-ascii?Q?WfYBuChMlyx0iYwjW/V2Yh4f4YZOmLk4lfLPnwuG+8hLIoLoXSXkUXFxZA66?=
 =?us-ascii?Q?k0Mdee4INBCibMHtMgO0uw4fzLArPsoxSZycgctVdO4KaY+XlkfTv6aoJ9op?=
 =?us-ascii?Q?UFBZDGwnb9Lq1k4td3kRWDEVcMpmL13KZh2lrb1r3InDzPIRzF+4xYJ4Cyjm?=
 =?us-ascii?Q?zGXormgr+mQ5OB6j46CL3SXfxyQqzoFLEU6kCtbDy2z0kWPq6r1Tw3DOySaN?=
 =?us-ascii?Q?ZwS3HWDbMjOaHcsQSg0vgkTGRvVYZgK0y8w04Q/5e6ihNb02Dx6ZnGYvzecb?=
 =?us-ascii?Q?fKsMLFItSjS25Vz24XFqLz1jLMXTW6XOgpSkeRqBPPWk/eIogQ6/eaPlkzgf?=
 =?us-ascii?Q?2WsK27+nIPZe8TTXvtjKS2AJ0ghTZmwqLnCWx+TtNw/XCn/IyH6JRUPGf0XZ?=
 =?us-ascii?Q?izwsyNMHCtVt/tDCpVjC0l5ySpIiMVzUY89D9FLXw/rBarVTkTatA+2DXtLl?=
 =?us-ascii?Q?r6S/tVkdGMezU97B2RMypgZAgV31Y/zGgPWzF3LN9N5DF8i8k+qr8LOm3dnG?=
 =?us-ascii?Q?Tu4euTJjdfux4vlYpzBOWDqzdYr2BQbTlF603JoZpR2D2z2lDs1P5TaACMx/?=
 =?us-ascii?Q?vhabVDyqSQIhRDLe6+6n78QVoBvLSqYh6IKLi0Ce?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556cd57c-84a7-4b52-f843-08dc7296e66d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 15:19:21.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGNT5hEN6iciEIoPyEkumw4bb+W9//7zxx4NeDIjjtHA4IDJbPMpcNo7HA5syyeP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

On Fri, Apr 12, 2024 at 08:47:10PM -0700, Nicolin Chen wrote:
> Add for sharing the kernel page with user space. This allows to pass
> through HW resource (VCMDQ MMIO pages for example) to user space VMM
> and guest OS. Use vma->vm_pgoff as the carrier of a viommu_id.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/main.c | 40 ++++++++++++++++++++++++++++++++++++
>  include/linux/iommufd.h      |  4 ++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 96ef81530809..5b401c80cca8 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -16,6 +16,7 @@
>  #include <linux/mutex.h>
>  #include <linux/bug.h>
>  #include <uapi/linux/iommufd.h>
> +#include <linux/iommu.h>
>  #include <linux/iommufd.h>
>  
>  #include "io_pagetable.h"
> @@ -427,11 +428,50 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
>  	return ret;
>  }
>  
> +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct iommufd_ctx *ictx = filp->private_data;
> +	size_t size = vma->vm_end - vma->vm_start;
> +	u32 viommu_id = (u32)vma->vm_pgoff;

Don't do mmaps this way, it doesn't scale well for future things.

The pgoff/length should *always* come from the kernel as some
'mmap_offset' output. I usually call this the mmap cookie.

In this case have the mmap cookie for the tegra doorbell return in the
viommu's driver data struct, then userspace just passes the opaque
cookie to mmap to get the correct tegra doorbell.

The core code has some simple xarray/maple tree to allocate cookies
and dispatch them to the correct mmap callback. Usually I'd say to
provide a mmap callback pointer when allocating the cookie.

Also look at the RDMA Code around mmap there is a bunch of VMA
validations needed. Ie we must insist on VM_SHARED and check
permissions, etc.

Jason
