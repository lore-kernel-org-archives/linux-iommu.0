Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95313B5B0
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468495; cv=fail; b=K4p3snR5rq/EAfbnry8jhcNunYyxnm0uGKnoBadz1YEGLvJdAhSKpV6xlgpH55U7XBrLlEZxE0cEgOgUZXwreIHFKExfVWmNujcfRsEMmuAhCdOOETMBl3wijjElCsGqtYgX1DSPQByvABXuve2hxhMYsOGOKFAwo++I6cdJsKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468495; c=relaxed/simple;
	bh=XmHbtNq9i/3yc9HgvjQc2umk3Kynl5+nP2Mkx9X4DTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u6LWFK5mSoiVsKz+dVZ4AO4PrSY4hLhKH/zrbUDhBsuVdSx4aSLV34EW6RzowG+Gh5zureU9hHdqWkPsznTcpY+EhPydE/P0HXjihwgvN6qq44iUmHKYfDNx5ycI20l+oLChRXeufU4OVgGG6fc0RAqPekI4BMBRW2Vf4B75wLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=guR7t+aw; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="guR7t+aw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwaxdFst3L72Tyydbczdzl3QiQ9O/3Gbi9f7Vzfoc7vNgrV9eaV3RSQ1kS/FEXuvKgqd2uHQmTJR1bgsh/HLoEG7SzQh+B23AhmzU94atnh/vJ5+2gv5/LvLTrnLH749WS732cLaY33TrG5i1rW78Ewzfdt8ZAk7hats5hk+3Sj4IShWz3bZS8D3VHdhwsh4yF3rTgQ3fNQrVKde1oREdpSJT9G5UwJJhV+LtHM04ct4C+2HPiXKol/vLHOn4lYGvVDuaEn6nnEgJrmZDpGeE7bwfuvoHNuoIDY+54fJvONYWMurqwesj88m3T3etPc7OtmRTst/jwosSk6yYaD5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MksDHYz0B/CAQ0GIzrV74cRj56QW0Oy+DoalaBhO1Ok=;
 b=MfSGpWX+e0jOPgeEKJIcvePEX5k5wQT2UsE3bOyqODpzsIY1wJWqrLtYTMk823o8OE+KFw7hFXbdiq6mFBgdDPTQ3tylUvO/VXaUMOMQ92xwpp+r0jR/cYuac0hSZrS7tCOo3GqKQNW5FgzUUzFabmhWVOhYrfT+pvV9vSNQAcepk5UDwHwwu/vaWiTxAJ+De4GDFNzb4NIBBF3yX5nD8fuz67OvTNcOsadEEoNr/qja2TO2JGaxcGIKmSeV/kZi/lktJsAqZL/slZMihpk9SL1rIZa4J+UxYLzR4itNoxpqaKX1r2n3SPf4w6ZdOcmr+h9hSApJ7y6krKGPwy68EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MksDHYz0B/CAQ0GIzrV74cRj56QW0Oy+DoalaBhO1Ok=;
 b=guR7t+aw7M7YkmpOVFi+okJDBko5Dxbw8elhN3x6LCC9ShyjnlS7He6QOHgvBgQJ+XuGXmgB6ZoGRrA3zD+dNRt75tTHmdIf9mI1zymbUg2V7PTWtCE1uc7c3SFsIFa0p/D6v7n5uM0Rc23EAc3AX7FQxdIrldXt9oAtjp7j+2jcnsYX/8s3phgY+xNp9mUmNgC6wACX7z1wTxOeygB8k7ZegxdrDSXN1Ds7HPftleMlzsMHrzhqQ07f3G+fRCQ7p9+Ctt1fs+Bo0PKy2XovQ9fphaIWaiElMXExLyaW7WsZ0ziIQ7H6QADOgumTfjyTiDNwtMKbAkoBSUq53sCPag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 12:48:09 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 12:48:08 +0000
Date: Thu, 23 May 2024 09:48:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
Message-ID: <20240523124806.GK20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB527641C15DD88FB0C44323D08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522164818.GB20229@nvidia.com>
 <Zk5Lx7IqvnE2q7a7@nvidia.com>
 <20240522232833.GH20229@nvidia.com>
 <BN9PR11MB527613C6094EDE9B2732928F8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Zk6zWLcPCc+nWICX@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk6zWLcPCc+nWICX@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 7871fbe5-3267-48ab-5fa5-08dc7b269904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dc2O9D9knK6MpV+GgcegqPkcm/KE1TIZnCnlXLr6w8MzHqgILMbmVVv+wmoJ?=
 =?us-ascii?Q?MVAD9oQPctwzrPpA4Grt+lHocMANtqmf2ntxEdEDY+gXk+4UD976yIdueBcy?=
 =?us-ascii?Q?ttoaDJuClUJJXh7Yw4sL4Sv/dXFvDJ/wogczrSAGfBkLXN9ISnAfnj1Uh8Df?=
 =?us-ascii?Q?ZLTXTKLur+U0+P7dwRlTPE4vs0BgcQDhkMnJCUEpbxDWPDIFAKo22yLtoHZ9?=
 =?us-ascii?Q?YgTAistijpdSufYONps+WX+1Sd0l82fICUg6DnSjXbGkoucEg78bwf8f8cTy?=
 =?us-ascii?Q?PjzcQDE4DhBnE1DcM6Kev17jTqDdY1xshqoUzZNPywhUNArbrNP+Ta0DQFE5?=
 =?us-ascii?Q?6wK4ATOSaX+g2WTFz2Tj1TxpocETtStlfl3KrXaNYy4oewv05faeeJxKqH4U?=
 =?us-ascii?Q?DOw0NuJ5zMA1BxaFZzODIzx3dX5ZOskfzypsZaXCrZV/AGEDMdn2cu/jdjrv?=
 =?us-ascii?Q?IfWjjylAqFnmowbg5V2ljQe1/k7pkpz8n0XsTrc7NIFcjqdk/NvkIkk/3Ie7?=
 =?us-ascii?Q?jaq0vGv+HhLumwURK5OYP20Bl/AI9iHe/31z3Iho7CzBPfxhyB1KDZkLzX7c?=
 =?us-ascii?Q?bAkeEJuy43ViFrLTa8i++t2YEB5PvsR6wM/nfL51Uzxmaoqb+CHjWFjtDnjG?=
 =?us-ascii?Q?S9cZHAwz05pfnJg6DL8D5rimlQjzl+k3oU6stmFSE3R7aQriGRJVKcv8wiqn?=
 =?us-ascii?Q?Nhl8VAPmnOQqNrKlixq/WFgCK/zPE5IdTanuqfKMWSPpGDPMOGQwTY0NhF0L?=
 =?us-ascii?Q?2yWykXvemcHWrxMDSbGeU6cGZKEJvUounEWOliPyamV3pGlW6hy8x6QNx3FD?=
 =?us-ascii?Q?dWBKMH9KMPMGMsVwgI5MWF8/kjBvwEcIYdWz4PGjILugPr4+xcg3oLFyVump?=
 =?us-ascii?Q?RKJLitVJ3B6B535xl1M8mFlq74hBDmtvch6avaPmpg7D7YDqBfH+qoa9oa+R?=
 =?us-ascii?Q?84ihMopfmwfujHJnHAsPKxvCe7P9eeIwyCwDt/08SvLPmMza1pI0Msbm7r5C?=
 =?us-ascii?Q?gNPM1lbZW+i5ackBnjs6/0ruYf1VFKee8E4FoY+EXtbyi0NqunBBqMbP2q/4?=
 =?us-ascii?Q?knWqjBq5JEm+ggdbtbCB0rsxUW8Y94RaKndUVEywDIb6v7cbIMJv8DvvHELA?=
 =?us-ascii?Q?Gqhq5Hnmq7sLfWxUyaQsZJG76rabnhn0UIMXkJxRwtcF7nCSlAn13/cOsv9D?=
 =?us-ascii?Q?wP0xWge03gZLilnvYppC8ssyeMDM1Wjm6cdeWrV7rGn4YvEpkIN9bZXd2Lvp?=
 =?us-ascii?Q?kE2oNJL++r5RdhszcZFz/IXeyBqQrQJE8mdZ56851Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?48jKtD8xmrPe5+ls9+MXRi7UlkGOZG1zwHAxVOd/NdWQsiWF8m0D7NSJc+MH?=
 =?us-ascii?Q?fvfVGNUOpR9EO6+Slh3hF02FvScRXCHvFZGClvOtmKIo/HjeIK4TMcCZmnVt?=
 =?us-ascii?Q?9HEoBEnDJ+c7ZyIm5mvzZtGbOy/4WFQg9bMQ/Zr2sM4Mu6GBDmoSbLU2EdlO?=
 =?us-ascii?Q?JEzVxJWfz66U3ktHy9Sql42DTIFZLyN30nqfzQ4kRcBt9v/JMGZ+1eK1pU4x?=
 =?us-ascii?Q?U8XRzm6n3YMx7csLg6aw6VmOd/ZtaedR/Oxq5r5T6aAkPdT3N0eoAK79qA8T?=
 =?us-ascii?Q?BUFHnvgedFGksbANDXF0Lj70tItB/0V2iGsugDtDsUXUK0zq9LvyJUEaQoRF?=
 =?us-ascii?Q?pgzwZ1hdehqZqOiLoV1pKE2jeKP9rOJiv6kkeXSa/j9SPAT02Vg3KW/+3/9P?=
 =?us-ascii?Q?qBGqg1raCWu1u7qC9Wzo1RISwvaR3XwwlJrO7xqV2dtvaM/CSGlQ7uEFf7mg?=
 =?us-ascii?Q?t5kQ0dOnDu4Gr/1UP3RR2g74z77F6R+AlNKYmh4KDEcSSULBSEpGf5lWWkHS?=
 =?us-ascii?Q?GzkRyXdQIB04hMDfKU+WuBKdg+qqv0GJSgLTi5lJEY0oZozNPb/TfDzDZePf?=
 =?us-ascii?Q?QU6TQO5rgHQuL3caQdAdN4Osz7yCPnThgf4sueSrEKtdV/O079vtyFdax/IX?=
 =?us-ascii?Q?9vMcEYGYXkOAo2kmHqTr7+DVhPZNzs41OE/ByXCTrzg6wZqw+QDdVwvHwGic?=
 =?us-ascii?Q?4ZQ0GoY7Ym85bhgFkuZyc41udQ/e1Yn9/Jae5dGWTn3+ragAboDnFYAxwJ43?=
 =?us-ascii?Q?ajdKnOO/uYpqYQF0KXY/+BRDSnfp6NBjYQGYcBhOzQ9TSiv+8kRI7GGcCh3i?=
 =?us-ascii?Q?ZmoXRTLWHK2Qz9qlw0hxBKbjeyrhDP2H2H6vT033FOJUJn3UrGtEXBQA/8O4?=
 =?us-ascii?Q?lga/HS8KIoMT8lFm32HKaDH90YuakIDmXdIomso9nQ2JI/vRLs/4QLlFR+9r?=
 =?us-ascii?Q?pViwQg5ZzEHE0rmEHkzVOL67raYXk5As3WhlkH/AEaaVGnnhtk91GUTPSu/f?=
 =?us-ascii?Q?5L2ces7OfLFW6eVwYG/frpdVUCyb0OKRhQRtms9Q5Udf/3Rl5+x7RNQV2T7V?=
 =?us-ascii?Q?mmDmr56n5NifFgiL86ySHvGtCXP37XjeiHZFdm1ki02OAi6zLIhQV+1zP7po?=
 =?us-ascii?Q?xf2HMIFYK/XcFnvc6x146V7uChxVfbvghGmZZJnFDZhpS9heoEYI5v9ko1T8?=
 =?us-ascii?Q?4ek0YHvPZkX490o8okqtfhiWAkUSGN0/02SyKOoxGyMD0egw6P/5EvjjSTMG?=
 =?us-ascii?Q?+S2GetJnaxsRUrYos1mq8f9adddi+3bLSt4AHFJCgoNg4mWOAAHgdWM1c9Dk?=
 =?us-ascii?Q?RlTGdZpJIQfm2Qgxi4oSLkwHNDdEnLeyFnyx74CYi/GVMqZ8mHc2XZVnrauY?=
 =?us-ascii?Q?nTPRRyTz1VyVHFGZBfSigPUir4NjpqSApslY0Y9FzcmMudfba0sWjIt4R0q2?=
 =?us-ascii?Q?TESlZFb4jd/O2t9uwascwbipEZRNQKAiLCs8Py3pl7kDNj0adFGyCftsn21F?=
 =?us-ascii?Q?MXNdYJomyDXin+3Bud+C+BOE9GpbXVJUIAvLHboRq3sp+kgUEgyn2pZ4bHMh?=
 =?us-ascii?Q?ESdS9zVZ80APnMoh7Vzu7YoMFZwPeWeB+cffkw27?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7871fbe5-3267-48ab-5fa5-08dc7b269904
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 12:48:08.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xK4AE6fdAJEbEJXFjgbBmwtzHIo1X7qO/SsCG9V0jfIJfP9idBuhvWPQhnrUUY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910

On Wed, May 22, 2024 at 08:09:12PM -0700, Nicolin Chen wrote:
> On Wed, May 22, 2024 at 11:43:51PM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, May 23, 2024 7:29 AM
> > > On Wed, May 22, 2024 at 12:47:19PM -0700, Nicolin Chen wrote:
> > > > Yea, SMMU also has Event Queue and PRI queue. Though I haven't
> > > > got time to sit down to look at Baolu's work closely, the uAPI
> > > > seems to be a unified one for all IOMMUs. And though I have no
> > > > intention to be against that design, yet maybe there could be
> > > > an alternative in a somewhat HW specific language as we do for
> > > > invalidation? Or not worth it?
> > >
> > > I was thinking not worth it, I expect a gain here is to do as AMD has
> > > done and make the HW dma the queues directly to guest memory.
> > >
> > > IMHO the primary issue with the queues is DOS, as having any shared
> > > queue across VMs is dangerous in that way. Allowing each VIOMMU to
> > > have its own private queue and own flow control helps with that.
> > >
> > 
> > and also shorter delivering path with less data copy?
> 
> Should I interpret that as a yes for fault report via VQUEUE?
> 
> We only have AMD that can HW dma the events to the guest queue
> memory. Others all need a backward translation of (at least) a
> physical dev ID to a virtual dev ID. This is now doable in the
> kernel by the ongoing vdev_id design by the way. So kernel then
> can write the guest memory directly to report events?

I don't think we should get into kernel doing direct access at this
point, lets focus on basic functionality before we get to
microoptimizations like that.

So long as the API could support doing something like that it could be
done after benchmarking/etc.

Jason
