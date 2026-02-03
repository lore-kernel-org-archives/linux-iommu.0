Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD9379986
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099895; cv=fail; b=F4rXFKo/lUhp3FAoU87hR8Xi/1stO1HEhUjOO5s3spyylboIcpyeG/7WR/2rgn9GgldgvS3M2pScxx3bWtR5EIEHMUgHaq2BdWpEu61KN+Pshz7p87UIxn0arI1sE47ApRbZQY0XzjGtttp8FZVr1OWDXC/HglllAZoNkGTmRj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099895; c=relaxed/simple;
	bh=ertuqN5CsTcPhMwFHLC8baIGBAKLL7jezndr/dtDB2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RBk21c39mPSb7FUA6xtrQuH7GIMw1RT1q5U9Uv+8ocnEP3l/DT+vBmUyMvCD6O7d4h9sm+8LWxQNKVP5oXMHKtUaBCBTU4SckOXSXiXOs/sZ0EntXed+HNFkJZCXG1ggn7A9YEqV2dOfyhfhVxMCdjfS3aqLsNPUYUconP92zL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sxx0L3Ts; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sxx0L3Ts"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqNJN4Ly6QyMOgWIM0M99Y7JrUxN2gjg+FaxpXzPVZCzkMhntmkH5aBnbf/HH9uWx49sXytTVrFUQv4XPTmqF2KbVmAWVnjnNyS0TK8xepMv4roKRKbbtlOCVZ6JwD4a5v1vRQSOW9DQd1ZHN/79FfFGhlDAG5EBVXDFX/f7/iTzmHp6pV5FDqtbhTecrNQBC2ao3kdV6D0JuX5sO5CFot7HIEwqEA6HjtgejMXe2ehnCPMzAa/zNtEknCwegHuppnt1ZWRhrIjQ3nBpZI56hzAcTP6vYs17UZXLH4ctH2/sl/O/Z8bUSCpjFy58K4t7h/Hnu1DB/fBipld3P7Xd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnSMD4FbF416plevn40SM6sgNuGfu4gf2oiQVSf/4P8=;
 b=q1jddIhJWzt9Rvef+tXBqQosyxexGO6lWYBUGHj8KBkshYkkjh3iFSuXHOaaTz4r6miaufmVWYwOz8XN81XCLo9wUSNKvNGJVytncGCVLwbE+eb7d+tfLxF+NlK+DfmC2+T/QMMQE0vgxVYdno6wYYtRDWOYqMDCWrIMZX5t0TGwZimq56rAWD9papfOn0JpePHHAno5p91E6/n7EN0kJNtYLYZjE7TwW6Cf7Fm5w7jHjP70gNaVKRd/FaybISnOmvSv8mvoXwGxkl9AP1rdSuWA6ILHpZYvcaggpVzr8Q83Hx5oUDyh3lECRFwdoE/26sbUffPGsEQuOuwawWwptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnSMD4FbF416plevn40SM6sgNuGfu4gf2oiQVSf/4P8=;
 b=Sxx0L3Tsu1lHO6pB/WU6ofcChFQhCQqGGpkBGPAbEe8WI7uanySDKlROIAo+DjaD0LN6OYZ5w/d2/SBr8SmXDAsIIVPew6z1BlWTEFvW85g+FZIthNIReti7Uf4n1w8a04t+sSFtGqnfpM8B47+yfbT/Nh7Llfkic4x5xUfkhi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 06:24:51 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 06:24:51 +0000
Message-ID: <95fa9ce2-51f1-4fa8-ad57-990479580b7a@amd.com>
Date: Tue, 3 Feb 2026 11:54:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: serialize sequence allocation under
 concurrent TLB invalidations
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, Srikanth.Aithal@amd.com,
 jacob.pan@linux.microsoft.com
References: <c20ac675bae8565ca6307eae65efe8b71345e62d.1769054653.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <c20ac675bae8565ca6307eae65efe8b71345e62d.1769054653.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::24) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa4746b-75c7-4b77-aa5a-08de62ecefd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VStiL003MmR0dStIQkF4dTJjZktON1BTUWNNSEtUUzFTOG9zVkRoWm5vNXV2?=
 =?utf-8?B?eVVhYjJhQjNERVNsVWJGVitYTnFCN3Z4OUN2WFBnMUI1RzhGTko4cUJ2M3p1?=
 =?utf-8?B?eUswZXVabkpyWXVGYkNDK0tCdjZGRmRqOWZWYWltREt6cEh2b2ZhUkpyQkNm?=
 =?utf-8?B?cVdVRm9IWkVqZEVnNWY1dnNXL0g2eTUrbGVxY1VtYmQxcUV5MFlZeUNaODIw?=
 =?utf-8?B?L0wyR2dKbG8zb2tMcExjS0ROR3RYdkI1TWU2cnFJRUJlZ2dZbkZCR0tBd216?=
 =?utf-8?B?bGNpRlBUZTdRMTRpckhUdU93aG5VTlQzMkE4RE4wdUpDa29OM0g5WVhmUWhQ?=
 =?utf-8?B?Vjh2NDBJSDJGSFp4bElJYlc3VGRtU0psRWk2VnJpMlhOd0Q0czdHam5NRVpK?=
 =?utf-8?B?M3NRZ3hiRzVNZll2QXlLV3ozOGJNZk1paUp5UERsODJrSWFGQ0F5TGcyWm1y?=
 =?utf-8?B?SHJLdzE3OThzSGthNGJLam4zVjZSZERHbHFoMmVhcVJOM2huR0J6Q2RWQSsw?=
 =?utf-8?B?VmtabGhPMWZJbzZpWGxKeHBzdmMvQ3MwSmxuNEwza2hsbG9kM0ZjRVNFblYv?=
 =?utf-8?B?QlRtUWdrMENFSEJBam5nWERjN0dPbThySTZnL1ZaTENQZE1oS1BjYmFmem13?=
 =?utf-8?B?ZkJHclVBQ1RtSDVPTCtSc3F2Q1VJNGJ5aFFVdExHc0dIVUxaQzI1R0t3QXZu?=
 =?utf-8?B?T3ZOaXF3eUxlZ0ZPWHduSUJuZ3cxV0h4cHpLcG1aMTRvUnozRWZaaVZPdTR4?=
 =?utf-8?B?ZTFHL01mcmd2MS9ieXJkeTQ5QmllZW1XY2xhWit3UXNVenlYY1pGcHNjTWtD?=
 =?utf-8?B?aU9nbGJRRFpPNzhXVENwamVZS2NSbUF2azVYOEdQaFU4L2JoaUtEQkNrSU5E?=
 =?utf-8?B?RmNtL1o5UENLQTgzaGYrSWNNME1uUzlIRWh4VkFLQThPaHE0akpmNjg5WE9J?=
 =?utf-8?B?MlVlMzVpd3cyYVVic2V2d2ZBQlF3am45bzI5OWFwN1hIOTUybWtCa2lkRVJX?=
 =?utf-8?B?anU1MktDREdnTnZmSkxKakI0NnhsRjJYMThzYWJPTjU3eVcyQkhpbURHdU9x?=
 =?utf-8?B?UXlyRnpTNnh0M24xMlduY3VEcDV6bzViN0p5cWdvVURMT3ZZVS9Ga0hhVmZ5?=
 =?utf-8?B?NExtbmJUUHZuVWNnQ2U4bHdGbDUwR09MQnhKYndNV1ZFZ21YVHZtMERMNW9u?=
 =?utf-8?B?UG0ydklYWkJyQWVpeEJmL1IwWnFqTmdmUklLaGlBVnM0NnUrTmtOc2tEZ2VO?=
 =?utf-8?B?QkdZT0VqUkZBbkt0aEJXamcwMWRUeGpoV2dyQkpZYjBHcThuaXZkTDB3bnFp?=
 =?utf-8?B?cVVyTnJVQ0V0OE02Mi9WMmRmMXZFdnRMa3V3eVR1Rk1ZQ2RRaUw2Mk9CTDZr?=
 =?utf-8?B?WjNFaGViSmFocnNtV0grUmFkaHJXdXBKUnlBTVhnTGdjVXNrR3R4SG10VEoz?=
 =?utf-8?B?YVNqTjhBZGV4ZDExYzJtZ1ZpVkw2RHhmY0plSlRMRlhuamRGb0U1VDFpVHUv?=
 =?utf-8?B?QWV6V1B1eVN4b29JRjB0bFQ4VU9qSGI5WTV3TWlxdWdGQldMc2NCZEg2OTE0?=
 =?utf-8?B?bHdQdTVoRkFtS2ovTjBiZXNnRWZia2R5TjN6YjNZMStoM3ZTMkFzTy9XMzJq?=
 =?utf-8?B?bmZueUh5NW5qU0tMNWw2SkhXcVkvVWNFeFl6UVpqRDJ1b05PYkl6Z2hZU1Yz?=
 =?utf-8?B?VmdId3hvV1JZNi9zTE5SYTliVkYzTS9XYjJDYSt0Y0RsS3YyZS9wanFpRTgx?=
 =?utf-8?B?eDlDb3ZvL2RYcis5ckNsTXZQVU1ZdGdWbnZ6N2lMd0xCQVRSR3RSTXpuaHQ3?=
 =?utf-8?B?cjRSYzNOOWNOWnQ2Uk1HMXk4eHJQamlRV3ozdEs5U0M0VU1JVlBpOHpOTmgx?=
 =?utf-8?B?TUxnOXIxT2w5TUtqMWhPbUF3ZFFOSmdVcUpUYUNuU0NLRmw2bU9zY2Z4Ujc2?=
 =?utf-8?B?L29Oc25abHhoR2VDUUlxdUtubGdtSkowZUNwem4vNlBiOU96dWdJaVp0R3VR?=
 =?utf-8?B?WVdDY0FhRGI2eFphZHFQazVtbEpYOXBLRzFhblprbXgrZ3N0SmpyMHJvZ1BY?=
 =?utf-8?B?WENmSGJOd3gyZWpSS09ZdTQxM2Ivd1JoWDcvT2NudGVDeER0eWNFOElRVCtm?=
 =?utf-8?Q?Q9Do=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2MzVUJtcFZscVdHOHNXdjU4d2oyd3k1S2NRa3czWnpqTW9wZG92MDhXMkJo?=
 =?utf-8?B?eW94a3o1KzAzRjBGbGVUV2RZUEVDK0dFeGh4MEhDdU9ZeWVJZUs2SHYyVzFy?=
 =?utf-8?B?L3dIZE90b3dpSkR2M1QycXFZdit2RklNNkJkb1VDQ1FQcWV4V2E2a3kyc1FT?=
 =?utf-8?B?ZDFTaVZ5Z2RsVTdBZS9PNjBSaVZyeFVQeEttMXRYUVIwS2toZWFtY0xZTzRK?=
 =?utf-8?B?djZkSEoyVlFVOXJuaS9TeHpxQ2FLQVhkemZITTJQa0o3blBBNk4xOEpUTUYw?=
 =?utf-8?B?a0R5YmZQMnlVRFhoVHZYVlRDSDM4enhLWEVsWU9zRE56VmdVMGY0TkNvMWE0?=
 =?utf-8?B?Wk1VWWw4RFI4TnhtekFCWlVLRkN3STlvOWhHSVh3MGFoVFB6OVVJbUdJalA0?=
 =?utf-8?B?OURPVTlpajlDTnBmSE5CcUhnQ0kzbUl0NnRwRFBJMExnRHN1dXhHcldTMVpB?=
 =?utf-8?B?aE9uWVF4VzNuSlE2WHpBa1N2ajlZZE9ldGpCcmsyS3lId01yZ0g3R1hnbmxH?=
 =?utf-8?B?ZmVJaS9mZTNJVHp0OU9UTmVYYy9yWmg4cHVLdEZsQXlJVjFMbFU4K0JrTWVm?=
 =?utf-8?B?azhxNjNtWTdNL25mQVc2ZFlBK3lTK1BCbmgzWjh5UVFYazY0VUg5YzdsVkl1?=
 =?utf-8?B?NDZFdVBjVVpST21qcXhucTUrL1c0MCtKR0NoVVE3Y0R1N3ZSUHBQcXhaaEZD?=
 =?utf-8?B?ekFONyt6QW01SVZVcDhvSXlodUNNNmZiVW1vcE9IMzd0KzFFTzJyNFZDbVQr?=
 =?utf-8?B?TVJkdXdDWlcyZmdMRHZmUFNZWTV3dU5nRDFUODlEWjFrTjZMVTh0RjNxT2g2?=
 =?utf-8?B?WFVCb3hNQlU5enJiNCtZLzRtbjcvTld3dGE5bjVobW9mKzMvMEREalhQMEIy?=
 =?utf-8?B?Y2FMRlkxbHMyakpBd0R5VlpQZUZqOUFKci9ZNmxEV0RQWmxFRnhKbitzRWl0?=
 =?utf-8?B?TlFHOU1IYk1zNVNEV2NzU0xla29XTDA1WWdla0NDUzc2UWlxVWxPRmNUZURs?=
 =?utf-8?B?VlVhb3UzSURJTThRMGlBZ1phdURHUmlROWo3K2VCcWRXWGRxSWtKYkczUXRx?=
 =?utf-8?B?eHNCYkJiaVhraWdWd1drSHBpMXc1UGFBdVFKZkNpbGFNekw2Z0I0d2tRUStJ?=
 =?utf-8?B?dm05NUNIV3ZDeGRWc2twamU2N1RnM0hXMEVqaGhnbzlmVzNnbDhqM3MyU1ln?=
 =?utf-8?B?SFQ2Q0pPTmR2ZHNzbzFOVkkrU1RBQ3Vsb3EvSlVuNXhya00xblgvK1lRV3BI?=
 =?utf-8?B?RkhITndJbytyK2hGVmFrRCtkMWkzMWRRbWlxWVQ1TG1tVHBEWE5Eb1lYbGRX?=
 =?utf-8?B?bkpSaXBCVVFZT1d4ajlpZ29xWjJiZzF3N2JYTzZUWjFhV2pPYm14U3lBVHdW?=
 =?utf-8?B?azU1S2JYWDEvOVdFWnQxNHlucStpeHQ2RTNTdWFFMnBFTUNQOE9UVTI3eWVs?=
 =?utf-8?B?ZERWWlFndG5DOHdwQUMrQTNLK0wzTFZBQWoyd3BXcXVsY2xrYTkwRmlxWS9y?=
 =?utf-8?B?Q0s4SExVS2RYUEV6dUlqem5Dc2dTa1poVjJLL3MrZ05mU2JsSk8zYWFFWHgv?=
 =?utf-8?B?SGlCaTVKUGJnTzA1MkVNcVF3SmpyalI1Si9sa1ByVE05dlhUV2dsMERzaEtz?=
 =?utf-8?B?U1lWL0JmYTEwNjBmS3pPRUN6Uk1WWDY2Vy8yMk5CZEhrUkU0bGEzdlBKN05E?=
 =?utf-8?B?blVSMFgrRzMwRC9KRzhzQTh5YmtRN2ZIc0U2a04wVVhURmE0SUdQTXBjamQ4?=
 =?utf-8?B?WXUvb29IVGNQcS82QnBTUXpKMHkxSWJNdVRSdUppWE1mYnd6ejkyRzB0dmJ4?=
 =?utf-8?B?OVZnTGE2aFhGTmZHcUVwc2l3WmNiUXpKUUp6UnRRTDdkN2RsUHVIYmM2OXFG?=
 =?utf-8?B?QmFkN2xEWFM0UjJiYkRKRTZMd3J1Q3VRNXhIaXpDWFIzTzJPbVFlMFJ3emF1?=
 =?utf-8?B?Y1Awa2NvSTd5QlhSU05ic2lGNjhocGhUNE1ORVZ5OWZZcU12L2NGQm9lY0NC?=
 =?utf-8?B?MzRBUWFFcTVMUFdYTGhjZFpiZUxFTVJyS24vSDhnNm5Lckh2MVJTTEIxQS93?=
 =?utf-8?B?MnMzRDJhMVB3OHVmdkp2Vmh5dGFXZDF2SGFhd1ptUmMrUS9wSUw1WGNYMWpl?=
 =?utf-8?B?SCs4aEt0ZHFGek9Sa1g5RlBwY252VThXUzR3N0xYS0cwZWFmWitOWkxGMm5r?=
 =?utf-8?B?QUsydWxIVUdURmJvTU1UeTc0NWsvb3VRYkdFRVo3MVFNS3ZLN0w1L0YxQlpI?=
 =?utf-8?B?WTRLM3UrNUpzWEVpakY3ak95NklWVWxCZmJaNVBmN3FZNjZ6ejN4VFd3eWVQ?=
 =?utf-8?B?REVZMGk0TGN1elMvQ3ZocmhFZVNHblIrSEg2M092Y1huSGJMT1dhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa4746b-75c7-4b77-aa5a-08de62ecefd0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:24:50.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdZoEsAV4696wRpZ0EsKppUd3HWH9KNXiAZYa/YpFDhXUtmpM2WvWyN7Bxwncqvpauf3ookfeD2IJDIK574o/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295



On 1/22/2026 9:00 PM, Ankit Soni wrote:
> With concurrent TLB invalidations, completion wait randomly gets timed out
> because cmd_sem_val was incremented outside the IOMMU spinlock, allowing
> CMD_COMPL_WAIT commands to be queued out of sequence and breaking the
> ordering assumption in wait_on_sem().
> Move the cmd_sem_val increment under iommu->lock so completion sequence
> allocation is serialized with command queuing.
> And remove the unnecessary return.
> 
> Fixes: d2a0cac10597 ("iommu/amd: move wait_on_sem() out of spinlock")
> 
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Reported-by: Srikanth Aithal <sraithal@amd.com>
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

@Joerg, Can you please pick this one? It fixes regression in iommu/next branch.


-Vasant

