Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF245DF4A
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592313; cv=fail; b=b61PcyGWo0uVVgbnAoihkW/zQfupxVaIgHpUwVXN1zjrWFKeKIK55uoCyJDMnH0r+V5+jL4Dh3y2Euco4opTKX21cNmQjuHZGVqqaNkqE/6yV1CE8KwPxDicIG8W7B4zBQ37ImwEIz9qpTatTu/yNWYnn1bmariyyCOBWwIpQ18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592313; c=relaxed/simple;
	bh=7Y7wycQXcBJqC80S6m6/B37ZaTSZ1lW2rp7/mlLTEeQ=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Jy2S2IEqI7ccUpnnkUys7uVpcrETV9pA3mhZaFr26bNWY66o2mnP7YBprE8+cxhJVWAqz+l/LkHhRK5HJW04A1pBjxL77rnAuNGTfIh875dRNhLp6BYqAfidJ9Ulp22As2+sUmjeWZnrv2bKKZl65TJzmCJ2+fA5WsoaOdkaN2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P+z6OuJv; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P+z6OuJv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9RRLEj3TDTZjkOW/zoB6n6uvGaSOG3QkA8HSdkM1EHtsanKJc+qiNE1Qza+4UfjEBJiYPgsImCkkky9TcLXNdkWlQxHehaZ7lkPT3EikvruoACRmYUDO6PZqbNcu5LEfjo5qiKqRQP9sPVupUE1vcHawupp2D+SM8E/Lj1s7jPpXn35pKRXfmRmEl1EA51pSy4WBP0LRouTPwQR+BRYsQTczD/1PowO6A//5aYRMqI6BXzqEGohxaUrMDC3NE3nLd/NDxBkdJ3w17JOFSqgzGdjoCueobY8ANsG9SyyN/aQgnSe+K5qClVb7p3FNfmHf0bidFiCF0bnAC8zIQWVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9k372yPjTw5KMTNvQzSm/jbcgGOIdBTMT/PEMvyzRU=;
 b=gJVOvPdnP8g3g1i4E55Xbt7hMGCnQdzer0a/p7p86fcPokFHSl2EnjXQefsgF6qMYhuGI/QRqtFTLsvs9Hn4cDmvSvg8wbo+tRIqre8K4Q/svGQxO39o/6G5+3vGIgvvfePtr+ZWHC90wdN4HN8bJWZQgRPy6T5hlpmIhBTxLygn36puQDksEyO/0bqaXyZthcZ6naZnLZHPLdSlJlX3j+tYc31729xHptafyrl5q1wE01todFNla4OxHnQBtHMVaq2MJ5RCdaaWzok7lLBTvILgnY1ECELkYTmKiH2DtWUYRChw9MNhwL7pOynLjmxp5ca3UxG8sZLiu2eAguCj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9k372yPjTw5KMTNvQzSm/jbcgGOIdBTMT/PEMvyzRU=;
 b=P+z6OuJvTm2Ua0IHV97RV/Q/WJO/wgFiRKLoqrXHvib45+O+3Uhr4N70W2ts70HGUTmPmV4vJbTw189+1o9Fv/IPP5c2p9lgSd8avBrM8CCzE5K4vlzLSsCbzF4ZnCCZCy1YQOqiH/C4+o1CybWC3kSrAo5SRMQXxeXfcW378T/s62xcEF4x2TIjDV2frZpTiMn4s6Px3r0BLzMBzBoHAXPqLMmhVNnreBwaQyP0J3aPKtH1PpYXIEZGm37rkP1hDJWNr6h/gnyIYsIv3SdUiDdLqYeth0FKLLwXCibibyvl4JnE2S7FSZEjmA6WWKGzsGreiF5S/DGWx9UJrjgCOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 14/24] iommu/amd: Add per-VM private IPA alloc/map
 helpers
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-15-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-15-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229635.3131778.7221566452483466465.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN1PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:408:e0::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: dc28506f-5d83-4848-d8dc-08df0204a2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PoN9X+u6FU85PSVI3weeBctJpyXQmVGCQlY8WLcj0wDnnikQcI0bkLeAh5x7PRdrqB1ITSIcYbzlvE9fh6mXq/rRUFlG8DlvtmX25AlvwoONeGIlEF9M9AuayrtMXP8sZ3klXoWsigfQjv/d6AEULQ7D7j7yr4dPAH3enTDngBIFk9EBhfZ9HEiXzAf2D4fTWp4E0PabsvH1wOMEI3Y+06q8Bia9yiRABJTnteJNlfqro9pVz+ou9Ylmfi0zsS/hTH0XYSWit0w1FdPGC9Ru6SsFcp0A25ziGM0guDWHdoRyATcFUbEI2VCx9yWs+Pm92haNkPbquANwR1VxI7Fl4P4cs317aysdTNRgxM7ZUDaHYaz72qiHJcb10bjdw6BmiV7MZV/iQ/N54ScfxkNTQVv/L+X2gy7SefRc3Q8AmG60gJLC0pD+eY44LHQNcoGYlTi14vr4dCZtQdWCD9nlCynjlhTny5s7lEWX2s0pgph44WsODFy9C8wg1HjzqNW2Q5x52oiX5+EU51HyI74vARPSnOnT8NKK5tgWnKppJ5p6ali3ZtLWvIOjxttLE1ukxT1gVQ6sq/nlC54HiD6zv06tBqZr4p9YIc49dEJW+mslzUNfPCZ4ojs9iGXe+O4weyXeBJ+L3N4wjv+AZTHi+Upyb0RPDk5aQlqcRIEPuJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmVhQ3VWYTRSTWtpN2o1NlpEK3NwY2ZVSEpyS1grYS9sWmo2R2ptYzJTVzNJ?=
 =?utf-8?B?MVUwbFNYdkp0ZG4yT2s3OWtlQzBlT3VhcnplR1pIaHNpRG5NcFV5aXBubWhv?=
 =?utf-8?B?UkxOeVdvM2kxUm1yV1k0d2RXZDROM3N1Nm1vUXkvdG1GOTZFcGx0MjNZSCtK?=
 =?utf-8?B?SjQ5dHluTGZHYXJmYTBYUWtRUG9qQ3lib05wdXJnWVcxQmY5SFpRVGVqdGFO?=
 =?utf-8?B?MkVzMWthUWlrR241V2x6Wlcwa29OQU4yWFFqeFdXU1htV1llOCt3Yk9YL29l?=
 =?utf-8?B?NmZsYUVTWVJYMHphQ1Z0VmtlMG5NSXNldEZRUGhUbVlNSTRhRzNQZjlkcita?=
 =?utf-8?B?bndTWjhjUk02Z2VVdEI2a3ZVUHpXOFlxS0laVWxyR1NLOVJ0N2FHenFGZ0xk?=
 =?utf-8?B?d1dxa0lMKzdFM1lMeVBMUjF0L09VaEZGRHRQRnJranhwUnJuNTJ3WCt3eUNn?=
 =?utf-8?B?RGM0U0NydGdtSjlZVjBIdzByMmJSc1BUMTV1bWkrdmZMNnBwNFZrQnpOL2lM?=
 =?utf-8?B?Tld6MS9JYVZFRlNFT2NySkpIU0E3Z0ZVVnVvcXhIcER2T2dSekZYR3EzSXMr?=
 =?utf-8?B?UmxRSkM4QWFlQUpUY29iY0tDYXhZazJLOS9DdjFCbGlkQWZneHRqODRqZm5Y?=
 =?utf-8?B?NC8ydEExc0tnbWRGYUtmZmd2eC9qVjRqMVlKeHU0QVloS0VBWnlkVVpaTXgz?=
 =?utf-8?B?RWtBRndXWk9uMmZKT2NIdW1GV0ltQzNCSVZab0M1SE1xOFV5b21aQWozMGRn?=
 =?utf-8?B?c2g5ekErVDNSRnVaOVlWdS9zNm1zVVdBdm51NnVBV0l5aXZMQUphbG1WbjBS?=
 =?utf-8?B?S2EwRjhaR01NSldPMHhzVFhsQm1QREd2d0NvZ2d6UEpHb2RtbU9BeFM2bisz?=
 =?utf-8?B?RVpUV2R5c29XZ1BweVRSaU82MFg5M09JV3NHSkR3RnFoaFVHNWZ3c3ZrQmFo?=
 =?utf-8?B?b0YwYy94QmFRQUlsY01BTkFySXdFYVcxMXkxZWRQRlNNZWpVQ3ZPZm8zYzI4?=
 =?utf-8?B?M0IrdEFUcFpPNzA1TFlGTldtUFE2M3N2L3VBRzZLYXhlLzJSY3dYTGZua1Nh?=
 =?utf-8?B?YUUrKytmN1NqckprWkxVQjFoZlIxWFI0d3pVRW8yQUJSbWl0cWtCdDdKRUEx?=
 =?utf-8?B?MW9TOWRLcjdzRTN5Z1dYaGlJK0NaTGxDSTZBb25hKzZNZWwxWGx6aEdtOVdW?=
 =?utf-8?B?bi9peHBjK2xWSndmM2QxWUpPdXhsVGRBazFmN0Y2eHJhU2plUE01NFEvRHBC?=
 =?utf-8?B?a2k5c2xUUUJQRjYwQjAwNnBlYnpzOU4xQnJKOXdCTm9CcWJFWTdFWEZXUXRP?=
 =?utf-8?B?Qmt3bmYvZkZOUTRpcWdnV1ptNExiYjRvellZQ0YwQUZrc3BXaC9JcFJPWFdF?=
 =?utf-8?B?N3RweUtWaHh4TjRUWUp6eFBkZGlqNDVsRWc3MURFYXJLbEJDMlYvOVBVTE5u?=
 =?utf-8?B?cXQycHdxa0JBQzNzMkpoZDJhc2RTZzRTTyt0YndMcGwzYUZ5UTZSNUxJdUd6?=
 =?utf-8?B?akRwdnNXQVJ4RnpScjZOK0paM1JmNXRhTWV4Q0FPRUFML1JzSFlWTnRTckJ6?=
 =?utf-8?B?UnVnR0E0aUlyMmpmaVRnWHlPWHJZN1FINEdBSVpYRzVydWNiMDM1WWlpdmdJ?=
 =?utf-8?B?dk5QMHRDU0xmZ0VPZHBNUjI5bEZjSlhTdzJ5VE1nWERvWURhdndlMk00TUV1?=
 =?utf-8?B?SE01RkVrdCtQVlZpSnAvL0diYnl3Z3BNYlhqQTk2SGkvMzF2T1c4dWNzbzFP?=
 =?utf-8?B?YTNSbWZEOVhtbk5yYWYxT2psSUJLZWpFOGZNRHd0dTU3VE1FMXJRUjFrLyt4?=
 =?utf-8?B?Mzh1aXpDMlA5UldoVkp4cGZGREhxOVRuU2NCbWNTNHAyUE1GL2dib1VlRmh2?=
 =?utf-8?B?cFFydmI3S3p2cThmWlFId2x0dHdKQ2FFSnhTZ1VralZXSTRwc2FSL3I3UnRL?=
 =?utf-8?B?dE1Ja2JaWEZXQlRzM2grbXRzTEtoQjlxZmpQdjI2b1JGb3E5bkxnL2FnekdP?=
 =?utf-8?B?Zkh3bUV5RmRXM0N0TWVxTzlMN2JVZlFHMUNQZHEzZnpNbE5SR0hLQVJuSzFh?=
 =?utf-8?B?REFJSXB0K1U1Q1BiN1Z2VnZMZEVNQkJZVUpxWFZLeUdxV3F3cTlZaDJWZGh6?=
 =?utf-8?B?V1FYWVU5TDB6byt5T2FvdWF3VDVtY3lsU2lTZFgzV1ZlRHRYNE4xQ1RIOUNo?=
 =?utf-8?B?d1BwOXFuelFhZlNFMnRkKy9RWWJISFBlQldmVnpzYVZTZGVTaVZET0RlZFow?=
 =?utf-8?B?Skp1MitseXcwYXRGV1lwWjRVTk1aZDQrejNqaS9iQkhIVTVqbXoyeU1YNCt0?=
 =?utf-8?Q?fhoLzJCDAMkiYN9yrg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc28506f-5d83-4848-d8dc-08df0204a2c7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:04.8604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhHgn0gmMRPsvdrG0ELg//CnitIKDFA4ZfXfVahiL5ehctLYMMpdsC76yVUSDYJ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

On Mon, 27 Jul 2026 13:29:03 +0000, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> Guest device ID and guest domain ID tables use dedicated slots in
> the vIOMMU private address (IPA) region, indexed by guest ID (GID).
> 
> Add alloc_private_vm_region() and free_private_vm_region() to
> allocate backing pages, map them through viommu_pdom, and tear down
> with an unmap flush on VM destroy.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
