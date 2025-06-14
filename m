Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4AE2E11B0
	for <iommu@lists.linux.dev>; Sat, 14 Jun 2025 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749860168; cv=fail; b=t4sdkZteecHxieCKBoZNuqfNJiWmoqzL/OXcJYY6SC2uqIY0My9jsviTPb4ATzbEUkRs4Tqj77S5OwvW3jgfoZpvDx9awhlmlBcjQli6SjhoY/VWsXkjxUtLEAarn/hoqniSDGb0wquRmWHWQ1P5pDxh9qlLzvCLFMlm3vlLqao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749860168; c=relaxed/simple;
	bh=zBO3SiCcdWz6bGpqhi62lUlnfhlr4WG+g46SSsGM9+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=talLMbKjkZ86se2h40ZyZR2nBpzv00tvv62a7EfsMn1fkzhvV3zIGfg3ILxnuCTqRStCz/rSSc2YWa5sFCmYBG/9Awt2IlR8D4cjJZ9SyOMFZ+57OahseRs8tKymwIxTooLely/cZe3O1U/LAySwXkZuxNacF2Hwi3dDVur0F34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i0P3Dbkj; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i0P3Dbkj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKLxX+QcHlsZ44jqPzUqJIjzbPioHrc6gzOfeMbeFPKJrXkKw9tqHXHIFX5V8DphQkUqSDnlUCwFroJ+MyuyVDEA4q4jSjpxK/9PWg0g5zacnzKY4TGhIu4HEnaU+w3HqUhMaBOxnrFklt2X0xbaH9RY8KRmHiwAIJIovk9ghpHXkMsX/4P4y0nKxWmtuQ4phF0Si8YjEMa/a8VsxhSNr2bN27zRZjDCDuG9CL0206HlmENjEV9lK3gWclSFnRbyd4/xgRJ7gl+fCUyzaz36f9MZuYdsNFEhGFPiE6l2dYLAsmCP4MudvpzwfK8dkz9fpBcz8/K/nhU9JEvi21aZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCOutbotbzgA5csP0gY1vR+duNEbqOH4HovztbtT8+8=;
 b=cUBmt+QOMYy53qOBgyTpkFB6zd1hZQVdq9l1y2MEB3Ot7JePnOykgi3Qagq6gaqbqVchLEWJANEZxRCqH0wzjEl1pvl9dztmH2j8lbS26o0Aa63IXlQIqfCoMtAKu/QPZPyPNuOOmEDqJ11Q9MNAmtySVFuaULeaQxPe8pmJdSy+/YREHDuYSHvd7mxQZLLVmX1pZOyBrYUjcv0hi/P0NQs3lMujc9Yvd4pulm5hZwnasLNqzAHE5HA5eH6J9ZwpSCzUkjdMxjS9iEwah+BVkA/xN8b6uIZiUuKLtEvNoCRsRaqLfjiWMrcac7Mf6fFCBHPV5L0c4XqP56ivzHfbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCOutbotbzgA5csP0gY1vR+duNEbqOH4HovztbtT8+8=;
 b=i0P3Dbkj/i69ymP9p/SIa/7jGI6GLQxxmHlikocD0eMnv/N5meppabY5DlH8O+At2tEl87b/Uuva2ejllZoDDy0PjLrsr2Ee8alzFbcYfzQJ+vpf4lnSv23gZjGHm9RgEkHIR18CR3Glaald1DUzFSGw/fML6DfNjwPFd3w3OWY9SbFfDXZWJUfxxg+unnPj2HsrAOyvBWhUchF1Ib+heaEi9ujvTTfQuBz/yAq67xoJQTkcsH0L/K1JFGjreGohcrdvKAPFrRyyLR6EzVCfvOpWhlOi88+2W6CUNz7RmMbnXlLvm9B/6EyIu27mR/0/GLZf61Hkv/yNMETumAiJYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Sat, 14 Jun
 2025 00:16:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Sat, 14 Jun 2025
 00:15:57 +0000
Date: Fri, 13 Jun 2025 21:15:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250614001555.GR1174925@nvidia.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
 <20250603152343.1104-2-jacob.pan@linux.microsoft.com>
 <20250613163103.3bca27cd.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613163103.3bca27cd.alex.williamson@redhat.com>
X-ClientProxiedBy: YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f1a6e0-6794-4b40-d95a-08ddaad8a25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cwUZSs1sabWmODzw9avQP21e2heFw7QAkzEFbgSJccoSAwdOGbe1Ootb5Gql?=
 =?us-ascii?Q?wWjg2uLdQBYacU+JoSrwtVTMkUd51dio8tNMZzih2knPFnsqoHfq0WjacOw6?=
 =?us-ascii?Q?BDT5qMOgA1SHbrFD1oXdQFd0QfTxhpyrhjRj7DI9tRsy+mUpgfxwhn1O1pvz?=
 =?us-ascii?Q?BnzpSKjXUiyyLN41R5tSZsFLvIv6ZmLNLz72H+KVOU+9frCHXMbX5JALx3fP?=
 =?us-ascii?Q?DbR7UfAcABdRseQ9ZTeEIIp5z3Qy3fuzIZVs9N85uWW+zSMBysliCird7U0s?=
 =?us-ascii?Q?13am4qr+rXyRDHwN0Rm1aOEtUW7Vnwj0RyD690DBcGPKbYkIR3BTaJY9iRZo?=
 =?us-ascii?Q?HjD673MrMyELB1CdAdWIxp9h6khD3wgLhDyZrg37PUES3KRfE4La6F3LvPb2?=
 =?us-ascii?Q?6WwW2Y0EZFuJyUUnLtdDYIVh1bLQc0nf/LF8Xhk0Bhpmkg6irPqFPwcwjw7W?=
 =?us-ascii?Q?31ylF5YxXJwpqZAaK5UVJLH2Alo3o4TVJc7deFPRLVKEJbmUvTJ8v5Cv/NuQ?=
 =?us-ascii?Q?rEwP6WGhYeju5PIY+usHKkyOi1TC7BdK7ODQSwGqa4QCp39uhOMvqL8mdGev?=
 =?us-ascii?Q?Ris1BLi1n1I/xzCbGoYM2WMZDtB5eVc1Y4vehrv64zPAvxcu9fOwS0RPGI3y?=
 =?us-ascii?Q?rpdFppZ2RIy2HMKzYEdvflyhegAW3Uqqi2DZsiGhIDaS4APhNSF7jHIyWXcZ?=
 =?us-ascii?Q?mxIoQXckI2Q3Tq9/XMunt6ecxYfDKGF/+rOHp/kiHvwrwOKR8ZvD0q5nI1R9?=
 =?us-ascii?Q?XD4/W/lDysllvyLqEeDGNEfruYRx3yrv3Ec8LpLX+mS+DlDLY1R+EXqiZJpm?=
 =?us-ascii?Q?aHec8CQwiD4WdBZnpWF6ZYdE8tLQz7KDkqf7uVMOzLYC8Crri8w2o3gwb1sC?=
 =?us-ascii?Q?M1uqdGS4+OtWShwAlylZeJm1ZAeiymh1lYSCWdkkvaLER62BdNOUeJCIaZcl?=
 =?us-ascii?Q?pvxmkGHFSagKRd6ssC8EUn/58BH3XtxTYGPWCw/LnZzwn/AISDWEGoi9Ue/n?=
 =?us-ascii?Q?CpmVgBgc3hZBKmfiqKzpl9nI0MFunfMtiDpHQk+A4Akh0nw7CP7p/Tf2dqmH?=
 =?us-ascii?Q?cQtfIiKRhRm+EhUgNqtbjnOFGNeL9oLunPwFRPVkq4HRMPAubozEqpGfpqEn?=
 =?us-ascii?Q?59AeLFKJ+P0JO3tZPrww7lQJCARzM6Llp+tP1mRanAzfHE0Jni8omGgB2fBN?=
 =?us-ascii?Q?eeNfDMqt11es1/613ajAeY7dkWyJ0INgbmye/ebx407GVfuGfK0427UUw4sQ?=
 =?us-ascii?Q?N7AqHtoxNzhNvmNeWcdbROgXa0MAvaA63hDFXM7eCUckuxGg/enBvWSZez7T?=
 =?us-ascii?Q?zClCiwIPhySd1EEQhdQbkVIIXZcssCulyr0A6OMBfX1fNSoLvEJoN86heshp?=
 =?us-ascii?Q?08VIuExWqAo2AJCSeezuHmjVQunJjBGQ6JYCRyH4E4NTSUpqqVIz+LG65Off?=
 =?us-ascii?Q?wgChHU14xtM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7/c9wh1sgkCuGoMYE19cF1ZcbRAX6VbjzFlrEeKwTRAfLiAMSCRhRdBeud+n?=
 =?us-ascii?Q?dgk/TvTrQqrMtkQB66q0CsB5xAP4spME74Nk655G/pZzsTtMRiEW/Y145xXN?=
 =?us-ascii?Q?MP8GGTGMpGaBQnwI+aYx6za4YT8uMB+vhMMSXK0WjnCa9+VNcBVDczNR6fG8?=
 =?us-ascii?Q?DhkEKTYcwXf0BV28HNlpnHh49zldW/x9Qf1BLPEUnA5gJFiXqxM3cs/G6W6K?=
 =?us-ascii?Q?U3cPvBCUGLcyG7yCKnjvfIECS3T/fbIa0tk2j6Uvkvx6wpHkBozE8ofQqPFE?=
 =?us-ascii?Q?jGBCQBpuSv0liEiiOarJqbn03xYhUVfObLlAF1Y0xXerUqA6ELzkK56IrcPB?=
 =?us-ascii?Q?V9idwQyXYjueKwhf0GWl55SQnm7B3ZNKzyKYyW6yM5IHx1RS2U/HHHrV85JF?=
 =?us-ascii?Q?/de8pEP69rDhWJWTo3Mr8xVpJaqcU5XoyOse2EMLqrLF/+rKIO8qEFXhiTnb?=
 =?us-ascii?Q?fjOsUW1w+0ShoMlOtC8z1OZUKkt0KujBl/skS97EuMzcOZut7bgemue1XpxG?=
 =?us-ascii?Q?Rhm535bvCxIuVNeu3QXIRMdzP265BBsuvLi1rxfWrtUvxhVOyxzg3dt7oj8v?=
 =?us-ascii?Q?atxq7mr0LWx/AZsvA3qj+thAI0YT6OHvfV46oYAYVAz8AJ0NY8T4q3ZcQGxh?=
 =?us-ascii?Q?k1KQBoVn4sFovUhIZZ2WqWP7lZfKghN6hdNvMnnhEC57TiNnWdzaiv+JkSIb?=
 =?us-ascii?Q?ZtzGP2Mk48kY47AeRuewdHtPHfbHxotEglQErpNOocf+qdLzuh4X9IVsQZV+?=
 =?us-ascii?Q?m69OCIhumfDohdpWZ+iDavPv0MWoG+aCtS6GDC7geTrv6VwiR79hRJrAgBUb?=
 =?us-ascii?Q?sEKwOwTfeG43XW07HTk67YmFJsrLkl/5hSR+LCcbwqEDBqlSiYrykc3wze2H?=
 =?us-ascii?Q?1b7x+/LN/Ic3G8JtOgEEpH1ovguUsO0YHtoVzZNs7CAOcueTtR2dYH9WJBu7?=
 =?us-ascii?Q?KtHCpUtwysv4cvuAvyTK/+1UZdMaRFBk7sCU1EYU2whbxXWS5/3JJDf+k72f?=
 =?us-ascii?Q?nG7SwJEtG486GrT3kB0QnsINuQCM/p2FMBINmv3HC7aCdzaLzGNkz432jl+b?=
 =?us-ascii?Q?MF0CgZrMQOhiroUFudz/gQdd+FhF2nggbRZ2fw2lYrWuXWdr6mEBKDV8KFqW?=
 =?us-ascii?Q?ilSt3bQSxusG1BVTDRSW0uPI63dTkJxf+h+R0B0DDknwjCjwWJ1wYxYESjK+?=
 =?us-ascii?Q?jETaeDr4f42Uoww4vzqLFifOOO6Jgi/mz67RIwhK/D1A+e9PFKKaoLRRMLD/?=
 =?us-ascii?Q?24Io+f73q4MEccYlwWbxDQYo3aCKqZGNE9wMAKEL2zOHGPFSRPGo+wOzRHSS?=
 =?us-ascii?Q?QHagpraGpum67KyhfBIW9qd5PEq1s0yAD0gWthqb5E7YKNOMpSnUOjoSjNuM?=
 =?us-ascii?Q?Fv2YKgdHTqL1UFox6zj5k9AVNuudvGvLmiEsFm8prBkouK2TUv91t0xefinP?=
 =?us-ascii?Q?9+LTYLL/bx539oRKGKBWTpWk1SXGQRH9crqbFzoQdzuY2hjYHZ8tYinjGxYl?=
 =?us-ascii?Q?4tJvdU3QrqSFp8oVWF3FV2mn11JCxYHy4iEVfKBPQ7GFbx6uA6A6PyyQzxSb?=
 =?us-ascii?Q?sOS92yMiuMEm7WS9rud93sP9fCGyrlgo3khB1sa2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f1a6e0-6794-4b40-d95a-08ddaad8a25f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 00:15:57.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rINMoRC46FUCyHmbv/jpUG0CyqkbKKIqnbPZY2RxAFUPXYXvQMN7FHLg5m6eGs3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

On Fri, Jun 13, 2025 at 04:31:03PM -0600, Alex Williamson wrote:
> On Tue,  3 Jun 2025 08:23:43 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the group
> > open path skips vfio_df_open(), leaving open_count at 0. This causes a
> > warning in vfio_assert_device_open(device) when vfio_df_close() is called
> > during group close.
> > 
> > The correct behavior is to skip only the IOMMUFD bind in the device open
> > path for no-iommu devices. Commit 6086efe73498 omitted vfio_df_open(),
> > which was too broad. This patch restores the previous behavior, ensuring
> > the vfio_df_open is called in the group open path.
> > 
> > Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Tested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> > v2: Use a fix from Jason
> > ---
> >  drivers/vfio/group.c     | 10 +++++-----
> >  drivers/vfio/iommufd.c   |  3 ---
> >  drivers/vfio/vfio_main.c | 26 ++++++++++++++++----------
> >  3 files changed, 21 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> > index c321d442f0da..8f5fe8a392de 100644
> > --- a/drivers/vfio/group.c
> > +++ b/drivers/vfio/group.c
> > @@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
> >  		 * implies they expected translation to exist
> >  		 */
> >  		if (!capable(CAP_SYS_RAWIO) ||
> > -		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
> > +		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
> >  			ret = -EPERM;
> > -		else
> > -			ret = 0;
> > -		goto out_put_kvm;
> > +			goto out_put_kvm;
> > +		}
> >  	}
> >  
> >  	ret = vfio_df_open(df);
> >  	if (ret)
> >  		goto out_put_kvm;
> >  
> > -	if (df->iommufd && device->open_count == 1) {
> > +	if (df->iommufd && device->open_count == 1 &&
> > +	    !vfio_device_is_noiommu(device)) {
> 
> Why do we need this?

What I was trying to do is put all the logic about noiommu into only
vfio_df..open/close functions instead of sprikling it into a bunch of
other functions. That seemed to be the right point to make this cut.

> int vfio_iommufd_compat_attach_ioas(struct vfio_device *vdev,
>                                     struct iommufd_ctx *ictx)
> {
>         u32 ioas_id;
>         int ret;
> 
>         lockdep_assert_held(&vdev->dev_set->lock);
> 
>         /* compat noiommu does not need to do ioas attach */
>         if (vfio_device_is_noiommu(vdev))
>                 return 0;

So this should be removed, I missed it

> > @@ -54,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
> >  
> >  	lockdep_assert_held(&vdev->dev_set->lock);
> >  
> > -	if (vfio_device_is_noiommu(vdev))
> > -		return;
> > -
> 
> Why not keep this and add similar to vfio_df_iommufd_bind()?  It seems
> cleaner to me.  Thanks,

Same as above, we don't check for noiommu in bind, so we should not
check it in unbind to have a symetrical API design.

With this patch we move toward the vfio_df..open/close functions being
symmetrical in their decision making.

Jason
