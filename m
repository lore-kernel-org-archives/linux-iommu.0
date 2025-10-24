Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66A30748B
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316472; cv=fail; b=Nf9IFfnq0l3SCCi9VTD5Honjf/eJtxxPLWJH4jxKZbt/lJ5eji9l8rD0oZXgUp9s4R+jhljUJTg1MShOPLFmHtE2LixPANXCvBwsFK3WhKA6CBOwqjefv4o1JFHEK/Gdjas2k4J74gofpkDXwdhrQvtMb4XS3IOf1M5LjhHQPAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316472; c=relaxed/simple;
	bh=CDoiOyDUGN1oqOJeBBvVV+ecf+wJL8vcEgv/lKsU27E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mWowqDdTTZVzWK46cw1QXQA9FvZrGNuI6PgbJwcePGNjNWxr4DG2okBVbaLCc0GYPikVnq6IWbY5Pt8eHm0oBZ/nID8Cp1cbo7Bn/0/yRJbn8J3bEYdYm3IDG5gOIkHeqmNPk3Ir1aOqS0KkgcBCrVFcF58Bwc90NV+DlkeVg84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=slkj6lTO; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="slkj6lTO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItEydO7eVeWh5+ijoO9PmHsfjE6Lfua5A0qryJPTJR9BV0CFyeWUuYsdHzExaOjvnQyuFkl/DBWJCEz/dSX26YlnRy8cjQ8N/tTlo4DQE7oHlmCDn7DizoxxTgQzgXJtI4BWaT6gwR+aOI2WDuEX/6h4QL/q5JSMC784ztIMlVoPjMIbAQ7IMQkE5oNNGT4Yf2ybaKKvTiMyD6ap4OC5cg/JDmWSi4fcbFryYx2TH+r84BTCfTZ9hZmXqFlVVRywGPHpcvXfz/Ia6oIYo4DFCXllP5p7SJSuJZwgL8mGzBmdQBDcMryX7S4vLc+kXbObstLUAbbHehi86Q/xXNGnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIpvNpu9DzZ9C/Xah/9C0KY7WHBHglkSVMQzLIZWDz0=;
 b=xDytZkb2KmsoUO9iRRs5m8uvvWwnEP1rh/anlAn6ikJ4LdfhYXNXLz2AW5c96SzexkVeNC2sQd5BqW3ZFlT+Q6mlwQBJnAk5O9CJPnDphFOtATH7suUe3twkItmsn2LqLq0WsMRnMVZZfnOOgUsuaD0M8MYX8sL47Pni0epYrScultNomRMCzj0bAaS8aE40ecdCzDafsWw+twh1l+TNO2hu8rL5D6Xphc4+iPOTBnRqM9Gf7E5WSOEArY3pypb553nocbHnaCWpyl3+CO5y8O9okfci5lBNHRWKn3WHXh2ehiiuPY4GHM+WJUpQZ4x56NkXevmR/BuorBEfmhJNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIpvNpu9DzZ9C/Xah/9C0KY7WHBHglkSVMQzLIZWDz0=;
 b=slkj6lTO0BY/QIV2lqnzgArI0AWHFtaIj0uAbQOpWE5/QME1kqauCQB9ZMLWjDjwClBYuSA15TvCCcEwNmi+lsHyUuZ5FLIg5jWJS9iNConhjJIy/FJ0MTJWuEF7IhSdlu7vWrS89AVrAA1K8yoIBhRSceE82TWJhlZTHD4EgCVvROXWdyEhleCpPmF0Iw4V/grJjiJG2d0dIfh+oDfmIHWR26LH2wAji/FaaQRGNH/frheqiZxj641+aB+g1mBIWzdGpqKcUyQhsqX6izrH2rLm/vvxEfGMAGkq/Xw1VrjwvCpb1nts5S7GGPDNpY2RubN0enwCpLLCoDnGCn3FUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 14:34:25 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 14:34:24 +0000
Date: Fri, 24 Oct 2025 11:34:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v1] iommu/amd: Set C-bit only for RAM-backed PTEs in
 IOMMU page tables
Message-ID: <20251024143423.GF847003@nvidia.com>
References: <SI2PR01MB439358422CCAABADBEB21D7CDCF0A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251023160154.GM262900@nvidia.com>
 <SI2PR01MB4393D52AD53469388BED8E6CDCF1A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251024114039.GA847003@nvidia.com>
 <SI2PR01MB43936BE606220BBABCFA30DCDCF1A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR01MB43936BE606220BBABCFA30DCDCF1A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BL0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:91::11) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 5426c40a-94e2-4394-e6db-08de130a6dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REh6T2VybE1wT1F5aU55MjV6Sk15TUFTbWVFcGZXOC9SdG5OTEp5TDhXZzVl?=
 =?utf-8?B?SUxsN3RZdHZ3VFpsUXRJWHAzYlFjcWRJTFJDMEVraE9SWU80ZHFBakNFVlFT?=
 =?utf-8?B?c1orRTgvOGRPVWpYNXg1Sndka01KQTNmczZ6dGRUYVpJWG1Fc0d6WnQxSlA1?=
 =?utf-8?B?Um1xS1UvQVNyL0ljWlBxdk96WmpKaStKbEpvV1RtUGRGRWlFczhGK09HaG5q?=
 =?utf-8?B?czNmdUlyUC8yVXhSN2R3eERLU2hkcVk5cDlWMTN3VUllelZSWm9nRVZLNWE3?=
 =?utf-8?B?UEZHL3hoWmsyUXM3ODhzZU9vci8zclVYdFU3YVczQk5WZWc0OGcvOVZuRkt1?=
 =?utf-8?B?Z3gvQ0tsVXVEb2p1ZWhYMzZLT3FFdGpvWDhZNTRlK3JMZHVyRGZVRThXaSsx?=
 =?utf-8?B?dmVtVVE4R2RRMG8xSTBOalhKRlZURHBXV0k2azFwakNtdFlNNm9rcHV1dTZz?=
 =?utf-8?B?UDFvZk5jQWR3cHV4NS9WV2VZVitZUEJzUzQwVWxiYjRRcDlrbC8vWXJNYlVX?=
 =?utf-8?B?ZDhoMW9mei9mNUtUemtVNFoyUFcrZStLS2F2Vk1mYjY0VTBMSG1WZmxMekxP?=
 =?utf-8?B?aEVCZFcvOElhc2RuNVkybkVyT2U4ZUxXM2ZUaU1kR0ZRK21DcFgyVEFZcnZj?=
 =?utf-8?B?dlIzdDNxZlZaWU5jaVRiWXRONWVFNXUwM0hTSDhkWE9UWDFGOExNcndObmdE?=
 =?utf-8?B?TjlkeSt0Mk1yT2YzWHRsQUZOTEZPQjJ1Y052NDZNdVlRRHdrWWs2M1NReGNV?=
 =?utf-8?B?L05ZUEpKN2RTd3RFenJ1bk5tb3JPTXh5Vjc1V2pOZDZPR1p3dk1SRkw2dFl3?=
 =?utf-8?B?eWhwbnlGMlVBYTdUZlREdkQxbGNoMFltMHV3YWhyb0tkbDNrZ0dZYlJQOVRI?=
 =?utf-8?B?Rm12WHd4dDFzVktxaDdoQW4wZkh4Q2lpai9zMVFrbzNDQW05bmwyL2VaWUt2?=
 =?utf-8?B?R1FvU3B4U2dMQmRCZDdwN3JHYlpudksvL2NMODBrQ2IvbWR4cE9ZWm5PQmpP?=
 =?utf-8?B?SmNJNlhBL3dZV216cWZYUnh6aXMrdytJUTM4YVlqUXhNNW5EVEpXYVpYZklj?=
 =?utf-8?B?S2E0SElJYkNpWStWK1k5K0VZUG0vWjRJbVZNbTJtamtQZnhoL1MzbXZ2KzNm?=
 =?utf-8?B?aHptVC9kM2VOeTN6aXl3NXBoZkdOcmJwa3MrS3NBVldHODhLMUY3NTlmK0Qv?=
 =?utf-8?B?eTlDQkZTR3JnWDRkTGlZQWM3N3JEWlZZY05DUzkwWHpKRVhmSU5LSUFUNEtP?=
 =?utf-8?B?L2J2VlZlYnZJWWVYQUZDNk5UT3RDZjFvcitxNDNuUXVqRXFnTE51RzdPQXpL?=
 =?utf-8?B?eDVQRDBXcitTR2k4S0dTaEJ4S3FTTnFiK0pldm1veFFjdUQzYTl0azM0b1dw?=
 =?utf-8?B?T0gxRHBybDRpUFhLdklpcjdEYWZabk5wSWZmU3FOMzdpRWNFeWdaMkFHT1pk?=
 =?utf-8?B?WDkvUTZOMDRNaURGTWxjU1lpK1lVeFhXVS9WTUF6NTRQU1MyajBJV2ZUTjdS?=
 =?utf-8?B?SzdsMS9uN21RdWdaT0NZY0tnbXV1aUJtODZTcFhEeHg2UWE1OVpHeHo0NVdG?=
 =?utf-8?B?VGRoV2xLTWNNdURORkJPcmlHdDRieDBJMzRUekRKU3FqMnZuWW5XUFNRa3dt?=
 =?utf-8?B?RlFHWDlsMDhvNGJ5Y2Y3d211cmJWdTlMaG9IeVZ1MVVIS2JVSEtRMGE0cDlF?=
 =?utf-8?B?S1NMcmlqektXSnpFdFJ2T21LTno0KzJta0EwZ0o1eXRoeE9pZmo2Zk50ZCtV?=
 =?utf-8?B?Y0kzWEN5WFI4QU03bGJIaEkxUFp1YytxZnk0bFY4ejg0c1phRWl0WG5YMFEw?=
 =?utf-8?B?c3Eva1hUblBIaldPNWlVRTdqRExDTnZ3WjFjYjJ4bG9QMXJOTzdOWUJrb0FL?=
 =?utf-8?B?d0tKUW4reWpMVmtkTGRodVdHaVRCRlFMVHNSQmFiWEV6cmxXdTQ5TTNCQkxS?=
 =?utf-8?Q?l+K+/NnyVlM0WBsR9V3eiDGlEGGxWawh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU9SYjNqejBzZzk1RzBCYkQzVXhoalNtTlE4TENRc2NFVndWOFhwNVZwc0xk?=
 =?utf-8?B?RWtidHZSSFlWUjhSNG1UNTh0dVorU3Z0RFpMTWV4NGpqZmpKZzBteVJSZnMx?=
 =?utf-8?B?RVZtc2l0eFBHaHBQdXJCSlNNODBBeFNYQkpvR3ZzLytOSUVrSERtMzBPOWdL?=
 =?utf-8?B?U0ZMMndKSUhqTXNwME5FdXJFdG5QTzMwUmovd1gyaHVENTBsQ0xNUG5EY00w?=
 =?utf-8?B?WFJRNXFudFlMMVhIRWxyZ0VaNE1taE1ETWRnaWdpUGZMMDErSnB5dWl0ODEr?=
 =?utf-8?B?Ty9ISzR1Wi9rRDBkNXA5UnJFSWJ3cHFGMEVFdU9pL0Jaemg4Y1Z2UzJwbGVX?=
 =?utf-8?B?dWh3TVdETUpkVU1SVUk2OXRFMWQ0YUhjYUkvVmtoVmFyTzNQY1VORCtZb0cv?=
 =?utf-8?B?azhvVkFuMUJzdGNLVFA3QlNlb21yd1ZUclhoc0ZXank2Q2FSajE3QlNoVE9P?=
 =?utf-8?B?V2xTcmRYYWZMbUg4eTdzRUFBVmlDOE8rUU5CRTliRmVrL0lQTXFUMzArbEV2?=
 =?utf-8?B?SjJqYXdSOXJTTnpUeWN2d3BweUhUNUE5QVBmbWx0VndkVDFuTTlaYjc2cFYw?=
 =?utf-8?B?TUxiR0d0TWQ3aUVFMU1HYmJMdkxxS2k3S0ZadkFPN3NDaHhYdDQ3UzZzUGJF?=
 =?utf-8?B?cDVKNndwSEZ6dVFTWTFIMytranBzN2NUUVcxclJ6d0h1eTE1Q0dKWW1RNFpS?=
 =?utf-8?B?K3YrRXNTeGw3ZGoreDhjV0tTa29aQ1QzK2ZCVjJNMktlZzc4V2ptaDVtbVlT?=
 =?utf-8?B?ZWNZWW1ZSGtjblhMaExKMWhZWm1XZHBtbUdWOHA5SlVnZGROc2xaTHJHSDhR?=
 =?utf-8?B?MjdKdWpsZEhLSGRlcHExZVN0aDh2T3V2TFYwRGxrNUNxUHBDVVJ6R0R0WUFE?=
 =?utf-8?B?RGlmSUJRV2NYN2swUnFCQkR0WWZnV3dtTWN1MDZHenJoN25Zek1MVlRKSGRW?=
 =?utf-8?B?eUF2TTBOeUdUWW9uWnRFQXhDZWJkNnBlVnVBZHdoS0crMHU3bXhrdEFJcXRZ?=
 =?utf-8?B?TXlRZVU4QXRKWGFCUU5IMGk1ZThSOGh1ald5VTBlaCt6UCtCb3NwY1U2MG5J?=
 =?utf-8?B?U1M0WUFVRGQ2R0t0L1dPbEJ2VklTdkM1M3FMRFpPWUgvSm5GU2grK3NuVFh2?=
 =?utf-8?B?VXlRWnBYVjc2elE5cURtU2hNeWM5dEt5ZjlRZ1BBUUtyQ2M2RDdHWWFLZWpW?=
 =?utf-8?B?MldYQVQvWUowRHVMbGEydGtyRlFIcjlTWUd3ZHNwTm44RXBIa0lZZENIVWR6?=
 =?utf-8?B?a29MSzBFQXo1b0FhU2d6ZVJYczNzbG1ITjlZYUJWLzd6WWpFYXdlaVhHQTc5?=
 =?utf-8?B?UXdCaVdCdWdTK1NrYm04eTRERHI3RnBQNnRMalIrWWRRa0ZyOXFyVjhtRG12?=
 =?utf-8?B?ZWl0bFJvUExOc0dzZzZ5a1M4b3NvcHJvTFlMWGJWY3ZENWRMYUp1M2hIdTdI?=
 =?utf-8?B?eXpBcmR5c3BxVCtpcitWMnNHWmppbjNubW9pWStZcTZjbzJ6SlpNMU1tL0xa?=
 =?utf-8?B?M2g3UWJFMzhIWFEwRVpFbDJjd2RvN2RZWWY1cWVmekxUOUwvMENSRUdTN0NX?=
 =?utf-8?B?c3FXWXJub0RzZUFGWkRubG5HUjJ5NVdDQzdUdCtwNm1XM0dLWWlJcWlIUkQw?=
 =?utf-8?B?cExSSjViM2FHaHdyTDJJbkJtVnNXSG9jeStBVGdlTDhidkgwWURxTFpvc09R?=
 =?utf-8?B?R2pFWmdjTnB1UGRaTmlrWkV4WTdKc2ZLYjNHSS9OSW51OFNIMHp5ZXI0c1ZP?=
 =?utf-8?B?WXJud0RNMm5XQ2tiM0pRNUhnMDZtaDVCQTRNL3NzdmVmRGEzdXhNRFhMUkw0?=
 =?utf-8?B?T2tFZHBLbmJUZzU1Wm5uZ0pBcFJQMHUwVHc2cXZ4S0pjL1MzVHM5bU1BOFVm?=
 =?utf-8?B?bnhCY3ZkY1RKdXJyaHFFR1ZXZHo4a1RlM29FSjdQMC9sZnB6ZitwbVVrRzBq?=
 =?utf-8?B?aWY1c0J1amJpV3pHRUViNDBZWndQTkczeU1MSFJsR2RINXBXajQ4bDUya0o4?=
 =?utf-8?B?YldhMGNvekR0TnovSmZvMmpJMXhOdDJjdEJDV3RVWjg4L2VBaDFaM1hyUU9Z?=
 =?utf-8?B?VmhtaVRFMU96UDQ3WlZXdW5zWWI1TmZ4MEQyVjI1WWxMU1ZnVDMzY1pUNEJq?=
 =?utf-8?Q?smss=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5426c40a-94e2-4394-e6db-08de130a6dcc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 14:34:24.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OAEOQn4PmHv2RQTX9pbF1lWgznuY61vkZoq7xKOAwQlMUAZwmzTu1VhZTq7/ql1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124

On Fri, Oct 24, 2025 at 02:23:54PM +0000, Wei Wang wrote:
> > Again we should not be trying to guess if something is "ram" or not
> > deep inside the iommu code. We have IOMMU_MMIO specifically to tell
> > the iommu if it is ram or not.
> 
> Sorry I think my main confusion here is why this is considered a ‘guess’ of RAM.
> The function page_is_ram() clearly returns whether it is RAM, right? 

IIRC it is not reliable. We have a lot of things in modern systems
that are cachable ram-like objects that page_is_ram() may or may not
return true on.

Further, page_is_ram is very expensive:

int __weak page_is_ram(unsigned long pfn)
{
        return walk_system_ram_range(pfn, 1, NULL, __is_ram) == 1;

We really don't want to be doing something like that for every IOMMU
PTE.

For your immediate problem IOMMU_MMIO is better, but broadly I think
this will need some attention later. I'm not sure how something like
CXL cachable ram is supposed to work through these APIs, or if it
should have the C bit set.

Jason
