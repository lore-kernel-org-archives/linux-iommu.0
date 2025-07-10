Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E900D199BC
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167728; cv=fail; b=aCRL0LD0gNcxbeRXqWm+CUxSItMXlxa0P+XC98Mk8TqOaNT2oosrQw/sjt2yhlRJ9kdrsO8+4R7Fja2nNhY3d+wSCoJqPklkN8+aOH2IcWvu8cGnpr7y7sOfk0Hhj6nVDr5DH7h0RotKU3FOkTBn9Q3Yo049WhP6rKAwiOd0bTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167728; c=relaxed/simple;
	bh=I8tqB7vTS9LzhJY8g4eBgvXYwv0PCW3jTryLmkee5vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=diHF9kc/IhFUvNnNChCWF03d0ucD6t/gzApt/0VGlrSIpYv8V65Px2L7pwyB+r6Y/FyECIlzw+xVZL7SzKvIlOUtmfi5KRs4ohwGJwrYHvrhr45ywsFBhaifOhaN3M0tToys9TMt9qjgUs0VLt8grGl3BGDguiS3FZ7yov3U2r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tWgjcsnD; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tWgjcsnD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LotDBs25EojoYhmCNfcmFCdQXk9rPopSOr4J5E0GEbl+1Uqi00qgNGtBrRsMNxM7Yraa0C3G8XUcDZwD48qR7wpgLOE6fhVi5VJsr57i/AfxU44tXI+iEIzJFUlsbrskx+rdgWYlVHhlI54cA8u68+kKJy6xHEW2rvt4YmCUgpT0ARO0kO+9H6GtpOI8Ua1+XDT8cV+t75KEePU3fBmF5rOiOP5LoQgFKcy4hmmqQtlnQ2nCmsb2rkr70zhZhm1fXtkcyafb5GOIxV0YPT+hVwD24xrmWYOnvs15xdSlxOPYyNOjWCt+uDFDAoHa1VSv2s1P8fA4iwwZr3h3WS7jcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zxe0Je1iAHxH53CEKp4VFaV07OFaFVJ3mnPAp9Sw40=;
 b=yHEFnDYlo9PTnjkpWBY6hCiinuULmldH/Ow89dfrnxWfHZLdh7E8wXqa6FHmCgtQKCdJkl27D5cfO0/MPkiBhUapY6ueHd7g37B6hUk2We4DLuKKf/IgV+BdkwxMHkCmOQfdYrIo725BHUydI0zbp1nUUOV26jleXYC5DDe9657NDOViCmMCohcmEHCO2vcrkEYDMFt92tN+sMuGJ6s08YNojEFp4K3X2nH6Uye1rI2CiQgntSJxuVPAXf9hG30gZ1fJHSxt0SrM3w88JHfEpSXCD7TooXtueX0BpXuH21z3bmWR+nFumqXd0eRsMsPGhtX4X75sjM5nTmEdfKH4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zxe0Je1iAHxH53CEKp4VFaV07OFaFVJ3mnPAp9Sw40=;
 b=tWgjcsnD+iO+Vnmw56Lw0k28AZq3EyTX9NckM0lu0SyvxdGa5LGSuIOxFSol89tKeYIjjDOszfZ9aeRG6yLix5z5E2k/STM42E6tCuoFE/jnRTpoQtiq/mrK4VHk/50qr53KIkk5M2lAdWHTvtucOHnRAFgbxS0MdZV0aMeGWKI5cyg0izP6Y6dRaxjDEiE8pcQ/9oCBht324+MnF2LQceyKWGKWtOTDhIG/FwrJ7+YoP2qXDI7C4Gc8/TKc5ytmZUezqnRZeJI/3dR8YpQB365HcG+46kAkJ+yo8BVsZtfU026g9MSJzt8qKrLmjZCMJwFy+1JVVHDFuisnXmvFCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH1PR12MB9672.namprd12.prod.outlook.com (2603:10b6:610:2b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 17:15:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 17:15:17 +0000
Date: Thu, 10 Jul 2025 14:15:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [PATCH v4 3/7] iommufd: Add a pre_destroy() op for objects
Message-ID: <20250710171515.GS1599700@nvidia.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-4-yilun.xu@linux.intel.com>
 <BN9PR11MB5276CA77E378CB3173CA76888C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276CA77E378CB3173CA76888C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH1PR12MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: 21dbb5a7-0317-47d0-4f34-08ddbfd55793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2wPhiITtc06PVKorc22SNj70yU1SlhFc+6lbYbMgqLWaogT3VGKG/SFNAzcL?=
 =?us-ascii?Q?M66DewSc/mv8BssC+GSrHK28fE0eTimB38ytPy9jA3lDFIv0RxIJIAQgkjwg?=
 =?us-ascii?Q?fTXi5ibOE/WMmAdx/Ueqc2dsP1KANka171ETkUL1IA6Aa/Pfth/+dmzpYM0f?=
 =?us-ascii?Q?zXMqeoh6OaFBv174B33D2c40Dca9vYbfQulAYq5MrIue4VFn+T2xzpoyYoyF?=
 =?us-ascii?Q?uYxGx+qhnOJhv3GGOX2zHTaQdL28a+kQJqM0XIK9Lf68WsOejlCctlnD8g9S?=
 =?us-ascii?Q?u+gh91vpR8Am0uZeFSI1zv5dwXDIzzhLjKyywlBoYd5pMlSLZccV+ZhAcGEI?=
 =?us-ascii?Q?rL4Ca+bPPhxcK9+6elmMtoX0yshE4B2NgAi9uESYS4qtwFQ9QvwI0y3uWDiz?=
 =?us-ascii?Q?YIS5yMy/XJRJ/R9pixDOtcSl246QwO9GcM/sSYEz4+qdIDb6sS+rxLDk9ZB5?=
 =?us-ascii?Q?quSwXud5K/TNb9w57DZvDSi18GDDz/ADSatCIGIltpoL9smUJDvXzZGDG/UY?=
 =?us-ascii?Q?m0TtLb4+elt2+U/k8XggSNKsZSHTygVRfMeSUSFwiPG2QAf3sX8sPtGoPMcj?=
 =?us-ascii?Q?2zjZd/bwCa1vG4JMOwG+TmDYQvm+4BI5rHpza3/iHrdP4jmRrnYLLSlFHMuC?=
 =?us-ascii?Q?XZSKWx7Q+BfrWl9j4QGpgwOYUEE1Y5YbUFgMlJQmP0XVhrmNKuxOIddjcTxH?=
 =?us-ascii?Q?8WBJSANG76P5EK4XBdzdiQWaRjrSYvybp/8/sWE6eQq7X4ryed6Xr0iTFYCT?=
 =?us-ascii?Q?TIkrYUXh5C1LMfTguw7ghr+5lR4TjjaUp9589TNPykFJe9RAqHlBaNg/NAZi?=
 =?us-ascii?Q?6ArRmazHOZF9TR3s6aZRt+HGu/krkGs4YLbR7xZreI6YUXqIpg/jpFTz8VID?=
 =?us-ascii?Q?Ln1kHcWEOvoGBb3QtnEbadPfcMhQqJaJBTmloDm7vxnWprSTg0iwvTmiLvPw?=
 =?us-ascii?Q?y0GiBPv7othhpbKLae0DxGkQaKgGfJFDEcd3QNw3RyRZpWrFI3HjKA/06POP?=
 =?us-ascii?Q?Plx03p7IdY20isO69B4ycTDQHX0XlCl88qt6t7z+FvhpuRfcaGXp8lFIa+yJ?=
 =?us-ascii?Q?1I+LqPxDh8iWL9jnNmsOBP/ICY7FrvBbOzSzlOzEQEcN6eizFgZrFZK6hmlj?=
 =?us-ascii?Q?KSqJGHC87MZc8oVyck/reHF/wS28tmId8E9Y28P2Uy3oh/v0xkDbVaqo08lX?=
 =?us-ascii?Q?weHBy56Cam+Mp2sVeIe+QGb1y7Xp67y/OuyCtYprchIZs+XGB6Wh6grq0wJM?=
 =?us-ascii?Q?V8ApOUGemaFh8n9JYDuhgLSd/pdKNhXlhWS8wM+JtvHjPWTRBoV9/Tj+qyLI?=
 =?us-ascii?Q?ldwJxHz8sde5LzNKT+r4FujYmlCYkIvEu5RYfZNeFaISxSFt4n14DcnfBidV?=
 =?us-ascii?Q?VNN9lbbJO3Fh6YVvx2d2+MjaHKpAPyRhb9u544yu/irfeOLub30IRDZCaXHr?=
 =?us-ascii?Q?tc1RlSVuqyc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JPnAw3/eyhDJWrWL44+a8MPGyK9QFl2TMgCUqoJYEQKrNVhq0yJBtSBUniBK?=
 =?us-ascii?Q?4ooAYxcTkiloSRM5GHLM5w++nCI6L8yCC8OHNsaNHHVDoKqQ0TUpb3P/0gOI?=
 =?us-ascii?Q?CoT7uQHAI9wtd9GkqwB+BchG5V0MYfzg/3D+7WyOzqPuLZonl3crd4DYtYaY?=
 =?us-ascii?Q?L5hv7C8ip1qHJYFGb1/Sfbu8qA8tvWkem77Zzri/PPzpt+IDtkiRo56NLM8s?=
 =?us-ascii?Q?8G1T6q4bzzuU34vgUyQZnxJ5kMysMIq1epujKePVN4Tuf5nrvCK3/Dq//B+W?=
 =?us-ascii?Q?73ARt23hinUNaLAMwbWMTLMNF3HZl5YBH7hY5u/x+dXGT7sELxc+pQLFzKru?=
 =?us-ascii?Q?UWCCzpaOOPgRGd9zo4AsSEiYAsEgkLfHeIqyD6y/7eVBkkY2HNAOqa5xSKMS?=
 =?us-ascii?Q?CmxJ3lA3qaopmxmKKPORF4F6uiC8r+8pEo+wRaCoZzB+KhDTUpLemDKDvXV3?=
 =?us-ascii?Q?25p5PNBtN72HhobUt8LzTKnACaCHkyw18sHfR/Hf1/+aRpoMuzoqfWljuNQs?=
 =?us-ascii?Q?uB2Z0qwpvVC49P8etAmDL2hHxDsv0iO7agsIY5PDXRaoFF4voEOVIeedU7Be?=
 =?us-ascii?Q?96IM2t//j6IN3Kx4MBPv5a+d++cw9AbfetBe7KI0NeBlf1F28POSCVGT8YDb?=
 =?us-ascii?Q?ypOzO6uRRzYjJdYMJO59jBnIbC94Z3Gz7vrFVKZwGq/k0BwnnPokLNzB1Rbr?=
 =?us-ascii?Q?ZTllppjDP3QHWMQuPYZuoJLmKH66BrPIym4hIyTGDJeQWL0tKha2FaMOaOkO?=
 =?us-ascii?Q?MhLLyTZXzjmhVVEHpiM+NlDDdUCVPNBEGIVUMxGCHoyUIIcleYTT+oZJ0lEE?=
 =?us-ascii?Q?7pUMaddaJS5iV3I5GLIC/5OzRdzQqpLj6gBb9pMEd6Q6eJU/7oQGP7XdS9aU?=
 =?us-ascii?Q?VB02V9/XvKGLNyBSmlhJFsyW0l2VLyoSDYWrNadIpwhfF1Mo9vEXxf4qWxsC?=
 =?us-ascii?Q?ypO3X+DqC8KpdmkGgIlGV9Q4NGahNLJfZSFW2MarhQwEjgFPvlPzhwveCqy2?=
 =?us-ascii?Q?3rD5QWlZqa36AsM/rSo83tACbcyEbxKkvgl8/nRBMun/vdaN/yVuTdWR4X+Z?=
 =?us-ascii?Q?IKQcc0VXPeOd1YqOL9NDaHPmIornYh9+zx+h1HR8OtZwX+9469Po+wi8Vkh0?=
 =?us-ascii?Q?gAg66sRIgYuFxvtplyYhO23PO6H+koZmra7P0Lr5hMfARa8OPGTWId9Mv4k2?=
 =?us-ascii?Q?04jfGoERRW4HyUGzRJiZM4k2mN+OvZnOUNpP+7iAKt1Sl0FQHHXeCMNT80zh?=
 =?us-ascii?Q?2UVMGByvQhly9kYq9kNHhoXI+pW1QabQQKLLhPSSmA89TjbMNIelnjDRJPix?=
 =?us-ascii?Q?Ekw9qIY+GYIq/aPShjCEBBL8q/u/FpCSBRT7rSWD6UsF0Z+4RCT9mkPyqPgC?=
 =?us-ascii?Q?n3ZM2IwKINRSVq1vzvYchQdSJpicIy9i3Icw1gFYvepYAQ6nc6CxhsTE43yD?=
 =?us-ascii?Q?ic8wmiAyoBNJNuBnqS4KmTwZ/PSb/Q87L6vzXIivvrv+HaYwSHZMW/XAm8qY?=
 =?us-ascii?Q?YFwqh/WugETUicDAWKs04QVCeq5PhehNWTq5Xv13/pZpP8AuslaBGmcaj1HI?=
 =?us-ascii?Q?VSChUgjzCbIr7w938Ga/RajtYsImz/wEklujZYPT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dbb5a7-0317-47d0-4f34-08ddbfd55793
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:15:17.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A/cbZGmtLNcXdaabmFfUzaseEldv1st+JAQcT9p6E2fQvh6PMr3gi5fBsfoZIev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9672

On Thu, Jul 10, 2025 at 07:40:58AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Wednesday, July 9, 2025 12:03 PM
> > 
> > Add a pre_destroy() op which gives objects a chance to clear their
> > short term users references before destruction. This op is intended for
> > external driver created objects (e.g. idev) which does deterministic
> > destruction.
> > 
> > In order to manage the lifecycle of interrelated objects as well as the
> > deterministic destruction (e.g. vdev can't outlive idev, and idev
> > destruction can't fail), short term users references are allowed to
> > live out of an ioctl execution. An immediate use case is, vdev holds
> > idev's short term user reference until vdev destruction completes, idev
> > leverages existing wait_shortterm mechanism to ensure it is destroyed
> > after vdev.
> > 
> > This extended usage makes the referenced object unable to just wait for
> > its reference gone. It needs to actively trigger the reference removal,
> > as well as prevent new references before wait. Should implement these
> > work in pre_destroy().
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> btw is it clearer to rename 'shortterm_users' as 'wait_cnt', as the
> meaning now is beyond shortterm and is really about the need of
> waiting?

Probably so, as a followup change would be fine if we don't need a v5

/*
 * Destroy will sleep and wait for wait_cnt to go to zero. This
 * allows concurrent users of the ID to reliably avoid causing a
 * spurious destroy failure. Incrementing this count should either be
 * short lived or be revoked and blocked during pre_destroy
 */
refcount_t wait_cnt;

?

Jason
