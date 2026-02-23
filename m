Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F46345754
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827594; cv=fail; b=DI0TusblGBQITuYBlyHWJp0zNlFWShseE9pYx4lQ9tqwZh1r/FZyCx3uAr5lHvoj8nGFIfG3JqnnjfgN2BYXblt4lU5QYj0z6YkEd3rtBO2lsBLbbew9Z45CU8F4n8B/Pv6nuf4hE7yOgUL8BcN5OsMs5r5ulxgx+jusX8sXf1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827594; c=relaxed/simple;
	bh=faKQI5dJUB8gVqtb343GK+SjLQ+6gl5KjN5pY/NWkEQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mUU7AgyDfOYQwCOaIdIc+gmaiFOo8oi6qsViwUX1+GoUXty2qtYa0SLHh5SQFKqraD9J5PI1aLN/P3BpqMFBgdEALG5YBKjo4uZMwDUiS6gViIaV/uOVY6Ej+QLjX/ESddbp2Tm5b9eHjuzoYXfkrV+FQopCc1xrIy2jAq7xJ3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=liCb05d0; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="liCb05d0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsSNQsqCAIVhW88G0gywauQd8Hsacb2iMWExoX1bzHkVyCKUgwF98MFVytAES+sTuNvI7IKIuTA+BfCGLj7hRiE7Lmnb8nSHCZoKnHAoRAPDe7JapoITWNpleZPMSzP5uhA1htY/UHslW+fZgaXaaYzs9Pa30XiHi9vLhYzhGTDCdp6YYCU3PpkiaS6EsSO2AYWxDekMc8+4Uowe/qvGJN7K/VnHccbqW95TvTMKTuzzIzziP1mB5eBKAOmIkxnqPfOzEy8CBLYUW7U6ouaOxrCOHBKd9XxhF+WPLu9Ncn3BpS6Jsm55ZDgP5sIHX6240Hd0TxaBYXf/FdkoZgJgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXBPhAOUaNlFWL2Y42AgqBbCGUzyNxenxkTwOKm2ih0=;
 b=BvvrY9oFwVvHJ0yFWfw9p089jLVXc61jqr7AuXWKQMRD5jaISbUW3p2oPn83Mu0gCCZO7vHAH48zG9AnLA+bKb0hK4RJ2kqDsvTNwoQNmW8kaIviDCXum6kU2w/qtaKW+z64JsHLszjLtQ6ykpVuaRw3rIu62xu0Bhcoe5XVyfFIrFjfvs8nr/6c3XIhRc5DHgZD2wgH205MEYOUz70yetlEZ4o0y2aawDPn9f++5vwCGqfes2AuOuUrchGcOTdkWTABDFglQBIyY6BEvbODsOakXjVoMpifSKfcRoIlzgqj2BuCv+zqsQC3fLDINBMgk6Hmw7OIrudOFTv7VZZm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXBPhAOUaNlFWL2Y42AgqBbCGUzyNxenxkTwOKm2ih0=;
 b=liCb05d0VFNT/J/h4fhFRi9NXg/EaiarMLGyy3aJwsJJiVy/1q9k2+s/J5DtKVsLNbzTTCGB/i4+sygD4j3c+ez8qnaRaWZbifUMd3pMZdizZDOjjFS0AqL//1rKK4/qRDNqhJAVSk6P6WDcZyAOCDtqs/xlKDkX04DULSGWvOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Mon, 23 Feb
 2026 06:19:49 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 06:19:49 +0000
Message-ID: <9a940db6-80a7-4c6c-8138-0b4d85f6a402@amd.com>
Date: Mon, 23 Feb 2026 11:49:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add NUMA node affinity for IOMMU log buffers
To: lirongqing <lirongqing@baidu.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260211035839.1970-1-lirongqing@baidu.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260211035839.1970-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::14) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de07a9c-cff1-4535-5f42-08de72a38c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzZ2K1Q5OC9hSGoxYUR0OHBRSkE5MVZKWVQrdFJCRzQvcGRVTWhEZWlCYmlB?=
 =?utf-8?B?Mm1RM3AxVUJRdjlXTDN1eThYK0E3YW5zNTdJd0ErWU5aM3RQSmR0NWRXTlhY?=
 =?utf-8?B?dk5xN2FSVm13Y2NXeHRLVkVIR2Vta2kxNCtldkpOcGV5c0k0cTFvUWpvT0VR?=
 =?utf-8?B?emc1ZmZZN0M3T3lPU1FFbURUNktnZ3BLb2JYTUZuUEtlN3g0TkRWYlo2a1RB?=
 =?utf-8?B?RDRtWFRvaCtGZDhqMTRHWUtTcHM2TmllUE5UbUZDTVdCTWpOR3M4MXlTdkY0?=
 =?utf-8?B?TWdoQnhhY0ppMjUyRm5OOFd1dEJjOEhGS2xKWmhsc0hXRy9BWnhlZjBVZWt1?=
 =?utf-8?B?TzRERWc3ZkM5ZmhTVm9vRU5GMm45V3VUQVlid2orRlR3V2RDcHlHemcwS2lB?=
 =?utf-8?B?cnV4L3VpN0ZtUFBuZk8xSXNITS8rSmJqeUp1WGVEUXREWXJlZTVKRkp6Z0w1?=
 =?utf-8?B?N1ZjUnVwaE5KUUZZNklDYmpDK2dxL1VCcXlNcUExM09kUWJmcXJZa0hyUU5T?=
 =?utf-8?B?T1pTUVlPN2FtT2dtajVvNms4OHlpM080M3lhZnY2WU0zMGloNzdWQi96Sm1t?=
 =?utf-8?B?V3loTHM1cFovWHh4TEh3RndpdHUrc1IvZXJoVXdWZ2NYYWgzck54REp1RE5Y?=
 =?utf-8?B?Q0NDT0RrNW9MM0g2SDRNYWhkamM4QTlJdHdYYkMwVGVYelJoUVVhbUg5MVg0?=
 =?utf-8?B?UVNnbEFmYlkzNjRobEhJMG43S2VqRUNMc01qTWhqZG5vSjRhMlhHbGRlU3h4?=
 =?utf-8?B?cU1TU0tPd05pMWVCZW4rRTNyS2N3NlpraTF1bklTbkZoTlNLb2tOOEhsTHpR?=
 =?utf-8?B?dkFiVC9RbllaNEQ5b25jSDRsaWhLd3UxY0toWXc4aXVaR0xqRXNBc2dpWjNS?=
 =?utf-8?B?M25LUm92UnZESXdiRG00SXhQcDdtcTB1MTk1Syt0dWJVTEJiT2RLRHNPNGVy?=
 =?utf-8?B?L3FIZlFobWJ3ZHN4NnpyY0RqVHNNM0dTeWxZdWNVM3BPVnhMQjRRczU5ZkdV?=
 =?utf-8?B?SGkrMU1EQTIxeTcxb3FpQzkzMkx1bDc2WXZwdzJpRlhNNGw4SEpLR2E4ejc0?=
 =?utf-8?B?V3ZxczloZVRLcUQ2ZENoNmVRYnRZVVNLenlNYU9RTlMzMUNQUWV4SHFTam9D?=
 =?utf-8?B?NVplWFJZQzg5bGR6YmFtZlY5QllDQTJ2MjVYcEwyT2xsV0lMRm40aFhERzQ2?=
 =?utf-8?B?NUJCdHZPNnBRdVNJUEZPKzgrY0NVTXZTaFVPSEpKdUQzbmF5dFl1ZmFqMW9S?=
 =?utf-8?B?R1oxNGR1OEFtbDNvQnJ1NUMzN1FCUi9GUU93L25DZ0JuN1p1Vm1pdUNJczRs?=
 =?utf-8?B?RG9CUWwzOEdhc1BvblRCSmI1dHAxbUhOa0Q4dlB6a1NGNllZVDl2c2NlOXY5?=
 =?utf-8?B?YWJ6c0EraCtEdXRZT0R0MDJwM3JQREZwWE9DKzhCZlhYRWFGZWVMazRnbXNi?=
 =?utf-8?B?TmNLS2hsYmxNdjNuSXhYMWJ3bGx4Wm03SzNIK1AzMlhreWpYdXlueFFqSXZO?=
 =?utf-8?B?dUpuSnpmRFNYTG9iQUt2ZEZPNGRiL3FHMmlQR1NTTVJwdG1jbThoRVBUdThE?=
 =?utf-8?B?VExEMHo1dkFTRDBlaW45OUkzR0N4Ry9reGk4RzR5UkNsVEpvSkdhS0hEb0cr?=
 =?utf-8?B?cEpjRXZFbEo5cXVMQWlVOE9OWDdFRyt6QlQ3cVlseXQ0OHpuSnliNjJPRVJ2?=
 =?utf-8?B?WGZ2OEZoL0VoNExGMXJxdjJRSitBKzN4VVYwT25HL3hmenEvQWI1TFRVak5G?=
 =?utf-8?B?ZFdkSmR3NGZXRktYUyt5MzY0SC9wWlBYVTh5VE9YMmRPQ1E5aXl0cVZUNktq?=
 =?utf-8?B?UEVOYlFYMWtlNXlsSmNSSmtJczRRY2FXZWdWRnN0QXpudU85OGpWQ0JHditz?=
 =?utf-8?B?Tis2anpJVkY2STNhWjlYbEtHd3VCUnFsaWhlcDBJZG1YOHBKa3IyeGY1ckJP?=
 =?utf-8?B?d1E2OU9UZFQvbFZWaG50T2JCckY4M1FDVWp6M1N4MjVMNGdOZVR2Q2V5Z011?=
 =?utf-8?B?dlhZRjJKWU9wT1BFcWJsSjVBV3RxTnNUMnNlQ3dpMTBGVHVwTys0bFV6d2t4?=
 =?utf-8?B?bVVkbzhwQUk4R0F6UzNwVUdGZks5K2t0QTlpbnlmUmZyQXFhMEdLd1dSY1lW?=
 =?utf-8?Q?n5RM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjJmby84WHJ3Z2ZFano0UmthS0xpckw3cFBwbHRQN0pKOVBPbGc5c1dmcHBk?=
 =?utf-8?B?cjNkQ0lJQkpTK25KaURpb01Hcm9VeDZJc0krY1BROWdLRVZGejZPSjRPMkV3?=
 =?utf-8?B?VVpqSDVKb1B2VDZlL0Fqd3dQVXFhc0FCTjdnSkVsYkd5aEE4eHVNNCtaUUgx?=
 =?utf-8?B?emFzM0pOWkQrVTNYaVBETlJFaEpBd2E0endDQ0wwdHQvWlhaaFRFTTFQdnZZ?=
 =?utf-8?B?cGthRGJMTTUzb0RUWHN4RUdmdzg1NDhxdWdYZmJuS212REV1bWpBa3BSaGJo?=
 =?utf-8?B?Q0JSbmt6OGh3UzZrY2d0eWtSVms0WHVZMk1EWjAxdTZiVFUyWkxiUEtKV3Ni?=
 =?utf-8?B?cEY3c3hIRXpNdTFYSkVmc253WWNiQVlpWTJyR2JmR3laYWdueVZvOXM0RDN3?=
 =?utf-8?B?NXhhRFhUditiS3BQTkExa1pNdVc1VFMzV1lkWGVjVGNDOXZHdUFudE12Kytl?=
 =?utf-8?B?S1cxZkNETjJDTXE2dE96UUZWSDNHaXVuWW56K3FpMERBREdWbEIveGcySVlv?=
 =?utf-8?B?VTBtK3R3VWdrOVN0eUtXdDBMTlZacTNVb0czaFNseDhwbk1oZFk3QzUvdmxa?=
 =?utf-8?B?Qk9XSHRZRGw3bE53MWVOd1ZxbUhuZTYwQ1RZdFNNSXA2RVlrU3BpLzltbzFa?=
 =?utf-8?B?MFJ2YW5CVkwvM3JDbmJQcHJBbXZTMmt5dnlTZ0tpSjg0RFpZQnYzQWRsZ0FN?=
 =?utf-8?B?Sng1elhwMm45ZG9HSWRibjB4d1dJaGErb0Z5TTVzVWNlaU1xbnNhaTNiV3lK?=
 =?utf-8?B?dTk3ZlNOa252MFNxS2RJM05OaEVpVEdGSERKalpRVWdyNlZabWhLbEpJb2FF?=
 =?utf-8?B?Y2Z4UnVEOElVcDJKaGR6UHpmTVVXYllBdTBXTElvZlQybjVXRFRYT3o2VEFO?=
 =?utf-8?B?T3kvekIyWjJMdnJiZkJ2cy9LZU9ISldFS2tNd29jS0ExeDB4YmJzbjVWSUJF?=
 =?utf-8?B?RFFOY0pPN2hPb3pTUUJYTGtmSkZ2VVdnUDRxOHdzb3hlU0tvRWlZdExiSVk3?=
 =?utf-8?B?SVkyc00zZVkva2thb1NMVjFaaEdiTkZvUzU5QUhkRlE2djhuU0VWTGhKZHpQ?=
 =?utf-8?B?ZzMxRzFlb0lNY3R3ZGxTd2h1dXNFWGc5MHNlQmhvMlhzSy9wa3NEQ0VsTUps?=
 =?utf-8?B?THRpVVhBSkVuQ1JMZEFuWnVpZXJPa2l5Q1A0WUZ3VzN2RTcrS2hQMGo4Q3pu?=
 =?utf-8?B?M3ZENTl4K1ZwU045UW5RSElNK2xYN1R4ZkRhdWkzUTVxRUVIdUd3aXV3R2ZR?=
 =?utf-8?B?aDZ4YTl2cWpJcWV1dVJuUjZHVG53U0p2VW40TFJDNmtVZ1Z4R1BuNjdYR29J?=
 =?utf-8?B?QW5uWHprSzdtMkdkOHE3cGdsZk10c3dpaFp6ckFhUFZudjU5QStINHRqeWhz?=
 =?utf-8?B?cWQrUnpvbjRDKzBtU0RIbFdJSW1jWGtLc0pmMXF4VnFOeTY3VnQ2TW5OaFhB?=
 =?utf-8?B?Vk12U1FxNFpTR0p2YlJMVlNUakE1UER6c0F1ZDFGUHlhekgrUmljeGJFOVFp?=
 =?utf-8?B?cFhTZkFnUEVjNis0MTZEcFoySkxLWStNREFkT0hQOSszZkFhUVVMYVUwZUov?=
 =?utf-8?B?NFZSUEduZS9OVmpra0ZEQ0E3UlBINmdkeXVXL09SdXJtZFgyUTVsZmdFZnky?=
 =?utf-8?B?MHoyaEN1Mjh4T1NCbXZLY1NKMjlyWkJ6NmtTTlFTWnBQZGRabHM1L0dnOXA4?=
 =?utf-8?B?aittVWlFUXUreUNUT0NUYXdSUGthZUF3d0RwYWU3SFF1ZlZvZGhrSWFidTgx?=
 =?utf-8?B?dUFMOGx5aTcwNlg1SmtzVkR6WVVkWkJvVTBuYnJ1bCsrQm55VE9nbUFVQTV0?=
 =?utf-8?B?WVBkcnI2cnNDL2p4c2dWYVMzekhHYzNaMWQ2d3N5U2x5ek1tTGNXdVpNTXZp?=
 =?utf-8?B?U09UakQrTWplMUFESFV0Z3FpeU04TlNLaU42QnY5WHJzKzJwWG83bzdCMEVQ?=
 =?utf-8?B?R0pvWjlWTTNoZC8xMTQwRGFqWmJ2dFRJWW1XZEpSbVZydkM1MDVGQmVGNW1z?=
 =?utf-8?B?RU5pTVd3K3RMYkxWaEw1Unc5SXBHdGxGN2dIWHFIOTF5QXJ3QUlYUG0zQldI?=
 =?utf-8?B?Mi9URDdxNnFUSHJ0WlBCTTBoWCtuT3lIVG1iMElETHJiUStpc1R1WmJRell1?=
 =?utf-8?B?N3lnak1HVFlObDB5MHhHeWtyL2wxQjNiLzltMXgwRVQ1c1pmRzlHVldjSWha?=
 =?utf-8?B?S1liYWtsaE1vN1phdVpkNnJUaURJcFVLeTg3dmczeGdWTlhGSlVTR3NnZ29y?=
 =?utf-8?B?UGtWOEdtMWJVbXRFUWJKeXJoTEVwK0NPSFN4Q09TV0dZVjVaRkcrWkNkYS9r?=
 =?utf-8?B?Yk9Ha3RpYkNoUWZYWkZkanhCcy80Q0srR2xlSVE0UTFnQkVQS211UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de07a9c-cff1-4535-5f42-08de72a38c69
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:19:49.5258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rElcI8WE3BbWM0sM2jUndCGGbXxxCoeQUUjtU5xJ0DhytrAgm/Wc35gTfzuaryHPpK0azutZlL0H1+gUGEvOAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On 2/11/2026 9:28 AM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, PPR Log and GA logs for AMD IOMMU are allocated using
> iommu_alloc_pages_sz(), which does not account for NUMA affinity. This can
> lead to remote memory access latencies if the memory is allocated on a
> different node than the IOMMU hardware.
> 
> Switch to iommu_alloc_pages_node_sz() to ensure that these data structures
> are allocated on the same NUMA node as the IOMMU device. If the node
> information is unavailable, it defaults to NUMA_NO_NODE.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

