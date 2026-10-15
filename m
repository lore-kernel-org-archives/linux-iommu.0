Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071E406261
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107610; cv=fail; b=fC3lSMkvdjCFKwwLvUMcDSVvkbSxuvIu6v1f+7dz+qPNmpReklhkiO8IYVDDBaCdUdSKH5tcSWv/J57eNYdn4B2MPnEbKXve6Aq6n1wHhPfuAhWtBeShzLUZYR2VYYhlFYiR4UK66VsH3t6dUsKWB54Lr8++8t4XryfCv5Ryrxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107610; c=relaxed/simple;
	bh=uqTnhAEaae08J2oerWoqCs4wL9hJyYqLkOQuqnfQYtI=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=A1KtDOhE9U9VMISz1CI9a1koqOTfbBkjaptRwvNHIleRQV7v3NxwOGko0b44sGOJvIJtAKo84sK8sUT6GSs8IVW9+ZDQIXC13MIvTrAFxZFPza0T+G665QYOj7ifluZl5UHOOmFDg+vVVSNn++0VomMf97bf7zr8jI3eUNteFjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3bovOOG; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3bovOOG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmdkWOsLZ1Hlf+4EBHoF4mt0CLVxhpZ2tGPtjBerfmyJJxC3hBgFKXYho/LrZHs5fGnXNBaWoV7v4N+an8CSv76VkvV1upv+z2TWOrnZxQXmUw1DQHEZf82vv5DxJz6cxVRCWVkABHhDY/dUficSEi0grOjRBe5wH//Aus91aMMlc/2pEVZmlRfO73qm0hXQkbivF+rXvQ8ehkd67RCr3t9ngtzbrSk4o/g8KBh2OJ44z9OBes1X/FLWGiURqm7GZNfJTUQJj1RFpQxfz/w6z4jRnuEIwvEj/AzRF+A10NjbTKG1q0eC7tSQlFt2nGCZG4A5U+GS0CpYTC25kGf7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IImPz/Sd45t/WOvdv7c7MFgJ/wFhJAcLIA8JNJLIwAc=;
 b=fPBLPAUcgxeAlVTk+6S+gwB3SgYr+HspQbXGijvnVbSjsvT/3Mcze2vARJOsppZALMroDYrX2uwefrr6PggWbf5XXJNOdOAUWTAhGhCZ3KnK517DJ0KTbkDGfzvda4K9qxGcWPmFt2rgXl0fiW0LwFNF7w/WKu6O/ukhhgTOrz4QKfo9ZRy1PdHf3sgC0G7ou0L4OvwmZjnhfZ+oqP5qZ++pMI+SNGv+DQeaYdCgt++E74DSwkOXRQJ1Uc6KJXynNOJV4uiGYf27Un7UEyotaUu0EOUQeb2yCAqWI13JzpNGi3AEGXmA02IzsvWIASCCW7mjc4WOiH0KXyW6iVNanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IImPz/Sd45t/WOvdv7c7MFgJ/wFhJAcLIA8JNJLIwAc=;
 b=c3bovOOGD/JqjopyRkt7r2kWEETuIRyygMJWrKEh6Rd5I9NTLhB8woR31b+dq+xLZucD/SDxT0Xc+11PNs/fa2nzAdcC6WL7Tj+7vm3LDbWIfyAUXFIAOyuqU7i6cArEdUUUAqPR0EWm/tGr+93oKJ0n49XZdaDIEA7892ilCGggK1hlWDrrZjzrwfCLLviA/MbMKQ69o3YrQourFpQbDdBLYatTZQBAUTjlKm116C/GMS9/mN77rnbkH7uUikGNDMUbmwA3oWUoxjDs9vv0LUax94htpmdOpsPGR1YbhiSIHxsbehSM8gvgRBwzFmLUDRpq0EIhvs6qG8G4EZUzlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS0PR12MB7969.namprd12.prod.outlook.com
 (2603:10b6:8:146::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 23:40:01 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 23:39:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 16/24] iommu/amd: Add IOMMUFD vDevice and DevID
 mapping
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, 
 Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, kpsingh@google.com, 
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com, 
 guanghuifeng@linux.alibaba.com
In-Reply-To: <20260930092344.5616-17-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-17-suravee.suthikulpanit@amd.com>
Date: Thu, 15 Oct 2026 20:39:49 -0300
Message-Id: <179210758993.4133959.4584677647518464223.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: CP6P284CA0076.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:1a9::11) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8408cb-c9f1-4600-83e1-08df2b159ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|11063799006|261009223027099003|4143699003|18002099003|10067099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xyk81UDbLmt4l4JHmKoAUisgFUKvvcsMykxWTrmcVPcofceXVutWW1UyQxMrau6xGowwk19Lm680ODWvct3nlWHLONd5GyiLJBqKfhKeMb+Ys8ci2X/hdlFgzKDqJOemavFqNoUfibsqs2s0AB18NYQD45eKj8uxmcyDkfUM4mT8IHZOWCJxz0NmV/3TDZ9wM6n5q8p1oE/AtprTfp36WdGqCUy71IA96RzuMf09m0NFAJe9EVY+40k37f3SNKza33hgIAQIHdBJFjw6vfewGC0XbqcJjG/C+Znj933OgPTN+n98dFgi0ik/NznwRxtatLRT8mAtK+QrjUAS/nkeFSCIFZmZxnBTKcRU+mELRAbSgNsTFcbs9phj0+MEhJRyWz+1jDFljXxnDUbfmDCrku6u1RZBnhgl/2CSA+XbaxHFm+ylhIUjvi4uMlcQm/CS7k/m1uE3XNLXdryrl2wUjhd39Ef1FQV0gAS7rXJe1bzk1bwja7HhqYDXQwMEgBpKQSepWW/wgBJ0NdiRAsBUvSh1ghO/bT8RXIRlvTINs0vS3KKpzKr1EeusbBVbJUBZQJMSH+KEV+XHpQB1Jd2pKU2wgklHyfUfKpwFEqJM5FAfPPnkHTf1h4dMivPI/5ukrJlfN4NDEKIRatLIAf5spR5JkDG7lPUsanawO+SGJWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(261009223027099003)(4143699003)(18002099003)(10067099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YThDS2RSMXJSZTkralpqNHNUWmJmNDFlQTZKNVdueFpDUEdMbHZ3ZW1UTWdi?=
 =?utf-8?B?UHBhNE1aMnBFUHNsUko4Z1FKWERnUEN4M1QyTWJzNjBaWE85S1hnV1pDcUhm?=
 =?utf-8?B?amZPTGM1VklEMnZXTGpxemhSclNoL2FEWDhTNXk1WFJ6d2c0RS9GQXVUWDkx?=
 =?utf-8?B?VzB2Ulg5cHV6VWthck1FT29kWWhmMkFuNkhUTGRqRlYyVVlwbkx0QmFVb3NF?=
 =?utf-8?B?N1pwOGhUOWFIYmJDOG04OEZSRXhrTmlZRWxNUUhCS3RIUnF5MU00T21nYUlx?=
 =?utf-8?B?a3VtOHVYYlZzekk0M2NsUGZxTk1KM3I1a1lZN3NyQkRlalNPTlN1TlZXRzRV?=
 =?utf-8?B?TmhVMmlXeFVleGxwclNQdDZJcnJuQnVOSG9rY0tpMjljdjdrb21XWGlqeWVi?=
 =?utf-8?B?ZExMUmR2RWdIQ1ZlYWk0aUVCd3RtSThnTGd1YTZuTlFGMmUyZ2drZ3YvVmlM?=
 =?utf-8?B?MjBBWXB4VkU4UEtRNTBFQno2WksvZEM0Y0lOb2JSQmNYQ1IrZXFuc3hDcUhq?=
 =?utf-8?B?V01qY2o3aTBmZUhTYlVQWDcrdjFZNUh6dFRIZGo2YUp6aXhNN2p0MHVVdkR0?=
 =?utf-8?B?a1B3ejNIUFNTNkVyajhNd2JpbWF2eTE4TzdScld5ZlI3UUFOQi8rTEtzRGll?=
 =?utf-8?B?NDM3VWNVRkpuTUVZUGFQZEJkVUdzTHhpMmRrbDVKZ2RnOC9QcklrTm54cXVN?=
 =?utf-8?B?UVpLVGNHczZZaG1hMnI5Q2N2cHlyNWppbUhzSUJQcEwvVjdoNUNMb0x3RWd1?=
 =?utf-8?B?ekM5cXBHdDRDUHdtTnpCcE1ka0dzckRWQWNNUnQ5cXI0UE5oeWh5cGd4NXMx?=
 =?utf-8?B?RWlqVUFjT2c4QkltR1RTWkRTb3JFTWdxbVRmcFlvcU1kdVE3N3dUY0J6TytS?=
 =?utf-8?B?Y0VDcXJXZE5KN0t3bXhVUy9MOXZtUHRvUUtObTA0Ty9YK0Jub09wVEtWRjJY?=
 =?utf-8?B?eHJnRWEyenRSalR0SmlwNmY0ZzFZaVRaZzBsTXkrYVE2RnNnKyt0Mmc2Q21q?=
 =?utf-8?B?NHBKRTkwd0xSS2UramNobUVFY3BCc3hUNWZhMjBwTDY1Q0c1VmtWNHgzRVNB?=
 =?utf-8?B?aGtrUFZ1ZkN5eGloYVliL1E0OGNlY3o2WUExejFjOVlEVENtKzFSZWFDZnI2?=
 =?utf-8?B?R015RFBBL0VxdmthK1ZUTVBsS0FWUXFtbXUyeFd3UU9aZUZQdStQN1F1Mk5D?=
 =?utf-8?B?dVJNQ0I5ZllyMWI5Q0M3NFNxQ1ovQTEwRmFLdCtnTU5NMUlsZlZoK2EyUjVv?=
 =?utf-8?B?QUc1STBLbDhzT0dEZ1c0dUh2Sy9HaWVKUy9aRHQyczcwUnJrSE5iTEN3Z0gy?=
 =?utf-8?B?U2JkQlNnVFBiblVqY2xnR1BNcjFnUGxPbUlqV2lKU2NHRUV2dDB1WU1pSE1C?=
 =?utf-8?B?OFllY1RUMUszbFNsUVMweVJjdllONFVvUWMwUVQzNUtNZi9SZVlFVlVvWmtD?=
 =?utf-8?B?SU9GeVZVR1FSSkh2ZjM4Zk5taGFzeThvK1ZacjBkUnRQY0lpeENudDRKdXdS?=
 =?utf-8?B?YjdnM3luUjRDL1VzYjliME5xNEtXQXNvL0I0ZDFGbStnbTdUelZVcnVQc2VN?=
 =?utf-8?B?SUtwRGY3UThWNlVHUEFBM0J3K3NaazFJbjFaYU5PMHIrd1pLNWIwOEhvSU9J?=
 =?utf-8?B?TStsOXI3UitNejlBMThXMFkvTG5obHZ3Qm5KZWZVYkFvTzQ4Qi9RcHVId284?=
 =?utf-8?B?aUxiNFFMSXpHTFE3NEZFUStzNDZQd25JelROaEtZZVE0UTFtYWMvamJqQjE4?=
 =?utf-8?B?TzhEM2hYSFNwQXJCdGY0MDFEdGNIMFN6SjJKMDNxQzJqTVlocHVUN2haNE92?=
 =?utf-8?B?cmZjb0RqaEw3Smo1NDFTa2ZLbk41bDlJRHVkM0x1V2krWGJJVDdaek1OUmEw?=
 =?utf-8?B?YXU2S3FUSFdNUW5XWDlCVWQvdnZMZy81YjlveXVqWjVQVit3RGdNVHBKNVFJ?=
 =?utf-8?B?WFVlMVEvcnEycGtDUHRkcjNiMm1abHpza0NvdDlPelI5NDQvcG4yRm9GSS9H?=
 =?utf-8?B?VUlmckc3L2cySmlPMExKUUs3M3dhQUtRTGgwdzF1eGVUTjM2U3BlOHZrTjVw?=
 =?utf-8?B?N2F6RCtMcjdjOUF1ZjY0azh5ZEhKOFJlMmk0ZTdEYTBwNXFtZGlqMk5pNEl3?=
 =?utf-8?B?RmhJN3hRUEJraDgzL2ZjZzdOQTNENG01Z0VWc2JzbnNHdFR1Y1o4R3lDcG02?=
 =?utf-8?B?SWw0QmVMSE0wSG5MeGdLR2s5emdqV1lNQnNTaEFUREcrbjZSQUJTMXVxcisz?=
 =?utf-8?B?cGgrVHYxQlM0ZmdIeTA4T2h0ZjdqNEtWSHZMYVVOR0xJU2hLUk5XU1J5N2xB?=
 =?utf-8?Q?t7hCKRLwUVS+nRWDvp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8408cb-c9f1-4600-83e1-08df2b159ec2
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:39:56.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yMDmrf+UBRFd1UV1BZB4FvuI1HEzAYGyDtDK0tnqmltg8qvVEGzz1ezCMEUFZSe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969

> [ ... 128 lines skipped ... ]
> +/*
> + * Called from drivers/iommu/iommufd/viommu.c: iommufd_vdevice_alloc_ioctl()
> + */
> +static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
> +{
> +	struct device *dev = iommufd_vdevice_to_device(vdev);
> +	struct pci_dev *pdev;
> +	struct iommufd_viommu *viommu = vdev->viommu;
> +	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +	pdev = to_pci_dev(dev);
> +
> +	if (vdev->virt_id > VIOMMU_MAX_GDEVID) {
> +		pr_err("%s: Invalid virtual ID (virt_id=%#llx)\n", __func__, vdev->virt_id);
> +		return -EINVAL;

Do not print on user triggerable flows

> +	}
> +
> +	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#llx\n", __func__,
> +		 aviommu->gid, pci_dev_id(pdev), vdev->virt_id);
> +
> +	amd_viommu_set_device_mapping(aviommu, pci_dev_id(pdev),
> +				      (u16)vdev->virt_id);

I spotted several pointless casts like this

Anyhow this looks like the right use of a vdevice to me and broadly
matches what arm vcmdq is doing

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
