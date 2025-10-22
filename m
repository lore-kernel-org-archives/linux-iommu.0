Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1128C869
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163216; cv=fail; b=KB1KQtr+QS59LunKoFOkaAUnUExPetlxYEBRne3DSgiHefKJYAh333RzWSAxQRtYIl16ZafitQHRW9nvLBEHZxKWiQTKtynthVyIaD0uVtqI2YQHXLwwL7v9nAtYog9wdzuBNpsAtFQisZWZ5PfQweDKNatiI2HMSc3b6g8FcqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163216; c=relaxed/simple;
	bh=NV6iHpF/Ht6hv35a2d+dlZn9lpkLjaYfSyBP9PpESUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rAdvFmqb+gziFHNvj4MEZAm7WSmGM6w+RiYAYIMH5Vi6Sdswsg9wzUn5GUwNujXPeptlDwDR0Kzpq8w8HUzBOIU1bYD1Jjn/bUOGfmyuDOp/m/ui16u8CR5qawYRyq3fjFORDEKWmM6e4/J3Paw4lW24yvt9Dsq3/Gzr5cr7hIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eGxUMWRj; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eGxUMWRj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHL1wRTayg187V/teUVa/j/35E0TrwBcjdzdKoaT+yTg4NtDYKYG7QzDUC/bvOAKGvi1aXsci1DZEAdg+p1Hcu4doMOJGLNUhZrnVMnIOArM2TGpAiTENq8gifzibqw6TstwLC0fxzfkYdOpGXUDWB3ZN6KFFlgCqLlAOLiHqLWMcZW21lGbA1+vgfV67b74BFPAp1fySXY/UUfMZD95j5lzRC+xuy+Mut/yNI7t5htRe6n7c7gFLzipbJhwnuEPrwkF01TE2FPV3FZbPiuWLnoFDuesyI3+SNOJIqCbIziEU40mmKvFmcYsYjXT9VWpFPBHgroR/Vpr2yTp85mWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snWbIEh/aOZVXLJtxkogLJS2I+eSDtryseFtIxMxlzc=;
 b=embBO4IjrrNG1d+C9YjUjl0t+saBGJtsMksFC6WC43Xc97OvoNZd5QUv+kfsh2wyzS8dkOKUAQNo6F8ypjXUqibGCGTMPmKqXbEff+NJ5cHrBqAJHdjeAo5G3iwhTHBhkco2GZfRLPTyVTg9l8zmNmAb331PUJGPHd1ru1lMm6ENqPjemd5VIK7lsZiG+FkGBhwcaLTdBRTFRRAoc31yzuxEt0XYxO3QZ05c3SCXxsp9RHzSdlCGp6OmhxB57Vch9WUHGQeL8VTcB3CK5TX6IKLg6Ecpvca9vztHSRTFrt7woTMAKmBHKE785JZPkzFwV+z4yFtLG+ci+MjjZpGP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snWbIEh/aOZVXLJtxkogLJS2I+eSDtryseFtIxMxlzc=;
 b=eGxUMWRjZrxMW1S8CcrLVQ306xMolN5aFiDEt8orDHI8yjC2jL2wGfzJAHq+Cj5DjDzTrxk7Y8J/O+wO2XxYVD07nHObf/QDrWlk5MEcnK7Z0u/HB8kg58tLYGkNAZvxMmZhsvHyuk1I54PXwkCBLdxM+0/vBJpOuuEBTn6ZfhtAEPzT63UMfXW83rkpZSmwQcSfkPyxRwZpo0eG+1+BoUVBWIdkQd/YGPjtJiq4xj8UrVI3gvy4X6TsFZ/JyIsl9Amt4uSRX3gJv9UNzrS36yNP0hgStHKpK3Jea7HpehG3SnDedy7jx7zvoGvVf7tI7TBgzNN1regj67VRtLEfYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 20:00:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:00:11 +0000
Date: Wed, 22 Oct 2025 17:00:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v4 11/16] iommu/amd: Introduce struct amd_iommu_viommu
Message-ID: <20251022200009.GC262900@nvidia.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-12-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021014324.5837-12-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN0PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:408:ee::34) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 886798ae-5cab-4799-894d-08de11a59b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x2CWQP3AHd9kyylnKf0pfYsQ4msgM7Uq6fbd3ylIA3whB8WwVh9Movd9TIqC?=
 =?us-ascii?Q?/uETqT8eeK+MWEdtyu4+f6TWmHPgyOCUzJIQFdHOf+/zi/jjht9cmc6g/8l1?=
 =?us-ascii?Q?lcf1XjagaGC+OhfoQvQM1/nPF7Wgw5G8lHqKlXZGa7ui3jrP40ZTiEZSWMyB?=
 =?us-ascii?Q?72NJxRM69hzv4FJWHo9eRCnX28WPgGOUdDMGYBsbIfHjM7PqWj7n89xkANPs?=
 =?us-ascii?Q?qReGbxaGzn2mc1VQYzTT30p+Z+xyiqXjlbTARLBpSjHa96XMPEgd/UlC3m00?=
 =?us-ascii?Q?I59j8PeUu4qWLxTxMY2UqHZ9QvKESSTgzifYcEAJxtNX53kA638N/1Xq+A28?=
 =?us-ascii?Q?FAJe+dqLAyMogj9EcyWjTuSvkXasrK1j9IkDI9k8KysQ228j5nM00C7P0rRe?=
 =?us-ascii?Q?dETfajFHar/Br6bwfeowmHi4z0q8LIdNT4OpgxOkBQH/gEB1MwDiDwkDX9fD?=
 =?us-ascii?Q?RZLWz6E72BADH5TCM3GqEMnJCBEq1UvBBX0OlRwt4Cojb4nRx9+kb2LmytzI?=
 =?us-ascii?Q?OdGG9gp4WPa1BBEdV1cmQEEnifAbtHozr7czlvNw9RA321Ep4sbWhsRoAZUi?=
 =?us-ascii?Q?XIyi6Q49V713EabFwBeXvNYMLDlddjNHs6O/CBPtJJRVuTmH7Y27WS3PXnAr?=
 =?us-ascii?Q?PriOBGprdJxDlx5ibRi7PFKRThTm9OMBZ79MExa/sfWFTmITesebHd+xwoyd?=
 =?us-ascii?Q?ILYO3PtCsgFxHDZuxtz8Nc6vhm6tL7QVdoWOdOgxLy212BWm9cLPqnJyufX3?=
 =?us-ascii?Q?zeFhJSLaG9eojJK3HJXBTKlA+ph6LnO5+WBuktXYMZ3VPALMEa+w2sS7zMuj?=
 =?us-ascii?Q?4XLoYTDwbRSO8dGkD64ijE/xdhzDmyB/ZgVmidbRHetbvnP9dmgAEmdZOi7K?=
 =?us-ascii?Q?IY4bn9P0BdEiyMYdXcY2kqJVkHhluPUzLRhW4HcRCGeT4jv5GOVN4H3m2KjI?=
 =?us-ascii?Q?5GdpMsrkPIjjGjMzxVCbeHQjOcGlBXsJ0K5FOPj/UZ1u9/YNx+lhCIn/+4RH?=
 =?us-ascii?Q?KQxzkULgkhFft52UHIDpqwATluPrfDzDf2FzjQl7JENIeOB2+fqbvWbHj6Wo?=
 =?us-ascii?Q?tInHM1ba/zc0Dh0n1Oc+F9QuKDciLkiheyLK8JNMifnGZGi3H/k8k1qiC5P2?=
 =?us-ascii?Q?oKm2y2AKZW3HnjLCwvCzwUPx75dV2F7r7+NhEfYTe9f+O0o0RUr8qxG4ijfB?=
 =?us-ascii?Q?MhMattlH7j+cBTAgjEL0eWWTiRHnBtaJOlUacY25bB3hQdhmWwvSfWTy+st+?=
 =?us-ascii?Q?vLlXerbjaZmbsvhUVQpWOY+FP3yTRmHm4s3Tub8UzbGiAXLQwcfoLvB04nX+?=
 =?us-ascii?Q?FcA09f7GNYIlN2Q04eOaj6EXbbtD3LOVZweLJNsFVAO/WCTLK+CzEFfi+n63?=
 =?us-ascii?Q?ncG81vnuz/tPuSphPiHaKH5kEfmsR6SFkkGk6fqEXx+o5Ol62tJ13g9JUiEy?=
 =?us-ascii?Q?B4zQv19vN7Qm3SM1mKO6CpLgQlwmAnb8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O2qaen0SVJMcTF6nVSrWAVz6J42ajyiysu4xJOsoORjXEtv/cVaKzw5oXRJ9?=
 =?us-ascii?Q?Q+E0Uaom1n9iALOMmX9ZpDRmM1JGiRz6uP1IgGJeoawJXcEzffm4ULrN/mal?=
 =?us-ascii?Q?SmhEdoTClKQHfzx3wsnK9YHoh90CwgnUulu/+vx8QEG5RtsN3PixBDJQxhT2?=
 =?us-ascii?Q?RUOtI6UXDebzSjyLSvVEIvQN9TDw9eYytPXL2PBkgbo5ifc2qFqMwCDLn3XN?=
 =?us-ascii?Q?j+HLOoT8H2LUCzR0+7CiCDxxkXokbzl/KEVAHlHPeHTDIGd673QqVPmK9VU9?=
 =?us-ascii?Q?l6kIdovS3R+4lrrT6FChyH+X8S8Jpts59OWzrpItfRIJapTWnfwDnlwlKLZm?=
 =?us-ascii?Q?CNxaZ5U4HnxsfWRcQMR3DX5gTnjv3Vqkztj26o2FpJ+T8aorFS8SOsKN1JAK?=
 =?us-ascii?Q?2XUTOufzCahZLkFKpWGuIV94dV+dWfUCHicVAfAWXYzgQ+GSX+DilKEyu1v4?=
 =?us-ascii?Q?4It6Xd1Wv/iQDn+Li0UOlYkD88Jzg8VoxCJKyjzkUDzy4VGxOj052n7GFtcQ?=
 =?us-ascii?Q?pKJ0HlSblT4SOGwy0l00UrRNSPe/DF9X/2Jw30aKTVLXF2vmVaGVflAaF5SB?=
 =?us-ascii?Q?DmmI4BT3pxfugFm1IDO2/bc9kg/CqCJUXPPGKzOeFzfCs488DPceSkNdP246?=
 =?us-ascii?Q?UwSVHDuPQ05/eWbZGQ5UvOmJRbLp+5+swBJovFoLGAhFKZYZXwUl9b35bsG5?=
 =?us-ascii?Q?lPq6ZCEXQDyKlDBoieMtQe8YDNz5lditBk3RzsXl9tapJ2sXRMajr7rIGiTK?=
 =?us-ascii?Q?7Yg7zVbRagZTFPbM733izTWNCQa7Pu4iF7gKXB+HbaG+xH4zyxRM4mldd4Zn?=
 =?us-ascii?Q?JlGtIJ41MMlPzvQOBFQ9MlZxZ7r7VHh6CX4mivqouDVgUKuc90jt21vMrPEI?=
 =?us-ascii?Q?gOpYDQ0vmYJwbbEZ1ZG+sNuAFP6pGpUIFUe2samrb3ubnjIkF+yB3agfpeu1?=
 =?us-ascii?Q?gBpWYEwRF0l8Z6KlAQHmXvlQpJMIgSj7Sv6/zLymKmaDLjBBL9Z7biaXeUvz?=
 =?us-ascii?Q?RN+F5oIcKZQcmhuivrTLBVQ3adMk+FLimgNWNyKE5vQFlVTqLWOu4cDaN6Sx?=
 =?us-ascii?Q?aHlWqhu610bA/S/oNxTLSw9jEShChUZ7g7cNLzreguj+Z837+kTgJ/lY5qR/?=
 =?us-ascii?Q?iTwbYdqYj7V6dgujW6pThpQU0WfRYxPLJbAQ3YTSWDrKnPf7M8KTlK2rgxcL?=
 =?us-ascii?Q?proE9A/Bg65YHuOYX8FazXoOQjCvMWuTsoCJ/kQuyMqxMVnTB/Z16Ma5S6jL?=
 =?us-ascii?Q?a8OA1GxYDKmhQ6EvwWH9gu8wgTm63Si2XF2clBAwl3iZgq5yvIxPQ2N2uVx6?=
 =?us-ascii?Q?beG6Hzt/YOWO2N2HHERqiOjGotC+kaGlJkx6PwzNsnrC2K9eb5s8qJ7JJdre?=
 =?us-ascii?Q?A9ybTSKr4D0SheumwRD6kYR69gXFhfuYCGC43XaymhCe+dSQyGpv1CdLYYJk?=
 =?us-ascii?Q?jMqURHUXNmoB9QBU47hlHFcdUbBpMRSK1SgL/keh7AiaxJSszll1OVwpD9+i?=
 =?us-ascii?Q?r9ixovwRzJ/KzLlV30TMUPZdRjlrBtOeO17FC0if0o/Q0h4x9h9w6mK4qbdn?=
 =?us-ascii?Q?DVgBcgBORGkGc7tL8es=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886798ae-5cab-4799-894d-08de11a59b81
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:00:11.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGgd4ZtNcP0oOOSsj9vQYA/Sd0NdrhW5e561jEGWTZ4ZCnsnmHdxojpKzvTiU8oW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282

On Tue, Oct 21, 2025 at 01:43:19AM +0000, Suravee Suthikulpanit wrote:
> +int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
> +			    const struct iommu_user_data *user_data)
> +{
> +	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +
> +	/*
> +	 */
> +	aviommu->parent = to_pdomain(parent);

Drop the /* */ - otherwise looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
