Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADD346782
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088697; cv=fail; b=eDkBD5dY55OHUNdmV+BAunLbuICGUyqxYdC2j9jzWJX5O05LBhGTFZCqmaEMQtYneMOYRhTqo9ASzoFTKUdi64+LK4GF3LVGAtdkI6DV/f5cUlI0gmgHDkZgav6Q1PoWfaRGocYWRqIhwRDIOpHnJqgtx+vg+t7o3TKQ0QEObI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088697; c=relaxed/simple;
	bh=vUyqomx/3I5GwL5icUzbF9PxRuycHB5vEFyKw0Kekd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/q9U/cy9xb7c0CAry8/Z2sB79MTlribtThG7JlskEg6sSUbuG535kEyW6Eggh8K3x950dWVYkIkH7DX1dBWHt6xJsbBzMWZPPp9pPZhzwGcgvrmWTR2309GMhU6Kz10fLchfNWhKqce9B3w1Qz8Qk2eogIzNgG0tCzJd8EioLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZWQXDyT5; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZWQXDyT5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ks3lKE84kGs61apLqiu8AIS4jUiBuwHpS3Vnfi3muhMhUonW1yPORiTOHD9ql9iYIqwebeXG4uushduXC6jSAG84weNni4YSamcLDRqJSIqwtyx1zCGjdtL57Bx+8IrLnLfGE2Sj2nZCE5BAB6o8saQcwKys56aoBPSnFJ80Bp4HZNyCecgEdYcET4mbvuFzprT2ejX770DvUllqqsaJ6mm4xiwiQSdZ/ea+VnYi69L4EcByGTDT+cIwr29Mzm4Z8e88/o18hbcCwglRtED2IQHJizYoSkXZ8sOq8dSL2ifYoptRcHXbDIldOJNxnULSi56CFhC5GrUbv5ek/PAxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfv9Yf2SpTCMF8EcpVxIJYw8fFNfVGK/hPh4Wu4VJOQ=;
 b=g7xLrjiPnX3y3/bnbGfDrqJ1RTS9rHjpjLs5LVLMIoimpJBGDM6b8B/F6jaVpDi9UFlCfvnFO48vCwpzDVZEdCXGWx5wnlYxjWLRw9ThA5ciUP1letRB/ysZlhTKLu2HlpA/2Xa14JhfgRDGkwcuTuWb3ANaAhstEsDxKtEiZFlIFZF5sfgsS4rxmpq7fcdBld6f6vMxD+uVqxPrb9J8GGDW6d0Plgj89jbzgDef9LnrC10K5exUazgvSiyLHkmGasGkBqkBieV5lQBPu/3sYousvPtxjc8DTkcq+VCZbTC3JD5iRysZwsVrg103r+7CDhdxKitfCX9if1xy3YLmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfv9Yf2SpTCMF8EcpVxIJYw8fFNfVGK/hPh4Wu4VJOQ=;
 b=ZWQXDyT5Rg2W/dRselkrkP/jYEhpyUSmXcDJCKM6ylQ4t8mULEShjjDt0sTPBvVgxKpcNWpaydcwmij7CeH01qSUqFVMm/Q8TvdQVnUsbBdIJ9nUfuYp9y/bbNMHlRQOtRZ4GMl54YXqp/nCivFdSh+i6tHNv7F8yLO4cKCY01C3LDLpS8tboMeLahE62ie8T+hp4kWM48/sptp96hjymAkq1J5Mpk8qBj3RNJuF23WLqh+MzcbDfMu5AThaN6GO3Bm9z2j/RZkLpoMHpPASdKFgWnEbf4We7EtHgA86qifjU4iu/OiarJuLTz+H1sQaKfn6DgfVkIr7mLFF1CeEkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 13:31:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 13:31:32 +0000
Date: Thu, 22 Jan 2026 09:31:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>, iommu@lists.linux.dev,
	intel-xe@lists.freedesktop.org, Joerg Roedel <joerg.roedel@amd.com>,
	Calvin Owens <calvin@wbinvd.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: Xe performance regression with recent IOMMU changes
Message-ID: <20260122133131.GL1134360@nvidia.com>
References: <20260121130233.257428-1-francois.dugast@intel.com>
 <20260121131135.GF1134360@nvidia.com>
 <20260121180449.GA1490142@nvidia.com>
 <aXHAcibp/4pUB8f0@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXHAcibp/4pUB8f0@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: MN2PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:160::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: e25c685f-626e-46f7-fead-08de59ba8ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NldDNGN5bm9pL014YUhKOHlMRkRmRGZvNUp6aW82MTVDemZKeDlydEhIVyt3?=
 =?utf-8?B?aGc3ejRac01ndkgwcGl0Tm4zRU9aZ2xza1dGYmRYZ0F6RWplWXlNbXZwWjRK?=
 =?utf-8?B?c3dNTzZIVks2RVVzdnN4SEE4MDF0MGFGdzdaQVhoY3lhSDJnZnU0b0srVGFw?=
 =?utf-8?B?Rm5VK0dXQTBSYzNZeUhodFNtWnl2aTYzcW1HVDBNSzJISkUxK3AxdjRkTjJr?=
 =?utf-8?B?K3Jab25VUVphZDBRWW1idkhoYlA4NWJxR0dYaGZSVUdFSk41UnF2SWVuVFdj?=
 =?utf-8?B?d2t5ZE5Vb0VoMkZldTZzUW9PQzJ1OEk2Z3hEbHFXeGFSTDM4dkVxUFpQV2pJ?=
 =?utf-8?B?VDNob0lHdmhXaW5KQ28zbGp2b0p2dnE3OUZnYmJmRE5rdHBIV2V3SU11RGNG?=
 =?utf-8?B?dVJNUjR3STE3eFBUYVV1Z1dzUHBBd0FxZVJSOEJHWnJ1UkRWdWVKb0gxTy82?=
 =?utf-8?B?ZzNzU05IZVN2NDVWZHZra3NpQnlFV1VzVHFRelVJLzYySmZpSnlOWk9QcWNu?=
 =?utf-8?B?eWk2MXlwKzNka3lFaTkxRnVpeWJrQzhzc0ZtVHlDbXdCQzB4N3Jud2V2ZHM5?=
 =?utf-8?B?SlI4a2lpQkh1UjJQUm1BbEUrYU9xckdOQSsxMzlhZUhOSjlTYmwzZ0dkZ3R3?=
 =?utf-8?B?NGtldVdKVTBuRlo4aFc4UHVVTm55TnVORFBYU0hycUpaN3psbmlDQnMvY2NV?=
 =?utf-8?B?bG5EMVh5ZmtpV2ZTZTBUaGpaS0RDWXgveUFBczRXVHoyMlBET2FvbXc4Z1A0?=
 =?utf-8?B?NzRIRm9WbU1XWkk1LzN0RkhkUUJYdDJxOERrRDd2RjVqZ054eGsyYktFM1Z0?=
 =?utf-8?B?MzF2WUx0dXBJMlNmekxUdURBd0J1MmtEVE41aHlEbGxJeHpkVUdXTmJGM1JN?=
 =?utf-8?B?UXJrNVpiN21HamRYVkxEYTc4NEpXOXZZT014UDdqbjU5SUVIZ2RtNmJTc2c2?=
 =?utf-8?B?Rm9BaFNDdVUyMlFCTUswV3doblBMK3JRY1NqWTZ5aE1BY3JpSWFJQzJVNWJP?=
 =?utf-8?B?RFM3MEZ4RWYzK0dweHJ6dnFlS0dlOXl1dUhJNXpENFh4M2ZqczVidTEzRFlu?=
 =?utf-8?B?YzZFYUlEdG8raS9JU3E2c0RNV3hvNk9rZUFEbmtCQkltSm4wZ3BZd1hyK2o5?=
 =?utf-8?B?VTZFR2FTVVMrb0lPQnIwYTgwYmdWNEZoL1Z0MWZ3WW82ODAyUjNTdVc0MEhM?=
 =?utf-8?B?RUFTTlppUkdhYlVkVHN1eW9wSXVTK3h3SDBoc0xXMVFJZzNVTDlrL1BDT1Z4?=
 =?utf-8?B?ZWpNZ1liRHNTcC9Zc1g5YjFlSjlOR3Y0SE5hazF3ZzdGZVRlMXFQUWxRU1dp?=
 =?utf-8?B?YW9BY2t3ZVVxaDBUY1hqcldIbXpKeG13VkhVVU9PZnB2M3VoY1JacFdLOGg2?=
 =?utf-8?B?akJKS2NtVFBhMG0xT3pzSVkxL3pDUWN6OVc1aHFKYzU1TkxwT2ZRU0YyK1JN?=
 =?utf-8?B?cWFJcmRwemNIek12ZUhJbmZMRDZ1QXNzSERJSDNJQ1lEZGJQYlMxL3puSWI4?=
 =?utf-8?B?c0F0ZkJPNzJUSzNkbTlrcUp5dnFlT1oxY0k3YlFCRUZ2VXpDbW5FS1NJOW01?=
 =?utf-8?B?WmlnWXlVQVNlZjZRcnRQWVFSUzQrSFFQc2RzRzRRY3N4SDlobG5obC9rbHVp?=
 =?utf-8?B?a1FHQzF3R0RBNFVTTlVzL29oVmNISi9pMHlncE8wd1VCZC9MT1dCV014RGJq?=
 =?utf-8?B?NXc0U0hvS0xjcDVmOTJaZ1I0UGZNTlJtZ0N3OVNMcFh3MkY3STlrNm0zK0RD?=
 =?utf-8?B?aEJFbmdnQzl1TFJncDdRb2MwWHB0QUwvS2VsMjVCZ0xZTmxkc0dOV3lIbGNx?=
 =?utf-8?B?aitOZUtKZWhFY2hJZmMxRlQrZUNRWnlRdXp1ZCtkZS9sRm1lY1VSMWdkMzVK?=
 =?utf-8?B?NkdHa3RzcHlVdUJwM1dsNUVoQ2JLWERCdjZBdnd5eE96bjVHWmVSQ0g5dW51?=
 =?utf-8?B?NWVYTE9MTVdhYmZBK00zL1JQbE9wU3NSZWdmK0dNZHY5ai9lQ3RGUkRvOVZC?=
 =?utf-8?B?WFJMdllQaWxXSWE1TkVieEhxbGI2dVg4L1hWMUljQU9aZEtvZ05oSGtIajJY?=
 =?utf-8?B?MXdRUW92cHNFRTkvbFFtLzM0RVFEVkpzeFd0WHV0Z1UwbXBoRGpvZkQyTUdo?=
 =?utf-8?Q?N/Hw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVdNZkpXMmFEc1FSV1RvM250ZlZZQllVa2hTVlFxeGhLNWdwaGphV1NlbjV4?=
 =?utf-8?B?SEYwNnROT2gzUm1DOStHallkTE52dmV1VDRSRCtjNnVxeHcvV0lySTVEalMx?=
 =?utf-8?B?WWZUU1R6MW9FYUNuK255NkRnRkVMUFRSRkpvdGI5T2YyelMvWkc5L1JYWU5P?=
 =?utf-8?B?aExyTElXWjh6b2lGa1lRblJicjdVck10RUtQSGRmVVBTWXB1Z0lST21GZ3ZJ?=
 =?utf-8?B?c1VuVU5PaUo1QkJaWE85NlNCN3c3aDRrSlppS2tybFMrelNONkx4NHBJNS9W?=
 =?utf-8?B?cFY3NzI5bkY0VStsYy8xZjdKeUtvTXJoOWo1RWpITkRqVGVwTDlyaUsvcC9S?=
 =?utf-8?B?WEFBVmVOYWJNenFiVGpoTEEzZk92TW5zdkNDVXg2d3FnM3NtQWpWUmQvS1c1?=
 =?utf-8?B?bERadlFXV1BCT2FTNzhNVkpwZytOVUtqUGd5dURkM0d3Y1ZTZG5EVGN6a1VV?=
 =?utf-8?B?Qkpic1lsL002UFVENkNyTVl6Z3dwR2hvdzczL2U1b05oL005RlhpU0k1c3FY?=
 =?utf-8?B?dDQ0bVZpREtxWjFodDYxY3JEc0pCRUpoY0ZwV3ZPNlZHbWduYVcxd1AzTTRT?=
 =?utf-8?B?VjFiWVBRNFBWbUlRRUFrSWNSenU4QkZHdmV2d2g1cFFmbzNnTUNFNC82N01Z?=
 =?utf-8?B?Rlg3Z21ZaHdabnRTMjlaZnk1NWpRODlrYUFnTlRtcGNrRytaKzVZN01KWFdq?=
 =?utf-8?B?aWJtUk9OQ25pMzd4Y2tqQk9RNzVBbFZvNytBWDlLY0ZTQjhpQUZseTVYekRO?=
 =?utf-8?B?aDBlSWxBaWJsYjBjck9LNy92TUliZ2hzMlpPdDlaN25uK1QvS0tqV1c4U0pK?=
 =?utf-8?B?SXNwZlZHMHdiMjFYcWpsK2x4cFZsT1VBOGh6Y3k1cXVvYU8rUWdDc1gvQUlv?=
 =?utf-8?B?bjJjbFJCY1BzZFR0VXpTRkxLbE44Q0xYTWZaWFp1UFZUZ2tGRDEyZnNCYUJ5?=
 =?utf-8?B?cVFqWEVleCthbEZEM2FSaEp1czdEb0FTcGdVNmF5ZDJZNE1ZSVk0TVFYczZh?=
 =?utf-8?B?SkpKRHFENXJCcWdBWlJpL0RzSTc1a1VRd1c4QVI1SUhNNjZNVEZtc2ZaZ2tK?=
 =?utf-8?B?SjhpeU1DQmZNWGFRdXVNR2ZiYlE0Q3JMdzlxcE4wYWZnSHRmMHMxREJJdDA1?=
 =?utf-8?B?N2pUQUdFZ0hVL080YytINnFyb0dhbjV0UDIwaENneFRlUFJhaVJpc1g4M0dq?=
 =?utf-8?B?SXVyMWI1TUY5S3hXV2JZS3BtMDJLQnIwZUhqS09WU1dleDJJUTlUem9JY1hR?=
 =?utf-8?B?MmUyVlBIanBZZTU3b05PUjdINVhrcFZEeTBqbkM1TXhCTCtieFRkbjFTaW4x?=
 =?utf-8?B?QzYwMW96WW1zOWtWa0pxWkVtT0toWjRGZTRTYVVud0dJZGlXeXpuTGlQMkcy?=
 =?utf-8?B?YkdScDhyWG03MllWcldDQ2tZdEExNWtBTFc4R2tJWnhpaE1MK2F6K3NuWjVY?=
 =?utf-8?B?S0ZPQ0duTVZQNVJQUVJFNjN5RkF6ZFNKRzd5MXdPUERsQklzNllhWi9sRVdB?=
 =?utf-8?B?WWs3b1NIdWVZcXloNWFOSnhQUjdaRENiZURXek00cEJHYnovSmlveGNRWWcx?=
 =?utf-8?B?VFgxUHlsVWRIb09WNktMcTYvSEtrMkRiVWZGVDZrSW5PTG10RVB3RVc1QWVC?=
 =?utf-8?B?d0lrc2l6YkhqRG5zekdmU1RSS2Y1SGpEbmNkOHRocDd0NlhQN29Ka2hHYWho?=
 =?utf-8?B?QlRBTkVsVE9yNFliY1VIdXE2OE5lTlhYZTViemZCMTljWHIvbnNpZjdpSHpG?=
 =?utf-8?B?MWp4MU1sYStqV0IzUmxrQ29WU29xMVMxb3JzLysxdldEQkxsV25RelZDdzBx?=
 =?utf-8?B?K0xuZkhNc1NYZlVrYXR2dmoxQk5uRWlOakNISHpucTBSTytUaTdCQTFHTUp5?=
 =?utf-8?B?MHZDb1loaHdveFdZZ3Y4ZnJRRFZ2WEQ1Z2VybUorQWhIOVRrWVBrSzZGM1ds?=
 =?utf-8?B?ak43Y1Z5LzBRa0JjTzg1OERlYjlPd3FyYkFvMmQyVklMVGJ2SHVXN2NXTDBB?=
 =?utf-8?B?RW1nYnBMaGZpRVZxMmwvTVM3elZiT0tZbU9aWGNlb0h6VVdTcC9sU1hhbWJC?=
 =?utf-8?B?SUV5eVplUWh0aDhVWUxXdktsZ2JaVnQvYzUxU2RMSS9aS2dlUWhNRXdvekRn?=
 =?utf-8?B?em02Y2ZXQUp1YlEvTCs5Um5IeXFYSHRSNjJqa1hZRzI5dnB0YW1EcFJheHIr?=
 =?utf-8?B?emlicnZUdWp4QXZrS1F3bHRudEJZN1RZak1jUkc4R1FkWG94dDY3bWJPUGN4?=
 =?utf-8?B?QTd1Q0tBZ0FUZ1had2lJQVUwVVJPWk5RRExUdGhrNEJiWk1yd3BhZnRnNjNz?=
 =?utf-8?B?Z1haQTNVSmhKVzBkWGw3aEd0bVFJL1cxVTFXS09EenBXMEYyYXRzdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25c685f-626e-46f7-fead-08de59ba8ea2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:31:32.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KSu2Pckue4TotJKQcO27rePAm6x7aBFmIzkYclhzfquipP8fA+id7CL6U/tUZk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127

On Wed, Jan 21, 2026 at 10:15:14PM -0800, Matthew Brost wrote:
> > > I posted some more optimizations for these cases, it should reduce the
> > > numbers.
> 
> We can try those — link? I believe I know the series, but just to make
> sure we’re on the same page.

https://patch.msgid.link/r/0-v2-973a6bdc820f+693-iommpt_map_direct_jgg@nvidia.com

I also need the answer if this testing is running on the non-cache
coherent iommu HW Intel sometimes has, it makes a difference.

I also have in mind a fairly small change to make this special unmap
case speed up.

IMHO those two together will likely get you back to close enough.

And then do link if you actually care about this scenario.

> This was a fairly common pattern prior to Leon’s series, I believe. The
> cross-references show this pattern appearing frequently in the kernel
> [1].

Yes the pattern is common but virtually nobody actually uses it with
the iommu turned on because it is something like 10x slower than using
just identity mode.

I understand this is a test suite and it should test with iommu
enabled, but I'm deeply skeptical this represents actual users who
also care about performace. If they did they'd already have set the
iommu to identity.

> > The optimizations I posted will help this noticably.
> 
> I think we need to start with a revert and then discuss whether your
> subsequent changes actually fix the problem.

We haven't even done some basic investigation, immediately demanding a
revert of such a large amount of work for a use case I suspect doesn't
have users it not reasonable.

This work was not done for no reason and is bringing performance wins
for other use cases that do actually have real users. If we eventually
really can't fix it then you can talk about reverts, but given link
will absolutely fix xe, I don't see that happening.

Try the patches, give me the new numbers, tell me if you have the
non-cache iommu and I will give you another one to try.

Jason
