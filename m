Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0225742F
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670078; cv=fail; b=WLuNM31YDtMaULiMX6CBNaG7MJwDkOEOWbl2ZQ9jy7+doyugca/zqWyqUcn8ZwT/fC7OaBb8P9QA+dOPiwSkvcBxKOp6qTIdW5dUxzz5nPRR8j09QZQZob6DPCRgek+kJP0WHUET/rpJ5Z5UzpIlxQwOWzz5gvv8c9M6G/TscX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670078; c=relaxed/simple;
	bh=e6Oet9klaAVKCoBYYcGpMZPN6xR6hsrtS5oAIn7RbCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LjaZAWjPXd0McN07jJev8M+ZV4zDIAjK5cBb874SUAgslptJCHFMheFQFDPrdVLTQNxoCt1z3zOzCm/YWVKFsZVzrelC3t48iOhVn7Da6zUsKfHSG1i6NYtRTNBPiqBw2t6f1Z0v59XrJm15wicPSRqBcr7spXwftWKazWUOtAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q6lQFpmd; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q6lQFpmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xl8JoYm0iu0st99VveFn4HemxOKMezZvqRPNRKZcB5iXP/J6hn12GJ5B59FnPP5UrYb2TyAk2r7oYV72qb+5IMZ1TktPaUgv9bI87Lw5BgVhNXHXe2OBBxkM3MIAtKAiijDBQi5zddNeG2BdhokVH2G+Uh56sByAelhhf4iNWj8zp0fji6DP8UEcklx2wjL4yNDT5wNTKdqvvJucS+y2m9iChonRrOBNopmzSR1w+nxzVicAGIrnpSf7ChbMtVDlvhZ7S7GXv/8sqD0m5vP5tljxLSZaU0NnYzQ4F/iUZLscGb0BHj13tTBZL8DMHpP4+5edc7Iw5kreGIc4Roo4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBxWoiuD3qFDilsgvYzAX1gb5B7CCgvvt70mMTNiYHY=;
 b=G1/IXfiPMRYYxXnsnSBYZCsL6rotmixHSoDJ2lHcDj0w3GLZhjlJqOok87wNynoFpxlYMxh9qu9y9RpScGDjRT7NtRV4Z6hw3Assd+wDf+AcDhguHqljXLd4uHinlcSCgv5lMDJoRdUkt3L7cz1TEcfBN74BKc0y9UHjXHTn9onbW+4jVL5aoy5KB9c54s9Iic79FykAp5MHYZZb+Dz9lBO0nQ7x7BO7XQq9ZVCBxQDMe/ogumKSulb3GBZPUVrCX+ALQmipZDEmgq4/Mg8i7kKWDXMRENVBHZCZCoOnXQEg3O6FhKrltnKpExtrW3l5wLNI8c0K6BzoLc7nOLBa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBxWoiuD3qFDilsgvYzAX1gb5B7CCgvvt70mMTNiYHY=;
 b=q6lQFpmdGFix7gWfCGNT8ZxteTlI0CGfLcY2Hu0We4qrq7H6RyW0looIhJs8DfCqRoGRglSDPIuPvxC8A/1e58szt5Z4ZoH/gTJDAKwrELLFwddVrLR+NUPwYVW/UCuF9xRzjVa3D4+l0aKT4hx0eNiBA01EL+jnB/hFbxeHZ5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Thu, 27 Feb 2025 15:27:54 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 15:27:53 +0000
Message-ID: <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
Date: Thu, 27 Feb 2025 20:57:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: cf341a13-45f3-4cae-1dd1-08dd57434dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVYxcE50azZXYlo3enpjSGczRklKTEh4ZWd0emwrbkZXLzNLSHlaNG16enE1?=
 =?utf-8?B?QjdUYTh2SnJaUkRCU3JxWnZZV3NCK3ArUGplL3VJMHR5MGJENGZMUHNSVExJ?=
 =?utf-8?B?N3FWdDM0d3VoSzhLZGptVk8wK3RVbmRocFluNTdDRnIzVjlJZUFyYUsvRm5C?=
 =?utf-8?B?K0gwU2JIaldZT1QzbitvSkNkQXFkY2MzMXFZZGJxSlJUOVpTNTkvbi9WTzZB?=
 =?utf-8?B?MUhPTDBNMVlvcmMyTm02UjV2RjJrL1NsRFp4UzNkS2dDK2o1MmZ6aG4zVU04?=
 =?utf-8?B?U3U2WHBBb0VCV3F1YjhPdjJEVllOVmVEWTBCTGFDdUdTUnpRSXIzQU15R3Jq?=
 =?utf-8?B?NlE1WTdkWk85ckNCV2ZCY3pXbUwwVmZQeExGbFQ1dTFOZFpoUCtESk83aXhq?=
 =?utf-8?B?K20yYXZlcXo5UDlzRTRvdjhwSG5QaEEwYUJGTGZHQzBheE5yWlViOUFsYmNE?=
 =?utf-8?B?SGt5bG9mNVMwVEdXc2t0dmM1OXhFS21BMjNwR0hRTzZOMjhoS205UlYvcVlq?=
 =?utf-8?B?cFhQQ2k3U2hIaXZRak5IZWxtNndmYnpUNGRZNmVGOHpkMi92blh1ZE9hRHB6?=
 =?utf-8?B?dm1LZHlDMks1bVhRb1c0Smp3elY5dURpWjlkWXVTRXlud0I2Nm1HVkFXWEw4?=
 =?utf-8?B?eVIvUkVRQVRHeFZaS1FZTUF5cTQ3UnJxTTBpNnBsSkM1V0x0ZmI0NVNJZ1NO?=
 =?utf-8?B?dk1DSGwrT1BVdUprak1BRzhGRG1rTjhNRks1ZUNwQjRDalpOaFNIS0ViVVhX?=
 =?utf-8?B?UnB5ekRxenhKbS9HVDhGM3FYaTNldlo3eVRDWmNhV2t4bDRNNW1BZDhhazhx?=
 =?utf-8?B?eVN3K3RQVE1vNmU4MENTQVduZ2RqT3JpSTJNeHZkdjM2VG1DUHZSaUtvbVlo?=
 =?utf-8?B?T0NmcmFrWVRWbVcxc2RwMnR2NzNrckgwNzYwSzgxVHFFbThkbjcvNjFPbStJ?=
 =?utf-8?B?UWkvZDhYN0tTeG9ibVFJeEdWaWtrVUxFeGZxM3J5TmRSMURJZkcrdmdvWVBx?=
 =?utf-8?B?cEVKYUhYMmNsM3ozcmY4QnJyK2E4ZnlCNTRCMlE0a0xVdk5iQWNLa0l5R3Fl?=
 =?utf-8?B?QWZKM281ZTZPQ2ZxTTZKQzMyK2QrWnQrNEhoQ2xGaGhJKzgweThOTGpLY0Jj?=
 =?utf-8?B?Q2Z2VlZidjd2RFBEc2QycWtPMEFlZ2QyMUwvZW1VOXZpL1pMOVZGVll1SHpv?=
 =?utf-8?B?UTF5YnVZOXE5ekRJQkZBNFJhWkZ0VUJrSm80K290NWNsRnFqeEVvUTF4aGlr?=
 =?utf-8?B?UHNwK3EwYmc2KzlROHRIMVo2K3NGYUppcXZXNlVrZjJrOEpULzIwZU1qYzZH?=
 =?utf-8?B?bVJRR2o2OHk4ZmFwR3djYUIza0xjMmtqNVc5ZXNsQzJrcGUwL1hVUGZEdHdI?=
 =?utf-8?B?b0ZxdEYxK3I3REs1UDE0WkxGWlRyT0xSUGZaU2lKNjgrZCtqWS8wNXQ4YzBJ?=
 =?utf-8?B?ZFk1UkR5TEtvbkNIZXVDQUpBNjlscXRWclVVS2RRanZMaGttNmora3R5MCtG?=
 =?utf-8?B?VUhnNEQwcE5XNG80N2F0QjRyT0VZSWNZOHgxVzBsVkMwOXJLUUxseVF0cE12?=
 =?utf-8?B?NWw4Ukh4N0ZDUmZFdW05ZkoxNHQvL1JhZnhIR04xanVKa2RXdUx3cndMaWQ1?=
 =?utf-8?B?VWJUVUJvVDk0OHU2dWJHdWFGZUhJRDhWUzlGbTkvZThNcXlHN2NWd29LYkJY?=
 =?utf-8?B?S3V5b0d2WDdraStxa1dJNUhwYlluM3RkZ2hLb1BibEkrZGE0aStXRjU5V2lS?=
 =?utf-8?B?K3JQOEEyMVNSSlNNaHpVM1F6VDZkNkk3SWplVXFtTkM1REtua3MwRStPNVlS?=
 =?utf-8?B?WEVXZkpYRzdadXlvYmdpS2xOMDFIWVR2M1hJb2JPbjd5bGdWTXZvOW1YNm9z?=
 =?utf-8?Q?a5Ns00SljKMiT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnBNb0lSdHlycVE5K0w3Z3VCaWhpd3JPZDV0V0J1U09PaG5Yc2pSOFhZSURE?=
 =?utf-8?B?MWJaSTVRMTNycW1hb09mdWVMR3N0NG9IbVR6dk9jWDE2UUN5alBZQ0JyTVJa?=
 =?utf-8?B?MzdXVU8wSUoxVDQ2YWp1WlhJWTFmeGJRR1BrL3pIa2c2cXNLV1QxZUtSWTVK?=
 =?utf-8?B?SHpRY25wTWhUZVJ2a2libWU0UkUxbHZqYXFmOEZFb0M1Y3NSeGpPajZLTmtZ?=
 =?utf-8?B?eXB2UkNKTnRHdEg4RXpSYUtGbFVTYzhkM29obG45QmxpaGhtYmVSQXdRK3Vr?=
 =?utf-8?B?eHliK3dUVzJKWVFTc25aSVNzdklNTlVobGlJSXkzY1NTWnNRZFJ0OFlRWWJN?=
 =?utf-8?B?SUxUdWo4K21rZGdwbk5WZFlNekhCUWJwSTB2WjlGS2R4VWxzS1JhdkZnRTVt?=
 =?utf-8?B?UXJpdDFtRkVPYk1vRDN3RUJZL2RRSEZnSklpU3B0QVUyVVdSdmthZHN2U1l2?=
 =?utf-8?B?U0pPNWdhN2VRVGFIdWxwN3NONENvSllEWjJCYzNrdnJSSG1lblh5R2FkQ3Zp?=
 =?utf-8?B?OUd4ZmwzYmJGTHNKSzdiK3RFaGIyb1gzWDdpczJtVm5xUmg5WlpNOUY4dTVS?=
 =?utf-8?B?QzdrWWtQUjlvbzZzdHpoVHlmQThaK2N6ZUZDcSs4bUs0cEg0SlRiZy96OHVk?=
 =?utf-8?B?MFNHNlR3dTBpU1dJTHk0T211b2tHeXRJOVNuV1Z5WnJTSXM5Y0RuN1ZYYzBm?=
 =?utf-8?B?eWFPdXJRL0lTVi84ZzE2SVRmVG5jdE5Edk1sYzZXcGwvY0hVait1RjMwS0hx?=
 =?utf-8?B?ZDY4cEhUdTU1MTBTMzdSS2NDMTVTZVRvbGdQSTZOY3ozbzIzTEZoQTNoR1JN?=
 =?utf-8?B?VVdnUUJON0cxa3BOWk51TjVSWmVhTnFyb2FBTVdmNGxMTFdLTk5iQ1BGeDhy?=
 =?utf-8?B?MVA0RGU3VzVwNEdYNVVadCtJcnloell1aFdvVUdIYXpEZC9HaU5WZTBLRzZN?=
 =?utf-8?B?a0xtd0prYXFmYUU5bDJscHgweEtSQXZxTUNXTldvVUZoTksveFNJVDlEbUtI?=
 =?utf-8?B?bERvbUVNWTRTVVBxRTh3cDY1WnMxYVE3NmxaTmQvZEJyRW5mT3J1Q0JLVGEz?=
 =?utf-8?B?a1pTd1N2U1FRMmpSb1NlS1pGK25rMVE3N3prZlltM0JvWHRYc09GcCsyY2RT?=
 =?utf-8?B?Y3d1OEdmSFNYRUl6NFVHTzl2MXVrUnoydTl0VTNKdUwwTjN5MGdON0IvM0Jo?=
 =?utf-8?B?b0hMNXBXeFZEbzRVcnd3K1lmYllUWVF6emN0VTR5QTdUWXNZNStES3dhd01y?=
 =?utf-8?B?ZXBBZjhVS3pFZHZhbGN1SGpDUGQvMEhWZllpN3Rhdi8rSldxZ1VDai9lS0oz?=
 =?utf-8?B?RWZJc2E3SHlKZFJTU2xGcjV6Wm5NeWFaQTBoU1h2YjJKVFdLUmFhZXZpNlZX?=
 =?utf-8?B?UzhXeUJ6UUVTeWdSejluN1A2dEY3TlUxY3pIYW0yZjc5VXMvN0RvT3c0ajE5?=
 =?utf-8?B?NEZHVEw0MlFWV2dqQzNoQWRIWFAzM2VQOU9DY0xiTFVVVHJVUDB5WTU2OTl5?=
 =?utf-8?B?Z1JCR3gyR3cxSjQ3VTF3ZXpHNkNTNDdoQ3o5YzFoMnczTVlrZUh4U1NzWmdL?=
 =?utf-8?B?NExjcnFDVWpWZnE2NXErS3p2cHhEQ2JDNUthc3ZNcnNkT1hoTCtYcGFhQ0tq?=
 =?utf-8?B?K21uKzg1MGxuYXBTSUtFdC9mcmhxcThPWU9NY3JMWHJ3bU1xdWw4UU44MXpu?=
 =?utf-8?B?aHpRVWJLZVNhbjVTZW5vTkVQQi8yT1ZEUkhHYUN0bVVzMnNXZC9zVC9DT1FJ?=
 =?utf-8?B?OUNyVFg4VDhrN2kvWmRHdENGNlFkMGxRMWxmSFpPRjlUSExhNHg0NkFVNHpi?=
 =?utf-8?B?aG9ZNE42UDFxNnZMTFVIWi84akt4STFCRWtVWVd3d1EvTUYzSllwbHdnSjVp?=
 =?utf-8?B?d0RhWXYxTGRHVVRRbDRITTRnMkN4bFpaRnVXa2xWd0piZytoSFJ1MkhmL1N5?=
 =?utf-8?B?NUFaNlhrYUV4aUFiQnpLOWEzR2srSkwwTnpXYUlMSWltM3oxWVNzNEorbTRN?=
 =?utf-8?B?N2VXWVVxaWxLV2ZxcE00RTZYaGhGOTlqTkpnb0ljZ3p6VXdrTk5KV04yTWZQ?=
 =?utf-8?B?MWtFUDVwQWwyaWlvY01YOTZ3MWNJdTg2SnJYamdlLzdBZXlwcWZVMjRiZWg0?=
 =?utf-8?Q?wtcmkpdVPTVkv01e7VYqf2OtD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf341a13-45f3-4cae-1dd1-08dd57434dae
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:27:53.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7+ELrt25+Ils6UwS8DZdlIEocLzfO7tjvhQG2hQrlWxQ7RRLGao35tOL0ClUss8/fVuxx8LhNTNrHDu08s3vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180

Hi Kevin,


On 2/26/2025 12:35 PM, Tian, Kevin wrote:
>> From: Tian, Kevin
>> Sent: Wednesday, February 26, 2025 10:51 AM
>>
>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>> Sent: Wednesday, February 26, 2025 9:18 AM
>>>
>>> On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
>>>> If above understanding is true, my preference is to support a sats flag
>>>> in domain alloc (nested_parent only and PCI/CXL.io only, as the start). For
>>>> AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
>>>> structure is created and updated according to the map/unmap calls
>>>> on the parent S2.
>>>
>>> They are functionally different things, and have different
>>> requirements on the PCI topologies supported (eg CXL.cache vs no
>>> CXL.cache)
>>>
>>> I think they need to be different flags
>>>
>>
>> Not exactly. They are functionally different but serving the same purpose
>> to the user. From user p.o.v. it's sufficient to have a general flag for sats
>> when allocating a domain. The underlying driver decides whether such
>> flag is supported based on the domain type and the associated device,
>> just like checks on other existing flags.
>>
> 
> Chatted with Yi offline. Having untrusted user control a security 
> feature doesn't make much sense. Probably what we really require
> is:
> 
> - IOMMU core exposes a separate sats knob per probed device, 
>   allowing the administrator to manage the sats policy which could
>   be no ats, unsecure ats and secure ats (might be further set per
>   domain type in case the hw doesn't support sats for all types or
>   the driver doesn't support all hw-supported types in one batch).

When you say "sats knob", you mean sysfs interface?

> 
>   It's also checked against the device type e.x. CXL.cache.
> 
> - Then when enabling ats for a given domain type and device, follow
>   the policy set by administrator: ats disabled, ats enabled as today,
>   ats enabled with hw enforced security;
> 
> - Optionally iommufd may support a domain alloc flag for ats,
>   which alone is a performance or functional dependency (by PRI), 
>   hence better to let the user opt. If opted, again follow the
>   admin policy whether it's allowed and requires sats.
> 
> Is this way reasonable?
> 

What I am really thinking is :
  - If HW has a enforcement required (like AMD SNP case where Secure ATS is
must), enable secure ATS. But do we need some way to inform core layer? If yes,
may be have an domain ops similar to def_domain_type() ?

  - For untrusted devices,  by default enforce Secure ATS (may be a domain flag)

  - Have a command line option, so that if administrator wants to enforce secure
ATS for all devices, he can do that.

-Vasant




