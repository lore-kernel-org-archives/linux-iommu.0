Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE522DF9C
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624539; cv=fail; b=ASqyFFFKp4L5t7U7SNlnnG5p6yulIpdHKPVPUZooJhzMLf6Q3EmG3HFnypkdYwYKessmY+/9xoAeQING2ZbDpoxjy6ZgAhIdVje9NHEXKMUhO0iPkvRXR6VfUoZA/OgzJdQsqX13kvwlS72SH1h5LudfIfC9Vo1r0OaJuevlJ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624539; c=relaxed/simple;
	bh=GjgpiNH/WRMjuuMbCAXHYz1fBGskphSKYKgrESj49vM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQidzdM/Kbudomp/bN8flW7GxeYEvxATQh+aOo7pHbB1idzW7dMNLGsTjN16dfHg85rPKxTqryvvO7eI9L7iD7oAxaFY3M68CXy6FFDVqyOCbucynUX2rUh8IBBsq8d3DQ7VKR1XALmGzJf4i9t9Dg5+hw8W2GENhjG1i4dOdKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0dhU/TZE; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0dhU/TZE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmHeD56zfkreleKb7ARadCBZjaumcQMMnuX8hUJFrLPFIpjw3Vq9pIg7IePhhTnVAWJoS4YWlNV2nJsxYZAgcm8stZFehO1Y3hRncHfbhUDbV6JwwIuSmDZ6h3BiYJfgqKoiFQ4fpIATGDcOzs28gfvLQ3F3sXPsU2BH36xJ1RIJDvRMFEMgV/aZlSAtEo1OMlEFImY3tzelVkCbc8FXeen+SnxoCe/n3jIo81UodOnVzW+uk7CRD+g5R8GcOcjSE5uXbSN5rn3kinukXaa4pAraqJsuRs4NOwUkPNQ+XzB7Zqj0mW7z8Gg2gXs4KUGtmlwPMugbRvNoBY78c/UGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGTRE4pjMQx2YJ7hZfvY7Pzi85eUPFYxRvBz1jP4dII=;
 b=jvfMSdQ/jKqeSf7h95q3Jx/QFbsTLeiEHCa6365VA0uCN4Vyzt6aJsJ2fyG/qxpK6H/zszAFsvxdp4NHt2hBiHxsJmBZiNwdlt3MLX2o0ltDdwBQSowireeB/1TgzqHTEQBD/K1iJZbxmw/gUKE6YOO3bEoMRYGuzF6EYUd6X0CPX1N2x4hM+cjQHk/9+UWqWzmNhDsPxtVtguMRKN7pvQvLvUdOZrBobqKgJVJjCH+H+HR+lUWd3+cR0FWKa+gJZ8exwBZgoTlGmFMPbjA3rb32Ydt/Gejfy0WNl1ozWnWc2fM2NetkeTpZXXzJj2rTR491K1xOqgYUyYp8JKfmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGTRE4pjMQx2YJ7hZfvY7Pzi85eUPFYxRvBz1jP4dII=;
 b=0dhU/TZE0DjbYWZ0iCNly4+MVWwOooxlCLB7zRFt5YNEVgVrNocGJIebl5fI7j24Yc5s1OFBx5MM1AdDsRfqbkAwQHQ991HPTWMIudf47WDkW6LzuPs3g1szCs27K4EuXblPHNciOHJQl2iGIDGD+XSmn8EbQF33rQJA0GhdcYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 16:35:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:35:32 +0000
Message-ID: <6eb163ae-653f-46f3-bcbc-56a8fc8072ea@amd.com>
Date: Mon, 10 Mar 2025 22:05:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <391a2333-0373-4cd3-a858-349230bc7c90@amd.com>
 <20250304142402.GB5011@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250304142402.GB5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: b410c78a-0813-452e-288e-08dd5ff19361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTl0NnEwN1Yxb1hLY3VLRHdKQ0pqTzJlcjliTC9jMEFheG5XV3ZaaWpzVmFH?=
 =?utf-8?B?bHpwMXhnZzBaSy9Qam45c0c2RGdlWlR5NEtDbDRUR1BBTE1lMVFGN0F0cFRl?=
 =?utf-8?B?ZzhzV3JrcmFrUDV1dVNCZ1F1UWpwS0p4M2t3WVlta2NJcmFhQndIaC9rMmJy?=
 =?utf-8?B?aG9DUlR5UktlUnVoYm95UjNFUkc1RGRmQU1Nc2xwKzk0MHExei9IZnAvWnQ2?=
 =?utf-8?B?OHRReWhXZXBIL0dZcXdEK25QbDRUeHFhdGhmdXR5RGRsUVdyRUFKUUw3Wkty?=
 =?utf-8?B?M1E3aTdIWW9SaUhNc1J0R2ZkY1pWZVlpcGRGWi9OaGU1K2htWG0wTmlXdXV5?=
 =?utf-8?B?L3Y5TFpqVnBYak5haGtUSDB3b2YzZldqZzAxd2F1WXh2V0tVQVhPSmpGeC9u?=
 =?utf-8?B?UDZTTDdtODFPRVE3VlUrWCs0RHV0eEZ3aGd3RTdzV2VTWDYzV1BrUG1FVm9W?=
 =?utf-8?B?OENhSHR6UThRd3dveUVDVWNWakRmZFU3Nld6Z0FMMHU1SCtJV0g0RlNPZ215?=
 =?utf-8?B?d0t6eVUvcWJVM3pjV1RCMjBXRVdCMnpLN01GRzBYMk94T1VoNkZZYUxGdDZ6?=
 =?utf-8?B?VGxHMExwMG5wSDZPdC8wSngwTjYzQ1ZRTFdST3gwbmFLVWJHa3kveUkwbUg2?=
 =?utf-8?B?bjM4RGxDM1JRUHcyd1pKYnkzOFpSSEtKZmZpUGNjcks5dWdaNHYzVGgrV2p2?=
 =?utf-8?B?U1czc0Q5Z05JeDg3Wkp0dk1IZk9Ed3ZpMXEzRnB2NU9UR25OSFRsYVZxYkZN?=
 =?utf-8?B?US96aE1LTzBaQUVLSENlZzFncWV6cVJWSTdjLzhVVllQMGdubVZEbVhoM1d5?=
 =?utf-8?B?am1FMXh6aDNMdm1kUERuOXZmOHNsQW90S29CZEx4N09YaWY4bFZJNW9iSUVF?=
 =?utf-8?B?UzluekJHUG1IWDdrRFVCdDcyNlJoRlB6azFWV215eGQ0THV6MWdhRmdWVDZQ?=
 =?utf-8?B?QW1LMGJLU0xxcGlOS0dBZ1Z1UGlsenFvaEN2Nm12cFpzUUg2NWhVblhicUxl?=
 =?utf-8?B?ZDVDQTVmZEczMzdMdWMrWkxMckZGNmJ1MmZobnU4TkIyL3BVSlRkY1NZSHdL?=
 =?utf-8?B?OExFbURRU0UwUkErYS83cHJPc1JIam8wU1JJZUh0RVdSSTRYOFZTbkpEeEpr?=
 =?utf-8?B?OWlvWXpFVDVwZElDc28zWERoSStJTy9PdkV4TmRYOVhQTVFkMVN6d0tEY2hs?=
 =?utf-8?B?dE16ZThoYU50MGdXNjZ6MmI5bkd1a0RpZnFvSWRIMDJub0FOS0dyQ21VQlJI?=
 =?utf-8?B?WWwxRzdBeVRjS1IvUFZvZ05kRnZENkdUT3dnSit4NWorRDBBRW1aNlVXK2pM?=
 =?utf-8?B?NGg3c1dueHpSanJ0SEFCcHpXWG5ZM0ZvK3BZbFkyenVYMWMxL2ZVYTI0bUhI?=
 =?utf-8?B?V2U4dU85azBBdGJPcC9JSmVqbExMdHRNZjFXRzlqMHFQYUNZeit0Z0U1NmFr?=
 =?utf-8?B?bFRVNFJNYUN5OEhMTVBOdndGV2VqUnh0UEJuV1N4VlhHQk9mbjZzWWFsRVpF?=
 =?utf-8?B?MDh0ajd5ckpjcTVPWlJOcFN1TEZ2TTM2d09EQ094U25ESGNRYkhCbkl5WFRq?=
 =?utf-8?B?cmtPY3h5RGhoQUZXUVZvYmpKeXhNNUJ4Tzg2TjAxVVFnN2VQc1l0Z3ZoUkNx?=
 =?utf-8?B?WTBIdlJOaENCL1VtTDBTU3ZkQ1d1L3pxZEFEQlc5bmNqT3dmNG5ZbTBaNUtV?=
 =?utf-8?B?T1l0aGQ3NWFhZnpkSzZGVklRY0RkM0pWbUtNNTJCY25tSENwVnpvOEdQcDlk?=
 =?utf-8?B?alhqREpsVHRIT0NJZnRBQzA5WVpxRW42dlJwbjdDVFM5VCsveEdsdWtFL3VD?=
 =?utf-8?B?TFZURkFWRmhRMFFrTTBtdGxNUjRFRStYdlYvVG85QzBOb1pMaS9KZXd0VGxl?=
 =?utf-8?Q?BttirNY+1icnz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEd1ZE14S0NYaEgzSkNsTitnN1djYm40Q2lnT2p5VlpnTEVBdjEzVWU1dTY3?=
 =?utf-8?B?bTRrMi9LV1dXUHRTOTFNcCtsRllmdmlPcm9LWFhyL01Sa2R0cVEzcTBwVSt5?=
 =?utf-8?B?aUFuVURsMzZyQXlERENieEZkdG1CZlF2aUFnc1JFcU9makp0UlIyOHBaNGdM?=
 =?utf-8?B?MGdQRnhYdlF5b1U5eE5kTUp5VjQvK3pUZ2t4MndQVWE4RWRTV1JzYUU1R2g0?=
 =?utf-8?B?dE52dlNzZjJhOEI3bU1uN1BwNmdmODA3ME5nb1ZiSWdCUmlaYkZKZjlGdUVS?=
 =?utf-8?B?MnJGM1JWc2NLTnZFNlN5N1F0bjdrMUVBVVRvSmg2eThLeURRV29KcmZidWlh?=
 =?utf-8?B?TW9kYW1EK2wxdFI5V1I4WlBRb3psNWJqaXFDdUQyMUFHWDdoYUxnRGpUVlJn?=
 =?utf-8?B?T21ZVXRheUZWYThEK2xISVhPM3hNbEcrOC9tZVlmcWlYY1dwNCtTVmR4blJQ?=
 =?utf-8?B?WldieElHVDZCbXRkN3d2Qlc0WTFTKzJBZFV4YzhoZVF4bWpJQmZZRU9PK28z?=
 =?utf-8?B?ZDdDQVRFeG9NRmNpbG5OWER2dXk0Uy82N1d1UGpPTlJLR3BhQ1N5MU5tdWg1?=
 =?utf-8?B?UUFoNlp4a25zMTh2YUVZbHRVNlFXdm4vVnBMd2RNTkVseEVyR0VmZGZXaWE0?=
 =?utf-8?B?ZGVWRlNCV2RCMEk2U3Y1dkdTcTd6TnhuWVpBTXRWTmZMcGlzaERwcTZlSEpT?=
 =?utf-8?B?enpEdlB1VHRoK3I5dVVZMExFclhYanUrUHJxSVdLLzB1ZlRnekhxaU9hUy93?=
 =?utf-8?B?eEQwQkowYmZoMllYZzRjU1BGblI5K0dzVUx3bGozT2k2cE9RL1doUk00Tnd6?=
 =?utf-8?B?RFIvdmtCa3V1akZaQjd6T09sK1hMWFpRcTgzeitmc1A4VGRNd0NZZTBHd1J4?=
 =?utf-8?B?eTJZUGhDV2RGY1hRZUxUN1RLOHAvTVZBZktZZURFVTY4ZCt1NkthSktEZm1E?=
 =?utf-8?B?b0RZOFpGMmYzM0dndnQwZ2RFUldRb0MvWTJ1N0l3T1NleCt0MjJ3OVdkVzI0?=
 =?utf-8?B?eHA4eTZzYksrWThjT0RZdlkzK0lNeUFoRjgxNnNrRUlUWDd1dW9JZ2R3T09P?=
 =?utf-8?B?UHpkUkhSQ2p0MkNwN2Y1TkFsYTBUTVpyd1JidlhmOXhkYWZNb1FDNTBHMERj?=
 =?utf-8?B?RmFBS0oyNVRldDJKQ0tNMHEwVm90emhSdWZyalptc2xTZ3BMS2hHMzJPc05j?=
 =?utf-8?B?bGI4NFFYcHRKRkdhMlhxZ1pjS3ptTVduRThpV09ZbGJ2WDMyVHcvTGxlY0g3?=
 =?utf-8?B?RU02VHNwRk5ZalhzOUw3bThUTDJQditzMXJCNXpnRW5iaUx2VUlTemdLMEEv?=
 =?utf-8?B?elU3MXFVR3VkaSsxSmNFUVZNQkZzRzlpTzJEZTcyaSs0YlVxYnhRd1FDVVFw?=
 =?utf-8?B?NytjNmFZWnpERS9iTnQzb3lsTWpNRVc2YXRRSmpOSWFYc1ZQSzhZTXdzRHZI?=
 =?utf-8?B?OWhwQ1l6T25mNTZyTVRvaEZabGIwVDRDd2tRSWJISEMvL0VRSTZzN3libDlm?=
 =?utf-8?B?N2RDREs0Mi9WcVhJTVFmS1l2NzFGNExmWExQSU1rMi9nNTFDYWh3bWFDVDVt?=
 =?utf-8?B?UUZPbFd4Q29BaDdOWVlkUU43SlNiRkFzeXZGVVVjQlpaMnlrNkNFREFnOTRk?=
 =?utf-8?B?dzR5TjJ0L1B5S0x5cWJOWGoyQjA5QnJES0EvNEw2Z1F2aE8rdG13bFhaS2hO?=
 =?utf-8?B?NTdxZ3d4VkFMdkp6T3Via2grUDJHOVdIVmcwVG1EYzMrMEpDL2k5cCtwMlhr?=
 =?utf-8?B?aHZRV0pjeWFxSi9KeWNFNmtIMlRoYjZrSWgwMERFcUdEdGlTTEFmNGFsR2c4?=
 =?utf-8?B?MUFWdmQ1cGVzSThndWRSSDNUak1EZlJhcmtQYy9wSW1HemQrUEJ1Qi91dlg5?=
 =?utf-8?B?VGdHMHp4TEZ3bnQrSnBNeTNpTTBzZjVpNGlvL0pnL1o4T3pkT2lOS0ZRUDdz?=
 =?utf-8?B?VW5GaUpnQVNCejU4OTVSSjArelRjYXBDRkduUVBLZXhZWW4wZmNOeW8vY3NV?=
 =?utf-8?B?L3B4SG5XY0t1REkrcFF5Q0ZMT0t4d09MbUJRUG1rZElvNytIdCtyRGllYldD?=
 =?utf-8?B?ai80aEMvYTRKNnh3Sm1RM2o0NTJEYUEvK1d4NGFJbVhKK0xHMmRjNWNTZnNs?=
 =?utf-8?Q?/7MQQFxbxi1T25VlwHbnX440j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b410c78a-0813-452e-288e-08dd5ff19361
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:35:32.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEWnE5dJTMODCnAqs4gbz8aESAJifUPseT9xCMYOA5g08G9QFkZ9rwR+Cp022yxIJmFpqDmzGnNYZv0KqQFyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

Jason,


On 3/4/2025 7:54 PM, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 03:45:54PM +0530, Vasant Hegde wrote:
>>>  never
>>>  always
>>>  paging-only
>>>  secure-always
>>>  secure-paging-only
>>
>> Why not just expose supported modes (No ATS, ATS, Secure ATS) per group and
>> allow admin to select within supported modes?  We may have to add more logic in
>> sysfs store/show code path. But user will know what is supported and what they
>> can pick.
> 
> A sysfs type thing is what I'm thinking
> 
> Just trying to understand what options we should be providing to
> userspace..
> 
> I am sensitive that we'd like to disble ATS for identity modes in many
> common cases and we get that implicitly today.

In default boot, we can keep existing behavior right?

May be add more logic to sysfs show/store path? Meaning calculate per device
group supported options and expose only those. And in store path validate
against supported options?

> 
>> Also sysfs knob needs new domain ops to communicate changes to indivisual
>> driver. Like in store path
>>   - validate the input
>>   - make sure driver is unbond so that its safe to modify the
>>   - New ops to communicate to indivisual driver
>> 	 something like ops->set_ats_mode(dev, mode)
> 
> Yeah this needs to be considered.. I wonder if a flags input to attach
> is the right way to go.

You mean add `flag` to ops->attach_dev() ? That should work fine.

I said new ops because that would make updating existing domain/DTE becomes easy.

-Vasant

> 
> That would be convenient for how SMMUv3 is structued now as it can just
> switch modes hitlessly with its existing logic. I think all drivers
> should have a similar design.
> 
> Jason

