Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76E3C8C52
	for <iommu@lists.linux.dev>; Wed,  5 Aug 2026 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949308; cv=fail; b=afsZJ418C7/JIYk0GfIFaO/+K7G1lKwmmNjCdizUfscG4ck08ViKVJSAzEFqhDkpX8K1KKlBguAe5Q9ROTTuQx9le+/mOq8o90tGHrR3+ExE1O0SCysAu8pOqteN9iSlNFY697DifE8e100bZnTvv4Fq0j0sNp85Id6+SqnG4k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949308; c=relaxed/simple;
	bh=QG3itLQYJivETQKNnLHiK5dy7LIChUKEei+NhSXVgsU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDsLVsxhX0FTPttL3wPAiiDdmHVYkqxrSFbEf79dPUcZoO6LIrp2DrNZ1pgYfPlQkdNc1d2yp7hJisC7WWGaLg2T6aKUiIfCD+oTOfn3cLa68IOIdO9rKgA7HQKfAyG3mit3wDSLlEMxvdxMpvmANCj6tJPHp46AsYXGlE7oEQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B5AOgQG3; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B5AOgQG3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLRjUHpfPrfTknSv5eGirsQXmYtax/Ha4tbhbRK2Uo9PYE5bW0JRgXrf3WSSFxNLw2lzBLQbV24ZmFuMxbT+Y3GFbZ3TTl4TkhpmUSBDE8mxUZr2P1Rep5b1VKm3g08hHj39LlDR1LvZK1vZlTWOdxElHbi3lE2uke2apfORI3/+4JANElwTDuo/Sdtv9AGzGfBbNXoGBSZT2o/rDhBMn4qkR/DRyoY/pBBYIXAQ0jHTodKrxLl4imx7WsLGy7Yf90ClG5SUt9Wl9tu5agjA4hFl78Gk0goqp64f22umjGtxyWeS2twwplMC6bXZGaNksPDAPc2VRj5O31psyfIjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG3itLQYJivETQKNnLHiK5dy7LIChUKEei+NhSXVgsU=;
 b=DDFx/N6hxHtLlh+44CsB/wtFq88QbvfikiyfqPju3eOgTFCGwy8a31WYKEl5RyvAp/k3K+KbDSxuSdlliJ2RYpV6wF0LLCmeXbJwg1Xf/Eulj2Bxf8BsLeWgJWAIos+FGEtwQxBG873mOlVjdKO77db4kLygtEfSqYyPt0RDHNjQ8C9Y3+rdlgFPYJuLt6HW8ZB+WxASY2O1NKnjUd2kP3qixRecdh+MRCnji62yHzB/YEEsENqI0qnFhZSjoM6bZ68mu4edqI1Q1I0hDtjkK771xtyl5/6ZPQal3vzHdzsBgaltDdcQ03/z7dSQs9+qI7wYYUN09Lu1pmDTp5tpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG3itLQYJivETQKNnLHiK5dy7LIChUKEei+NhSXVgsU=;
 b=B5AOgQG3Vyg30ugDb9yqR8BsADClUXeWtFo1XBzxdBJJ4GGkIQGgMTLPZGCGz9AWQMICyPd20Brvm8xOtpZ5t9eo99F5atfuHP5Q27O5s2mlkmrwXh0k/OgpqprdSVlJWTLh2dujhJKvVf/IFIexVodAuJvgS2+JEKyYUP5o3Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7SPRMB0047.namprd12.prod.outlook.com (2603:10b6:510:1f6::14)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 17:01:29 +0000
Received: from PH7SPRMB0047.namprd12.prod.outlook.com
 ([fe80::b54e:e6eb:405a:218c]) by PH7SPRMB0047.namprd12.prod.outlook.com
 ([fe80::b54e:e6eb:405a:218c%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 17:01:28 +0000
Message-ID: <be2f6b1d-69cc-4a5c-9de4-f3fab9a5ad1a@amd.com>
Date: Wed, 5 Aug 2026 22:31:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] iommu/amd: Make amd_iommu_completion_wait()
 non-static
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-2-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260727132913.22475-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::7) To PH7SPRMB0047.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0047:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: a513a598-d872-4554-7bea-08def31330c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	p1cWdf/iXcqmjuKswuIMCDNtQonrAhzDOqSrgczIO89OQsXkNMyEeFxG1C9dfVFnMIn6akt/QsVCTt8lUjD842qK3FlXTY4HGBEZgdA/GsuVjQaiY2aaU7jSoXgWkkfi3LzWAMaXa7orUMfkglZ2iHyzvK7+fhnErHHxH7l5MCF5TEwS1fJU8BW525W9HPhqdBi899Dt0nSYlnz0bRw5Wfn8kY70HqEpTM8EgmpXvM7ewfVSFkDvLeD1WbWDEIR2untspIT6CekU7wQzy8Ac5gD88F8X1xN19SxJLVgqOYbc1Rc4e6F2CgVXDKrK7/qnBR76vALk8aeCbk85PRI0zvXfwZWsPkG2oKC8YF0ZEVXrxc41qIeVgmXH/xVtvAevuzm4tMUm3BZxXXqkSWguhE7NZydikHxrWMp7QsuFJLodsy04ZWlUXB41SYCBeOWffDfNEG6TRnj7kkFfMB50RnoYLIzFoYaYD64sp5dRn0Bph+fadEwYLhkcuR5q/Bfiu7LXNI+SxgvOvsLsB3XlksGlhuyEMokg2PtWma75h9S/IXouhEwqlhYnkUKT9vUmbUovWk8WY515FzfEtJ/Fr3DhHVF8vFAm5u3wZ7izENdFq2VjoGMMRDnJRi9FCLQTMC8qsglVWuvTM8wHLcdwkXotmWXIdBbSnaCC3Fuhros=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0047.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGtzRW1YcEJhWGFKeXJrb0M5bDU5emZFaVMwWUtvdnVwQ2ZIcHJBZUtrellH?=
 =?utf-8?B?VDQ5cWtHNFRwT0I5SXFNVHFpTzJrYWRxZHhhRlNVUGRrbnFITnNsU0Z0RkJX?=
 =?utf-8?B?cFYxenQzVzNZdHNFZlcyRFZXNXRWdWJiWWY4clNmQlBHSXJUUFhHN1VtUHo2?=
 =?utf-8?B?cyt5eS9SWlEweWlGeGNSZGJEaXBiTEFLV2g2MU1EYTJCTU12QSt2OTVEaHVw?=
 =?utf-8?B?ZzNvcm9FSnJnQnMySTNNR3hGN1l6K2lZdzNYN005ZVlXdGtvNDdnSGo3OWhr?=
 =?utf-8?B?bnlOWi9NTFBDYzQ2cFJDVTYvOGYwVHQ0NTMyT2MxejgzakI3MUNibElNRWlW?=
 =?utf-8?B?dHphd0dZTllSOXBKU3p1Ym03elpsRFJFbkZraDI0M1o1T1dOSXliWVRJN3Bz?=
 =?utf-8?B?RDBGaEFkZVg2YzhqV0FtY3g3bk9oMEhGOERGMFNzak5WYWN6L0ZMdUhOcC9x?=
 =?utf-8?B?S2t4VmhyRDRpcnhDN2RUSWg1SWdRVEo4dE1BOVBPdGdtOVVvQ3VhZGNBeUVJ?=
 =?utf-8?B?ektFU2Jxa29KeE1VSkNYaVI1cnJEMkpFTU1GNDg0UnpYT2tWc0V1dlNyckJH?=
 =?utf-8?B?NE1qRHRlQWlDQWpGYVN2UXR0LzF1bEk1dlhacTlMVVVjcG53clhFL3F3S2lx?=
 =?utf-8?B?cXdVdURKS1ZIVFhZbUtMWjhMWmNyZzVqTzZnUlBXUDI2S3piVGRkcG5idEs0?=
 =?utf-8?B?UThhUTVRV3cvV1JsTXo3aVdsclF4NzhpaCsyeGhrNHNELzdtQ1YwWW9BQkps?=
 =?utf-8?B?ZDhHTjdHdnhiU2QvampMZlM2QXQvQm5vaTFxb1J5dkkvdkkvaGdtYWR0Z1E1?=
 =?utf-8?B?VWdwU2cwTVVhRzZvWVYxTDJuRDR5YVhla3ZPUVcrNTlMYVc0WWhjY20vdnpM?=
 =?utf-8?B?NmJGL0daMGdVMTVRZnVDZStqUThmcERORHBrQzNxMEhHVnVRMzNMOWd3MjNr?=
 =?utf-8?B?YXZWa2ZvVExBZ0lUQWRncjBKLytiWDg0S0NwTm5nMlFkbGNidHpITHZEczdF?=
 =?utf-8?B?QStNSG1vRG5YM2lHTFozVkJIWkFHNGtiZElIWDVwY0YyTFd6cjFwNThaVE9w?=
 =?utf-8?B?MEVVaEpWWHJNeWRuREZQMCtFREdxU2x1NFVaTjBWVVR6bEltaWNpWEtmbE8w?=
 =?utf-8?B?WDA2KzFwQ21LbmRPdjBrOUYzclpXU2x0VjRIUEtmTHJoVldLMnRlUXlZeDQ5?=
 =?utf-8?B?Y3F6TzV5YnNGU1R1ZllPTXBYSmJlLzQrdDBiOFpZUE92WHU5Um9YUlZtSGQz?=
 =?utf-8?B?QVJCRnFiNHllQ1RlUWFYbGNrdVRTQXBqVnB3VnpDZDR1ZDRBMEZPaHdLSmlj?=
 =?utf-8?B?UGtQanRHRysrZXIvaVNjWjhWck10b0JYc2JIMkFkRGNQWUtZOFFZK3hRUVVk?=
 =?utf-8?B?RzNBeGRoWCswNnpybzFmaDMyKzloeTkzT1dWRGljOHpMRGcyVDNSVUdIU3BM?=
 =?utf-8?B?UWp4SG1zamF0Yy9PU1RlVjZEdU4rUXhvZjR0dFV5Z3JaRFR5L014ZEk1WDdv?=
 =?utf-8?B?UHltd3pEbzh6RFNnbXp6Mkk0UDdPSmw5eUtMZUZKVDVwRWJOWHFaSnk0d1ZJ?=
 =?utf-8?B?aHVXUlA2K2MwMVAySGdLOXJYQnhzY2Z2MU5BQVFiM3dqOUF4NmVJemJwMVho?=
 =?utf-8?B?cXlheWxxVFh4cFUzVThKV1pRRlJyNFJzVy9jdm1JaWVvUW9tQjVwUzRSam9C?=
 =?utf-8?B?YkJHTUZqQldrNG5LeFZQL1hWakxVQjhMS1N5MTh2bGtxWWMvMGJjU2t3SVZP?=
 =?utf-8?B?SzBTUjhCTjRWY3N0R3RSNEM2b3ZHYldaWEZIOGlZUVJHM3FXRzZyMDY5R29r?=
 =?utf-8?B?Y1BOZXRXM1F6MDFIYkgxNk1TMWdrU0tMU3Q4NDhOemluOGVuaFk1a29Oc2Vo?=
 =?utf-8?B?clZES2o0c1lqM3A5VWR3cGNqZnVCTitJYWlSR1N5M3piSEhTR0lLSTJQK25t?=
 =?utf-8?B?SDFPaWgvSENZNUFZd3RHTS9kWUpyWVVIMmg0Ynl3RlNzUnJ4dE9Qd3lsYlhy?=
 =?utf-8?B?cVNjZmFPSDR6RWFtUmw5R0RxcG1qdnRqTmlTa0NFRksvSCt2OEp0NXBqY1hu?=
 =?utf-8?B?L0NpOXplYnJrN2NnS0E3Y0NsWm9FVkpYM1V1eHlXUWNlMU85VHJ3SFdOaEFp?=
 =?utf-8?B?Vit6Nmp2VTRXeXFCQTlIOUFNdVB5STZJbXIyY1lFR3ppTXhodmd5UitYeVJn?=
 =?utf-8?B?QzlUVmZFMjdRNnV0c0xVYVJiZEhkbjJoOGpWbDRrSTI4RnRvUUlCTzBPakVq?=
 =?utf-8?B?T3JDM285eVNtV0JDcnV1VDlIY3BFNmdySDlJdHFZbGZCSHA5L1pkUExjTG5L?=
 =?utf-8?B?dVZYYnU4U3QwblIxUC9VbGJYT01HYTB1dkpzRlo0UURtM3VzL0lqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a513a598-d872-4554-7bea-08def31330c4
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0047.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 17:01:28.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+1vZLjI0/UwnOEKUvl32lpKbFba/NUfB/V+r0DX7zboYDrev0oftU9E2ky/Sv7ljg0JfT1ckijL+MamTG1Csg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479



On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
> This will be reused in a new iommufd.c file for nested translation.

With all the changes, looks like amd_iommu_completion_wait() is not used outside
iommu.c. May be drop this patch?

-Vasant

