Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E53546C0
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912724; cv=fail; b=nYU4vhJEPGTbmuKU9oXfJm2Nb5WX6UnJ7LG617pR/unBUuitX//RXCfPZBfWrIS4AW9RAZnJhXGS8w6wIOYevAVSytLRsmaltyc6fIgykHjDvHrwgP4aliPkWco35+zRYbwvIYdEuBs5f6xfrR79wJfj9q43PGOfUwlky78WUAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912724; c=relaxed/simple;
	bh=2Rzqk5YYAM42LTRagSfD8P1lze2KbrabSuD50kRCHaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D+3lLR/bys5nbRdcGPh3ltfhZMVjQBKLFa71vuow6i/nnpYLNgrO6ukXNNlrI4vuO9UKb8Vnn/aF3CU79ngkhGX4Aq9wmhNQhFUBLpO4Y5/K3fFCn9G3zLLOqCNLa2KkVvIikhHZP5oSgRVts5ju178gpWhe3FtbUJttRda5Umw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XgXWPtQb; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XgXWPtQb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKmxBZbM3K125gGivTyUQq8oZXSE0S1+5cklnYUyrVl/V9UAD5A5hlTEc38osVfI9Xq58dB8nojOAEmDbU77kcaehmyY+r4DQKMo+QAQ6rkwB6JXHr/D8JDv4EGj3U/VZADB0vhN8pqFLiH4aP67LPCTBOCbdONQthOmJuTLwgRlbHgl+4OCq4+3jlxaWsjPt/IzwflUH2TfqTjQImvm6ejcqZJkEp49PXvlvWIAGVPE3UOwvEfstGU26ZeHv1WB2KCjI+37pBoiaaTLwnq6gqlf0tBvcd/BWXqhq3TGkM+jhDyGosjNf4YwxHEwOsQZ1mbjY0/tEbC8NZ5qDeP9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOw0UB9iFDf8BCSyQ/SVNJD/5hN2YPyarozK4u8dqUc=;
 b=UiL3ceb8PPzuxwUoAQH5Guj6htVsbf0+2pZ/yaE6oMrghkEXWP3kvL6X8CQcWvVubDVayba3wwfJoYWf6q1XIhgH92gioO45aH2Svu7ZRC3xW61gRKm5yy56l78plQqzpxwbWGjjxchhVrPGAeYMW8YIGSyMgUChHSZOdwuDnHJ9ePpuVJuRK4c62wIOAmk9K+mJMiO6nhnqUXZqwlPGDsDFqJb5jE+vL5CXJ3X5WCa2z01fhPmde+Fsoip4fZn6D2XsXcrzcRKkTi/Zd2qyY35WpQ8haKvJYjUBAU7ktCYseDvtpC/+Snoc9aXJjwFw4Y/vqlVk5lIOZn0KZ2pBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOw0UB9iFDf8BCSyQ/SVNJD/5hN2YPyarozK4u8dqUc=;
 b=XgXWPtQbhL+jQXbbD5EDtB7Dxx1eCEdwNCUxL47QatWHibRFpXzrVA2FgBkicwuDU1WX1hqvjh9zM6s2OsD0BzuM3r/IOdCilMEwUBHvz/ftj5w9dOuKWhOtCAQ+w1wWJBPXbpuyrzo3nDgcbiWrq7bdyooZV7GnNWiBGmVOwH4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 2 Oct
 2026 03:45:13 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 03:45:08 +0000
Message-ID: <d4634df4-ab32-46df-8b05-665998959e43@amd.com>
Date: Fri, 2 Oct 2026 09:14:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/amd: Make PerfOpt compulsory
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
References: <20261001182410.1525285-1-superm1@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261001182410.1525285-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: bf29b6a1-e70b-4f0a-ea52-08df20378d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y2kfK73lDm7dekdWMd1jVe9Z/Ci0LCeARX/8tuLuQp5CSJP1hZ9K0BlE41LHVGK77+1dPxoGo4dM/XVescIsk6VnY5YUiqCmCDPnpb0Cbou4d//sXjSy0lSsZp2QpsLYwll9NmIt3jmj3JLvI4ZMPeWxE+JSj2D1qvhTLD0cGkwccA9BAw0et9fqa6w6PpEymB0/UYMoPsOgDh26v/lUeY7Xj0F0U+zqvsU0Dsm4oaH3ymk14cj/z/ZbjhqcP2CZD5yzt3kOtAUexdgI7nKLVmW2SI8qc640iemyakBs2a3Dl55ST+ISZkzXD05E4xoQf834chEODHF4gY5AKBc7d3XGg03IuYRpc723A1Kk1ZyBrx6+lIXvURnkBl8Q5V4Q7CqDFRx1qMLXyJrVwNZm7fODD5emw7f58YumwkjXNjEn7xyg1Mv2W4cshdHi19fCt1XJP4IbmmPYtjCuKwumqI1QdqVMRk97kH26t63NbAFOwk9rRzjJJ6TJYRriijfSWyA1AJ2QTCDm3/0PjZ3Vo1HUq1aEpFBALHA43IKGBqQ/24ZhBRvDNXx6L5/NaZ+MYFww1zSCQ7mhLodqzA+uEq2K/h/qfxzpIc8iv9q50ug2Hu3Wy69VkzLyjhEs7R01gbWwPJNP51gNBB8MJdKix6vGlw1JJeqo3GnrqBW/+nc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGpDNUVRSVpkVi91NGpsQ0FGWDNLOUplMWVBTEE0aDVLT2NRN1JwN084YkVG?=
 =?utf-8?B?L0paYWhPamJNZ1hvMzdSRS8wQy9jS1Z3eXZIUklUL001RDVxd05wUXR3M2RB?=
 =?utf-8?B?MnBCVG4wOEZDOWx5Q0MzdTNVSWlQdko3UU1sam9qOC85WTBwQllKUWttdmVD?=
 =?utf-8?B?dENqbTVCUk5ocytZYlk3L3hzdGhySzBYbUNYNGk5OXcwR0VJK2R2ZXFLdWhD?=
 =?utf-8?B?WkxlVlhtM25rSTIwenhTZDBKT3p6SXhicC9zNlpvSHNjeTJXd1QrQWZMeVZv?=
 =?utf-8?B?NXhVdHI4R3dEOFJ4bk5SVzRTR3JlWjVYVkhsc1JpN0xDcGtBVFFsd2lEMFhB?=
 =?utf-8?B?ZXBnKzc4YzQ5M0E3STMrTWZLWGsrc3ZkQ1lldHVCN2dUS3FqRTZqN1poTnZP?=
 =?utf-8?B?YTArNEZleFZGbUpiZzRHL0N6SVNSUkIxZ2tFRDhWU3BHVFZEZWJXSUw5UEFF?=
 =?utf-8?B?MXpmZFU1cUxnZmlDZGZqU3Z6V29tYkJIUWs1bDlidXh5cXp4YVMrZzFZYTUw?=
 =?utf-8?B?TktrTEVaWlJPZU1lc0VLQjJNZG9xTDlGUzBQT2xwaWkwVEdaWnE0YmdPZytx?=
 =?utf-8?B?SzBselRLTHRxZUIxMVY0VWpWa21EdmF2MGVXOW0rMkhHS2lFWUl4TmZ1VUJX?=
 =?utf-8?B?TWMvMmVIV2luOCtuUnI1ZS9pY3lER21kY1o1TDIvZDJURTlqME05MXVkWCtF?=
 =?utf-8?B?L1VVT1lHa1RNUklnSG9pMGdobTQvNEgwMHBIN3dlZnZsOHprekN2N3ZISFR4?=
 =?utf-8?B?ekRwYkhqOFJWWVVta3J0YVQ1NkhhVk84ZEZ3TkxpWEQxNEJ6SUE5Vjc4WjVz?=
 =?utf-8?B?bEJRbDM0akZVQVpWbHR4QzRBY2tJUks0ZlJsTHRTd1JvbnpGd0V3N1MzbmtS?=
 =?utf-8?B?T0FsK3lnNjBCQWVQYndnSGpaeWwwVkNJSm15amRwU1o2U1JlZGVzODNYa3FL?=
 =?utf-8?B?cHplUTF6NUhxSUJ5eG0yYnYwOWZaam1tU1U0eis5b3Jtb1ZDeWY4RWMyVG1D?=
 =?utf-8?B?aTFtamNkTSt2clVRTGVScEEwa1BBa0EweXB1cFlsa24yQm5zZDErdGFjWU9n?=
 =?utf-8?B?NkdtanlqT29id1AyRjI5b1pENE5CWTFkOUQ3SXpoNUp3OGZqMk5VZWxxY3Uv?=
 =?utf-8?B?RE5hVk5DMzM1ZkZRME45RlJTSG55UHNLc0NQcXBONzIwckFIZ2prdWc3Rjdw?=
 =?utf-8?B?bU1menJ3czFvbmlPSEgrQlZFOEd3b3ZMcnF2dEV4c3NKa2RwMVU2YnNJeXFp?=
 =?utf-8?B?ejM0YWRIK2NRMEZjZUNhYnQzVk5sUmNUL0lJaXFXZ0NVS25yTUtQYU5Ta082?=
 =?utf-8?B?dStXK0hRV2JiekVOQjV1K2V2aUFNSkpFVnhjN0hGdzZWY0hCSlBiL2E3Qlpk?=
 =?utf-8?B?NmsvQjBzeE5rbmpwS2w1dERqTHo1SXRyTWVTT2dMdEQ4V3FKVlhaT3A1ZXVa?=
 =?utf-8?B?K0lzRWRPWDFIV1Rid1dyWjFLWkhZMDJDN21YVWRSZHVydVF2US9pVndrcko1?=
 =?utf-8?B?cnlaOWVWZzBXTFdoWjBpbEFEZFdid0dIc0YxM2JhN1hDanFOUFR1VEJGSHor?=
 =?utf-8?B?cXY5NW5ueVk5a29Pb3hMaVROWFMvVkhwZktnM1RjU1Y1dTg1ODRsS2RLVlZB?=
 =?utf-8?B?bUUvcTNNbXVGYkt5d3FRT3JzTndoakN5dmlLeU9yMzhTeTBPaEEwcWVIdnZ3?=
 =?utf-8?B?T2pTOUo1YytBWnFUUGVObG4zQ3BJenVsZzVPaXNBU1RHNEVNUWlxRnNSNENu?=
 =?utf-8?B?M0kwQjUwNm5ROU9IWFNEMGhEamZ4Q3N0L0RxbkVaNFR0dUpnZk93MkI4YldF?=
 =?utf-8?B?OWxOanFuK2pLRGFyNnhUTXoxYjNCVlBCSFdRVHVkTU1GRG8zakY3NmdBYzdE?=
 =?utf-8?B?SjcwTjFseTlQOXpHOGZhVnF4LzRzMEkzYTVrOXVxMVg2b3ZsNGlRWlVzSDMv?=
 =?utf-8?B?VlRsUmpOZFJTUTQzSzBwUVRXSGh3ZUczNlM2bXdISUFSVDFhckRhR0dDTVND?=
 =?utf-8?B?ZDI4MTBITU5hWVJaVWpMMXVLZ3hQTE85UUZTaldsb1pHa1hJa0JDQzB3bWpn?=
 =?utf-8?B?UHBBaEJ4T0E2NFNwNUpQWjR4MFArRWMyNVJSV0Y4SWtEOWZmREMwMEtnNmlz?=
 =?utf-8?B?eVM5bFk4OFNGVU9EM3VNc3I4bGRHOWMwSXRqZ1IydnN3YWIzVlVUaGhsdU9O?=
 =?utf-8?B?QXdZbkQ4TnZubjNUalJiTHZ5TWRZVzlIcFFYYk5TY2psbEJneXR0eUd3Q3dw?=
 =?utf-8?B?bDMzc21DQ0VaakhkZ2tyaDZmTjJDL3lxTGcvcW0vcDE3bFZabnRobTJ3VmV4?=
 =?utf-8?Q?jF086t2XBPU0JTnMYz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf29b6a1-e70b-4f0a-ea52-08df20378d6e
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 03:45:08.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpdhPHZIgXeKJVeYKtTBt1qCZx26uG1wvM9b5c2dvNySmSkPYxO6Ql9coWvWDWzLkWbuQw0/4jnt7jUS+bjvRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820



On 10/1/2026 11:54 PM, Mario Limonciello (AMD) wrote:
> PerfOpt is only a feature usable by integrated GPUs and only in identity
> mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
> an integrated GPU is in identity.
> 
> PerfOpt locks the GPU into identity mode where the DTE is ignored, so mark
> it require_direct (blocks VFIO/iommufd claims) and disable PASID (no GCR3
> table in the fast path).
> 
> This drops quite a bit of compatibility glue.  There was a refcounting
> system, exported symbols, and device attach/detach logic.  By just setting
> it immediately it's a lot more straightforward.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v4:
>  * Disable PASID for PerfOpt devices
>  * Don't allow attaching a blocked domain

This will block attaching device to guest via vfio-pci. Is that fine?

-Vasant

