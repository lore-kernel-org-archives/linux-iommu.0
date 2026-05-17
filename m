Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26063C73E1
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040540; cv=fail; b=kSoTXcxAX3OA4zC76OSTX3g4Se84ytGzTYrgBPGidfrFVWO+itJp78huUBSdT5cPLV74Q3y06U/B3kEdQ/rSAKQBSzlphaeRxghwHbYwmVNQY9CvpCgqxrGUtmxUQAcGrK058icVC/MDyFkFoQeH5uFEHIRzdqq4w0nZqaYBZw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040540; c=relaxed/simple;
	bh=FRfu+4lDiqwTGDdK5mXTukeW3ZTY6Yja7jyu4mPwJ3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BKQKrHn+jrX3ftLhUiWFoDeGoAi36QKg29/MammZd0hLUjRnBosmIRdw+MwM9094vmESqKDmRsiVpuczuEPlUuj2p3SvDm0VHU8tEqw6lhxYYmnQAoQ8quw2SyBOTrG/VjzGuFGnqNFJXNbWMnghC6AL4SpH1OHJNQUmMfsDnp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TsVgv8md; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TsVgv8md"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jN10oa56huAmQCOzd48XJeaKitVj8YsovwHHfspjU0ftEkqpmcfhzaUgYZ4oSGvaAfK9OK43MHGRC2+dElQzbX8y17bOSbGjSylsleB7SxVnvo1xM+Ht7PA7mYN5J8GlNdFTRNflnDpg5ESEsgzoFIm4TG1RlyvXhmZUJ+y0N1ln1sd84fGW8liLU8nnEJJSZgNiVb1QNBDEaagDQ1vIQ6Fuc5sSkBWJNgAE+l4ltLv72G6ah8Mx7PKo4FOxd6OT+gtX3v5l5fDGV9adk9tLRlIHiSE24aZ4xLD38dcu3HrJBMoWmb33+g+kV1uq276/wN5gOA5eoyR15y3U6oWV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRfu+4lDiqwTGDdK5mXTukeW3ZTY6Yja7jyu4mPwJ3o=;
 b=eh18RibapeXAeKeDTCKFJwXSlTkyecU268eRVH1XUcl2rO2EQeoHHJrcXlgljvXAHmp/BaqnYkAcltwNciajDWetD59zSu4zUJsOl9UjdPN7r89ElGMg5MgJeeKXl9PnQaGdFaPNYveG1ubFyJOtTgmdravt8YrTEpoUjGBORTRrHpWTOi9amgSwAspZLqUl/nhsjGS/8M+/Tu6CAEpLefAN2Mksj+ksj8GuddRXtiqWcyOhk9E2T4WrlDvh5fIIeNSMEPHlEynQguaJ4sZuhunQs+XuCxp1ADyFlewHpMsBLNi6qr+cWPb2MSN31QmG8O4p9rSYIcMZ7Fq64fHsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRfu+4lDiqwTGDdK5mXTukeW3ZTY6Yja7jyu4mPwJ3o=;
 b=TsVgv8mdpvHhU30C41hQ6m4Bu192QWOTLN/xhLYSH45pEdB9YuiBChbmok9dkADiuw8o3oSsOjyJa2W89y55tIZxuJkeWkJQdcRvg1TTtBzAWq3Yo+3AdEE/OCOFULzcjQ5m5efn55TLo5RBRm/QFTuDgSMhIK/F8P1tabX9NwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 17:55:35 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%5]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 17:55:34 +0000
Message-ID: <a9e17e1e-8ff9-4dc8-99b2-37bde23755d5@amd.com>
Date: Sun, 17 May 2026 23:25:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] iommu/amd: Fix and improve SB IOAPIC IVRS
 validation
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 suravee.suthikulpanit@amd.com
Cc: Wei Wang <wei.w.wang@hotmail.com>, will@kernel.org, robin.murphy@arm.com,
 thomas.lendacky@amd.com, aik@amd.com, jgg@nvidia.com, kevin.tian@intel.com,
 xuyongwei@open-hieco.net, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <ui2oa3gdlq6v3qfsezadn7rxa7osisjmag7us5ufw2k6mn75gr@mzilog72gwf2>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ui2oa3gdlq6v3qfsezadn7rxa7osisjmag7us5ufw2k6mn75gr@mzilog72gwf2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::6) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b7e8e9-b839-4c22-35e7-08deb43d7e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	SVxdX/D8C1gkcpxvMJtAKITU3AsNKVa0wf/6SjE5wml8rFZmKzdGSKfCsrCP4apwQ8sFxjt5iTJmlaOgcHuEWj4osRYqrxq7+ftxtcXbFGdDgIF8+yF2C7Wjv2IyFrlff3MJFYeT6OPFXnibDMSV/delV9kAlsckkIJEy//9MxbGarTOYCzE24+q5IuHTRA+WMNYV0TQWSH5cw/SSXqxknszW+3L2NF4XkyA63wN3k+EyvF23J9yQ8m+GENGgCcuGUCLdTLO+QyJNmEzPTs8owTlHJYLFYAIdaGi9RBC3TTJ0E4WWdV4B/8bkSGZTr7tBaTNo3PahjhAU6ziu5TXSegzgsIq13DzdNo1m3BTi5794vyyoqFo0wbhA/8WFshqZ6zBLoH+d3On8PeR4kkM6sAT1JiVXQCpmjYijCv0eIuR/bHMBrGQPPFfwyTEwQJsQzV5qRQME2x5GEi7Oi7Bm6bYI8qYo9+S97K2dRhxsrSWV8nl0sArdj+6LBKyKO5vhkxtheTrUtrS5cb79Ih+ZM5pl0cIfSfx0jChqOxcHTWgZ0igSzJDLbtK2+DSPe8DvySxw5ZIcfuz9k7muG09QMZq7J9/i3eNAZtVj7X+ewJcTETSmLsVGCbge+3i/Z1e8scBA6+uxi1ameYsRIefwEo5sx2Y2x6JhsCtL6bKDFG0wzD3AGiohxArYjYapbS9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHp4WHp4T1YxOURCMjBBbVgyZGxSemRKNHVINXI0d2NuYlplc3JEUXlWclVO?=
 =?utf-8?B?U0tDRTFGcnkwYTZwRUNFb1NKeGdyaEpMMFFlTjNuOS9kRTB4cjIxVmVwRUts?=
 =?utf-8?B?Y01mR1diUUpvVG1yWTZ1VGVvTVNPR2FCUXhYcEVSYTJIdnVMSm0yMDMzZWdS?=
 =?utf-8?B?YURKS3BCZmNCQ2MzR2RGN0o5Vk52OUlaQXBobzNOTklDS0R4elIwQU5GeWxn?=
 =?utf-8?B?endPcnFPcDlxRlowQ01wR2QvSlZXcmRFUjJ6ZXBjVUhISTRnWFl1aDA2c29V?=
 =?utf-8?B?ek1jSlZVejdVeTBDRVIydEZBNEdYRWE2TEIxQ0RlU2doN1FWN2xxbEZnbTZp?=
 =?utf-8?B?MlorN0FjWFdXQmhRRW1RbktqMWFoUXl0dUY4VUF5cXdaK013WTQ4UTBnRWFP?=
 =?utf-8?B?N1hWU284VEVTWnN5R1FPMHB4UWdNTEhCaVRnbEw0b2hJRTkxaHJ1N3NtNzFM?=
 =?utf-8?B?bzdPOVhUc3M1cy9ITG9EaDRJMUtNN1VkcmduNEF5SmpyQXhBQTNUdGdCd1hS?=
 =?utf-8?B?YVljU0liWGtKMllzWEZIZXdjOXVtQUc4M2xFa1NkL0RuOE5tbWdJVTRGYis0?=
 =?utf-8?B?MEJIcXduYXB5MjhIR2NhaGdWQTh6REJmYWdsRnVJZFZ3WUJFZUxrbTUvQ1RP?=
 =?utf-8?B?YlRWVHFzaTNUbXdodEdMcDYvMG0vU2Y4U0VNaXdFR2pBNFBLZGI4ZUVqdWtO?=
 =?utf-8?B?UUs5U0lEdTdWMEI3ZEJZK3d0ZGhzSkMrY2MzNWFiVUJDMXJtYlJvUkpVMlhj?=
 =?utf-8?B?a2lQbGhSOEVhdnNJS1MyYWthZDdSa3RRQVNOZ3Zjbmg2dDRZd29tdm1OdE5Q?=
 =?utf-8?B?TkJ5NmxDQ3g1dXByZDBqenJoc3d6ZUFxZWxEOU5VNDdUSU1XWDNKWlUva2Q2?=
 =?utf-8?B?cTdoaFh3YUhmK1BLV1ZMWlJPRFNzNHJLU1I4ZGhRdFRxcHkzcWtQNmtsNjB0?=
 =?utf-8?B?MFhDQkNCcVdXM0EzakprQ3RXZUZ0aEkxZUJocHJjcFdVN1hLWkFyVTlEQTlJ?=
 =?utf-8?B?UG15VVYra3ltWUZjREc3Y1R4clYxclp3WDM1WmtMUXltWVdIcWJLaFZIN3FE?=
 =?utf-8?B?dnNucEJ5NXdnT1BEV3FpR0s1QW5iVXlkZUZqZ0xlMmpzR1N3bFkvVEFKU0Ji?=
 =?utf-8?B?Y2g4b1h6R3U0UUlJWG5heVRmeWpCVm00UGUxRWtEdUI4MkRvaGRRRml1dmhP?=
 =?utf-8?B?dzQ4YzM3WFBjakp5UnE5TEMxNFdYSWViOTU0M2QrQk5yNEU1SUVYT1ErL0pz?=
 =?utf-8?B?c0UzZExFaU9VTE10NUtoR0hRVmtEYkhGWko3VWo4RXFEZU03YzJZeGNmOVll?=
 =?utf-8?B?T1hzd0lPbkVtSG0wMkJXQ1FGTHU4Zyt6OUs4RVdrZUlPMmgwbk52Z3cxVm92?=
 =?utf-8?B?VmJaeU1KeFlZeVFKdFJNazJDbU1LajZjQjRLS29mTGw5THpxdFNCU2FPMWIw?=
 =?utf-8?B?Rkd3cjFydUZwc2ZMcno0ZjJTUWFndU92RTNqbzhjSGY2TDQ2Y0JHV1JZeWtw?=
 =?utf-8?B?WExoYjRVKzNDTkVOSURJeGF5blVkR3BQc0RQbHFmU3lMc3pNSnBQUW1DTHVJ?=
 =?utf-8?B?dE11NUtYSG1uQUtBbEc2d3EwVUN6NTdkUlVzRUc5MVUxYWFRdW1udWl3WlVz?=
 =?utf-8?B?ODNHc3hyREtRSjNpZjdBQ1cvaXVBQXdwNGZZWDZUcFg4ZEY2Szk5Y05sVjhn?=
 =?utf-8?B?UFBGZmxxRzRsMW0rZ0Vla3dFUTNtVHhpNWFXWmRmcHJTbEVzY3VwS2hETTl3?=
 =?utf-8?B?WTU4MEVCSzMwcWxad09pR2FSdk8wR3hqYkJhdTEzVHlSRE5sQjR2bnk1ZzQ1?=
 =?utf-8?B?R084MHRCZ1ZFQzZGNkZZK005Qlpab2l0SnBZZzE0VktVOVJTZzhWaEZHMVlV?=
 =?utf-8?B?cDRJUE1qYmk5dDJVem1zLy8yTTFNMVRYT2pKY0NobncyTG9OSFRYdGlDYVdm?=
 =?utf-8?B?aFlmVFV0UnhkaVRlbXpLbERhQ3NtWnBaRFZMVzM2RXFKaE9FcDhCeFZFWkV0?=
 =?utf-8?B?WWxBeEY1b21HOFNINndTcTIwUUw3UGkzZ09xeXhpU0dlaTFyOWVFZVpNdVd3?=
 =?utf-8?B?c0RIaFlUWjZzdkRPK2ZlanF3di9YWFlHMXovM2NFNVkxOUh3bXpLRUZFU0Zo?=
 =?utf-8?B?RDlSc1B4WmFEdHNyb2FjK1Yzd2paYkxQOW53cmwwUXlQNkVHQ3hDcnFXTlV4?=
 =?utf-8?B?MG0vVmZ6SkVPNkF5S1Y4aFJGMWVWcUtYbmgwY2V1cjBJa29zUG85NW1GcGhB?=
 =?utf-8?B?R1JScXoxclZEdjBhTlBESHlQRU5OVHBCYmdVZ0dqMHRZTmZOOVE0SklSZGJu?=
 =?utf-8?B?UHZqVDlCenZWcE16VW81NXBYS0tsZG9qR2UvSGMxUXlxck9FSitQZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b7e8e9-b839-4c22-35e7-08deb43d7e84
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 17:55:34.2961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/q/WZS6+4gVBQZfsakOOQhREP4uciI33F7mVoqk3+g4wB1ZKREVru/z6xd1dpNGBkqyfJvgfe9jm8Y3qchQuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

Joerg,


On 5/11/2026 1:10 PM, Jörg Rödel wrote:
> Suravee, Vasant, could you please have a look at this series?

Sure. We are testing it internally. We will respond back this week.

-Vasant


