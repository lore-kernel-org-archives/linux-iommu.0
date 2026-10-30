Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361918;
	b=G+Uq4PmxgtUsRiTe1ZJepOrEI8AW1zyMiqNxUsrY8RJQdlNYtcCO5q0Hp3LbT9D6SCCX
	 VIKzz2jUIotQ7fYpwBRwEk0d65aw+Jqgznt3LYPSL9icT/7O5/276XC5/jS0+CqFVHLb5
	 RYY4tZ5XaSY5sr1iz4oYMWmOVMAdycOEeYWc42hfNQcmUSBpvkTMB40NclwUUbxcCgFtz
	 URSpd9wM9ELQnJ4B5iDUl5wK7XyGNqsdmKc9XQ4x3Y5guDCIQPMVBmOztoAEqOO/KVcn4
	 HUDGs2sjRMqEiXcYwFNwRNqBSs3WYUjFQYsEY9Bt81AUkIcuC1jcQGjXCnp6BztfJRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361918;
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
	bh=WOANYC1qsLl0yA9bNjHNqmpcneeU13RDVxRkHJo+PCs=;
	b=kzuknkkd3Jl+qXtPpq4vUmauSNm5CGbRb6WbHpcy+ceshiScjhjI882V92nJjmdpuCbE
	 oBTJOHbprFyPib7Zqd2hxn8nHie4hpqo9CT8EoAZ/lNj/vYVw4V2JL29mU/KbTRVqWMbk
	 CC6X37Um9fX2cwawwAS6cF86DqNOr88JjSvNTQItYnd37D+b7OpYO1EZoOKpaZ622DNTj
	 0fxOGvTgY1sCru7exXYcUcCKoweJyc3J/6fK9qZOmNH/Irx6V/OxJJsEwHn+mZf1j1Apu
	 CKF78XHi3nTQWSHUil8OQgfRDyLxZQxCQDaQT9EkTyrgxql7LFvDKonqjcUx4uTiQdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CZAU6fc0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.49
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE52606A321
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE52606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CZAU6fc0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjVk+WPdRFdgYcJFSoRzMW+VDDV4ENHT4xjmKUUuk73+/va8XLQrCpHV15smjL0b3WE0Tay3PSdUvnoC/edEE+img5gGNTOKVwIQv3Tm973NHyq1DhqvCDDMc4qseizbCWDaC+MmatsEFrmsKVaw9zR7GAT9EWjqB0QNQYYEejZqMSqLq1eSucGf+T0yogntH8AWWD5Emxle+ljctO1R47K5sx5JVmwIdxn2DN1NtTnvxeDv3hd3QsmutBp1AoTEoFDNK20Ff+gbC1qNygTDTLQqoaP7TIJmXM0VbXEk+nAYw+Ih3ghaUcTfyS4d3KG1jyd3+izuaReJzCL65IFeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOANYC1qsLl0yA9bNjHNqmpcneeU13RDVxRkHJo+PCs=;
 b=P64amaGydt+iuAE/znFlmrHFiZJrNGG2uy87aGTj/Ci+UnScrtrTuZN7k2tRWimWCeoIJK9OgoUb6fc80ECpVWUKH64s+zzdZDbScJtZfSzwoInmEFs7kQL3zopMLvLNyOqGQonOOajWyRf/FdJj+uyXXt+9oZKz2O+XRTarPmJgOVVTmNUi9j98Yid/k/0MldW5esqy4JeaYUHRrgh931/9auS9MlSHG7FXD/4qo4UBljCKutJn/qG8jOKjem18t5MfTc+L750TeML58J+uboL9/AngodJVaoZV7bLd6BTA1+K4LMMZPTjv4O9C9pL1lksNuhJl8wWPOgeD44JoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOANYC1qsLl0yA9bNjHNqmpcneeU13RDVxRkHJo+PCs=;
 b=CZAU6fc0zYGvCTgziZaVUxsvGpVhq38VF1tEEu3nron4k5kYntvouoY/PB0iTvBDon3MjNQ4MgHY07Jbjrbif2VyiThRYlIjav+xcakFYQ0vyBL95ns2cct7I0CLPzWnjKl/lfJQk+ycbVz/OR+LtnB2glPVU+R1MYQWoHkd5siEhEZwtOXw5wNI2izXgLr0IRjy9ZatT77s/vtJdbn+SfHanXq18suLquhHRXMAJTnRzH9NuGDcVnrCPWPkEjOCcXyamYv3tBGA9tziY2M0IkIPdF0G3KICx4ZyN+7QO831j3HzhOoLS6srOh7Ej02EgOCUBYksjOr8gI4mLbQMDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB7021.eurprd04.prod.outlook.com (2603:10a6:800:127::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:05:11 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:05:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 30 Oct 2026 20:09:35 +0800
Subject: [PATCH RFC v7 3/7] iommu/arm-smmu-v3: Plumb the CD table into the
 CD helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-3-961726ebd6ab@Example.Com>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
In-Reply-To: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jean-Philippe Brucker <jpb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI3PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:297::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: fed8527f-3823-4b74-384e-08df367e0b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|19092799006|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RfpeW8W6Ze7gf/jb3+JS1dR/BZcXXjfsg9240Jx5mfXtrJ3oEKyES8jOFUwz84VeqjMlYJkvfDZKvjGj+NbyBqs/VmsfNac/DCqc35WuyFYU6EVRIlflH3xSCR7SYv+rsQSyP512VJN4KfzHgyg6g01KZ1uJef/LfuZoRyHx6F5W6AweLBNh7acKi6TmocgRhHFaXkR1YeoVww3aaAzEZSqOVAd45P6XAAo72voWcipHZ3FvS+FjorhDM4R5mvNrPVLDxWm5PP7Vik5fQ97+nmElwwF5nJkI3jpyAertTn3vv0TPoNMq5zdsTaSu7+9zqszLNf3+9FKFBecv33eIBoohuCRD7FbfpvDkTgDDEUOUA5v+uuQbncd7RhWo9MDHTZAaWzny5QGCT1jsGmcXaZylIAw+aoYmseN76T+ID2seJ7C2XuUNedS8d9B+L/ykhJRyyIz5k+vPj/1FypRgh5l/m5ltzkQEu9Sbm6Q2clHh6SLsse9ROEi1LAylWvwp2cuvnHdlNuZg8lUNbXl07PrVjMGrY/Fkp/XMhpOIaFJBwZ56vxvCQn5WreFVcHH4iekrjWbbK3uNq/kk0NJP2fAq/s64dh0CtWhpwS6KBUD9xFGUItXz5cr3QlUeymuUIr1XN3zUttu3Ujzw+zCZWyTc1Hy4ksrRUFHVQ0c59F0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(19092799006)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWN0bkZPYXdHUkwyZnVORlNlem1JOEtPMGZZdVpyMng1V2ZGYUZsMXBNeTBx?=
 =?utf-8?B?SDNyeTZJREI1TXl4eWFiNFFjL3NJL1llTDlvaHo5dUJsMTJRUmdhMnhnQU45?=
 =?utf-8?B?WGo3bmEwWU1zU0I5aDAwV2FMNzI1MGxNZEUybi8zbWdyalFmZldyT2dDMzUx?=
 =?utf-8?B?T010MnRSL0x5WnZyVHB6dVBmRHY2c0JGNlAwYmRtMnhPZHZiQ2cvNlBQZm9r?=
 =?utf-8?B?ck81V2QyQmVzVWQxdE9vZXBXaHBYYS9VUlliQ2M0UDZHakVoZlF4Y3VXc3F0?=
 =?utf-8?B?VEtpTzk3TU1WVHFGUld5SHNMNXRpYlAvYllpT3MwTVgxYUcwSmc1V2ZteTRw?=
 =?utf-8?B?SlRSRUZTcGFRN0VHVm5kVVRZbSthYXYrNzNLOWFXclVWcDFxcFp1ZC9yRlNL?=
 =?utf-8?B?Sm1haXlMdXkwK2Z1em15UUtpdVd3OTJ1TlV0NFFuaUdUUk9xOUZ5TmxvN2dK?=
 =?utf-8?B?YnRjM25QMEcwQVE2bC9TN1daRjFTM3lRV3BUd05GRno5K0FqakRmL2JpazA2?=
 =?utf-8?B?Tjc0a29WZHpvZ2tSamhtc1RoOTFQSGpnQVpUSVI2R3piZDYweVZwNlJVQjll?=
 =?utf-8?B?R241SnVodkdYRVJUQkFVUDR1REl0WDZPRi9mbm4vdklxaVJDU1ZoT0s3RCtu?=
 =?utf-8?B?b2oyWVdlcGdKeFhrRTY3RnExWk5pTUp2RnBFLytHcVc4NjF6dzRsMGphd3JF?=
 =?utf-8?B?OC9DWjlLMVRNVTNmOUx1OXMrNnBYUGJuZjN3N2NPV2I4c1dRTkFQck5NTHVl?=
 =?utf-8?B?WVZQLzJ4RVR3dzdjekZmeVNxanUyM01xck1vMGwvZWlFUzNxUjhPLzNBMzg3?=
 =?utf-8?B?NlRuRHpYYTBkaFdJZ3NpbXVMOE9vbmlBVFBVaXpCR2FtOElQUnpoVVRmaEU5?=
 =?utf-8?B?UGVBSWszQVdEeWMvYW0vOE0wSXJPb0VXcnZueXJBOGczeWJiNGtIdUJBUHdy?=
 =?utf-8?B?WisvRzhXQmdxa0p5NDFTRVVveHRBSk5RTWxWazdxeXV5ZTJNNjMyZkNGaURn?=
 =?utf-8?B?a0pwRjFBTHYwazFxc2h2a1c4WHJqRmlZVlhzb04veHAzTGJESTlmd2o4MU80?=
 =?utf-8?B?ako5dmNlNUpWeFlqQituSGIwUHBZL0NzNkxNRGM3NlRSdURidndPL2pSTnFv?=
 =?utf-8?B?UFoyZElGTlVTYzVEbUdqMHhzMmJuWFR6SUw1RngzYk81U1BQdko3dU9yaHg4?=
 =?utf-8?B?dUNKZUJPQ1VCbWpZUXRFQXNKaXV0RXRWRmN0ZHVudGI4eDcyWURPRVd6S1Bu?=
 =?utf-8?B?Y1hkWDVmcDMyUTlqSGdEaVAzZ21nUExyU3hjZkhCVW9GaTRSOTIxT0o4OWIz?=
 =?utf-8?B?L0dnTDlBRDdXZGxSR2swQkd2c2dPQlpqaDcvREZpblErMHBnVFpqMTc4SUxP?=
 =?utf-8?B?YlZmVGRhOFRtZEcwQXd4SGVuTFBNNGI2VEZzcG1KZ0I3ZWlUcExXckFCNVFH?=
 =?utf-8?B?c2M4ZjM1SmhJK3JFcEZ6dElGV2RjWjdTazZ5WTBIbFZFZldLeFMwL3RXU20x?=
 =?utf-8?B?U0E4bDlLMzFMckJMRlB3WFFRUXIwT1RGWFdjYk9yNmw4Rk1XWFcyRGEwcGVH?=
 =?utf-8?B?RE9QRHlMNEFuNVFvc1FqODRYenhDQ1VPLzZVa2l3b3ZESldEZnVEaXVLeU9V?=
 =?utf-8?B?VVBodmdTQ29VdHk0R1lOZjlSRXk1T0o2Qllabms3UzcvSDQ1ZmFSRVlWN1hi?=
 =?utf-8?B?dHJxM3p5TWJ0UE5YdmE1V3pjcU5IZVBzRGhoc1haQ29ldEo0U2JoNE5TanNw?=
 =?utf-8?B?YVg5QkRWM0dHeEU2M09Na1VvQlpMbEhYdW0vTS9zcDJTUzhtRERvYlBkemFi?=
 =?utf-8?B?WFZ2c1pLVlZCcHpETVpkQzJ4Q2xMTmJ6Rm9qeDRDeW5jSlYvcTNkUzlHS1FD?=
 =?utf-8?B?V21ka0RwS2VRVTE2cnNiald1bXJUNjdGb083T0M2TnpSRm1SczZLMnh4Zmxs?=
 =?utf-8?B?ZmJmaUlITjlLVVpzUURwcURiUnFDV1UyVXBhMTN6VlFVWGFDZnY2dkpHVlNk?=
 =?utf-8?B?ajlnU2ROMWdraWJ1RXR3bE1zdDk4M1RWZ0ppMlJaWTZGYlAybHlJbndKRDNw?=
 =?utf-8?B?dUtoaVlWVkhWNVNHVUMvRGgzMG1tamFQVk5kQTZYY0dldEJmY0R6VkFCbXpw?=
 =?utf-8?B?TFNEaVNsTWZzRWQ4Y0tHYTZTc0Y2WFBHVmlKbkNqZStXbDJ0MG9oZ1pGUTUv?=
 =?utf-8?B?bnMydThoNHlnZ3AvV3ZFYmIyNFNrMVBjZ1RpVVdIMWVKMVBWWkVtTXJQM3dK?=
 =?utf-8?B?ajhrY0xHamlXR1dhRTJjTVFhMU1wWnpRQzdEckdHNG91eTMxT0U1aWx4KzlG?=
 =?utf-8?B?QUJ6c0Y5OU04alp0RTQ0U2FZZnU1L0JRem43U3RpWVJpMVgzS1cweCs4U1pU?=
 =?utf-8?Q?NLxxajeK1wNJHHSRgOiD9WjwHmUO88yiGoOX0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed8527f-3823-4b74-384e-08df367e0b70
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:05:09.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rG+7wnbZcsdzekykYuTPwM4pUfqjAU8dQUO2h7RDaC4Uguq4GmAep+CsM8rTcI3lbM1Psw+aJcrSEKfocQhddNBMy7OLW8qZl5nLk+aEfX1qAWKfS1H5GUx9hxdXASxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7021

From: Peng Fan <peng.fan@nxp.com>

Refactor the CD table allocation, freeing, lookup and STE-building helpers
to take a struct arm_smmu_ctx_desc_cfg pointer instead of always deriving
it from struct arm_smmu_master. Add master wrappers so existing callers
keep the same behaviour.

Prepare for domain-owned CD tables, where non-PASID streams will point
their STE at a CD table stored in the IOMMU domain rather than in the
master.

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c |  3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c      | 63 +++++++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h      |  5 +-
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 5a4e45e151258..864d9f2350bc1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -215,7 +215,8 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
 		.stall_enabled = stall_enabled,
 	};
 
-	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
+	arm_smmu_make_cdtable_ste(ste, &master, &master.cd_table, ats_enabled,
+				  s1dss);
 	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
 		struct arm_smmu_ste s2ste;
 		int i;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ea755ea82192..51de3a0b8e76b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -122,7 +122,7 @@ static const char * const event_class_str[] = {
 	[3] = "Reserved",
 };
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
+static int arm_smmu_alloc_master_cd_tables(struct arm_smmu_master *master);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -1545,11 +1545,10 @@ static dma_addr_t arm_smmu_cd_l1_get_desc(const struct arm_smmu_cdtab_l1 *src)
 	return le64_to_cpu(src->l2ptr) & CTXDESC_L1_DESC_L2PTR_MASK;
 }
 
-struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
-					u32 ssid)
+static struct arm_smmu_cd *
+arm_smmu_get_cd_ptr_in(struct arm_smmu_ctx_desc_cfg *cd_table, u32 ssid)
 {
 	struct arm_smmu_cdtab_l2 *l2;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (!arm_smmu_cdtab_allocated(cd_table))
 		return NULL;
@@ -1563,6 +1562,12 @@ struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 	return &l2->cds[arm_smmu_cdtab_l2_idx(ssid)];
 }
 
+struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
+					u32 ssid)
+{
+	return arm_smmu_get_cd_ptr_in(&master->cd_table, ssid);
+}
+
 static struct arm_smmu_cd *arm_smmu_alloc_cd_ptr(struct arm_smmu_master *master,
 						 u32 ssid)
 {
@@ -1573,7 +1578,7 @@ static struct arm_smmu_cd *arm_smmu_alloc_cd_ptr(struct arm_smmu_master *master,
 	iommu_group_mutex_assert(master->dev);
 
 	if (!arm_smmu_cdtab_allocated(cd_table)) {
-		if (arm_smmu_alloc_cd_tables(master))
+		if (arm_smmu_alloc_master_cd_tables(master))
 			return NULL;
 	}
 
@@ -1595,7 +1600,7 @@ static struct arm_smmu_cd *arm_smmu_alloc_cd_ptr(struct arm_smmu_master *master,
 			arm_smmu_sync_cd(master, ssid, false);
 		}
 	}
-	return arm_smmu_get_cd_ptr(master, ssid);
+	return arm_smmu_get_cd_ptr_in(cd_table, ssid);
 }
 
 struct arm_smmu_cd_writer {
@@ -1721,15 +1726,15 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
 	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_device *smmu,
+				    struct arm_smmu_ctx_desc_cfg *cd_table,
+				    u8 ssid_bits, bool ats_always_on)
 {
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
-	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-	cd_table->s1cdmax = master->ssid_bits;
+	cd_table->s1cdmax = ssid_bits;
 
 	/*
 	 * When a device doesn't support PASID (non default SSID), ssid_bits is
@@ -1744,7 +1749,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	 * Set S1CDMAX no lower than 1. This would add a dummy substream in the
 	 * CD table but it should never be used by an actual CD.
 	 */
-	if (master->ats_always_on)
+	if (ats_always_on)
 		cd_table->s1cdmax = max_t(u8, cd_table->s1cdmax, 1);
 	max_contexts = 1 << cd_table->s1cdmax;
 
@@ -1786,11 +1791,17 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	return ret;
 }
 
-static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
+static int arm_smmu_alloc_master_cd_tables(struct arm_smmu_master *master)
+{
+	return arm_smmu_alloc_cd_tables(master->smmu, &master->cd_table,
+					master->ssid_bits,
+					master->ats_always_on);
+}
+
+static void arm_smmu_free_cd_tables(struct arm_smmu_device *smmu,
+				    struct arm_smmu_ctx_desc_cfg *cd_table)
 {
 	int i;
-	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (cd_table->s1fmt != STRTAB_STE_0_S1FMT_LINEAR) {
 		for (i = 0; i < cd_table->l2.num_l1_ents; i++) {
@@ -1816,6 +1827,11 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 	}
 }
 
+static void arm_smmu_free_master_cd_tables(struct arm_smmu_master *master)
+{
+	arm_smmu_free_cd_tables(master->smmu, &master->cd_table);
+}
+
 /* Stream table manipulation functions */
 static void arm_smmu_write_strtab_l1_desc(struct arm_smmu_strtab_l1 *dst,
 					  dma_addr_t l2ptr_dma)
@@ -1900,10 +1916,10 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_bypass_ste);
 
 VISIBLE_IF_KUNIT
 void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
-			       struct arm_smmu_master *master, bool ats_enabled,
-			       unsigned int s1dss)
+			       struct arm_smmu_master *master,
+			       struct arm_smmu_ctx_desc_cfg *cd_table,
+			       bool ats_enabled, unsigned int s1dss)
 {
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 	struct arm_smmu_device *smmu = master->smmu;
 
 	memset(target, 0, sizeof(*target));
@@ -3865,7 +3881,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
 					&target_cd);
-		arm_smmu_make_cdtable_ste(&target, master, state.ats_enabled,
+		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table,
+					  state.ats_enabled,
 					  STRTAB_STE_1_S1DSS_SSID0);
 		arm_smmu_install_ste_for_dev(master, &target);
 		break;
@@ -3932,7 +3949,8 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
 	 * the S1DSS is correct and this will just update the EATS. Otherwise it
 	 * installs the entire thing. This will be hitless.
 	 */
-	arm_smmu_make_cdtable_ste(&ste, master, ats_enabled, s1dss);
+	arm_smmu_make_cdtable_ste(&ste, master, &master->cd_table, ats_enabled,
+				  s1dss);
 	arm_smmu_install_ste_for_dev(master, &ste);
 }
 
@@ -4065,7 +4083,8 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 		 */
 		state.cd_needs_ats = true;
 		arm_smmu_attach_prepare(&state, domain);
-		arm_smmu_make_cdtable_ste(ste, master, state.ats_enabled, s1dss);
+		arm_smmu_make_cdtable_ste(ste, master, &master->cd_table,
+					  state.ats_enabled, s1dss);
 	} else {
 		arm_smmu_attach_prepare(&state, domain);
 	}
@@ -4436,7 +4455,7 @@ static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
 
 	master->ats_always_on = true;
 
-	return arm_smmu_alloc_cd_tables(master);
+	return arm_smmu_alloc_master_cd_tables(master);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
@@ -4510,7 +4529,7 @@ static void arm_smmu_release_device(struct device *dev)
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	if (arm_smmu_cdtab_allocated(&master->cd_table))
-		arm_smmu_free_cd_tables(master);
+		arm_smmu_free_master_cd_tables(master);
 	kfree(master);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 56ed6ad1dd523..0256119e9c137 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1143,8 +1143,9 @@ void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
 void arm_smmu_make_bypass_ste(struct arm_smmu_device *smmu,
 			      struct arm_smmu_ste *target);
 void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
-			       struct arm_smmu_master *master, bool ats_enabled,
-			       unsigned int s1dss);
+			       struct arm_smmu_master *master,
+			       struct arm_smmu_ctx_desc_cfg *cd_table,
+			       bool ats_enabled, unsigned int s1dss);
 void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 			  struct arm_smmu_master *master, struct mm_struct *mm,
 			  u16 asid);

-- 
2.34.1

