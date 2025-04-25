Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE82192F3
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606986; cv=fail; b=amy5y68Larz3wubiBpdlUGyJyFVqp6yHtXEkxgi8vvQsI5QsbWuGTXaLKwTwbd+opUX59nwzqdOZ19XE+5dfTE8C70ac5ZhjWb2u/bJP9Vz9v8VyGbTv7mgT75SwlLPC81PfnWbESZRlYiJWUKuoqwCZriNDKjr80hqz5CSa4n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606986; c=relaxed/simple;
	bh=3F8yIrLY/WX1lukatDFl4wWfGNCybhKJ/kjZaCvAWXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pd5P0Q6Ejfva1GJCC/xlL3To3GStbarUrRp66QfRRZqOEPVRl5cYpe25PcWofyT3q876sJUI4TLAkm1CwStRGRTCcq2A8hw777AthJMV79RhejMccym46y4hBFUgLB/UgUrRE+IYeW8gCSWY9E27dw7kgO7rzXnYVLhDw5guOck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0DsIZL6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0DsIZL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745606984; x=1777142984;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3F8yIrLY/WX1lukatDFl4wWfGNCybhKJ/kjZaCvAWXU=;
  b=l0DsIZL6aSGW6JAM2rEUfqay0kz1X0zmN/FpVWqpxxtzNTD09Bt4Gvg0
   YBhpBWJzojCNWLKjEWYmqDWKInQtChLvhj6hvJsOe+uIPT3oJD/zBH8Ke
   GLkOLkJUzxXu8Jc18NrBk4Tfa/8xvJ34lHyHYJwKNwQQy1DpDJEpqTBqi
   mYOSivWcxNE7Ynu74m/F2hMgl9Nb2Onxy25D87DExAOU49ROkxhCxN8aW
   96FHEOGLexFrtB64Q7RL6tQqNSv928hrXQq5D8y4YqhTP3FF6zHYV3x9m
   z/HCJbFzvTlTtTL2pl4dEZ1etdVl/xEpYsOFZfUHFt+FKP6M9L416Cn09
   g==;
X-CSE-ConnectionGUID: h8fcdx83RVGEenr1PLpTTg==
X-CSE-MsgGUID: MIADSbPiTfyQHltDCjvqzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="57924307"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="57924307"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 11:49:43 -0700
X-CSE-ConnectionGUID: FNNKY0wwQh+Z3klk4XjcQQ==
X-CSE-MsgGUID: 41kgdCGaQd2QHMEXDqRJLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="137027775"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 11:49:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Apr 2025 11:49:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 25 Apr 2025 11:49:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 25 Apr 2025 11:49:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS5XtmDMdeqlhTHOdSnq7nHh5Nm551o8+o5Rs3H/elde/F81hudGyoUFaAaVUewo1gdsywGTrgYp8mbOKC52LZgXfuXzjfVuhSWpAvuFEv1wBcDSodq/mntlhGQGBVg1fu3hNWHKOwniqBSMPROvntjruKrcvzmAZDqqRY5wYtQ8pK67mGZgQnmSF7bEn9QYu4Da8O8qgYigMh/j3UoyykoXnKADarASu1kNrM2usY8A0aSNdIhA0Ej7logStk4A163wVtfxhnJ2CtM+BQnSxdNW75e1XRDwOlyJm5ymYY0Xls6DfwYBPHhbC4Fuf91RHod3fwMwYmhtEcJ+ndj4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EAaufdU8xv/EneIafRdCYZvzhHxAHXOI38N29ouWJA=;
 b=hFxTcdcJMTSSixtn10fT9a0OfEHFsllvdmwDghu6tOMl0WFc5vwpGaA0DzQnfgiiZfqhnU/7qhy5kbxqplimMtHAXmgT1KSq30lSsXwn4UUYb0eGTGUTLh/9Nv8kat1sxCBuKH0uunkHXhLmtqTazVwZuJSleaRL63L/ceFoynfyJEG+z+yvrOwRzIElBfoxLN4z1eSS1hshZmeiUqU39xcD8jF2nAuYrMaEnPP+ob874whk1FhMHQsMDJ34Tz1rjkD8y5jM2iU05JbwbDyducTm5HfGTuFGfSP3zqSloWQ3j57KpZkv8JNBnpgo4L42SBQaCj8DEy1vB90zcGQUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8245.namprd11.prod.outlook.com (2603:10b6:208:448::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:49:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Fri, 25 Apr 2025
 18:49:40 +0000
Date: Fri, 25 Apr 2025 11:49:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Lu Baolu
	<baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/3] iommu/vt-d: Simplify domain_attach_iommu()
Message-ID: <680bd94098249_1d522945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
 <20250423031020.2189546-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423031020.2189546-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:303:2b::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bd8f02-8fe0-4843-1c29-08dd8429ef55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CyGlnlWSbVmRnF7skvGCzwrjkLvlAX++SSUgTbYhcReLemNp404du32126zQ?=
 =?us-ascii?Q?B+T375hUgGf1NErMiFSbxssxI9MXKODQzYBS2uMMuk4eVYmBSeWhQw29RgIs?=
 =?us-ascii?Q?oDZ2pQXK8Zgo1bkljR0QAYU/W6TJB2vc/BsDj+lv9cUg+5Tx6z326j5VxgZS?=
 =?us-ascii?Q?731cOsY/hlot00I+MLPlOCswaOmIJnh06Px418UAJK4SeLnua9/BihqX3DGZ?=
 =?us-ascii?Q?PL/putEdx4dlev1PWVgt4l20/VOW6j7Qc+r0GLXdzS78tKnnd6zmQ8JIDosS?=
 =?us-ascii?Q?lTG/APEsCSjpLMXdrwRNmADs4UV0JuBfH2HTvzwZBbDi3jhBNtBQ/mL/IQwf?=
 =?us-ascii?Q?aFFDiAMj+NYdcEo2P8oG7QYuTAeVeUvvGKr59ie3+5pH9ikgqZM1wFC746tk?=
 =?us-ascii?Q?7QEOFN6itwQ7ug3hMpMz7phpGPsT609Zw7+7F6tvgxkrYKGGjOgOS59CRPLl?=
 =?us-ascii?Q?yJEdAEKcgEkwMPPHsXkaajOyiaoBiS+WhdDUcJBdGVEyHzxQYPJcWMETvWln?=
 =?us-ascii?Q?7Yl8dt62PCb6n3F7O4RvqW3yJBt9S1rpE00pJoaOwY1EdMNJS4fULAgJOqmt?=
 =?us-ascii?Q?HySCWNHlCVuIVogGt9gXJFxnCvNGxmnnMUyhx/HFrXGzFtSZ9sgdI17ANxv1?=
 =?us-ascii?Q?MSsSSxmVlN/mWef/cAtVPLF0oAowSodfelAdCDkjo3duG6ZjQa1JL+uoXt6Q?=
 =?us-ascii?Q?IXHC7WxpTyEXxy3QOO6SNUcmyxNRygQ/fNKvXTGQe0LrL7qc33o6y6yKvQ+u?=
 =?us-ascii?Q?uRCgXm6GapqegoKf6jV3iM2PcC4g3N/i309Amz8CpHAK7Sig70E6B101ysAl?=
 =?us-ascii?Q?7Ssqahi3oGS7rgeHwr0epzNYxZL7wR16JvA3Z8DNk8fJ5gbkyR9ScZP4dvkw?=
 =?us-ascii?Q?iIFs0UO+NUzt5H7c6rO1YsXyg/NupsclC2RbkW5N/2n+fkyvwRzUWwMrEc1V?=
 =?us-ascii?Q?J4Vb7DNcYcn6VWvciOp/jGeVwu+R8TfUSUBy9seYYmwNtW7reHN1KmiqoKjA?=
 =?us-ascii?Q?UIUwQPuhOGN9miqUKG4NcmNnkyG/76++LhOsVKNAx64Fe0QtbMzXKvvDDIF3?=
 =?us-ascii?Q?QXrLi//NkjU/3K2irkVnJefLDzCqMgKCvSpzJ9tQaS4/9l+HxQJ59nL25fF1?=
 =?us-ascii?Q?BRYNvEyruKb1vAF6Ovwg4afApNx1uE2zHjJ27c0007m6G8gy9jNmQqrgrsBp?=
 =?us-ascii?Q?/WkREkuFL0AjEmFtmOcT/90gtbXNZHBUWDw08Aw6ph8mnnKjc0s+3O+D5iA+?=
 =?us-ascii?Q?Es/tj5p+Ev9Fto7NiHVxKQTov3qX8Q+srdvf7Dt0k4EFigIT5fNEDxIn5GKD?=
 =?us-ascii?Q?TQoZ8Ris2PAS8QlZrG/2wlQlU2IfRkRXhthwL7E5SMJr1YxsUjnQGZ+HgNjb?=
 =?us-ascii?Q?Mo9KwXzFCfS8GFlOdbfSSwf+CVW/Sn7bBjiyoVpYI7DgHxCyLplWqdpmbdNF?=
 =?us-ascii?Q?nElwt/RypHo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cxg+pAMe1misA83h4k37UC45l6yGiAYuSfj/aWB5swH6odf881wkMIJBhyHF?=
 =?us-ascii?Q?rTm7+Q+djVif/2EwpcQzPw1iLp1E+0zi244Wv1hVQoz3ZdCL2u9k1Hcy4ZnH?=
 =?us-ascii?Q?Bbv8f2fga24WNcCAh2tjfYA/4tVqfeo9KhbM0/tj3YGzZx0X0Exrofn2/1qO?=
 =?us-ascii?Q?XUBp1EWmQAd5LXVQ+wkQjkxXRxcxODUggPfF8LDKjYj+N5wyMJHZpEs1sOuu?=
 =?us-ascii?Q?elH095Os7HPjAVQsFNTGU++JSgCME4Lfbny6JuRS5z+fWsZEqEtlCT3mZKjn?=
 =?us-ascii?Q?Q6zTrvn4UdLhDgxIkwMv/GLbelzLaW501m7osAayO60HCLG7xDK+PV1ueDKz?=
 =?us-ascii?Q?Bj5V19OiJhaHsgqWa35byVGOiWr3pVAq8l+FgGUbLdxxZ71St6nNE+2Ao9Eh?=
 =?us-ascii?Q?gC1sPDdFV2vLJVtVshh2PIySchkr8ddENm85vkyyjVCa1xhU66vmauahqTly?=
 =?us-ascii?Q?yDyIj2HXsMCTAWmaoZMEp7aDf3GULoIr0I8KwbV7Xv/fS/cjISb9mJO1EnFQ?=
 =?us-ascii?Q?1ymNON1LOgfDvzLlO2v3l1GnTKOp0NNlH68Nu9cySMoU7SFlPip68xe/Aejf?=
 =?us-ascii?Q?pNOoaHCyQTWbq3SsDBKRJaF+MJ/xE0fBXrWJVYWgvpyupnMYreyMCOWWq+xu?=
 =?us-ascii?Q?HDgxGpHyQmDgINNQayIw/GnFE44VMzCurQY22WOVxcwjaQtnWxm3snGkava1?=
 =?us-ascii?Q?iHGlRz1GPoUudlEXVFLHi+BM0XTPKlKzTDgFo35Ewt8WIdIGbUJuVa082Nfz?=
 =?us-ascii?Q?p/44wy54j089TQ7ZSFyeiHaKD7ameqhcL/UicxHWNCakWYMl+g+NmRwGUhJ+?=
 =?us-ascii?Q?eoGSy0a8KlvbVIpTgPldKVTHXnlr+yHR2rWh5CPylqRKHWOT74oQnS7vaDYS?=
 =?us-ascii?Q?K0fNtWSZmNJMl69CiGNHeKIlHZ2p0b/xogXSvRQf88g8JP0KbMV5ZMtlGh/D?=
 =?us-ascii?Q?fqitXHQbKGBT/yOlxGtTwa66qfKfQzEsUC7vPutv9MvthhxXD5aQLuDyL/h4?=
 =?us-ascii?Q?ulCrVHgqWwQvQ3u9e0umyhxn3ZPyf0GYcWACqHMYMyYXHRoRt/LbZB8wCEt7?=
 =?us-ascii?Q?0FBKxrB7vCqyzrm1arw/dfL2ubDMZ7n++SUcGmmJG0ZFNqOuA0xAiI/J5qw1?=
 =?us-ascii?Q?XEDZ3UUQSc3HA17f+pKJBUjeW26UF/rU0jmgHNV3VA5ORaKPU0BT5WK/XKhD?=
 =?us-ascii?Q?8Rx0sFFccX8/bwUGxJh0DkpZHIXKmVbfuYuRR5urcCdHmFgvbOuAI+P8qUdp?=
 =?us-ascii?Q?TdywDHUsYHyfiUQz+ojYZMRaV/EFlZo1tyfO0m2gB8/VgW8PS53eiyoudkQT?=
 =?us-ascii?Q?7VcgFNREgNuDY9MgdpUHswJuyHSF3C0izNvM2WSzDiFwEpiGot3rlFoKgw8n?=
 =?us-ascii?Q?SIeECg67TI3eGKk5ESkMsWDE7Q0PYbjDcxf6q7sWLezJHN2ZC2rmwdHA93Po?=
 =?us-ascii?Q?YcdSFQJbtTVBApYN0ph3YD2r53VMnhSrAXZiEDtvfz69Ju3pnA2+c+o+sxof?=
 =?us-ascii?Q?uITU6GmThKBFDaeakNCvC8GKPny9xhifVo8gqcED4k4pdTxhXgJr52Vy5OTk?=
 =?us-ascii?Q?5RdP3HChzT4CfyZ4HrGYg6oQVJ4y4XpbyWKfxIK8P9xvIMLq4p8aqjXVxqnH?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bd8f02-8fe0-4843-1c29-08dd8429ef55
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:49:40.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHPuBeWKvaomcKSbJ4mBkf5MRG7/TbZWwf1Pt20iidHcy6OpIG37RrO50YGeqh2fpD1kMFjpASS0zmKtMqtDeEkKyZwVdSteJoNDwulIRVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8245
X-OriginatorOrg: intel.com

Lu Baolu wrote:
> Use the __free(kfree) attribute with kzalloc() to automatically handle
> the freeing of the allocated struct iommu_domain_info on error or early
> exit paths, eliminating the need for explicit kfree() calls in error
> handling branches.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 3a9ea0ad2cd3..12382c85495f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1337,13 +1337,14 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>  
>  int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>  {
> -	struct iommu_domain_info *info, *curr;
> -	int num, ret = -ENOSPC;
> +	struct iommu_domain_info *curr;
> +	int num;
>  
>  	if (domain->domain.type == IOMMU_DOMAIN_SVA)
>  		return 0;
>  
> -	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	struct iommu_domain_info *info __free(kfree) =
> +		kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
>  
> @@ -1351,34 +1352,20 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
[..]
> -err_clear:
> -	ida_free(&iommu->domain_ida, info->did);
> -err_unlock:
> -	kfree(info);
> -	return ret;
> +	return xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
> +			       no_free_ptr(info), GFP_KERNEL));
>  }

This pattern looks like it wants a "xa_store_or_{reset,kfree}()" helper that
handles both canceling a scope based cleanup and taking responsibility for
error-exit-freeing @info in one statement.

I.e. this is similar to a:

	"return devm_add_action_or_reset(..., no_free_ptr(obj), ...)"

...pattern.
