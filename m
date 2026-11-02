Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793631422;
	b=1L7pnIlfAyIRebaGdu4AbTGlnhCRTaAUtOfSkL2+KolE/rkKxnej/LXo5WYP74qMXrKW
	 41a/QJMfI7EFEFM/CSCVtFI3Eb29qHRmj4sug3N5p7miI3Ry6zraDth+jYfVgQb4NYaFQ
	 g37zFwCwSZ6wYU8nDpHv3ZSe6FS8axfuh5ktNshofklkNhnzvD3CiEJeJbYx8g+CpMLh2
	 yg6ws79jwoCVvDeWxdNScBNh1SBAVhrA8v624YTx8bgiG8nvpgVu0/ehgA6obgGjvsn2n
	 JfOIr555IVMSU04AKDjEm0lpLpSymivjrqIXWYyOrv1DXdfJJfzfK8G8yGYpk47IPMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631422;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OjfsU32s6nigEXvZ46EX/dV8M0Vj8Y/DFqbgV2hLlBE=;
	b=zqUKYe5z71Csqywj7calmDRE0DJCJMCtj0fYhOUJLWX1e0MYDVsqHGXFMFN5o1MYZpPw
	 6A8hR+22QI3wQpEBX3jxE6h0kdLaFMja4D9UdTu5Oseo4ge2s6afm9TS1Y2YJo90sehzi
	 mD7W6ZV3LdySWl5I+NrGcW+G0xUEYysOQXlf/n0OgdBkjHxF7/+lKVmyzwYvwZe6G4e/l
	 ESVQCu01r8eUm4HjP0qR+csj1lChdNO5ew+Kg9MTZ9sbbjv7x6IRn99N8KyUVEgtbeG4B
	 6HTK+x7rGOggYAe/yKn8t9UIcSkUv/tW+8ds7DcUNGO0/aTsGQll6d/8y0jR2hJr1oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wWiRZfkm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.14
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C1606A59B
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 14:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC9C1606A59B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wWiRZfkm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYI/EMlyv3AKZqXjNYiE5W/Kq6EzzIz/ZMVziM9kbV8kKV5Ec+tX8PVpVytCnEFeGIAf09EoNB3vySk+8Z8xyqb99lBPL9+egBzRvbYVPfeCX9PztzOGqaKCCrRt8zFZ+oYtbMyCRiHapVXkjSwEILti4JOtI+UF0QcAg90KbTBv2/JaUd7eOfz5vd527jQhHF7U3vTqLTlMvbHnxOOOj0+wqMafMimXvfIqnV+235Cl/H9oSsE+WyBNuYsg23YpNheAyLYo+cNIwk1WjrmAzY5jjvGWmxkgVsQ6CfchGAU8O0c981rchwMah/yB7tJzhOyhSbuR8FWy/XDt8YMaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjfsU32s6nigEXvZ46EX/dV8M0Vj8Y/DFqbgV2hLlBE=;
 b=wf5CKFSjAT2mhpz5innZ7qyTzwsGfi4Uu9YbavQjHwzZcsTDhWRfCJ1JqRsnXEYWMJXSAGe2DtBH6nBy8RZ0LXDH4mQpSZAb8L0OQD1aD7M0+OKUlF1kNSs5vJyOj18i8v5IK3uv+PLRfVCp3c9Yhf+z9pSCyPO7X99SMjnWqMyKCUBtzNxo+L58eulBybWL5/nuCMSiXczCQc0a0yeFw19+Gb/EL5QixWKhnoD/nGkFin3AdlxkVtKZeNy0z+Dczgl48faEi5XkziLkxpzYGjCiBVrNe5isGh1jOSvIkadxstfiuOfnq1TlUt5x3eTjy7GEHbEQI40jAvavzQhB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjfsU32s6nigEXvZ46EX/dV8M0Vj8Y/DFqbgV2hLlBE=;
 b=wWiRZfkmlDVKnvRpK7y+QkW0joOG/j+ei7nCvz8LYi3U2BmTX5oCZdDkzPAwWrgQp6F2wBR+YsivwuSXV01/m3xQUN0ym7Y/FwKomki64EM92Ol6rzDPgKKZxRLNac0UngXSw8JgxC1D8qtUodIvBN6goNV4D60F19p7qiBtQik=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:56:47 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:56:47 +0000
Message-ID: <4206ec86-c6aa-447a-a5d1-4d2e89a31b5c@amd.com>
Date: Mon, 2 Nov 2026 20:26:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/amd: Enable PerfOpt automatically for integrated
 GPUs
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Deucher <alexander.deucher@amd.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20261022-superm1-perf-opt-next-v5-1-dfef0b78b7b9@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261022-superm1-perf-opt-next-v5-1-dfef0b78b7b9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0302.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::19) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 6831b782-8f3e-4cf0-1ec9-08df38f18459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|261102123227099002|22082099003|18002099003|56012099006|11063799006|261026121527099003|261022105027099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	naOFSGroMN/0lV+AxXsr1wSrjztY1Zq/nTt30RMlpA5ZyZxoUzkx220FB5fJXnBKxiKZ0R0mkeZsxGOmJ2luLy0OuBrXdRnjHzosbrOl05ahULCBEWCfJIMIA15r9lS2x3KKtIsACEREvXA2lCPfq6x8Ppa4foWr3XeeFIm6dKfzM8f1r8hfD7Y0Y4qoESWVX5bPXYzb0Z4wSW5MLVJOaTBBopQMNGQ4l6JVniZVBZl7TJpnNIRGkIxQs+SvWuBAnuYdXgQAmuWMXZWEbc3/0UqZyqIeOAUB7FI/amkOiplGDXOnkwYF6H2yBWPr3G90fA5Ay0kKg+5gXqVbEzNPkoYAT+gQHev+SeVj4aCcNYj8ZwSj2UMktbOTePP3aKH6Xwh8iw2XQmH1hs27pezfO7Or3/f1UFIBOTUqk7Fpfx1GoAmQYin8nNcEKt/InErbR7Usi0W3wwXxgBCrxV149gGQtNM4CyxZCnWT2Wf7p5hvNuBct0GCdWPQSDfQiOWocwrMl6wU/cP9tgH5wez9qBkzEgz1hMQGSAXqwZzPY9vhAktzKuowMSh3pN1J9IuQtqZ5LRIK8sl4/uB3OX97ElkLcxaKAHOVRXREEFWXetWyMTbvFy/obTES99uNL/UTDgehvltJWzazwCF16b+yDo6Zb51/ylV++OOsobS12lQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(261102123227099002)(22082099003)(18002099003)(56012099006)(11063799006)(261026121527099003)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHVIVHpzU0lMQ2I2ekRrWTlDL2pkQitCcG84OHBCQlVudlJ6RGVSS2wvVnhs?=
 =?utf-8?B?UGZTVk1XM3BoRzczNXRDWWpxcERLWEVDTjBlL3E2MUQ2NTVhUEFBN2NvNVFr?=
 =?utf-8?B?K0VLVWliK0FvVHBBQmZVcExRT1RCZ2NsNmV3cFRZeVlKdEhJSzFxQnpHVlBq?=
 =?utf-8?B?M0ZROE13dmhuU1ZMc3IwSXZhNFBFcEx0aktEd2lJQlM3T1YydXUxWHZxdlFF?=
 =?utf-8?B?OGdscVdIZm5qSWtONVFTdkt6Sk9ha3dYeFdmeVlSVDcrcjY2MXI2TlZNK0Ey?=
 =?utf-8?B?akpPc1lwRjRPWnJud1J1TWVWWkFPSHFJSDJJRy81SFFJQTY2OTBuaXRBSEVz?=
 =?utf-8?B?SDlJWGJPNVV2MlVBWmZqak82UGlzRWo5Z2s1UWVhdU9oSyszM2R2dXRpWlR5?=
 =?utf-8?B?NE1haFI5Mnc3b3ZoOE9zc3NiL25Zc0RMNGhLc1RVc05meTQyd2huUGhHWlp3?=
 =?utf-8?B?cjF5VGdudVFiaVVaZzRwUW4zN1VacTlib0ZRWlVjRWs0dURaMkV3ZzN6V0xP?=
 =?utf-8?B?dTNGNVp0Z1ZMR2NwYTU4dFl4S3FGY3hKWUxPeUdYRU44UjdWc3AvOW5DSXBn?=
 =?utf-8?B?R3Y3RG9iRFVyaWZRWElFR24wYnRINUFNQm9lZkRUdHZvL0dwRHI2WnZGRGhR?=
 =?utf-8?B?VFZWZy9YcStlcExaTFJaM3F6alFSVnJmWDVBUTkwTU5PVkc1bHlXcjJPeFNX?=
 =?utf-8?B?eHdFQ29yN21VcW5qaXhlQUc4SjFydnM2cWhxcjFaNTZZdkhORjNwRW5sb05j?=
 =?utf-8?B?a3VBQUlpTmo0aWlockpqeXlsOGthbmxucEJ4QnpMUnUwY2MzZ0xiWTJlV0R5?=
 =?utf-8?B?aWUwclNzN0dVT1dyQ2pPdk9CcUFHTHdEYjdQVjlIR3czdUtxcDNXVnJaNU1i?=
 =?utf-8?B?dUdva0J2cFUrMUtpdXduRHdoWWdmUVVEV2hHTFRQbHQ1MVk1TlFRaFgxKzZF?=
 =?utf-8?B?bmtTNHoyVXFUMk9IazJGSUxZQjd6YjZ5L2dHNGwzaWNMU1pIcDI3Yk4yZEc5?=
 =?utf-8?B?OGhXZFNPL1doZkJmQXdxUUw3RTU1WXo3NDZ5MzV4OU9hSWF5T3oxWDBVLzNN?=
 =?utf-8?B?bGZieUIzZHZjemRNbitRNmxpeW03R3RmM1hkU3lwNFAyeEVWUlIyaW5nMEor?=
 =?utf-8?B?dXplODdxZGM0V3ZWSHhlby9YdERVV1dFYk91ZDQzUWptUlMvUTBrdW9PTHpi?=
 =?utf-8?B?c05XRHVmWndtSC9UbG9aTU9OTGF5S1ZETjBIWlZIcWc2a2NCcXh2NmwwYWRS?=
 =?utf-8?B?eThEc040UXJ0bC9ZaEFjZFdVVFZOMEU0ak9lTXhKb2p6STh0ZkR4TjhKeDgr?=
 =?utf-8?B?T1hDWWc3UEVnbUlSai83Qit5WFVoSmhJUjIxVzBvRTlBQVRTblBIbEx5QUwv?=
 =?utf-8?B?dE1kTUVSS2YvZXd3ZGErR2ZCcDlkV1o5M3FnaFl6TGtpVTNyR1ZKRFNYUXhl?=
 =?utf-8?B?RmJRWG9uSHBMV1VyYmt3bjhLUnhQekhJNE4xUjFhcmxOS092OHdDbEFOYkMy?=
 =?utf-8?B?TWZ5UjRGbzQ0TW9vMW5MMjFlOW84MHJEb0lxQktnOXdUWXdUYk5IYVF6cWJv?=
 =?utf-8?B?MjJ0NTA0NkppWk9BZ0xOZWtBQUFhQk1GU3pYem5jUkwzbmI1UzJtMXkzWUJu?=
 =?utf-8?B?U3hmMGlCV05LckZXYUlLeDFFSng3K1RSR3d0cmY3RXJzZk4zbmczWW9GREJ2?=
 =?utf-8?B?dGdob1M2NWwrZE83TWdWODdkRkltWUt2RmZDcWhaTU9FZXk5QlZxTkpiamt3?=
 =?utf-8?B?d0ZHWEZDMkdJSWVFNjZMbkswV21JNGtZY3kxT3c5YzBuTC9kN1pmMlR4aGJ6?=
 =?utf-8?B?aTFoNy9rZFBheld5VGxzSFpLelFHNlhJT3B1K3pGZDZYZFg5MURidnovYXRo?=
 =?utf-8?B?NFlvbkhjZy9ZM2g5OEFKenBWOEFEN3ZCRkY0QWltRHR2WHcrdU5JVXFsQWZ4?=
 =?utf-8?B?ajcxQTdWTC9jSG9CeUp0MGFIcWcwK2E0d3dOY1lCWTI2eUlMa1hGRWQ3NmV1?=
 =?utf-8?B?bWJUeGZrSlBHTWx0NjFsWTEzYlpUZ1FiWkFvYlBnTkxSa2hzcmJWa3hRcDh0?=
 =?utf-8?B?NGtOZW9mcmphUzQ0OXFlY0ZFUXNmdVlMR1NhUW54VWxpM3hsODRPN2M4ejFu?=
 =?utf-8?B?dklSTUZQTXM4d0lXcTJmMnBsZ1FESFovRTFqMkx6WVo5Um1DRWx2TEFZYUJQ?=
 =?utf-8?B?YlVuUzJFVVBJVkdvNFhzeHJIdzVsVWRSM3BYbjBxa2ZzamYxL0VsOW9RMGVO?=
 =?utf-8?B?TGJoSXFPVGtkMHRyUDJNRVdjSXNUYUhEbFZINTdEU2RuUDhxeC8vaG95N2hH?=
 =?utf-8?B?eTU0bXBkNlhIT0N0VlNLdllseDRUYXBDRXBhS04yVlNKSzF0U1Zmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6831b782-8f3e-4cf0-1ec9-08df38f18459
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:56:46.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsBuXI1NMr/6ZOmT634dofJ4M2/NAQauJBIo9BUio5NQZngJNljy6Pn5nKKUpNQp82jIVqEZBY+F2sLzkMv+iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366



On 10/23/2026 2:16 AM, Mario Limonciello (AMD) wrote:
> PerfOpt is usable by integrated GPUs in identity mode. Enable it from
> the IOMMU driver's domain attachment paths instead of requiring an
> amdgpu policy knob and exported enable/disable interfaces.
> 
> Mark supported integrated GPUs as PerfOpt-eligible when selecting their
> default identity domain. Skip GCR3 setup and ATS/PRI/PASID enablement for
> these identity attachments, then enable PerfOpt after installing the DTE.
> Clear PerfOpt before attaching an eligible GPU to a translated or blocked
> domain, including unmanaged domains used by VFIO. Propagate failures to
> clear bypass, but keep a completed identity attachment successful if the
> optional PerfOpt enable fails.
> 
> Clear inherited PerfOpt state during initialization, including when a crash
> kernel reuses device tables. Read feature support directly from hardware
> because cached features may not be available yet, and stop initialization
> if the initial clear fails.
> 
> Each IOMMU has at most one PerfOpt-eligible GPU, so track activation with a
> boolean under the IOMMU lock. Preserve this state while clearing hardware
> at suspend and shutdown, and restore the bit on resume only where it was
> active. Do not enable PerfOpt unconditionally during early IOMMU
> initialization.
> 
> Remove the amdgpu parameter, driver callbacks, and exported interfaces.
> Translated attachments retain their normal device capability setup.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Looks good. Queued for rc.


-Vasant

