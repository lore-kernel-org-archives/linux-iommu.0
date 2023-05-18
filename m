Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6323D380
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 18:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFZnMwpyeLFiNiYIVUeT33zlBCxihScKywkzwnwNE6vAOSxCp2aC4AEb9GyQzKdxm5U4DRw0uvXEmvOa3uBk7rjzid1yJU3/+P69Jr2x4Zag5nDB/2LpmqAXDxopUvNbk1DgOtteVT0Ze9C/X9jFAdbPaPe0LERWyqCCn+1ZGj+/Ahl6UNl5a5XDOMkEPhpMmUzNQeiM+oyoCGY1oGnQRvoRhcXrSNIdR4btf/0WWMcCyIwefi3dDnX+1JZL7ebiREouHUG2DimeWOgsreU7Ngy7zt1SpOnADYHKNOLhOyE3IH9JY+/no/qvZoCwiITO+G98oMKYLqlEmVQcZiwJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZqKG8p8anZ4Y/3XhrWw54VPBy+G9efNoKxCZzEt6QY=;
 b=g63qlOTHLDJpQPk6kzLNUy7k0m9OcCIIRGJ8/EYLJUt6H1e5WK4LJxef+GqLEGTHrEueeJzAZ56WT3qiCz4ykS4JqKammdGpNmLLuRyiReT91+FMT7UHI1BmeUoi9LWHhFu9qz/DA55LBQa2w7f0YwMrvDHs4tgSp7cpF5QiWmjm1+5QEmt97meTtm1lMT/op2rrNs+Mf5ayA1REFmI10Mi3wv2Z3T+GxSF6cl+wSYXGpJXYBtI7BHX8Aq7rg0nbMvrCYHksFCEwNpFu7GvgJ5Ucm1pbSPZ7ndlVqW8q31Bef1ggeOEUJhCvPxy+LaOcl3QwmhVsSnBT+AmcGjmV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZqKG8p8anZ4Y/3XhrWw54VPBy+G9efNoKxCZzEt6QY=;
 b=FS6nouLp1qxYBzGS844FD/jQQF3F+Zxa+B0rrNkhUN4h+DD+l9WHpT2++NKRXVQaxAiZTsHB+N55qBgOtDELbwmp7zL76UAknrv9PU1lvPXtKc/3PXVOrEGFWifTZbm2Sqi3Y4D0L5xgDbKwp6RIm1BCxy41P6ApBw4Ayrr4PbIgRj2aet3AghxsReeZrlv1bNCyuB+kq50krkK3ZhU5diGFCPMw1CYNAvzUdrWnxcXJitXcvO0wiXTT9WH+470V+UhBh6ycft6Wh8QhKxF29DMMojqO2qAcgHPxvnC6/jptGvLUAhvVGnIkPm0OcmQlK+XBJ/evlmFFtEWmJBz1ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Thu, 18 May
 2023 18:17:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 18:17:23 +0000
Date: Thu, 18 May 2023 15:17:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	eric.auger@redhat.com, virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev, akihiko.odaki@daynix.com
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <ZGZrsgNX1ALNP2w3@nvidia.com>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
 <20230510081157.GA3326511@myrica>
 <ZGT+44a6RYZ999kz@nvidia.com>
 <20230518135638.GB2587493@myrica>
 <ZGYvMDbkBN+2UgzG@nvidia.com>
 <20230518164937.GA2934820@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518164937.GA2934820@myrica>
X-ClientProxiedBy: MN2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3c36c8-72ee-42e9-2408-08db57cc2066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SmZuOzVfy6BAO4dpqveV0NZlsZAsQRGmKfLmXGF2/bt0q3jU/lKGAzdoELMnodpzkz5hRTFqp+xS2waQkI2QH+QRt+xyXQQ2i1UWlRNzFkG4O4KDX9dGEwhqN2c9Iv1VhGl0JwmRj90+A2m1xD8NDFh//ZYPeD6+28OUyARBf3r7LF8B72sLKE5+HlcSfT4oNB7hAhZ24fSABd8hZuS4s+IvPxhlXVgy5fG20VgbWSOSPrqDYSG4X4ZQqO6BSIfJW8QeWcBptn10uT2P5/bTR9McONlG0RBZx+U2gCoISqd5GJm2cQVNasdSSuVu3xHzb00syjH0Qgett0dDCXsvrq8voco/EEdIcwTp7P8Pe/8/a4ejpD7QjzQEVAPhh+W4Ckp4tINOrmEK1zfowPC0rBlVed/U5C3K8ZqTAfH6TcYgItuZRT8RDUdN3EiRsMVGYmXgKGnyRlsW9+EOjWbmhKwpCtNo+b/e1JWttNh3SZVK0zsM86C11jASAeU/BwhjTSotbcNC130NNHgfUCsW92vEjhCfyqRoyZCRMEamgtoGvZiF002DJxrFtyLjc7Cm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(83380400001)(2906002)(2616005)(6486002)(6512007)(66946007)(66476007)(6916009)(66556008)(4326008)(316002)(86362001)(478600001)(36756003)(38100700002)(5660300002)(6506007)(186003)(26005)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RjTp/fmLhbJh5m1LhM5N4d1MJHPw6om6O3NwbGgyx9TalSVx/iqchWd5oMef?=
 =?us-ascii?Q?7zWd0FtFyFKcwaWEKxluHSpgZ98h5sQMtCcLJFymtIFiIWM2K6wEPeTNFrpo?=
 =?us-ascii?Q?PKzbGJGba4N0Ttp7MdQHCHKpJ5x/TUjvDlmyfRMkqPvGxqxGpAO77YsWqw9Y?=
 =?us-ascii?Q?7y0vnZ9ncibNDy86zTP+Zkerho2aeVkGSvwAax4Wn77Snb+V5IC9li2JYsOM?=
 =?us-ascii?Q?gXj+bytrSclS5HiY9NkoZaCdIfupPfh8k2+g6QaV2zlUcDkarOl0S/zOVBVE?=
 =?us-ascii?Q?F4XVS9O61sXRb7CkPHjFrV+xZK2wMTqz1FTzRAGgTYsvt4bzEkLt/uzLy4ZC?=
 =?us-ascii?Q?kYbGv9FaXXoKm9fjIQyA0V3+YbVQBteCqHhYRZroppN95jitBIlfRUZTb5vv?=
 =?us-ascii?Q?YVKSOYCUMi0sLGOMJeSEOU06bCLC7H8L+jCJZo5zIskOFFMqJfiFYKtfRKA3?=
 =?us-ascii?Q?+V9F1Ry8lCZgizv8yYRcOv0Z7MwUfZxABNoONef5e4DDFKoJV5FG41V7WqOa?=
 =?us-ascii?Q?1yHM+GW6LMpmktLN7U7SlXyRy627mQ1QJM/qdqkNERL1W0DgKPGS2N82ebE3?=
 =?us-ascii?Q?Rm3uHnAhy0VbP9JuJmdA+hn/jc/9PAKSvh8HeoqQBFGjtKpiDBjYFllH6imP?=
 =?us-ascii?Q?VcA+y/ZVyx1vT5bQFkMCU6NFuwY0LgfEu1fBvnfVLc2HrvachmMJzP3WRtVG?=
 =?us-ascii?Q?7j+xPdtMq0NmYKx27fPSgauPxLz1ixVP/vlVZyu3tWamJVW3jp9ftPzHdf2j?=
 =?us-ascii?Q?rXU9biwBcrWmCwsRNxAykAY0oHrmKOTS/50WXQDxwvQLymgz/IkvGhv6ScvL?=
 =?us-ascii?Q?xE/ihIpa7F5U6Xw0doxbel9oBxK0FCLcSUo/Q6MTA1sJ2rYz1vp4GUr1q/kk?=
 =?us-ascii?Q?fam7Egq6L2sLD79VHq5hmVlZ31QO4ht2scgLQSHRM5hYLmpW9FiJGhpEcSeD?=
 =?us-ascii?Q?wusgJpF8djhaPsv4Nr7TFP8fkA1etAEzJi9T7bE8s1zTt/zVtvWgyhtUihTe?=
 =?us-ascii?Q?JRmaXWQs0U3/o++HrSltEonwb3h8O51f5fO91m0u/r5/SkJluubqrPxLIK0/?=
 =?us-ascii?Q?FsywrVqoJEurEKVycAzmZnfpNC8tdOW+y0jNxD/5mshBNm4BoOpzRr93N0N0?=
 =?us-ascii?Q?7RoRtK1I4mFAdw8yVRpg1tgG4LEWN+sfcoDOcFWshybfIYkvYMmitj/1+wQb?=
 =?us-ascii?Q?aLhOCL3rGGylu0zpclS8rFpmIaV/HOqjjwecISXl93JXdKivQmv1wLm6rxM8?=
 =?us-ascii?Q?e3A7KORjyEfKM97ye4jwHa498px3PBnmateDR3LKj0FjL1cwbQU77VHrPV26?=
 =?us-ascii?Q?zUE28Iin8NYU0Ie+lMT/7cbsKmXGGENqz4gdZHcd33aUEJrBbEwFAVYzo3Ss?=
 =?us-ascii?Q?2ctYxyzrEJ2xtvlyfY8fT4VL+MNx8v1KY16weOXJFUINwqVo75ju5pBNfFfR?=
 =?us-ascii?Q?KzuIsdM+H5fB8oKcgBBttaiYSpevHJGvA5RYFSBn5zDmZMea298WUiiUmg9Q?=
 =?us-ascii?Q?6MMlvFSeFTpnMoIZh6hO/aDSe0AGzXRHRgYSa9Zq82p89YmhlH8r6pxIkA0C?=
 =?us-ascii?Q?Qn864Ws78gxe3eOwfawEvwY7a6b4rQGJexSf2gk2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3c36c8-72ee-42e9-2408-08db57cc2066
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 18:17:23.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2f+eTdUK1FDIqjG3m9PaIOie8LB6YFr+Qe5LFxqWcgOV0FtWSXFrVDJenOyGPGSQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383

On Thu, May 18, 2023 at 05:49:37PM +0100, Jean-Philippe Brucker wrote:
> On Thu, May 18, 2023 at 10:59:12AM -0300, Jason Gunthorpe wrote:
> > On Thu, May 18, 2023 at 02:56:38PM +0100, Jean-Philippe Brucker wrote:
> > > > Can you wrapper this into a BLOCKED domain like we are moving drivers
> > > > toward, and then attach the blocked domain instead of introducing this
> > > > special case?
> > > 
> > > Yes, I think the way the virtio-iommu driver should implement BLOCKED
> > > domains is initially clearing the global-bypass bit, and then issuing
> > > DETACH requests when the core asks to attach a BLOCKED domain. This has
> > > the same effect as issuing an ATTACH request with an empty domain, but
> > > requires fewer resources in the VMM.
> > 
> > Does that exclude identity though?
> 
> No, identity attaches a domain with the ATTACH_F_BYPASS flag (or an
> identity-mapped domain if the feature is missing), it doesn't rely on
> global-bypass.

Oh, so you can clear the global-bypass bit and that turns detach into
blocked then you can model this detach operation with blocked and
still get identity because that is attach with a flag :) Wow, a bit
indirect but OK

> > this, the desired translation mode should always be made
> > explicit.
> 
> I probably misunderstood your plan for BLOCKED. This particular patch is
> about removing devices from the machine, for example PCIe hot-unplug. So I
> thought you were suggesting the core will at some point attach a BLOCKED
> domain to a device being removed, in order to block translation while the
> device is being removed and while a new one is being plugged in with the
> same RID.

Yes, that would be appropriate

> For that case I think DETACH, rather than ATTACH an empty domain,
> makes more sense. Otherwise with the same reasoning we'd need to
> attach all 4 billion endpoint IDs to an empty domain at boot which
> isn't feasible.

Well, this is what the default is for. You can consider the default as
being implicitly attached to BLOCKED or IDENTIY. If you want to change
the translation then you ask to change the translation to some other
defined thing.

Detach is just a confusing idea because it doesn't really say what the
translation changes into - and there is always an active translation.

On the VMM side we always have a translation assigned in VFIO so it
doesn't really matter how the command is carried over.

This command coding is weird, but it seems like it is fine, and the
driver will be clearer when everything is labeled :)

Jason
