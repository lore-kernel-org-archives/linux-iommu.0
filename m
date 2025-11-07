Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D53043A2
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533382; cv=fail; b=FZajV84n++HMsKAiuI7FYD2h42r9coDpWFZjxrG161qyGOOcbeuyuKnJiy4vh6merGS8NP472n1KtnveleKYHatYPQssLKqG2pF+kofCgqZ6fdKFFQhu4WOFIfctMUMZ3lRybOnoRbxw3FzvT1wT0Y8uuWfNzJZnn4uYFKnKx90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533382; c=relaxed/simple;
	bh=WPBdNVPSC6a0eJYrsK4tmHTaKQvzi3lbaIDxWs6xvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gefUGlTK1csldjFslx3DMrEN3NQGmGUsfTHDwpG6sQ2p3iMPwqxz1tAiundVq8o34AYXyrxKgsNvS9uaGa2tU760Lo20Y0zAyD2RVeqqwgqX/7rWoYpnxs0aL0GK5VuHbK8d0a756n/gfFKDqT7meFQlAVUqzzt94g2sXbAfIwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LTsoWr2p; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LTsoWr2p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI4qzEvE4ncfRMSzjMRm5ab5c7njtYs/vA74pyODGb/EV3guS+abCUBXndFTZ6uyQEPVRI4If9RHjhCK38oE1VtJ2W02aTrq9zeApGqLIKSysPwFHyBa0XBMpzpaAA1tIzdpks464Irwqfn9tF55/A6udA1DT7lfwqBsMeED+uQ5rLHwZzE8Bj+f9kZq7zVv4Yh5krbIMt0djYm3xigeUBKL9nSwGF2eS/c7opu0+n90C5FNGXPE3vSPRAIaVBOM5SWprUKuI1A/mysX1gda+fOYBXymnzo4Mo+TtLosv1zkXOx/CO4k5q49oJY4/4dVTPAHHoX7y8qxzKQmlraL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaa8cnOVM4IsOR2aXuKp7MWD+Uv136sQC80GjjOwxY4=;
 b=lPc4xKJvGMryGGInK5jhjDkZ5DC33kji16T1Fc4i5OoqDcdDFcmTEwUV2gU9khwiohK3rPwWUPsCjV2umTF7MZcGj7O8TeK9L16ZWL7OOlnurTvf17Hqj4wzkO+jzXI6CAvOOMtl5AMenDsgCvZUQ7eQ0jrOzjGhqi+HJgcoQjgARALfGLXfjKX9esEHqruPlsOC1Uc/f5iPwSWdssPbGgxQ0YgfHaYKEH+AhPZcQjpcGbkpR/GMGKPftNG8JJ255bpWVYlF+ehGRszxM0tQG+Hpjl2qDsgPVFSqDGn5Vgr7qbu7Ba5v56sK8qeJNF97AdeUOkchuWzRWT88JW3plw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaa8cnOVM4IsOR2aXuKp7MWD+Uv136sQC80GjjOwxY4=;
 b=LTsoWr2poaPBKlyQlRSGt8IAWHfhdoY99Nv1k+OTnfpa/Vq0WUPMR2IlVD7pGCJCJt3LCuQmSYsd2bX1bOaPh2gdJJhW6si306gFZl8zzxFr/QtaSSEj7fo2p554t7Jru9y8CZoOtx2vH+JIev5kroXU8FtzGUMQ4G6SSlUVBJ9e9oFYdm69UgMDpCOrSdY+74C4ra4iR13axJEpl7XLVjjyfhikLsoKnGsmMtRI0suq3lpzXfITLV/bHieTMP1UVlQEk6CauNLT28f84QgvKtsNqMWBFHi0ESFKINxpXcXltBI2rLO8qcAxhaSBAAYBFRUWSCzVy+Qdoy44ofSAYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:36:16 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:36:15 +0000
Date: Fri, 7 Nov 2025 12:36:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Message-ID: <20251107163614.GN1732817@nvidia.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107141632.GL1732817@nvidia.com>
 <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107155704.GM1732817@nvidia.com>
 <SI2PR01MB4393E3BBA776A1B9FC6400D4DCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR01MB4393E3BBA776A1B9FC6400D4DCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BN9PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:408:f6::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: ea47497b-b1aa-49d7-3561-08de1e1bc54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajBZOXREaUhxVXZaajgrODVZV05NN052TUFhQkdUQjFYTGxVL1dkVnZiVWt4?=
 =?utf-8?B?UjQrUDhmSGtZZldyZTR0SFAzdnhUWlFMSlhkZ1BpdHVGMnZEczNxTVZwV3hC?=
 =?utf-8?B?VDVReTJla0xjNW9jMW5NajF4VGZrWlgxNEVqbUpURUFKUWczdis0WFp1QzRY?=
 =?utf-8?B?eUNKWC9mOGJjTTV4cHBPYWRxaElHbk85UVFkWUc4aTN5VHIrTmlhQzNDdmta?=
 =?utf-8?B?dWhUTXpqYnVDaEJPZHdoakEvTWM5WU5ReDhmcUFjQi9BMDBoSUlYT0VWWE5C?=
 =?utf-8?B?cGViZzVTT0VCYmVFMTlMa2FHUERpd0xQS2dpZUp5ME91aldNMjl0Ny9JbGVz?=
 =?utf-8?B?MzRtd1JuWUwraXZoUi9vMGxyK0JOWklxaklwRUE0Y0tjZE93N1BURjlCa25P?=
 =?utf-8?B?QnBWVFBFejI4SFNOeVo5NkZDRWxTblpWNkhCT0JHWDFUTXJveGZYREJGeUQr?=
 =?utf-8?B?ZXQweWtMVDRnb0RHZTVGNTZaYzdHbWVUS1VQODFBRlZkYjNlcExLditzUEtu?=
 =?utf-8?B?bURBM21OdlZlUEJEdGFLYm9wUkw5cHNpQzA4WFI2K3FGNENmUXF4OTBhZ1pz?=
 =?utf-8?B?eDRoV3Z4ZGk0WERtNDNqbXMzSW5NRjVrbk4rRHZqbVBjZ3dyLzRJMHZUbVJ3?=
 =?utf-8?B?MVl3OWFlQ2RxdFFpa21pODFLZk5FMXRrNjFzWVZZYzVXWUx2T0JBK0orRlNy?=
 =?utf-8?B?UEZCWmJGd3NKb2FSUFpTd2Q2VlN6RE5wb2E2TUc0SVdVTmNBQ3R1ZVRURzRi?=
 =?utf-8?B?SXBwV0ZiTXJ3aFRBaWhDZDk3U3hBRFhybTNVZHVYaE9rZTdXRHoxZG5iK3RU?=
 =?utf-8?B?ZzB5TmtaaXFHN0ZIU013ZmMwUi9ZQTFHR2Evb05SbkZyL3FDVHhORzRhenJ0?=
 =?utf-8?B?RXB2anpQeGF6L3JlT3dXL0hBUE9HQ1ZVVittK2xXSEhuL1F2N1RVU01ZSzZa?=
 =?utf-8?B?VGVVMEgwRVBaaVRvZmxMd3BEN0Z3MXBaMWIxYUJWdjZ0b0NGY2FIRXM1Kzdx?=
 =?utf-8?B?RDhDczJZSjVaUnovLzBCeWRTUDhYR1Fqdkc1amtNZUE5MXN6SnE1WUw4YTkv?=
 =?utf-8?B?MktSRWMrSzlBeDBwOUxhcVRhNXltOXNRTHlLTFhQaW5jc2lhSFhGKzFaTWlQ?=
 =?utf-8?B?eWVIMGd6bytNWW1RMU5Ba1NUeVJHSmFXbjNGMkhQc200b3pXcElYMHE2a0x2?=
 =?utf-8?B?KytQYjBWc2hXTS80Ujg5cmJDSUI2Z3d6Z01BQU03M1NLYTkzdGtHMmd0NEtD?=
 =?utf-8?B?UFBVZm9DeDZJazN2TjR5QnFaclJyRE5zWEpnRUtxZHBReGtxRDFnRWNjd2kw?=
 =?utf-8?B?a2wza2Vtd3JaTGFUcUZpV05tQ2xVdHlxVXgwZVFtOUxzbStXcFVsZ1hidVdm?=
 =?utf-8?B?L1d1RmJHdW5FejVwY0ZFRkJBMUhlcnpXc0VRNG1jWm1aa0JEbFdLdmRXSVVI?=
 =?utf-8?B?RzM1WTFhRzJMZFYzUlZWWGdSTnlvcGdrWGM3bUljNFpreUpIUTJOcEVnY000?=
 =?utf-8?B?ZE5kYUZ1MEFueWFqWHF5azNibWkyR2NsZkdmcTVWUElSc1o4Um1adWxyUHNp?=
 =?utf-8?B?bHF5cGQwM3RpZ0Q0NFJadEp3ZHdEVjJYRkpVbjZ1NERNbmMzNTZIZmQxZFZo?=
 =?utf-8?B?Z1lTb1NGbzlXQVBMN28wVXdUWndkcVZNN24vcmNhZytTeVU3SEhzVk9ybWt2?=
 =?utf-8?B?c0Q2WTZrdXZoaXBBUVBBUmJkajdXMDl4ZG9lZklLMUtEM3VtbUpTb1Q3ZWYv?=
 =?utf-8?B?VkdNdGdkdGlabWMrdmgvNDFxdlRwd25jVzFJNWE3RkFodWI3L2x2dFVWVC9G?=
 =?utf-8?B?NFZ2aVdwNzJydmhsMHlTbkRMU2dMb0ZQbEFFZnl1Zk5FaFovL0hrSVNLdWhT?=
 =?utf-8?B?UlpqYlE0UUprVzdMUkxmbnowcFAvRXZWZk4wTi9QMG9jcktYMXlHZmZWOWo0?=
 =?utf-8?Q?AbYxc606zKWU4TJB7homGxntOd5coGmw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW0xN1lxaXpWT3REbngrYnRaTnBBaUVDYUlJQmJkSzlBVlRXMGpXWnZzdzRm?=
 =?utf-8?B?dk9aelhFRVVFQUpkdXY1UmxwUFBtZ1ZDV2dXSFdhU2pKdnpsTHdYMGxCL1VU?=
 =?utf-8?B?b2VrUXJjcXFTOUVDcWYydHhmaEVUUWh4cnl0QnZKTUdkbTdPb1dKbk5KcGVz?=
 =?utf-8?B?Z2M4cm5sWHJYTDRrSlR0UmNGcGxFMXk0WWpnZWw1dWVLeDA2TklQUFNsNmR3?=
 =?utf-8?B?TmtPVTlUdlkvNXNxOE5pd0dQK0V3MHk2N2YySzhlQjNrL01EK0ZvdTQ2Vmtp?=
 =?utf-8?B?WHM3M3VaaHZWVjVBS0x4bHdxYnMvSlhxbno4clJtQVBoelBKd3VUMDMzSklz?=
 =?utf-8?B?Qm8rZlF0Qy9PdThQUTM3WFB3SE9udE5pNW54U05DRmNJOXZMRU0yaE1pMzFQ?=
 =?utf-8?B?OUhyTkpEMHNFTEpvTXY0Y0F3aXJ5WXQ0bXEvQ08vK3FTRDNabXBuMmFHWExk?=
 =?utf-8?B?L25wRUcya1dvMHNoYjlFWHJiKzRHVS9OVWdla1FKVnFTVHJoUGlvZGxsZDcr?=
 =?utf-8?B?Rkkra2orbnpyeFpEVkEyRC9ZSm5vU21CaEpJTnFMNEFHYUxtTnVHcmtFQlFp?=
 =?utf-8?B?RHgrMTFzUDFjT210SjBUZUQwOEhmajlIOTBzZmRnU1JoMzN2RGN3andaNW5W?=
 =?utf-8?B?ck5HbGpDb2w4UXltNzhXQVRUakpEb2VwWllkMFdrdTN5RzN5ZHlSOGFaV2Zo?=
 =?utf-8?B?K091RjIyY0pOdDFONVZMQlluRktOeWU5dlZMSXFjWGt1OXhzaDV0SjlPOU1T?=
 =?utf-8?B?NVBRa1hTUGlVODZZQWJ2Z1k1c09ianlpeVZQNlduTUttbnNudGkzbTVrN1Ar?=
 =?utf-8?B?dTVBbE8zcXZRaFpaLzgxRjFienJRV3ZIeXNQR0QwM1kybW5EemQ4MDY5NTRM?=
 =?utf-8?B?Z1QydGJ0amFDbjBCRTAyNmFESnM1U1pHS3RWSlc1SmFFSUFUV0g2SHJPbHZT?=
 =?utf-8?B?RTNHVWN6aTFhcWRZL3h0NG5sZndyd3dacXhhSk1rTEZmQW1HYW9nZGNkOTNr?=
 =?utf-8?B?R0tKd2RkVm01SjI3VWlqYVlWeEpIUEF2RFlzZ2lxQWVuamUxM05YYWNiUTVF?=
 =?utf-8?B?VmJBRE5ibXNpazBrOE1jUGRpcFozaWdVUUNMdWxaamJNem1DRUdYQ3hFVVNW?=
 =?utf-8?B?Ly9RTDlrVWFlUWJ1a29hWURCS3I0N05qMUVHbDZsVkxFZTFoNDlaL1BXcWNs?=
 =?utf-8?B?QkwrcHl5OGJvMlBid2MzMTVBN2ZaMTRabEV0OTJ1ejZCOG1qTFhPQnBuclVI?=
 =?utf-8?B?YUcxTUxmdjBNNUM3M2VnU202aSt6d3ZaNGcyaHEwT3BYNUFza2RKK1hwQ1VY?=
 =?utf-8?B?QzhaWXVHNHp4OTNlRWo3UUsyNzM4b2JYMHdRbkFMaEt3TGgxTVd6cmJLR1p3?=
 =?utf-8?B?VHMva3hsdk5lK0xFNG0zTDIwcVZ0aFJodHZaZEQxcU9YMDFsUnBZem0vVllu?=
 =?utf-8?B?c1RGVFVyem1XZEhhRUxXVUdLUlZseFl3cGh6cU4zNHZvVE1ZTlVNbkNWMGRG?=
 =?utf-8?B?elJNYm52NTQ5dm5YVnZBN0RZKzNTSkFIU2J2c3psbTNaYzR2YkhhdHdSNy96?=
 =?utf-8?B?NXErZ2dvSWNsOTQzZlpVeExoWHB3YUl1eU9Na1FwQ1VxNkdLRHlQZDBTbGpp?=
 =?utf-8?B?N3d3Unl3cHJ6R1RsUVQzN3VHeFBrZTJ4RGZjTzFxYzNmS0wzSnlET0JFdjhM?=
 =?utf-8?B?VGo1dE9kSENXMEM1ZjRHbi91UmZXNjE5aDkzcFM4WmplWHVuN2J2eWxiUWhn?=
 =?utf-8?B?T2thdVdhRnc5VEZ0c1JiTWNxOUpaK3dqNTRiZ0tnYndjRlRLMTgyaUFNaVlh?=
 =?utf-8?B?Mm9Pa290R2tUcm83ejNCcElvQ2RySS9KVktOZWhGZkNHYVM2c0dUbGQySTcy?=
 =?utf-8?B?UE5iZllLcGFuMXBuYkxpYmQzWWUrUXllbnFFcHhpVkhCdkJtNGd5SlFrRy9Q?=
 =?utf-8?B?WUhCdi8raTdMbFFSS2lUQWNnWGhMZnVqdjFhUmJaQ3F5RmEzSUIxNnVpWWZ4?=
 =?utf-8?B?dlBYUzNaQWdRN3FKUkVBaUs2Tnpnc2VEMlZFekQzMDU3aTJiN0ZzdlYwZVlt?=
 =?utf-8?B?K2NtRWJrc1ZuWTFyVUVhaXVqV0pzZG9FcVpQNHowa044K3dvVUNGaGMwMFJJ?=
 =?utf-8?Q?Fr2k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea47497b-b1aa-49d7-3561-08de1e1bc54c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:36:15.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FIMpvSNZ91TzwUuCvmypUAfNniMPqyANDL5XDEgRX/eLQieBdwTLoR7WzTwzPSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376

On Fri, Nov 07, 2025 at 04:19:35PM +0000, Wei Wang wrote:
> On Friday, November 7, 2025 11:57 PM, Jason Gunthorpe wrote:
> On Fri, Nov 07, 2025 at 03:49:17PM +0000, Wei Wang wrote:
> >    > (are you aware of any real examples in use?)
> >    > VM_IO should indicate MMIO, yes, but we don't actually check that in
> >    > this type 1 path..
> 
> >    Is it because VFIO type1 didn’t need to check for MMIO before?
> >    (not sure how this impacts this patch adding the VM_IO check for MMIO
> >    :) )
> 
> > Okay, but it still doesn't mean it has to be decrypted..
> 
> I think "decrypted or not" is the job of the 1st patch. For now,
> MMIO cannot be encrypted, particularly not via sme_set(). If MMIO
> encryption is ever introduced in the future, a new flag (probably
> different from sme_me_mask) would need to be added.

The kernel is using "decrypted" as some weirdo code-word to mean the
memory is shared with the hypervisor. Only on AMD does it even have
anything to do with actual memory encryption.

However when I look at swiotlb and dma coherent mmap I see it calls
set_memory_decrypted(), uses pgprot_decrypted(), but still uses
__sme_set() when forming the iommu page table??

So why is that OK, but MMIO needs to avoid the sme_set() in the iommu
page table?

IOW I would like to hear from AMD some clear rules when sme_set needs
to be called and when it isn't.

Then we can decide if VM_IO is sufficient and so on.

Jason
