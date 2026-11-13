Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576203;
	b=VOpVKUZRlhrl7QFYrLrdZ2EQ2hmKcBpk/kSAed8CGi9FVQsrUUf71VFPPaQhFjDi/Q8U
	 AZWRRBAz1N27N8Pva6LBKUyIYug71t5HqjQ/BdZ33U+YSGiFv/YFKtJD3n3+YXSV0T3KQ
	 Fy5DpngknpSG64Dp7egcvYSqI4rUJeLUTdkF9ihq8AYvlCqnNWyqtjpCz2PVMNSRko7V6
	 b09zldVkY/rJHFGBFZM2US18yhs9rgwZkitMU8HGZ0r8DXm9ys991pYdYZ4D3jEmqWcVC
	 H0qngVklzunlk2hrDE8rMXkKuStpnTb8RH6XBE0TK2JoldAQEI3tBn5ebv9dF2hm6IA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576203;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=XXB7PpiXoM/W4OjefemPUqNuX9yEUubqOsRSAGzYX2o=;
	b=aF/epKmZdZ91Pg8Fvucazo/b4aHshJS+oetaprOCbBWkcf4MuaBzZpILBSG2x1wo2jAU
	 g6wkfaA6truKwBo83ErihaPzViIbAxbsW43WmbfTA2zA6aGctXfRVZqEWtbnDUJ+Y1soF
	 Kwc5nFuNjJvYxpAiU/tWiucyy4jY1QNZ28p6ZXyEqIfftGGiH9OqWjfYOP+uSmQ0L/Viz
	 2ihMDupI0LxjAoT1a6u7zcjnBmCCdVdzZp0iqAYoT5I1EpSb3wgH9cFYw0Fgn7FHzCkXU
	 gucjbPNCF0OZUFubfal5rMTjULr+AUX+W8HOpRKKf7PvGz63Tp7oBQ8GE3xLoE6kVfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DKOVTH5B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC545606CAB7
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC545606CAB7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DKOVTH5B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1wn1arNMxYlUevsbEi4yEuqou241qWNun2JH9pYQSwF1WX3gnFHFVWMJZiACgwN9X1X2dF5ru4GVXAtHpq9QB2zjgQ6nZUJmgvOLGNZy0k7LBRGOwXtIDVV7VZGBhPxTdF/S1Iuxs+r0FpfsMRMVCJ60/WClnipxjSQhwiLAHIYAgBGcF95iMl/0nT6i7toQTaxJAM797aJzv4xnkjN2h5y99X5ErQ6HnKSATD+MJrgzHEOborc//NrCB4bSz9fEz0Ca+JD17lG1eIOH76zRUT9NCL+GNrI5FMCp1LQYuJvpo398CALTtJeRl5GRlixxwDM87sJG/FqwOwPKA5s4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXB7PpiXoM/W4OjefemPUqNuX9yEUubqOsRSAGzYX2o=;
 b=Q/hqtZCIB9wS0Q2n8xoBj2ZfPsa7sYDYVR2rva5pfEZ/rE7NHnCS6APUW8WmToDB5lQNgpwcBZxMqw2yExD610U6T8NXmmGezksnjt9CQZEDhky4eK59wBnfoD13aj+0p/O+WsgbgYMYw5RvG93QG7Q5hXReMSFPe4rv3Jb6WNyPxv/yNvrt8j+pz8asB/gbMgQP2mFb2L2Xb+V/y4JN7Np3wlQLQbrO+RnDH4+OhDHtzOomIbi4Li8SJwyifGjYjSSSK2vqc+hlefflSrtrhFK9yq+OjvroXKgHyPwke8ixf7JTco+w2CwITM0aDoBwcoMj3uHT2Xz48aFgT5hlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXB7PpiXoM/W4OjefemPUqNuX9yEUubqOsRSAGzYX2o=;
 b=DKOVTH5BVBVKU3b1M0B2RTGsHxcd9yIEsAKat3bTESC/pMuOxlGZB0I8sNA6j6NuJubxlgQA1odkNZCC4BRCTLPBajO9mJZvSWj2t1/oQ7qoso/9PKXMVXSPej8clrk+2iThzxQjIhtTdKNkmqOCWkqTia0AICMTNH28kGOrSvm5zWNNIGUBEmADcLHWZxfzuz0L/vmqUBBKdh3hcVT8j+4sFbKg9LArS6cdJ8sbs5FRhNiKgNAghNTX+9d3Vp55AJpL8xBZ2ek70HL/kuQzcaPUmvV/TYmHflyQE3qT9BPNqlnSv50uPcjEkJmKYy2dDoOUJXS30kptV4p97LmOaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:23:19 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:23:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 13 Nov 2026 21:27:18 +0800
Subject: [PATCH RFC v8 6/9] iommu/arm-smmu-v3: Group aliasing devices into
 the same IOMMU group
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-6-587307a77f3a@nxp.com>
References: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
In-Reply-To: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB007356:EE_
X-MS-Office365-Filtering-Correlation-Id: 455a0f89-1f05-4527-2846-08df41894861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|921020|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|261021135927099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GtveMC6+2CVH+0LF9xxMQKcEYo1CFcrMLN/iOFzdzEyWfCCYVlrgoYH+KGyOjFnQxnKM/0PO899HtyjX+RC70NvH8ESdEy4Xc9wUt2hJW95UzWr+gJRGD9Z08DTlLAmZRorSZbnVeTgJlJiymBG1vWWruckQtTbx/EWxLHhi3S2TQRgumPYt9Dh5be8pHncxhIl+bC3grhpzkPCj20mgjp/X9TRVV1JZlppBgAk25YqKSyraUWE+fNW+lbeogediW1iKPqBdgKGyUeKpq0I8OjuDyHFo4jjC5UjlnQK4wUH+cbvAjmT29g9jMRHOdpMSW8uUqZGLFtSixdjn98mUoay26Vm3U1W54PLz+z8SNKgZO2SHd3eRyHV+TcAKkt3bZCyI0wovTP3dZljg6zWbRNUg5YjB+fbIzuteJIEJpQszQfpzGcpaNk5U4Vx037n4hIXw2/4CskoX9De1M9mw9krp5VUBtNYJfBHtpLctOgv5VyMB13ZPme6wN2/zxkSzXCtWoOLmzLhKO5IfH/FTjijJ9JfR0UhrVxNSnixxPI7VgjuH2kkytc4CwfzaK9pbAkc9O3FOR9Q8HXnj54SgWueqps018X99p5rIlCOyNYPjiJuYkT6JzTpVR7vw0eHUGcvu2Z9dqb9OLt1NioJ5F9l3tkNAPWPoWBU8KWBGPB1EyFyzNPbGwLJagmn+eP9jaMoohPaxcgEID9lk+1Jj/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021135927099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWVHbzdINjAwV0pCRzAxQURWOHpoTzBrcDhTRjFuZmVERXlNWEtvTitCUHdm?=
 =?utf-8?B?S1lnOUZ5N095bDd3Wm1jdHN0ZGNkS2l1QzhYRXV4ZVV6NmZCczFNWURPRHZw?=
 =?utf-8?B?NjB2ZFl5QWdvbS9zZ3JtMnZldTQvY0RoaUR6aVMwQmtESFJ0U2g2N0FhcDRJ?=
 =?utf-8?B?Mjc4VHVTN0xVVmJpRnhvOCtEY1VFL0FIRDZxUDlMY2lxczRWSVRVNmlJbmRW?=
 =?utf-8?B?aUlVYStoejRjK0J5QUZmeXpKdWV1OVc2Ui84NXhUQVFPbkRhQXRhRWU0SGY5?=
 =?utf-8?B?eEJjZzdwczJOSSs3NmFqK1RTQk1ubFRmWEdENlZobTZ0c05Cb0RFckxCb2FH?=
 =?utf-8?B?c2pxOVZER0ttTmY1R05CTG5mUDlYaHQ3NlBXUU51RldncVZKMzQzVmVyUFhp?=
 =?utf-8?B?QjJrTUZQb21jMW9YSGt2WFVXL0huYStmcmFwYldhd01Ta2VWT0lNM1FXdGsr?=
 =?utf-8?B?WDI0bG8xckk4d1NYdTJOL1hlMGpQNXczYWZ1UDFZcGV2VThwTkM4Z0hCV0hT?=
 =?utf-8?B?VkJmMjkwQ3d4akxQY2Q5SXhKeWtTc3dMb3lLTEZrQ0Y5SzQ2bSs3azJvNkVa?=
 =?utf-8?B?QzEwZ2JPV0w1UmtKdHhGTHlzVllzRTVCZXhTLzA1d0VMZlFjb3pqM1lRSVRD?=
 =?utf-8?B?Wlh3Q0JSbUNoMTZteWdtVk1lbzJKR1NIZDFibDZmQ1k2MnhuM2pJdXdTMmpy?=
 =?utf-8?B?OHlSWjBBM2FyRHBaR0xPZUFIWS9mUnMvS2k3YkxiampIOTRUZEFjVUVnWVc0?=
 =?utf-8?B?YlRJb3pHVGk3WWJHM3k4S2FwTmRMa2xaS0ZiUG83MDZOcHFZUFVvejY3bWtX?=
 =?utf-8?B?NTZOYWR6UUErMzR0VDRDM3pIRExVeVk1NnphbElDdnhDdG8yNjgybzZRWG5Z?=
 =?utf-8?B?SFdrdkZxL20zYi9kdDFSUU9XUFAvSUZGcFNMNGN2MzhyeG5UOSs0RmgwUWxO?=
 =?utf-8?B?NFRNcHdKUmJsWmxqdW9HTk8xY3NtT2tQYkxqRkNzQXpzODJJL3Naa3cvMG82?=
 =?utf-8?B?T3dqS1hpYXR3S0V3QnAvUTBnSVJHMjFYNDFiR1NENFF1RWt4M0t1c0NnM293?=
 =?utf-8?B?Q1lURVdGK08vdkRTRE1DYXRFdXR0L280RUtxMjhWT2RMdzhvakZJc1VnNFVl?=
 =?utf-8?B?ZVhITmhjTmxuUlJBaDFRTDVLUnc5ZFRaZVhKeTY0R2ZpZGVWRjJveDJNVHFE?=
 =?utf-8?B?eEZnU2l1cEVXQVVnYy80MnZZRkhxRzY0SmJhVWc5VXVUUVlGdEhSSTFLeUxG?=
 =?utf-8?B?TVFhV29UKzJOejVUM1FnODdIKzZzT2pUeGYvMVIzL2VaamxGVXU4d3hnbzdR?=
 =?utf-8?B?UXRjejFwT2VCSXFtdnZmREl1RWpZd0FSeGV1TWtPb084dHNtR3E4dk5RVjVv?=
 =?utf-8?B?dWIyVGEwM0dVYTI1cTRIakpzRnVSNWJWWCtpK2hHeWI3L0s4amVncnQ1V0xZ?=
 =?utf-8?B?b0phUjRORnJRSlVOQy9NQWo5dUJaTVArdzRYYzhXS1RsTWRwQ1lSYUpCTWU4?=
 =?utf-8?B?SmZvakU5MERYVGJHWTUrY1RnRGdSejNRai9nZyt5dWpVaDNDR2V0U25tY3d3?=
 =?utf-8?B?aUxJek5SNVFXU0FweGZONnNndHJmcXFTcDJwZjlGbnM5ZHBMdTUxVDA2M01Q?=
 =?utf-8?B?M1N2MkJjK0N0V29ZMG5oajEyVzF1ZUtVNXI1T1ZvTjVzUGd4azJJb1NFMk9o?=
 =?utf-8?B?cjJ0MDNRZDR1ZjRJQStDWU5ZRG1hVmpqU1BvQVQwTU9sck9Oektoa3RjNEdD?=
 =?utf-8?B?VXFoSzBXOWM5cWQ4OW92aHBHWCswbUJVK21JYnNTWm9Ba3dhQ0JEZGo1dkM3?=
 =?utf-8?B?QkJoakhQaVVyOURjYm03UVB2NktpVTRxR2thVXV3Y2tlKzlEYTJZaWxReFpk?=
 =?utf-8?B?QXhZQkZiajZjM3o4RWExZUR3RDA5Z3ZWRDloRldkSVpxaDA2UjNyNWo2Tk5B?=
 =?utf-8?B?M2I0dXQwZkpKQUJwV0grZWVYYWVTbGZnWWJTSXFoZE93bFhHa1hKUlVZQXNI?=
 =?utf-8?B?bXBFMmEzOEM0ODNQa3Vtd05CaXlBWjU4VjRnek9UM0RFMlMxbWFBL25qN3NX?=
 =?utf-8?B?QUVXYVFscG10dkJ4Z1drQ2RQbmhKeDVXYXBCM01EcHVvdWdBdVZzSkVZaHFL?=
 =?utf-8?B?SnM4cDZlazhFRHVxZVhDa2dCQ0ttRlF5cTZheFROdGU0a2Y3VmRQR3ZMaTh6?=
 =?utf-8?B?clFZazhnOW9LOUFTNHBmd0krVWZraWdXSmc5eENwL2NOYVV0VkwxQnZCeUlR?=
 =?utf-8?B?bitBU29LdkZUUnZnU2taaUdEYldFZklacFpoQ1BJQ0JkNXFRQVVjVERUc2ty?=
 =?utf-8?B?dERONkh0b3IyTzU3aWcyb1hITG8rcU9HanIvRTZQbytNVC81TDVzRDRYRHNW?=
 =?utf-8?Q?indnx6sFBWiNuUhKsdlQnJ3VOJ5cblEMPrDbg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455a0f89-1f05-4527-2846-08df41894861
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:23:19.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qATKb4665oEt89d6KgvXJEX+SluRT+iiD/psuXFqonaOncmm+1fWNMlMpcZOpd10zuKoRrgmCwC949S4WptARu3B3CqvUjorlvGsptCzbGZgNZ4pqxQWZNuhqj735fLr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

From: Peng Fan <peng.fan@nxp.com>

Devices sharing a SID must share a single IOMMU domain because the STE
can only point to one CD table at a time. With the domain-owned CD table,
non-PASID devices in that domain share that table directly.

Detect SID aliasing at group-assignment time by looking up the RB tree
for existing owners. Since probe_device() inserts the master before
device_group() is called, skip the device's own stream and look for a
different, already-probed master that shares the same SID.

Faults on a shared SID cannot be attributed to one device, so they are
logged by the SMMU driver but not reported to a device driver. Sharing
across PCI and non-PCI masters is rejected to avoid bypassing the PCI
topology grouping.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f954dc7361c4..20cbad032846 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4736,13 +4736,28 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
 
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
-	struct iommu_group *group;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_group *group = NULL;
+	int i;
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *stream;
+
+		stream = arm_smmu_find_stream(smmu, fwspec->ids[i]);
+		if (!stream || stream->master == master)
+			continue;
+
+		group = iommu_group_get(stream->master->dev);
+		break;
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	if (group)
+		return group;
 
-	/*
-	 * We don't support devices sharing stream IDs other than PCI RID
-	 * aliases, since the necessary ID-to-device lookup becomes rather
-	 * impractical given a potential sparse 32-bit stream ID space.
-	 */
 	if (dev_is_pci(dev))
 		group = pci_device_group(dev);
 	else

-- 
2.34.1

