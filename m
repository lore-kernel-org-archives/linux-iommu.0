Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C05749C
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233849; cv=fail; b=flYzR+VnBOIn3kxUcGI4QnKtEHWnyNV8D+Yz4YcW2bgQDTGmme+ck6h3lNVtzkoRI3ye6o9NfoYDAStuVP0r3Vclt/v6KA4I2SDrA84isOsqfnJEl+EcNhBzSm37RgTz6nyaM5nzecWA0YMYvfv336+fmjl1AkhvnY3jMp1l7uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233849; c=relaxed/simple;
	bh=k87Wz9qvFnx2rfKeWk3XfbxzLoKgoA67U8o8Gup85as=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AvKkDNnW7cVEa6ERmPIUG/ShZ3Wbhlp22d3jFCtXsCRQcpt/SDndB39Q/vj5ZpppP6HYIMT/8+dyA0tI+JWIlVVmg00KbCnbtpRM3ybbIAlGOpfmWMdpyNqLOQjhveRsZ5z5pRtKK4Ro+1adDWi8XHvgWmstpNXqiwJ6eHyYPdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Ao9VJZO; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Ao9VJZO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZn4JSv3XCFJ2hA04Hrmiat34wq0T5MU/uHnj31UQprmKT8zThVkJXnAwAhSrDKcr8VyinQ6/Z5mgd7lglnooCqiJ9UhuV7bgxlWLL0LkjVwgjZRN0TGCQyjfhr0SDZCuVsJpxFgV/bVCup+Eza2qgGza3F0F//HcMvDpJz1cUUoCzmmLqtZR1QjdczqCsogLGDcMLbVdWMhKB7k0uVLYBzYYm6plJTCYwFkFEkPLR77gwuPnCIARJjG9QeOz1uNLsmMLu+8dEgQjPVIn1cn+hzPHQWsGwoBvr5ZgWXpPsh9ZwjicYM9A8fCyL3FrYa5hqnsvbVIO38A4ufNvfHfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0FbgFXPRmFSQ4hkQQTFIs58eRYJXfLzpGi6srWpO+4=;
 b=hYr7HLoramV1jhYuKk6UMxLR4otIIWW5z+6YPXVLBVJflsyDitZ9taSrY4WQT3B+g54w+Uax3oucISu/Dzl7CbV6qivbFNRJ9Naq2+61NnVCMVzgQGQ7G8oy2VTM2v4z06xKBWrPzR7ROFr345g0N+5xOtyGA4sGlPHVJDjhloPe50ygVwBFr8gLveL+FXdrvB8YdF5jPnchtJ5iGc1aO16l2B8lzoIVkdMc83iej48mYpmIcRoWvY8o3EQHJH97B1Rw7W+Wti9lt+1ZT96kxe87z0e4Uvbpky4FrqzhKkFlFAdia9tMWvYiskz9CDSLgDOk0X0SCtzm+Kq/fa/P+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0FbgFXPRmFSQ4hkQQTFIs58eRYJXfLzpGi6srWpO+4=;
 b=2Ao9VJZORYPVJMKyG+2nxubdVUsyddkRFTwh7/N1HjlgEWwBK47/tXkgKrXfnE+rQ9zVKoBiqFz+XLh3XdE5h9j3VM5Hco7UMH4x75D63Bcbt4MlkvkzXVfqIvXSU6saxFmHXkkqruNqOFwVdldQ7c4KpbJqD2YX5CXwIVK572k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 18:44:02 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 18:44:02 +0000
Message-ID: <a4260493-9f75-4446-ad01-61556ed8e034@amd.com>
Date: Tue, 26 Aug 2025 13:43:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add support for hw_info for iommu capability
 query
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, kevin.tian@intel.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com
References: <20250820042533.5962-1-suravee.suthikulpanit@amd.com>
 <20250825134420.GB1970008@nvidia.com>
 <85c544d7-b274-4696-9fc0-829033eaccaa@amd.com>
 <20250826175813.GH2130239@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250826175813.GH2130239@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::29) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac8eb98-ffb0-485a-f35c-08dde4d08697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFA1M0FXWjY3MHJsK3F1NUNQV0U5ZHdHMmRxRldwVHJpZy9CRFJ4ZWY1ZGpp?=
 =?utf-8?B?SVl6NUpIYjRDRFVOK3Q2RFMyUWFDUjZrdENHUUF0bEU3OTlLOFZRb1pOai9n?=
 =?utf-8?B?R1BzTlZXWndTS0psSm95YzFNMEp5UWVpWWcxVncvZXFCMWdLS0RoWlI4RU5o?=
 =?utf-8?B?NzRaS3dOSTQzbTdQVmFsZkpjT3daOUJsclJUUWI0TjU4anJuaXV2Rkt5WVZu?=
 =?utf-8?B?OC92Q2tLazRVNUFod2xMaFZHSWkybkt1anAvc3BJa0JzbWMraFJwSFNyZE5K?=
 =?utf-8?B?V1lCZ1lTYnN5dTV0ZGEwL2FVRzBPNUlRV01OeFk3MmxsWFR0YUdtT2U1SW9I?=
 =?utf-8?B?UVkwM041RHdPVmhVNExyS1MraG13ZFQxWTdSZ3c3dHhOa2M2MjhadXlIWWpL?=
 =?utf-8?B?cFU0WVdxaEg1RUlHRkpadHF0QnEvUEpQT1JzdHAyYm9sN3VpREwzZHE1L3A5?=
 =?utf-8?B?czRJZ3A0OTNMZUFZU2txOHRCWCtXR09odlliR1dsRHh1Mm9kcjJMcFZpUklD?=
 =?utf-8?B?TE8rWmM3a3RYcUVGcWU2alZZU0wwcWtYZUZTSDBGVUdHVUFPa1gvQ1VCci9m?=
 =?utf-8?B?U1IwdCszSUExMTNWNEJNa3ViVFAxd1ZqRi90V3p5RFhYNmNzQk53OGRFdXN3?=
 =?utf-8?B?K01QT0I5eXdXN0pieUt4WmF0eU5hTG1hMWpWVUYvK0lWWGFYeFJyMEw0dGsz?=
 =?utf-8?B?OVdybTdpS3N3eUF0cEx6ZlY5QStmR2xScmJQZ1JJL0lKQktjOHcrRWJUcHpz?=
 =?utf-8?B?SzFJTStQQ3IvUWtuYzhHZnRjL25uRWdxUTNHWFZ3cmVrR2M0NXhjc0ZOdits?=
 =?utf-8?B?QUdib3VSczlSTjVQWStnYzhoeXlwUmo3dnJzTU92ZGNTNVEyUUtvcHBVRDV6?=
 =?utf-8?B?cjVoZlRHQ0RqRCtUN00rNWRSWmdIV1l6eG93Z0c1Y05ZN09rbDVSN3h3VmN0?=
 =?utf-8?B?ZjB5WGtkOTRGMlRHSzdnd2xlbStZTWt0QjBEZWpwa29YMVREN1M1aGJtdi9P?=
 =?utf-8?B?SnpZT0doeXFNVUh3OVdsSDRPaDRrY3UwbTZhRUEyY2FSUkYyVUlsc3BEczlS?=
 =?utf-8?B?OW01Ny9Ic1hGQ2JLNmpoMTNaQVpEVlhRQnlxSGhuUVlGYXpIYWZnZWp2RmVn?=
 =?utf-8?B?Nm9BVG9CZHp1Z3RtYnZGL3YzTWdsMm83d0Q2SncvcC9zaTJvZHJwT2JxZ2Ez?=
 =?utf-8?B?UEpRK1R3Y1h4V0piSGJqTVhVM1I5R0ZPWi94UkpMUHBEZ3o5elBrQmZGQVZ6?=
 =?utf-8?B?Yi9XaVRZUHhWaktEanFBSlhnbFluQ1VGM0p3VUJkcUNJKzVnUXRiRzdoNkZk?=
 =?utf-8?B?ZlI5eGE1TE5tOUl3RkdVV2RVN09jNHIzOFJRa3UySmhrdnRGOG9MaS9ib24w?=
 =?utf-8?B?dW5kbldXUGdMWU1hM2I5RXZXQ1FKeHo1VFl2Q2U4c2k4Mk1IaVQ1U1RDeFhj?=
 =?utf-8?B?bTdYejNNSjJSYW1TSlRKSzJNV0RqNE9JN1U2THF2WDdqRVVndXF4ZlpQdk9w?=
 =?utf-8?B?S0xVVjdkQjBKOHNrMmxweGpsSGsrUlBxOEViaHV4ekI4RTJ3MHFSMVNOclR0?=
 =?utf-8?B?RGJEWWJRdDIwRU5TSWJ4MTdtcU1LQXpJaUgzWXRNRXpwVzB2dXdYUTFldGZK?=
 =?utf-8?B?d1JFdS85YTRtaHhzaVhiSEFXcUN5ZXMyTG1pMTI4amh6NXFERkpEeVhwczdU?=
 =?utf-8?B?ODIxVVUvd1FxdFQ1Sk5Nd09SZU1ad04zYytUZ2dOOUtoNm5uS0l5amhHL01w?=
 =?utf-8?B?WlBJb1JuL3hHNU8zNUhyZ1NYTzhzOURxYTNIMGlHRmxTVHdVQTU4TzJ4YUd5?=
 =?utf-8?B?VDl2RitXN3VLS001b3oxWng4ckUxMWFWOC85MFIvc1ZNZHZyWFYvMTlCMnJ3?=
 =?utf-8?B?dzBtcmsyTWREbUxnYTVRTlRKd1gvcmc4NlUxUWZCaWN0b0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzdGOFl6N0IxTStOd1lRbzJNZmZpeEU5VlZWWjNwRlVOUUdpcUlGaWFPWjkz?=
 =?utf-8?B?TVJ4MVdoUCtJM1huTnc5eENqZHZXSG9ucEtNVGpYTU5xdUhGOUJiT0hZNlE1?=
 =?utf-8?B?SDZSbEFuMU9sSDhMODMxWlhsdEd3b1RVRE4xeUpleXdyZFVSV01WYWhzYWZB?=
 =?utf-8?B?ZDk4UFFMWXB5WHE3WFl4MUJGbStORUxQRm41WFN4N3NoK0dVdE1BU0Vwbk54?=
 =?utf-8?B?QVZmTlVTOTR4RVdWdEJQRGdBanNuOEpXVHh0NEhqVlFDNk8wSTNUOWNJem93?=
 =?utf-8?B?RHpYalN0bUxyK09TUEFHeDRWVXMvaWhXWndQS1JndVY3Uks1MVFQYnJ3aTc3?=
 =?utf-8?B?UmF4WkVZdUNIaHVGR0locFdyUDZXRHFydGcvU1VmVkVGZEVLa0doOVlZSHc4?=
 =?utf-8?B?TmNSdEVZaXFxeDFJaEVFU3pmazVIaVQzeHExZ3hNTEhPTXVBN0hFYVJ5WTVK?=
 =?utf-8?B?WmNOSjVweTFzSGhISXVtMEJvdHNyTWJ6MjJ6cTI2SWV5WG16MTc5WitVU0lk?=
 =?utf-8?B?eDJZMytkN3VTd2NpejBja0VlM0lYZEYrSXIvSE5JalovME43SDVScDU0czJy?=
 =?utf-8?B?S05DWnVzOGdOVXV2SlhpdC85dStBcHp5NmkrVTN4cmhPNWwyVW9xZXpQcSts?=
 =?utf-8?B?a09jamNobWpqdWhKVmZDSVlBWjBSZ2FpcU93K3JHSkE1Q3hyb2cybzlJSDhw?=
 =?utf-8?B?SmJIUEFXWGpjRDQ1azBMalB4OTlEb2ozYTUzZCtnTWJZdHBqZlc2T2Iwckxm?=
 =?utf-8?B?NFdrLzlhcHlqUDdRdVR6V2NCemxWK0hOVjNrMGR5Qk1pY3ZJVHl0akMwbEFL?=
 =?utf-8?B?UWZFMTFNU3RhSXQ1MTJmQkIrOTNWUndzdlVnMGt6QUxXYnJQSjB6Njd6THBI?=
 =?utf-8?B?K2hIejdjL01McVdrRElRWlUrSmw2bFdxeEczS2xRY0hiL0JBUzE5RVMvQ3Za?=
 =?utf-8?B?emFBTVQ1WHRkVDZZOE52WXVHc2xBZFEvWWZQMTRvTkVOZGJ6UVorbzNNb3FK?=
 =?utf-8?B?Lzl0WkMwVW1ETVZBOEVTbjNwK3R1N3JoTkhWcE9HaHp1V2Z4VldBR1QrRFBt?=
 =?utf-8?B?YnVFODF6dzE5MFNkMEp6dVk5UzNQdkRmM2NrazJjY0lkaXJrV1NYTUE5WjNK?=
 =?utf-8?B?YUptWHExMmpsUVJSaW1xay9WNjZTcWtnMnBQTUhGM0RyOGszMWZRTGhkQ2tq?=
 =?utf-8?B?VmdBZjJ2bmgrQ1Q4RTF6OVZQck1XMkRkNXBWNFdPMEZjYy9xaTJlSnIwcjYv?=
 =?utf-8?B?SEV3QlN1YmZKWW5EZjNoYzh5eFJDTW5xQklJOXJpdnhNaGRDdkpBTEdGdith?=
 =?utf-8?B?V1NsQXBsazluSndDMG1zZVZUSmFWL1krbW9VV3JOZVJWQS9md0poWFc1cWxL?=
 =?utf-8?B?b1NZNTgzcGVwTDhTS3BEOG9tN3hrQ2ExaVlncE5nMDJPRStwU0dLdEUycy9F?=
 =?utf-8?B?Ylk4MkdDUXZKRkZJekNMRCtwZmZPTlk5Vm5XWjJNOWxHeHdLMXdna1pxMEVL?=
 =?utf-8?B?NUFTTVVpV1N4Slk1djU3MncwT0ZZdUFpaDI4YUl3Zlk0anBkQWhjQ2wybE1x?=
 =?utf-8?B?aHVZNjM2ZXJvSnVFWjZtNTFCWmNmZ01GcDZyOU8rUExSUnpOQjAySzB2MEVs?=
 =?utf-8?B?M0dzS1o3aHljOVZPb3hKNWpnUHFBZnI2OWEyNXo1cURhZVF2bnNOSTNGSlpD?=
 =?utf-8?B?WEFvdEU5ZkVkdVhOSk5yWi9YVHRIVjVmRjJRRjQ3Wk5OZWtCYVY1UldWK2t0?=
 =?utf-8?B?cFdhQnVteEVublpKOW54V2ZuM2hIT0d5R3FLZVorcmhIOEcxNTZ6N1N1aDFM?=
 =?utf-8?B?MDZXM3krSFFOL1JpZGxDbHNIMlVSOE9VRzNnKzhjeXVad0V5bU9KZzFUSWtB?=
 =?utf-8?B?RWxvb3M2eTROSUhwVFVqbjlydzM5YzhUOG5uc0xLa0ttVlhWUUFCQjJwSFg1?=
 =?utf-8?B?Vno4MjBWK3QzQXYwRER2bXVPUDFreFJicXZweGJ5QkUrSGxheVRxckZ2SG84?=
 =?utf-8?B?Ry8wZUhJWmh3UXlqTjFvek9xVjRBV1JkNzlsUjdkMXIzZVUvVU9PNWdsSjZx?=
 =?utf-8?B?cGIxQW9UZlBLWXp0akVNMXhpT2ZObDNJR29nV3lLZWx5R3oyeS9vTlV0Y2xV?=
 =?utf-8?Q?1B6ahLX8hf6+URav6uLxBA4FF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac8eb98-ffb0-485a-f35c-08dde4d08697
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 18:44:02.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCcdGeGhJmHUw4gXZmJxH7zZxDQ1DjQs+dfkv5+ckuLfH9YrAp4utxIHSgHOtX1r4LjdPoNlNXZhGHMSPKBhCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209



On 8/26/2025 12:58 PM, Jason Gunthorpe wrote:
> On Tue, Aug 26, 2025 at 12:36:23PM -0500, Suthikulpanit, Suravee wrote:
>>> I think you should probably just pass the raw HW value through and
>>> require the VMM to figure out what bits it needs based on feature
>>> flags elsewhere.
>>
>> The problem is some of the features are virtualized by hardware, which needs
>> enabling from the Linux AMD IOMMU driver. We cannot just provide all flags
>> since VMM would not know if the kernel has the support enabled.
> 
> The VMM is not supposed to forward these flags as-is! It is sort of
> some kind of maximum what the underlying HW can support.
> 
> If you forward as-is then the VMM will forward broken flags it doesn't
> support when the kernel gets updated, that isn't OK.

I got this part. That's why we mask out unsupported feature flags before 
returning the EFR/EFR2 to the VMM.

> Each and every feature the VMM wants to show in the EFR has to figured
> out on its own if it can be supported based on other kernel features.
> 
> The utility of the get_info return is for HW features that don't
> require any special kernel enablement.

Not sure if I got this part. Are you referring to the struct 
vfio_iommu_type1_info and vfio_iommu_type1_get_info()?

Suravee
