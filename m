Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AB145FE1
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256541; cv=fail; b=eRK+Rrczb0ng7t2f5qp/KgnDEiM0alW3zfb09jKPkDaiyG/s5V96ORdMX/7TtWi1Gokq9aSDLAG0qyUjl2D9MCJnU+ghurW+6+yaIYXykE7a2AmXSGHAVcaYB+T/M/aPXiyWBwX0Q/e9XcLM9sMj4I7kF89IAXhT8KNZQ1Dfviw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256541; c=relaxed/simple;
	bh=o5MLfR/0AwpZte2TYrvdm6BeSvtI/tAlDbkUxWW9hIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WpeidozoMR06T0pj97lCxYvyirtBFfX78NOHfnZm1NTXXZe5WJcMW1t4EL5qE1XnXAkNhsPcUrgoQgpx0+RtmN0s3wDJZXEkYiFNxs1K2SpOZCr7iso5mbkurOHq9VD3yHCFbAqe6b6Vr1dBHvqUN6nnKUic5KqdsH3MJE++oh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hjb/xZHb; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hjb/xZHb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6O/CIOVxLcysLvDLEAS/SQFN8gJgkq32aGSF9Me8jxvuOLGCiXl4v6WF4TH3xL6nb0fM1PYNyGF041eRrTHhuzLVrc8pDi4ChCGMNueBJzRAYA4G0jTc3GAKs4gvduOL4bMNjkgzLilxCepd9u62pMFJODSjHjOmiZdnn7DvjXJQiwKfn5DNicQft+2Udc1m+0vjF0q2P5TLqckoohBpcaRRLqKNtG9uT9ipH48WHTYu3sEBwLJGwN67npJzZDmH+T5ykNn/ANp8KjzhQl5mhLvVW4v00z0UcB7ffssCdheP0Zi1LF+N6tEjj3MptHpT4J35UctPphKrRV2kAH3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm7/vVFe2jClmonlTM6NNLq82LzA1wLnFxqpixscz1g=;
 b=jHCrd2NV987ttzBIGJRpGnyd6KB7VmevFYLdp2VDwnf8qVj1u0poykV7sZ7P60wqvO05F4DUQRilnTffmQHW0aJoweO8TECfjZRZk6X3q9+Hfrhb2SUe63D3GSWupOwxKHYa1TVzd/UwN+ye8aRv8cMrdxkEuLzl7dP4qhafOdaFD9+bQtBImY7dPWQCns2bq5Ji59QF6YMyjyoVmP1da941Rzia0xMx09zElJxQdPkiIfQFEXSgzY7sc09vZV7oMuxgmwEZV+9BkI1xH1GMV8RGF/ojEnyvWqFyaaqkCSaJDErIoG6g4QpQkLQxpWrw6Dh6DU+Wo3qX+Hi/4kW5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm7/vVFe2jClmonlTM6NNLq82LzA1wLnFxqpixscz1g=;
 b=hjb/xZHbu6qoxRuCIA3MQ5nR+EjoT/Wa89UnKg+wANw3hxKYl+/6k1NFQvtNrib95HKoqWJhomHvaRwSf5Fd0Qpy7pcskhShIvGXiZVgK2h88GLpk3+zM5Y5K2KT0eyPvglm7z2prxo8Bf03x6zmDaZEzq0MdI1Vc0xAtaFPUiiXqhrth6sSKR9l1JA18uSRRp99a0Y1jubV+THv7b64ZFUGwBY0GJpW6blmx6CUw4gWFFa7VKceoZAwkSMMmtui4lFeb8yDK/w2Tcrvi8SMn60uUYr/nck7SjccZE2SB5EyAxgVb2RssO1pMIqwndjCEptobNp39TmwgJQnHht/Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 12:35:35 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 12:35:35 +0000
Date: Mon, 29 Jul 2024 09:35:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd/device: Fix hwpt at err_unresv in
 iommufd_device_do_replace()
Message-ID: <20240729123534.GA3371438@nvidia.com>
References: <20240718050130.1956804-1-nicolinc@nvidia.com>
 <BN9PR11MB5276718A6C5A02FC53D7E9C38CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZqbV4KY+H+tdpIhs@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqbV4KY+H+tdpIhs@Asurada-Nvidia>
X-ClientProxiedBy: BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: f6236801-7ef4-45ae-42c3-08dcafcaf1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+QZG8JfxI1h1vqLPIKBB4HFXONYQUoCtTRjvcphTUTFdLXtrXm6MS0S04Ml?=
 =?us-ascii?Q?SGn0jxg3b3cENjTRlQ0/GA7VKvCoxasAQ76IWueJ4pN9U28A5jqc1l8jPzV8?=
 =?us-ascii?Q?4qtvDpU7RBlToU8WEUSWI2ZvhCMByzHwBWUOwind1SdYGgMnWm7zhk3iLJwY?=
 =?us-ascii?Q?1O6Jq4SdgOnJ+kY5RwYFa7gKLR/8EbvW7nsW/06PBiMoIVm6TJq8WN7xwed+?=
 =?us-ascii?Q?CMJZ3OTpshyFq19BoWMvA29QsupzJ1dbs0up76B7IFS+1cWapdLE6ZAU2ztJ?=
 =?us-ascii?Q?myeuRSEmQ16FxukszTJO1t7xdN2oHhgJiMep/bSMudiV7/Tmwta5n0wZfWCM?=
 =?us-ascii?Q?n7ZavGyqv8VG58AANqRXZRDe+PC+F8sSMcul+137lpaJfrfCMBG8fpI2UxCf?=
 =?us-ascii?Q?9e0SuJYMVUDLL6+YGuTgskaSpXynDx8A0ggD8//SDQSMO7Vj78rzPeA5Ir5F?=
 =?us-ascii?Q?aIB81uWg7jT93XDcKRJ0Gwu1ypZQj6gbkR5zTY8p1+fRMaSKkXdAieXQKHZa?=
 =?us-ascii?Q?jYoKdgSBPe9J6dynS67HDEu/9TgCfSnAWTHv96kdlIEohnnkSLdi0HxQ5sZU?=
 =?us-ascii?Q?4TQibGECTSA3Ln84BGeEvtp7zhpJeDgXSyUr/GFJUAdKPCDk7uQdthf6jEbv?=
 =?us-ascii?Q?id5xjt40PNVhjE5Ed0SFExjo0OxMeaCe6wf9GcSQJ6jRby/hE7GOmR6w/OMQ?=
 =?us-ascii?Q?brlf9e2ws/ykQnTvpxMDSm88HXbP757ct+YgcY3EXOvLOOmQqqKft8l6XMN3?=
 =?us-ascii?Q?5tYHpgO2tlwh/IBTTnn1zA6Cn1kVWYzJy2Cz++9wQEmCqRR2GsB0r2sLeYZb?=
 =?us-ascii?Q?DtPUKJKJGE9GFgsE47Rv5i0OwptskL3VASpuqOD3ukAcOQsaH1xtloT1H9BC?=
 =?us-ascii?Q?ZDItAWKjFvHb8SVa6ZDxcK+AtuY88vSPAIwoVanuqH0ZUr0qzknb9oBv002r?=
 =?us-ascii?Q?rKcaQnAPMc07neA2WlGFTrGnkoWicpZ4slGmxYS3Ii058O4IQo6aW8tGYoK2?=
 =?us-ascii?Q?LKCo31BdFi4uyChtm8erOLk+rGdQYsUpYxVJNA+E3xdohySePkOxeSOm8Fll?=
 =?us-ascii?Q?f/LgjrJ3pCvtORS80OVijfe68AZmwjOwiSmMhIj7IR5s86BvEjxV+DFrLNoB?=
 =?us-ascii?Q?tm0JAg7kk8QH3jzv3YHkbNFf3DmAPS/dV6Doz85HjSbXlrH1t78bHLpklS42?=
 =?us-ascii?Q?6XRd3DKurwXbtSQwt1dv5H7Zz6/PhQx9mHyAQN4+K1mdMna0PWem4FDCPjY4?=
 =?us-ascii?Q?lRKS9SO49WAz8KNl1ovYOjLo0nD+aXZl4HsQz8srtT+ixmxBlpnG6f1pHV1f?=
 =?us-ascii?Q?P305Fq9Hny00s3yql6tRcEb7mY/R+C2PTYQHygYTbsGsIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tHSmbzAgj+vzt+kJzVlwPL+O/y2hpYexypCazmU+oDdmfQX0qjeuUs+g+rpW?=
 =?us-ascii?Q?Z4IEnoO0eN8X5nLf7gw2Cb+F2SHMbZZsV8xtWguCoR0ZsLGjBALskj8X+nE9?=
 =?us-ascii?Q?loflrFxksElJr+9v8COih9HrOytoyueHHjZSp9zCdZNnA/gafgCn9bYhC1d0?=
 =?us-ascii?Q?e4GGebMtHaeuhysnWfSRkErMnkFQieSza+qbZsm0qTug/zAAi8EWorW4hpfb?=
 =?us-ascii?Q?1sn6/LbCYzMaHyp+NTDi9gbQQz8mQnpKZ/hCgYdJVwPol5FYG3vjIDv+tuRA?=
 =?us-ascii?Q?f3fmjL76/TWpm34yr7A5TPCiknb5GmzfOHY4BpUnFeLgOxcYODVM61ePFVX8?=
 =?us-ascii?Q?6fcDW6mImtdqrsBUsNwIIggjH+u4RdTCJVAfhScl+RAL3B9hwbqetttK3AEJ?=
 =?us-ascii?Q?b6/OfjiHXmwWSE21QiduydAj2h4kyYrgsUMi7Niq/+5Kl0lwoZGbmv4GKJDB?=
 =?us-ascii?Q?MQ3dpqPMkeDHtwtZoSiaZ3D8Klnrv12nOLwjAJYirEB9sqbNa3gPT/XJPNBc?=
 =?us-ascii?Q?1+7X9bIwuYdZw4so+Z46pcyb57KZfUTEGpTI3rSii6Zwbcsohp0+MU65VQK9?=
 =?us-ascii?Q?l3HujinZXucCujmtd6IhA9cP3vwzYybjC7T6+e1nuE5TX3slNRfWoTcz/ikl?=
 =?us-ascii?Q?HHuucOeMnuwgrGtA5Qi3TqqB9+17MBDvmVCWlRhdzXlyMAgjwDSZBteWM3PR?=
 =?us-ascii?Q?+Q5LS86IHZioCKCIoZdkG8EvR0FVFMs1AqE9bUN1YJGlor6MS4J5R+wl2zpk?=
 =?us-ascii?Q?gr0rcR5bXWFGxXOF6IG5BlAd0UZ5IvkL8QewK+Y/gTrJLI9EsISYQmbsvrmN?=
 =?us-ascii?Q?H91bVntaAMOHd0CF4FoLd8XH2QN5J6I6gyvHaemFW/ZKjhz/RKYoP806hr6D?=
 =?us-ascii?Q?6qj2XxUfxW4XHKJ0ZiAUuhR8aefP5VTdlBdD6H6RtsCZQq/KNCYIadBmWojS?=
 =?us-ascii?Q?LmzhLdRIQHFLnpy5R2I7Ex8eOWzfu5unJZ7hkQBltGgCXViu1NFxg/VeozOE?=
 =?us-ascii?Q?JcHufFpsEeiflpMmtq7F73CuOt5dtktM6JwcZGPtOYy+zGxq2gNprJTD1VNO?=
 =?us-ascii?Q?+8l6QL4YrTxttLcmkIfJjVfL+IaSmpoXM7WdlkcnpkUSpLFCxZr3kKjzFNaI?=
 =?us-ascii?Q?U2iH1dXnMGHhcvWw+oAsC3GsUzQtFrz3SjDXY1o9ZfJOndl98/qEJm0D519Y?=
 =?us-ascii?Q?vDEBSCsHQTHa0ShLhv518Wb6QWsU0HPnPqX57/p7Jzc37gpuI1/UVriD9YE4?=
 =?us-ascii?Q?WXxfw54dUHsq+Tc/YdQr7pRz/2/xKc8MIFzBZANINKEaFctrcw23oZwynaFR?=
 =?us-ascii?Q?kCC9wxoOQWNyH/KNbABejOf6wCxXBfYQGErfn18zq8rrXb6uycrD6D8qV2mE?=
 =?us-ascii?Q?M8J20GQus3Vg2sjCc3wuNXaXUI3vEUbdyl75hxHlWATyj9ByWB9g0XKYXcWK?=
 =?us-ascii?Q?vYNxnwHPjA6BtiVo0er/bm4Ih0DCKTV+NB5IzacRTWmLHssnsYGsyBDntSbR?=
 =?us-ascii?Q?IWrakABX4y5pc5mDDneCX/TtaKIvSp/Wa3ZeqJA1PsJv2nU3DoNogzV214zh?=
 =?us-ascii?Q?d1jpOr1eTOpfcoLBTP0qjS9qFcSn1IGZyhNWwlmy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6236801-7ef4-45ae-42c3-08dcafcaf1ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:35:35.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS9ytb/cle+k557Slx+JK5VHbKKOGbS3FgHweBNp713tCtTANTzJSEGqYr7WnIuI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

On Sun, Jul 28, 2024 at 04:36:00PM -0700, Nicolin Chen wrote:
> On Thu, Jul 18, 2024 at 05:13:38AM +0000, Tian, Kevin wrote:
>  
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Thursday, July 18, 2024 1:02 PM
> > >
> > > The rewind routine should remove the reserved iovas added to the new
> > > hwpt.
> > >
> > > Fixes: 89db31635c87 ("iommufd: Derive iommufd_hwpt_paging from
> > > iommufd_hw_pagetable")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> Jason, it seems that we haven't merged this patch, right?
> 
> It still applies against v6.11-rc1. So no need of respin.

Yes, I will pick it for the rc1 cycle

Jason
