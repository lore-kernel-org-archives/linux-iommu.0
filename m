Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834C1BF322
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827523; cv=fail; b=q8hrUTVt5gequw7NEyle6Mu6rhdZOXQfvqXnCIHnYOhsZun142uVQfJgvJxN+RzplXRRbIfrWP2DdjwszJrEALPCe++35oaKURMNCA9tpz1qxY0OlEaY+r6FDmAifiIBelncVVubCbhzA2qPUpYHkkdi2vt59VU6Z0vgxcwvhSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827523; c=relaxed/simple;
	bh=8kXpdXHfw90ary9ettxhpFT5//QDYytPzbw/0CmVDh8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OdTNXj12rGzHFnYz/I3T4LzVuPEyndKb5TDNeCKI3bDbJcmoRSLDp6NMADKh2gpKVbL4BDKIqfIdWU9Uar4z7UR9sbjmtAfGUrtrPcTiZOgJdI5anyThT/1Ck3uscDv1iYB2+ymnO3LdaWWisVsL7GRIFYKdshfPk6xJewYt4eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oUaVKIOG; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oUaVKIOG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDPaWcOJAfbY6y0fuJ3vCwcYuA3aEdgUebJ0DygB+61sSLCwj/71Uj2QyE0/lc89F18EiGito+4+oTnr7GAzBiabWQL1ZarCiPcWvJ8VRbui3nJh9CfEX9K0t57WMiCpWNWUUeK4JToTBxlsh3pe/t85tNckiIcCn4aOahVUn/OPr0rlZFZaMmn0Ph6NSAUMcjLj4fdMZ1MKrrqQk4QSUG3x9IaDBZOK9S0fGBiuX4XwbPAVhOclLF2ymFo+gZ1qBrn8c0eTp0+0LYZ76w1MmVkn4GDxz547I7mtZKpysCS7R1cRv76Wm4Op5la6UWUSuxOGQCt6BUJRbfKkk1Smbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHEu56CX7tBCkjHSM906KPjb1NfbxQkVsYfzEcmOcrU=;
 b=cm1PGgKYu1Yb6WBsMpanRyI1dQB78EnGo+sn4EaBKAI2tc3ZMUAh/NyEj6EYL/91qKask5/ItRkNHO0cTZc0Bn0bfvwx/EMEmggh2ySJhEhIDw8B4VEF877qQN2j/cACknZEHKeAhfxhqLK0y5Y8jS9C5HW4afCXI8nnf0yALwbRXz9vnJiD8WUNOau38Wpa1m1kdhh38mnSYF4jSnVUzyB0zAQsEOSaYIrL6EKSZGXLp4uumsqvGXhfxsDsBPX8yWGhIPRxqDtEfwVW5hH0Bxc4YjgaV5iKGxJuxsTU/wOaEsVssR6SJEG5eS5/bDD46jEGibNabHXdrOZvPpXMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHEu56CX7tBCkjHSM906KPjb1NfbxQkVsYfzEcmOcrU=;
 b=oUaVKIOGJgTS7XfuttRih0hoPDJPeGpBz7di9xU3VjUbMF4iF0MR6F3irkWFzaK1p0LQhsF1p7is6+qCrzMAvWZ4DcNA/BBUnjlqxRpcXycfP3XcVN1mXeWYFzZRSHeN93YGryg4mWFdyh6TFKb17z3DYHqgtPsL1E5DjuOnboI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 16:58:39 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 16:58:39 +0000
Message-ID: <55ef0f8b-9b41-4615-8631-c36e63c93b49@amd.com>
Date: Fri, 16 Aug 2024 23:58:31 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] amd/iommu: Clean up DTE programming
Content-Language: en-US
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240816154331.5003-1-suravee.suthikulpanit@amd.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240816154331.5003-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e30767e-0ee1-4c92-a3f6-08dcbe14ac9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjE1Qm1VOFF3VHBoek1yb3dOaTZHU3owR1JTQ1JoU0REd3RCZm9CK0JIOTJP?=
 =?utf-8?B?TzN0S21yd3FzNjhlUCsybmgwbDB0T2d5dXNJYUN5QURVSVRWTCttMllSVUJm?=
 =?utf-8?B?N0xoZnNxL1l2dldHNmVZbEtEbkNuRC92R25Wb0h4RUlxQXZFeHQ0YlhWdG5X?=
 =?utf-8?B?UWVvWWlweEtFV0p2YnVvRFVQd2RZTFE5L1VrVVhaWlpLYU5xZWREcjArcjE2?=
 =?utf-8?B?WlFXZkFkM1lyZU9aczhWUEhmOEtHbUdzSVBRT054azZlcGpjQnA2aytkVFFK?=
 =?utf-8?B?SlVSUmxwdTlpTG5RbTFpTXR2WXpLMVV1TkJCVUNKZzhhbHFQckw5bCszZGxx?=
 =?utf-8?B?NjVMNFY5UWlwbzN6K04vOXFSMDFsQnFUOHU3VlkxQ3JiakFhOVBtS0hOTmxC?=
 =?utf-8?B?L0I2dW9CZE82cTEzcHgvc3I2RDN6SFR2azBzdHhBZXlQWHpmRXpXN056dnBI?=
 =?utf-8?B?VTg0Y3lLb1hvdlgrcW9qdU9qSUU4MzRBdUVuQld6VEt4ZEt3RTlET0x2UlR4?=
 =?utf-8?B?YmVoRFFoR0FWcnVpQ1gyOTNrdFhGV1FIeGZtdUNJRTZibGl1YnRQNUg0SUxM?=
 =?utf-8?B?SGhTNVZaVjBiRW9CNHBMZHFXN3Z4U2swbXZ2NUl1TTBGcmcwVjhiTUkzUEtj?=
 =?utf-8?B?TWNGS1ZyZHBDa1RnVTQ4RVRZMU5ET0RxNFRYdmJ4SVNLMTFFU2ZIQUN1MU54?=
 =?utf-8?B?OVExTVErWlJpWGEwZmxNMmFTWXNxMGplUi9LU3dYY05ENkFUUEVjT215b2hq?=
 =?utf-8?B?RW5JT05qM00wSVNOYnRZOFZpNjd3NzdjOTFEbFFLTG1ZZ01kRUZYbEVTeFhI?=
 =?utf-8?B?cmlrR1JFSnFqcGxST1JvczFOWXA0YkpiUGh1YkZuUFBGZVQrNXVOVkxWR0Jx?=
 =?utf-8?B?bkU0YkVSR3FSYlJZREdOTUFLRW94eU1sUkw1UWRRdDhVNDJhSC9TS0prSGU5?=
 =?utf-8?B?dUJLWFVoMk9tT211QUlKYWxheDdCZGo4R2Z5amlOOW1MdklwWXQxK3JlM0dx?=
 =?utf-8?B?Z2RvQ01CYU5adDlPbWtjMnQ2eEYrV296ZmZoUGJrbGlzTmtUcVo5WkpsYkFU?=
 =?utf-8?B?aUJ1YlJEK3hNWVFLZEtBSERCeXJmUmU5dk9xUHV0Wmlzd20zUkFOU2I3Tytz?=
 =?utf-8?B?bkFEOThCWCt4dlRhcnZsWmw5ZzNpS1hzMkdaV1gvb1c0RDdiRGs2dlRDRnh3?=
 =?utf-8?B?Nnc5N3RLTzFXeStXVEVxcUErWHJGbFZOWnhLSGR2YktJK2dRamFkemxyV3NT?=
 =?utf-8?B?ckxjK3hodW96MExZLzRGMnlvd0FvcStwaWowSlhmS0trZUQwZGN3anZTTytD?=
 =?utf-8?B?eGsvZktBUDBSRCtzMjNKZVVTdzljUUJPNWZXVWhWZUFSTjhadVN4UzZOZkJT?=
 =?utf-8?B?aFpqNnh0M1Q1N1R3ZlRYOFlUb3haempuL0lNOXNNaWtWUWN0M3lZWFBjRWJ0?=
 =?utf-8?B?emxad2FwQzQwbFJrejJZUXliTWl4YmZTTXIwT3UrSWtYSjM2WE9IdnNaWTNh?=
 =?utf-8?B?bUhMTmpYU0RzTk1UbEg3dHZic29Jbms3VWl5bVo2YUJVZUd5Sm0yNWFaSDRS?=
 =?utf-8?B?SUV4MWlkRXdnS05Xd09LNU1INUQ5YlA2V3ByZE92QUl5UmdiWWFYcWthRll0?=
 =?utf-8?B?SUp4RzcvaE5aVFk3RDgvZ1pRQktWa08yTTVMeWo2SU42YjZOWFo0ZzVrK3JM?=
 =?utf-8?B?QWMwNVNTS2J3YmJUNDNCeUgxL1pSMWFRampDYTB5QXcrckJIYnZvNFJvS3Iz?=
 =?utf-8?B?dnNMVXlQeTQvdUR1dHlPMVo5TW5nRDZGZXFkNHdtL2xsVzZ0OTd2K3dCVUpT?=
 =?utf-8?B?czRScEIxaDV0OE8xOXZWUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0ZXNmkvMVAvRlhySlliTGRQVTVLTzhGR2o0ckhwVmY0QU4vVjlFcHVBeXhy?=
 =?utf-8?B?T3NrNnVndHE4QUE0Mk1jQ3ZUN2dwUUlYUXJpbkE0STBvSU1HNDZMM00wb2Ux?=
 =?utf-8?B?eVNvZzZXaFNMWGNOYjZwSS8wWUR2cTBQWWw2OStHeXE1Q0R6Rkw2V3VETHlz?=
 =?utf-8?B?N3dLMFlITVFFVVV3SmF3OVozY3V1VTZTZXN4Nm8wakFDVXI4R3cxZ2s4Mm9s?=
 =?utf-8?B?K0h3TUpGazlMUjMzSm5zRXFubXBuUVdMV0Z4ejRsaHNhcUI5WTV1dkovVlc2?=
 =?utf-8?B?OU4yMWZjWDNkdFpabnZRUzh4bmtmYU9zVlJiUDJQSDQ4WkJwdHc4a1Q0MGJ0?=
 =?utf-8?B?YVR0TnVhRkNSVzhJa2dROUcrSmNjSFUwaXUxQ3J6QTBTeG45ZzROZG5USlNr?=
 =?utf-8?B?Z1BxNmE0aFVlOU9vSk9BSFA1UzlOUG9ibko3Ly9jdDFyd1hkSFE0SXF2NEw2?=
 =?utf-8?B?MVowYmhoTUhEQ0FvZ3EvUGRwT3pyc1B3RzNDMm10eVczUDh4K1hEbTl1R2N5?=
 =?utf-8?B?a21WbTYyQmFSYnNMSFhEZmk2MGdjVEhVNEh3Zmx3aHVoWEx0SHBuOXo2M1NE?=
 =?utf-8?B?Qmwreks0ckZrOTFGbVY1TzMxYzcraVBnQ3JocmFUcWJ1Q2RkNGNvQjFOQ1RL?=
 =?utf-8?B?WUFJNkx3NjJMZ3ZpNUNGZ1VUUHVGWm1CUnc4aUxUYm1XZ3BZYlNWbUdabFcy?=
 =?utf-8?B?UlhmMVdlOHJWbzVVZnZqd2RSR2VBQ3lvaS96Z3JwOWN2UVpjRm9LS016ZUhy?=
 =?utf-8?B?OVRrMUR6VHNGUmdPcnVwV0JpSyt1cmdBbUR0SDAwcGhIMU5CTGlmemVCZEdk?=
 =?utf-8?B?S0dlVC9RUG1mTldENEV5dFBtMTNmZVBhU3lWaGhLYURwL3BRSWVveWFCV3F2?=
 =?utf-8?B?ckFpRFpTZjUyNE0vTlRiaVloVW9qRy96MytLMlpmNUUzNGRCcDd0VmExQzJ0?=
 =?utf-8?B?b29XNDVtYWRCa0V5MWhlZSs0ZkZCNExwbFcxTktvbUNFYnBvY2tnL0syUjEv?=
 =?utf-8?B?QXlFamRwVHY1bVV1STl6OGJFeTROU2prRCtXOFhVVmZBWU9lY21ISE1qZWtn?=
 =?utf-8?B?bllpU1R0RklpZmwwZmI5OVA4TlR4b0laMFVDMkZzbXcxWG9HZW8ySkExUjE3?=
 =?utf-8?B?TGlMdEtOV1h1Zk1XS3RGdEd0dVhEY3ZncjZGYmVBVzB3QzM4dHdwOVlOK3Jk?=
 =?utf-8?B?VFFMWHNsSHpYRXB4SmpLTG5OMTlJVTk1SU4vbW4ydGxoSGxJZjg4RFV3ZWFK?=
 =?utf-8?B?ZzZHbmVOd3RZelpxWkZlRUorQ0hPTjNMRE5mbGRtaDJhSWt1YThxMU5RQ2VB?=
 =?utf-8?B?cWVTbTBycmlPVzBWZjk5cGMwRTJ5K1BrWVBLL0FFWWRTODBHcmtFSFo5MSt1?=
 =?utf-8?B?cHMwYUptdW5VMHR3d1I2OVI0d2JlL1I0VzZaRFhEaFJOYVdvbXdRWjJvbFdZ?=
 =?utf-8?B?eFdoenVSODF0SmFEcUFZMDgxL1ZYVk1BM0U2SnQ1aUpWSFczRFVVU2lCREMv?=
 =?utf-8?B?Q0R2VVBzZDlMY0RsNjRRUTFwYkNhbVk4WmZZZ0NQV1BGZHBGUi8zSU1ZRDBW?=
 =?utf-8?B?bkpTV0YwakE2ZENpU2lXSElHeEJjaFRVYjR2NFZ5ZlJ2M3N6Z25qa1QrVTFB?=
 =?utf-8?B?eDlONEx0SmN4WjhvWWZRWC9NNGtvREd3bmgxcTVwSnVCK3pqY0MyQnpiZ2xr?=
 =?utf-8?B?Tmc5TStnT3VhZVRwNmJobjBMdjlOWFJVdmR5SXhTRjQyS3hxNVloVUFNRjdi?=
 =?utf-8?B?Q2JJNmlNemE4anRWazBobm1MeVF1WmJ0WllUMENSMWswSU5YZXA5YUVYMEMv?=
 =?utf-8?B?dmI2U0h3c1hKMForVHVpTFBCUC84VU8wVXl2UHNkaUlMcWE2a3pUYUx2WVBD?=
 =?utf-8?B?LzYxbW05QnV4ZnVyVlJVTDh5RXpHWHQvUFNVYlVOeHhJbGxRdFp2V1kzc2JE?=
 =?utf-8?B?dDY1R204ZXMyUVJjMWdFRW4rN2ZCMUlOWGVBM0I1bHp5aGpDUzQ5ZDJGSDBM?=
 =?utf-8?B?OWFxckZMYTRiaFNSUTJyY1JMeVh1M1lLeVBBYUpDMEczUjNNVHNJZ3g2cGZi?=
 =?utf-8?B?K2xEUmlnR2I5TEhNVlV0ajhhUUxZTjUwM2xvZmV1MnhzUGQ4aWhQL2duWlNv?=
 =?utf-8?Q?rrGrE8HQWFeZoqaytGkP8f+Wl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e30767e-0ee1-4c92-a3f6-08dcbe14ac9b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:58:38.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiCpRD/j0h6c/qIZWbMz5qO8cP4MocNXmDT9NSmCoYKeljIcsM0gJqVu4z0goBem3zFSodqN2htJzIsBOZyxsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878

Please ignore this thread. Sorry for the spam.

Suravee

On 8/16/2024 10:43 PM, Suravee Suthikulpanit wrote:
> Hi,
> 
> This series cleans up set_dte_entry () in AMD IOMMU driver.
> This is also a preparation for subsequent nested translation
> support series.
> 
> Thanks,
> Suravee
> 
> 
> Suravee Suthikulpanit (2):
>    iommu/amd: Introduce struct gcr3_tbl_info.giov
>    iommu/amd: Refactor set_dte_entry to simplify GCR3 Table Root Pointer
>      programming
> 
>   drivers/iommu/amd/amd_iommu_types.h |   1 +
>   drivers/iommu/amd/iommu.c           | 131 +++++++++++++++++-----------
>   2 files changed, 79 insertions(+), 53 deletions(-)
> 
