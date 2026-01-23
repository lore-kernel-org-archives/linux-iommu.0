Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997A38A299
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 04:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769141667; cv=fail; b=r8wAeGPvUutwJ4pa2Nuj6sl9fqY2VsiWQ1gz+qn3uMwAioxhVtNduq3CV1riNsIYyRQh3hZ5dN/YNeiavzfAyxDvxwr46NcExSC0XoeeY4hecWOEK6MaT90dM1qT9WPvg1WtncZjQX1dA7iOuw9LASM77caF4EZAcTMOdNaKnJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769141667; c=relaxed/simple;
	bh=aHB+tCuJ0IGkfpyMXAI7fcevzLV0RyBXCwPsQUcxAog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TzBad4h6Xdlsf8fkcA/wOEzm4ue6luUYDnp8LohzEo9CdeNMXkCywTzp3tDYoyGH/9ZSpKFmVTDGx7gR507IqUx1+bFE0e35DciYZISedMMJlGI8NHiDXDvxa4zct3+D5DGTeJ/a/1K+Bva+YDJnVG6KW0qfw7mE3uW6Ar0+zZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HRpS7nOW; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HRpS7nOW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAYJoVwlC0nzfKfUus5Z5QpbXfijJ26F+a6MPAGwHiAxHAasGEQ+w//2o8aUbQcSQXw5HB411xMM5UF8vC4BNmjofFVo1tiJ+abVSkY78MNMG5tQ6D/dcl1VSwZ29CTRMYhWieL9mdWvWC7TSZFwhUHDtQ4HoYIXz+qVSoEYL+GUIoORak6PD/Q5sybGV4PE1iHdGgLEO5QEfCt4+T8Sx8NwVOfuorfuHWqU20/A+2Nmt7n0jLBclA4eJorA1VDbXSmfAJlVatTN5UGbmgMvgdNBnRq8I5VZz+A080Y/r+jM2GhCjh9TbnJRQmpIlo59nMgJW27QB92HXSXhaEiobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz9MY2Gk4R8wNU0/VY+UuH2p7SMbCwb8LAzdbXXoVTA=;
 b=jFJ8YpqZtfsg4V5OYTmwnCUb8OhAOMUlr6frMAnGlxcvsHq0m51TxJjzkJl8Gu3ReumDeME3WF0z8y4051l5NQfRU7WTNfehWgSNK6OU6aHHgrNf9cPU3V6ES8yX9WJiWYXNYpCtlOk7pcHiz5euB0nZpzx6aunb+zAWiwPWp0KLv2D6CiHHcm20GzNmh+4A4BVeTlmkhGC551zltDWjw94lL1YSBDMd4o8Rs66wR/waRTF1uUo+BWU3RKT4116w1ed+UTKirUzeS9/xHCHGKWMSVIpw7c/SbAgrdUYdMrdMQeAMNsLubUGV9WVVyvUQq6fAk5BNlAUEScfh13QFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz9MY2Gk4R8wNU0/VY+UuH2p7SMbCwb8LAzdbXXoVTA=;
 b=HRpS7nOWcQbQ5phO9O4lTgeYBRL+47yvUAOiREdRG4SQ8N4YKnRgLCbGqgbpXdGIVMuqQcWGjvDf+Jf4iiGeVAkAx4doOtvOpC11zsE6v7eMJktwxi/1CkBqHBB7pffRd5eKfn1H37QMNhSJjXqpwfTCfsqlFjKZkXhW5OgYmwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1SPRMB0013.namprd12.prod.outlook.com (2603:10b6:806:22b::6)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 04:13:06 +0000
Received: from SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a]) by SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a%5]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 04:13:06 +0000
Message-ID: <1149a2bf-eba3-474f-9539-6329ae7c88cb@amd.com>
Date: Fri, 23 Jan 2026 09:42:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix type of type parameter to
 amd_iommufd_hw_info()
To: Nathan Chancellor <nathan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260122-amd-iommufd-fix-wifpts-v1-1-8ee604527875@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260122-amd-iommufd-fix-wifpts-v1-1-8ee604527875@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::9) To SA1SPRMB0013.namprd12.prod.outlook.com
 (2603:10b6:806:22b::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0013:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: c36208f7-6d6f-41ee-c6ae-08de5a35b5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3ViNWNveUovZWxXQXhrL3JjZXF5MFBvZ1VpdE51cFNGTWpENGh2a2VKVHp2?=
 =?utf-8?B?Vzd6bjlLWC8zY1FOSThlbjMxY2IvSGZXcnVxTmFZS1J2Tko5TjBWRi9PWWh5?=
 =?utf-8?B?WjE4SnhHOFlrb0hrZithZGhGSTRjdVI2QjdNdWRnMGoyYytkSEtHUkpBUG9h?=
 =?utf-8?B?ZHFKakRLSWZ6UGd1MHQxOEVacnUreHg2SmVZKzN1bzgzSEdBUi9XVFJiSEM4?=
 =?utf-8?B?OHIyWklTa2pUWUh1T25rZThsTUtIT1NoRFRvWjVIcnNOU1V6dkVXdGdYSC9k?=
 =?utf-8?B?eHZFR05qZEJjZ1pocVY1MFhoTlFJSDhVRFlwQzJLVUlsUXgzTzBvZTRiSndt?=
 =?utf-8?B?TlZXMm4wN2p1a1hWK1dqNUc5eXRWMUR0YS9QOFRKakd3ZzVXQUwrRWp0eGRx?=
 =?utf-8?B?RUcxeDNIcWUwdkxhR1RUWE85dDkzYndmSEFMV05IZ0xJb28xd0tteFp4Y3hM?=
 =?utf-8?B?Y01sZGZ6VzljcjBOT2I4cHBlSUJXRHZvSFQ2WEcxaFRRandMaExId3hJQVZH?=
 =?utf-8?B?bk1DSGZaajBsQU13WndGWEVoL1RCVlY1ZmxkNjNTUGZheXJOZUN3WWRUajFG?=
 =?utf-8?B?eVZUOFNydTlEVlluMkxLWW03c1hCSjk3TDV1YVFEcncxY001dkJZTUhDdDF5?=
 =?utf-8?B?NkdtTVhLSEl0OU9tc0Q4TmMvVDl2Y0pIUEdXYmwzNTV0NlM3aUZvajBFZ3pF?=
 =?utf-8?B?bzFTRC96MmpPWnowN2NJVDhRbTN4RDZTUTRMeWtmeHVuRUt3REJIUEYzQU0v?=
 =?utf-8?B?V24wWXJSem5ZQkV3MFg4alcvN2NNV2pIc3V0K24zOVhyTlBhWHpiYjdVdVdw?=
 =?utf-8?B?OEphR2NhNlJuN0xQZk9kc01FUkFocGZsdDFXVnpTUDNsSWR1dTZIQ2VvbVlM?=
 =?utf-8?B?ZHYrQmRVVkdjYmxaTTh4anpiWjM5OUZlTHh1OTM5SThaWjFlVWI3NTZNZUFu?=
 =?utf-8?B?aUJBT0tXZEMvNVRSRGE1Wnh4OFFzblhJQmc4TE5GVHM2ckpsd28xUW1DWWx6?=
 =?utf-8?B?bmhHcDk2dmdIZlpVNm54SHF0MUtvRzZaSlhZKzFHUkNHaitabno2cGZJMzJq?=
 =?utf-8?B?QXJ5TmpwUytmTXFYUnZMMlUxdTdjaWRrSnM5K0M3a3ZYN0gzVmkvWjA3aVlk?=
 =?utf-8?B?blJ4cHJOOXNZWVF3VkJrSG9ZcGxJNFNEaVNENTdDcWdkOU9yMHdxeU5FUGxt?=
 =?utf-8?B?YmZuZ3FqRHdYb2tnUC9GV2hiR25VbGF4anJ0bmg0WFpGZnBFWGM4RC9Ocmdh?=
 =?utf-8?B?U0FyL0VockJsYThCdUJpSTBwOGhacFhrSm9WN2o1bXJPWWt2cy80MW1FWGdU?=
 =?utf-8?B?Y1V1SHRvNHpoOWQ0UE8rNEREenoyRjB3RzlzU21lMXBSbldGeW5ZSVNQNjkx?=
 =?utf-8?B?aXBFQXFMOFhqVUFXY09ScWRTNkMzUmVGT2lkOFJGci85Uk9TMk51bnpDUFZw?=
 =?utf-8?B?YVhNK2xnc0ZkalF0NnJQalpLbUd5TW43V05JOTFwdGdKcnZ3VDNscXR4aUpM?=
 =?utf-8?B?NzhFWXBkcU8yLy9LOHpQTVhlUWdZY045UVZua1pSZGNLS0ZkNndacXZ2OFN1?=
 =?utf-8?B?ajNIclkvRmRha1psR09XaU9VZXovaklGbVVyMWJDck1PZkRPY3M0RWFrbFdE?=
 =?utf-8?B?SFBBSzd1Zm5oQXhHNUdIN3J5TUcya3JieFFieTRyRHFKcXY4Q2hEV1dEdTFi?=
 =?utf-8?B?OHlQaTc4cXQyVmNkMXozK3g0ZzcrRlhXTEVDZzJJZFA4dFo4em5lNnN2QW9X?=
 =?utf-8?B?aUxUeTZmR2l2TjB0T2RDS0pJTGU4SzFmNVJMTjNPMXVrT1NZVXlIVE1sWjRP?=
 =?utf-8?B?dUNkY2pZZ2htQnBmZ21lSFM0OEsxd1JyekN1U0JaWk9pZjExUGExTFE4MEta?=
 =?utf-8?B?RVo2VDlUeXpqRWlsZXlCRW51UlRtNU51bFlTSUluYitWWnNhZHB2NWhKdzJw?=
 =?utf-8?B?RUdDZGMwYVN2R2RzMGI3dE93T2ZrMSsvYjNJSW1aaitsb283aTJSQjB0ZU9T?=
 =?utf-8?B?VjgxSWM5elVoeUtDejRqYkNWS1JuVldwVEVBWFp2L1Q2SXBGaGswK2hWZmlu?=
 =?utf-8?B?Q2xZdlFKZGs5ZlNBVXMvUCs1UlBNMjBlbzBTKzI1bVhhR21oNkNvcURib2lX?=
 =?utf-8?Q?8yNo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1SPRMB0013.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0g1czgyY2toMUU1R05RNUJmMlFUT3BqaXhXK2xWSTJ3aGtZUTZsNlRlY2o4?=
 =?utf-8?B?MDZsS1ZGM3Qxd0NndzdnamRxMStSSHBXa3BRcGYxWjZ5ZXE3ZjNWalkybG9L?=
 =?utf-8?B?Ums2T3pYQnZrV3lZdUl4T093VzI2MlNtWVhOREVmMUNOZ3hJOWFpcmx3eEQ1?=
 =?utf-8?B?YldIZ1d0aWtOSmpjMHJiQ0toVFp1REgzV25DSCt3cW95aHlmNVFodWc0MTNZ?=
 =?utf-8?B?b0JrcWl1U3lwUk1HdU5wcEhrY2U1cytaMEwwZlF4RCtpT2FUaDZJdXE5UTli?=
 =?utf-8?B?NDE3ME10NlhiR3dYZWxycHlaTjBNblYwR1daWlFqTFp5ZktDY0tDejluRTdO?=
 =?utf-8?B?MFdjSzNCOUt5NTk0SlZ0U1hkSDFCMm81WnlwdDQzcVZZMExzQVR5V1FjRit5?=
 =?utf-8?B?ZkU5M2MwRlZDeWRPOFMzTlAvbEMxS0xsRVV3Zjdmd3JEaWhSTXN3T0FrNzdh?=
 =?utf-8?B?L1dBcDRNWkNLQ1ZGWVo3Q25qYlRkaDQxbThHeGF5Yk4yZmh5WHo2WXV2WUFR?=
 =?utf-8?B?Qit5K3dNY2xjTHlDRXRoSEU5NjczUEsrU0JUWFhhNnFLdFFQS0dOczVhdzJD?=
 =?utf-8?B?SXpnRlJXRENDSXNkSEZpelFmUUhMaG9OQ2lTSUg3RXZVeC82TlcxREdHTWlB?=
 =?utf-8?B?cU9tZXMvWmdHMmVBUTRySnZYTG5FL3VqK2R2aFhpTkxLbHp2b1paRHhycjAy?=
 =?utf-8?B?WnhpUWRpby84Q1Q4U0Uydm1YYnhNUS9NNFhNclBHaWE2T2Y2SHpWL3VaQWta?=
 =?utf-8?B?K2U4a3BUTWtzN0JFZmtVbWw3ZXRVUWZZUkRQWG9OZnpiT05aSnQ4MVA5eHRh?=
 =?utf-8?B?dlo1KzhROTJ1bjlLd3kvbktjdzRicUt1WlB6SW5DZGZ0NTU4VkNWZDIyMlVq?=
 =?utf-8?B?Y25MMitUQVVLa2tyWjUzZHl0MndCVTNBY0NIcXZoM25ZMEYzMEZVMk43OERF?=
 =?utf-8?B?eGNnSStXaWl4RU04UXRrT1h3VFhmYU9GRFdSV1FPbVRVSmtVTkdUS0RLNzhD?=
 =?utf-8?B?T0d2MGJ0eXBVeXRRQW16ZmxCbWFPcDN0WDlVaVZKMnZNVjF0ZG5keFU1ZnBa?=
 =?utf-8?B?ZWpNeFNPbm03VExjU0V4UVV2Sjl2WmEwaEp5WGppY09WU25xTDZsSzBEL0xX?=
 =?utf-8?B?SzhYY3hCQmYyeG5JWUdodWVqOGFDUHN6eXViV0NRcFJrVGZyUC8veVQ3bExv?=
 =?utf-8?B?SmFWV1dJOUVDZ2tBUWZaU3A3WlhBMDZkUVUydWJVMkx5ZG1SaVlrdXcweU9w?=
 =?utf-8?B?TFdybS9zdm5LeGYxbVNGcTRVVWV2ckRsa1kzV3NMSERyemEvMVN1ZVQvbVFv?=
 =?utf-8?B?b2dLSExkcG40aEY4empsc2RtOUtOQTk5dUc0OUxiWTlzQkxtRE9iSHdNVlJH?=
 =?utf-8?B?d0RZNStrdlN3MDRnRFVuQ3ZPQkw2OE1GQzQ1MlJpd2pEZFhtMWxhaWNOYVhY?=
 =?utf-8?B?cytWUGhDQUxHbW5KaHhZQTRXUGNPZ0J5RjdXaVlhSUd6VGd0dkJSaEZzL3I4?=
 =?utf-8?B?TnZaSER3emphdGk3TENzdmpWMzJrYysxQ0pvM2dVR3ducDc1ZmRPd0tSVWpS?=
 =?utf-8?B?cnY5cTRuMkpGZXZwRk0zVmk2Qzg0RHNCQzZFQmwxSFcxYXhFaWVmaFl3VkNX?=
 =?utf-8?B?VkhpcFJvSG5PUEhQbVcvQlAyRllqQmJwQUtjNzYyZDRqV0IzZ3RWazVqNHQr?=
 =?utf-8?B?bjZQLzIzQUJpb1J2VCtWN3hiRmFBdmdDMkU1UVV1Mk8vdVNIYy9MbUVEblhM?=
 =?utf-8?B?ZkNjSWJWRXBXMkRhOG5pNFdkeEpyUVVXVTF1Vzc5NDMxKzgyRVM0S3gwT0tN?=
 =?utf-8?B?VnZkYlAvWnorMHExY0FSWlFsa0tySnJXRXlSNFZYV0RwSVRPc1pSeHUycFlV?=
 =?utf-8?B?b3V6aWp4S3pZTkc1akt6bjZ0WVQ5TTViY205MXo4clRQbmVQQ3QyTlo4MGRM?=
 =?utf-8?B?SXpiZW56SDZtT09ZSmltbnBoWEwrazlFbjVteTVNanBTTVIrMkdRTUlpRktY?=
 =?utf-8?B?b1ZWV2Q1RklYekpiTWtxM2VoSkdHWlBUWVd3TjMxU1BXSHhlM2JjaTd1aE5R?=
 =?utf-8?B?OUhxZ2lZY0htZmNGR1ZMWWExYms1d2xlWUVOVHdWRWtpMkJBWFJkWG50R2Z4?=
 =?utf-8?B?WDUwdzMyYllqTmMyKzIvandXT09nQ3IzbXoyNGZHS1R3WWZsc2MyNWtjL0VZ?=
 =?utf-8?B?K3RsUGk5YkRsZG1OYnU5TDlGbTJWUEZoT0VodVJNRm84MXpLRHJBZk9ndU1n?=
 =?utf-8?B?S0FuNE15U1pNSGJPQXRsZGllMUZ1Umx4SUM3aDFjZjd5U1k0N0tvMGJQOWZl?=
 =?utf-8?B?YjVBeW9HeE0yQnJkSklYdEtyT2FkQ0VUZmZscCtjQnYzYXFidE11QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36208f7-6d6f-41ee-c6ae-08de5a35b5c9
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0013.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 04:13:06.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq8uSKL2FoLirxAiPLND/qvqpXsErrLucdrbs5xeYAoTxRMrc1W1VW3V+I9H7n7UCZMy/bNnHC3UOU5Dhbgh7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290



On 1/23/2026 3:12 AM, Nathan Chancellor wrote:
> When building with -Wincompatible-function-pointer-types-strict, a
> warning designed to catch kernel control flow integrity (kCFI) issues at
> build time, there is an instance around amd_iommufd_hw_info():
> 
>   drivers/iommu/amd/iommu.c:3141:13: error: incompatible function pointer types initializing 'void *(*)(struct device *, u32 *, enum iommu_hw_info_type *)' (aka 'void *(*)(struct device *, unsigned int *, enum iommu_hw_info_type *)') with an expression of type 'void *(struct device *, u32 *, u32 *)' (aka 'void *(struct device *, unsigned int *, unsigned int *)') [-Werror,-Wincompatible-function-pointer-types-strict]
>    3141 |         .hw_info = amd_iommufd_hw_info,
>         |                    ^~~~~~~~~~~~~~~~~~~
> 
> While 'u32 *' and 'enum iommu_hw_info_type *' are ABI compatible, hence
> no regular warning from -Wincompatible-function-pointer-types, the
> mismatch will trigger a kCFI violation when amd_iommufd_hw_info() is
> called indirectly.
> 
> Update the type parameter of amd_iommufd_hw_info() to be
> 'enum iommu_hw_info_type *' to match the prototype in
> 'struct iommu_ops', clearing up the warning and kCFI violation.
> 
> Fixes: 7d8b06ecc45b ("iommu/amd: Add support for hw_info for iommu capability query")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks Nathan!

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant


