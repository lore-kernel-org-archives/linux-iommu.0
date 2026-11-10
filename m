Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493320;
	b=wzJgDPDx2smT6IxwNjDzyQmgTwKy8O1ecuI3rEnjaIK2Dc27QNhiye2LjObz6NszhwpI
	 8+xs+ddFAowHpxsYtHGSOF1pFp3/wW2icEVHkV4r3x1xzdTRFqLAmabHlmxVUp8F9wXPp
	 jiHzMNhTe1Ch42yCcPJIbDgBTRIiqHyjR8rBrpeYIkBT3Cb9YxYNYAd/IEcKC689Q7cJ2
	 XRFHe5UZDTUAKjOCQCeeOJ55Qso4TaKTYNsY9L48aVfv6KDP2pK6hS44ERDckNXgM7c0h
	 1o63bxVnomqOZYSuTmTknQAK4FNRNw1V7iA30gk8fnoVpx/O0JnZHHNUAhNttiLTvcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493320;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=ZiAen7amm34pj4WU4yzHry+/gm7Eku5rWpAfpKAY3Yk=;
	b=Tyd6ZrOFkkKIHBDPkReK5VKnKrd59XgisUOQFFqeH+gLne2IzeDetSbqQnjCRtjyIZOC
	 0OeTtOsaKiOpJA6LMlaJgAYq2qC1Rux0Dqmtmh/CaYWaEO88+fWtuiSB5qVEZ0SJFg1bB
	 pXLx+4MJKg+mYrRni1cGddfSFTMHbKFJr/6JbaeV+feKX6s2HB2EKYz3sGsfSw1fwd8e6
	 PnbEdJxvtUGUIc2sfBpndXBbt0u72IaqER9K7gGo0qgaUXXCVLUMBLgPE+0mTW+g6X6Q4
	 fis+e2mwkcxBG/9/yIe7CcuBZG4UqsWwVdVohXW1iokWh9FNNvgKjoi/27NjEp6nOuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J4vRanV+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.51
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22336606B82E
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 14:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22336606B82E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J4vRanV+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsnpdQ9hSGrUi5fNoJmtV3PHi7hwebZu6pOTzMBS9UUeuVv0WuVPC7clScEqfvabK26WH/106Cd0L1yESHAMOEwHlqNDz/ogBMpdMggvo93/1SB60QBZrDZu4III8+aQudBR73wrm86O7podCCZhLOYqAn4yWcwne7khRtJYl/ag7Sa5aBQ1I/tY9MarMbqMbp5rZc7N8DcFZnFW7OFLHdiP1hNmgk+mWBvFy2HWCRTYpLXu3zVfI+/T1NWyPaii5SugclgwdICGHU4K/itg3/Vy43gFSl2roSMgygTymmqc7HEJo4fMAFBshUrtWvpPFzPEOnHvXWF7ys0rCY0Tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiAen7amm34pj4WU4yzHry+/gm7Eku5rWpAfpKAY3Yk=;
 b=cC8uAOtzPcExH1uib4bxh4ypgALbgwz7HfIghqUF2JHCYjCgBDER0EbpfEY/BOf8+zlOtOSLRKocwzMF/1UhIYZhdhf34wnKFUxLfkcVukuTstZNfjcgS2kqWd3fA10tbORmsIsgiSQds0+S5OK57c5+fdFDp4PvhgzAYe7afPKpFKSx9IRQxG92oBYF7NU+uLVlhaG1vKQqSqMcBS3vReEeYQOjC14m57ekvrGVr8XDMbUMv58GzHvU+902lNhxgzLQvqeDNTygqB19x6neUn+wBf7RdKid6ldirFj3MqcN9a9LIJ0R03GSgZAjJPba52g7cMICjO8MqXrLqkyCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiAen7amm34pj4WU4yzHry+/gm7Eku5rWpAfpKAY3Yk=;
 b=J4vRanV+lcVfIWuSLcEVaotYNoojUpwyqCrCLHonSvDulRMRMvWZJpBqMuU48IUk8Ptwn/Ozrjnm+FnLpbPhdt+yVNrJ5xw/ND67NmkF4CnId3oeqb91Cgro2/lbQ/5o4HWST74k97uZn+nr3Q8+8AnjviBd0G1Uc41CBpmaZ5yypIOjkhh2TJIoCAaR3o3W+OmEaFLfUYCVWmKbvkvNBphLYjFbJv0vzxhSe+OK9OB3+WZVZdnEgpTNfU1oFGQbDe36Nz8l3BuvV76kEy17zyBgx9K/xJELrn2xltYC5T/jlbEJJWxmVnbHsW0ptznOLgGQpPpFojwtAqsVo4UyvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:21:56 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 14:21:56 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103155501.534820-1-sashal@kernel.org>
References: <20261103155501.534820-1-sashal@kernel.org>
Subject: Re: [PATCH] iommufd/selftest: print size_t with %zu
Message-Id: <179432605484.1456949.10348379117512543483.b4-ty@b4>
Date: Tue, 10 Nov 2026 11:54:14 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0369.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::23) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c38a93-1588-477a-fe75-08df40c84e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tZojL13waykhMsnN43a/xhut3okNFXhsDsoIfjkYo9GRFVeRF+yMpeR50686eV7bBEKtWTwH5XaLCZkSJj/VgQXwqWEI397kaeFd6BuqwkEnasLhoDRouy6hcn7g9BURZgQ0OXsUn1nAjiDBn20jazrSHjAMgydxJdYDMI3g7OA01ywtdCtAcFUgVo74m3MxffhoLip3cv8XsFukwzojibzBNZgHjEmCncDjT5VUIZ5eW9PYd1QYxNfyU4xQkupKebY24YzbVRNTG798K6C+f8G+9oocmmWBlkp3+Sv84z3zcb2d5ckkDUjhrywpiUL4OpTBEwZfNOEbLLLMlqiWM04LrdnUJtbmvZVovKUCDRSpVZ/T+h7LotZ8Sws8Gd9eWx3BKBEz7vRLZxO05JE3Ha0XsYL+iQ3RSSsXGOQ7zt4chY5aV0JEcdzK1cZycG3zWuHlmMSJNOcCcMg3Mibc6lMSdWgDQ6gOX2ztkkq80q9gTWwIHyibE3GZtSRwiKbY0G4BzflOwr482t7qFastfGwNy+z88QHhjTGEL0GJMcI08S9U1KfWWSRxPJh6HkyN/cTddAcNy1ZqZeTmwIMSbPHQ29P6eXm3a0qTK/P2f+5e1ciRMR78e0TIaaHXBPyTAuE3zedR6YxQgyv6NS03WN/y+2NzVXY9VN+mBBvZKUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmFPWm0wV28wN1lIUkcxVHJUVzIyTGZLTjA0UEdlcThVNkhsb3dxbDBGemQr?=
 =?utf-8?B?aWVQWCtlaVgrcmsyNlpNWVlCY0JTUEFVZldVSlpFUDJnTEluSmlNUjVPQTA5?=
 =?utf-8?B?K24wcVhuOTVVOVBaZEpwVURIbkxwa09lSWlwTDZicXg2SEZQelFpN2RESzhW?=
 =?utf-8?B?SHh2WFU1RFJxSElUbHAralZaREp2YUZMNm1wUnZ1SHJlNUJVYThPeHFnazU2?=
 =?utf-8?B?ejZZNEI2bGVzNXFFTEpDOUt4S3lnQktjVzYrZjNzdlRTZGV6bTRvamlkcmZR?=
 =?utf-8?B?eWhDL0tSOUVYSUM3S0RWN05qTGk1cTVCd3grODZ4N2h1UWNNYTFPeE41U3o3?=
 =?utf-8?B?WlBvT3k1d3ZFQWFHUy9NM2lqNGxtVXYvQjNnWW9zVXhxY2RnVWRuUWZJSGhY?=
 =?utf-8?B?ZkRrSlVYZklFSzVYaitDOFdDbjZXdnFYSXZkUXJpOFdvSjc0OWhRUStuWktp?=
 =?utf-8?B?aWV1OWczWFdVZTZlZDdoejJnbHJtYXRmR1VlVExDMkx0NjlEOGlFTGN5VUw1?=
 =?utf-8?B?ckhtRlhXNWc5MEc2VVNDdHJQaTVUSFlHSjF3c1ZrdWdBTVg3MmpHZUdpS3VP?=
 =?utf-8?B?d1pRM2trTmJRQXlhcDBjWkFSK2d2Y0pvMFEvbW1uZHFtdEt4ZHpRQ3VFZkRz?=
 =?utf-8?B?L0RYRlo0NWN5bGJCRmRGY3FVZ2xYZ3pOYTFqYmxJYmRWdjlEaTQ2TlE4VDZy?=
 =?utf-8?B?RkJuSmg0emNQVGlMNGwrYUtoQWs1VVMyNmNFMmVPTnNXYzFDTFRZaFJ6ZU96?=
 =?utf-8?B?M0l5TUd6anBYelpPdE1MM0ZrczZSVCtWMkIxd29oMXlYQitJeTVLN28zNjF5?=
 =?utf-8?B?bEdPZENFckduaEpUQk92STk2dmVpSXMzZEhIdVI5Vk9NY21IekJRZlB5UE1J?=
 =?utf-8?B?cUVrd2gvY2d2Ykd0UnQrNGNGQ1pxNklsZUtYcXVLT2RwV1NNTmxKajQ1dVBs?=
 =?utf-8?B?akVqWXJEekxqVTdNNkp4Q0ZRblpOdHlSMndidXBpTTduRWU5c0tvYW43SmY0?=
 =?utf-8?B?amsvMlMyb1cxbEFMbExHTHRpa1dIYk1IQjR2RTBYUUtvMlZhUlFZSThaaUdG?=
 =?utf-8?B?RzZEWW5SQzdwOHo3ckZFUVpWWnViTm53aGN1L29Fa3lvR1pDZEljWDZjcG5s?=
 =?utf-8?B?YzE2bzNwK1FyU1JIQmRPQlZPVlkyYU8vUzArYTAvODRzQllMMURLK0JnNGkx?=
 =?utf-8?B?clBISUp3ZHlwczUxdU5Ic3V6ZGZiSWlFTk1tMTBZUldDckZVZ3kydnpZb0pk?=
 =?utf-8?B?TTQ0V3haL2RpV204NG9xZzBRQWFPazRVQ1g3cXY0bEtKWC9QYmxCYzRZc3ha?=
 =?utf-8?B?bXNUV0Zxb3lGUWsycU1ISEdYMkZId2YybEJPdklUOXE1eFhmT2dRQ0JtVkRX?=
 =?utf-8?B?VWlsZ3RaL0VOdkdpQ1UzYU9Jc1ZzSVFqZ3NVT3U5b3R6YS95dlFLeEx1R0Vk?=
 =?utf-8?B?NHlwRXhPdzJDVFJFakR3bzBnRG41c3NiT2VqemxkTG9BbFgzRHNxVnhSa0ls?=
 =?utf-8?B?bUxRQ2x3YXk1MFZRcWJadHIyNFZ3ZzhjQWJGVVB1MDVsU1VjOGtZYVU4MitW?=
 =?utf-8?B?R3ppRmtWQ2xoSUkxbjJSZmovS2NQMWpHN255Q09IVHk4VDRqL1ExT0oyaUM3?=
 =?utf-8?B?dCtwOE9XWkZCTFZlS29zdEZqN090clQveWRBOEcvQzlJQS9JUUZjNHlPVUdv?=
 =?utf-8?B?NkhLK1RWTTN6dVZqODVhMkc5eUZReWdJUEJBb01vbFpyQVV2bHhzMzlRb28r?=
 =?utf-8?B?Y0psV0hYcmhwSVFidE1raEgwbkxVOURuclhvTmhKcFJhcURNVXpnYk1WNHFX?=
 =?utf-8?B?WFFIbnpjL1ZsVjl2dlcxZDc4ZnM2Q3I3cDd5dWRjTGdmRTlIaTRQUk1QOUsv?=
 =?utf-8?B?cGlGMTFmd0xJc2VySVBMMzg2REdSOSt6YUFzemM2Z1prOEhjeEd0WC9kQ1Ri?=
 =?utf-8?B?YXQ1bkQ5cDdyQlNKM1JhWUt2cy91R0g0dlVzZytzTkx2MWZXR2ZrTG0zeERX?=
 =?utf-8?B?MGV6QVl2a0hoTGl3OGFSL21PVUNZWmpFUXFrUjlpSzhSMGRKSHJtdWxZazhn?=
 =?utf-8?B?M0h6S0VQU0VNNWZLNG1CYkxKZVFreFlnd3dEeGgwZW1SUVAxbGUwS2F5YUg0?=
 =?utf-8?B?bGRQOXIram1OTXp4SUlsV3BJdDBwL3BFZE5GRDlhNWpRVGU0WTJRc3NSOE9s?=
 =?utf-8?B?UjNUZm5YcWlUeXU2MFFiQW9jVFVYejg5NXpWQVIvRHFiWlViMlpGYU5STndG?=
 =?utf-8?B?dTRPcmpjZVZhQmtqK1gzNE9mV1EzY2toSi9hNmw0QVlDNDFUOTRuS204eU5C?=
 =?utf-8?Q?8tHgoLGfGpnFY24fX4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c38a93-1588-477a-fe75-08df40c84e30
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:21:56.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfrfDyvUMc6zk9W7MOy/Xh+DUb5jN3+hM2gl2W+hI74xH81nzqQTgZ4/a7zqluRM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205


On Tue, 03 Nov 2026 10:55:01 -0500, Sasha Levin wrote:
> iommufd/selftest: print size_t with %zu

Applied, thanks!

[1/1] iommufd/selftest: print size_t with %zu
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=f0ff459312183fe1e5ad133db0feeb9faccf908c

Best regards,
-- 
Jason

