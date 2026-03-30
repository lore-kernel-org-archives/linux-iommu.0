Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AE3AB27C
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861466; cv=fail; b=g/s5bDFFelQtdR6k90pywXT4ZpXpbDs5VuDNkedjIl6EqoIO6XYQmx64+8j887Bx5O5OSC+ctC0EqYc7K5zZFYlsBtLtRy4xZLMuFfmkIl3McJN9XytvQ9KWEGR4uVx8rTxMGehWYiV17xc/2W5Qdi53yrtFkmv39wZH8tHsMYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861466; c=relaxed/simple;
	bh=v9RmI7NkTQh7hAqYfyz05XOm3lVzgz9IfJvJXGT2oLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mMeBW+NpLzLq31/60fGPPOQSSBgRTHEUUTOfvMaFii5TJwgDlGXPvuPAFTWDdXlIHJLjMOgUpti0URf2RC8KQrQkSausu/XdZ0l6SMujFNgi7aQAR6REbm1oSDbv5jHgON3+vXqLGtHOTarn0gG35JOWHf2nzrr4CaA8kd7DCKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wLc7kq/o; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wLc7kq/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgRNXxBfqAGG9MVdrXHGFkttjGcbS6P97MCRZWm4vQD/1j0hEz13LUdHdFgOKbksgBrjOdNUnBrMUYlkfdbSHxKWsTQ2vMb9f6uKf/4qFi6a3YTSHDgK7ioJligrghorMC9kFM3V79VR2WA5KvkA7R7J0ZliyBYHfqHTgkZcYMAXPWG3czDkjX62CrnJSTKPSV/yArnWKTBLpR6mvBZyByash9rWR9gH5KOqBQkEduW81myilsK5SYBMeeesps8PQphXZ/cLlT2wUUsQmaUbeJuEWXQOfpfdtuxXL8TGxQf4oJGK4AHRTMs5B6rOYM7mKDr4LpMOcuI2RMILpdV+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hsLtPYSopTDRHm8vs0Mg3fkinwl5SaQBeABDB2N1MM=;
 b=dAOscp7nBvBR/xB8s2g9RMfMcZwHeY8aHt2kFGX0nmkUEjGtzapEnReA7RcmrdNypzAaPfLdz0B6jxYa3leTtUN16DdO8lKfpcHMu7VrH2V6X5nWA2EsJvqlYNNb6a4//4TrIschXUVuD/QK9YipLO0BuaiW5m3wvghnfk3K1I339dBIAdkIRYidqqb1FB6AvdfzSWT6QF6tFYJuPPYu0EQdlain8NVZV9ZIWu7tcrVsPRM38mztDwTolwEUvtbYBZiC9ONZzUuc5h1LaDEoiYQk4qlkeqd0OSdKHi+anRtayvpC449eH+e9wlFex54jpuMZEKJW1qd4IoQ8PpdINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hsLtPYSopTDRHm8vs0Mg3fkinwl5SaQBeABDB2N1MM=;
 b=wLc7kq/oeLonLrUI7qR/hBUkfteqSUxUkybxRFsqAexDiCpn70Mm9jTG9V8kYog+YCA20E2W/i6+KskZAKKIZIcoPkUXVgU7ObmLLug8iC0ofJAPaV2uCj+fRRwH6PSBgOHhKdxSqw5y59/snwMOQHzWggpI8i9tUGyGJdKsYn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:04:23 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 09:04:23 +0000
Message-ID: <223439cb-3047-4f76-abf9-692e22f4248e@amd.com>
Date: Mon, 30 Mar 2026 14:33:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/amd: Fix illegal device-id access in IOMMU
 debugfs
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, ming.shu@amd.com
References: <20260319073754.651998-1-guanghuifeng@linux.alibaba.com>
 <20260319073754.651998-2-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260319073754.651998-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::18) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6ced9d-f720-4eb9-5f5a-08de8e3b55dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7t7xiIImBXXpttU7mTRWELR9rMtgbURdBI6hJH89IsTTwl8R161fsghmgNKjMeV4S3z9G4pLDZFmDDH/nBAmrYSA0cuWpyrK5YR0wYXAoNjGPilXLvinfMMpI0TSqCppmbPr706Hf5J6e4z9JjEl4+3db9LjFv2oUMGcFYQ0+jcZv43A7Ek5UQ3EwOMP2ujK2NB1outUQI61PWVOxUo0bzFZm0uXuYqTsaT62TbLDGnpkyD+wOfDmx65SUIoqamv0QfwqUZJvOPulSEiiC7V5DX9nRGUmanKGCJInrTNNY02uGnFS4udqz2greBvykgDD7scz6bjZ3rI/tllEmyTNMNudPs4dONr5IKj9hyR+BRU9bAjhiHO2tt10QelDZnk6dSXyH0UJ+M8fEJAI2RjFQnCliZ/w59e/L1r7dBnshmSojazwNrJlFnQmL/doV+ZnxdaheVrlOhYmTD/EMrEOdWXH/hhyHQFqPGbfQ1KPICn0Ry5+1GV3zAizq7avJtrkyBh8dPmJSLkYC8hbHZ2z1wVmzOd1HakRKNL7c7HiX0aDTjeAR6tWDQXq7Y97CEAc3NH31eMSZss18lOy/bvT7nWDR5gqTWF/TXGhjfGNViujdGDiVkxuQ9d8pgmJ/xydi5xqXXpLsPQ8FrOWOtHX0Oh3DKfwR3rLYpFiqMdECikQVuwcndVYPEm1xuj7RWzEwb93jZQeIKgAxg/hVeHXruXehR6ODPEpkj+mkB22bs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjdpcXlCcGVWZko4RUFZcDc1TzFPekFmSXJ5UGZjNTBDNW11dnVMSFMxZ2hC?=
 =?utf-8?B?dkdDZENpY0lQbEs4bk9yVDVHWWdZUTdYR2xrR3Q2eXVWTkRXRmdyYUZDbWoy?=
 =?utf-8?B?SkZLbEU2eWJYRENpWDE2UEhnYlY5OXVaSE5QcmZyb3dEUjk3aTZZSDF0VzF4?=
 =?utf-8?B?SzR0Z2JhZ1ppaUZaVFZXOVJYRjA5YTJGeXovYmlMUkZBd253M3Jla1VpQyta?=
 =?utf-8?B?bVpnN2lYb3VIREdkMmxzYWxMUG1ETHRWVFVvK1QwdC9SMWtYQk5ZaHgvV3lO?=
 =?utf-8?B?U2N2U0lXMlBkdVFxQm12YytIYnpqNFhTRE5pd2RucUQ3RXNYZm1NVXduOG1Z?=
 =?utf-8?B?andvUndTZ011U0V2b3F6YitKeE5QUzFiaXR3bG9pWE5aazV5ZldoTDFkY0Fo?=
 =?utf-8?B?U2VTSUtaMGVDbkxuRVU4RjdpWDJoTlpjaS9Vek1vakFwYVdCVk11ZFdyNHFE?=
 =?utf-8?B?TElYQTRhM1paLzU2L1BnT09VcEhQak56Ty8zSU8wOTNlMkFmR2RYUHFETXRY?=
 =?utf-8?B?a1huQzk2c3dnZ09MU1pJcHBsSWsvNW1iRU5zdWVlWGl5TG91dWRjZzJ0Ynkv?=
 =?utf-8?B?ODVYM1VOUEdGUkxSdy9lSi9EZVNOSGV0S1hMRUFFdXJwQkppN1Z3UEEvQ0I5?=
 =?utf-8?B?cis4SWhxcHJRTlU5L2dQbDJBOVNSZUxiSzg3cG9mRm96bzVVbjUwUjc5SFpm?=
 =?utf-8?B?U0M4akZnQ0hoci9UbXcxb0RvWjJPWGdINWExVm1vTHZtUitYM3pxalNjL0RU?=
 =?utf-8?B?Qld3MTBnY1MvWnNnNTAzL1U4TCtXWUlERVBhUXVUQzZRc1dIc3NqTDR4VjRV?=
 =?utf-8?B?MldNTUF6bkdnSEthb25raVl6TGZNdGJmbVNKKysySTd3aWxPdVlIT2IrbUps?=
 =?utf-8?B?dWIzcmpNbDRkTmdNRVBVM1p6VGxNOHFtZVJhNzhOclI4SkNmaGVWakg5RDhM?=
 =?utf-8?B?ajZIQ0UwZXZ6Mit6R296WWsrYUtMa1RKdFZNL2NRZ01QZm9LcHp4ait4R1hS?=
 =?utf-8?B?bWtuNkpRdGovZXBlMTFzYjMzVFR0dmR3QjJ3Z0U0OWkxUTNOTmRWQmg0ZXlm?=
 =?utf-8?B?dHhNV1EzeXhQMk1PMEk3aW1pbXNMVjdGVVNFNHZRT3hOejJ6QmJCcm1QakUv?=
 =?utf-8?B?d0hSTjNXa1M3Wnowa2Rzc1FUYW13a3NBNHR1bmw4U204QnV0TkpyOEV5UTlC?=
 =?utf-8?B?cE5GNy8yTHYwTFUyNjRnUmFRQVR3QTVYNll3UWx3RHVkQWpKRTd4VHlENUlz?=
 =?utf-8?B?dzQ2SnhaYmx0TGtMMFU3Y2RqcXdMOHIrZ0JYazNnb2RaSXJwQ3lKckQxYWE5?=
 =?utf-8?B?eVg5U0NjWlNJNk93L0ZkTlpCOUpOYlUxQTBQL3V2QzFSc1lKRzFaNHRILzR6?=
 =?utf-8?B?dkM3eE03RjdMVHA4b3Rwd1dEcmg4UWN3eHNqdWF1YlBiRzdxZStxanRpZ24z?=
 =?utf-8?B?ZnMyTDdQRkhDYnpoUTRjeGJTUWs2N25ha3g3T2RlcFFGMkRlZUI2Y2xIeE5z?=
 =?utf-8?B?T3hpTnVhZlc0Tk85ZHlVWXIrdzVxWUpYazVyVHBWS2xFQ1hJYnFNdEJ2RzRy?=
 =?utf-8?B?TUNWeFNaZWVHeHlBMXdWc3VJSEE5UEVKQW5BMkx4OUZWTkhxc2J2Nm5wNDdn?=
 =?utf-8?B?TVhkQ0lxcGl4SkVCSDlMYkdIWVFFc3pGdkFQWUI3aDU1SkluNDNZMmdjWW9P?=
 =?utf-8?B?bVVHbnZubHhBZk1GMU4zUFRnVGhnQWFLN1NVVU5FcUQ2dlJUU0tiNFlxY3Zm?=
 =?utf-8?B?QmI1ejNlNW11c1UxL2FlUDVSY0xaR3ZSVSs5elptR2ltb1dVdkZiQUUvZjBl?=
 =?utf-8?B?bFFITURCVjFxSlVFdmxJbGlBS3NnUVdhTlYzSkYrNk5ERnE2NzlaSlNGYzNu?=
 =?utf-8?B?dUFVV3IyUjEyTitxYnZsOGZ2MTBqbDFIaGhEanI0NlgwVGs2aEJQTEJQUG1J?=
 =?utf-8?B?bDFLV3dlOWZDbjVQNERMa3dKU2U3RzlJUDZnUVVicnhSSXpsU2Iwdk9Ic1Z5?=
 =?utf-8?B?b1ZyY2hGbDNiOTlqUGJ5Q1pHVUJDR2hNOElBakFJQUFTdUZncmJTMU9YOXBE?=
 =?utf-8?B?cUlJTytSWk42WEZDZXA3RGkrTUlBbFNwYzRkQ0c5d3pyL29Zb254dG5MdXcr?=
 =?utf-8?B?SmtVMSt3R09iaDhGUUpyK3B4QVdmdlQrSmNiWWhLZ2cveHAvTFRHQ2t3c3Nn?=
 =?utf-8?B?ZnJnUWVoRjFvUmhuQlprd1NCZFhScFlBLzhMVHc0NE1XcUJGQmlQVmZreFJu?=
 =?utf-8?B?dE5KY1liSExEblhzRmhXUGdhem5EKzBQQ0EyTWVlM2J4ajRIeGNHbElUZnhJ?=
 =?utf-8?B?blEvU2g4NVpPakhia0NHRW05dUlYZmg2SU1NVmV4SVpvRSsrK0Q3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6ced9d-f720-4eb9-5f5a-08de8e3b55dd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:04:22.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUyF04lEdjMZYiKFE1MaO1guWbWgmWfOJ64aw7QO3IJx6z1u3VZp8mz1TpWgOvfnz6A2PvkowWzzdMEomr0rCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826

On 3/19/2026 1:07 PM, Guanghui Feng wrote:
> In the current AMD IOMMU debugFS, when multiple processes use the IOMMU
> debugFS process simultaneously, illegal access issues can occur in the
> following execution flow:
> 
> 1. CPU1: Sets a valid sbdf via devid_write, then checks the sbdf's
> validity in execution flows such as devid_show, iommu_devtbl_show,
> and iommu_irqtbl_show.
> 
> 2. CPU2: Sets an invalid sbdf via devid_write, at which point the sbdf
> value is -1.
> 
> 3. CPU1: accesses the IOMMU device table, IRQ table, based on the
> invalid SBDF value of -1, resulting in illegal access.
> 
> This is especially problematic in monitoring scripts, where multiple
> scripts may access debugFS simultaneously, and some scripts may
> unexpectedly set invalid values, which triggers illegal access in
> debugfs.
> 
> This patch modifies the execution flow of devid_show,
> iommu_devtbl_show, and iommu_irqtbl_show to ensure that these
> processes determine the validity and access based on the
> same device-id, thus guaranteeing correctness and robustness.
> 
 Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>

Looks good.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant
