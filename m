Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3D367
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 00:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442409; cv=fail; b=Y0utquw4SZhP/ve2eJjsY4cVCxhwXfL/jRxOAJ+2r30ndnw2OfUH6iXy6mMJXfkP4Feo4Mor2ujXjKPSzUrHrUL7lSs9zO0qt/chLa7x3pS2k0qnbHRL7lzKIfb8ye3IczFKLhkZTKnhiKwIs+w6yRgG8f2PmnJrv10UJspWJmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442409; c=relaxed/simple;
	bh=fBgrY0f3w642g34NXNxuEZt0feVKIwCMbZHZJDVZB64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=McEhIHyIIocrKUE9Fww8G5ea8/NxMPPJf8QEWoNPgPLVeLius5T+2bZzm2DHCo4c+FwVKfOLka6NpPsK2Zcgo46IjmD0PUDOgbiAlXASpnPokBbhhgc2dhx8azwlDZTKMx2CrtoV+bWOQlmUl83p2lpA/JeIblbHsF5vadO7wy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jCBfPzm0; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jCBfPzm0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2Ctj3mJHAIFheI+j7ZHm9u+pxk/15ggdGmVvwXcXcVsOxjb/shY0PNCZHPS4FkUwk+IOQV+1ol+YS2e+CG4Ojiy5gbWaWChA+KCnHdgI18zmO+p9SuyRrTPUnTRIBuPG/JYJX2X3Aa69BDkKm8fiKKn8tIsLK4l3eytnmanlNCL0U4L6+CTMZCxBfy1It5ygb9KN0B7xCVgV6M0xdUtXUcF0ggn3Y/aK+K+XZmrVFnVAk12eGEaLwVfvUWnvdChM35stOixreQmNBtUqWWJGD/TwkEeJaSbJoisVPCamBZFg3h4ei8oJCi+OPCA/OyDlmkvzgF94OmPT8Grhh13Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5wzaXDznx+tEMds7iEpkxLkNqdD555vLNYrR+ldh8U=;
 b=AgiiBrcbCh7UdMR3Q1EvyMVK7N8bw7Ylst4lMom009SB5McDzEjWRj1V8Bcg4PvRoCmclrSDIKYxX9z6shJV/OIYY/jFZSovvftFWd/+JngNzEd4IngRVWF5pfTGh3FkDDx3ROhbLoxPXOu2CIFimAcFktuM0ZV+LHt49sE4MNbbl9ZZQ25pBTXXgqIbrjCngDF/bw2QhDeRF+PebAVkwgyzz+KF5KoBzlb9L6k2POZjRhf6FljPTJKt1RlIouAXVcDrrqgean2GZMi1fEyZu4rHXIJ0C8/mQCAV6f0//Kn5Y5MolO1A8FgbalNR41BbpVuZc2MkypYWq5o5B8EaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5wzaXDznx+tEMds7iEpkxLkNqdD555vLNYrR+ldh8U=;
 b=jCBfPzm0nXFg4YvhNAYPtPr4OOqLFj/KP2tWUkuHluWsaOFdc4luQ9fV+rWVBxiC8EvGWnzM0s9/8u172GY7oGWWfmfRSSJrKqHuZL6lLiPA9GPgbjisNAGV+/XO0crWrSS7rOlCuZ7qufT+/l5bdANAjgVY4tdydXYeIcx8huW3+y1pDN3MpdtI0O6HyAOMrmb68bV22b/W0TrLby4dYftvLHr+2oWYUrG/r6nBDNa7WMh+ToGoAtx/RAlIKhAkytNf7hWIII1+43OZ7OLL44/0bQZGH7ipADhxnVqE+D/MkgBce1lq7nMqePdekoCZl5zn6+wdjB2hXIoD9Z4Z4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 00:13:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:13:18 +0000
Date: Mon, 24 Feb 2025 20:13:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	robin.murphy@arm.com, nicolinc@nvidia.com, will@kernel.org
Subject: Re: [PATCH v2 0/4] Misc iommu_attach_handle enhancements in iommu
 core
Message-ID: <20250225001317.GI520155@nvidia.com>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221143335.49874-1-yi.l.liu@intel.com>
X-ClientProxiedBy: YQBPR0101CA0175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 19468ef6-ebff-4768-cb91-08dd553134d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x2CmPQPx/gID3WnAMhYDBcJLxBFD4m0zobIu+szPjwqvG4XXcdlNApVKqaho?=
 =?us-ascii?Q?gQ2mVA7ZWTxzpdZONCirCFstdRq3Lzsj0IijL3IWae/xAU4ij4Ayr+/AaEFQ?=
 =?us-ascii?Q?u+0HrBxFK+vC2LWHVvVkNhOALXi66CNFLigTBKkSviOQhvv9PSozX9o4EeFE?=
 =?us-ascii?Q?TpGZVcMOBD+v5hv22WsHoYVwKNf5JqaRqWD2B9CymxeYIrX6E5J7Mkzrl5Jy?=
 =?us-ascii?Q?6V8HcDJ63G/iN6L6/Fw4vRbGKKUEzvwW8y65oXIIvj4J5Xhu8LhL5xjpswlA?=
 =?us-ascii?Q?eywtG2XEnpn4i1xYU03vm1I0oKhQfxbyjfxTXGXDBe7TUWzGsZJW8KWMm31v?=
 =?us-ascii?Q?uykD8k8uyjvyBER64fX8ce1EpeyXE82107O2/qq6UygzPfWLGRCeCLHz1I65?=
 =?us-ascii?Q?hvGFzbcuOHLFXCO7KdAqJcuZTKykPxGo1eB2s11ygnZL5V0v8rMqE2YR6Yh8?=
 =?us-ascii?Q?7G3XMMHGXIZZbDA5wm+g0Tcmk5JCLoXlYLS2H3JsTqgyqX+8eoYG6wM36vbZ?=
 =?us-ascii?Q?kbSkDbbR0oe9GLqVfo+KKXsc2rOsiolqvrV/OJAwPG5SfLb7T7gHHEmS/RFe?=
 =?us-ascii?Q?JOuxrka6HHvDMEnpvNofYqVkIzvTSvvGvY+fXZVdOjJCfc5bftCeocUKqznN?=
 =?us-ascii?Q?pYxqQwYC2w/VZ9Nirw3J1lqGXbyWMRB99UtYFbTxiYz5X96prz3wGhpBxia4?=
 =?us-ascii?Q?J1rf64Q5GOU0f0GwFEwpUk5f7uaTpshsKus/GVCBwgN6pLqNY9A2/2I5EryH?=
 =?us-ascii?Q?IPncsBCzSkFDOsAqyzX2VscGHdBayzbyW5MojLhCSirBw0DTt0cCfbjXzaqV?=
 =?us-ascii?Q?zAFyLD4iCVYYM4pvwkYP5wJYbvtVdHJzxP50y4thfM6lKcT4DTv2ndVAV0t9?=
 =?us-ascii?Q?nyjaQKriG7KCQ4xLGluOqwFnNrZ9UZUY0pWCuCN64N4vn+bVlom8zpdtOqby?=
 =?us-ascii?Q?LU9bLaA0BIh+hckvrcbi6XUSEXtFWdqn90As4cNsa5i73siTkAEC6ny2jvX2?=
 =?us-ascii?Q?AwYwbipIgjyQmDoYMbX7Gvqj6tvhqcbC2o6b+JOR0k/3Q8Indy513DZNgiyy?=
 =?us-ascii?Q?9QsDS3riDgpMKbz6Fi378OOfy4SOkFVjVoTC3tg9GGLK0SYTMsjtMFjqgpky?=
 =?us-ascii?Q?VRvKVBUbgfmovX+ClKW1qesO13opCWuzjO2idVCnalBFU2J+u7psZagRmMTK?=
 =?us-ascii?Q?5VKNcZ7RYZAGbG7RA+Y9xFVYwsSqMelXXKTd0DfJ+4vR1yFdG3so7dqxUuG4?=
 =?us-ascii?Q?8yQU0GSEGWIDRGOIiYkLXDpegEj68mAqN7ef6WtLyQXOnvZf8kwNWkvI+W/n?=
 =?us-ascii?Q?WkhQjM2sn1kUCbExAdKjDB8kll1+fhxUmf+dLvd+DV95EOyLnOJZlDzHJuDD?=
 =?us-ascii?Q?zTkMwjhFYEEP1KHq2LJSAHyoBm+/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEmwUAUU5cGvWCkY948XDvwaTvwPuM8HDnzFU1zFi/svv2peVBhuUoWOApP/?=
 =?us-ascii?Q?v/MPf4swVeR3arsH6VMJv0990RYpZs2nJRkJb1O+SiVvCgkV0ahd9MCqqDS7?=
 =?us-ascii?Q?0QKOkLYQFEST43VdPuRkBkBE+dfpyKMugdO0jFafGW+jjqR37qjtHouqEORy?=
 =?us-ascii?Q?Lr/30N43XtiUc5yNvvO/m7L5VVA7CbRW3r/O5HnHMIE6okRCsVzVFbSzAFQF?=
 =?us-ascii?Q?q+8YHO5WJEkTjBTJDqMTmk77NWpgS8xBxGwDVWDe5CKmMTLa30+1pmSeZj8t?=
 =?us-ascii?Q?I5LcEtYfx6RV/9DO+MKzEPvtmzlVtR23ZXAh5GlkfQHNkn72jF3YMd5I6zW9?=
 =?us-ascii?Q?+zWR0r7/igC5E0na3uxQAHRBAjujDlBKXzQOadbZwvyOAbfDN6byYY2YZM7U?=
 =?us-ascii?Q?JO74oRuesc/s2LuG/rRTd2A+feBMqSEH4oQM0eCZkEwMSlpwOK6Y/q4XGVPX?=
 =?us-ascii?Q?+d9JODosV3XBkHG9yZAe2wMkstEgTn5/4qZiKfpUOmble4oVmcdpL3Mw4A/d?=
 =?us-ascii?Q?aWWvY2PbkhGD9ImsMwg+JVP61xXGcYGB7H/kgsy44L2/NpRBc1pyAlTBQfhq?=
 =?us-ascii?Q?4wDe4CQiTt3JWGFt8bjMb1yVUosQy0XVAdFYTILHkZg2IcBCkfVEFUkTnvYi?=
 =?us-ascii?Q?z4WGOrwG2hDG+jyHPNz9VrR2yG8k1lt8fkvYL/dN7rZ6dxd5FJMuQ2KLnDJt?=
 =?us-ascii?Q?QLz7W+IttSAskLU+86Vt9a4R17pczbrEYafTaHYkz8rGCVHyuw+UWmL//tDo?=
 =?us-ascii?Q?EGtO4QXKsf4zzaihc6BLLnB6AnNUqX2MY1CfQ4wliDwdN8cRWDN633dd5Lci?=
 =?us-ascii?Q?1sKs7rSYwCJA7dMniGML4s4QKx5UU7V2yzpTubj+QDJ+gjC33h90YxSwYSlW?=
 =?us-ascii?Q?YoLiE+2rhGV3CJQw/HqUNP1/LJvyyI0+Ysp8ITScy0N/DsxCdPkWW+FlCBbX?=
 =?us-ascii?Q?+l7+KPr+NC+32ioyzSez5VLsFRn9JNkS+uG/xhAMY5FJGXHAL6sOWAnC9QHZ?=
 =?us-ascii?Q?L1Po+QaeZb3E4NgeGep14TYSXPEefYPyF5Gauw2FoCvIqZQeuDzdO/lsLTyg?=
 =?us-ascii?Q?t/tWs/E8APogOSgkDinFA53Hfiet74AvEMcp9qDeKbxGLiR/5Rj+Dve686Z2?=
 =?us-ascii?Q?Mqah/vi8RzFhB7qR1VvdyQbCfM0bYm4pGISId+i/XqNumhlFLP5mAMd2rewk?=
 =?us-ascii?Q?YKECDK5PbEb3h0M+xD2e9xVG0lehabrd0WQr7zSWoC+lNsh9WOLA5MAe3Np0?=
 =?us-ascii?Q?8/khebmyMEWDVAMtkzBnn8GEJaRGG116y1XuxOXnDqcgYP/0syyH0ttoPTEl?=
 =?us-ascii?Q?AnVt6XEXY7El7v8oWFAwTQoAzcFKb0eAFP9wwh8n4nqCb2A5xnjslVRbkgR6?=
 =?us-ascii?Q?WnV5GKbLOOTJdib7tYpiCnI+XI3jXfHmiuucm8v6SeX/ElMWL2StbOGesxfw?=
 =?us-ascii?Q?nzDsodDZeUHbhXzoZt1Cz4XtnQcUFZ3r9iAVR6inkgyIL6xTRttoi7R4gD2P?=
 =?us-ascii?Q?gBM8slblwB2mrvVXLIYzU3smQan/oWxcGGzBVGfw3O5HLNBWkGO8X/zi4Wzk?=
 =?us-ascii?Q?L9fByrEHzrZFBbW0Os+IclMUBQZztughQUYiTQaG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19468ef6-ebff-4768-cb91-08dd553134d4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:13:18.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4uKk3ZRc5FGvns8MMCZvBHJ8CbBzR5xaydOOyKnQ5EmWwP2y5rZVRJibGwDQgsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

On Fri, Feb 21, 2025 at 06:33:31AM -0800, Yi Liu wrote:
> Yi Liu (4):
>   iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
>   iommu: Drop iommu_group_replace_domain()
>   iommu: Store either domain or handle in group->pasid_array
>   iommu: Swap the order of setting group->pasid_array and calling attach
>     op of iommu drivers

Joerg, this also needs some of the iommufd patches on my tree, I can
pick it up and send you a PR with this and the MSI stuff. OK?

Thanks,
Jason
