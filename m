Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429632;
	b=IdS+1oPxK83gDxfT/yC4I+bTEL2bJf8S9Uy2LJmYdBkgSbpZEYe+MHlX2+ADbMSGNiVc
	 PV/ogASOnNwBtGtfleYVAzAI+jU3OcA+5YCEI0IOfBgL9Z2qvJmoT+DyPBgfy0o4lZl1C
	 c7of39OLhSd2vJLrnAg8Mp+aJAokYE8vEMmdhxhUjBf1lqtYC+/poE9KII+6441u1gcpy
	 iM1UdbIsVMZRFhT00ZbEuu58BPezIBzSX9VE7tUJ8OwN9Sz2mIDH8MzwEtI0gxAgcQpCd
	 +Yx3MTShj044OY6HBWyrV8geA4ADb3bZjfqWD72J/bf+O3GvhWgYsF5AsT8pflbNEqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429632;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rq4ohf5H/xquQaorKss3NDIfiYe8oJHiHW6GhP2k7YA=;
	b=p8edc5JuvorLohywZ5E71ZKd9c0fhjzwUb/mkWdkR0tdW5dkbD7D06s3qAQyAsasBazc
	 ETLUhkscCXLpW13CXbiuVZg72m6iPW85UtU2PESHyqtAO2dXMDCojDkUkDlzTFWhM+m4c
	 9tF/VOuiPWl5YFTlPesl4WhUZZwBofwtDKdXtUb8coDY1q3YUfi6UaTjAhRr8pv56ijww
	 ESdKRGnnqgyAjyAccNwblFHhazezTPsrsgVklJB95/MP7MMNkRX4huf+eiV9RS7D8s/Zj
	 bC2zFm2uaUYun5GGKW5vQyXTDPLywCYSfuAyMV4bkdzN1plBLKBavnRRHUPkDHweCTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CrZlOGCu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752BA606A31A
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 17:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 752BA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CrZlOGCu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT/nTNN+CdHgC5YbzanGNvqUPil2rT7euD3+0U7sO2InruIEatcIv7lf3obkSZ4k4xyFomP6cf2rc33SxyM3uGJ7ZdBZ7rQdkWGfm8VLUvsQUt6PO0TG6f8/VwHVTH2ZGmkLR11aSrIWLL3+XeFkfl2GnkV5JucFwPu8pVyz5dsbu67HqRQ0PA39ekyg2aQScFhFh39f9pchnuYDV0hiRB9U557fs/ueW0pDjytLcWd8JNEuniBfmxJOANnieonoc+EZfK22U0BEiQfikGaLtodPJVMEKXAm6DVgiKiZEOTQ8rtcopFvF+IpRAwiCvNwqiANZj0lvuKfh+iBfI77TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq4ohf5H/xquQaorKss3NDIfiYe8oJHiHW6GhP2k7YA=;
 b=En/y60eNpVtCPa9baGiBtOzsalV/GVHpj//75uqhJcrVonCuZ730SQsFXSnAoY//kT71dLYU0iHXlGKjaNkrhHDw9iemeptxeWiPX/Ylq+YKS7jlkVoQSh38E8013VDSxlMChEVTwR3b2A/f/CbdW9tS2073JWcIf5gD7aUbbC+u/UbRFAblnpCYw3X6lrdGwD4CkbqooJNoPrzQ+zqyth3ky8+xhKoOZRTmcNoa0IimxdNv0K7/kTHIpZ+K8jwDPPvHJOBgsLNfmexIZOc3sE/OenTeMbnbBzY3WnY2FXsZHeHqMx8BlNqxvXjQIYZm9tcvhvE39moKclZyj0mnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq4ohf5H/xquQaorKss3NDIfiYe8oJHiHW6GhP2k7YA=;
 b=CrZlOGCu0PHY1z8mC7Y/HHvkDb/yNxFGUhq/PEkVQB33xmnHa9Ku7ODnJs/Fk1jp1HHgAUl3nWFCUKr7ICCZWL+zcATWuCUyoifnTh2c0B3JsEcxe3CmjFvaNMqOu22RU0eWdIZ/ruBmJqNAoBVKpocXEYCYZqGBi3LvP1dkLMQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Mon, 19 Oct
 2026 17:07:08 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 17:07:08 +0000
Message-ID: <39092f38-0904-4d1a-83b7-edbcedd03cc1@amd.com>
Date: Mon, 19 Oct 2026 22:36:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO
 BARs
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-7-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0219.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::6) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: e71b0fce-2365-4dad-556b-08df2e0368a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	VDjmTcOri4WMDJ0JhYGabOBMnatfT6kfCgIR78njT0WOO7Q75uYohP8tnWieU2mpathwyjF5wGJxI+qaYJddTZQVe65YNn9Ikb76yclDh9DldUY5xGepwSbau2Wc/Tp2Ps2ZRyMdtXuUeEJfQaMJoc1GQmI06rvYexxkyrOUSfQgtRABL1BqxsAotYhjXQYtSlBx8Bhd0pIE1z5ayIFcYPgsHeYrMgWIcQvKjWzTcXDP7sBUI+wgFT51AR8kGNhZgJ819bgVlsSK1FDUJ0NIVvW5lrO8uoB9feGb+nAmwom9HVHarVYH1ZlJS3YufSGc4iQvR+q1BDTtgnKtHERu0oCCKRPr+qNvtPsEb+AX14L4qwe2+MUfie9WVTzHqXv7e9neJGnYuDVRDt8u3k3YVqe//gbqDOt3PyvZirUvAtLXuSruvX4DmbH8tVfEdp5BRCjJe60JbYM5ccSnPPfhXoFG5vPf+JOmkgsW/52SuURfo8KLNaPJ/5Y1+iNryDj1e0/kAewWyDdQ09JLKBBm3Zdh2m1MTJeeEkFGe2Xr7npTXkzaox1YXycuSRS2ptbrFLMv5VxMsNwC0aBrgb5DFPxRtnRnZu2sujk/qwofOjkK5CH3ZV1n07bapQCF4c1rVxu6L4JaFlpR19WGa3TVBStVOmYZvaXM8wswYdtoxyw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkUycTZadXlvcjNiZlpENVFqMkc3dzhMUjJzRUQvb3dHNVdBSXlheGNhMDlC?=
 =?utf-8?B?QTVPR01iYVhidEcvSEQvMFdHMFhsTmVSRmFQUmhHd3BrbEQ2ckZnU3JoQU9Q?=
 =?utf-8?B?TXBxZDh4Nlo0M3MwZUk2UFgyRlhIYTgxRG5LSnlLaEZNWlRrbFNQTUgrMnFj?=
 =?utf-8?B?eDI1WFhZZDVhNGxmQXVrVkxvZ3RjT0F2RkJkNGNBT2hLV2VwUHpXTEN1ZVlC?=
 =?utf-8?B?WmVyQTI1TFI1SGV1TlIybFJKZkdHNU9VNnU5R1gyQXprMXpONEUrdm5NSkZE?=
 =?utf-8?B?ODM2amp2aXVma2NQMW8wSkR1UWwzdTM4QVFwV0VNeWIyRDQwSDZmelYrdzEv?=
 =?utf-8?B?cmcrdjdza3Z3ZnprQVhmaldWd3cvcUEyMW1JZVhxbzV2OTQ5SURzY3ViRTNo?=
 =?utf-8?B?YWRTb3gwUlpkUEV0bFdNWlBHR2I1WWRvYmtoMmtvS3hXc3ZxcTBvMzZ5RDBR?=
 =?utf-8?B?YTZZMkZldXVHUk9ISTJSaFo2NURyRFhGK1lvRExJUElOTm8wOHpuVDBWWlll?=
 =?utf-8?B?QUV4dFRIZVEzVjFjdlc0b0hHQ05adnVyamNkNWRwTUR4UnRuRXJGeWdBSkc3?=
 =?utf-8?B?TUo4UGs0QXprS2hJclQ0SVFzb3hVSy9KV041aVcyQ1d2SWl1aEZCdGxodWhC?=
 =?utf-8?B?RVFtSENQVDdlVTdDK0p1TTJUVHE2ZVQyVVplU3hUcEVMNFg0OCtlWmJubjRl?=
 =?utf-8?B?Z3hiVmNFclBzM2hhQkdCODNkWjhyRmowemJIRUlzV3lFTDJVbGNhS3NjRFhM?=
 =?utf-8?B?SGhGV3M3U2FMeW9qM3kvbEtiMS9XandQcTRhbXpvTDl6bDRSeGJkSSs3STFL?=
 =?utf-8?B?bjZHL1pqY2FmUEdtZkZCVjBTMGtGYTVkUUFDMXNwQnVYV1hMeU5vZERNMjJH?=
 =?utf-8?B?THdNaXRYbXY3NnZOUjR3RFN2dU9DQVBGc0h3UllmbVhtbys5NFFsY1UvYWlx?=
 =?utf-8?B?MTlSWE9zQUJqWEFkdnhzRmdJWHJtVFRyUEZGNGRQTzFXbXlaYkwxTEJWM2c3?=
 =?utf-8?B?azBOL2grNjI4ODBoWFNqNGdXWXZ3TWYvS3lYa1h2eG5pazBQNXZiY2FSTENo?=
 =?utf-8?B?Skp5eDI5Z1JUYVBRbE1sOEw5b01nWFp4bkVmbjdKVGg4UXd5enhMQVNMblJ6?=
 =?utf-8?B?TjNGWmFiUkluU3JsNjBzbGxVVlVWNVJUMEVwY0hDUzJQNkJqdnBMbWI4cGZG?=
 =?utf-8?B?WWRBUzR0dHZjRDdBZDlPOUhuQnloOVdLTnpGSkpyUGRNL3E3ZzYrNWViMXZN?=
 =?utf-8?B?bUhJVHo0blFXRE1HbjF6VFd2NjgwUW83VE5pS0NtNFZuTGtmSXJSbGh4d3p4?=
 =?utf-8?B?WUhCTG50QkFQSFEzL3JPNDM1bVJUbzhRVC9KbDFzLzRrMjcya2VMWkc5YW5q?=
 =?utf-8?B?U3JVcnA0SDdyR01VSUpoRlE5T1RxdDZmVTQrazFDOFlScGN6ampFVXMwWm5S?=
 =?utf-8?B?eXQ1OENvbVRSZUhwM1JyMkdCdVB5dEJ3Tjcybk90bmJEcTNacjk2Y2FOQUxK?=
 =?utf-8?B?Q0JRMHdPQjRjOVZnTWJOM0l1WmZJcFhQSU9UK3Z1NVFkdnVHQkpqc3FUd2Zp?=
 =?utf-8?B?R3E5ek84RUNPWHdjS2JmUm9sWjcvYjlveVlMT09raDZwajBtU1MzM3prS2hE?=
 =?utf-8?B?bXpxTm54QnFFcUkyMHdoeFNTdkN2OW03SzdqVnRYUGV3M3g0bnN1Z0MvOEN2?=
 =?utf-8?B?dmg2ZGRTWWVvU240VkJ1dk1qOEkzNVcwa1VlMUVRL1ZJL0o0dnM1dXdOQ3Ur?=
 =?utf-8?B?SnJvOGhRUEpvZnZJaFg4R09JMm5UaStrUFJRWFdsOUpRQkZsQUQ3ekFKZWV3?=
 =?utf-8?B?V0hUc0krRnJYWEFKOFM4c2VMb1JmQ21jRVpwZXVQbWpUNGNvNjJGaUtpb0Yx?=
 =?utf-8?B?Y0dLV2lkY1NGZE9ucVBNcVpSMU1lY3JqOHJsc25PQXhOK2NVdmFFVUdDcWlx?=
 =?utf-8?B?UlhrSTlFRnhreWU4N3hiRytKL0ZlaFpoNmljcGo0R1M1QzhzR1QxS0JMMHdN?=
 =?utf-8?B?enRRa2d0ckdrUzZaVWpKZ04yYkw5TGpISW9wUm9peHhxVTFHVVBRUGYzK1k4?=
 =?utf-8?B?bkR1Ymx2d1VFVW85NG4xbDloQ0pSS1ZkSW94TWdPd2wxRHN4bTRjTEN2RkFr?=
 =?utf-8?B?c2oyNjY2RVVtbWNyenV0TzFnSkJCNlB6SkgyYVRmNTVOUDIrZXBxbFhsUm9j?=
 =?utf-8?B?SmJoVEZkdm16WU9TMjloMzYzK1BkekFML3ZxRWZwVWRiNTdEMmpzN21ZdXdE?=
 =?utf-8?B?VGpFa0RSSEhBdnBNZ0xIWllWcDRvTC93MnFDakhYUWw5dS9HaWxjS295cjh2?=
 =?utf-8?B?ZGlBcFViQm9QcWJWQ01VamlGZDlSME9HWjBLc0xiZlRSQ3pwT0lxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71b0fce-2365-4dad-556b-08df2e0368a0
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:07:08.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCSUmYY5qX9mYfgLGDdYg8BSzFvzCfR8xjn3T8iPVgeRL02Bigm4y/uYSEwzOLQdK2D4deMWH7NRhUX0ZYTB/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> Enable hardware vIOMMU on an IOMMU by locating its PCI vendor-specific
> capability (VSC), reading the VF and VF Control BAR addresses, and
> mapping them for host access (256MB VF, 4MB VF Control).
> 
> VF Control covers the first 4K of guest IOMMU MMIO (control registers,
> trapped by QEMU). VF MMIO covers the third 4K (virtualized by the
> IOMMU). Per-guest bases use the Guest ID from the previous patch.
> 
> Reject a VSC VF or VF Control BAR that is disabled or decodes to
> physical address zero before mapping MMIO.
> 
> Set AMD_IOMMU_FLAG_VIOMMU_EN after the VF BARs are mapped. Export
> MMIO map helpers. Call amd_viommu_uninit() from IOMMU teardown
> before free_iommu_buffers() so MMIO and the command buffer remain.
> 
> Release the reserved MMIO region if ioremap() fails so VF/VFCTRL map
> errors do not leak request_mem_region() for the life of the machine.
> 
> Skip the host release in iommu_unmap_mmio_space() when mmio_base is
> NULL, so a failed ioremap() is not released twice.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  2 +
>  drivers/iommu/amd/amd_iommu_types.h | 31 +++++++++
>  drivers/iommu/amd/amd_viommu.h      |  6 ++
>  drivers/iommu/amd/init.c            | 25 ++++++--
>  drivers/iommu/amd/viommu.c          | 98 +++++++++++++++++++++++++++++
>  5 files changed, 157 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h


.../...

> +
> +	pr_debug("device:%s, vsc offset:%04x\n",
> +		 pci_name(iommu->dev), vsc);
> +
> +	/* Setting up VF and VF_CNTL MMIOs */
> +	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_BAR_LO_OFFSET, &lo);
> +	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_BAR_HI_OFFSET, &hi);
> +	vf_phys = hi;
> +	vf_phys = (vf_phys << 32) | lo;
> +	if (!(vf_phys & 1)) {
> +		pr_err(FW_BUG "vf_phys disabled\n");
> +		return -EINVAL;
> +	}
> +	vf_phys &= ~1ULL;
> +	if (!vf_phys) {
> +		pr_err(FW_BUG "vf_phys address is zero\n");
> +		return -EINVAL;
> +	}
> +
> +	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_CNTL_BAR_LO_OFFSET, &lo);
> +	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_CNTL_BAR_HI_OFFSET, &hi);
> +	vf_cntl_phys = hi;
> +	vf_cntl_phys = (vf_cntl_phys << 32) | lo;

AI suggests, w should use mask with GENMASK_ULL(63, 28) and GENMASK_ULL(63, 22)
as other bits are reserved in these two registers.

-Vasant

