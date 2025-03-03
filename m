Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52A202C55
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002991; cv=fail; b=gjlGCvyPkbGH92N6KtXkmqbxF00YqUzDXkR1ZLa5/1655pi8VsfRQdG1mlGiD8qiGDqEBHfR2q/07ugoSYSJysL8KFDQjD1FG9QzDHpFXp2rI4fQdk5yp9Niqp0Av3YNbDhaJ4htMSUdJZlP0oh+8N6UcioB4WAns6GuYxshIuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002991; c=relaxed/simple;
	bh=82FMMMZroVfqUJy/t0hX83TbyfMKyxauCRzGxydMfxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EYBM+57emLp0+Z15+ztQ55HiBuaiuAfwhEd3Hcu2jX7NWlYg4V0SrwTk65mb2/GFZf9NzV6WIAHx22/tVUj+gkItEt4z1WC36kglYk3yKE1y+v7pTuLmw3Azl2vYW2pRr9L/xvXg4Z4mcJjJAjRWeeXji+cfZs3QHC9xurqHCpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gCDm7YP1; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gCDm7YP1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idSvnA3lgKb9Suf1D3pIJ1nk8OeLLKbxPUsgiepJ6xanrFNaNmN7L1qlN3yGUTMQS6hqR+0G2xz+b7UTVBsLT31vsO1EZi5S7wwRQy8bZTtoz7XWbnh+hhX0HRbcY2OhLIFZQlT6MwEkQeo5rqA2obzoyFDM6/c7omCYq8wuFI5bZvVQ2SmHhpXZI2631rNT03/PHbzXRFhjRTFp7FIOJ05bgYXgrD3VA8HD3LZvkEoJebcYd7iDZ3a2ZunuCzjpmN7WTcG6fsglgwZRW3g5okjZbrxHmT8rUZT3CpZc6hmJ8v3nO3Hn2YmQNwo+MYSfyDlt4bA3xBMNM+wbDBljdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wbkjpxctgjbKotNSQ6zVc13J1vzTPbm80VfyWczTYQ=;
 b=tw459KnatAJmLb5y/2xgz1jIsGTsXftFoxnXozH7ia9Eq4W3aTzvmtFn/JfH0LY5knfgSVTVq5Fsllso15paAxJTym20mcOrWxzTeNaiP1EssvTTu9MYZQ2xQzuwpAu3WkU3ZzSt6dPNcwTP24PmUIuV5HfNAWW8+FCh7KnHgvyBnaZr+s+u62XUtLduu7n9zREtvDaEYAJUzy9h59IAD07FuV9QY4rL4h8FYGxwn+TErpV04I06SvFCTHko9f3V3pGLhqojg6YN+/uRH52Npv/DyNjDwGX61U6IzZdA6QdCBZmxsO0I1ZlOTT6kTlGo6YEXAi2MxF17eKAsLWB09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wbkjpxctgjbKotNSQ6zVc13J1vzTPbm80VfyWczTYQ=;
 b=gCDm7YP1B95ZpKNv1Fh70et8AUnCZk4hE1U1Puzf0UNUr7fdR8lmO1hO3aG6EFHN7BGML7MZPPYopcI7iWrnR+rq1u00zfu0gpkUh8c4t0YMUa2xDCrPh4IUq0SdT9XkUCD0ivdNuLbLtmtabPDCqj6Lac6oxiILa0K8gQpPQ+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 11:56:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:56:25 +0000
Message-ID: <1b67b00c-fc43-4195-8723-dc138dd460c6@amd.com>
Date: Mon, 3 Mar 2025 17:26:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Robin Murphy
 <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <20250228145636.GL5011@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250228145636.GL5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 731ec338-9f64-4ded-c74f-08dd5a4a6c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qkxla01VRFRCQ3VhWkQxRTQ2dEFISnpFZlZLT0V6WVhwQTkvT0ZxcG9uNGdx?=
 =?utf-8?B?ZDZ2aktlZGdLeEVIemtXUDNXVnNvdGNud0Q1clBpTk1mV3pNS0tLYVNKYWVF?=
 =?utf-8?B?WkpoUFZyYXhlblZQRHFzYnFKT1RqbFl2UzladG1lTUxhZ3RKamtaZ2VtaEVJ?=
 =?utf-8?B?WmRWUVpKejNHdkg3c1puK2J1cUpGdGsyekNkODE5U1ZsbDloM2tvNitTbDNn?=
 =?utf-8?B?Uk45SlBQMmd2K29neTBSR3lBSmNCYVVTYk01Z2hnUUJnRy9Gb0prZmpyUndM?=
 =?utf-8?B?dTZpNUV6czlKUXlFb3BGY1BwWHBJQ2tBUENJdXNNVElHdU1Pd3pZZkdiUGNa?=
 =?utf-8?B?V3grR0ZYRzhXRndYMzltUVRNSUNyVGNVVytxMVliZmpUUkN2NWcwbTFremVE?=
 =?utf-8?B?SzJ2ekVwU0VsV3NDbC9pdmNJRTZveXZYOWhUdGJBVXE4NE5PUEppWlU4L3M5?=
 =?utf-8?B?Q3h5QTBsM3ZSYlJxMDNGUk13anRjOFNtSGdRQVl3R3VzQklrUGFPQUp0RkJK?=
 =?utf-8?B?U2VFUExYcDRZbzdOTHdDMG1XSEZWN0VHTW9yc2dmYnNuNHV2T2JxY0pUY1Rt?=
 =?utf-8?B?SStvRERqcUpHem5CRWQzckFvYWlFUmUzUVVGN3ViVmtKcEZkdEhDZkxiNlRk?=
 =?utf-8?B?YU02YjdEdVlKSmxwdFh4VzBuUUUzQ1RxekxUUzZ1VlZidEs5Q29kRjNTbmhU?=
 =?utf-8?B?NzRacXdsN0d0N0xGZVkvZ2w1UG8zMVV6dUtpaGFuR1J0N2hSTTVkSUtIQ1NC?=
 =?utf-8?B?MHpMSjB5UU94c3VsRzhNTHkyQktnTEkrTjNnSzhyUjFWbFg3VTMxeEQxSVJR?=
 =?utf-8?B?S1dIYXFyanFsZ2g0YU02c2FPN1hvVG8xV2pZUmNuRm9WLzhlSmlOS0hncVBQ?=
 =?utf-8?B?OXpzaEV1eE1LellEdHBOcmxvKy91Y1RGdzAwQ2o0ZEtPcWpyWGthWGQ2eEt1?=
 =?utf-8?B?Z1pDN08rRGdXVjI4Ly9nN1RlTVZwaGRWK2tkQmVrSCtONlhaU3NSUXZ1QWM1?=
 =?utf-8?B?dUdhN0JTd1RiNlNNZWExL2tibiszenA2MnVnaG4yTVJrMG9HQktHR0FkcXd1?=
 =?utf-8?B?ZlFzVThTMzNtQi9LRzF0SE9FWlBuSXA5TmxwMlJsQWFmdldDVzRoL0l4b0dX?=
 =?utf-8?B?WWVFMHF2TDc5QUtCNmUzWm5uMjZYQTdNNWJBdDBHQWlnQkU5aVlGMEJmVUpF?=
 =?utf-8?B?QndDWUR6cStsekVNMUZTalhvQnI0Mzdvd1kvZ3NmRkF2VFZWeGVEZlAzWnk3?=
 =?utf-8?B?Q1R1V0VSZWtORG9EQWJKd29icGdCTFVzV3djKzNrTDhqaStaUGttYWhmdEZh?=
 =?utf-8?B?LzNITmp1bDh6T1puWk9GTjgwZUQ1RWFYUGRkYkJjOUNtRTYyUzBFeHJsdk5Z?=
 =?utf-8?B?TWxGRUxPQlVQV0FzQUo0b3ovc1l5alEvYmJMSnU1OVVwYzBoRzdYMFVYOERy?=
 =?utf-8?B?OWpwVHZadVlyUTNNbnJjbDJ0czRicEhZbzVMRWdTSEc2QWYvSkF2OG1ETThW?=
 =?utf-8?B?RVlVbUVqYVY5a21aQ296MnZDdXBBckk2czRkeUhzbTNwZUlHaTBmWjBoV2d6?=
 =?utf-8?B?NjNaSFZFRFpUN25HRW8wYWpwYTdNTnJvZFp4TXN5ZnVCWnpHOGh0emNab1FH?=
 =?utf-8?B?Vm5rQS9vU2xyWUdmSXQwdHd6MUg5WVJzblJFdHM5Q2xUd1FraktWOHpuS3lO?=
 =?utf-8?B?eG5SdVo2RU9ZWTBFVytrV1dGVW04eitqUFUwMi9DMURpcU9ZWlgwUUlYQTBn?=
 =?utf-8?B?UnVjY245eWYxNVBCbnROaW5TNDVKbTRsMVQ3MWZBOVZ1S0hYYk1pbTZLanZO?=
 =?utf-8?B?TVk4UVF3Q2dWb3YxaGR3UHpianVVMFcwZ0I1UzFPa29kWEQydmQ4TmhhNTZ4?=
 =?utf-8?Q?SFMMXmjAZ29Xy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2VCSVhsbW41K1BnV0VCcERzdi92WWVoNDNEcHUwcTJMa245ZnlpMitwd1Rj?=
 =?utf-8?B?M2RNNUxwb3dlZnh1dEs1a1RnaTZkOVI1UlcwQ0NzS2Y5dzY1bjlzczEzTm55?=
 =?utf-8?B?b2VXaHp3MDY2R3ZSd2FNTjc1dFB3ZjM3QUo5RkErdDAzZTdLUzFJQmdaS0U4?=
 =?utf-8?B?UUw0bDlma1FLNU85NlFHTjd1T3d6djB5THdvaGx2RzRsUlArTG5sSFAwcVIr?=
 =?utf-8?B?NkhZTklWRjdCVFh6WmVRV09NcEIvUGNheS9KR01RZXA2WDVuYjAvTzc1TXNr?=
 =?utf-8?B?L1lTZE5uTCtUSGNLd2FuNGxLMml4UDBOdSsvSWtZN21UZFBlRlN1T25tVUpQ?=
 =?utf-8?B?cW4zNWZYZE55QkZXazFuKzZoeW80dEF3QUpEYnozN1RBT2FMM3Z4OWhkR3Qz?=
 =?utf-8?B?QVBvdE5Dc0hob1dNbUVBL0pIbVpkMXRSRHUzSGNtM0x2bVEwZGUrd1JHdU5J?=
 =?utf-8?B?VDhWTlE3QUdYZVgyakV3M2xSUDhYdWE2c2w0dGtweTU0SzZVSVM4SjExckhq?=
 =?utf-8?B?ajZhNHBaN0M2UWZSOUVHMCs3RjdncDZ1MlBkUW9mT3d3VTM4OE1kL3NuSjI4?=
 =?utf-8?B?STN4aHQ3YUF4QlBRcnl5UmF4RHFVVG9FY1BmbGd2SlZOUnhvUFNSbitzR0JK?=
 =?utf-8?B?cWRLZzBna0s0Vkp2eXdxTjRtVW1xcmVBSWtEZFVtaFJFYjZMd29UdkJ6Vm5F?=
 =?utf-8?B?QzZUejdwUzhBK1BpQkFZL3FGS25BME5PRTQ0MEhOcFJxTVNldzVZa0VRK1ZO?=
 =?utf-8?B?a25uWWRKdTJqVUlMNysyYkJ1RW4wckhHZlI2RmFuamVmM3FqbW90OUM1Mndi?=
 =?utf-8?B?dHlXUjlvQjU2SW1yN0FpZjlyYXlrWUUrWlczY1pSM1ovWDl5NlJ0Y2NUUHBr?=
 =?utf-8?B?aXZIV0xsT1RodlpnSFU0ejBNKzRRVXZIdVdFT01BUzZsR20zRkR1Z2J1azBQ?=
 =?utf-8?B?SW83ZFdiUnRkTTV3YWxvOFM0Y3lvM0ZNV08zaXlZZzNib2FkRDA2UlFBV0N4?=
 =?utf-8?B?cFM2MGlOWSs3MHRwVE02clN3UUJJK09Pb24yQXFYNkJVSG1PT2JrZmRkSEZ4?=
 =?utf-8?B?cENxbzN1TlpmU3A2VlJCT2Y0RmRKOWZNNTJoaDFHRE9sdm1wdEVlRlNEMkdU?=
 =?utf-8?B?ckdoWjg0Y1hXQUlBb1VCRDJBdnZVSy9EZ2xiNmlQL0ZFTVZsTXYybVpmOEpF?=
 =?utf-8?B?ZFdleUNLVzJhR2sxOVV1d0IvcWk2VmpGQ0lyajduc1pMNE1ybjNSUWRWZ2FS?=
 =?utf-8?B?WW1obWhEbCtLZnFVQys3ZVNMajdsNFNuRkw3MlFmaGRJSGFnZ3F2a25PTkxE?=
 =?utf-8?B?aUZVTjlKNlhjbmVkSFlUQ3ZTcUhWT1RnS0w3aHlVcVdtZzlkcGVIU21Gc0dh?=
 =?utf-8?B?SFhHZTFoT0lCSHlPL3JjVUR2Sks3OUJROUxmWEkzdFlHeDZrNzhWTVE0ZUxN?=
 =?utf-8?B?Z1NlRk4wOVQxRWI4YTNxVysxWWo3RCtiaVJLenN4d0RsdWZJUExyN25CemhK?=
 =?utf-8?B?cVlnUDJCU0JUWStsdGhsV0FQcmVsQ01PT2FhY2xISTd1WUI4V1FVa3JQZXVr?=
 =?utf-8?B?WWdPaVNtYmlwM2xBcU44amFNNlQrZ1o2L0J0YVVSSFV5WDR6amhtOXZxVTJV?=
 =?utf-8?B?R2o1WXFXOUZhUndVYW9HWVp0QW9ielZKKzhBR1N5bU85SVdoSnIrQkV5dlhy?=
 =?utf-8?B?MCs0amlmTURXS09uK2d2clRNeWMrdmY4SzVMUUh4ZlpETDlBM0QxMnJRQ09y?=
 =?utf-8?B?bStKWWUyc0NzemZFQVNmdTE3KzhHci9VV0VFNGN5MHZOMU5Zb2Z2NWpyaHVy?=
 =?utf-8?B?MUpFa29BbEw5QzJ0YjlVT29QdUZReEUzZXdudzFYVG5Ob2N4ajFabmdMYlFR?=
 =?utf-8?B?ek5HdUNkbERldndmS0V0MlFlUmFEUXdicnk3TXpWTThGVE0zKy8xZGNOczRN?=
 =?utf-8?B?cS9QdG11SmMyZlVQLzRaWjdxVXJMWXU1SlB2WEhwbGdBUDVHT0wwRUxzN1p1?=
 =?utf-8?B?dHJWYXZHeCt5U2doOXZDdmQyWkdWcllrczJJVmZKYUtzbFNxd0lmTXhmZDNn?=
 =?utf-8?B?cytuOXVmRG5pM3d1cHVQVERRNERYcTV5bTg0YkU0UHRJUFpZYTdTQkdoL2RF?=
 =?utf-8?Q?zgvo+mELFELvNvKMuymP5SxaY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731ec338-9f64-4ded-c74f-08dd5a4a6c80
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:56:25.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/3I5pNmcxm0B3xTjRXuIaTPeeajJoGMI6iuUMm3WJA/ZucF6lvd7yttrT3bWQ6biBURhfVf9trZeK5/CkVGPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

Jason,

On 2/28/2025 8:26 PM, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 08:57:45PM +0530, Vasant Hegde wrote:
> 
>>   - If HW has a enforcement required (like AMD SNP case where Secure ATS is
>> must), enable secure ATS. But do we need some way to inform core layer? If yes,
>> may be have an domain ops similar to def_domain_type() ?
> 
> Yeah I think that is probably the best option, some kind of callback
> to the drive to check if a platform forced secure ATS is neccessary.
> 
> I assume if you need forced secure ATS then you also are disabling
> IDENTITY and disabling PASID?

Right. Currently SNP is enabled only when IOMMU is in Host (v1) page table mode.

-Vasant


