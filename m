Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC301B412B
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201807; cv=fail; b=qojgLtPiAG+741N3CJo8dvvPrhcdf4DpYvCMpUpeexkcuLAmBFgYRQLJSJiDeULWlf7oQhUc4G/DVaTnJosTCXiOixB7mGaytbvrcSaa3jsRcuqI6sfnIFOKr8CNbiF9J9QAgd5Zo72rPAC7eOODNqPVv0pT1vi/jyILgRQzSvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201807; c=relaxed/simple;
	bh=ac1KUQ39oJ+KYaqpFfOOJ8DXBGgWPPDytysAbb30ngo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXsF+4IPolaP5H8ndwLUIW48jCGIsKQtlbxAf9oGusOPU/KJnGHGSysOctrGVlsoV/hAmOfvaSbgWs+T0hUiU3HTe1rbyAnHGHP0NjoMzKgTxZGZ63nPPbVM2ITSjkyrjT9lHLfuVWRH51uCYqIbJLZAywEq1Ye0a2ls/e0ynAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=riEYAQEQ; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="riEYAQEQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQ0LHFLvOC11nqxOu4Q9LLUBeoZ53vMhUnXpkm+jCj18MEL/NhCuIyQuWs8fMBb4CRg/n6tpxbyRAVnotEP6PUfvtHvo8nDCqU2mVFu6084iFFAiYehyJsG1aYawWowDsI4K8IEsTzM/ag+j5cosFhzDqKy0ccqox3Mc4JwI4/Yiefn2cZeBklEDoGUZI7LaqhnIS1SIXCScjh1DiAy7DdQB6oFJsQtxkijdGwY54CpR0vBbhkQP8dI/il5bCzzJ8BhEJ8edUpGdSDWipls0RKp2DL3byaGIMn8er58HVaxY2pb51M/ir7CL7dJ87SxY3bIgq3no5l7GDm9tlOMt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kUuBvlvSirBYfe2rEYuiQNXI6E+TOytH5ygYT2Pez0=;
 b=FaYsHeDU3Et8EafIBS/baVsMj95eyMZpXQKY4zTxq7uaNJCbcX0hSKldat4HhUtgONVlfmxWzG0OOQAXGk75qTWsNSUk1kkti4Cw0INAJrGcx6/qUseC/2cUpL51ADgrX5OAE7+yWLXfiUWHj8v9Hukx3LnhqG7rc2ig+C7y6MJBw1kyQWnW4pD81l68V9k6PattQluF7iI43od8O2cifgBG7Y0zAWvZt3t61E6m+ZIs3FXy6mBWYfqtrmDCh9NS7z35/9z3iBoWh7bkzeYfIoM+eJkRLMGu7OYnP9hvZhf84jeOlzjs3QGsXGxglYaZWPSBgm+8tdm6er2K3jN4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kUuBvlvSirBYfe2rEYuiQNXI6E+TOytH5ygYT2Pez0=;
 b=riEYAQEQeJujS53plzaiMEkRKUmO+GDeUN8oPBKlTUHT1uj8ugGNa46zQljFcZmSvj9HpgZVCkcsf4YA4FwO9BsKcWf4/PgRPGLl2znovqyi3eMFJNvZZTb8oOkXBxY+nC19tktBG4Tl5pFy51w0mMIWqk6tBkVXYvGWZKXgGGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:56:41 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:56:39 +0000
Message-ID: <0fff7dea-3a7e-4305-9ce1-066fd86537eb@amd.com>
Date: Mon, 17 Mar 2025 14:26:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <4a0e64e9-57c5-4f30-97bf-00c3eafe0b8f@amd.com>
 <BN9PR11MB5276786C4BF482199872BB2E8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f728d10e-97d0-44eb-ab2f-0e40d7d5f810@amd.com>
 <BN9PR11MB5276B52073263CF1AEAE888A8CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB5276B52073263CF1AEAE888A8CD02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afb52f0-5aeb-4f6b-7b7f-08dd6531a18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXIxR1lTRzZzMVBBZ0VaNnEwK0QycnVrRDUxZUYraXFINkpDK29CMGh2bStE?=
 =?utf-8?B?dDcrc0ZiN2ova2NHZmM1RjFtZWdvZ3NNMkdUNy9telJrdVBFQ3JXaWcyR1Nw?=
 =?utf-8?B?UWdtVTAyVjd4eUxrUFVuZFh3blR3NVNsb1BiVDZBSWdhUXJ3eTlHb1V1QlhO?=
 =?utf-8?B?bE1LYW42eDZCektrcTBRN1ZmYkJYVHhTQ2FmYllNa2lMZWhFK05GSzduNmR0?=
 =?utf-8?B?aVU0ek41QU9RcW81ZkZqNHhYVG9kZ2luMWY1Qmd2UG01UFN0cnd5R1AzUVRF?=
 =?utf-8?B?Tzh5dGt2K2M1VTIxSkljaUF1UFI0aFNDcVNCL0RFeE1zbjVjbHdLTndwcHFM?=
 =?utf-8?B?TmdxdWRtRmNNeTNiaXVHaGFQRU9yM2dicmZYU2VieHRHeHF5allnMGpwZERm?=
 =?utf-8?B?Q3RvU3FKZGZFWjNTT0RwZmZxQXIwUU9sZjM3Rzh6Z0lxRHJGaEw2czFuSzA0?=
 =?utf-8?B?ZEs0b0UvSlIzUW4vaXU4cHA4d09FV21qV01qaUFqcGZnTTVlOVN4QkF4eEkv?=
 =?utf-8?B?MzJiN3VsUjZBMXd6bGo0c3QxVkpVeVZuN3k2ZDFsKzJBWjhGbjNBZWg4MktY?=
 =?utf-8?B?eWRKT1pxWnBodzJ1UHk3Qm5CQ01xRzkwM09PZlNQNXZ3K3dVZmRsRm5NZ25m?=
 =?utf-8?B?RTZPcU5NS1VyQTJZMFhSQ1RBeE9NQVpkQWYyWGJqNmxmemNoT2JrTGdNS21T?=
 =?utf-8?B?ZXNhZC94cTkrM0lzQ0tONk5LMlIxUXB3b0V1Tm1Oc3RmK1RPU3dITVVUZzdz?=
 =?utf-8?B?ZElIa3cwVjlsTHJhL2lVUkxORTFNb2l1blhnVVUwcWtMRVBCUXZiSWNib1gw?=
 =?utf-8?B?ZHVsN29US1R0MGFrMHkyU2xQVkNHU3AwVkkwSXRneGRvTDFNbzFqMTliS0JO?=
 =?utf-8?B?WitmMmFQK0QyZUVXdUN4TDVFSWRRR3ltWmRqR1V4dm0zZ0s1bjhsdnpCWUxo?=
 =?utf-8?B?T3RZL2JVTWZCaFc5MXBDRkJZUElSZkszc2NsNnF2YnJZVzQyQkZVdTJQZ1dp?=
 =?utf-8?B?VkVvMUNsNTNqMVNJOVFLV1gyTFFyN1NYZVlJbkRpSmE3VkFnOGdLSm82MUd5?=
 =?utf-8?B?WXprcDE1WVlKWTBZZnMycm01TnEzakVGS0VDeGJHOTFSbk03ZDJOS0JheGpN?=
 =?utf-8?B?ek10enhSMHF3d2g0WkphTDBINmlZTEVWU3htZjNlVEFBNXQvaGhTcSsvcjRv?=
 =?utf-8?B?YTdoaStBZnYwRmE1b0JTWk13V1VodThESW9KcWpRT2lWSUNZMTFQMEhBelFX?=
 =?utf-8?B?RHl3aHp2VkVHQWRuOTl6WUNsTjlYUkxBUmkzWkwwaHBjMGE3dUxyblJ4THln?=
 =?utf-8?B?R2RjaEZid2dCSkNMMm1hamVpeloyUXpuazFWRzJPRkVpSEpyeGdTZ0J6WUl3?=
 =?utf-8?B?QWJ5cUJpcGtLVjlRekgrc2VMTWdWZGU3WTFFZGhaY3JhSEREdTRDVTBZcmlC?=
 =?utf-8?B?TkMyTzJJQVBFbVBkWEhCUEg4Y3NCejAzbTB4OVlycGVkb1IzTEQ3cys1ZGFW?=
 =?utf-8?B?V3BocXBJeGJRWVVpVGpJcDNnbUJWU2ROVlMyVjdwblRDcnNwYXNFZnBtYUpu?=
 =?utf-8?B?d01yNGJ0R2tYUmIySWo1QkpLUlZWYWFXcGx6QmFRaWs5UHBrK2JPZjZvMlNP?=
 =?utf-8?B?YnB6Wnl2SDdHU0Qva3QxNTI4dlc2bm41emVOK3R4bEJyOU05NkFNS29rRENv?=
 =?utf-8?B?WlFGT1pGQXZVdG1OcFFubzlCcnorZ1NRS1AyMWtCaHBjRk0vbmRVaGVKTVNT?=
 =?utf-8?B?MDU0Q2dVY3hNQ1FFRUk5OFk0cWppVVZkMW1PSk1tRW54WG5mRUh0TWFBRzBY?=
 =?utf-8?B?RlFERzJYcWtlTEZ2bGxiN1kxM0Nxb1J0V25BUHJ6OXZ3RExjeEttYjE1R1kw?=
 =?utf-8?Q?h/75Iw28rip5t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWF4OXhIalc5RkhxcmZRcGNNMlFtd2UraXZxM3IrQVkvZ0tMWDhhRW9XYjcx?=
 =?utf-8?B?akZQdVl1V2dxYWNpZnRSS2RSN05oUzd0QlZ6TExOUjhVZkpHc1dZZnBUWlVi?=
 =?utf-8?B?OXhmN2h5bmd6SjdTeGtNNXpycE5mcjFsV1NDWTdPOHBicFc4R0IwaVlTNEhW?=
 =?utf-8?B?M1JvWUxpcEdqK3NRdXBucW4yNzJ5aVZvOVBNWkNJQXhpQ3BYbFdFenpYWFZN?=
 =?utf-8?B?bGpzVWZFTmtRZmNjemk3S1NRdkFLbkNVZ0NVS0U2cVZxWDVGRTFWaTZGbWdj?=
 =?utf-8?B?MFFRU0pWSVZnbXlFaHdrdHptTzMwWDI0SkVPVXg5SW1kUWtTS2pzeVlMNlpy?=
 =?utf-8?B?UjhCV2xVSStqWjZucTVmV242eGFvM1lrRzZuNFg0VStSWE55L0lGNGJrc0tH?=
 =?utf-8?B?MDdnRkRxOXJyUWcxbEEvZitKanJlb1hoTVFwTXZHekt5SkJUMWgxaWtqRll4?=
 =?utf-8?B?b1BRaGtHK0dCTWN5L2JzVkFIWjRuOXVwdXZQR1Y4UlBwWDUwQ0FQS1BsQ1Vt?=
 =?utf-8?B?MHlJRXNFWEFCNjFHM1FkRlJiMFR0NXBUVXNpQVp2Wkd2K1JoYksycU0vbllU?=
 =?utf-8?B?bkFleTVvMTFZWGtxL0ZZZjlnaUJLandUZnNZM0kyQWhSZlJ2Ty9ReDZEbFpD?=
 =?utf-8?B?VkZhR3BlOTRBYW95eCtVRHdpNUQwWm91NmFEcGNobFMzbmoxeXY2bE51ajl3?=
 =?utf-8?B?SVBLdTZXVkMwR2tCVXZIeUhReWdvMCtOeUNVUzg2VE10eVljUnlSZlVQaGVL?=
 =?utf-8?B?ZGlRWXlFYmFiU2xzdkZ4Y3pJeldXMjM0bUtEeEJ0RGx6Y2hOUWFLNWpYMDl6?=
 =?utf-8?B?V2pEcC9UazZXZ0RMUmhCd25QZjlKcHZNaStwa0ZpVW43ZExlYmg0RlpJMU9Q?=
 =?utf-8?B?OHBtckY0SVVHait4di9jRTY0MzFydk5CdGtzYUVSeTZlM2N2WEhJaG9Vd0R5?=
 =?utf-8?B?d0F5WXIyNjd3UStvL1VRQVVHRU5HRVAwVjFWQTZZQ1hFUHptd2NzdDF4TVF6?=
 =?utf-8?B?Mnl3bVBCSTJkSG1FOHZEcWlDMGU2aG16bDlJby9nKzNibVVwaEdzMFJGZzJp?=
 =?utf-8?B?QlJHMG1CZFFWRWZGZHl3TXZJMnlLYit6R1d3SVZ2TnlweU9QQlR4alh2Wkk0?=
 =?utf-8?B?RlcwdXRTQWRjV2xuK2hRdk43MzF1VnRLVVEvU2dYQ2tCTFUrbzRPSUpNWnZm?=
 =?utf-8?B?SWxIN2VveXdKVFJ6MkNzNTFnM3U1WGcrWTJ4S2JNSENteFdnZ2dsTnJzVFVm?=
 =?utf-8?B?SjByd3FzM2lqTzhlVzdrYy8xT2hxUHEyWXR0SndGS0NrcTVnUW8yUm9EbUhl?=
 =?utf-8?B?bk0vMlBnT3l4TjFtUHhZQkF4NFVnaHZhYU9HYVZ1Rkx0VXZsaFBUbDV1dXBJ?=
 =?utf-8?B?cXlwQ2hjdGpzbzROd25QVFVFcG94dUQ1NlJwQ1BZYjI1Z1FaL2NZUlcwejRh?=
 =?utf-8?B?dUd2WVF2NlgrTVArMHo5bG9EYVhLVFVTRVR4VE1Qd2xzQzRlTjZSa201QWVZ?=
 =?utf-8?B?a2x3VzQxOWRwcndpdUdFR096RFpuVkdGZTliYnFEYkxYSWE5UXFoN0crZlRn?=
 =?utf-8?B?VmFlNnhlNFlDNVA1aDBmRFJTalNOOTMxZjRQVnNTTGJpeVdsTHpFVFNHNlRp?=
 =?utf-8?B?NGdRUjh1a2s5d0hVNUgyMyt3ZWdoNFp1dnVacFhDOGdadUp6Si9KbmFkZWl6?=
 =?utf-8?B?RDRXUGs2T2NXbE51ZkRJLzdEdkJiNkdUa0lBNjAxa21STVpOOC9MbURqZFdu?=
 =?utf-8?B?MHphN0syMlFhUHdtZWl1NEdHTnlGNUZvc0lqMkFpeno0bEkzbkxQeXp1MUFU?=
 =?utf-8?B?eEdlRFFTbFlZTk9wNHhEWGI3LytabktoQkhVNG8xbzRDUWJWOEpHTzV3aFg1?=
 =?utf-8?B?WFc2dmd0c1RBNVU0akdUM0tpMzE0aU9POThtandpM3M5SHU2eE4xWVp0ajR6?=
 =?utf-8?B?YStzQzZSbElXbVd1WmhuVFZTZW5vV0FhZGl6ZkxKRmpVdkZaYSsxMXBKWDZC?=
 =?utf-8?B?V3d3dGlibVkveXE5a0J6NHh4bldWZ3QzVHZ3QUM4MjRkR0V2bjAveDkvbXVz?=
 =?utf-8?B?SGZ6eW9Cb1dPWlZobVExVGtxbENIUUZ1MUVvWHRaa0Q4eE9sOGY5WVhMMGVB?=
 =?utf-8?Q?UeLyOF2wy3xjXXyosXTM5+0hJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afb52f0-5aeb-4f6b-7b7f-08dd6531a18b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 08:56:39.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ3fHcIwTeUtEYv/uPOQOZD/MrkR+2NZK/guuQdtyV7NIw/n3zSqMh3oD++SSLb+rknSAL1wLsCwJrcKRivkSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778

Kevin,


On 3/12/2025 12:45 PM, Tian, Kevin wrote:
>> From: Vasant Hegde <vasant.hegde@amd.com>
>> Sent: Tuesday, March 11, 2025 1:07 AM
>>
>> On 3/5/2025 8:54 AM, Tian, Kevin wrote:
>>>> From: Vasant Hegde <vasant.hegde@amd.com>
>>>> Sent: Monday, March 3, 2025 7:42 PM
>>>>
>>>> Right. Lets see if below flow covers all the requirement
>>>>   - Define new flags
>>>>     IOMMU_HWPT_FLAGS_SATS / IOMMU_HWPT_FLAGS_ATS
>>>
>>> SATS policy should be managed by the sys admin, while ATS feature
>>> itself can be opted by the user.
>>
>> "user" you mean like iommufd during domain allocation?
> 
> yes
> 
>>>>
>>>>   - During probe() driver will update this field (similar to max_pasids)
>>>>     If (IOMMU needs Secure ATS always)
>>>> 	iommu_device->ats_flag = IOMMU_HWPT_FLAGS_SATS
>>>>     else if (device supports ATS and IOMMU supports Secure ATS)
>>>> 	iommu_device->ats_flag = IOMMU_HWPT_FLAGS_SATS |
>>>> IOMMU_HWPT_FLAGS_ATS
>>>>     else if (device supports ATS and IOMMU supports ATS)
>>>> 	iommu_device->ats_flag = IOMMU_HWPT_FLAGS_ATS
>>>>     else
>>>> 	iommu_device->ats_flag = <NO FLAGS> (May be have one more flag
>>>> IOMMU_HWPT_FLAGS_NO_ATS) ?
>>>
>>> Here the device->ats_flag should be more an ats_policy thing? At
>>> probe time it's assigned with a default policy according to device
>>> type, platform requirement, etc. and later exposed via sysfs for
>>> admin opt.
>>
>> Right. We can call it as ats_policy (expected/desired mode by HW driver).
>> So now core knows HW requirement. Also default and global policy
>> enforcement
>> (via kernel command line).
>>
>> During domain allocation, we can enforce required domain specific policy.
> 
> yes
> 
>>
>>
>>>
>>> Actual ats enabling/enforcement is done at attach time, according
>>> to ats_policy.
>>
>> Then during attach_dev() we pass those flags as argument?
> 
> the policy is already stored in iommu_device so no need to pass.
> 
> and the domain also includes the ats flag at allocation time.
> 
> Then looks no need to pass additional flags at attach?

So when user request to change from ATS to secure ATS via sysfs :
  we tweak iommu_dev / domain and call attach_dev() ?



> 
>>
>>>
>>>>
>>>>
>>>>   - Based on default setting, kernel command line option and probe() data,
>>>> core
>>>> layer can adjust ATS capability. i. e.
>>>>      - If we have kernel command line (say iommu.ats=<x>), use that data
>> for
>>>> all
>>>> ATS capable device.
>>>>      - If not, apply default
>>>>       untrusted device -> force secure ATS or no ats
>>>>       If HW needs Secure ATS always , enable Secure ATS
>>>>       For all other cases use ATS
>>>
>>> this is an interesting one, i.e. whether we still want a global iommu
>>> option to enable sats for all applicable devices/domains. the pros
>>> is that it is simple and allows underlying driver to add sats support
>>> before a more flexible sysfs interface is ready. the downside is that
>>> it's unclear which device/domain types are affected by sats on
>>> different platforms w/o digging into the hw detail...
>>
>> I preferred global option (that's why this patch added amd_iommu=sats)
>> because
>> as you said its simple, can be enforced at global level. Also w/ sysfs interface
>> we have to update for each device/group indivisual. Another drawback is, w/
>> sysfs first we have to unbind the driver (which may not be possible always),
>> modify ATS setting, then bind driver again.
>>
>> In Summary, I visualize it three level:
>>   - Default policy implemented in kernel
>>   - Global policy enforcement by admin via kernel command line
>>   - Per group/device level enforcement via sysfs
> 
> that sounds like a path forward

Sure.

> 
>>
>> Do we need something for iommufd/vfio? Where user can tell desired mode
>> while
>> allocating HWPT domains?
>>
> 
> we should not allow the user to change the ats mode/policy. Just the
> option whether a hwpt needs ats, i.e. from functionality p.o.v.
> 
> Then whether this request can be satisfied subjects from the ats
> policy/mode set by the administrator.

Ok. Let me write down the details and then we can fine tune it.

-Vasant


