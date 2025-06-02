Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C421C9E8
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748869583; cv=fail; b=OxOrssWT7B3AWtYB2XC0i1QEe9hpB7shz3ytDb+NDR5pw4+ot4CpmkTE3QlnnRQDV1sydUWVmYadT3p8ubdUh1omqQ/5UeAepFJKzvi9jrkgr0rIggXphSpLSXSarchS1ZucHwf8le874h3b69KgEYR7uAk8k46/y8gvbjZDvKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748869583; c=relaxed/simple;
	bh=2WQn0y2rZ+SdCwUQ5XF7JLOcqNtla8AQAcRFLpKHOGQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QlTu1HWGzgxDtmdShciDTG7Vt2dkxGgFF7uFreqIKeNnD6+4l/bmaCjh9o1ea+/N4XdDE/lpRCqZUMcf6HAr3EF2mVkKd3zGpl6H15O3I8trUCi8ONQmcQwU1HsOGbImuaSCAY1qQ/x9v/AhSvBu8vgJp4ICuunG69XyTXVmwK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bkNOyjuF; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bkNOyjuF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wf/iOxOCDVwjiQLsajOmtzpiWdeH+swbRmuNqBMLp3dTTEkMsJ06LnvDbNn78uGL7lMPHWjRhg4yCmU0VJDZI///n7mBc3c6uBfIEIKC1WDO8Z5nwfvWFm8WhDrAFv9WHF4WnlLQ7BXp3+O6QNOWGzA3M9m4fLRAy5ZNTBXj1Lsm1Cu6Bt8F0EtZZmXCvkMXsBg9u/L2Gh67TrC6DtCo4gFzDRj2sGORDLpAUYQLHbwGy8jdlGeOKirQ9drR0PUidpjfypLgS9f5lU3pbNgP8vebtIww55lM5fEHZsB6PCjYpJAxRgRqwNL3nLAGVifXATzDRwllIPzZOBIf18T/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn8hokviY+4Lwy/I5e7uW6cKdFvZGhZ+wuewoYBB2zQ=;
 b=GUxNnR+3PsPnTaeBD7+e2adMSzBNtKAu37LqAUtcq236avGHTtSXCEe9NCr8tLpOUnqTrIuarc68BRuJ9Xyw7Bi/Spzl67/h/MR5t7PWxYleqvQG+qfTJg6QjFA31+JV/lDIaeLccOU1lpqF/FnLLirQIgytkw63zjlF7XlbTwcdMt8bCB/Vf3zNc28XQJAOZ4Isk4/+BUTf0d5xWQHgjytykdph8UeIQyVX4N+f3x4aGXVapk9Fg1HHvKnAaeMMbCALH1/F6dK780D91Xmeh/9ZU4eW7IVGYv4VSfhbQRKXnuqtbbg5lRebHnCsV/gEMx5Gwmj5Z39izU7CMD1w6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn8hokviY+4Lwy/I5e7uW6cKdFvZGhZ+wuewoYBB2zQ=;
 b=bkNOyjuFVJVdtsRuVOj8Ko07A/yF9JVjHzkilZ7xmVxON5R8xNHDCsZv7nmSItUa8y0bXSG3v300xiSFOcTpDbdQv7qzU6SMdQCPITuGQrrWN2w8zvx18PB2iAR1YnbcePF4NTVGUtkOTkCcxJ26iBCDjrrjDrTXIilELtiNEbgdy4e8CcXmLZlGXpwf55ImzgtIHdQbyVB5E9mnPcgfmdteKQd4Yx6nlJvieXZCHG0MUm30qyjEX2+NfFBc/vGrI310TME0TwgMvHg/TX+v/zBNE8vdnDMmebZq1B8c9zDBmJ7LYn2WNAFavHFidev3EBB+LRBlQgI4ptM1LYSzsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 2 Jun
 2025 13:06:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 13:06:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Jun 2025 22:05:53 +0900
Message-Id: <DAC2ILD2DSIZ.3TF8W39X5DDH8@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Valentin Obst"
 <kernel@valentinobst.de>, "open list" <linux-kernel@vger.kernel.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>,
 <rust-for-linux@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, "Petr Tesarik" <petr@tesarici.cz>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Michael Kelley" <mhklinux@outlook.com>
Subject: Re: [PATCH v4 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
 <20250602085444.1925053-4-abdiel.janulgue@gmail.com>
In-Reply-To: <20250602085444.1925053-4-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: TYCP286CA0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb1046a-9e84-41c1-b6f5-08dda1d64318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFNCZjc4Z0Nyd1hpaHlvM2gwYWo1MUhSSGczbjlkQ3lnNERaUlZWZ2srQ2Vr?=
 =?utf-8?B?R1BNbVNYR1VnREJmeTAwWmhaT0F5TUlQZlNGNjZzTzhVQ3Azc1NvSXlYN2Uz?=
 =?utf-8?B?WUxtYkVGYmdKNWtiYUhPUjJxcnNuR0pWWWJseURlVUdBdUs3U01zaFk3OHhX?=
 =?utf-8?B?QVlKSnBXeUFIZXlRMDJnc1ROQUJCSFlSMisxSEZBbUpaZUg4eDBHUlZienJk?=
 =?utf-8?B?Qjg1bDZ0U2ZveE9MMEZlcG5jWXZ6MGdleEhDM3NuSHZFUk1hQkRyWDUvaS94?=
 =?utf-8?B?STg5SmhSdS9iVCtaME5wQXJxRXFPSVVycjA5TXFHZUN4eXB5QmhtcldvN2Vz?=
 =?utf-8?B?UFBYQnVXU1IyZTk4QktGUlZUS2xhMm4xQm44eWdzTm94Q284RGQ1WUx1dHFs?=
 =?utf-8?B?Q0RGOHpYVjRibGdLc0VPbGE1RnhqYSs5UjZYRnlHY2ZzaVh4Mk0za0pQVUdV?=
 =?utf-8?B?SVpvNUlpUHA2ZHpYQXJvaVcwY2Y1Wi9PNGdMdUpKRnBEWm55TGowNERBLyty?=
 =?utf-8?B?NHRpQStYeXVlU3llVUVOODRNdlR5VmgxUnVjWklSekRlcjVZcVM1SXVwYURI?=
 =?utf-8?B?cSsvSVNRSXNKajJJNkhqRGJJYzRRQTJSRGN3d09GL1ppUHBsQWUwZmdLRXFH?=
 =?utf-8?B?a2tzUFVTUmxRN3prczBsVzRPcjVvOEw4WnhoYndrSDhKNUl6MWpLeXBscTRQ?=
 =?utf-8?B?RnYwbDdyZ3dZL3Rwc0FEZUdEa1dNQW1wb1Ztejc5KzhVaEZDVHhZcUl4bmJy?=
 =?utf-8?B?dHRaREpxWVp3eEZRdmxHZHJIa3hHcmx5VTNZaU5qaDdyOTN6ZkFUY2lpUjI3?=
 =?utf-8?B?MEZaLzdSNEhUSkN2L0txSjJnUzJFU0tHWnNoUDlEZ29DUU9BRU9vb0l1NjRr?=
 =?utf-8?B?a0RCdFdRa1ZTRU9YR2ZGVVlFUDQ3Nk1SRlU0RXFMT2wvd2RGdlpjdHR1TUNo?=
 =?utf-8?B?VS9aTmczRjliZklhTWVCUjhYalUxd1AvQ3Fkc2pYUGg5aTJZSWl4bW8rSEhW?=
 =?utf-8?B?MkVWWWRFWlhscy9qZit3VllOQ0huTVdoZDh4ZTc0RFVwQjgvaHRxdktOLzlt?=
 =?utf-8?B?M0tNMjJ6RldGb0xEVmltZSttZ0ltejYyMEdyYTdrOEgrMTc4WGlEWHhDc0pN?=
 =?utf-8?B?RU9CcXdvS01TTFNGYnM1RVVCR1FGeXpJQWFiQUo0WEpFK3B4RzlCTFo0SzhO?=
 =?utf-8?B?aTZUa0RYTkx6dGNjazdMWnU2SlVuUlBpMGxjSlg2OHdkRlBFc2FzMEwzQTl1?=
 =?utf-8?B?UmgySi9CWGNTTlE1ZnB1bis3b0hwektvTlNlZStkbmRGU3FpMng2WmtlbHYx?=
 =?utf-8?B?Q1pUV2FMMnoxaFgvMHB6bFdHZUQ0Y0Mzbk1DNEljb1hiREJNalhlUXo0Qmd4?=
 =?utf-8?B?bFNjbXQvMC9NTndubitRS3NFSTVBTXRMTjU1TmZUcFMyL0tDSGh6NXZFeFFR?=
 =?utf-8?B?elRNNDlNalZra0s2ZDhUZzBLV283aVo5WlV1dVRVVWtqTlk3QnZCeEdPNVNX?=
 =?utf-8?B?bVhUd1JVNU8xWWhHK1p1SDZqWGJiUmNndWhCWXNxQkRWZFk2bFpjUU9pQXZJ?=
 =?utf-8?B?WVNUMXhlaGtRbGlxcmZSamw0Nzgzb0pUT2xCdDJFenkyN0JadU9ON0tlNlJP?=
 =?utf-8?B?NU5BYVhKYXgvbmdIZEpYN1N1cC95Rmd0cTI4TFZaelhNM0hMcExYTVJhWjBH?=
 =?utf-8?B?RWJPalQ3TVRtU01QNmFpK0hhcFNBNTBGZCt5Wkh4OTZWa21rQk5YdU1kZDY3?=
 =?utf-8?B?eHFhZGtiNGFlTU53U2FZN1pyRHU2NnBJaE40TEtneXNjc1FLOEFXbDFlTVcr?=
 =?utf-8?B?emlQMy9BYlNLVFMrTTNLY0plMzJHcTBVSjE1Z0QxK2loY2I4YXBoTjB0RXMv?=
 =?utf-8?B?eGJUV1ROVHVxNldzREM0VFlDdGRDdnpvb3BJb25KNTRsUENrdUpVS2ZBWlRI?=
 =?utf-8?Q?MARfcxeFdUI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVplRTF4SjM3elpveCt2UWVjT2EvQ0FtUlpKUS91OWxuU3AzWGZOdS8vajdE?=
 =?utf-8?B?cTdsUjUwTjAvM1pkZG1oczBNalB2cUIvMUxsTjhJQ0RlalFXak5VT1VVdmJP?=
 =?utf-8?B?OExCTzk3aEdNMllLUFFlY3lKcmNVYndkZnFLMzV1bVpSb2M1b3lac09XU2g1?=
 =?utf-8?B?MDNSYXNDQm9UMnFSL1lrNHNLdmpXWEpMYkNqeFdDV1l2MHJNY1BhNzhsZXpx?=
 =?utf-8?B?VW5XOUF6VFozeExYc0lMMWoxMEI2eDF4aGRaQTdQL2tDc1hFZnhXNVlsdVZH?=
 =?utf-8?B?UzJJMkpsT3lCOXk2aGRnSnRkZWZUei9VZlBOSVMzVVEvVy9VaThhQStPUHdw?=
 =?utf-8?B?TmE0Y2RjTWl4WERlSDMrR25qa0VudWNmMnFhRFQxQ2JkRUJaRkNiL2E0K3Bl?=
 =?utf-8?B?SzFzcHR1eHJtcFJQbEJTS1BObHl1TTkybUhkMmttVitYK0RYN25ibXZBMS8y?=
 =?utf-8?B?Yk1va2NBbW44SFZUVFd2TW9zWGFWT2IxS3JicXlpSUV6ZDVnckdGcGxzaW45?=
 =?utf-8?B?QmpEbUlrL0N2YnRrMk0zeUQ2VUkrY1NyRC80SVhJVU1WdzlBQUVobHI5WWda?=
 =?utf-8?B?dWxHYXEzTlFYenFrSCtQZksya2pYZE5Gc0dGWi9pZlVSeHpZcmNEYWo0RGFr?=
 =?utf-8?B?TUVUdFFMR2x1ZnVjU2NzaThSSWovMGpaY3huUTVBY2U5dExlZ2VJWXNPakhJ?=
 =?utf-8?B?N21UL2htVHpGeXZuTXZ1YkhOWXN2Z2JNQUgvUWlqTk5vcndiN1NFbjRKMUdp?=
 =?utf-8?B?UmdNL1F5UzBHbUFKcHdVODZDYUVkTk82RkgwY0hiSE05L2hZTGtadGJWd2FK?=
 =?utf-8?B?WURick1QdTFIMngwTkVLOGNubzNSMDVYN2ppRXR1SFFEaktWV0RpYmFTcjZH?=
 =?utf-8?B?Unhjd3VhazZaU21aZjR6cnl3RDNTYU5UcVNrbGxSUnNLT3Rna1dRRTZZSDFh?=
 =?utf-8?B?ZHcyQm1EYnF1dDlHdE5tYWllN0FEWTlNWHdJYkdPc1lCZEc2NDlsMm03LzMv?=
 =?utf-8?B?UkhnTVgwT1NoWkN0enBnS2NuaXBITGZSYVBZM1NVYVB0RGRHejZWRUtpaFl4?=
 =?utf-8?B?VXl3WjFPd1gzVTVMSGdhMitwNStYaDdwdm80bGx6dW4rTll0eHZyaVd5SGdu?=
 =?utf-8?B?WlNBTlhuaDZRemJldjRKQm9OT3VDbDQ5cHBSQU04RUYvS2tFZXpVLzJpcSsy?=
 =?utf-8?B?S2Q1ZW5PWjBYb0lTQVBGUHpWRUV1M3FvZFgvbElBTExvbzYyUXYzVkpKRWo4?=
 =?utf-8?B?dmMvby9RSCs3MWppdE0rdXJEcEF2a3RHU0hFbkh1cTNPc0FHUlFLRWVtSDE2?=
 =?utf-8?B?bGN6L3oyY082bWxzaFBWUkJGTlo2VGk3aXBYcWZ1S3E5MzRsZmNYNDNTeTV1?=
 =?utf-8?B?MkxzN3pGSFd5NHhncmpGblRLNTQwcmtwUUFBUEdzckZYT2g0V1ViYi9OTDRE?=
 =?utf-8?B?QVljOVFLYU5OYTZYdUx5ajdWaVdydUFYRThjWkJudXk5RmpNM3Zrc2sxcU9M?=
 =?utf-8?B?NlRuZ0FNWmJ5NzRXR2wvQ3VSNEZHaTNNWXRRc1Z3bDl1RWtkNTJobGhtV2Qy?=
 =?utf-8?B?M3JMMkRxZ1FHL1REci8yRXdQUmR2OUMyNWNKNlZ6bVJtbThGR0Q0WHRaTzR3?=
 =?utf-8?B?Wkg2UVhsVkt4WDIxd2Z1Y0tVOUI3R3doNktUamtrbVFidjVJRjV1M0YxQURr?=
 =?utf-8?B?YVVmSGRtRGRHN1JDbjVEcy9RcnFpNW4yN2dxSHNENm5EaVZ1emlYQnNLdklw?=
 =?utf-8?B?aTViT3ZjTHg1RmgrRVUwMHF0ekVIeVp1S0lvNzhjY1M2VTZlbHIvRDR6ZzlN?=
 =?utf-8?B?Nm52SkZpay9TYWQ3VVBsK3BRNGRJdU1uRjdoL2psTTlpdi9xTGloWnpyUnpK?=
 =?utf-8?B?enpucm9YUURvb25oUUs1OVlzZW9TTEdOSkVDQW9mL3MzYWRXTHp3N09UQ21a?=
 =?utf-8?B?VTdWS1JMR1ZnMk1ET1A5WC9PdGlYRXE2MFJTaUY3c3RVZ2RSeFRxT00yUGJn?=
 =?utf-8?B?MkpoRlFwNUI5THh0bER1UllhL0RqWU9JU3FSblRqdWFjZVEwTmtSQVhrMzk2?=
 =?utf-8?B?T0h5amZhRURYNStoSGJIS3FkZStyRjJrYXA5cXRTZjVsa25vZWMreXJ2dWZC?=
 =?utf-8?B?OTBIckU0TkZ3Ylc0dDRUcHcwL0g0U0ZnbFdBbjhQcEhUdmt1b3VjbXJham9U?=
 =?utf-8?Q?ELSDKzDW9Rgba+tWdjS8NE2Bj+hqTpujVAPYFEZ927VI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb1046a-9e84-41c1-b6f5-08dda1d64318
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 13:06:17.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAVH2hu8nmXRbnMVG8vTNNPLNz2sX70PcM3Jq0u3QGaYJXdFFtO0EpL+kLopvSgHvCLOSGAcB9Eh8Ww0iisRiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7

On Mon Jun 2, 2025 at 5:53 PM JST, Abdiel Janulgue wrote:
> Add unsafe accessors for the region for reading or writing large
> blocks of data.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

A couple remaining nits/questions below, but FWIW:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

> ---
>  rust/kernel/dma.rs | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 5a690e5f1e66..b486f63c1d3a 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -218,6 +218,92 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
>          self.dma_handle
>      }
> =20
> +    /// Common helper to validate a range applied from the allocated reg=
ion in the CPU's virtual
> +    /// address space.
> +    fn validate_range(&self, offset: usize, count: usize) -> Result
> +    {
> +        if offset.checked_add(count).ok_or(EOVERFLOW)? > self.count {
> +            return Err(EINVAL);
> +        }
> +        Ok(())
> +    }
> +
> +    /// Returns the data from the region starting from `offset` as a sli=
ce.
> +    /// `offset` and `count` are in units of `T`, not the number of byte=
s.
> +    ///
> +    /// For ringbuffer type of r/w access or use-cases where the pointer=
 to the live data is needed,
> +    /// [`CoherentAllocation::start_ptr`] or [`CoherentAllocation::start=
_ptr_mut`] could be used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   slice is live.
> +    /// * Callers must ensure that this call does not race with a write =
to the same region while
> +    ///   the returned slice is live.
> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result=
<&[T]> {
> +        self.validate_range(offset, count)?;
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`,
> +        //   we've just checked that the range and index is within bound=
s. The immutability of the
> +        //   data is also guaranteed by the safety requirements of the f=
unction.
> +        // - `offset + count` can't overflow since it is smaller than `s=
elf.count` and we've checked
> +        //   that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset=
), count) })
> +    }
> +
> +    /// Performs the same functionality as [`CoherentAllocation::as_slic=
e`], except that a mutable
> +    /// slice is returned.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   slice is live.
> +    /// * Callers must ensure that this call does not race with a read o=
r write to the same region
> +    ///   while the returned slice is live.
> +    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Re=
sult<&mut [T]> {
> +        self.validate_range(offset, count)?;
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`,
> +        //   we've just checked that the range and index is within bound=
s. The immutability of the
> +        //   data is also guaranteed by the safety requirements of the f=
unction.
> +        // - `offset + count` can't overflow since it is smaller than `s=
elf.count` and we've checked
> +        //   that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts_mut(self.cpu_addr.add(of=
fset), count) })
> +    }
> +
> +    /// Writes data to the region starting from `offset`. `offset` is in=
 units of `T`, not the
> +    /// number of bytes.

Reading this sentence it occured to me that `offset` may be ambiguous
here, as in my mind it rings as being in bytes unit. How about using
`index` throughout the file?

> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   slice is live.
> +    /// * Callers must ensure that this call does not race with a read o=
r write to the same region
> +    ///   that overlaps with this write.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Re=
sult {
> +    /// let somedata: [u8; 4] =3D [0xf; 4];
> +    /// let buf: &[u8] =3D &somedata;
> +    /// // SAFETY: No hw operation on the device and no other r/w access=
 to the region at this point.
> +    /// unsafe { alloc.write(buf, 0)?; }
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub unsafe fn write(&self, src: &[T], offset: usize) -> Result {

Can this function be written by leveraging `as_slice_mut` and
`clone_from_slice`? But doing so might require `T` to implement Clone,
so maybe not a good idea (OTOH, aren't types implementing `AsBytes`
implicitly Cloneable?)

