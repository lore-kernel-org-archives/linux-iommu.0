Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47235E534
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469169; cv=fail; b=g/qBV7lwceD8SJAluCCVdToGlaXF4GQL481oS3hDSpmtoLUUEdgcLS696cCmMjpVaa5DDLBhHjJj13aJDBLjN4h81vvJ3Sawp8ZmiciboqTOYtXyTi7jnqy6ba8uTEsdsUB8gpvehZL9cptS09dbOfbb0V6c+xWvEkGEBsPW5pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469169; c=relaxed/simple;
	bh=jGv45J5iPUrFnGIEp+UVqOlxpOxOFjhtpxksgqkzkSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eg8PFDHxZNyp9SU7jp6ehu7jPgXvNCv2+5S5hv8opcrpH2LbwEhrvxPn8NPi4djBPcxDt7yJ1XjiH8PyqxcaKQtRTDYX3NhNr7Dv0a3adhy6je18D1HjHlVxmU7hA1mGeoVIlF8OUFXfA4e1Wh4CF4UKn7Pxbdy34pU3bK4zMkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F/f2iupJ; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F/f2iupJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UckqpP9qdoAnv5j/W4ZYa3sNWnmpk57MIV6t/J6X+bFTZJUTVG93iwLVNn0qZ0P0peG9B2DR2ZjV8wiQZ9mTeuJoMFSb6YRQKGg1qKg1Ib3RDq3gcY1nbijw3gQRgGcpjyVqurz0jmCoN1hyosyhdCrgmTX1FVhaG9NfqCJwMXTHv2dezRsNfSPH6PMahzFH01vWMGVbHwsdrBJGEbTfTWIbN6f3bJcx3g18mASIttAXLTjFPnL6ayDNjrGAt9UTX3N+PfhN8M/y8TEqfGqBjrvINOuL+WquAqyUrlwZe3i7ppGerMouHh2Fx29UWoLB1n72m4WWfPGzPGY79s62Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gco7WTBGTWpHLbi97ATCGeoaCjZXDL/s8tUFwImCJfA=;
 b=ynhGMMPHZdrcKAmBxkJQA6PGL+KnX5vBpxXZ0OjsrM+igkthfThEuqWHnBnolG7SSmKvpTiyz1BS+DFc21AjuSXDFb9+VN1taa568WIiTaQuM49XTJQjTd2IGk47G9mgRy+mxE78BRxvnK+3cKPVw7KJcnqABv3FK6Pey57U5CBTw7olTa4gR9y2irYb6VwRXtA+5fAvVLIgkoPNSN2REsoOFC0s3A6/tpau3aMyg911n32yVRKbor/HWdHTH9jofcKanRS4sgg1jBehNUR7q/AizpcYwaD37j8C2jTHg99dHNj+HUQPho+pWamEtmvevv40T5ch3DhfG1Z4sj+A9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gco7WTBGTWpHLbi97ATCGeoaCjZXDL/s8tUFwImCJfA=;
 b=F/f2iupJuHkYZ0RpiQoJukmqICNXlMeXcDPYF/xuGTYDlaVsCqEfAjNqI+vZBlcSHqgdN4uEP1JRbDgpbRInCaOYPDILjJCbLwXoP2/Fb1GQMypZzTMwKgWxEcoYGvRGAxYBQPapWd4f+5wCUJ3WSDyDdgKc3LbUI2BokZr2cl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Thu, 15 Jan 2026 09:26:05 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 09:26:05 +0000
Message-ID: <0e6444a6-b27a-4fd4-a948-61a0930602dd@amd.com>
Date: Thu, 15 Jan 2026 16:25:54 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/14] iommu/amd: Introduce gDomID-to-hDomID Mapping
 and handle parent domain invalidation
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-12-suravee.suthikulpanit@amd.com>
 <aRZBN/nBz6lqTzmt@Asurada-Nvidia> <20251119000217.GG120075@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20251119000217.GG120075@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af2a16f-e7bd-4da7-3f5d-08de54181b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1BQNm9PcWdTN2ZadUJGMDFBU2xOdjdSYUdMSUYzM2t5NzBGbGp1VXhDNUx3?=
 =?utf-8?B?ZzhybkpQckpMSmt0aGlHRzNWVCtnYzlXVW5JamZWZ1daanBpbmpqUzFwVmZI?=
 =?utf-8?B?Q0U2TDNlZ3RXZzFBYVV5K3NCMERnQkd5ZkZ1Y1hDcmVlWDVGSHFDdDBlaXBC?=
 =?utf-8?B?c2YwTEtVbkNKQWFvSGJPakg1c0ZtY0ZIazdJd1hxUHowWGx4ZFRNS21YRERW?=
 =?utf-8?B?enBPUTFqYjJzWlQ1UTh3SlR4eGs2V3M4VTN0cEwvL3MxdDI5SDMzcGxXa2Zu?=
 =?utf-8?B?UXhoUzFvQmNNSDRLNnZzcWZQMWVQb3NIZnpUNk8xRUdIclVhaVRuNDNpMDNr?=
 =?utf-8?B?K3BxSVdaSjJRaTZJSmlOeVgrVjRjakNGSmNRRDlFTDYyL0hzU2VNaC9rbm5C?=
 =?utf-8?B?S2pWRmtGeUZRRDZKMlNVMlBOYVRkR3B1NmNpUVVZRXMzS0ZaT3F3YTArS21Q?=
 =?utf-8?B?NE5ZcjNLaUU3aDE1N29SY2lvYnpNWTNLUWx4UHFYMktyT1hJcGFnL1BxUW42?=
 =?utf-8?B?TXUwckJYbmZxQzNYYWUxZ09Dai94WC9DQUNoajR0T00xZW9ndCtBdzRLNDlj?=
 =?utf-8?B?S2Z0UkpFYWRSbHdEMU5pOXhxejlHRHc4UW44UXpRRVk2Q25pWFVTanJDd0M5?=
 =?utf-8?B?SkphR3h1aUltZmdVY1k1bEdYb1NzZmZwaXV2aUlxRkRwUEhQdFlBRkJjWXc4?=
 =?utf-8?B?bWMycHJ4UWJ3b2NtSnNmdllleEtuNSs5WXRhRkZyKzFUbnJoQmJEY2ZscnZO?=
 =?utf-8?B?SGQwR1pYMXUxYlFIbzYyRXhDL3pDT3BObit4TFhKRSthSVNUTnNTSWN5a0dj?=
 =?utf-8?B?d2podG5tQk54bGxnOUcyZThBNmVWakVUMG8yL3J3RUx3Z2x3b3JUd1h0SGtt?=
 =?utf-8?B?QVM1RVhKaDVONnppVlp5c0ZzSUdVYVlha1NQeG9mcnpaV2sxTUdDZXpxMHIx?=
 =?utf-8?B?dUtQTGZVdWpUVldCMG5RYk5xZm9nOG83YXdpRVJsV3g2QUhwNXJpK2FpVGp1?=
 =?utf-8?B?b2NxbGRTcm5MYlE0TXREdVBZMjRVbzN1dnFFa01MR2xMeTZRUDdPU0t0UTRH?=
 =?utf-8?B?TDdxaDRvZTVLaTVWNUR6WHNIRHZlZURVcnd4RWhFZ3ZDcUpaZ1JHbUs1WFdw?=
 =?utf-8?B?b24yUXAwQWZRZkVCUE0zL1dFa01Ndm5FN0YxSHB6dGdKQXJQOTZ6OE84MGlN?=
 =?utf-8?B?enNKaEhBb1cxRXZYOVltVjZNQW4rbkVjc0ExTmN6d0ZFM2Faa3dPZ3hnU09x?=
 =?utf-8?B?bmx1MHpzd1NSMFhoSy9MTWQxL1dFalRvWUhxM21RQUlUZU1YM2p4cWdhb1Jw?=
 =?utf-8?B?M2xVRm5nTkt3UGlxK2lEUEdVK3FJWWtjdXV5VHI2WGt5c3Y4RDJ0N1lXWE5Q?=
 =?utf-8?B?a2tYbWRZd1BUT2ZCTmpCTTNYcy9PZGtxNlF3SEt5Z0xhcEtPTktMNHlpUmh0?=
 =?utf-8?B?NzY1R1hWMFZxZGtPMzBROWJreG84bXVtSWI5STd6TlpTTDlFZWhETEUzWE1u?=
 =?utf-8?B?eWNaUkdHUFRlV3lUWXN2Q1FLVmxvUmJrWE93SUNobGpxRU9HYUlGakdBK1FQ?=
 =?utf-8?B?QWF3YWthTWJZRnpZclp0VUJQTFNIZzJFYXdtYW9INW1XbTJHUms2VjNibkNP?=
 =?utf-8?B?OUV3aW5mRHdBMTloaE9XYTl4cGVEZVhpNE5IekpwSlh6djQ2ZWJQSzg2OU9G?=
 =?utf-8?B?M3NRcjB3STV1YlU2MFRndjRLUW1GaWJOVjdKZFhITVRXMEY3Sm83bHNYYUtw?=
 =?utf-8?B?YzdWUmdYeTRXZExpUmFhTWlKZ3o2VTE1cVhoV01yNEpxeDkzR0I5SE9EWEtp?=
 =?utf-8?B?OXhTZmFUT3lueXVNNzh3OFVxUkVkRnRLSVYrL1NqUnB1dE51R3ZUQVVjWGNX?=
 =?utf-8?B?TTJNM3lMSWFGdDV4bG1QczQ3YTQ0UDIxZHhYVW03NEtxWGR0djVXWjNBYjMr?=
 =?utf-8?B?dXdiY2NQZGxWTk9FR2JrRXkzS1B6OENaUGtvM2FwYUtRVmVGRnMxV0FsN3VN?=
 =?utf-8?B?Z2IrSVpNQk92NzE4ekZET0xiV09xN3gzODFvdTdrNHoycFhhNkdYYTZLT05o?=
 =?utf-8?B?TUNJV1NmeCt4TmtmMEltaHZWT1ZleSt2bnY0d3UyUEl3ekhBQVlQSzVzUTRh?=
 =?utf-8?Q?HRbw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHpmYkFLMm5QaEgraTZBMmU5ak1aM1VoSUpnZ1NJcnBiSGQrTmxDVDBCeDRV?=
 =?utf-8?B?Wk5rMUpjbzNRcDhoUVFtQzRNK2xya0YrUURTeENDUUxKcGV3MVVRN01EZm9H?=
 =?utf-8?B?cXlwTE03ZFlrcGJnR2t0Nk1YOXVwMGl1SEVsN1NFalRIWmlqRXpyVzBicmZC?=
 =?utf-8?B?MkFVc05YYUdqUFI5UGRjMUI3dXZqTkpPK0VwTDBWMGpHbjN0NWxtOGRuUGx6?=
 =?utf-8?B?SlhWbnUrRk1OMVUxazVIMFV4VGdQTXl0T1VMN1ZBM0dQNUlnUFBoVzZGUEpC?=
 =?utf-8?B?YTd5dkFGTGxCbE41bUJoc0hnRmcydm9tTGJjeWFQNXRUWDN6T3U0a0t3U1Mx?=
 =?utf-8?B?d3JISFZzTzA2dE1BdkUxQ0NlLy9XTWJsSDE1VHNhNUNxRWFiMjBHS3JCT1N3?=
 =?utf-8?B?a29PSEpvTUFmWWhxUzFoZzhvRXoyY2x3TFFiWGZ6TlhYVys0OTJSYkM1WVBK?=
 =?utf-8?B?UFZmWVJ0QWFoc3NFY3ZOcHFjMGwzTys3WE1OREM5YU01L1g1UjRwamN5K0o4?=
 =?utf-8?B?NENjcmN2WHNNNkwzMmlNK1drWFpZV3RRY1dFYVNOSnZZNy9nbHdLd3ozdHNn?=
 =?utf-8?B?RjE3QWVkZ2VhS0ZFWGVzQSt6bjk1S1h3WVFOTnlySURyMHdEUVErNVpkN3c5?=
 =?utf-8?B?ZXpVMU5hNFpnamRjSlgrcnk5VUtaUXF1SWllZVAvckNxTEF6dmlvcEN0dldC?=
 =?utf-8?B?TUQ5ZUd4K1E5ZHV3T0hTcURPak9UQ2krSy8wQVJxSC9md2prZzR2akRTYjhM?=
 =?utf-8?B?R1diaGdOZUJWZ1NPdXhGTWRWMWl0TVFsSmRMNFVrMDZBRVkxcHpKYVVzWmJh?=
 =?utf-8?B?Qy9EOTZIbzV1Z2drZWcybFJXQS9YQkhkU2lTV1JGSU9yQTZzS3hZcWszanBI?=
 =?utf-8?B?VXcySnk3Y3FxKytRVWVvRXBCQ3ltVElJamdBZittUEYzdEFJMEJFNDZCK29s?=
 =?utf-8?B?dVEwZEhVNmQ2c05MZ2FqaGM5eHFrb3k3N0c2c2xmeWYrU2MyTVhPVjBBWlpC?=
 =?utf-8?B?aVZzQ3RvMTZCTzZNQksyekJlZjc0bFNIdUs4aHpLWjNYREwzSkVydzM2RVVm?=
 =?utf-8?B?eXNWS0xRNlQ1M2dsUGNpM1JncFMzVUtrbFlHOUdaTXZTZHkrbFhwdnM2cHN2?=
 =?utf-8?B?cWN6UVMxMFJDUDJGU01RbnRPQUFFUnFzR081cmF2SFF5WFBpUTRtZEtQNmdz?=
 =?utf-8?B?Kyt5SFFzdEROWEtXSzByeWQvOE1temExdGdsSmdlNDdlZFU2eW9PdUpZalVL?=
 =?utf-8?B?YlF6Tmk5cmFBbDZGQyt6OHJuR0VpMmpRTWxpZUs5UU9KM1FpcjRUVzRmNEVG?=
 =?utf-8?B?bzJRemZDU1BSMXhhUTBVcFVIVXlzUFJ6b1pSRmxOZzNhVFJFdjdWRmljbGVE?=
 =?utf-8?B?ay9aN3FSbDZuVVpMMDlLTkxEZzNsSC81aVp3M0VvUWprb2dtQk5qWjJHWG5V?=
 =?utf-8?B?eGViOGltc0xjeXp1aXZuVjUvWHltZFNGbmcyY3pDR2NkT2I5U3QrNTNpNHFH?=
 =?utf-8?B?OXZNMmxyVWhYVUVMVXd0WWRxaHpVdWRDNkNlTkpLeVVnODBTRGp4RXY3SmhW?=
 =?utf-8?B?OHcvUWR1b3ZIdmQweUx2SWtlSmwwZndLTm5YTzdBeFRYSnlSY3dvMnNjZTly?=
 =?utf-8?B?cStWOUlJaUEvTTBNVFJKemtRZ2pzWDZka3pOKzFLc3ExUjJBUlJJekRxazRu?=
 =?utf-8?B?OG5odW5rSWRjTm9hOU44SldxRnF3QWN6dGVyZ3hGRUladGxPbm9tUmFZcjZN?=
 =?utf-8?B?dk9malZQRjBOWk1EYzlDS285M29BaFBXclltdlN0UFJoUkJBVjZPK1JWQVZS?=
 =?utf-8?B?UTAwbTdYRG9xSE5tNmVISXdzQlJZeTg5YkhpRTgxVy9aNlpnejlrNzNCeDNw?=
 =?utf-8?B?SFZOYkdRKzZNQmNtR0FlUXFTN2crN29XUDEzV1hmZlZPR0dVQjBQQ0VVb2JO?=
 =?utf-8?B?VTRMcGNMdlR6UkV6SnRFU2s2QXNrbDUyOHdnMG5ZdWttTGNJZUk0QkRvQk9y?=
 =?utf-8?B?WWZraEJLVFQrc1ZpOThmbytCaWh4QW1uUGJTd2t4YUdPaTBndlJCMG5TWTBz?=
 =?utf-8?B?b1IwRmlWNXFjMG5tVHNQMHhBcXMybVhlZC9tZ2FKL3FQVGNsNHlYNmdGZ0lI?=
 =?utf-8?B?R1NVdVY5T2VuWWZmSi9RU1JKR1o1OTlld2R1KzB0UkFlUjJYS3RCUjI3NjFR?=
 =?utf-8?B?dkJETThIZGkxOXBEVWE3SzJRYmV0elpqMkovY3BOa01uWHJMemFTUG9tWFdy?=
 =?utf-8?B?Nm9TWW5JRFVFaFU5L1dFck1tNXZmd3hVQWtHSHdhRlFkWHdRaXZRdTI3d0lL?=
 =?utf-8?B?TFBJUFA2NW5SbFZQK2dGMWtFMm1abGhKelY5VXhXUlVVaGRCOU5yQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af2a16f-e7bd-4da7-3f5d-08de54181b51
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:26:05.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvFra6BHLD9vc/TlsMxieeBBqM4x6cr88hu4G1kmr3Fe4/MMSimzxJoDD2Tiwb2Ckpv99ExTlmB4VduHioaMkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607



On 11/19/2025 7:02 AM, Jason Gunthorpe wrote:
> On Thu, Nov 13, 2025 at 12:36:07PM -0800, Nicolin Chen wrote:
>>> +	curr = xa_cmpxchg(&aviommu->gdomid_array,
>>> +			  ndom->gdom_id, NULL, gdom_info, GFP_ATOMIC);
>>> +	if (curr) {
>>> +		if (xa_err(curr)) {
>>> +			ret = -EINVAL;
>>> +			goto out_err_gdom_info;
>>> +		} else {
>>> +			/* The gDomID already exist */
>>> +			pr_debug("%s: Found gdom_id=%#x, hdom_id=%#x\n",
>>> +				 __func__, ndom->gdom_id, curr->hdom_id);
>>> +			refcount_inc(&curr->users);
>>> +			ndom->gdom_info = curr;
>>
>> This looks racy..
> 
> Yes
> 
>> When a gDomID is shared between two nested domains, a concurrent
>> nested_domain_free() could enter before refcount_inc(), and call
>> refcount_dec_and_test() or even free the curr and ndom.
>>
>> Then, this refcount_inc() will blow up, or curr/ndom will UAF.
>>
>> Actually, I don't see where amd_iommu_alloc_domain_nested() gets
>> used in this series.. I assume AMD will use the iommufd's vIOMMU
>> infrastructure directly which doesn't mutex across nested domain
>> allocation/free calls.
>>
>> So, the entire thing here should hold xa_lock(), use xas_load()
>> for the existing curr and use xas_store() to store gdom_info if
>> !curr, and xa_unlock() after gdom_info is fully initialized.
> 
> No need for xas functions.. You can use the __ functions..
> 
> A helper function like this will do the job:
> 
> static void *xa_load_or_alloc_locked(struct xarray *xa, unsigned long index, size_t sz)
> {
>          void *elm, *res;
> 
>          elm = xa_load(xa, index);
>          if (elm)
>                  return elm;
> 
> 	xa_unlock(xa);
>          elm = kzalloc(sz, GFP_KERNEL);
> 	xa_lock(xa);
>          if (!elm)
>                  return ERR_PTR(-ENOMEM);
> 
>          res = __xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
>          if (xa_is_err(res))
>                  res = ERR_PTR(xa_err(res));
> 
>          if (res) {
>                  kfree(elm);
>                  return res;
>          }
> 
>          return elm;
> }
> 
> Call like
> 
>   xa_lock(&aviommu->gdomid_array);
>   elm = *xa_load_or_alloc_locked(..)
>   if (IS_ERR(elm))
>     ..
>   elm->refcount++;
>   xa_unlock(&aviommu->gdomid_array);
> 
> Needs more bits if you want to use refcount_t

Thanks for the guide. I have rework this and sent out V6.

Suravee
