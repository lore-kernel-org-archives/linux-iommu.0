Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942732E856
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328851; cv=fail; b=tFa8gJQQgRxxt8RpXg5q60guBz6OH2k2mpfe9f0gAFCYEFLjoG98Zl2sZwTuI7vM/ria+YkHAOa+67UKmbqrr6Hovizso3+fkRbA2L+e0JYjLJJul4ZLW0TqYm2OJASjBJ470PE5olekAwRzSePEi3fDWC376Vpq+pbCH0B2k5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328851; c=relaxed/simple;
	bh=EWo5JpuVWtgY0hUqqZhFq+67/C0/qqDJnQY36Q/kb/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+FWwUy3EPG6DDXSrCc7rHlN8ASpEDPegjUOmCxCItmYvRBmUUhAJnntjg53l+AmAjbwmfP+NkhVYnRtsPDbdqOO2F/Rtw90ddMdAu9TyhEw9OPXJh4ZBc1zRO+pz/GG7fvItNWM+L3Nvg8krctslGJgs4qN1w+C/k2IhGK4kPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ieI3qmD6; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ieI3qmD6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4/ORWrtUK6K4e3g8Hhg/hGsOgzpsunM5u0DHnVbnoCe7OeGqXVtVgNpNWEuajS/om0bzFMSbc1MHF7fhuahvt/D1j3PrCGSXAh+hK6oBH0Ju6xY7zXM4CDTxNiVTzr5y/ctjLew/TjFUiJv7vFwva8iqGPDQWliCalyINdTwtvruTMT1WbsBLdzF2yARm40OK/2cCpnzocdQ0GSnWcZCGMU4Mp5U30ZGAwQtffHETJZU0T7WCuOfaKOSem7zu61hZSu/HOtHplDkE/0hTABqt/VCZ6LWeu+aC1YTrvCsfp8Y1k4kem/rEScX2ft6tM5VnIYfL0GXnJkZlmx3p6GeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk5sqw1y2jOVY2iuFdIJc7jvEb129WJ4W49Sld652MA=;
 b=m1Eh/FmbI15qpW5Y8icMV6esZTnNb8fFBDnmZ05qlxakdw3VtVdTevq7Ki6lzqdXXXHVkrO/IvqCf3XN92zw78DuxGiiMrAyZNkYxy4xoUvchGmY7w2wnjEsU9baS93bYnLDK5XPfHRtptTY0xl8GXvo86mnO4PnShx+WzBmzwlbAVMhehUKvKQ/bp4rM1twgEaeLSXaq4Ex9d63xcXKSM+S9nVxO/810FBn6TZrkRVCp+7clTb2d7DOmFIM4wpYM9Px7q4xDMxtPbuhFF8KZlwaH5/rT3GVIS6zljh0z962n08LGtmGY5n7hwlHsIFbqOvWn5BNf98JyBnKvX61Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk5sqw1y2jOVY2iuFdIJc7jvEb129WJ4W49Sld652MA=;
 b=ieI3qmD6cZhiYCB/MbKOuj++1MkH/tq87TVw77n/1oenWGgDF7oeS/4mWEYevlaYMzwdNzA1rX7uLj8uKh65SAEga927wNa0H2f2lw41o3L1nYfWTAC2TtZ0GD2ryc7S0mby7pPVlsuV4ch1Lxxu1MAjm+6bFpI3nA3uZ8sqBMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.17; Wed, 7 Feb 2024 18:00:47 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 18:00:47 +0000
Message-ID: <d852455b-aea0-5484-fedf-4ff4a0a6c731@amd.com>
Date: Wed, 7 Feb 2024 23:30:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
 <20240201214949.GT50608@ziepe.ca>
 <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>
 <20240206163657.GG31743@ziepe.ca>
 <873201d4-57d1-e856-87c8-08e2ca71f0a2@amd.com>
 <20240206175824.GI31743@ziepe.ca>
 <0d626c74-aba5-bbb1-5fb4-b9be5577d71f@amd.com>
 <04df4081-b99d-4f87-9d20-bf97f7619040@linux.intel.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <04df4081-b99d-4f87-9d20-bf97f7619040@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH0PR12MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a518567-b88b-4911-584b-08dc2806b5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bobMTgvI3gJt+4KQr92cDfWJlMeHdXQp0YdGxn72FBPgLmNtHaVid7v1JRJiO7tZBpkEGx6ZrEp0SRAtx0YBTu+OzTxKLYSCe+RgfGZTXXlSG60FL0JZ9P1G2769izOIAICs8NBhX82wpbBQ3FglSP46DLrKL27DX/nvLX7ZWgpjErqZ9vX+4XVxVkBXLzK16T3AkhgxKX/jHAVohnLY2YsHs9CdbGoO3esRT+VOu+i4mX7K93W9O2Zc8076+OEkwtr/kL43wsJqTwC6w5dV6iUregqTFAoWCSEXOr4VrLI/n6YXJCdTs2SlvUM4/hbE74PXm8lannyyw8gW5IP2SaVixGXN2Ibr69x+fPr9Yz3V8uDcxyEI2Sz2VPg++0v+IHnpU5c8XZt+PMgmOfZe56n2uom0x1rkQ3rIQqdborAQ3EQnzIWVqpqiHOYz8Gt1PZADgfeiQfe6CtsiQh5q63dkPK4fnmgsx/QtTP9yudUjsik1MZebmjO/GpQJDhnvz50AvneDS53UsT69WdhtWvFB7oG8fCfvalTMlQJLBzn81N+WqvGN/f6m4n3ojPbDTCICBuLgc1YgtIjT9KjAaAAZznBifHRRqSmvPNmXkv5EUUiQJUYnTm6L+n3kZDM/o0w71IOlHRKmZcGZnAASkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6666004)(26005)(316002)(53546011)(66476007)(66946007)(2616005)(6506007)(6512007)(83380400001)(31686004)(38100700002)(110136005)(8676002)(66556008)(8936002)(4326008)(44832011)(36756003)(5660300002)(4744005)(2906002)(478600001)(6486002)(966005)(31696002)(86362001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVJTZlFhY25iN0x0T083WEJNelJlMFQxMVVpdThPek4xTmUwYm5mNTVQeEhx?=
 =?utf-8?B?d1Avc2xia0wzSDB3akg5MS9vaDZPckRLK1pTVHE4a2dKUndiWTQxNktnNUxK?=
 =?utf-8?B?bG50QzBML1F6azdoaVAzOFBJdVlQQzh0VW1NdmlvTkxGZnpjSkRPSXU3Mlho?=
 =?utf-8?B?T2VNdi9KdXNHSmFOUWx1T2N3SlhnVXpmWjBFTkZueEV5Z0dZK3V6VjZWdkhs?=
 =?utf-8?B?bWxoNm5LV203YTZEWDBza090QkhzSmNvYXVDdHdsemovQ2J3aFFHSHA1ZjZr?=
 =?utf-8?B?bGJISFBQNHJoaWpvS0x1MDU3b3UvcDdHYXlGaUFhZHJhNGJGRjJhYjVlM1dt?=
 =?utf-8?B?NjQzMnljbUlxRFE1L2RTVk5ERlJ2OXR4QURXNmdUd1VPNXZFd2hlUEZyRGU1?=
 =?utf-8?B?am4wN3JYbkN5UTkxbVVFYm5UMlVtQjExeTZBaWNEaENFZGZ5eWtveWdPeWxr?=
 =?utf-8?B?a25XL1VITytoVTIvVlRQa1cyZjFTWXdId2F2WUVrSjdXYytTMDlJd1hHaEFH?=
 =?utf-8?B?Q2swRzdSMmpDMS8wMW8xZlZoSFRIMmg5QjRFYWk2Zm9PVUxzL3FyMXQyeDNR?=
 =?utf-8?B?OGwzN2htU0ZkMWZ2UlY4S2NHbGtGV0tOeDdGOTdva1gvU3l1N3dDcmMzWUVX?=
 =?utf-8?B?WS84eFcyV3dyNWpHSFNCaDcyK3FCWXRuZUFlRklsRjE4SlhIQXJSTjVMeXNk?=
 =?utf-8?B?b1BsT2Y3OUEyRnZPNGVDbjBIOWdkZVhlNVJnRVByejJtbG1iYzdFblNEZUJM?=
 =?utf-8?B?NGdvdUJXVEV5akc4bFB3b0tHVng1MDM2Mm5ibkZYNjdRNGhrQ1JUWmEwdHFm?=
 =?utf-8?B?SlR5TnFTYTVDZTZkQjc0S2k3MWhlb2FoRWVoeVl2TDEzUFh2Wkg2TU92a3Bw?=
 =?utf-8?B?WGNvZGhNMUlXUTFkc0kxQkdVbXI2QVJKT0NvaStEOVdxcm5ucTZzV3hMaWo0?=
 =?utf-8?B?STJWTlUxMWd6UzdCVWF0N0dTd0dBSWpYQlBvTFZTNWZRM0ptbzZTMEpMS00y?=
 =?utf-8?B?NlpxaDF4R05rYXVuQU5HcVFiUTdOTDFiRkZPSFJaSVY1NjRVY29RdzNEczQx?=
 =?utf-8?B?RDM3cC9MdTVVYnhmOHVIWEVPSkpadXlRdlg0Z0kzZE8xKzM5UUxQRHFFS3U1?=
 =?utf-8?B?OGx4eHZiU3B5a29INXJ6NmhUVjd2dFBHU1BrYnNYTEN6Uzh1OUdNWFZMNzBD?=
 =?utf-8?B?T0JReEdSUVM2REMxTnpacjV1UkkwOTNkSG1KSjhIRytobjFFSE5SbU1xYWZr?=
 =?utf-8?B?RVNQVmxGUzZ2ZU9wN2F1WFdCclV2d2Z5OXNvb0dNRmFEUzR3dm1DTCs4TmJI?=
 =?utf-8?B?T3ZGQVhpK3UrVGJPUHVxSzVCaUp6VGpESnpha2t6WGJUd1YxdDZTeTluSFJL?=
 =?utf-8?B?K2k0V09WV1NXNkNhYVdRQ2VpblVYLy9LbUxHelpyTXdudU1sOTdQM2VuNFRQ?=
 =?utf-8?B?UzN0dWxwU0VabC9yY2xpT24yV0MyNXkxWmdqVVJMbDRuNHNiaHFsb3MzQjBq?=
 =?utf-8?B?QkFCZHRUczY4bnJtenBXaTRoYURFVy9DaDJLRzJQMFVNVElXMmRxMDZjWkpB?=
 =?utf-8?B?cnZHNkM0NDBKdHZtemtpYkJoRDRlSi9UWHJtdGZXOHFXVko5ZWJ3cWlRUEJW?=
 =?utf-8?B?OHltWE84QVQ2TzB1eWh3UHMyaFk4RU0rSkRFR1FkeFYxUjR4cXRIVnh0cEow?=
 =?utf-8?B?REFRNHI3NEdObzJTVkdnM2xBeklweWl0WjN3dndwSm5Za1hFOWRnTDFjK011?=
 =?utf-8?B?ZVJSYlBNakNVRHBRZ1BYaFMydTVTWjFxcTFpR05hSzhoSjNHM0g2cERZUzgw?=
 =?utf-8?B?RW8rWk54VXZUWW5Ra0J4ckZ2dXdhaGszbFNWYnA4aTV3V1IyR2dldHZrYjNu?=
 =?utf-8?B?ejFFajExemxIMUNTTjVDKzR1dk9HRGFtd2NpZlFDcmtkNFlsMnRTdGhJcDB2?=
 =?utf-8?B?TTQyRm56MlpqMUlJN0xMUjhIeEc4YXUxQTZQN1ZmNlB4VlczWUR1K0Q1OVAy?=
 =?utf-8?B?Z24xZ29kaElkcy9XZm5aWkp0QVBNOHViSG1Ha0d6NUIzeWsrZ3c5TGFtdGxk?=
 =?utf-8?B?cndKdlhCc1pFVXJXNTBJOWhsRTZRZUxIQ05xR1p5Q3l3UDNqT05ka3UzeG5s?=
 =?utf-8?Q?6pHfrJ8DjeTjJK8uIu69Cx+GK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a518567-b88b-4911-584b-08dc2806b5dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 18:00:47.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gfpWR5XVSK5PwsZgYq6VwyBRlQaezbQy6ci5NKWagRf11cZjQB8BKF80Ohyd81qnw3i7Agg4DbSGeiYj6Auog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5123

Baolu,

On 2/7/2024 6:06 PM, Baolu Lu wrote:
> On 2024/2/7 16:58, Vasant Hegde wrote:
>>> There is a clear protocol and ordering requirement for the PRI
>>> enablement. Lu described it in a comment, make sure you follow it.
>> Where? in intel driver? (they seems to be using feature_enable() path)
>>
>> I did look into latest "iommu: Prepare to deliver page faults to user space"
>> series. I don't see anything specific to PRI enablement flow.
> 
> The latest version is here.
> 
> https://lore.kernel.org/linux-iommu/20240207013325.95182-14-baolu.lu@linux.intel.com/
> 

Thanks!

-Vasant
