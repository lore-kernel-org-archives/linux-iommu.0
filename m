Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634321F099A
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104364; cv=fail; b=RLaFJunmpalluXMf407w0UJ0y9xlowPP3S9WAgaomg0T2v8d6eRFtPzAWEfivNv8THmPnyXhg2CetXAcSLWdxVLBxBHu43rQIcp0aaXcshoTYrPd+U54SbhWXR+NXzlZvvsZkNo297iBpS4j0APo27QSz7XPoPHLirIRI+5me9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104364; c=relaxed/simple;
	bh=ySS+ZiT/YsP8dN0Q5c2/dCzEdEw1ByCj4TS+QzroBzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=swF+TGYtja0DHOJnP2x0HK1PAE6dBGvLNyDt06AwV+MTz2aheP9KY6AqXbt5kXI5Rs0sGz5m97GRGn/Yo+HXl+4qQFJmRB2QdFj8j4aWiaRt6f8ZHfiZxWoEBft67+OmwFNYw87h6LCey99oTFfQDXwcBR7ze2tI9LUYlPb6g5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F4fMMryy; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F4fMMryy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLoC3ZO4e4xlHIahUEBJEpDU3On7UI7958ZhG/mVI144Ns+TzZta52cyFCsSabBba52qmcupDuHqRbdQNRdtFgDIQDYf2vM/hNVqAJsloD8T+7H7VW6i8CtLRFQEN9U5MMJmGAQQizutVQmCRyFmDA7SsHk9MsXy3iQFFDmEyaEbNeg2rHWnHedTes0IJ/e0ApKnAjc07NQzcYGI3UU4SLYO874DggvC07L+ww5WXHHPmS4ZHVpQLm1m4VNTon7EA55ceSdJr+MVrezu2sNaEaIrXUNgQjlcugAUNvzit1boxHSAghqiL/KNCogMDnTczx3ca4dIKIVGOaB6UDimfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY2vs4aV8sBhV1jQ+JIOr+BthuLHNRIg0PG0WR8dp4I=;
 b=w0d030biYE8IAkS1GL7zkuKQlNizHRMKFcGTxjdG3rH1NM6ZXcMD0s5p4jX+egAzdKF776NpDodilaEInU0MleFKppT1fn9a4pjNQvq93IiuM0+Ex1+dg+tfKWd/wjFsUyJkeIOPRYQw+6iefYCBWq6I+FDMVrDKjdAvFCupIZeq850mjbg3KnKVH1f5bEekR7O5V+IjwXDiQwtak7pr9f/d5Nab+YdoJbom2yXasEZGcQJAhYxwXp894bUssSPpH7r2DdpNp1LRqdvBrUnJlndzR34r6TZQK3lsJsiFLrObux7drBIe2YymucPRRGO9eeCh6laEO4S+P4Hq881iuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY2vs4aV8sBhV1jQ+JIOr+BthuLHNRIg0PG0WR8dp4I=;
 b=F4fMMryyiqsYWgS31XgmFHWR2XUWxv+5+eIvS6LxQnirGlJoaZ3lUuOMFMxo4RgUM+lxXxQNwDa/+/7hFDys+UlU+Es9HCS8QuAzHb6tSTGA07LSpB+g36z/OSTaL+j3qc5BcJYFFH22pUU8ZrHRGzEo2/CALI80E8xDMHNcMt7n71qBBmfuZitXartPD4FPRqEqGRnxPwYxWQQSfPQGTQa74S82U7hkOkZkAUoMSqciMIA/HnV+gnlSAD28SCiAiRzbd9RbWHsohcNMBrvZSI3L/FBnDudBeQwaVuCQDAM+KcjRwa0ZPWzafJ+IMa3qWWDgvjEcgg/ESv069thVGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 20:06:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 20:06:00 +0000
Date: Mon, 16 Jun 2025 17:05:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] vfio: Fix unbalanced vfio_df_close call in
 no-iommu mode
Message-ID: <20250616200558.GR1174925@nvidia.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
 <20250603152343.1104-2-jacob.pan@linux.microsoft.com>
 <20250613163103.3bca27cd.alex.williamson@redhat.com>
 <20250614001555.GR1174925@nvidia.com>
 <20250616084708.5a94ead7.alex.williamson@redhat.com>
 <20250616153455.GK1174925@nvidia.com>
 <20250616134004.60105ad5.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616134004.60105ad5.alex.williamson@redhat.com>
X-ClientProxiedBy: YT4PR01CA0436.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7fc8b6-07ee-4fab-a82d-08ddad113680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OyPI1BmoMPUSsI99WAcPt4Vo52DJm2Tl5jWPvUDVuf0hSyzYEk/trLiEcemO?=
 =?us-ascii?Q?Oz4b9T+nqbQ13cWbyScdXvj3vTKs8i4Jaw12jaew5WAvL2X66xgQALq6DApL?=
 =?us-ascii?Q?16pDi5Cxnsa3pAc2Ij33zl+xo/1NGbvT/zICIefAI9yBCMrHosQdgM4s8oPR?=
 =?us-ascii?Q?lee7oqXpznuaAgg7JnpKc1ZOgRDi3qgSKjb/ZbG8DsqokTAq4bG+tbtzH0du?=
 =?us-ascii?Q?zkc7fWvIRPX2VIZwYfSVou/Zbfb+7cMpOSIu26yVqtr8svgM0hjXHiDJ4fSj?=
 =?us-ascii?Q?rw/+5zWsFutXQsswsVFdCQ5sXEPePQaRJrOXvO7nir0h4zIbphBGID1F/cTH?=
 =?us-ascii?Q?0qsftZO1qtQqUSKwaiDqmhrvMzmHHF4hCgQa4QZagqTJLOmF5P1gMsoh9Bko?=
 =?us-ascii?Q?4nXvPNHJRBhHK1f+PBGUpFsUFwNz3kJ08HNfuZGqpBTzEdPofvbjZeol6GvU?=
 =?us-ascii?Q?DwlSxHra6ObgeJi7tBYMBPFx98QK3LD5d7ZxNMof4TCxEkNjSYdGXvFFpih+?=
 =?us-ascii?Q?KwMceNTTenQJ96HKvIcJem0kVgcAMcqY3OwGmw+X/oOfnWaDJlZyEJCMOzPi?=
 =?us-ascii?Q?QoMQeTNhEuybArh4X159UtikZuKRP9h4LEJnAZ4wyIXAcdgrRuM6FnVuRLw6?=
 =?us-ascii?Q?Qua1/w7ItVSFWaLfbsyP6BH783n+f0efgYKnC4GQT4YLORSYvh/i1PjmB1bb?=
 =?us-ascii?Q?+1j5T1uafLlZvh5PsUwghqFteVut1UU+Q4tGUk7pN+tHP3VEdF9wRYQYFMqU?=
 =?us-ascii?Q?eOaK2UdfaZaFxil7PSeeEqEeWYceQS6idI5DFYgGvTNON0nEViyHKR1y5k/R?=
 =?us-ascii?Q?Tnb3wvJdEi5+Cu8OzfZR6YU+/1lc2+rT810UM7LIc21qlWZ94TQya4eS9tO3?=
 =?us-ascii?Q?hQ1qfmWIrwzRlHe27yx8XKRC+7n7vdEniW0kj+6ljEJDSwcDTewEY+2Yvtzv?=
 =?us-ascii?Q?J6b5RVU1O3nc8YvHiZt9ISUJKc5zu5MnRZftfmOl0xJV9KaApVUBXwqMs+vB?=
 =?us-ascii?Q?UVy37vAziVi7rwV+Bx8PrXjmitHC2fCMiCP7oqZyJLYvl5SIFgqNBK+bkLMr?=
 =?us-ascii?Q?JHzNj7lFfEVzifIzNVFkTOjDAj1xTlysnBPMe6uffN5yNybrgXmuUKJquBMR?=
 =?us-ascii?Q?PeTWeAw97UNUOh28v5A/il49mmYMxd01JQA1uhHzxGzE0uORB6kUktspUOCj?=
 =?us-ascii?Q?u/keac+FVbGRG7XyfQAq/89cAzuRrqqS0SaWKJCXDTR4VBC7/w5EPKbI7azD?=
 =?us-ascii?Q?OzVEx2h0PTgiaoLB3/djsLI7L67Ezr5+hHd0S4axlXHzPlpk7vzycCE2Hg8U?=
 =?us-ascii?Q?FcxtysR6d0aylCma2Jc+aVZo+zc0bRBl0ZJSz85loy56TbU4Pb2snTZXa/co?=
 =?us-ascii?Q?9cK31i3gtfMm19FsiKoqKYmJEQv7GK4QLbCB1gBoSx93d+5lMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqTkWtrxxQZ6ZMpq5TXqdv+Jhsg/lcs+che8m1Wh7HBa2FBS58RSPbyhoyrd?=
 =?us-ascii?Q?Jl7lvvqz8ZAJbRgeZfWQTODGSQXNQMVZcgypHYGEnvx1HSjZclh8Qgor2Umb?=
 =?us-ascii?Q?Hul+29BPzLlejBYa5yU+KGO5ucpf16OCxWe/RcFprtCOQt2ThwUoyynoTylb?=
 =?us-ascii?Q?roieBxtF7GBqHyquasDZNdlFi6RWIL48v+OBwoXgUHryzRAZ4ImAWHY3unp5?=
 =?us-ascii?Q?2IDYdEvsXk/EW8r1iEgWy99nUFY0SzAl58wXPH/oZoQwOy8KhagrqvFVIfuh?=
 =?us-ascii?Q?59uTRPXFSwkTCuxurWw0AibjbZnRMwpwUTToymUHf2S+EwRrGDa2TGHyvI6s?=
 =?us-ascii?Q?h0gO1v7swCLQf/BBP/twLhlqpaEFsOv2UWAkto/TTrvfXcnxZiOItB3S5lwE?=
 =?us-ascii?Q?PhbQZ48kq8qSNl4kuYSAK+ZyDADcvQ6LfwhqrU0Ab2VdvxvJRCU0rxmcOA9J?=
 =?us-ascii?Q?CIay4kupqUtIO/dQbLjm4f8lnTJvwVLo76E8PAGpUMuC8RAkNoiUgbbW9Cfg?=
 =?us-ascii?Q?qHQqtsUl62ciR80WI2pryzVyNc7hIBcGGl9uiv1IP3XMZNAuJdrlvoEGlNap?=
 =?us-ascii?Q?A98VrraCfq4i0ezyPfurZwYqEl+ce+ClD3rKmah8pywbHxvp6WH2S6v+2SOZ?=
 =?us-ascii?Q?YkVbXyaw3LtzzynsN3pf+fY78YNVUWM71hTqg4kwzyX07dDmg3hOEfbUohjd?=
 =?us-ascii?Q?61N357g6+/fcfNkNdorFmx+X7NX9qiXI1NV5Nt2AS3p2FAtzseII4e2hlhdz?=
 =?us-ascii?Q?JeX9UdBQf9BUQskujSHjQ/3qZfQszmYVRWLcujKVeLuLH6bWEAmziSGNZ6qi?=
 =?us-ascii?Q?Hw/VWVTfoiMQsLWf069iWI0eZQnrUMzHMVaAv5jWaTmd6tFzo6U6aOK2RiGB?=
 =?us-ascii?Q?qf8GEwAUEgj4iznuTSH64DUwesMMQDaYDKdyk9wvSf3RQpiNUqWVjFwW0MYi?=
 =?us-ascii?Q?uVapBMuOYMk/n/75pZXTvEQ44ttQvN6PwAmWqRJKVKaqmBwCM/ZcraHFzMKW?=
 =?us-ascii?Q?vMb+xUmwcodo3AlfMNy4eiE7OP0NFaE+bLMaFzFVOwwIpFCySi1YDt+qIcRu?=
 =?us-ascii?Q?ZTisvkBJCOa0boVY1aA+/ZShZdYQxCmP7v3THolHUavG1SoVgPDGzx49/3Zk?=
 =?us-ascii?Q?n7x0Da8fFQSLcDjySCEeh/n1YdBdVNWfwTwNUd16WHZN0UZ+5Q8lYUhUtiHT?=
 =?us-ascii?Q?/6rx9rqLemHuCf73MiGl4RKkCmaQ5j8SOshVDEJUquthxsBoFv1Xt7RJT7Fk?=
 =?us-ascii?Q?7lw+OYI2T1kacJAMTtWh0enuZswIPEQOl8t5iSFxdi8Wk728ak8hRIteAFkS?=
 =?us-ascii?Q?A5HZIVYsaRLBR8Vo5DB66unKOeLdHe7NgE4yLReJwg4DRxjK+MIY8C70QjuR?=
 =?us-ascii?Q?Byjc4cLaj9TEQ6guj6i3g/AyupuoR0IEg7T6AwCV84zeHalk6E+nfuivebWj?=
 =?us-ascii?Q?njukBCbBKIl/ZBbZgNNqIOut2h8BindgMfnYqZgnPW/hRswzmwEADD6tpPkb?=
 =?us-ascii?Q?mzOXvVez7UlK05a+TGOSAvipoLdLcrkL6YX1UHDdvYnD6bEhoylc0Nvpkwig?=
 =?us-ascii?Q?EZNWC1ySVDLvM/I9rwHKUmKpgigB47JqDPfETomj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7fc8b6-07ee-4fab-a82d-08ddad113680
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 20:06:00.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4mnkNbPIkW/8SawV/8ddOtY3FMaf1qzB6tmuaWt5ma3aG/PCMojk2cuD8zr79G6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794

On Mon, Jun 16, 2025 at 01:40:04PM -0600, Alex Williamson wrote:
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
>  		 * implies they expected translation to exist
>  		 */
>  		if (!capable(CAP_SYS_RAWIO) ||
> -		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
> +		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
>  			ret = -EPERM;
> -		else
> -			ret = 0;
> -		goto out_put_kvm;
> +			goto out_put_kvm;
> +		}
>  	}
> 
> 
> And add a noiommu exit branch to _iommufd_bind, symmetric to unbind.
> Right?  Thanks,

Just comparing to the original

+	if (iommufd) {
+		if (!vfio_device_is_noiommu(device))
+			ret = vfio_df_iommufd_bind(df);

Isn't being captured, so it needs another hunk in
vfio_df_iommufd_bind()

Jason
