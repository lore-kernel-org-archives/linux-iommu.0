Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794798046;
	b=vC5TSPmzRdU5DrRlm5eXIWykaEC/q4zY5fwfjC5c679qgizmQrsvLeVTOnHunRIq3Gv6
	 KuacTxdgtA74TkqjON2+stBjwJm5t0mclNhiaVsSelrRPExPt05WVxwsyHtbFQ9oOK5BI
	 nBG3KhOmoS//hpKCB0JmAtUK4y7BzKkGCuZ1n3TCOGgWGUS94lOF/4RGW1SVu/u2nxagf
	 fAbuj/bJh8rIDpWfVcY+Fpx0K9ZRkkEp5hY8u8DkeIZwrqOO3IE5B2yXho0mfOs6huyzb
	 2m9fZtz1C0BFY6j2I59xWvanvCXkytglU+Fdy29ihLjmJZY+Dywzm9aIgzhGcclE1kA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798046;
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
	bh=AKyVVULTtlEwweMNh7FmNsB/1Gv5yzdKcsrYTOI9gvs=;
	b=C4loFuj3HsdoTvDJMy8YZIxVtrcgA9AReCvKsxXh3kFlOWzyWQ45Wd2XEd8b46V43nKw
	 z2VmewoJQOb6TYtmdwJQ1ywmEoBxskwvQrRtHZv9G4+EDHhN3RuHZTAPu+qQKwfRKFgCZ
	 OtaP3qnHgUwItFu2Zq5jx9xCo4OZ0O6NIJmUsAByS2ChjbGSAJj6FivduzbJvAnn1ThdO
	 fZ1FFbMUQ7g56oHxwr6VH+QoBQT5aGy0QeM8GQb9eXjGvfuBYgCx+iHWMI+31aYBLjzDS
	 HG3XacCHTgyaX5bz8v42+618c753uEqRzhs0YXA8F7bV+UzqvGDgrTblpLO9EbfYYkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Y8jIIkEz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.17
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B5606A31F;
	Mon, 16 Nov 2026 03:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261B5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Y8jIIkEz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYSjoKxTokTpy1auXOKiupEm4M+UYwOwNuj604Oa4e1VE7UoKxF8DRst303Te1hu9P24DOlNA78nnfAngpqyxcZlhC0f8qjYCsnaSc+yBpfMr7vnHesN0FXFeO2LHRO2Cy7kq9fTEWwwihWKpLl8SrG9J/+w9fjMG8e1UnhvG+aGNU1OyBB1BW3wQD2laYZSKfrm7o7DWdOkHKcbk+qLVUQzGHT8w3w2EOagi3xi/2xSkuTFCJpE9WyfNzINrpsoobzkSe2XO9Ag8yGDV2rH5hBPN1lh3WgMgAxuGqKAvjS1uNYmCiGFDxYcextCVvbDtsT/smCZyYeMirufTbRw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKyVVULTtlEwweMNh7FmNsB/1Gv5yzdKcsrYTOI9gvs=;
 b=WbijhpOt3+ZLamq3UK7TZgp2ypXEL+K9h8KKf0r9GuhTPwS8U3+AuoCjH/17NOxq0fohhG1wYDrO2hwVaoJ2/YANNfK6JPCCkH5XMvLoUpPGV7YQGn5Gta7HQQaw/dybgoVeWzhf3TzymkZHH3GISAVFUoaGDsHhTRAdoGw3URYvIPRZUytHVEaRpAWM0z7DGemSI2qRKbMYqU5RoVErXqlOzAlIW8MRU195YASx9PdXkY0jPpr7CYgtF629GVYezqlwB+vgNxAlDK3zzavj0lQFx7l/awF7RllICQqZq0kKrOCjEUG9bYk5fSlG6sJUddhozx4rAgRGSAIGE/J/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKyVVULTtlEwweMNh7FmNsB/1Gv5yzdKcsrYTOI9gvs=;
 b=Y8jIIkEzEfbj2n2UwC/BzRhANGLbdkfETco9CaoC6GRLjaeMOlJFMTfTe60KD5c1R4RZpb84I8VCDJwW98U0Y3HN3mjnMkVwoRS4p2xnCaDDZgHlNJzROsVbdKDGihk7A0PO3wpIg0OiqVEF6CFuuIosRfMF/N5yCOqwou1BgkrrLo2BSXyNBglqmZsy82sbS6h3puTkMbHq5kAcZdD7XnUvGz3vMHs39gO07yspI/4czl7qj0E5TbjvUiwF7DbGQHlSqa/KvEmBPHMew5ZVDriU9q1MeZqmWCHwE97YCaE1KPpk/HgG5roZGdLMX9GZWzCclCD/8bits2fPqvas1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:00:43 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:00:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 16 Nov 2026 11:05:23 +0800
Subject: [PATCH v7 2/9] dmaengine: add a bus for DMA channel devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-edma-iommu-v3-v7-2-32794ba8efbf@nxp.com>
References: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
In-Reply-To: <20261116-edma-iommu-v3-v7-0-32794ba8efbf@nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Jon Hunter <jonathanh@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
 Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA6PR04MB11778:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb6f9f5-f5b0-4998-ded7-08df438dcdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|921020|10067099003|11063799006|56012099006|260925022911599003|260925021911599003|260925021311599003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102124527099003|261102123227099003|261102130727099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	PXueT7nQGiT4r5iqLQqMWFhoq76nB4DI7FLks7jwMMyhuzepKxHM1B1/OmVRxckjsgOqtESP7pVdLskqOKjXLxhAYxxTYARtg4GA0ErNnDnW8CL4je+RziTTbCYjbHzzAe0P3lnYi4edStkhnpgAkk0IiTmftsmVJQbM9lciYpZcSIQIjARzZRTyqN3rIAmdaU4vc/IRvKeEr11SfL+ulGZ26ioq5hwHcbhO4Yf9S4Xla2EHVIpuHiOC+q0TB4lKhsFsV/t+pGrzoIVLnb29DMJsG0mZtD947vaVrr/Jfp6DhXu25pomFwmhQ3M2VYGhM4zt66aKc0LPqPeZIdomQ6YhLB6vFKf8p29lWGuJSrfb3+1C7Km7c1zBlmpnvvfgOi79cZKvQ4ZrLASomiR/Zf4LxuHgPyoKFZivf/d780io9YkLtzI947EqTiIf/SO4JzDkS7mYbqb+e7BhudXVuWxVEJ6uXAdbXxVo1idRBi8+FBQENQTRK4RMJO4OBCLCv4xPwzMk2Xg31lAo3gjaBK1fa6QAoi//tlx0Uo8p2DlArJDm6R/Z6EAeZ1XejkhR20Dug+je5FlSvRGSP+HfgpgirDq4XaoCA6eKC7/Ec7jBvomeQlai/B0z/y1WXp76avZhelCZpEVDGWrAOpLVb/ijhYx0SC1KvpXvG8ECzlTAeXNRw3pdS8XagjLsaSLQHUxLdEsW06Xw2QtabXb+4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102124527099003)(261102123227099003)(261102130727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEF0S1lZS25mdEZEbDZvTUVWU1FOWTZOa0gwY0xOSTJudi9TOG5CaTVmc28y?=
 =?utf-8?B?TGgvbmE2dUdjb1JCS1V6cFdOR01iZXVqUFlZancycExIK0hHcmNWYUlRS2Fy?=
 =?utf-8?B?YXhzRGR5eFJwaG5jU0JBdHF3RkdQay9YZ2VVb2ZYSnNzblAwVWViVFMxSzJG?=
 =?utf-8?B?MXBjTG9aOC81VWxEKzA4YmtxSmQwMW44ODU0QkFRRkx5ZFZjcEwxclVYenMy?=
 =?utf-8?B?K2ZJY05XRTZLK1JaNFVtcFUrWWptbkVycDZiTVlpT1JVMTZqSUJXV3ptMjF5?=
 =?utf-8?B?Y1dPbm83dURmQnNxWU9wQTYyODVFVkJCdDhwNm1RYVZqeGxrVldhL0VSVDZI?=
 =?utf-8?B?dG1uSGNYSlAyajdCeUwybVlLeFR3TTJFVUVIemZQU1ZLLzlzd3k3MTFVb3pM?=
 =?utf-8?B?b3Q4Z3c2ZzhXbXhqdG9wSFJpd25mSkVWTkY5TFM3aGZnbUw5bmVQTWpLYlU5?=
 =?utf-8?B?OFMwS1phK01JNmdpVHlqMWRXZ2VWV0JmNitjU0hiM1d2TDdUNGNzbmJFTk1q?=
 =?utf-8?B?Qm9sclRmK0RUK2xIMG50cmdsb3RUdWdVdlR2Ym0vRWZkY1A0ajhaT3RyYnFI?=
 =?utf-8?B?cWpQRkUzVnFVNDg0M2pWOFN6bzVvSGxldUtrSjBZcG4xYVZqeEtQUVgwNlhj?=
 =?utf-8?B?QkR3V2RocGZTMk9aMXl3cHNvdWVjV3VZb2NFS1V2SzhQRmFEbWQ4TURHL2RZ?=
 =?utf-8?B?OTNSbUdLaFlGS2tUbG80RUEvM3U2dVR2OUtQUUZxS1orQ084cGdFRWxwdDdv?=
 =?utf-8?B?TEJmWEFtSEJTbFFqMDM4SXVodTVkbVBQaWtCRnR5Tjk1UElnbGVmVkU1ejJr?=
 =?utf-8?B?RThFVURBaXhMWlFhYzdZVW1rbGU5T1pxTUdVRVZLYlFNOEtyc0p3UmdDMTI3?=
 =?utf-8?B?TDZMc0xaNnpNV0RQRVRQK0JrMlFOT09pQmxtenhodlJ5MDN6N0tpUkoweGhk?=
 =?utf-8?B?ejJBSmQzdk4yVm9RMy9YSlVXUWR4a1R1b1lxV0RBQ3hRdXBwZlFIWjZhVVpq?=
 =?utf-8?B?ZkpoaHdXbUVORVllb0JESmdmcUhsRDJPS3VDZldiaGhoWjFZb082SlcyZ1NC?=
 =?utf-8?B?elhHb1pLR3dKR0NTWU1WNW1PMGRLZHhhcXpxcHI0ZFVJRFk1U0Y5cnZkK2RP?=
 =?utf-8?B?cnJid25BU2tTOGw0aEtaZk5sQk1ESks4eVpUTFZsaXhINmJrZUFHUTNEeXRG?=
 =?utf-8?B?NGVxMGFYTkVWY0FIdHF3bGFTNEVPRWFvOTlZMnJkT1QrWEc1Wkg1L0hoYjZX?=
 =?utf-8?B?OSsveFN0UGJiMFcyK1lWR1J3dGxiZE9PUTVYMm5QNG5CL1V1a0srZDh6WjZU?=
 =?utf-8?B?V1lEVzRSKzRlcFQ0WndDL2ZlY2wyOGZvWWdYVjhJTElKOEFmbi9ENStvTlE0?=
 =?utf-8?B?eno3d3pGQXZQa0tNUXNSck15S295VS9TcS9keE0rNGxtRktNUUt2NmpQNU9s?=
 =?utf-8?B?aENVTjJIbmF4YXptcmduc29nbkpzK1QzQmROdjk4cVZnRWFlMHJiYmo0bFd0?=
 =?utf-8?B?UzVXZkp5QkExQ2xLWFhERnVubEtpd3VtcFFLTGRna3c3SmpFWGs0M2FtK01L?=
 =?utf-8?B?TkhYOGxDbm1uU0N1UUxxbk9tc0VzQVduZ1NnQ3JWZHY0ZUdkbS9CaVd2LzEw?=
 =?utf-8?B?OXhiWDBpYmlOY25XZXBBRGJrQ2M1ZjJHZ2Zxcml2UEZ5NHczd2pSem9GZE91?=
 =?utf-8?B?aThuWnJvekRYbFRiNk1OS3FhNDUzdW16NGxKeFlSYmc0eVlOeGlTYXNwWkdS?=
 =?utf-8?B?NEwwTHU4U2o2MTZmZ01jeW9ucUpVUjhSb1JlUTBqQjNEWU5lY2RHME55dURo?=
 =?utf-8?B?MjZ4RStQVUlSUlBUamhqcHFWT20wZUtLTVhleU1xdmQ4dDVtSWpMRXdJcW1W?=
 =?utf-8?B?b2tqVHdpMW1LMnpzNkJhc3JZam5wR2Q4aU5WRGRBbGxpOXRPVzBWRXBYeTEr?=
 =?utf-8?B?NlVMbzk3SXZFSlVTWktyNTlITzB0ZWkxT0Zpa2xBZTk0T24yVmRNTEo2elJZ?=
 =?utf-8?B?NFo0NVRCZzgwSmxnTFdiRVJmZUNWYnlCZ2lwUXo5VStQMXlLUmh2RnVjdGZT?=
 =?utf-8?B?d0M1N3lOb0pmU3RUMXBYZ0ZTalZpeXRPdmc4aWxrVVJJYnkxVDArM3hyWWxK?=
 =?utf-8?B?eGl1RjhQNERZbVhzRkk0WWNvWExHWEM0WjIvdE9zakxWNEluaDM5d1hyUXVr?=
 =?utf-8?B?emI5L2lhd0pPeUtob1M3TjFZRnVFZUhQRWpwWjMrUlFtRTFOenE0ZlZGaEd3?=
 =?utf-8?B?OW41cU56OHpPYUZFOHlFQUtQVlBoc2dkdmV3clZMSGdySWNVeHNQNSt5UU9q?=
 =?utf-8?B?Tmc3VWNEcmhZZXNjRUtHb2N2Mm53WDlOMFFMRXRJRTh1c0t4VkFaNEQweEtX?=
 =?utf-8?Q?Y6KZNq6CG/j3+taHkAflMfIK1PaLTHy1q4IxJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb6f9f5-f5b0-4998-ded7-08df438dcdc2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 03:00:43.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEvaTTlXpHNpb57wEm94hHOFwvS7Wen0hhzQJacmrYvC8nb/+iQWN8Xf/dD8VcWlLmnRMnGtrFXH+A4loNqjznOp0YAqVFHXxvuKUxowzmHssKaAASyHtugjYdlXAQUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778

From: Peng Fan <peng.fan@nxp.com>

DMA channel devices are currently created as class devices without a bus.
This works for sysfs, but it prevents per-channel DMA/IOMMU configuration:
of_dma_configure() only probes the IOMMU when dev->bus is set, and the
IOMMU core only installs probe/release notifiers for buses listed in
iommu_buses[].

Drivers that need per-channel IOMMU support currently work around this by
assigning dev->bus after device_register(). That leaves the bus subsystem
reference count unbalanced because bus_add_device() already ran with a NULL
bus, and bus_remove_device() will later drop a reference that was never
taken. For example, tegra186-gpc-dma.c assigns chdev->bus after channel
registration. Review noted that this can underflow the platform bus
reference count and lead to a use-after-free when the device is removed.

Add a dedicated bus for DMA channel devices and register it during
dmaengine initialisation. Use core_initcall so the bus exists before any
IOMMU driver can call iommu_device_register(), which iterates iommu_buses[]
and fails on an unregistered bus. The match callback always reports no
match, so no driver can bind to these devices. A follow-up patch will
register the channel devices on this bus.

Clean up the unmap pools if dmaengine initialisation fails after they have
been allocated.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/dmaengine.c   | 28 +++++++++++++++++++++++++---
 include/linux/dmaengine.h |  4 ++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 34be53487a21..e1022d297674 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1643,6 +1643,17 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx)
 }
 EXPORT_SYMBOL_GPL(dma_run_dependencies);
 
+static int dma_chan_bus_match(struct device *dev,
+			      const struct device_driver *drv)
+{
+	return 0;
+}
+
+const struct bus_type dmaengine_chan_bus_type = {
+	.name  = "dmaengine-chan",
+	.match = dma_chan_bus_match,
+};
+
 static int __init dma_bus_init(void)
 {
 	int err = dmaengine_init_unmap_pool();
@@ -1650,10 +1661,21 @@ static int __init dma_bus_init(void)
 	if (err)
 		return err;
 
+	err = bus_register(&dmaengine_chan_bus_type);
+	if (err)
+		goto err_destroy_unmap_pool;
+
 	err = class_register(&dma_devclass);
-	if (!err)
-		dmaengine_debugfs_init();
+	if (err)
+		goto err_unregister_bus;
 
+	dmaengine_debugfs_init();
+	return 0;
+
+err_unregister_bus:
+	bus_unregister(&dmaengine_chan_bus_type);
+err_destroy_unmap_pool:
+	dmaengine_destroy_unmap_pool();
 	return err;
 }
-arch_initcall(dma_bus_init);
+core_initcall(dma_bus_init);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 805668fbe437..be9308739676 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -412,6 +412,10 @@ struct dma_chan_dev {
 	bool chan_dma_dev;
 };
 
+#ifdef CONFIG_DMA_ENGINE
+extern const struct bus_type dmaengine_chan_bus_type;
+#endif
+
 /**
  * enum dma_slave_buswidth - defines bus width of the DMA slave
  * device, source or target buses

-- 
2.34.1

