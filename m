Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AC1386C9
	for <iommu@lists.linux.dev>; Sat, 18 Jul 2026 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784416164; cv=fail; b=lGLgwYKNveXuz1DzO+pDE1G1liXSvg5ImnhSbOg5QpHskiowGF1JnK2SPhkCAaKR10Fmam453UP4ri8LOf+yGh3wICqN0zZN6y3ttgiFuFtJfZHnmZ0I2KkO0HYMYIMdPc8XkmtRZutlXX3CyaGjTKIMrrEFE1ZV8BpML1M+Zg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784416164; c=relaxed/simple;
	bh=d5Lt6FQC9V+CTVAD2OpWg1lsyV34ibRvDNip1UDZ+/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KvCRzIbTK/vALqZHpnvwuRRxVNA0lEC94EH6WLABW1yAwxfM1cM1aBXWSLrxtPpFq743h0/VWBvswwfff3/Z42fmymOWzkqjYFINqfJDIGZDshy/C/orR5OAc4NuXSAIyvI7ZMMhH3cLzOsl3qCAZJlr+PcA0hTAVJPbcotrbFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlSOHup6; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlSOHup6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlnY2aqPAVy0WpH1pRSRg8A/xty/v5/whkUO3uEMfnnlCiaOjha7sxpZKzBt3wTEa+vGd/10AItm52hMCircFOiqq1aYigKI3GEkK74WUfNtO/8A21D2FrmZTn6leF4ALqLzptFAB3XtCNuPfKWyR6aFImqOVaTVj2CH5Osg0QY3s/jjgTKTKIptO+d2TgkcZDFHa/DccVhMGF26flLctmUlRBF9HfAbKxsjuNXP03CS2YfX5Lto3ZjYXWA8LXkzkkVWA/PBZ90JbnS4gh1KA0uyDKqeRG6d5xlpq7mp5D7yNKrsWQjxbUQk3/ZxxxXfy/tjrpiq5FzPS1Z+Ld92RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKZHedMqldFVoEfBZUSAvISzFyM19J1uAbzoZaztQ9Y=;
 b=V6y6qUo43As+bRbZZrLD+lGq8jZLOXCOB5A3lLiNbQOst6v1cZnJUJQwM5JroZEivqVk31iePq+SxZLkotBKL0+3/9jjQvEBdYB6wVYk7AcDq84B0gAi4KJzqhYLFbjjAhB6NasvpBSHx6q/xgHSzBzHem/aRLd6lU2jzyksAdju59y5Ir0di1RN+kBzPCWSbBchrG7PNO+v/Km+DfXyPSYqlRx1vSiiL852Yw2x5HTdlG2IrOUA+QJFAVwCPzjlju+7wIvwcyrFHAHNravRwRBVB9Zcf2Kaf6HtgZMqCeDN0NaWjMcX8U0ijd4hZUgUhrGWjduloh24mCzbp0n75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKZHedMqldFVoEfBZUSAvISzFyM19J1uAbzoZaztQ9Y=;
 b=NlSOHup6hjV63hY/AApbyu/q7ixIXMjM+SEVBF1DhIfxj5/p4WUbO5kBzfTaHFAg8MWcDnnMwC2z2B+QXWhch9bOQ7IbrWWXWZGjLIKNWVRVyoEOO7uNMMCJFLVBfe74jPvq+8Q9EHQa84V+le9F2QjS7EE1i16/bii6pFpl8XtrYLqX/pYXHrzSadMXDaJCz3YLn4JG199bK7hsC9x48uvNxB6UpxtbuuoOYwVuDtpINAfU21KoykVs9xHFpF5RmeN4J29Fx1vUftNdRE36f0dvJ4oGgXB4qAyUE2B/X4/DMYvWo+r6ZzJY1oxK3vu+xvoQX0Cwh+kaLBMJMEHTUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 23:09:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Sat, 18 Jul 2026
 23:09:18 +0000
Date: Sat, 18 Jul 2026 20:09:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add support for contiguous hint bit
Message-ID: <20260718230917.GG699082@nvidia.com>
References: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com>
 <20260703161228.GA1948451@nvidia.com>
 <b7224dff-7e51-49cb-8421-14d090492dfc@oss.qualcomm.com>
 <20260715113913.GA3775915@nvidia.com>
 <ald3CuddY6I7gml1@willie-the-truck>
 <20260715122830.GB3775915@nvidia.com>
 <alvd9zPeXQVQ7l2l@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alvd9zPeXQVQ7l2l@google.com>
X-ClientProxiedBy: YT4PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 525c140f-6d7e-4289-f0ae-08dee5219835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|10067099003|5023799004|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	kQvHhF+OxPxOITqviSHWBqkkKjz+v8K8NW5uIZuLX8fK2k3NPITkORqyScs+uxzFzq5cvu9MAQllmTfN2nXEg8f7SoNxRxcesHABd4LB8V0aaVvjnMeB1eVYTv9naS7Ju+gbUpKmvA2vJpTPm6+TZ8WeGHfHSqa4jh9rupQ5qU7YGSrZMxsK3A6rxU6BhavcWcE6yNDDt+QF/FGw3k3g9k6DfLL22jb7m6eu9NywHnXVg7j914k/iGH/gkxfKfKhSADr/HWsGVA8DUxFOTR3+rfFmRfbpYx4I0z1mJVtgQN5eXYu3jwtZWC89KHQ6vWmRWX7RN7w23fUnH161dcAHavUirYBuQL7e2Evv091G2bhtkn1Q45cLetHSCVeXqlX8kl2K4ReC1di2rwnVoVvJwxWS0uxJVkwBKe6Xag7E2yi6u1GAswhdIypbi+3+pqJro5Rto8PsQeFn15O7vlpQhTTHmnxyz/1bn07jw0QMQjYFbP1GG3mmJW4DRwZaeYzjIlFJvS3wEA7j4NVVDDRvDjxmBENZzmy1cxQ4F1I/8OWCdVMOKi8xATvtwcYI1cEYHRNh7oV0KcmD/PP+E815FbJkacAMtgtLvOnycmStEwwudXAAhSvqU8dIZf5xXbud71Ag53ICzbLFuWPDkYBbdedGT9znfqrpSzx8FEXjos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(5023799004)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z0Kztu/WN62se3++zyEJ+HMepWA4oiBduypVeW2ffDFy6Mmno0H5ItwT3dn4?=
 =?us-ascii?Q?PMQzBzFjJacK/soI/k9R6DVHoaXctXMhydmjTbesQUZBqHOu12Gh/4p2Du6J?=
 =?us-ascii?Q?nA0muuaQ8VSRB03mkYboaCxCKIH7JxM9V3cYMcUSyk2DiBQ+j1CFwcAdTU7c?=
 =?us-ascii?Q?bBZ98ocHm3585b6zjXNhcvWy8/UFfP/amwwv1wjZKkFY6UjM5RT3W+6PXajf?=
 =?us-ascii?Q?fj3kuVnJgM8pKtXM5o6Dw8iDvCFwM+jhDigdx0crRXgiQrq2Qyhd+Aoq3oL0?=
 =?us-ascii?Q?I514YEa1bayxGl9N+nK6++L6TPu/8sZwmdHmy8Zjg2iQU7jQPuys9aiHpKgx?=
 =?us-ascii?Q?928Z3X3u7JA4Ua8/9Xy9W4OWPd9UYh+Pzdp6TjK6tzZK9u5rxE3aKhdYKI88?=
 =?us-ascii?Q?Q9z/8ix/HVOjPIXNG/xA4Gl3YY0IxuTj7fKkYO7IU8CexVg+YZlMbTGfJzHR?=
 =?us-ascii?Q?sHpo+k9/mbOcILIBnEprzC6jhK2rLvXChjvYROjgwiWZjz73fJ/uiYTOhAHW?=
 =?us-ascii?Q?Dgpr4dNBLjKZL2xu2QNhaOrnS/nfPmwBr7ls1hTnUylW54p7mDvw6BlZfQtP?=
 =?us-ascii?Q?SqmjwGfC+kWaDSt2sqyO5TWi2CaUjMiz3lmPTBgjQVIkcHDILmlfwgz8tPA4?=
 =?us-ascii?Q?5d0W3poms/Y92JIwSpI59KPHSlZCQWpuj+knyeAp3SY8qwyj94cJJ8A7p/Qe?=
 =?us-ascii?Q?HLjeVbgb+2SXOOXfUsrdguu6QfvU5QeulKDlysDZCsuX02dGO88FIkPSmyXU?=
 =?us-ascii?Q?CEfNAJrnD7XZLzUkLOm50Mrtecd5XCC2gCsQPENfREJENu26SLbpp0TG2B4+?=
 =?us-ascii?Q?BmdRLDoanBlkTqsxSWk42sNbwWMVKDKTIf+Oj0leL+TxlK6RUg9DhWw3gXZB?=
 =?us-ascii?Q?nNU4is7GBvbcWEGRfdgj7Lm+IrW2XHssYGyZIDTjF6LRNS5eoG1zJrYVlAuJ?=
 =?us-ascii?Q?t/Mv2fJiiSt08JV473R2RigtHuGCF3GRFH4GudHD/txUsQXbgZfBoLMZg4KM?=
 =?us-ascii?Q?8hA2W2OKxHV/xcaf7n9ZU547EfOsFnyH+c3HUeT7Gg/V/w3tfy81nQJsn2xP?=
 =?us-ascii?Q?2aA2WxTNSRPwNli/l0eQqtR8TkFb0bs/mtiJq7hhMox+Dx+qS+44lhfCHEaj?=
 =?us-ascii?Q?p8gKNw39h23L2nN9lHalHrq1MQpRI5n/hyab/TPY7fUsxHkgzVxF8alCqmHa?=
 =?us-ascii?Q?Y7yWzZ8gWjD/t30UqOOskyNoYZ3IFDWUZvpSETQ/x3ZZvX1DMznbmDVOJq6a?=
 =?us-ascii?Q?UFa22T0kig3ODtjeN1D6m2CK6BeYCOauhmHNeabisCxPbMAdadBvwIVCghF3?=
 =?us-ascii?Q?xZEUHiVkZTQ8NmxaOEa5RP/ICWFXNzYO5rmHxsJkLDzi7FT2IyU+z6lh3a2u?=
 =?us-ascii?Q?TemgMjpcBTN8QECv5dCIYk691sTHw4qkQGZf9oxYsb7mZkO5tJR72l/Exhd4?=
 =?us-ascii?Q?fHazTNeuNHMLViXMjDW6HM5LCFowCT0fnT65bO9jLe1U5hkgBZXQ7dT3xacB?=
 =?us-ascii?Q?+xSunu0puu0fGPywIybffL1gaFg+J5Y7DzBFMegvFvUP0j0yx4NMQAH7OoFp?=
 =?us-ascii?Q?or0uCirikmIIDDqH9mggXZhnuBJbvq2Kl8qMvgL2vdmiG1048NOhasSbFJHf?=
 =?us-ascii?Q?0YGtM5M+PfCUUtTKLyTajDhg96sOsZyX5op6KqZQbZ3XDCWc/CGYiCApzdoG?=
 =?us-ascii?Q?JCuNu8x0jeMxuaLRjcRTTTSUGw2fC8oVt9m5F1eM6SE2h6St?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525c140f-6d7e-4289-f0ae-08dee5219835
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 23:09:18.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpuGd5dMzJPeh5fl3WsMRTZvud/NI0ORieExSXrsOm+QTVjfOR2/LsykHduR/k7q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

On Sat, Jul 18, 2026 at 08:11:35PM +0000, Mostafa Saleh wrote:
> On Wed, Jul 15, 2026 at 09:28:30AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 15, 2026 at 01:03:22PM +0100, Will Deacon wrote:
> > 
> > > From what I can tell, the fiddly parts for iommupt will be:
> > > 
> > >   1. Hardware bugs / quirks. Some of the simpler ones could probably be
> > >      handled but for the more invasive stuff like the Mali format
> > >      format, io-pgtable will probably need to hang around. Perhaps
> > >      it becomes io-pgtable-mali.c?
> > 
> > I briefly looked at Mali a while back and it didn't seem so bad, but
> > that was for a GPU driver not the iommu so a bit different
> > issue. Exactly what the GPU drivers should be doing is less clear to
> > me, they don't really fit well with the iommu focused interface (eg
> > the memory preload issues/etc).
> > 
> > >   2. The pKVM work from Mostafa. We'll probably end up with something
> > >      separate at EL2 for this (ideally, just reusing the CPU page-table
> > >      code when it learns about BBML3).
> > 
> > Yeah, I'm not sure here, it isn't great that is adding another user
> > and open coding some of the logic (eg smmu_pgsize_idmap). It would be
> > much better if it could just use all the existing flow more directly
> > somehow.
> 
> I was under the impression that io-pgtable-arm will remain the same,
> but if it is going to be removed (or at least the LPAE format) I need
> to figure out an alternative for pKVM:

I wasn't going to suggest you change anything with your series at this
point, just opining it is "not great", but I wouldn't object to
merging it as you've constructed it right now.

> - Compile iommupt for the hypervisor (similar to what we do with
>   io-pgtable-arm in the SMMUv3 pKVM series which compiles in both)
>   I am not sure how easy is that for iommupt, I have the SMMUv3
>   iommupt series on my review list, I will check that.

It is probably similarish, I thought your new version was pretty clean
when I glanced at it.

> - Write a small IO page table implementation just for the hypervisor,
>   that's not ideal as it would benefit also from features as CONTPTE.
 
You can do this pretty easially with the generic_pt and you can write
the thing exactly as you need. I wouldn't do this unless there was a
big mismatch with what iommu_domain provides.

Jason
