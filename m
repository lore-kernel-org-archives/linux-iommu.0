Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBB4AED7
	for <iommu@lists.linux.dev>; Fri, 31 May 2024 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135889; cv=fail; b=gWCYaMi0DDmSkbEWy4W/WOv/OhRA1IdmuokJOqR1QR21eOg7Z3xN1bWTsyVHz6OtuhS+gP0pd8HSHH9g+olbKD666AvU2vjtmHp/wFTTM8VDysMCtedXu+QGKewLJqqSRTqUaU30oitwUFfAbWBI1HMNvECpWRgswpRGztkXNXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135889; c=relaxed/simple;
	bh=7YfrghfjYMD0RRWQp8N9Vxnu2g4khDguOTFXyJ77PuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MVMWEEnePHr8CjL8V9FPp3yw3yMF0p+bVUUHiZ+KpzE1XEVAu6Ofo2F0/36H5noobHSwOSZ+G7MOopdDyqC2OOJIBEm5o3G+iDimSqKQaIus8mio0ptYG78EhRaj8FZUb32Pf3gn+9jG/kR2scIhYzZ1o09EDIvgoyknpfXOPXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ybTVKKnd; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ybTVKKnd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS1st9Tp//s2m2nyjiC0XXUCsMLqn60pZIqV4JwuxJap32tJZure6NFDBO+86VUUo3JQ1/KeL52Ac9PU5wxyesuJtcqq6eVZiazh9zq2xm1heSTKtUeY+D70gv44BBj8lVTPD+wMcyJpwkAQfL8YHWaTX+syNtXt67LsrAexxOxoofCvEWitDtieDuF9vIk+s83okAtI4VPggaOY4JEuiFEoDAchfPoCFVxCbeS4ip7t1c0Fa6DinE+I6/b/0nUj1mNWi4unEz2qnkR5dNsMBMmDJRuUiggIG7zZROX6xbQaYF3GLhO0wpK17/INB74VWJgHUmcUhAJdfZtIPGUkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxNFAhCKXwFcBQ1aGNZOeSh7HcWHeqj33RAfUljl5dQ=;
 b=jwR8Ltt4IdOwkxk9KZHlpC06nMuPC2fqHkSNMWQKUVyiCMsQuFdSC3/9wa6Rwfrqogl7moUZWqgPUVwul1ddigMX33QrzZcVY5RBFlLvT0GkCvKG8PDLSTP5YcZGa+EBQQrVZxItxIQdcxmiiQ7cgC8CcsiDTR49Phoe6qwWQlVaiqsU3eWDIM6kBjESst7Xqe0/dkOB/QV+wjRy0qwk3mFhzS3H874F2iRtPrqlyi+xxW1DawNjg2l/HMGAQu6GMsVDdGTeFxvTBJjZkuVWX+krx/v8KgwY8Qdu8zAdqmHNN9wvgLNUtbYgnLl/+6246S3qNRbXADeZyVXiWWScwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxNFAhCKXwFcBQ1aGNZOeSh7HcWHeqj33RAfUljl5dQ=;
 b=ybTVKKndlHqsdL+TVlHaRfON0pptydESBh1IJOQhb6s8JNHQpNRxuQ6eNObRr1mac2SzwPKbDJDdDK1rp1VLwDH3qKNxHXjBWijPwJ8qesd0bdL9t/F9OsL+U3zyZLBgBh9cDs7FER0NkLeeVxIID0r9C8L1X91P+IBzP34j0Qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Fri, 31 May 2024 06:11:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:11:25 +0000
Message-ID: <77c91b46-cf2f-4e11-9fdb-c867c87530f4@amd.com>
Date: Fri, 31 May 2024 11:41:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix panic accessing amd_iommu_enable_faulting
To: Dimitri Sivanich <sivanich@hpe.com>, Yi Zhang <yi.zhang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Wang <00107082@163.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
 Russ Anderson <russ.anderson@hpe.com>
References: <ZljHE/R4KLzGU6vx@hpe.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZljHE/R4KLzGU6vx@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: e9659f93-1205-45f1-fe83-08dc8138803e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFkvdUc2N2h2UjZSS1Z5N3ArK0lXcmg1eVA5dkdQUTBRUm84R3AzS1JoTjY2?=
 =?utf-8?B?YmlLNENydFdhRVRxVzNQYnVJSDBPSkxKcjNuWnFNU0w2SXdDbnRRUCtEOStM?=
 =?utf-8?B?VmdGY1VHYzdra0E0T0phbEFEdVI3Zm1Xa0ZUd2hpeW1YdlpybEJPR1NHZ3lY?=
 =?utf-8?B?b0FNQno4clh0ZnFaUVV1cHpGQmhodTNYMVBvbXdvWXFhOSt0Z295VlYrREx6?=
 =?utf-8?B?cmdpc3lFUDhlZTZjSS9Da0dJK0dXaHhCOEtabFpaU0lnRlNMQVlhN1E2eG16?=
 =?utf-8?B?R25EMjdKMDhSazM5eWR4eTJwQzVkODIzZzJ1dS83M1FCbTQ5RjI0VzNVT0gv?=
 =?utf-8?B?em92dUs5MmFyUkY2U0xxbmNXMjZLYzhibmZvR2Z4aVM1THhPcHhsZjFFdktS?=
 =?utf-8?B?UEU3Qnh0Q2dPTExyUEQrUnMrdEVIZlFFdVp3dktEWEhxbDR1K2tPek51NUdt?=
 =?utf-8?B?RWNsTWFwYlJTSVlLMVdweTRRT3JHVHdDRGl2UmYxbk1sd1E5Tk01N0t0OHgz?=
 =?utf-8?B?OVpGUG0zejZJK3ZEbWMzZmhjam5MV3k5ZVdvaitJd3RrNnJZMmVVUGhIQzRx?=
 =?utf-8?B?UlFYWW5KTzNYdEZkQ0Zmb0tiaWtGdkJVZUY0a3ArRHgzV2VTT2l1THhKdkZD?=
 =?utf-8?B?aUMybW5PcVdXZFRsSmQ3UU9MQkY5MmhjeHNCaG8xQ0xmaEp5R3B4NFRZQnMr?=
 =?utf-8?B?aHdUeDBpQmR1Rk4xbmpHQ0lXZ1picVlQbTJQZXNFR2l4d3R6TncxcE80TUVR?=
 =?utf-8?B?ZVdXMnR1ckJWVFRhWEdOMXMxSzhPK2ROckIyS1V5ZVhEN1EzWmtDemlySzRq?=
 =?utf-8?B?a1B5STVuRDNuUHlRTkpQcmxWZ3BWK2tYRXJwYzJjM2VoOEg5bS9CWWYzSHhO?=
 =?utf-8?B?a3ZXV3pMR05lR1c1eE9uZGJPcXRpZDNPd3lPWTE5d3ZrOFhCNS9uWlJBWGdY?=
 =?utf-8?B?NkZIY3lvbDI2OVJIcDd1U0tCb3IzMHhiWVRLbG04a0R3YUxsVWtTWEx5T2dH?=
 =?utf-8?B?U1pobGEwZDNlWUpGKzFrSVpTSzk1U3J2bUk3aGVPR29wY0VtRCs4RkVaK2hQ?=
 =?utf-8?B?QUlBQTdpZnJ2WXZjN2hlNTh6R2VZMDJhQjA5dDVtMGo0Y3dBeWwvYjZpc1Nq?=
 =?utf-8?B?SlZpNTVVcHQrcXQ1b0ovTVMyR3NkeUtkZ2xsaVk0V0xDV2pLZmxVaTlxYU5C?=
 =?utf-8?B?QkhsSlBMRi9oMkxBVllsZ1AzbUR3dDFuWUJncUVmUkpueWsrY3NuSWxicXVt?=
 =?utf-8?B?WFlXNTRuQnlMdm9kYzBqa0R1RnRUaUIxL0VjZXdCZzV5RUZjcHNOcURNempS?=
 =?utf-8?B?emlDem5TbmRBeXIyZFNxQmRFNHZ0VXkxZk1KbDBjb0Yvc1ZkeUdZSm5lMXMy?=
 =?utf-8?B?b1hFOEtkNDBLV1ZJbXVEdklvN2YyVmJEclpZYWVsNkxLbzc4UjhvZXdoWmxP?=
 =?utf-8?B?cFFhaElRMFZoRitveTB6Ni9ZamRaRWxlWHBtbFpWQXUvbW5qY3F6ODZYZTNi?=
 =?utf-8?B?VkpxdlZsMExGcVdHKzVQTjhIUmQ4bmEwNkxPUXVndGtZUG9yZHliQjRSajMz?=
 =?utf-8?B?NVZpbGRwK3ZYVmtmalRNSWxXQWtYVE8vOWNiV2ZGN0FoeFdBMktGQ2Y1V3Fl?=
 =?utf-8?B?N0ZUYW9uVSs1WURhdU9uU0RpS1c1TCtMUHZqdmRNTEZhWml4VVN2eEt1YlZU?=
 =?utf-8?B?SmZlVWNPNHRFZ0w2aFFWdVltSEd2SDRNbTNCd0xWRmpIVU9HblBkTW9iZVRD?=
 =?utf-8?Q?1wi/BoLRpAVk7zkZiVWaq678R+EUi7St7EnsTK9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU55MVFCenYrbU9GelVwaUFRUWNjVHZ2eFRiTWp0aVpMYnorM1NyVzRGeFRF?=
 =?utf-8?B?QXlHTFhBRkY2RUhxcnQrbVNiSzlub1VvYnFlYVVXZHI0dTZiVW5Sa2cxOFBa?=
 =?utf-8?B?aG5EWUtxVFBabWE4OEMzbWpMclN6eDBqQmhOdmU5MjNCSmppTXVNK1N2dWwv?=
 =?utf-8?B?TEI5YnlBQU14VUwwc2VyK2FvZkNlNG9PRTdSTWlXZ2FXa1NPU3ZxdDUyb0xD?=
 =?utf-8?B?Sm8raGE5Q3VYTU1Oa3VuSWN4RkY0Qkx3eXI2R0loL0h4Szh4Y0VDZDEyMHFD?=
 =?utf-8?B?Zkx0VXVQSTIyRVRCMDRMSGRjNVJBa3U4OUFLV1I5cjFva29XNWVHRlhDZ3Nm?=
 =?utf-8?B?enlvYVFDTzk3RGlaeWpNK1RXZUhuYWR6RHcxczFnVEtYSzdVbnVuSFNDSFlh?=
 =?utf-8?B?RnBHaE5vLzBCaTVtd0liYkEvVDZUaUlRcXVMK2RTMVRIWjBVZjBJUXM3SUY0?=
 =?utf-8?B?RC9rVFdab1FxVEtEMGdyTC92dG41UGVZc1Fta083dkQxSU41K3FDRzdTK2FD?=
 =?utf-8?B?OVE0Lzkva2Q1a044cEhBUTVoU3ZPZlFtdTUrSnhjM3haY09VVEtHcGZRaEt5?=
 =?utf-8?B?UThsK1krOHl1UGxwV3Q3bXV5S2NvWDgwMDVXL3gvVnB5WG9OZmowOGN2R1pm?=
 =?utf-8?B?K1BEWFNYakFMRkRaWWNXeFZaM09YUm1ZdjZoM3FQaUM2dzgyeG5rMStOU1F2?=
 =?utf-8?B?UEpPZ0NPRzJjTnc4QWtoWlovWlBXWE40SmplU29Obk9sczI1QndZU0JBSmNy?=
 =?utf-8?B?ZCtLZjUveHJoSmZLS1NGZUN1ckdsd3R0NU84b3FROC9Ea09UdjhPbkRsVngv?=
 =?utf-8?B?aG9IN1FrbVpkV0lIRTZvM3RQSG94L2x3S0pNMUl6R3dmdDFOOHZLOEhFczIw?=
 =?utf-8?B?MnFyRHlTZDRRaVV4ZmhNNyszekZyTW9Kc3FRYmpYbDltdEtldWlJaVVVK2pa?=
 =?utf-8?B?Sm11Tmxlam41UTJnYlhGR2lpYitmb1ZPL0V0T2NwTFlSekVZaEdwUitiZ3lY?=
 =?utf-8?B?UXU0TjU4YmlPdklnM245TnFMOXlNWlc1ZmFONHRSQVpjQlJiRitpT2VsKzdB?=
 =?utf-8?B?eE80dHEyVVd6RDRDNW03cSt3MWJhZkhiODIzMFFmRHBGcjR3a2E1Qkc5czZm?=
 =?utf-8?B?ZnAyaFJBbWhoUDFKUktBRmxSRUE2OXpYY3lWdEwvcWErUG5yellCUnZiWjBn?=
 =?utf-8?B?VzdKbVpHN1JVcEZISmFXdWErT2JJYm9XSXZMc21RS2Uvc1Y3ais5ZFZwTmlk?=
 =?utf-8?B?SVhyU0t5YjZCM3BZaGJTNWF6RVlLSTdKb1lkSTMyYTdPMVJEU2loTmFrWll2?=
 =?utf-8?B?YkR0a0hYdVFaaE9iUVZzUzJxNUFXd1ZqN0IvbCtiRlRzUG04amtmS0hGTjZI?=
 =?utf-8?B?cDhhME5BRFdmZzh3YWg2c2tFVEhsaWFhZzFxdVNJWWRPTGs3SThLNXRJdzZp?=
 =?utf-8?B?Wk91b2dnUmhJTmNlVDZlQ0xUaW1hbFZpTXp2WFRJTTBYcFZiUmJ0RzljbytQ?=
 =?utf-8?B?VDB2MEkvS2hHaHBQQXZjSTkwNFJXOSszaDRSRi9kVXArcGplN3drNTBnQk9U?=
 =?utf-8?B?S2VWTDBYK0h5NTFXeWRxNUVsY0RuQmlDa245UlhqMTlwallLWkFBZ200Nm1q?=
 =?utf-8?B?QlpLTHoydGF5Zko3Mmlpc3FvTjJNN3lGVUlSVVBDYXJmUmg3TzFwUFp4am85?=
 =?utf-8?B?VENQRDlraXlpN2hDSjRwcUJXQXFwOTdMckU4M0p3YXVGVWFIdk1mVTNyWmth?=
 =?utf-8?B?V2pzM2N6SG1sSzcxRkJ4a2tUR3B2VG5kUFNqTndTOVBhNmhuVExkUFFwZlJs?=
 =?utf-8?B?ZGtodE9kdXNkZDBtWGMyZmU3VFRKdDJwSGJhbkxKZE1MVityVUhGK0NkWTR4?=
 =?utf-8?B?aC9Xa21sY1FqcDc0UGxmajFtT0ozUzVYcHRZa0p0aGlSVHd0V1MzOUlKTTRp?=
 =?utf-8?B?MTd5UWZ3dTNFY285TUk4K1NLOHA5VDZLT2pFdTh6TFZ6WHB3L3U0WHRBZUk0?=
 =?utf-8?B?QkhOa3AxT0NZcUh2bjl4QWRMZzlKbzQvYnc5OXY0ZzFBWUxKdFUvaVlJR2F2?=
 =?utf-8?B?V0FxYXoxMURza2oxYkhDTUpibm9oK0pGTWxDbU1qbTNYUk9OcUpPOVlCWGNC?=
 =?utf-8?Q?3fooVzYg/81k4ZwWoW5QZV/YD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9659f93-1205-45f1-fe83-08dc8138803e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:11:25.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9h1dDXmPHgrb4/PjffXPSgwa3qV2X22CKMg2vQ3emXdyw7KXtz8fuYWukvtjB5O7FrgwTc+A5RIf86xJhU/VVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196



On 5/31/2024 12:06 AM, Dimitri Sivanich wrote:
> This fixes a bug introduced by commit d74169ceb0d2 ("iommu/vt-d: Allocate
> DMAR fault interrupts locally").  The panic happens when
> amd_iommu_enable_faulting is called from CPUHP_AP_ONLINE_DYN context.
> 
> Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index a18e74878f68..b02b959d12af 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3353,7 +3353,7 @@ int amd_iommu_reenable(int mode)
>  	return 0;
>  }
>  
> -int __init amd_iommu_enable_faulting(unsigned int cpu)
> +int amd_iommu_enable_faulting(unsigned int cpu)
>  {
>  	/* We enable MSI later when PCI is initialized */
>  	return 0;
