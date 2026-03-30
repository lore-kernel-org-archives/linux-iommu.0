Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B4309DB1
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872957; cv=fail; b=j69PU8ZSJVr47LlIZjidX79EgFMeM+16tzei/PATFdyCmz2V7kFXyBtLu3q6+S31+lXnra8wcw4hVz8En/Jt66//qGAHUfrDuLEUop0nwnQKkfrZ0Ora30oyRmegZFOQ+hBkr0VioE/ysw3nwXrMq8ms2ZsPY0UesKpsWCnn96o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872957; c=relaxed/simple;
	bh=vPhjwHRw8ZbGwmm+aMd56jXl0WfB5fySI8baqf3J7Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SLjnzlY7hIt6hTYS00p8xNUViVTjJRtGH+5sWkgq2veekNRef6EaGAO/FpOtM0zEFUzfaQBUH5dfV96gAg5phIG6fAgq669XGCQrIltmEVjnK4gfffm6LwbihvI4fl41d12ytEQMlTuFZ8dzR8YAsoksIwKKB0vDmIlm9meCBFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rpx5h8gk; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rpx5h8gk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sje78eszRPngU4qVWS3nnyDzEz/0vRnG1UYQL4sIkFS53bK8+JjP+25YO6170boKryBbLGZ/qHKwO3nJAzJC+llI8aYcg2oNFt9s6Y25eAN6mM7HR2OjMTXeMSGLZZofrp7pA41/KLk9wdHcC6R/hNLrJupROyU5k31zvi9ZpvmTpD7kfJspSDum+xalbpr3Nq9ZHzWCuXMzzEyePB8n7MQkGAvn2xLNeq7t3musf/ruw5sGugNSr7NkJXf/JbYktTjKfEUsVY0w52x8HwVOTVZGRazsIEx1WAcEjz9ivLcLY22dumkFvrKHTa7OxsAJh0PqHUL9fP1qxUGeDJC47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPhjwHRw8ZbGwmm+aMd56jXl0WfB5fySI8baqf3J7Hk=;
 b=gqWUBDnAan+xYIQVzDePYaJTtxT42Gd1Da1BFBaDeI8dgSou9W/5+fF7X/ZFWD50Crsrf+MR2mbkK0xNjM7sNiSpjbwX/F/skF9BfIbSkAgoAkl8adb4BJuw/CA16qgTRHSDiZ+DvPyq1bGdw58o3b0k/rhpfg1ZXSF5Fj32flocnr1W9r0SS5/SoH93UFtqsOO8796zJ9q1OyIRAkRC3jg4pZIy5snTBHai+zjrkE2mJ3hOpq70CYhpRlZH/ovx9UTXeCq68jLvbxihApR7uz9VyXYvFRUqAy4Ovr8JvpG/sStglm5kjticVuvTiPSdm92Wv3Lro/hTnWk+Inv/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPhjwHRw8ZbGwmm+aMd56jXl0WfB5fySI8baqf3J7Hk=;
 b=Rpx5h8gknji78Wwj9jYmyKTLyZFmHp0Mu5nY5oXVc/9jSsmewouk6WN2D8oC5JjJeL5/cl2Csi2o6tXZ8h85wTVIdVHasALHYtROPloRShXFxunfSpGWj7ByFkSlMB9XluCtIrh4tTsmDIyuZZ0be0anfkH4Gvgo8sVNpdENzTKngbU3Ka4tWVsfwpjS0G5m8UH3h9vg4c5TvuJh1gdc8udHFKoEecKkruhDsj1e7v3hTkO3w20XIZfWb7RfmMc3nkHS8bKTUPC0L/ym8woRR5s15iRKu5f7oAPMwe7IpPtYxjU5Hj/WCF81IQXzWTsXbUlRCvuQhwLmVlsWfjsSPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:15:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 12:15:50 +0000
Date: Mon, 30 Mar 2026 09:15:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH 22/22] iommu/amd: Introduce logic to check and enable
 vIOMMU feature
Message-ID: <20260330121548.GE310919@nvidia.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-23-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330084206.9251-23-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1PR13CA0339.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: bdefb2cf-5ab6-4233-9970-08de8e56147c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oUA/MS/z7D6BfDLMsYTmh3nmJ4ZtcV0WRvkWixG+Ex6DRHd/n2zcWu8OwyTVG4M65uo0pIkrWrOUOvGgITv8MZTdJ0A6D/k3ZvvpcV1k9M5UpsVOVPSaddaSo48cy0ahmXtpTvEBZnsb50VI5Bn5HgHfOZA64m8ty9R6LZOdiYXEf6q1NbCm7bhbLAEHczfWlvjX08S3ESacPtlq1RN14Xn+Mfh8ItS/QmoZkwzk/tFE9pHC5UOW5CcmkvmIzomFte8ZMcvhhZJ0KoelnK4lh14Yex9jawl+0TYFPBPdyDwQUHp5M8WBoKYEX9azD4y4yoJyOwqvNj24iRpyk6Ck+5sdlBb1Ew6n+iSdSaJwKHxKmj8fBx4wuaTkGVG+IK67Z9OBokqvQIhUvbTzTivcTQVQ7V3NAi2wxKzjCg0p8HZsox5iQDD2mfGYEu94Oy/ShvlKFM5uGx7ck5kzDRhKom5r0e/A0ozVngw8RG5tmMb+Zku3SBdYZFq/Ku5DFLO7P41Uuie46QMc8GwcPgDrplJAlmA6K+U6KbbbNrEgD8FX+3qZ6iirTiB0SldRFsW3RWStbxWI58VFap0nPnj9dmJkgqacTlFvHUqZvrhwkKn0arfMrPJ+/HpYngy+KCrLnBMI9pbJ6lZ1F+Gl8kWK4M7D8H1fo1g6qAotAhEPuoHBq86oIXknwV0iPc2ZBV1XBbeXunlenr2vzACvmD8g0R16rI7iavlH2QbXD5tuBZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jo0RW/UHNrhURbuQvzZdkcJ6oZnEDyUbCwDT4X2iCpWG4ASjlvs3FKAdszeo?=
 =?us-ascii?Q?mzRqI2CsehSNI59ry6Tteej/sGSVqfbj47p6GpRocrlvbpi+KOGNJSlvOY3q?=
 =?us-ascii?Q?xM3vVOyPOhq4kt2q516C6EB+da25gibaWYb0rbockFIbq3uWa/yVyOZw6/yM?=
 =?us-ascii?Q?nYtWEoqu78o4HjN8MGh9djjJKe9AMK3eZiCSiVVVXCTW3LoQmGAkGZGP9Mo8?=
 =?us-ascii?Q?XFe3T+HMiMrvRI36P0t7Cj4tREPIGZ+RHF99LVlAgNQJsrTylrm6dULrRCvq?=
 =?us-ascii?Q?P97Im1x8bEt7v004b3xC/XtezQSpP38+pnO741hWKAUxvmqq/0p5jj8GBOrm?=
 =?us-ascii?Q?JS9b4WqWq10nxiZGhbplbeGSdhA3RP/uCukt7eHyhtk8PT57PK2WOcHquZc3?=
 =?us-ascii?Q?th5fuyenMr9JkWUJq2N3O1Plgwh+beYcx7pj7HTJS7a1IvjwyhvFPIcszWXR?=
 =?us-ascii?Q?27GodcRo0S2db7LcXw8xsvXBu55zn+qnAgtomY2Q6wUusAlcgtc5L1GZbkoP?=
 =?us-ascii?Q?P5d7c3G4Rr1iKZlQoIIGjnp/uTPDG+ACwvG/TgSV/PQ3f2UXBc1USTpoSKG6?=
 =?us-ascii?Q?J+eTmJ1U9HB6xiiS2EAmg9ceXpT16sAZNISwll5jPOhtolLdRTTjfI2Wl/Y3?=
 =?us-ascii?Q?u210D9Q/0uonkP57ynxN/ZPUtZzSXhBXtJCbbFSbIKQAqdkHrf4w6doLUa3V?=
 =?us-ascii?Q?PIrqmh/Zxs4vGWghVQnFRCKCAd/7JT+O180LbeDDZWppdN5CDJhXGbsTeJ+t?=
 =?us-ascii?Q?OL0nkbl7OA813NaDsUDDpL+Mc8AdvPie3l4c3qrZNV9Yq1Ei0j4BgiS4hxSE?=
 =?us-ascii?Q?lMcB2JsgjLY2Kms9IEQ6J2gWjzUczVjR182VOhVFtvf9z2Wil3wbcVi4ixVm?=
 =?us-ascii?Q?R7phFntEfjMzRAoW37QZRG44iwDp0OYZunStkWy/AZsHCrFRQdOt77r+mMEl?=
 =?us-ascii?Q?vssxVzLHkzGwt1ldgStBRQcfNF93m4XUmbBx7gZNpAj47HmJOUTGKXu2Ovts?=
 =?us-ascii?Q?YqeUUBxTvO2bBnawtxz52S4fiaxzDjkaNK/ssaaB3x4QJd064CsGuha31wO9?=
 =?us-ascii?Q?vTimhZfj+wLn4UxDLksM2vO7uz93y7CI4W9kVOT8x/ExxO6kVNJQop5VcrV6?=
 =?us-ascii?Q?+Bg4BakgjPtu92GqFCMiaFVag65wScEX0mIkaNycAyVpwurHpk0AgdEzZen7?=
 =?us-ascii?Q?ep5U36ZO3tTXTs28DDsuC9WCDSfjo7n3lmtY3Fh5A3Z11z/oVSjQP9eaxALw?=
 =?us-ascii?Q?cC9MpCMpSnWOXLCzPJ1otvLWp7aFWbnUiQLRhnbFZ8PhapAvbSt9LNIbayTH?=
 =?us-ascii?Q?8Y4+Ee14NsXmtxbahusY9TLY/sh7YMTLXwua5YhIkXyKgEuvR3r37O+bvXiI?=
 =?us-ascii?Q?UGZrup4BaIXzK7mQ9+t59a3s3PEq9udovPYkwGAdB7GSSOCDKi/AvO7kR76y?=
 =?us-ascii?Q?m42HLBgjWXreYJVS8u4L+vP5lAdHJD7QgLkfZkLhILQMbUc/M7a2pdMRi+kX?=
 =?us-ascii?Q?LSq6fAiup4mfDPr5UdXZWA+SzjjB5JswifkN69uWE9IRDQ7jikxvKp02j0mT?=
 =?us-ascii?Q?sZP2eRG2fyH+8Ieqsqlb0nMLW6iw5d/h3Twe7Z+QbcFx0VnMr0Rm0IVQdqxk?=
 =?us-ascii?Q?Ab3wspwG+F3MYXqfP5Wz3ryNz3fb7H1H7U0L/Zylx3lMLB+M+JRAEi7SWm+3?=
 =?us-ascii?Q?aJo0j110IUIR+gMNxEDUmTY9yOuAU0fXTapptEYm68v1Ko0A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdefb2cf-5ab6-4233-9970-08de8e56147c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:15:49.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zmGZt99HbZeh1liaxRLfNEcA30hFoL+wCvRRE4rN3HbibILZ8BHv8tR2Ory7Gxo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

On Mon, Mar 30, 2026 at 08:42:06AM +0000, Suravee Suthikulpanit wrote:
> Also switch to enable vIOMMU by default, and provide kernel boot option to
> disable the feature.

Why? userspace is free to not use it, lets not pollute the kernel
command line.

Jason
