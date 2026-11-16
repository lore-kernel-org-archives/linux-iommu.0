Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.56
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794827374;
	b=XvUheKWLJIEz6k84zlOAffOARt1m+Q1uoHquemupuXKL7uAYgC/ZKO7IgeDguBcwbV/F
	 4wBoAokJazvqwkU1wCxJw4dZRSu8veCyWo/fGBdaOm6dU7V9J1LVKJbxls4ol+2NmClHn
	 b/y7TBoPQDPQCU6c35xd5vR5VPsb1VWqfDfxppV09t1jSzC/zgHo1KSEYdXcWHkcTmD3R
	 vb/n3PPeEN6v1TwTyEEDzC8gUQG9JuIgg/An1WQGuHqWGqH+j07zs+0F+UMnwIfEv7MLO
	 X1c2vRlR+9QqdiSJqcKlBfnNHu9az+Xy4kYtiKJ5dBOPZA+Trf9CH10eHvcIdVvOLkg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827374;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eX+EfiZnVovOMGa+8RknfzvtdxHaNahk8i8EIq3lp6w=;
	b=0uyFiofFY9yX38VDlOAULBVnumf9An32THftQ7rEMQMxBEJg2IEKuP2gei0N0zjXu1SN
	 rQUWIY/2G3tipfzbBHXsCQEJpmkxzPMPZqsi/Mp/YB1lx8U9024nRG5s98EaEZP0am/62
	 YGrF1Rbl0bgP7VmA+Jswku4bObdPR+tvbattbf0okKaljfCSPYbbDr/pHjlHFmr1xLnDx
	 xTmY0ThdPcl6U3pKgAAYtzSCnoKRWkXYHggj+i/1uRtuTIRIz3yz9YtdCbgCzigEeUjax
	 8gsXcZK5BxfaHlZF5jwjvh+nZFbnjWISc+Kr1adVXbC/b/1t8n6hl8IlodYNnPKLbSg==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KFwDxhoj;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KFwDxhoj;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.56
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CA607A8D6
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D6CA607A8D6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KFwDxhoj;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KFwDxhoj
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hhkYKEuIR5agEdqLN6oFU2hP72nU4TlA7b2whFXYKohVLCtW9PCJ8HIx+Xh7NA1pdvjZlqGwHt06OB5SeOPfe94IZeLFORdhE0Inrxssn8O/crKxGJAZMCzD/r1oUhqLKoQ8JCchU9AIuD9zthIe5LTHwRVcU/GBXh4Vqdo01h1MpdsQyKp71DFVC9PPWXRK6890J+PHMHrL9ss9SS2EOgoR2hwm9R3pfZmzUMbZugnY92QiuT93u62kI1ALKid/4viuMsMMn7wuiQwvmyN45BUr8GZ+wrNwweSuEGnPC5OWbv4SGpdpnzNaRCs3CVgTZWk+6VHb5YWctirkYLNSOA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX+EfiZnVovOMGa+8RknfzvtdxHaNahk8i8EIq3lp6w=;
 b=uhDsZqw3TiEV64gy18u0gxFtjVzW4cDjS/PHOL6e/iBmaDlF+y51EX/Hymibf1SmucE2o/e1/oIqRdeKP5S1/kdLISne97+2xLhM4IxAvjM7SsvFd3qm1REoVf4nXmOi/J1si9XKhIuDRkV/3+p6G4Sbxnk34cInJMZirygWuGlr9Tmn1wIlQE/Gczle5Yclc5MTrbux1Tg1rNqbydiJ3I6eTAzI6Xyf8PjaX1i+6De6l5nXhfkJ+qUcD886Y5JhusVQrJ2R5lVFvsxzui2ZMOUKd5KQ6KNrfOt+u+QDTwtZnSBNF9x9fV3E3VbTEhycPodO5BGpbpsfzueiNMr9pg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX+EfiZnVovOMGa+8RknfzvtdxHaNahk8i8EIq3lp6w=;
 b=KFwDxhoj+Y87UlIInksDzY79JVBQLY7zxIh0zCTHl2Jthc/z3lgESl7CrMq1AvR+JIS8pdvOq9TdcTRI+GylEC+2CnTjnjsuY3jhj13oMhkGDa5zdx3m4OjsnLus06Oe94PyDLl3HXIxXgPJSRKVXESx5lnUf4+/dBgaXSgpw58=
Received: from OS6P279CA0094.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3d::18)
 by DB3PR08MB9033.eurprd08.prod.outlook.com (2603:10a6:10:43b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:09:27 +0000
Received: from WA1PEPF000099D0.eurprd04.prod.outlook.com
 (2603:10a6:e10:3d:cafe::70) by OS6P279CA0094.outlook.office365.com
 (2603:10a6:e10:3d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 11:09:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099D0.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 16 Nov 2026 11:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkcmM7xrUNJXW/6grSORd3XMqsjjEpO0BwyOHJUVkqs8lZE0IDPUBdKHC6rtE80Y/XNXgf0QYlyn9w4a9oJvtpOWYi7uxjnV5QL4SRax+cGGb4JUclcC5ucbkO2OR9rBVa7fUgHOefOVnsSZd6wGaYmCYOGtNbDD1rECX4ovn7YZd0i/dv8VmPfpjBRGMK1xeW1zt/ohabeXhi9saM6J3HRKCwAYC85jryTrgS86d7tG2vAYShzcuk3SueWdoR4HdbhsOMLXE5qmmOe+eNUCXZsbvBwYoZ7NI46gRIKrUbGAVHjx+2PEDuP+sycvdUyA3ZSy0DgmJaN+NTlFTXJOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX+EfiZnVovOMGa+8RknfzvtdxHaNahk8i8EIq3lp6w=;
 b=jjdodrujLoR0/IkoNdZzARvW/2CuPVhLz4K11U2nWMzMktxsglmc1PNiy32ok4UfWm/P8orCHkZQl8QtYRY8zY29qkNCGkZwlyH2dVTejsqXPUjpz1Wggteb4KQD9ym0iX0DN6Cy/edqK8CQhE4D27jK2mQYMOzf+ZCrUtNw4S3SQ4LCc/PKAhj41bgn6Pnbh1VEDaJa5RIqTR437GPvODJB8rlAxvVRF6XwNUelf9p/R2kA7xNb6CbR16nx8k+qbg5WQCaJSRrkXziwebQobCpJWShdVwmRsFMAufiQ0yMmJDv4NaR3a7TEuo303+iSTfIpVHaxW09Ll9QBOCaq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX+EfiZnVovOMGa+8RknfzvtdxHaNahk8i8EIq3lp6w=;
 b=KFwDxhoj+Y87UlIInksDzY79JVBQLY7zxIh0zCTHl2Jthc/z3lgESl7CrMq1AvR+JIS8pdvOq9TdcTRI+GylEC+2CnTjnjsuY3jhj13oMhkGDa5zdx3m4OjsnLus06Oe94PyDLl3HXIxXgPJSRKVXESx5lnUf4+/dBgaXSgpw58=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by WA4PR08MB926493.eurprd08.prod.outlook.com (2603:10a6:1d0:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:08:51 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 11:08:50 +0000
Message-ID: <87102de8-0abf-4d33-a43b-85a83ab29ac4@arm.com>
Date: Mon, 16 Nov 2026 11:08:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/12] iommu/arm-smmu-v3: Disable the EVTQ and the
 PRIQ in a kdump kernel
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <325a9bb2908f4a163dd3a82099341dbac4ad304f.1793593923.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <325a9bb2908f4a163dd3a82099341dbac4ad304f.1793593923.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To PAWPR08MB8959.eurprd08.prod.outlook.com
 (2603:10a6:102:33f::15)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAWPR08MB8959:EE_|WA4PR08MB926493:EE_|WA1PEPF000099D0:EE_|DB3PR08MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bddd10f-d463-43c2-b14e-08df43d21366
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006|261028144727099003|261026140227099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261021135927099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 AhyQBHBF1sswx1tKEY/xjyAGlULQleP6nXx65ahkruRZIeuoMHxwXTi/CHVPasd5o4weR/v5JRB8GMtw70OIF8rNpoE+ntyB2wy/rvRha9UaI8E1+DeMjiZKgV6RDyahuK1v4qgREYghW3ztImUzlUMXq3IcemjbLgAFKJPd/oSZz5tUWKxNhq3baPtAIICwSQZECewDh32A/AOUujSXd2PnoumIKM9ZKzqspqkM7ilnceYX67YSSXnsMPJoM4uHMMblGSO+5Bg7vEgP2zi+hzYPiA+MY009ND5P5IT9NOLPKXgYDPuCCOUDnoAclzrfOahIyfiVtEt0OsXJ9TZY9WCdA+GPSPjGC3dU9/kOYQGxDW/xNG2+eIrDJc5R+hyYxD73GxNgQ14MnAn8jylumWbvOo3kIjq++emwLmggqK7uBhKoGgoJClG33T7uI0TZiG5sKp35lDTKLszMT+r53ZTChNQ4Xo0/bdOJPHI/2WqtKo10rDfoJX4SDQDd9U+gn+JmMMliO9OmzWd+R3Xynt+W/kHGMZlyxIvOUT0BVRT49yY6mnStjjg7wdCFYpR6NFEp9pBHN8pJLsp8ccqYwU3mVBRAqlJcgSS0ITfmcaDrrbcFRy9jGX+AypaOJF/S
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261026140227099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 mlbKXuYPQRGfBxYbHdfz50HVvcqfgG8s4cCfUI3e0Qv6r+AbcwCooqKApMSd9OueG2OUazMGT+0PN2cpK+o1004MqLKRSERXI3yKN9zgdJGP7YWI9R6Nlcrb/CknZgj+qxlrhGPLNC9jKfgy/y3lu25Kr4fXqOAnWmZoZs4daAG/XMIJKkvVKjTqW8q1vbQRgoQmelAZvXsN5cWovMAQQHQW+yTYGcJ/yH7k8OVZMECU27+tw3T3ufvab5/V2EGB/qDi7blIhXeaLc3WLiDoEov+To+rIgyzK9rdpkt9ptNz8n9gumNjdqYoSyCLFOUFixzWJpCYjd/jC67kID00RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR08MB926493
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 WA1PEPF000099D0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	29e58e0f-4686-4b11-d420-08df43d1fe8b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|35042699022|14060799003|1800799024|82310400026|376014|7416014|36860700016|10067099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|261021135927099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	roL5UOnFhpyoPYkWgC3/3J4KG8kCKZyK/Pkd2+FEb5s/XFHqXoJvMmWwevYDY/PgjzHBYqfXLhdqZ4COkxHb8HH5wR4lc9XzD/n5yco5qdk61tqFFj7JR5Pv828QhoBCt0JFPTv0ovayDHlj5BxtIge+yS6YX6sG2JOG83TRkJBceZtfI88MGX3kTtIJZ/GL5sDWV7jDUtBJV4E2wP2Xq8nbWeWWJ0FPfNyJ0qlLdxUn9PtZQNWG8ZEANm5aMpCQ1R5vnAxWkpPpHugBB0x2EbahsiMHFKS+4Ol5sveZ/jFOhrUs/cTDwYXGLQvh+X4e80oSkLtruKJFVsUcppat8zmdjJHdz18nh1xOMTvuP67F/nEVYaIIk7/riNfXf1ji/4cjo4xwdOe43IAjTNj9kCjiDvt2s9OzBhUvt19c4GjNgrbJoKwJ02QXT5sWjX10dU/OC6+Fd6b9JUWmVe2m2ALvifVwTd8q5CFp7pLR4Skx3YyWXboqx78YSG7UxmDEJyef3kjGLesPjI/S/Yh90YSerSHj08GueINAf+PE2SnM2N+joLvtga8+JX3AJ7iCyAo9XoO/sfLhobncVVJH4DWQMnihLg9C2E74Vhpcwn2/HnHSfpA43QmEU+uYadupIVFCGAaU1Qgl18D/HW0v3NurBKjbgQy1+yaBlclrVXw=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(35042699022)(14060799003)(1800799024)(82310400026)(376014)(7416014)(36860700016)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261021135927099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8fZvJFaOgHRwCJmH3r3GKS3Xv9V5cfaH5XEKu2I+uF6MB2YnfwPgr+KD+r1NyDnl4PgnrzMIDvdrx7HL6ued3hU35c4hYy1KZkWLjg2dhw5ZxucPvsx+WRV+LRrLRsHp/wHYFHLT1Qe5d8sWPb9xqVVuFWD/0Mi8VzQ4JTuw7FDWqEDaALoYZJFnIktch38cMWf+DaPidNUbikO6slBltFMaQM+PynIs8iesYBrEilzgLQ2igTw23lBNML1PG0OCbUe4Dwj4lPI044QCk1Ar5D2C4XV4MSvp/tH0Z1HyossdWOx0G3LSbsqApdUygO9DM45HgXZM2G0Yhq+j4+2D0oeqk9alJKj74vvkXpcSezFcH4OIFwga1AKjTFSfdGdBaurKmnKR340yV6ht4pttGxx689cNF6qk+eTjAnH7t8JijmeEAoJO9S17Pbqny74t
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:09:25.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bddd10f-d463-43c2-b14e-08df43d21366
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099D0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9033

On 11/2/26 05:19, Nicolin Chen wrote:
> A kdump kernel cannot use either queue. 

I'd say a "kdump kernel cannot use either queue without potential problems".

> The crashed kernel's CDs and page
> tables might be corrupted, so events would spam the EVTQ, and there is no
> way to serve the page requests that would arrive at the PRIQ.
> 
> The reset routine still enables both of the queues and then masks the two
> enable bits back out, having already programmed the queue bases and taken
> the interrupts of both.
> 
> Clear ARM_SMMU_FEAT_EVTQ and ARM_SMMU_FEAT_PRI in the probe instead, so as
> to entirely skip the queue initialization and handling in a kdump kernel.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Link: https://lore.kernel.org/all/amiBagGKn-Aym1DK@willie-the-truck/
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Breno Leitao <leitao@kernel.org>
> Tested-by: Cristian Prundeanu <cpru@amazon.com>
> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b1222d6f771cf..18ba48464da0b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5244,9 +5244,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   		return ret;
>   	}
>   
> -	if (is_kdump_kernel())
> -		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
> -
>   	/* Enable the SMMU interface */
>   	enables |= CR0_SMMUEN;
>   	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> @@ -5573,6 +5570,15 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	if (arm_smmu_sva_supported(smmu))
>   		smmu->features |= ARM_SMMU_FEAT_SVA;
>   
> +	/*
> +	 * A kdump kernel wants neither queue: the crashed kernel's CDs and page
> +	 * tables might be corrupted, spamming events, and page requests cannot
> +	 * be served. A disabled queue discards new records without raising any
> +	 * global error.
> +	 */
> +	if (is_kdump_kernel())
> +		smmu->features &= ~(ARM_SMMU_FEAT_EVTQ | ARM_SMMU_FEAT_PRI);

It's less than ideal that we unconditionally set ARM_SMMU_FEAT_EVTQ at 
the beginning of this function, and then here conditionally unset it. 
Can we just conditionally set it once?

> +
>   	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
>   		 smmu->oas, smmu->features);
>   	return 0;

