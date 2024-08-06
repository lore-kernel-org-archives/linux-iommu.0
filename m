Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356B1C463F
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948970; cv=fail; b=SUnYWGMY08MH7glOGLVtan4+sebwOx6WQDCD8Qd3eG39dzCkURYUDwlrYfliV1M8QwbPkDo+7PR/zMc2jr+BlPaP038VoikICNmUuISdAfoDevifbjmP6uOmWjivjmPuKmmBhIdpXE2Xwb2AXOr3WrOtoK8Dv9CYxSEto2GT27g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948970; c=relaxed/simple;
	bh=hEvU0iaipgaeCffgnC7rIILs0bLEJDdlPnEjS5cBqZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtWVx1Mk/mTqCDoka4y65h27MtctIpGFEHQ8EXxVKEx9DKrbWRwxTVxyxFMwIgpG21EZ0cXDMkY7esUdojVFt4AjYrVrKe54rFvmRrkY6kW6J0uxnZELyRU43xDlKCPnUGcBUWQtg/mHssp/gM3NT5/G4v1ql9xf6n1u3UPbRVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UMtYq8i2; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UMtYq8i2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGrjqlB7L7WiG+zvkgfAsDvSOVW7X/dJhl8VJOhFLEvFGAkrJaFm4cDUFwSEJaZx8yMxpKkmdLM3bsXE2YRsVktMVwjKOyVuhyKngk/Bmil+45UwMYOts0g4/dUthxPOAUuvUNp1Wpt9DCba2DDBR5tYp477SVjTujJ8AgpLzUcHVMThiDX2W9oJ6p5aOM2wjK/EY9St5OHOIMOsyij1bQs8akctnk6GUyXPhAlS/+2+J9KOHj5eDWE0hFsGF849UE0xOpVTgf5AJ46rBUq5Hh2DoJnTQg2pgGVnb96w2M7Z/lxzs7pO3JNP5tEMkgkq460++ERpGg5peAWGLSqB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK3ZQphdmYUvjf8mirPEx/510p5drmZtq8JX/OWwPLc=;
 b=bZ9gaR0WXQ1CL5iVXxLsM1+7jMjltaD0OOKgA5CFIeuj0VM1QvHCMM252qLs58ta/FBETri+jJyK1QKKQVo2JufgVKBensmX21Sxptgoq9WXWmji1D0p10gNRUnCi/QRBFQSK2SARuDiD0yNmXIIgXSQ57EDlMSdlHeRUcpUTzenNXmG6L/RqOFZyoDAOim5eQPblOq/UCzRkAvNh7D4S00ESwAOIwaAUB4RGNqiCO5QaqojvBF8olxW6fuSIGZdK0Hhyi2pFv0ZZraM4oYmgeNHEjfuHeJ5R4pcvDxMtwn6UR6/a8RaRE0zbMLyQIqklXw/7n4yX6SgTRBTZiw3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK3ZQphdmYUvjf8mirPEx/510p5drmZtq8JX/OWwPLc=;
 b=UMtYq8i2PUVeXC3qWD26gB8/4LIYaTISP6ABm7n06A8kiHEH9YLm2/6WOLhtcsYswg/g5R2ZKJDvpnWL9H2IoLQwpSZv/525/2i1m3qShc+CcVoHrP8ufwawheIbwhD5U180zwhgqXH5WfH8hb+S2xzd1sCy2z3mwTpFc6xyBZZuAY+GTB2/Tlwew423DsdGni4GR+mRDXp5iEvvwSlwpOcynNgKd6qyvdaSJDRyYL800ncLzJ1PVXTwnQ2t8i69rPCXNxNojewoUN6zRVGr+lLkfjybnTqhzFnmFqZPoTMLycatzUIRR3b15mUYgA68zePE9khI/Eu+mz3OsqxL4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 12:56:03 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 12:56:03 +0000
Date: Tue, 6 Aug 2024 09:56:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 0/4] iommufd live update
Message-ID: <20240806125602.GJ478300@nvidia.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <20240722155500.GI3371438@nvidia.com>
 <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
X-ClientProxiedBy: BL0PR02CA0122.namprd02.prod.outlook.com
 (2603:10b6:208:35::27) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfed336-4c3e-4ffa-d671-08dcb617211b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yzNFKxCNULKmk+Hkx/hwhhT0L8K19jiBLTkUUxtqkOpE6JopfhJBOjK0AqgJ?=
 =?us-ascii?Q?cqhe+P0OHoDZUIrveGRQCJWod/AIsXgxAJtofAtMgJj32QkW9JYe0Yn1oa+/?=
 =?us-ascii?Q?cCezD3N+PUaPBJJsP50rLQQCUddd9GBveqJLgbYNY8Xw5OWpTmR3zTWE45YG?=
 =?us-ascii?Q?7H3k/CYkuLhXPdOXPBAsNE1AIGcjaKSJtxbGaX5dskssWLudubMnrpodX8+L?=
 =?us-ascii?Q?7CwToPn43+qEezOUjDahEWUIYbbD9QH2UoOB1paEqhr6IUsd+SS/x9ICOqEA?=
 =?us-ascii?Q?56qoGLCApavDa7kdeyEQTlo+eMbuw+zYtQtLvDKir9intvd+YAZ2YLhFk2CI?=
 =?us-ascii?Q?3mEq7APiO/QiCUjabhuwWvuUjM1O/1ytTbweUVt4tayv5ku3AnhtogdCNJQ+?=
 =?us-ascii?Q?ue3Fb03SvL6efrpqTHOzsGksWaIsd2YrrOdyJzzhvsknYaOV1Hia3ebSi/yH?=
 =?us-ascii?Q?dQXgX7dA+MNoJKX5Bm7u6rmUCXVEDl1m7HD6SiUPERn6WRGZkreoOMKhQMwS?=
 =?us-ascii?Q?vCLp3Q4oQ38rxQj8DRhmltiO1osZW4lorTX0if8AeaYerGIyOHKy2b94jqLQ?=
 =?us-ascii?Q?cAOUTmLtf7fVPlyKfTFVT4n9whPykQjQb2fov0RSYRPi6SQ1KXOExgri2CPe?=
 =?us-ascii?Q?l4ICgIVEnUSsEQ6a3lrwIy/s19BJZjIYe9uK+XmQoiKTjT2mBa8TxGpawaVP?=
 =?us-ascii?Q?EOwJu87rl/oiK9cc3+BpyNKIRu9DrfI/42lU+ppaYt8NqhiATLd7jbkTeF6I?=
 =?us-ascii?Q?iE3pHqaXryaGijdgLHtOxZA0I+S+GAWpWf7Sin94y/FYj3nPm8+tTGyEJfs6?=
 =?us-ascii?Q?bgj62G//E7+cOhRXm3n5zuP3XLNFKIzaXSB75L6+WXO8bqWFBHfeL2sqrcmX?=
 =?us-ascii?Q?pq/86FZDY445qH45oSw3wkZpFxyLXbnP6r4gs+iHYkFZeq0jc5WvnFHVv3pN?=
 =?us-ascii?Q?VL665nvOrSexyuNtO44bj5ReZXQ+e1WIP7bhnYa8s/oGQaVISz0eudopZuS6?=
 =?us-ascii?Q?oGJvyPOOlmVofIXHNUfbDJkyVcrf72Pn4M61hl1y/R9fCnRlDaE19tdEK1Yw?=
 =?us-ascii?Q?u4e0Q2lixaChDKoKPSOR3xW1GRvxSDvJEH9EvvL3h8YteHwkuXXig7leYt8H?=
 =?us-ascii?Q?18NohY2x8qMas9Rk4Ro+/sbrwUXlvC8ckiD95FcjsztUcidfLg039yb7dF1f?=
 =?us-ascii?Q?13wAFIC19N8GivQFtiPk8y9ciE6YLLOTP7kJHXpTh8hSGgfAUg9+eWYb7lNY?=
 =?us-ascii?Q?34qf3vJ28eVyJGoew4YUya6IdVgZwjd2LneDAMlo8VVr43qJAOGz9m37390B?=
 =?us-ascii?Q?Czo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KP1k98B7d6awCapGsUqh6QqWcR9YJwG16kn6UWWeduAcxZlesjAYmB4gnqaR?=
 =?us-ascii?Q?SMMiogcA3/U0/VGRHTAW0SNezV0nSv78b32rSc+oPPLykBM+IqnBf51GbAzX?=
 =?us-ascii?Q?H2ydxbTO5E0Tp5RsJYf174Kj0JXnbcQ5HudDC7OmPW+TqbFGOuCoAtILK9X+?=
 =?us-ascii?Q?D7cS9I5dnsuP4wTLdnPZ25MD5dCJG8nz5ZFQGhSwtVBq+TnfUhRwWjXxpA5y?=
 =?us-ascii?Q?OxH/OYYX6ApFM4GH0+7af90SXZoP4aJtT/M5w9XsZ7XzfzQ3K+EbqEEhH7TN?=
 =?us-ascii?Q?rcstFBAnLKctrU9Tvf742f+bXkxqFE6GfD1hjiXJh/qvfXIWqtqcC7SypJxi?=
 =?us-ascii?Q?lvOveoZNQBtkRO6NhBdKoTLAM8vKN6Ne5yBgmfnadqdP7LD2FMuIzoQ3t+RI?=
 =?us-ascii?Q?fGBHNoCUW1RcIFb9v/FlBO/0GiCpl78MxJiXiNunJ3BhHT1flNsUt0Lrhjsv?=
 =?us-ascii?Q?sW8TzNKCmHjDTHBCIuH9m8G0MJbUfh1ttaS97gyxhY5nBgqeLRtZiW/GnqYz?=
 =?us-ascii?Q?hmNzRv53WLcoq42HI/AUtBLkwzPJ1GuMLCynvjmVZ/n6yQUWqROdBAV4dr4q?=
 =?us-ascii?Q?2JA6n6xlcBkzSx6ze2SWKOtpHacVNmv6Vn00AIq6JgcfWIuY1OWLcWufB04y?=
 =?us-ascii?Q?+Vow8fph34KEk0nT9qGEmrLrlpxgR1HvsTAMs5+VXhu+0SBcaGwPeEhZE9QW?=
 =?us-ascii?Q?eXP6a4MgMnSOKlgIM82t91gLfHd4l1ddtMDC6c4S6L31xzIfdzyvmMIqcB36?=
 =?us-ascii?Q?6HjTeLkjxvMaNgjZvtdIx7uS7+czlwJF888b25Gbeu3zWd56Yje6S7Z4Saw2?=
 =?us-ascii?Q?OMKvxUBcT1hpoNRRO+AIRoOEXyNBn5gO0I+UXL/+Njk32T5xXPcId1ejx16c?=
 =?us-ascii?Q?JRFg5KJoDnFsXqGhMlYPDbJT2MTWKC7E4CUWtQLeOSnbIUJTYHVePZJ6N5b2?=
 =?us-ascii?Q?q+0nH5xtLKdh/IOCXz53tyKD5XLIZoWS0mlPxVnQ2XbYNu0T1Dqn6vs+6MlG?=
 =?us-ascii?Q?q2O1p7BasGg9SlVceXIojg/WU2HiVG2jpZCRe8gLh9SD/u3XurQODrkDLqew?=
 =?us-ascii?Q?kFehpoBGK5GTTD7pEK9zI8oAxDnuS8toiE3N4ccVFiE0+MbLgGwy/2enuXKy?=
 =?us-ascii?Q?L0eCR4IWkFSE0+qSA/ZKkoO0XhfBrMTcN8VSdGwJVIk2ahm2HyUIKzU19/mt?=
 =?us-ascii?Q?k739PJbEVD5Np1q3MFQh3Vi8FLEygp3b9yDwUpHW0L19zbO6Cbc4SEPIEIZB?=
 =?us-ascii?Q?ByzzUyTWzk0V2pOrmzTlT00qcHAv3arSkIjeunh/thgHmU7kVzClhyTi68g8?=
 =?us-ascii?Q?wYMKAvC6a8s7YBzlWnWATC9LfKK3wU0mcBe1dq8vng3F8PmmM1Uy7vCjIlkw?=
 =?us-ascii?Q?kACiABkF/Rb/aH4qVH5lfvrLARcbFAzu3KZGGGsI2OerIQ2MSAvMJQFIaotL?=
 =?us-ascii?Q?y5PiYmMUuyhIG+WZJvlbkPECISgWX98N9HuRvUTHzohDhQWJJS8+yBneetca?=
 =?us-ascii?Q?Nb3AqVMLTFIUSRdT6wxRHKYe4jCMfhe1OEN8ugQKFlXc9uTHDdmzclx0K6bs?=
 =?us-ascii?Q?IzmZ9lqT72QS+3/utYawCX3T6JTTuio8c4Rr/XcK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfed336-4c3e-4ffa-d671-08dcb617211b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:56:03.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlmruRVNLtVR58i5CiC2Cdg60WDpw8reQC4p7q5bEzTjffaw/lVR2rjIj74sXbka
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214

On Mon, Aug 05, 2024 at 03:03:30PM -0400, Steven Sistare wrote:
> On 7/22/2024 11:55 AM, Jason Gunthorpe wrote:
> > On Sat, Jul 20, 2024 at 11:56:40AM -0700, Steve Sistare wrote:
> > > Live update is a technique wherein an application saves its state, launches
> > > an updated version of itself, and restores its state.  Clients of the
> > > application experience a brief suspension of service, on the order of
> > > 100's of milliseconds, but are otherwise unaffected.
> > > 
> > > Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
> > > of an iommufd device to be transferred from one process to another.  The
> > > application is responsible for transferring the device descriptor to the new
> > > process, eg either by preservation across fork and exec or via SCM_RIGHTS.
> > 
> > It seems Ok to me, I'm glad it worked out for you
> > 
> > But have you considered using something like the new
> > memfd_pin_folios() system so that iommufd is bound to the FDs backing
> > the memory instead of VMAs?
> > 
> > https://lore.kernel.org/all/20240624063952.1572359-1-vivek.kasireddy@intel.com/
> > 
> > I've been expecting to add support for that, but does it help this scenario?
> 
> Thanks for the pointer, I had not seen it.
> AFAICT it does not affect live update.  The memfd is passed to new qemu, and
> the manner in which its pages were pinned does not matter, as long as the effect
> on the mm fields that we manipulate is the same.

I mean instead of using mmap's() and telling iommfd to take the pages
from a VMA you'd use a memfd and tell iommufd to take the pages from
the memfd directly.

Since the memfd is not part of a process or mm_struct it is not
effected by live update's exec() and none of these gyrations are
necessary.

Jason
