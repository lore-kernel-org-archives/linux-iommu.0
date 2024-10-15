Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124F1714CA
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728961577; cv=fail; b=UDCiSBvQs8zBiVn8MLeXqYCF4G6TxdmHyU+xQswFAT+eXPbdAX3aoUNX+ZdsLOn/bmpdv6z228AJsIkxX083W7fK/nmeKr5Uud2AZ4QgbkmJ/0/zSH8gJXQFIOnN9eekE3DoxX3pgMfp148RspyuwYz6swaGc1+lIICmyvWebcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728961577; c=relaxed/simple;
	bh=DfcneFLqdBdGmPAJczvPNYpaTTk2MX/SRs1lKzSSUOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hVet0kMt+a4SUBCCSNqK6O5pRiAl+k1dP1ZSjIPQrBEVxqPNyCXN/Xvq08YTcdlOxoz80ucq4wrSTzqaFwDcwiXlo+e3tQURgX22daGqT+PmxOddVI+D7XKFQek5rkbHZxu8vmAY6ANIyGMGnGWNjNz70k+fN3UcJlFYPKCLVx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NYBVWvxI; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NYBVWvxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBm3pusfHiS9FAIlz2hn6Rf94xSDPZ5wno6iF2wbILYP18FteDcuir6NMclV6/UhwnRpFthAVq6UHOgopEQikFxBNIU4SuMp2vbGBncJ0NjZLSSxOF/CL78gV+HIrKthS21Ds1agkx+jzcF79NX2gC8KzERTFhrUporSG5PDOLko4h1PBgilJAR5zm51K2bBC7B5A1TqQ8+HWA3d6v67389uON+dO7IVsY2ozpnub8QNTsOl4tIPQD7ypM2pBp2qEM8LKTrvmHgQjqACxxUTutc2qNHY33WeMTbxu5++yEhb9XCRSsjoi+dXNxsW7TNZypQ2YpY0Xdc9QZNoG+DqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OAVDj4lxiUm9B2gMs19l7f2hsZrxwWooSsM29M+/kI=;
 b=DNQVq0WJU4dMqF0lMzAcWSS9bLkg0y6GUzXxCMRFaVY7r/44VEulBG6IaiOk05+/TK5LSR5430lpJbC73wQhx8jlFccOWiXYiPvRVgY0PZpYGixejrjbwTZVAErjJ//ZJFr3XEeSby3XzsnzA+AygqzZZv+Ik6TiLztCIT4TXvoeIeqCMmyVKuPsNDfA6fd83WyemLLKic2ZOQCRh0lWbv7MmfYyZYTtGJYjzOtv1afrcE1Il6d+IIz5lSD+GycEoEayrqQkBWcmv0g7YJULNRh9+pC6MrpT2zzFBImenKqTB2vf3BqGZpKbbvwWI4vmdoJYnMpItqcvLuGZwfQLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OAVDj4lxiUm9B2gMs19l7f2hsZrxwWooSsM29M+/kI=;
 b=NYBVWvxIoN+5VTh07EpQXaa5hAJF8yK2lsCsNVEoPu4Lt2TYPAmfQ5+PCsFCHvsTTSjUrBduobFGRPcS7sLk98gEjnHJOgBzYp7+mfif5JGm0vQzhx0zIxlAgu5pbxTVH6AaoJM/aVdHn9A0DhglV31fS0SF9aX7c8riAm2SUThO7c+1gRxurYxy0FQbLWVdCDGZowURyPX4IcGcdUm28feEvXfA78EAwxFrWfz+Sg8AvzAAe+cfTrOxi71EuZrV68XMCCDMN3kBms2DoZsdqFcGmff/vT7Z3q6FlVSMyINbU4MtVbOrHL3xxydkSN0Qf8CnJy6NImCvk5dyIUaM2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 03:06:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 03:06:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 15 Oct 2024 11:14:43 +0800
Subject: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
In-Reply-To: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joy Zou <joy.zou@nxp.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728962092; l=2967;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lDCDQiGPOSRXc7ev1dUa1F8oSAhBoTCxcJi2puh3lOw=;
 b=fIWBFLYMswv9hNrVHTz6dQ2yEimP0aeNQGlcDp3joMWgSJ2N62QpiooFtiRX86YTStp97zcmQ
 zoR15HltTAFAGM0jrzS5kH9Hvz/JgRMXprlCNpIyzeRTyM+L8m3uMv+
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 35428267-57f9-435e-7815-08dcecc65321
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVZnZGtPbjBRVkZ6eStacmdDUFBoZVdiK29UdGNHRVV1S29YTG1sblhWQUxK?=
 =?utf-8?B?eVF0OU1wL2JBNXJMQzlUQ1lldWxkT2MrdDNvTEtnbkhKQXBzSjZJNE15RVQy?=
 =?utf-8?B?NTVIaFZwVWI0U01UV0g2Q05JUis5VlVVSGRISXY3SzdnVHphL0pDZFVhVkY4?=
 =?utf-8?B?ZGo2SDJNdHh1WG5hQ2RTK2FFMXMwRzZSU1lPdWRRcTJmVEFSTUlkSGR0NStN?=
 =?utf-8?B?ZFAwdks0UEVERFYrWmRHL2I5V3JJRFBoM2hnWWtKWFBaZ1QrdSs0dzVNVmlo?=
 =?utf-8?B?QUxwb1RaSWZwVXRiVW1NOHg0TExQdURINVFVbVZEUWJNamZBNllYTVhpN3ZK?=
 =?utf-8?B?YzhxOE9oWFNHQUtIdU1HRTBGNzhrTHNqRzg5TWZ3UHBpWFhUdmw5UjV2L3ht?=
 =?utf-8?B?MkEzYklyRE85QnJLeUUxKzAwZmVmMC9ZUkkxUWZnekJWVjgrR2VkNG5jZzlP?=
 =?utf-8?B?dzJBemlla05zZzd2K05EU3o5US9KK04wL25VeC8ybU50eGNUbEE0Wi9icmZL?=
 =?utf-8?B?ZVY5Q2hhditBSkJkWFBTUk1oOWFGdzV4bGo3aDZpWFdzYVV1aDJXczlmK0xp?=
 =?utf-8?B?TkNaUVczd1JCVnhNeTUyQVgvZXpaUTA4ekg0VGJhclF4ZkNzUHErdFdCQmor?=
 =?utf-8?B?dTR6Y3ZqdkYxeUp1dzlPTE01MEMvTlF2ZkRpV1JBbHZvZW5pVkR0ZzVQSDly?=
 =?utf-8?B?UEN2Zk96Q3RSb3RtaHlDN1FrelNsQWpXT2JJaUQ4OWFXdnltSU54QmZibUhS?=
 =?utf-8?B?NmM4aXVrOWVtOU9yemVpM2R1UEJ6L05ObXl3VVdPVVJoT29YMisyOS9mRTh5?=
 =?utf-8?B?a3lId0J6dnk5QlhHWlJJNmlWV1poZ3FvRnZsYXFjKzNqYlpRWlZzWUFqV2lU?=
 =?utf-8?B?Z2lIa2h3Qi9OcmdPUllOWjBvY0xLbk01d2RPVGJReVphWEhUcmFoY2VGOUMx?=
 =?utf-8?B?cXBkUVRrVG5XRGRjcU5yOG5sQkNFYm5paVhkL1hWTlY5NHpPQmczQmptckwv?=
 =?utf-8?B?bjV5ZTRNQjJzcTVhUFM3N2pUckxWaVR3alRqVVBpOW02MHBCdmIwQ01jcnYz?=
 =?utf-8?B?ZDFLSE50MG5qeU9TT2VrcFpsVy8xWnB3MDM5RFRuR3FLS09VajBGellBY2ZV?=
 =?utf-8?B?RDNUbEl3WDdOa3EvVklBTWhtUTNKOUs3TG5WcXNXRjQrdXZSZmVsOHFmRE1u?=
 =?utf-8?B?SlJyWHpScjJKUmNIanFnR1RJa2VwRE1jQVJMbzBzcmpCdnNlaU40NDNJTEJP?=
 =?utf-8?B?c2RBeFoxZ0laWXdhbThMek5oZ3NUVExLaVlDbWFqYURQVjZORTd4RGtVRThE?=
 =?utf-8?B?cUZhZ3htQno5UVpReFlzTVBLcG54Y2kyYi9ROEpsTk95b0hJT2ljZnZjME43?=
 =?utf-8?B?T1h5NVo3aU5UdXNGeGpGTGNaTW9kV21sejFhS1hxV1huWVBaOWxtNGF4Zmdk?=
 =?utf-8?B?ZnI2bmQxbnVPZEdGQ1Z1ZkxEUnpiQm5oZm8zQ0c4YUVHUWFTQnFKQkV1WTVh?=
 =?utf-8?B?Q0RHUm84RkdLVFY3ZW81WGVVZEF1aEV0UUlsSXMzMmpxUmNZaGpTVTVxeUlP?=
 =?utf-8?B?ZXQ5NkxycGI0ZUE1SUdQZDZqTjJoZEZ6NWxuVGpRMWwrMzBGZ3R5Wi9Fa3Y0?=
 =?utf-8?B?bFFqSExUelZtOXZvYjQ1U3U2Y0docCtaM1NTenI2YlJRcFpOWEZSRC81VFNW?=
 =?utf-8?B?WkhWNkxpUlVacVV4cW9rMWUySndPaU85K1p2WW9JeWpaN0J1UHN3VVQrK0NK?=
 =?utf-8?B?R04xdExaRFVwTEc5ZTI3Yy9aL0lmOVRIZjN5dGt0aVRZbG56dngzOXVxYThJ?=
 =?utf-8?B?TVlmNHFueHVKU1U3Q1lCdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlVJWEFseUE1UGN1eWp2Ry90WWpvYmNEZCtqL0NUbFV5bHEzR09DZFVaTXBH?=
 =?utf-8?B?bEV2OHE2VmxjNTREOXVhOFJxeVgybDBGUWxZMDRLN3BacW1vMUtaNm9adG1o?=
 =?utf-8?B?MTQxN1FzeUVmMnAvNW9wd2d0MG1rdlVWcHlTdkhtdXZTcW9Qbm0xUDRheHls?=
 =?utf-8?B?d3RtOC8xTWx2bWdxUjljTS80eWRJTWZkOVdacmdmcFRWNTZud3dIZTArdzVD?=
 =?utf-8?B?blozREM1SmVyby93RXdSZ1ZHSTdreXRGYkN0dEVjY2QxaGV0K0lxVFNrbEJN?=
 =?utf-8?B?bE9yYmhwNStRZHdHZG5YaytrYk9hbkd6TW9zVE85RWhwd2JvQzRmejdmR1dG?=
 =?utf-8?B?NmYzNlh2NUttVGthWkNQMlQzZTBmd1M0N1JLQ2g1RC9Qd0ZMcmVhUjlnK1c1?=
 =?utf-8?B?VDRrY244d1JpRzQvTE9hbkVjWEswSkJFc0xzNy9GRm8vTmVSM2p1c2RrdUlH?=
 =?utf-8?B?VUtsem4vQm1hTGhrYmtvcU1xOWg1SHd4cnpMSWV3K00xOWs2UklmcERWZUlX?=
 =?utf-8?B?b1QrRGhabVQ3QjRWWDEzL2gxOE9OS1NHRjU3ZU1sUkFQa3Y0MjlGOWFyMDls?=
 =?utf-8?B?V1FiS20wUEZFQm44L2ZWWjJmUUVEQ0FjeXBMMCtuT2tPZTRwR1lUWWJLRXpY?=
 =?utf-8?B?elpaWlJzdzZmRVFrc3lhdWNkTUlJY2o3Mjh0NlBSK1ZSOTZwTThsUVdOSlhn?=
 =?utf-8?B?WmFZa21YU1kwLzN4dmoxYjlRME90eUgzL2l1QkVxOTMxZTRaekVUMGJUN2Zo?=
 =?utf-8?B?SHhPVXMyYnNCNmRvZ1ZDQjNSblZTNXRtYm5Pc2lMUkRYUzFLcDhkZjFlcDZV?=
 =?utf-8?B?MnplWk5UZElRV3NqSGVWcmRJQ3B3dGRiT09vMUIvZGtMbTE4VmdOdDcxbjFK?=
 =?utf-8?B?bm1FQnNpS2QvbUE4VDZBN3Q3L01xeUt2UUppbENIWFN3ZVBVUGRDdTZDR25Z?=
 =?utf-8?B?ZGdIb0xPdktQVlYrdzFySHROSkx6Vmp6dCtJS0lOMGlDTUovTkFWUWVNSkE3?=
 =?utf-8?B?YU1qU1p0emk2UmpZaG1QUXdTS0hjbmJFWFF0bkd5MVl0aVQwclRhMlJVZ01y?=
 =?utf-8?B?UWpJeXl3OWU0TFo0d2hnTkEwOEs4Mm9QT0NHQVJrVjQrODBrVitvLzR0Wkd1?=
 =?utf-8?B?c21ucmkzbi90akhSVi9PYmFXQXlOZitpaE41ZzFxMDFLUEJtZ3VSOWtsbHVP?=
 =?utf-8?B?RjhzdGRLTzF6QlVhQ0ZhWkpuWWtlWnVhLy9lNmxnMmNHdUMwSkJHV2hpRTVP?=
 =?utf-8?B?WmdiL2R3d0JOQ05xaXZDcktPYitqUmdadUR2dkFTNkJRRzZuY2pqSlozcUNo?=
 =?utf-8?B?TzA2ZXFrUjdPd2Y5a0RGWTlSVFVKd0ZHY2VGTndHZGhvaWhZNFhwYzBhZjZv?=
 =?utf-8?B?N3o3SUZBc01kWlpFRVZ3blRXMW9rRGpnVG9FM2NvMWhFRXhoR1h0T3RBK2VB?=
 =?utf-8?B?bGQzNkFPdmhra3FtdkhZLzQ2b3Z6WUdyaTJqdklScEF6RTBPUHFzaUkzMHow?=
 =?utf-8?B?bXNUdS9wdE5GRmc5Zmk2K0w5TkpqS3JESlNLYWIyZjh2QU5UdkpXc0d1dEY1?=
 =?utf-8?B?YUZiZ1BDeFZEYUxmMFg4K0FYenN6TEVHZjR5cHVDY01DK2d1Wk1vdDBIbVhx?=
 =?utf-8?B?VGhTdU5QaUprOGF0b3F6aXN4Y2llbHVqQWd5OVJ6WGZHY281QTdIRzRNMnQ5?=
 =?utf-8?B?a280RnVsWkJQZmFieElUT0s4K3FrTEdiRXZxbzF3NWEwWG9wTUprOGpta2k1?=
 =?utf-8?B?NVhqMmZDZnR4WjZTblAvZHZsWnk4ZFFwSHlZbEdHU0xsTTJqdmJ0M3pyVkMr?=
 =?utf-8?B?SHB1UEt2Q1VXa05DYldsWlRvUWtQaHpVd2U1eWhJdldBcDJFZzhZbmZJZHpl?=
 =?utf-8?B?VmlHUjJncnRiSk91SzgyUjN5SlY5RzVZOHN1cEo5dWtCZlczejFmcTRaSFZX?=
 =?utf-8?B?TmZIVzlmczhQUXFma2JCNUN2UG8rUEkzc1VoRHRSZ0hCT3V0STdpdnBvT2xU?=
 =?utf-8?B?ZC9SL09XYytyWWVWblB3TmQ5NFZBSXZGdU11V0J0MHE2SnJsdmozTS8wSHlB?=
 =?utf-8?B?eDlLK0FMNkNuK2FVWlh3aGNvS0N4THVPMjB1NzJoQmluYUVvNFg0ajFzMkhx?=
 =?utf-8?Q?UTJmsy3eWl8uC2mYMn3N3rfs1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35428267-57f9-435e-7815-08dcecc65321
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 03:06:12.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYmwQJ+52sG1WJgM+Sjsj5RDY5xUkGCwNbpj+zbM3wxzGxGM1NiHGsZWUUXXImWDhdhlXULUMW8z6Z9B0PpbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173

From: Peng Fan <peng.fan@nxp.com>

i.MX95 eDMA3 connects to DSU ACP, supporting dma coherent memory to
memory operations. However TBU is in the path between eDMA3 and ACP,
need to bypass the default SID 0 to make eDMA3 work properly.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 ++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b88235510e3ddb91a28cecbdcdc14854b32..3db7b3e2ac94e16130fc0356f7954ffa1a9dfb33 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -80,6 +80,7 @@ DEFINE_MUTEX(arm_smmu_asid_lock);
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
+	{ ARM_SMMU_OPT_IMX95_BYPASS_SID0, "nxp,imx95-bypass-sid-zero"},
 	{ 0, NULL},
 };
 
@@ -4465,7 +4466,7 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
 	return devm_ioremap_resource(dev, &res);
 }
 
-static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
+static void arm_smmu_install_bypass_ste(struct arm_smmu_device *smmu)
 {
 	struct list_head rmr_list;
 	struct iommu_resv_region *e;
@@ -4496,6 +4497,18 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	}
 
 	iort_put_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
+
+	if (smmu->options & ARM_SMMU_OPT_IMX95_BYPASS_SID0) {
+		int ret = arm_smmu_init_sid_strtab(smmu, 0);
+
+		if (ret) {
+			dev_err(smmu->dev, "i.MX95 SID0 bypass failed\n");
+			return;
+		}
+
+		arm_smmu_make_bypass_ste(smmu,
+					 arm_smmu_get_step_for_sid(smmu, 0));
+	}
 }
 
 static void arm_smmu_impl_remove(void *data)
@@ -4614,8 +4627,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Record our private device structure */
 	platform_set_drvdata(pdev, smmu);
 
-	/* Check for RMRs and install bypass STEs if any */
-	arm_smmu_rmr_install_bypass_ste(smmu);
+	/* Install bypass STEs if any */
+	arm_smmu_install_bypass_ste(smmu);
 
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1e9952ca989f87957197f4d4b400f9d74bb685ac..06481b923284776e7dc4f3301e5cbe8ab7869a9c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -733,6 +733,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+#define ARM_SMMU_OPT_IMX95_BYPASS_SID0	(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;

-- 
2.37.1

