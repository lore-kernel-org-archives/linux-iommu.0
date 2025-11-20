Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0340271468
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763618856; cv=fail; b=SollnZ+FBgCjo8prM1DOoAG2Y3vbV9n76GEPXUKTKWCNCKEyJjCVKSDiTFqqitjg+AWr0RPFe7AkYLfqIDT+5C7baw9srDqAYFGZIfUpOn1kBA0YjW6MfA4EOVMII+XWHsfLxLS8XeduFq7X7FbvtRDHDnCaJl3SlvAolte1l+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763618856; c=relaxed/simple;
	bh=K8Crzsy7hh5sh5BxCpmbZuwZ06dzRu1e5uGKS60Mc64=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p7cQD+bLE709RFtmFQnjHRnojyDT3jhAcGEADlp88kCzvYFRbRtE3sOQWFOU3JOeoh0z45OsCtlWU64/teykX4h3P21yY+T+66TzaIRdHIM/8Xer36f0eEllWYSyh6itoUm+HY6d4ewMoyxmkbCtZJsSiWHEGUCO7iQbPZryysU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=st5aoN/Q; arc=fail smtp.client-ip=40.107.209.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="st5aoN/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZLEhpjGPXJ70fJi6ed6VId1iX0ycrqsWoXKd8zUcDDe096YbUEbj2TwFe6Ol6s/KYyAuyG+Eop2zbAWg0KToyw9zn9Gsl64y/XnsvjXekP3Wk3/fpZXEulerO0umAenRDXwzKqSpmAqAGbfw/pXreQmak68Ov5nGsE3Fo7EfhlHDtmZ8OAfMLp/1bMzv1UiWFORqO8XmfnHr6rOid8qY7InV5JApnywVKYdjmK8G/+SLqz3V96iXDqR2WbpmGEysBPOtBa3CL5dt0rhg+dxuTktRxpVERGMaM9O3S73QvUHZy6uv1w82hVSnjAI8k4MagoXYgvrhHlWyEpiyMwAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYhdMXSoNMEUfKIC3uyV/hBP3sYJwc14+w/rIgX816g=;
 b=DQHbDT6esJs1efgsm7pga2Qd6wr1q08jiMYogkHkLqUTfqtU9uocPqs3wb4WHpO5o6gNJCRpwk0Ws1sk1bB2eeBp8Ovv5ihixGwCare261ch+YUiT8rTs+Wc0KRurV+c/fH3lwsU+B/Tgr0I/xeSrt2e1fcKRNIv8/LpSfn/RzWH/KjPehe0NjjE/oiMLTaNi+TMG0L+lwMhYMhk9hw4lsoE0UyXe5VdcrTmwOj0hJdZ9urXKm8xksy9MW9dN3yfR5PrzB2XnypQGtUOA02vmZf5G5R3CUUbLoVjcxrAvT7vUTfPnoCPFCxPwbvx68cWf4iPbVGPDyxZaBVAEetGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYhdMXSoNMEUfKIC3uyV/hBP3sYJwc14+w/rIgX816g=;
 b=st5aoN/Ql7VYAMHFXJNdn3A8xJ2hbjQDomJ292h4GaEP4c/0CLhDoIUa9gazg1KRlKkbnhNlUW9OySnniEhWBFihEJUNFXsD+dL7Y/7IATZRjFPQoJLttjEPj+gw3yR+ZcguVS/TX2r2Nk3FtipVQYEPz1F1mGXQGCSg3+9K9SSuRt77CTDYrBsTsdxJX35BdWgJkmqketLedYhiVOANPmr61Qu1QuSy4OOsZ1JTPEXv4zG7UXcQmS1OPrfaJZFhYQnYr51ys/tdP/EfeSmER4djChH1p+z6lWwDUyWuEr9d9WdLHlDypk/eMtDyHF5Xml4nDVcXHoXo8hDyOPEy8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 06:07:29 +0000
Received: from CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::496f:71b6:c53f:8fba]) by CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::496f:71b6:c53f:8fba%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 06:07:28 +0000
Message-ID: <ef5bcd93-c88b-4242-be31-a3a4765fe5d8@nvidia.com>
Date: Thu, 20 Nov 2025 11:37:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
From: Ashish Mhetre <amhetre@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, will@kernel.org,
 robin.murphy@arm.com
Cc: joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
 jgg@ziepe.ca, nicolinc@nvidia.com, linux-tegra@nvidia.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251031062959.1521704-1-amhetre@nvidia.com>
 <20251031062959.1521704-3-amhetre@nvidia.com>
 <20251031-witty-sociable-chachalaca-b73dbc@kuoka>
 <4f6496de-d3c8-4701-a9b4-6f695018eb5e@nvidia.com>
Content-Language: en-US
In-Reply-To: <4f6496de-d3c8-4701-a9b4-6f695018eb5e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:264::16) To CY5PR12MB9056.namprd12.prod.outlook.com
 (2603:10b6:930:34::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB9056:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 385feb39-2b0f-49a2-5aa3-08de27fb1564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHA5dW9oeHpSNUZvWGtrbU5XVU1oMjRXMDh0M2lER3BzcHd4dlAzbXZ4YlJk?=
 =?utf-8?B?WHVxRFpwcjFzcmRSeGc0RmZuYVRCMHlmTVRUS1liN1hpczJrZ0VrUWpzU0Fq?=
 =?utf-8?B?SWZad21xK2hZcDBrRm80bVhrM1kzZmZ5MUVsK3h1Mlo0TGxVdVNqM21oU3A2?=
 =?utf-8?B?SXYwVXVYL0IwaHpIQWRoQzl4ZjFsUjZtNklFWTAvaDdYWEtnNGVFSFlleTFE?=
 =?utf-8?B?bVpaaTNOMm5rUTUrTG9xMmplZWhXRjVKYUdnMUFabnJvQUs4cjlSdTBzQXpX?=
 =?utf-8?B?TWZuYUZLb3h6VHJYWnlTL3lxdnQxMUJ6d1lRQVVGU3RhVXVOU3JiSXIrRER1?=
 =?utf-8?B?T3JEMWw0RGthVUd5aVdJVGZvaFczSmtUU1VoSkZKZmUzUy8vVldRSWpEdFB5?=
 =?utf-8?B?ODcwRExzZ3NaaEdzMElWQXdpS1RBQjVLYk1zSUVZTDZ4MjZUdldBVE81a1Rw?=
 =?utf-8?B?NExreGxYeWwzeEFGUDhRaG9wTTdpZk9uNEFlNVVRUk5XWDZsREZJWUYwSm1Z?=
 =?utf-8?B?Q3o5TXlnVmlhR1VyNCtXL0FENkZ0VzBrVDloT1lHOTJCYTU2eU13MmR4dHV3?=
 =?utf-8?B?K1plMnk1WFZET3VtQ0ozQUFYRzlKeXVmVGtpZ2dnRG5yUGlsdkc2Mm15TGxR?=
 =?utf-8?B?aEl0VkV3bkhFbzlpczZ2cDNRNFNNdUZpd3N2MFNDcndYaGdXbnZlc0VvR3pN?=
 =?utf-8?B?UmR5WjMwVVRBRzJiZkMyeEllWWNLb0FhZjh0ckRzdzFwQlRYYld0ZXJxSHpI?=
 =?utf-8?B?a081WHlHZnBIZzRGUFFtL0Z0TENlL3dVdHNxREc0akVRcnVrYzJsU1M3Uml1?=
 =?utf-8?B?d0lHMXo4QXcwLzZUQ0NjZm9oL2E2ajlyRTlOSVBneW5CSU9EYkdYR0NjdUJF?=
 =?utf-8?B?S1NVRWxJRXppMlR5c1FyTlNsaEpaQVFEcW00ZFNxcllsNUw5alREc2xEYWJk?=
 =?utf-8?B?RE52NWgvdWJaMGxvWjBkeGdiVjFYWnRWV01tY2FqUmE2UUx1VnA5ZVJOWHNP?=
 =?utf-8?B?bVJSNmhuQTRURlhzeVhIWEVwcmVucFVYU2dyNWxITzhod3VySi8rd0VuY2c5?=
 =?utf-8?B?ZFBzdE11QlFaSjlZU2xITFVEalg5MXB1L3I3RWUrcWE5OXBLWXdpNFBqV01B?=
 =?utf-8?B?QkN2Wjk0ME5nZmkyMnJaOUxSV1k2a1c5eWxzb0piMFUxd0M3RXdrdW0weEZP?=
 =?utf-8?B?Mk1qQ2p4V1d4UTVDRjVYdnlUUU10amNpbjFzNG85ZDU4ejRlRXF3ZzZsZGpo?=
 =?utf-8?B?a1pLNXdIV2ZHVVVHbVcwcDErVHM4SnZhRDJNTFovRUFPdk8xNWF5NGV3ZmNB?=
 =?utf-8?B?Y1dQaE5zcDZrRVROYjB4S0E5UFUvWnJEZ215UTYzMGE4TjhCNFVRN0F3czl5?=
 =?utf-8?B?SWtWUFhXYkMzaG1GZTgvK3lnVlV5alkyaHpyOUh0T1hCdExHV0xMbDJzb0lY?=
 =?utf-8?B?ZVdlVkFvZG9Vak5yVGc4ZE5xelRrWVdTVmg4SHpwaXVhVWhTMFBNWVFtWHMw?=
 =?utf-8?B?bWdxazdJQUtmUEhEaUZVNW9hekdLdWtESGRDTnFHWFhsTUh1bFptTTR3TUZk?=
 =?utf-8?B?Ky84OEFDd0tGcHZId2hJN3B1dmZIQmZlbUlkUExoZkZwRkE2enlBR2dnY3h2?=
 =?utf-8?B?M1lXUXl1bFEwTzc2cGJodEZEWlg4MndyYS9ENXppZ1ZLNHBlcFJGTVE0V0g5?=
 =?utf-8?B?S1lMQlN4OXdCRnlhQmE3eVpZckt1TC8xK3g0cWlQSW1nT0dCU0FPdkxyaG5q?=
 =?utf-8?B?SE9MY3k3QWhsbXBQY0JGTk5TbmcydmtnT3N6SnBSN25SV2VTMHpsZStKenZl?=
 =?utf-8?B?cFZaL2txVVFtc0VELzhrR0I1dnNqVmEwS2pmS25EMlZtYzdLd2ExMU1lWlkr?=
 =?utf-8?B?cisvRHhOMGxkdC9sT2E5a1VYaisxUHZ0QVY3Mk1kSGw4T3pWZlliU2JYemkv?=
 =?utf-8?Q?eP483IWwD6Nf2rGPzZH/HhcdGWUdeFh/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB9056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1JKTU1hVGpVWFVrOHFUUGNyZ2NxbUUzSi9NeE5VUXZaalZwekhQemlaRnVy?=
 =?utf-8?B?UkNFMzFySFo0VDZFbC9EY0xTbTVOdE5TazFYL2NZUnNsL2kwTGFua2N4NnZE?=
 =?utf-8?B?UkZXUlVoVjdOK2NDYnErZ0c1WW5zSTJ3T2p0TE1hcG4xM0NMTEN2Tm8wdE1Z?=
 =?utf-8?B?blQwZm1oVUx5NmRGMjVsbW94R1B4T2FlelhqMWxEOEVRT3VOdU5neFY2ZGl2?=
 =?utf-8?B?dDQ5SytNS2J5ZUw1ZzIzNHVzRTRNVmNqdDNKSTkwUDZEN1lrQUJOY0w5WHRU?=
 =?utf-8?B?TlpJMllKdVg5aVBWZE1YdzQ2WkR5dDlaVzFZTHlHTnM2ZlhTV3FWYi90ekNt?=
 =?utf-8?B?bHZKdzgzNXJBS0x6YkVyZlA5NE4vbi84czFuN0VEczNya2NRNFVmQ1JHa0xq?=
 =?utf-8?B?Y0VQQ0V1cCtmSW9BZHVLZHBzK08zdVAwREVWbXpBM3ZwbkJUK1dsQkFIeGoz?=
 =?utf-8?B?b2JHSGU3bTBpVko0cUQ2KzAvWTc4U0pGUTA5Y2dtOU9NWWpRR21WVU4xUFNo?=
 =?utf-8?B?RHloQXdlWEVENFZFaVVvTXR0UHp3YmlOdUNtWSt3VmRDclhsZXgrRFhrYXdZ?=
 =?utf-8?B?QXRXR0d1OTdFSnlUbzUyK056OXpNZWVFNk45NlJWcEJ6eGlmdnpRd2tQQlBp?=
 =?utf-8?B?ZDFKTlVUL0FpMEtjQTBQSElUWk5QWFFIQlhsRHJOeWVtMHpnUSszNXZNM3VK?=
 =?utf-8?B?R2Q2dm5rdWxlRUpEdGFRUUdZdUszL1g1NGdTdXhOREdqMS83TWNwdzFJakNF?=
 =?utf-8?B?RnFuWXBQdXhmRTVmd29jdGoyMFdtZ1NRZ3ROQlRvNk1Kc0I2Z0l4STlXQnF5?=
 =?utf-8?B?eTVkaWRlNnY4RlplTk9GUVdySEY5QUtkVnlCZXdUcVdGcklrSGg3NGJ4L1k3?=
 =?utf-8?B?QXdJSFY2NXkrMVdydUpQKzdQQkMzVWRubENiQzFWM3dBL041VGNtNnJ5dFVR?=
 =?utf-8?B?cFpSa2dmbGYyTVhJSWJHOGZMaXo3eFF2WXRpZVBaMUxoTzY3M05RcE9kaUkv?=
 =?utf-8?B?bGF3cFVuVkJ3MHB0OUxXMXNlQkFIWmxGV01sS3AvM2t4NVlnNUxpMElmNVNS?=
 =?utf-8?B?REwvblhGYWlRWXFiUmRjMGU2ZVVtUWxFdVkrb2tuWEZvYksyU0Z0ajRNbERp?=
 =?utf-8?B?Yyt5M3lsYW5vWG1GY2R5TTIzbmVzUUdQckFxZWkzWGJsVzZ1cmg4Zi9nU0RC?=
 =?utf-8?B?K01xQU5IZHNINmJWeWsyWURJN2pWdG9NYm1YcExjK3dZQkhaY3BSWVRlODlN?=
 =?utf-8?B?eXBEU1JBY0pPRHNkLzEvS3prUG44eG0zT253b2NjV00yQnYxalBkRHcyTEF6?=
 =?utf-8?B?UjV2VC9jbHZMUWhRZkJWbk1iY3N5UzRVUUJpYXpRUlFEMWNVTmZpcTdudGE2?=
 =?utf-8?B?N21WQ2o5c3dNQkJBcDRrWFMraWZ3bGtLN3BjNHU2VHZ5amFWRFJya3dmcUxl?=
 =?utf-8?B?bG5xVTNMNGo4MllUczc1TkFwalUrUm9GYUd6N0lqdWJFM09rbmx4OENzNkJv?=
 =?utf-8?B?b0NoSTJlVjBqUjl4Yy9NZnA2bGtJd0FTRE5saXNBZWg2L3V4azY2UHdRSm4w?=
 =?utf-8?B?a2tYN281d09rdXVzVmhOWDYwQzBXUUE4Ukw3dHFmSXV2VHpZZXRZMUszT1Jk?=
 =?utf-8?B?WTNtZURldGh4OUFXK0p6NVNpeEFZYUlLUThYTXRBOURXWnh3MkVoTHFMSzVi?=
 =?utf-8?B?WFUzNlpFdTNXUnRWeW9vWlVtZWpwOVZTOW5xTFlsT3BCSkNvNFVWaGNNREEz?=
 =?utf-8?B?dWR6QmlJVUI1ZnNac0ZoK0YwOENjME1WeFVjaWM1RnRHK2hHOXg0U1J1ZDIr?=
 =?utf-8?B?Sy9NQmNKcnNIVVBYK21OSHZ6YVhsRlJPY2dJYzNOaHZ0Z214QVd0STFPTnhu?=
 =?utf-8?B?ZE5QWUF3OGhXM3RZSnlMM2dmbzBxWGdvNHVOYnhrRWU3MWM1QjdBd0RWWWJh?=
 =?utf-8?B?d2V6TXlNdnUydlVCV0d4eUl2QktXY1dBRHdnZXVLa3ltOXZXbUJka2NYTDRU?=
 =?utf-8?B?OTZhM2FaMHplWjZXbGRDeEdhVFcrV1pRU3gvY3M5L21xZnJlb09QSkRFRnVh?=
 =?utf-8?B?djg0bEl3cFNZbGVkdFd4SzdUYlBSN1piUTZsYXRjWi9hZ0dEbnJDREljWDRJ?=
 =?utf-8?Q?AhbPq/MgCNz1hP/EFnHZsvNcL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385feb39-2b0f-49a2-5aa3-08de27fb1564
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB9056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 06:07:28.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5+JnBxo/TviokmLLpYiGes2Qzr3JS8VPXcdero0UoX1v2q3fWouFPniCpvEECbxI2HlkcdymbmhM7iph5qzIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508


On 11/3/2025 7:24 PM, Ashish Mhetre wrote:
>
> On 10/31/2025 1:44 PM, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Fri, Oct 31, 2025 at 06:29:58AM +0000, Ashish Mhetre wrote:
>>> The Command Queue Virtualization (CMDQV) hardware is part of the
>>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>>> virtualizing the command queue for the SMMU.
>> If this is specific to Nvidia, then I think you need specific front
>> compatible and disallow it for other vendors.
>
> Yes, CMDQV is specific to Nvidia. There isn't currently a vendor-specific
> compatible for Nvidia's arm,smmu-v3 implementation. Would it be 
> acceptable
> to document this as Nvidia-specific in the description? Or can we add a
> new Nvidia-specific compatible string like "nvidia,smmu-v3" if that's
> preferred and use conditional schema to restrict the property?

Hi Will, Robin,

Do you have any suggestions on this? I have followed existing ACPI approach
for implementing DT support. Will it be fine to add separate compatible 
string
for Nvidia Tegra264 SMMU to restrict the usage of CMDQV?

>>> Add a new device tree binding document for nvidia,tegra264-cmdqv.
>>>
>>> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
>>> property. This property is a phandle to the CMDQV device node, allowing
>>> the SMMU driver to associate with its corresponding CMDQV instance.
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   .../bindings/iommu/arm,smmu-v3.yaml           | 10 ++++
>>>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 46 
>>> +++++++++++++++++++
>>>   2 files changed, 56 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml 
>>> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> index 75fcf4cb52d9..edc0c20a0c80 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> @@ -58,6 +58,15 @@ properties:
>>>
>>>     msi-parent: true
>>>
>>> +  nvidia,cmdqv:
>>> +    description: |
>>> +      A phandle to its pairing CMDQV extension for an 
>>> implementation on NVIDIA
>>> +      Tegra SoC.
>>> +
>>> +      If this property is absent, CMDQ-Virtualization won't be used 
>>> and SMMU
>>> +      will only use its own CMDQ.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +
>>>     hisilicon,broken-prefetch-cmd:
>>>       type: boolean
>>>       description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
>>> @@ -92,4 +101,5 @@ examples:
>>>               dma-coherent;
>>>               #iommu-cells = <1>;
>>>               msi-parent = <&its 0xff0000>;
>>> +            nvidia,cmdqv = <&cmdqv>;
>>>       };
>>> diff --git 
>>> a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml 
>>> b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>> new file mode 100644
>>> index 000000000000..f22c370278a3
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>> @@ -0,0 +1,46 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: NVIDIA Tegra264 CMDQV
>> Missing blank line
>
> Ack, I will correct this in V2.
>>> +description: |
>> Do not need '|' unless you need to preserve formatting.
>
> Okay, I'll remove this in next version.
>>> +  The CMDQ-Virtualization hardware block is part of the SMMUv3 
>>> implementation
>>> +  on Tegra264 SoCs. It assists in virtualizing the command queue 
>>> for the SMMU.
>>> +
>>> +maintainers:
>>> +  - NVIDIA Corporation <linux-tegra@nvidia.com>
>> No. It should be a person. If entire Nvidia cannot find a person, I
>> don't think we are interested in having this in the kernel.
>
> Okay, I'll add Nicolin as maintainer.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: nvidia,tegra264-cmdqv
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: cmdqv
>> Drop interript names, obvious.
>
> Sure, I will update in V2.
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - interrupt-names
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    cmdqv: cmdqv@8105200000 {
>> Drop unused label
>
> Okay, I will remove the label.
>> Best regards,
>> Krzysztof
>>
