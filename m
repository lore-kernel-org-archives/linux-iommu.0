Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAE39E6CC
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482757; cv=fail; b=gBo8wUstlqoxr3nGLofU1+0Q4izdNsfVkiFAU/P0avlONf03QPUVGLQN1/TEgzyV+UQdzhb/q/5D5+rY8SpC2Mplr8/oxdHpHujwoPpY/lbT6h97VNBv5QXGJ5CqJQyTNoGAYnBdZKwlsLNcpcRzTYDBH2MWYf5EnI0pwZ8cG44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482757; c=relaxed/simple;
	bh=H2VvqmHWI6XigFuLa4xtWFjNkxsZutb6/oxFaJ/zRsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QoLO3Gt495Sv0Hhf1ZsfAesPfA4NC9diL4cZncTvJJXOo4Oit/dAO68FpZ7ivVeA+hw5B9dOPFa1zu8h/7/y7Dw3HN3dbduUMfJ7CiuTowKgEPwkepppMpsAJ1SNvZ3cg8qKF4VdA51xMLs2gfM49ueoibcrazv/pyuT5OHe2CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ow8vIWAo; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ow8vIWAo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzO/sorHFcUP1hnJ7AVk0DXOltm7HGn1BsqlQT68dk2ryVFbb/M6y89df9cjnE9Ses8NlLd7wvQG74yOfwylR/Ypd1UDO7U51FqBQK8k8dBi7uY1vGz9Wsue/4t4XC9A9NzSx2qnMka8SvJmLu62fIjuDEEmkI4OEfyYtnMeKypJ+KNbikxzPCm7wTwTIzWMeQ7/BlJeiiDJ+ORd/umLr5skVI96hyadIxCmFrfON81lpqwtW5cH5Qj5CZCb3fDeSfdQSFp7jydyJ1ij/xaep8fMW8LTa7SKCVS6Ah+LJP0KKG2udx/vXe22vOmXfe/ItERj5OvtODs664VnbJjXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+DExzRjM60QjrF7YNzo1Cyxv2AYOZV/ByFaAnGihZM=;
 b=WzvWg9fteK/0nP6//aRJ4hp5G+Xr9cFToKipTPtlRyxTEcuWJrMDYe5b/T4eajA0lVdmxiDY+VM95D0IB31UpWVpYkUnDIqP9M6mdmwgmpMzRq+BzHyMAYkXs3JY8MrLhluw2SnlA+7Awqmjab4lYKPZvTMS3sGcCUx08pR5Jmk0HulvJ45gqjZLGnV4cUY2utg/06QiACaIOcqMeeF9+fQk438h/C3z8bbo7lZumLfrZmN3BqGQGxCqNP67HG8uQS8l/QUt0ts1awKwrNDBwin9gR702iJLU4Y7E4cWokFGlSEkUYGAy5cMfOFn59eDJOBsJw8rSrp1Q2hc+tN3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+DExzRjM60QjrF7YNzo1Cyxv2AYOZV/ByFaAnGihZM=;
 b=Ow8vIWAooZxZqyrQoLWr9iCRJ2tXnUolf4FKCAE3y+fBbEQ76rsLbB0CTh+OCPWvLumV1N2/uAdvEW8Ecnt7Gj7h9GZilbnP/ys9zp1BG0VCguPw6NIFKeDB7jirzk/99qG1b3wuYykKUgUDIdLDfKK5OqDZshBpVB9Vqnv/BHH8lGhsjybLNhZTebQVqO8287A0BKlsZgGBUtB3BildPJwDey+sH5RGeYdLxZU+pFnQmvownORt3gZMVCdiwjJbt+WH74unkpKxjVAJ5BrXiT3pc6/jwiEe380RuGhWgMGYRZIXASs+rECLmaOxcC+Y8FLmziB6165pkMTmTJz7uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 13:12:31 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 13:12:31 +0000
Date: Thu, 15 Jan 2026 09:12:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Message-ID: <20260115131230.GD961588@nvidia.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
 <aWacsq9gDrAgPxli@google.com>
 <1e967054-d2bd-4c3d-99eb-315a40bac9de@linux.intel.com>
 <aWd2KCSU6XTNmQ4R@mitya-t14-2025>
 <a2b12b1b-abd6-4d3b-b3f8-07c9f71bc7f0@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b12b1b-abd6-4d3b-b3f8-07c9f71bc7f0@linux.intel.com>
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: f564bc6f-ee23-4992-3de3-08de5437bdc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g4aV8ZomzUzltCzURg5rDbgTeYa435BpPK0RTznWGCmdzaO2AapxH7fUjt0Q?=
 =?us-ascii?Q?WbD+Q3Cler61Etg5IaWHsGEtbPe7S7DlqgxN6oRjLW5Wd5F6VLNIdSeKytuq?=
 =?us-ascii?Q?r1Ghe8kGGauOnVx3stoui9MIOcq7TtKFQGGilsebp6IHBeHy+OMBYFHsG3eu?=
 =?us-ascii?Q?+c/JsBTCsVDV83BKqQTBmVmisth61BYUDCP2yQx0Qcdzyy/Mh/8EWKEnj1t7?=
 =?us-ascii?Q?j747ajM0lq0M3fWQfiA5/xXc4lIGrmNEH92sNEKiYUgKLFhBtcTWKo4EgVaV?=
 =?us-ascii?Q?HxswETMKk04SV17OmzjJ69+BHVs/FdO96ba+IRwNImgKdLTIkccyjw/YZXWB?=
 =?us-ascii?Q?9XjyqJeYd12xXBlOjYol9eOrDPmCo3ULG5FwSkmjD+M2nEeoOOBwfh+nqMb1?=
 =?us-ascii?Q?Lr+T2SEv23w0hr95Q7pY3gSRNqoQMeL1OdqxbHPP5CECGg1kJPuTqH+sjcN9?=
 =?us-ascii?Q?3zLmFq1OQp8KvYp9aSjUVl97LZlMsDTHWPIjjFSKT2CxizMtCmnKYyh/19y8?=
 =?us-ascii?Q?zexXFSvF7oH7/VP9cOo8weLt7HwAu+h1IXhqMZ6j53Cpbczxf4l0ZWn0FYJ0?=
 =?us-ascii?Q?O3sOK8l11REYfsl2yOk/h/j9jK+LugsFmWvKqvBV0KD0fR3wHzbzVJemhjST?=
 =?us-ascii?Q?gutuZjHLKMGvEgsJeDckfXSXhReKJVY92iJrz3DwwNZkSpasAdJqb1FhKNos?=
 =?us-ascii?Q?kEtdwV0fXEL7YpO4pSs1sdetnG/6RyCm4yDPdiESxlo1XXIy+sB+/6DZ8YDL?=
 =?us-ascii?Q?tkUu6zVQEGkffpM+ArJbSfuchS7Sd2q2LMFKnwCs7tr8LDQqkpZ8OEV4a46G?=
 =?us-ascii?Q?Vjw5aN5qNERRiqrnZ3B05crkSsftgfwwcRr7ILBNN7nEDF6ELJrWLDH1jahH?=
 =?us-ascii?Q?kWvExyMAv4Axa1eRGdFWhv7oTmIY5kuXD1/2KYX6QkDxONzdmh6B5l6uAAX1?=
 =?us-ascii?Q?NP+ztgVJoXLwRYOpVUfiRVO/TGOPGCJGw/sVhK9HAE31ECvoH8RGtPjZ7y0Q?=
 =?us-ascii?Q?YaP0IWH9ofHSXrf2u3Z08yquXRpw7Q/Q1wh8exEZHufb3/L8DmYWeZBHX7rm?=
 =?us-ascii?Q?in2CD8fKTENTQKWBOi5iWnoXwaiBoDpLLjYFo13FESMJTYx641FYojtAadx1?=
 =?us-ascii?Q?9AgVr8psp/feGy8cyNpx2ZzosHS2CVTpcMecddiTSpoP3Jd4n4ttrLKCIXwY?=
 =?us-ascii?Q?qHRwC/xhdEQKkFWeuKYTnBLI9tAX7fiA+meAx7H4wP7w0QdsZPi3UiJVLC6F?=
 =?us-ascii?Q?kWn6FaFvLE8ua/zii8uLvcQAmQjutUnOmPtJiPNYd8EeFYdtbrEfgRN/6az1?=
 =?us-ascii?Q?vWpfDC3J5KmwzhIqcM+oM5hiiY/cIH+2UcNokbLFvznz2UkUq9tAMvbB/kOn?=
 =?us-ascii?Q?WtwA2Osav+seWqohpaoVZTqnN2L2Y2F1bWqrD12k6M0Buu/qnz7Fnb/bZVyA?=
 =?us-ascii?Q?wNpEeD553sh4PpgA+j6gLoovrC06nA/0TtSjvBGyBoTxrSUVsePoZFNEQxDH?=
 =?us-ascii?Q?u2HibKMo3OYBsr+KSkM8syjGHlIfkZqsO3AKDzEyp6NLN9FxLoMc0Xvyhvnv?=
 =?us-ascii?Q?+T/G/+MYA+eg9+w9K0I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4xQOzbyYdWJioWLJ769nRXfra6/owIm8CnbAv/2YFtC6AbQSmvysMfCersQQ?=
 =?us-ascii?Q?Vq9Ya1lAoces1XOajnc4IuNsc2y8xqiEq/skvC8FSQIlv95Vw7AwB3U2+EvM?=
 =?us-ascii?Q?hHyXO7wBfetSxed2cOgENxC0WZ7y8fMor9da2r15a/hlspbDq/5Mpx3mjssh?=
 =?us-ascii?Q?IoaIgNdg0T3+fcvzRUBqBqylYOo3F81ZB4rVDHPwGreitIeZX0uohAeGlY2F?=
 =?us-ascii?Q?nNHNVxbMb05ztyFaZBMeWrSi2h6LwdUD9xktl8HdVmel53+bJuW6J6jzy4bS?=
 =?us-ascii?Q?1G3AHVYpt3z8xBVGvsQIdFWdVGJFKo1y0l6hqkzdmC2omWsLkeA/b8JIXhD4?=
 =?us-ascii?Q?tUElfXyKkdRAiyjh162cOk6M/ZYUbvTbppNP2BnLcD6XXceuznhB83kuBNfw?=
 =?us-ascii?Q?s2tMnOWVFhex3p54I4JZLdUt+VuOH5bxKNCPUSYSnIAEmdrkR4wp0iGENqp6?=
 =?us-ascii?Q?5O10CqWZA9jt74wN50Gc7FjQBD8YZMpTdJVhWGo4Ka7qdrN4U+P3meQdSBQV?=
 =?us-ascii?Q?JecXAQXvMC3m88gCJfNQ6CuKIxfKONiDr6L4nCLZevy8lWYqbnNlYC/TdgTB?=
 =?us-ascii?Q?LvxeXlJ/rkS0I0fxVQMrL5O639KSJMvn2wi2bDKKBOEBfObrNAhGLOeQ7M4T?=
 =?us-ascii?Q?oTasTEk3UtEypu2cT60npVYakrVTR4DABL2lUZTBepce8C+HuOGRwkBWY9zN?=
 =?us-ascii?Q?Atc1OLYnpdvrugNL4jocyGKklkhMQF4UuvL2ifoBM6Lm5UKSdvhYTLld68D6?=
 =?us-ascii?Q?Uq9AX5hMDpLTxOyk74DLFjEeA4E8+kychtaMUcYS+ZgU+YpAIzSFLaZyazlZ?=
 =?us-ascii?Q?9aZeygPmQ2YckAF59rMdW0vIXydXEnDr1V2uZ08R5IbHWTToe6ucK3vQndLT?=
 =?us-ascii?Q?zLViXZrIoHDPXovHDmK6x3WTR/0tB+bZ2ecYiraC5E4kaChVNWI5CTyLNhtN?=
 =?us-ascii?Q?bNq5yHVr1zE5LVhIyqLvowvJEpUIZCX0ZfkoLltlujfXPqqDp839oQHQ52II?=
 =?us-ascii?Q?K6MO/DVGZY6RGTXPZNTIuORlhECVzHcQRpzSI4h0hgvQNVf04pbrrNpbUzQx?=
 =?us-ascii?Q?e6jlybZqus2wed9qGZS/KjjrEbU96L5Hq2znlwDCSouQXc7PBfn9/gBCwxlz?=
 =?us-ascii?Q?Y3Vmdu+9euMsLHoWvr2th9ACHULzGKiAvPW+lHCSmI0v8sbkhJLDBbd4bxqW?=
 =?us-ascii?Q?Y89E6E7Jv1vxftuLnx9kiRp8bLN+IPY5NKQ78meOWGmutuEaocczukQ2mt86?=
 =?us-ascii?Q?dFFBccjEe/zLrgSG6tWb794xbC8/NsUqG4CmjSeOLdz0NLKuvbyZoDxhuI4Z?=
 =?us-ascii?Q?YGQF+BVpPPmTH4jk8dno59MzfCg+pdMsvMAzSI0Qo3gm0X+1u5q8v0lc63eg?=
 =?us-ascii?Q?ms0zZxz20ckaqSUI9KYsjnl2ZZZ5qoaGnwz5RL9rGBrTPyXs2kBnK/vT/4Uf?=
 =?us-ascii?Q?0r6HSAIkOy3TefUxRzXb7L2D39HgSsUtUzu/wZV6JQsj2lKGtfBBvYJ+VY29?=
 =?us-ascii?Q?Gl89Bxb80tPfIGrExl3KIXnkyi43a3zdbnpGst06jRAUCDRRMx7s/3mWpusE?=
 =?us-ascii?Q?lhvnCs7jryEjE4zce62Rc3HuKX5s+bb3M6sbLXtTkb5uyFXDx5MBbL8WLEgW?=
 =?us-ascii?Q?3zSIK/0NJyPYUlVnzvDqL6cf/ZMnJx6Hrndk+xflqB2lRA14KhA22XKHw4uT?=
 =?us-ascii?Q?3fMTWhqSAmYWWmnsUYDQyUsP2uoNe6u7QAq1PCkcjE7ogKvTWUG1X8ylk2HY?=
 =?us-ascii?Q?jwBzHjDWug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f564bc6f-ee23-4992-3de3-08de5437bdc3
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:12:31.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3RwRcWgHrOhTaAsGqpcW/qL13CTzfMnAPcdeS2UxY+48Ad1hdc8Dm+DVX2cF3E8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714

On Thu, Jan 15, 2026 at 10:26:16AM +0800, Baolu Lu wrote:
> On 1/14/26 18:55, Dmytro Maluka wrote:
> > On Wed, Jan 14, 2026 at 01:14:36PM +0800, Baolu Lu wrote:
> > > On 1/14/26 03:27, Dmytro Maluka wrote:
> > > > On Tue, Jan 13, 2026 at 11:00:46AM +0800, Lu Baolu wrote:
> > > > > +static __always_inline void intel_iommu_atomic128_set(u128 *ptr, u128 val)
> > > > > +{
> > > > > +	/*
> > > > > +	 * Use the cmpxchg16b instruction for 128-bit atomicity. As updates
> > > > > +	 * are serialized by a spinlock, we use the local (unlocked) variant
> > > > > +	 * to avoid unnecessary bus locking overhead.
> > > > > +	 */
> > > > > +	arch_cmpxchg128_local(ptr, *ptr, val);
> > > > Any reason why not cmpxchg128_local()? (except following the AMD driver)
> > > 
> > > Yes. This follows the AMD IOMMU driver. Both drivers use spin lock to
> > > synchronize the update of table entries. They only need the atomicity of
> > > the 128-bit instruction itself. So arch_cmpxchg128_local() works.
> > 
> > Yeah, but my question was merely: why use the raw arch_*() version, not
> > cmpxchg128_local() which is the same but also includes optional
> > kasan/kcsan instrumentation:
> > 
> > #define cmpxchg128_local(ptr, ...) \
> > ({ \
> > 	typeof(ptr) __ai_ptr = (ptr); \
> > 	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
> > 	raw_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
> > })
> > 
> > IOW, why bypass this instrumentation?
> 
> You are right. There is no strong technical reason to bypass the kasan/
> kcsan instrumentation here. My use of the arch_ version was primarily
> following the existing pattern in the AMD driver, likely under the
> assumption that the spinlock provided sufficient synchronization.
> 
> That said, Jason has suggested the generic entry_sync library to handle
> these types of multi-quanta updates across different IOMMU drivers. I
> plan to adopt that in the next version.

I also copied the amd driver in my draft so it should be changed to
this I think?

Jason
