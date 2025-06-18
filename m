Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDD21CC5A
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289165; cv=fail; b=tFg9tErxtldg47IjUW5O3o8EM4r6HACtOGJ7els79c0wrNmhXbYOKkWOvOvcIJ8XcBeTYInk8aOhMPC+MMybPjM0EZMIxRjBs3KdhEjqG57PADjnujAGMhXpfzb4iWKpIVbnkKSG/vNnCt0XPQI0Hdhz0jhDMD/UWT+2FZdOuDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289165; c=relaxed/simple;
	bh=8XNxbsF5egixZz/4Zi+rJTCZqaIGIMfOrBLy7kXXx4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPA4hM53Xk5QJH6r0ZsgnX/HsnwsrbGZ0dZLKhuNV1hQqGmofmyxzyaM7hqjHwaA6nKSXxANd6f3FWOTcH6mSHHlgmEJ2l985epHQ60p4TRUHye0w9l1jUpteFS1fgga9V51Hg8XIPc2G8te/ELCFhpNeiQ+4iaCZ7nz2dSFiS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZtSMTyT; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZtSMTyT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSeldcAyZjdxWgZxYxNXznVpIxyztVeNR1Dgfhq1eNgqzrsGHY3kydwYdusyRMcGJpDX6g8fU7vFU/SjbhdO2ojk25nT3zH6xfVFmos8aIoKmQhynK8kDs+Pww0EmkOHOK6TfSdLKDTaFwauMP310sX8+54/xJlVMAzG2AeY2OrfFok2y67ywW9m3McXBbViDzp3nk8jaygptiBDYVKFhP8AD6JdjsHTnDJHH26zmxrsqYx4sdNRwtQkDBX4P7I1IK6+8dQc4WSU0q9nZR79i6SO9HJQdhAUsQYkJUzJo5y9zhbjgrs3t35k6Nvs8qZiM7B+xWyhCa4OoPAgWwuVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8UiWzDpKhkK70K0jNg8goOANGb9TWbWh59fspS64f8=;
 b=tTBNY1SNO52lBPACv0oCEb9bG1phNaaf8omXUM9Vj1l9f8hIvZaVpmwee4g2UxSsnO0cQell4+Tlzhpp7gXbTwkBijPevNE9aWJQfMh5PXcCzBsh4Fy+dAb9V36aymMIPB6GvPnHUrDOao6vqthH5lhswUEBGSOl3MgHWFUcNaLt1fXgZh3MPKUGz0EqvCKQcJM3S5/hmJP+ETNtpHwXO7jIjXMTosn03cY8RsSC1cLemmG5vUDX7rbdU8B/VzWBIHt6HvjJ6Ut7JCLDxF4+z1AHh45aYYArG5JO2DpkPacjtMhDFgjPBbTzB54fOCiSayNA1YjMGjj8aDtV3NCXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8UiWzDpKhkK70K0jNg8goOANGb9TWbWh59fspS64f8=;
 b=FZtSMTyTh85yAv66SO+ydQJELrN8ALzF6l9G05lrMMpHizX73IFYaIbN6nZlHsBriAKM78Yq3/+PpkrB+B4ao+mdd2xNB32Up4oKL7dxZTd4hZW8fbBQz8Vxfmg8iJMGo5Fw9ffaeIkBO0aaPWgtc69nRMnUmzBlZmxqwWbEfD1LMZvx/WdXL17u8sNWi5eCrMJLFz0lskLp1l7tsMlvvs+MFjTaESw6meZFSxu0f48YFUEeSyGlVXo22e0ntvOsGHlNbODyUXABNOjLtgCxY7/mI735Ex/eJ4ZkX/FybAQdE1D25IPqHUraGQPt5AUwuizbiF7njLG0fNMELfrxOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 23:26:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 23:26:00 +0000
Date: Wed, 18 Jun 2025 20:25:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250618232558.GA1643312@nvidia.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
 <20250603152343.1104-2-jacob.pan@linux.microsoft.com>
 <20250613163103.3bca27cd.alex.williamson@redhat.com>
 <20250614001555.GR1174925@nvidia.com>
 <20250616084708.5a94ead7.alex.williamson@redhat.com>
 <20250616153455.GK1174925@nvidia.com>
 <20250616134004.60105ad5.alex.williamson@redhat.com>
 <20250616200558.GR1174925@nvidia.com>
 <20250618161136.39029872@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618161136.39029872@DESKTOP-0403QTC.>
X-ClientProxiedBy: YT4PR01CA0259.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c76b23-f429-47a8-b112-08ddaebf7bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QktvEPS3glFQ2NNrWZCZnrRHjjPoqXhx9/mpsgt2DQVZ9zaD2Tt+RHcadzPS?=
 =?us-ascii?Q?xk5iIUAbcoN7xFIiNJqbg97HSws3glmXbIoE8eHM2AC8fyPsAfan97gAnmze?=
 =?us-ascii?Q?hHkgnKKjQGuoM1LWfNEB+uHpyIfXtX8CivHiS4L92/XMXbd6DlPNKa8MIhqY?=
 =?us-ascii?Q?8JxFyx12LsWIl+ls6v8qJo02MHP+i3yVgVdzuA4PPQp7wFi9/0A3731xGbDK?=
 =?us-ascii?Q?kk1dfrJIo9W+Utt9qqTAo/FmGlc0Ly8NOTgsiOocH87WqS7misQc77TbCj5y?=
 =?us-ascii?Q?uIuyaBCz47CTpe34v10UmVpGRLdGsFJyC57aPlw7SpsHtQU1HNgqB8BVE5WV?=
 =?us-ascii?Q?XkaVcz24kOJymkwT2xe9lphhXqdmrhYSfoNLW4bJZYG/mWHRcAXiY+z46YkZ?=
 =?us-ascii?Q?gkjC7szXIneF86Stor7SJOYvJ4MTmokNfrWXd35q5T3xhbuEOCxFS9pBZ9bE?=
 =?us-ascii?Q?al0zQH8zE4IkHarxtsOcZsOr0XxVV+GHbln2HH3bJa10FTr0yWI2cELbPEPV?=
 =?us-ascii?Q?51M3u84aYm55R0TSwBPsUI1uiOxqnOMrwGtx9lC1ETQ+wD/ZJZfNr7n/WRGg?=
 =?us-ascii?Q?SVJpa9YsfB8ptMTs5iZZxJMRp6HlPDXFAP6Loai3qR4nKNKOUK4OqY3tPttX?=
 =?us-ascii?Q?+Dc5vjFMx1NgTH01WLry6sfuDsfavAPz2m325jKZHszc1UcloUc8c5jVFDqW?=
 =?us-ascii?Q?CiuZ8wXOVSOGOFurxUHKh9MaM4xEC8v7D4s4vMXC1OBSNzC/+Thx8H3x9bNf?=
 =?us-ascii?Q?KDrM0YB8j9rh3+zeDhoWs2VZgCQtO1/XuVYke/g8I2XywzFJFUiOCeJpGRkF?=
 =?us-ascii?Q?TLP+f1seOe6WB/pKOAhRRbW9+Sm3H2Jsxs7bUAu3EYE2Xn8Q/+GSEowcNdrP?=
 =?us-ascii?Q?4eqA0iQzLP17b/hZBGKcIH+Z1NBZ6K3UKJsDDj7FRZorOC4dJK1fKGPDpOiw?=
 =?us-ascii?Q?ZMiyDWu6/uIJWjEQLQ/Bmq6hBttcAvIEEchMJxOT9n01rzn6mjGuN7iY64AH?=
 =?us-ascii?Q?vHTB4ctw2DxZwHTM1HJm+QsscKQGSYPRytitaPWU+QVArT5n09ssA0bx6kZv?=
 =?us-ascii?Q?JC28X3aOD14667T4Oxx20jJnvC9PEd8aLOO6KF7uJRf2PbC8iaqdfG19F9Me?=
 =?us-ascii?Q?he7JsdFsGn4TbnaQ7tq996ClwGOG9aBfAfkAoid6t4VKpwKmAbyjwacg4ToZ?=
 =?us-ascii?Q?UNo0Mr9gVgYE1ehl+UPQh1Uk6k2088MEh/j6lxEL/o75GNh/Kvj3UGfNoZ++?=
 =?us-ascii?Q?0HpQKhlvWZqoKB2jDIqKGFX/Orq5WcMDlkLCB/UYJWuU4fhNgVcvb0arHj1r?=
 =?us-ascii?Q?/yRn+6qtqwoMLk47pxrl8zKJy8Xu42v14pg9taRy52KgPklwEnZ2H2KwOoX4?=
 =?us-ascii?Q?XHPjAg8FsiVFY+I3G56PNkU5tsIIaRNxQYny6flCPIFysWUu1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80EqPPVtcW+cko8Q2+62fjYHnWi7kHpMID+HH+hXTylaBybHaHVZP22GiNZv?=
 =?us-ascii?Q?V7k233c31cAFdsubTX24eXMAf6848r42VSvakmM601dAmgJkUc+xxQgimbyg?=
 =?us-ascii?Q?Ih+pgtHiMGPG340q82VA/GD9dPM3oOJu5dYpUDF2K0jDxH5EB16druVHLG+X?=
 =?us-ascii?Q?K3KGHaYVP8Gpemg2mB9dFvyS7pkaNHq7MRL+BprXWGhVHktbw08L4tEfcKY0?=
 =?us-ascii?Q?Hi45NdKOipqbrcnVpK3dlU5CNmTnHHDHsLNSmuA4CUHI7Bnj6ZrXZ416DPg4?=
 =?us-ascii?Q?9dqBM6ep6ycAWKHWqX86xWig7Hz2N8dtLojEKdrvqNkp1Lokz/Nru2718239?=
 =?us-ascii?Q?aa42WeDpiC3MjjTn9a0FppQL/xz2jtXfNPgGlszAelwot7a+nifpXYPwOPrs?=
 =?us-ascii?Q?MHeKYTKvqJ0E9IHf5PftkkPeA20aLD9mi1YTJ5X+Mpyjio6YxTIw9IkepPYU?=
 =?us-ascii?Q?kWB8mTUbvlZrZL2RF7AzUV0UwvEI+JTZpCu1CaRT8T66eYKuvODUcw+fw7u0?=
 =?us-ascii?Q?QIVCD1GOL3hyvuQtQDWh8P1iLLvWD3bddheb72W6BhB3nPg//SOi4wCeR10R?=
 =?us-ascii?Q?jQ3W8HFa8DnFs9Vr14m91UjGM4GkPh+GKDz1mB3crJkzhxpyTqL+vnsp+azx?=
 =?us-ascii?Q?4SHVEggO1moOP9gXWwedAatLr2eTS6lPYOU8GeFB4acURP0TNTB+7lMlwblu?=
 =?us-ascii?Q?nFQfPqDrWbQCs22MwV0s428g7Tl4yaMCQ6wIJ5sD9cVhWXDC06oUOeyaxUIa?=
 =?us-ascii?Q?mTruZSPwP4en6d8BFUW+AfyplswemzGBJa+0V1mW45RQfYZRp5xrEf2FZOhj?=
 =?us-ascii?Q?V291+LY4vnPa5xlX0xzGytnokWA7RyrZ3OQtUFQOZz9gNpp2vyvDaDZkH20j?=
 =?us-ascii?Q?S1bvDuNkXZ/ZK+Ee5Wfv/H83BDeSIC1sgVtHr2hU0LVs8TpVD/Qut46EJR6c?=
 =?us-ascii?Q?54pk2qsY6SN+adz4PlpnBUJk9UO5L4jFY/DR+IWucC0mlazjU4mL0Bl0y7J5?=
 =?us-ascii?Q?8eK7pHlqVHEsh3NQ3dzTIphtefBB8FgeFH3V/trUlcfg7yYfXZ87WhWLwFI3?=
 =?us-ascii?Q?WzHvLHoZ/0GeCzmkHgGnde2zNBFAqQCa5of7J7TrM94c36brC56LNEyVfeQz?=
 =?us-ascii?Q?XbmZpr4iXfWYMg892m4bbeOrh4jlyeTEdCEcwwJSEU/r2ZhPf1xEmdkFA1+X?=
 =?us-ascii?Q?oMxxq3hM+IqxWjEwLsJ49dibh8NdlM7VkoWU2lkmehppomdXD42e57vucEz6?=
 =?us-ascii?Q?c5MAKpdaK9WePUBHpJ5gK1QneOjs2Q6819QwMa8xnJWwF35RjyycLWf1gFxa?=
 =?us-ascii?Q?/iJcSktefzlzChS/zb2NkU3tYmxSNbYnVHE81RSUCCQ/GoBAcB8n5FCCVUdI?=
 =?us-ascii?Q?/LdCHdx4ChAU2qB6+o5L7RIe3b7yZBKX/GYSFbL6auzgs/oq4Y/dqLA6mu5v?=
 =?us-ascii?Q?xatlRZ9N8gVe4Ifd29gZpHlBjjv78kiMTZbW5F+PNBFUUUavCAS56cr+ELy7?=
 =?us-ascii?Q?4yJXycp9F6gb3m4Rv7CtLaiCmn/sKUl/Xho8SBr76j6NFJLMsbcVA5iEP/gi?=
 =?us-ascii?Q?Xzo9HXZ0DXfR5pE30po=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c76b23-f429-47a8-b112-08ddaebf7bef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 23:26:00.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zguCwmCzH+B40GydzHUKFPJ95IJXu9lJVYIuX8YHxoUYUE9NClOaWbKk+KzcFe20
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205

On Wed, Jun 18, 2025 at 04:11:36PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon, 16 Jun 2025 17:05:58 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Jun 16, 2025 at 01:40:04PM -0600, Alex Williamson wrote:
> > > --- a/drivers/vfio/group.c
> > > +++ b/drivers/vfio/group.c
> > > @@ -192,18 +192,18 @@ static int vfio_df_group_open(struct
> > > vfio_device_file *df)
> > >  		 * implies they expected translation to exist
> > >  		 */
> > >  		if (!capable(CAP_SYS_RAWIO) ||
> > > -		    vfio_iommufd_device_has_compat_ioas(device,
> > > df->iommufd))
> > > +		    vfio_iommufd_device_has_compat_ioas(device,
> > > df->iommufd)) { ret = -EPERM;
> > > -		else
> > > -			ret = 0;
> > > -		goto out_put_kvm;
> > > +			goto out_put_kvm;
> > > +		}
> > >  	}
> > > 
> > > 
> > > And add a noiommu exit branch to _iommufd_bind, symmetric to unbind.
> > > Right?  Thanks,  
> > 
> > Just comparing to the original
> > 
> > +	if (iommufd) {
> > +		if (!vfio_device_is_noiommu(device))
> > +			ret = vfio_df_iommufd_bind(df);
> > 
> > Isn't being captured, so it needs another hunk in
> > vfio_df_iommufd_bind()
> > 
> OK, will send out v3 with this concise fix. I am also working on the
> noiommu special mode as you suggested, then we can allow bind again.

Sure sounds good

Jason
