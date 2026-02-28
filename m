Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F6253B42;
	Sat, 28 Feb 2026 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238949; cv=fail; b=ShnubTh9gPKiuje+qW1Yx1i2NWueFitS1h+NxgMYLt2ClFf6dSPOaIWhkGvMzLQ0K8T4SHdZFRSyS6wjKOx6LJGsnIPlCr0tB0QXEROrMNjM46vX7rVnZ+mhbNcp1xZkkae91ioGim/+6dSMaTL2ugLjsItFiw+Ke9/tSMogN00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238949; c=relaxed/simple;
	bh=Q+vYUx5hvVHQgXFWMl2+6jtbTqKjQSLz9eTdY+qNthM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/ojZWWL8AX20OpnEsWVtumH9JXBxzonn76trJQ3G2GDT3LmTPADjPUmB7InpVB64ZgbEzcRN++kRuXqkZb8bePhErgd4WeqKarrUgHmhW8qzwnNNc+6ky80nb1pCi1bgYy2a+xd0tBcgr8MT75gTouJX2xGaWviK9YvUSrjHRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nig1pkTZ; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nig1pkTZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sw9wu4qBSfHeHOM5tb6mufxMmeAPCZTX5+kBFXNzYgmNgwWQuvMpTD08W5husg0P/aoIAUsW2vl4O7yCUvZ0U3Gdv+YqkPxY/hfnBhhtq4nzYiewUwlMllsz4+Kknd3WklscG8F7GXZeziDVm98+lfzEHAgs30r7iJc9udUw5ifEvj1jroJFNke+vxKyVILOKWjZAy/L9S3jWI2ut37KpwONuatXLijXjF5P8WvuB0gPEtBVw5U4eIyP18+gzDxX1bxcdLC5u5N3bCgRE0LQaGBk+MwtBWL6i/03qodu+N1TJnRq2xqzzzbS+FbKSZWsBWXCmz+g25XLdfQjW089OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whGamjcg4xBmpeXxtA2m51oN4pnyc+eTcQOz9hJKTiw=;
 b=TS96UuoY328vJNriaqbpRo5j8EF8gDms54zcVBAw9tfvmwAAetf1NTk3hoKPZX9olJYo1cdv0eOaElZRbnlm55DWXiszGez81y/jmx4r+w8C5+nZZglKgW+C5CocHn/DyQNgeWyO1Chaem1fD6Cz8MvqtJqGj4877NxDGeRV1ZufHegtODyyFb4j6BWfQFRDAk+mI/rnMrYKS2xgBgDGI/q1RdTrbrFLxPgXLmwxKVvsU6tp8Nc2d3Msi2/QhiqPA02X6mDazJgTqmGiZVXrvNvteHK5pPMvwd7IaJ6aBXtJnjLvwvjH+zQ2PlMtFqqCDIigaP8la82u9KjRlR14BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whGamjcg4xBmpeXxtA2m51oN4pnyc+eTcQOz9hJKTiw=;
 b=Nig1pkTZo1VzxWold1v9NkwHvSTFfsonAK/B6HnaQuNBsKx1ylz1pQ2I6hzMatwR16wCVUlz6TJ1lS2MXqGIkWLodoMChDDUjPQdB5bqGw/U4DhKMzC9juABC0b/aOLVwJr/29AtC6fbsmkO0ST+Jvoep1XWB1GNxuO+hb+Igm4CfwXe5i6jrVd1SRS0IYO0TIhyDWt698obuLxz7KAfsqeE/YgfHpwMdxev3yMp9IHjOPID7o7QX5JlRCLUhiTydwTd435/QerYnJllkNiOf/5gtne+lBWTMaC18myOZHGvG5Xqd/mA/rPZWwSxR4KSI0QEzXRgGkzRWowZ/X/7Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 00:35:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 00:35:41 +0000
Date: Fri, 27 Feb 2026 20:35:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: kernel test robot <lkp@intel.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, oe-kbuild-all@lists.linux.dev,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 08/11] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260228003540.GN5933@nvidia.com>
References: <20260227175247.26103-9-jacob.pan@linux.microsoft.com>
 <202602280855.WxyIHCy5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602280855.WxyIHCy5-lkp@intel.com>
X-ClientProxiedBy: BL1PR13CA0325.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: bfeebe84-0829-419d-dfb6-08de76614ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	vgAELwFI6fMtBI8Iq7G72WdJfmC71OLMRjNggPOs3wdLzJUVV7MPPWOzmzfr5TsqagI+HMt2d4ZAQ1FxbQRPAxZsBRHJNmiZ5AAlUBngSow2KSxdpD+bI6lRGcn55DDOx0CFC0BAEoFUkikWqv866ulHE42ep9KEJfgpS8l81toCyIDOV1k+CuMN3zJj4IeDz4PoarqlYDpsDyfRWZVXd+/zHcNYLiXHSw9HEFiCMKbwFy1PiFRFYhuAo92TuoovTGhMb2BS58tLXIDRCl35fNrCcrcaRkueVXX52DBulOehVgQ832C+vuswFmsMsP05h1bGdYf7eNlFz7G/snrNDHlmDoiGTFRdDceWhTolXDTYKbSho86h2vLl1x+Qqzoeyuzbdn0cQRcDRl/UX6oD/U+hpmEG/9H6I7vgt5uVorLudQ7CDbyQmt+XvxAgFHZL09AU8RqJnTR7Cgdzt5rj8PhDDjwatSVzqkVvqQUxCuwCNoIimoJdNKK5lmYniBkOmU/GrSHrWQ5Rro2BjmAW/1Jm4YvFu7sEa6GqyAue/lndagu6aHbDAgI01z/noWci4RHbqycxV3PRDvNQUPXp9NOCGrIIXF29VbufGO53CcHBH/6cR+RViiITbiOLGE8gHgiqaPuqSpJpsffVG/Ja5o2K5OB3UwDJLujOiLaeC/QAG+RLJuLS0hwS8pgpLKBJDgKKdYCvuCZ/DJTr/5H1jcDP1xT5AVYZWCgEjwh/aek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xATD5K47iJeg/iNk7MSQkV4He59PdS+ntzBXHiI5GVeOZZVNpTFpoZdoRO8W?=
 =?us-ascii?Q?4fIx1/LbaTRvc+xNlxm2cgJrwXqcBhSPTtng81sVsFnEaIiIZn5//nAmFMhi?=
 =?us-ascii?Q?9UI759kvgTbJyJeYDTu4k8JSSe6SMlXot1eEJfVFpfi0KdEgpqkp+YaJurWp?=
 =?us-ascii?Q?NJPucaaX5DTYT9B2yz+WgwK4nT4b0h0G+g6vkzgbr5gIdJXZZ1SBLnjM/jqf?=
 =?us-ascii?Q?3Pmmb4g89fGR1ybY+F5bCkqhIjLJVonKsW8Eozu1ZRxsUleuf64aJ1emNHNd?=
 =?us-ascii?Q?eOm7oVNA7Hkxon72ZiFgXZC5lytfgRGRMg/SzK8ApWHMuNuABeBZBom7vxbS?=
 =?us-ascii?Q?IA9Jiq43MDDZ+ujqKo75r9jmxBcDwxxjdSlwIYdcl7ZADyqaRAX521x2QssZ?=
 =?us-ascii?Q?Ui3dxMzekoWfBElJ8k4vK5FAeTLsvwMueSl0JSdvZmlDeJhLeN8E5kg88oCY?=
 =?us-ascii?Q?Tzl4DnvMKcO+6nEP6w93/BaSQDqVxubY1Lab9s8MKEM5PB66KQJn/dOb7aTI?=
 =?us-ascii?Q?U+a9Uq5IdqY73u3KHkJ961XDGzR6MjipxOfbVS3lxbh5cBdKdrEu7Dw+6r9Q?=
 =?us-ascii?Q?GXBR9XY0dOBwZxQJqDl/pwqn6P75mGn0t91l9oAtEywDdg0FfpvjHzx4VNoi?=
 =?us-ascii?Q?6Bf2FP+5ji86lhl2YbDmLUDJBvKMCDafGMBndVS0SCFxD+PdZ70A2DOH+/4y?=
 =?us-ascii?Q?vEnj4tavxc0K+DkyRpwADopWEYg0THBeJVoNFMzMZ5W5jZU+XifiuEiqyzAK?=
 =?us-ascii?Q?GWm2QaSRZoq6fK/Ss5hun1+UOCUnAsDBqA4Cverxm3mkLQOkZhqt0tA30dzy?=
 =?us-ascii?Q?qwfowV/HlljKdK4iFzcMshX6V4f42RMu6AsVOIKQoWUjPUYfe1wYpIjXKHvJ?=
 =?us-ascii?Q?B5LvCqjkBiuRlhwQDBkLjQx8yZ5xLNC21a5mKDwxI1tAZZUc2uREfIRIb3AQ?=
 =?us-ascii?Q?aoFAfzoUX0N9WTzx02bY9d4SJMQTMv6IIXdj6nG67Vhc1LXMmrTjr++n0/1e?=
 =?us-ascii?Q?sOv8Xk6B8iQG1RKVhAp+xinG2D2TfvKvU6soPNL2ucduRY1FFeOIWY+majaM?=
 =?us-ascii?Q?iSmSun3yR5ANAMxO79KBEyMWk4Dy3Z+74z40pXwNp6BEzDkIFGmNdev9aWp7?=
 =?us-ascii?Q?IZp+6r6pwlzIReU5+1peJz8/TOzKy239BPn1Itf2tM+PTI3swLsqUF4RdVls?=
 =?us-ascii?Q?KfKRO17KWaCDKhzQ9klGVBVOuxU0MX08fnmfBSxjJDqWWiq2HM+GHRXBNCE/?=
 =?us-ascii?Q?e8ElfSZiN4br9sBO+EIJ7zFWXp7e8PMNa4LDlVadP6vp4CRB0ALF4hwB7Fmj?=
 =?us-ascii?Q?rFDSPVfXFwD0Tdl8IlA23ioZy+BWRHLIyUSSVbfhOaHBY4ga+EEQYLzo5MyF?=
 =?us-ascii?Q?OKVN4WA1NsTH8tlNDrq9AnFsOsGCK0JFOQMs6VOatk7am5VYrzZWMnlclDp8?=
 =?us-ascii?Q?LKZNGP2GeEPDBkCg760iI8vOXbN1t2UiKcXD+jaiw3zvD0lQet48fnXVs6K3?=
 =?us-ascii?Q?5cdVy+AGNJ4K18GlGynaD0ErL0BXMEtmQNir7KpuNjm0ZZw94e5FA9FDeNW3?=
 =?us-ascii?Q?Un8g2USxEFnWvW9++wXDBlATtTCwLhKUtRpxlfE3h2eab8uOptIqbrPpB+ug?=
 =?us-ascii?Q?GD2oI9vlywBaHKI4LC0IkkOxj+6ToSbmAfTjUrHyqC8eFIHeXXc6hCWd0S8G?=
 =?us-ascii?Q?9fbnExhTqm2wpQ3aPOlCEIyd9mBRSHxqz+5mCx7r1n7RGl+nPqHIXyGFRT1S?=
 =?us-ascii?Q?8J/VGpCJLw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeebe84-0829-419d-dfb6-08de76614ce7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 00:35:40.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOyw3jSi/uH/JLFoY4Hdwm41eB17LUNpKWnAUF8J/CSWm0o7gtrLu2i75mAZJa7J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081

On Sat, Feb 28, 2026 at 08:18:41AM +0800, kernel test robot wrote:
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for IOMMU_PT_AMDV1
>    Depends on [n]: GENERIC_PT [=y] && IOMMU_PT [=y] && !GENERIC_ATOMIC64 [=y]
>    Selected by [y]:
>    - VFIO_NOIOMMU [=y] && VFIO [=y] && VFIO_GROUP [=y]

Some kconfig stuff is missing, the iommufd IOMMU would only work with
GENERIC_ATOMIC64

Jason
