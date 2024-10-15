Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C516DEAA
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728961572; cv=fail; b=HkX6jcsVTiVgOk5f1OHl0tsvppuDNpSxnftY533zYQnDkUr5h01mJhEcNthFzTEu4i2cJnrVN7WGQoD1bdW7/x4PxaxvxYu7GiiuK/1iGCoAGWUPpBDuQ/5v+fLYAuICd7weg8V0bN4Dpxd02HY2PNDvlnish+3gIVg8hDm14EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728961572; c=relaxed/simple;
	bh=qUah2mtJDl+q0bHtwPVnpI0td/Gwha2u2BBA+Pck/c0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ueCnmjtt5cbefdk+p9B7+IhgnIqYC7KjI9ax5DP28qEeZrpr0XOfUCDWOOBq6XymWg96+shaYh5qkbenjwl1Yvm+5a/MgHYwnUOh3iuK4Z5IMDF66jIngq7gCiOlRHPeMCyzxc3w8kEU86PQH7MAXstfTr7QyPyhxe+cA87u1ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bj+e6ah9; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bj+e6ah9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNwPO7VNWgNmYZSSTO5zmyu06eIK2eRvKWq4hpeXEKFOf6ac+Nw5VlOXkhn7D+LSdHP3qO8HWqL9Uvx1LwjPVQ9rH5pc58Z6aHOvgZHrIto36ImGsUqj9ppyT3c2enj5zIWhV0PlYqnMotni3bEkn7tAjzxS24P98Jp6OCqLM7Mz7o3N4/gcSJt1CJzK1zTsvOJVMXP7sfExtjNMphe8MEhMhMuJluURWXE4p0iPXWugNXxWdpid8GUCZf4/WALevvIoyzXK7g6AtvpVCjrlIvpdCBC+d3WHCPf0yJnofqiOjGMATPH/66dFcaVEDsehR43rOIW/SHroHRy7bZ7kWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9J2nx9+4+A28xNXVtrIfnzoIRatgx7ccurFqhzjHeo=;
 b=G81L9cgzd98QGEeVgnDvLkBamY7xGiqoq8Qdw10VOgqugkMliQEEeffyiHq5gNvwr+ukEmL+PIkRtIJu6zGUn/zEaTY+mX/2+2GHrEvbuB1/2LCk/J1YhqSpVYzFKo6qGHD7hssrFsQtgyJIEjdbrXhATv4k3tZiB9xNUYcZSu0erJbUTbY6MgDGwaPSuAaBJg42IV93nDASzMZ0Mtdz7C63haasSJC2ovkzsmjPhppo7pO9vp3bRm2zPTkWsLdiP1Z5IPDr2Q4cFyjnMoqv5SpbytkQym0+ovrwG15tn/VfLwbLjtoogzGGDfLwM98rk9stj8EW/D4jTTv2iJGRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9J2nx9+4+A28xNXVtrIfnzoIRatgx7ccurFqhzjHeo=;
 b=bj+e6ah9YNuGImd4BBvoev4dvF8u4gIVPp4hpAgSGy1ILiWmwyJcW6GseIpnQ4u3gwycWKqoyYz7NpqUeHIleKXE9bojAVlnC5dLdNDdgEe0/dUT5xnGO8elesHSnHd3W/tcf5MscjtbuE4/f+8FHEwSdT3jGZT6d3KFjdURuHC5DtHrXVl8nj1b9MrT1pIEfMRpAGPJMe6AJxvsN5R9+7apHMluXRpVelHVKrLiI3PqHgMtqM1m80mMw4jJjCxhKfxr34bkChiy6/Rranzo0eniWDJ/6CLx8fnBJAOrT9etiF/B7vwKknt1RU9J6EkENr1zOX8ZmXofQ7/sGn3C3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 03:06:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 03:06:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 15 Oct 2024 11:14:42 +0800
Subject: [PATCH RFC 1/2] dt-bindings: iommu: arm,smmu-v3: introduce
 nxp,imx95-bypass-sid-zero
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-smmuv3-v1-1-e4b9ed1b5501@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728962092; l=1137;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=UoPNACgCzI27huV1njQudpI667foXeUbUQ2AwwwWuvc=;
 b=0Y0Y19NDgcrzYtqL/ocj1QvlHUZ/705CuJfFI/1m6JjxE1JA/di1xMjD+G6VIW1H9RyrcwYPX
 HUgtPeEVnd6DeQjdVWCDj0xpeyp4m7Id/GVUqXNgAKG/bIC2/JejLDk
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
X-MS-Office365-Filtering-Correlation-Id: e1b2ffd2-d730-4098-047b-08dcecc650d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0I4TlRucEdYd1VHZU5qNHZCc0lWYUxEK1VQTVJ5KzJGN2FKQWZnOHlrRW1K?=
 =?utf-8?B?bHFSaWdRa0U4SzdOZlNTZDVMWG5qc2Y4bnppZ1NvNEpVdnAwNXB1MW5HUU5L?=
 =?utf-8?B?Vmw3V2tVYWR3MVRxc2lKdmlLc0ZubUhNemxXa2RtU1ovU3FkS29DQ2NHYVg5?=
 =?utf-8?B?NXZhTmJxcXV4RnM2OGt4WTBCb1A0UGpBeUZOYmdRNkJ5cUtnOWptWXRVZWdP?=
 =?utf-8?B?U29leVJyek5ZYTJhY2h6dDlFTEVnWVJmclBQa051M0ZHdmZwZkg3QkxIR2ps?=
 =?utf-8?B?NXE0dGVQK2d1cmxBSFhUTHFzNUIyY2tMdlJCRXh0WWlZbjdKTGIvclR5bVVk?=
 =?utf-8?B?b3FKL0RtN252Z0lWTitPYy9TWldQUWVpVFFzSmV5Z01YeTdEcDdYTVZTYjRs?=
 =?utf-8?B?VnY2TkNpckxUNmNxcU5VMVFOclBvNmV3VDdiTE9LWXozNDRLM0orREdZc2xm?=
 =?utf-8?B?VThrTnJJZ2NoeDQ2b0tjMnJvVlA1WUpGeTVjdFdHNlE2Yll3ZlVqTlZiU1JB?=
 =?utf-8?B?NThwV2o5eW0zK0lkdzd2Rld0WjRQZi8wb3ZNcnBqZ3ZqWFN5cytuTW1vVnI4?=
 =?utf-8?B?ZjllWkxUdlY0TGFMaXN1YWdSZUtMYTNTRjAwMDJ3dklnVXo4RmxMTEg0cEZr?=
 =?utf-8?B?MUJNOU1iZVkxc0tDN3NPblZuY2FUYVRhRjBCZGVuMUpJcnBuYi9IYkpITUov?=
 =?utf-8?B?TXNxaDFBWitzclpKVUppZVZiWHorSi9BenBscEMvbXVQZk1xQ2k4U3FiNVVa?=
 =?utf-8?B?cU0zYWlGNjZacTRhUWt0NEU0VGlRRE1sUkRGR0VzVktLZCtacnlhTGlQeE9N?=
 =?utf-8?B?cys3WVpUYnJNdlREZmtqczkyQkNVQTcxMHNDZG92ZkFvU1pYdTM0Wnk3WHJO?=
 =?utf-8?B?NFFrTG4zZWRQeGRoUWh6MVR6Q1hwRXhWcHJZV09xR0hjNDdJMi9sVHY3RVFl?=
 =?utf-8?B?bW1ma3Bqb3A3VEs2eUV0RmJ1THBBMjJiMkRVQXJGRHMrN2RhT0prN00ydG4x?=
 =?utf-8?B?TWhsWDkyOGhNTjBucXIvR0JQQVNEZGwyZHdFdlFXOGNsNVZ4b2o5MmVMamVr?=
 =?utf-8?B?T1Q1MkpaV3NMVzdLYllrc3F6cDlCUFNPdFlYektmaXlIZ3dhY1NEOWFvQnky?=
 =?utf-8?B?MlVlYUpablRablVjd2NjdmhqZjAva0JVSStuVHNoRHIycmJTQ3R6d2hTRGpP?=
 =?utf-8?B?bjZNUzRKNkFTY2MzZUl4OWRmN0pRakdQaWxYVStUUm45MlkyU01lY01ZZE53?=
 =?utf-8?B?YUcrb0pCdXBtRGlGZVpob2RwT0RGV2V4eVBrTHZadWpxY2dib2xESWJDWm8y?=
 =?utf-8?B?SjFyWmpSc3VrWldIQ2RhZ3pHU1NRdythcTFFVGh4UUFVSXpvb2NQWnpseDJT?=
 =?utf-8?B?eGZQM0x0OUt6aEpmcjREWkVYVFhReEdGM3NBMGlDOHkvSXNqRTJMZGl4Ylhw?=
 =?utf-8?B?TjZ3LzNnOE5jc050aGhJQytiaUdDa2ErZUd6QndGbnVoTmdJRzh4bFBhS3VC?=
 =?utf-8?B?ZDlEWEtJS0tCWENrTG1pVkpLdFVrK3grcGlnY3dxMi82NlgyUnBxdnZwWmJr?=
 =?utf-8?B?TWc4c3hDSXNvV002Q2daNnlUZHNkeCtyWjdRKzhySUJUZnVraXRxd2ZCSjg1?=
 =?utf-8?B?VTNDZU04MkszV2xOY0pYL295alhFbXdYbFdoOWpNcUZPMTRka3Y4SUhvSmdX?=
 =?utf-8?B?NFJ3QXEzeXNwRHJDajRWMTdoeG5QUXhXUW94bEhzZW9mOHF6SDNCdXJZYndU?=
 =?utf-8?B?OTYyUmJaZGZxb2ZWaElreFoyeGVhQ0s5aWI5T2xUb0dLenV4akNEUDRHSTkr?=
 =?utf-8?B?Q2QrdVhFNHkzOUhQTWhEUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blVZVEFSQUNjSVdGWHRKejhCeXYyallla1FPclRPYWhOMEI2MWVsM3R0ayt0?=
 =?utf-8?B?djhna3BjZ3gzcDA5SUxBOWZnQlluZ3ZvMitVNk5XL1BUM052TXFUVm82bkx4?=
 =?utf-8?B?T2VrUjh5ZVg4TFdXYUhKVElNZlNsd3lGa2t2WTBTbFdveGorb20ySWhwNGRD?=
 =?utf-8?B?U1p2bkhYMnFaSEFGTnEwSVVzR2ppQ0NJQ2NaZjA4aGJmKzNSYVFlNTltbEtq?=
 =?utf-8?B?RThVTmd0MXoyYjlkNGRqZ1NxRzVJODhhd3l0TkZEMW1mK3N0T0F3VldSK0xu?=
 =?utf-8?B?RlVYcjlxaGZWYkEzMVpKWmttWjgxQzc1S1N1MmtobGZxTnh4U2MzaEFuSUg4?=
 =?utf-8?B?Z2xkYllvdC8wTndjNnI4ME9PWTNKTjN5aDVIaUhsZG4zS0hWcCt1M3pSRGh0?=
 =?utf-8?B?QlJuWDdoV2wvNE1CYUZUZFoxK2xEZ296TCtwaU9CSU1Ga2ZqM0YrZm9Jdngr?=
 =?utf-8?B?TEM3MkJtNUZ5L2o4eHlKK01hR2dVNzR3RXFPQzRKbnNHZHVaVU10ZWtpNmY5?=
 =?utf-8?B?QnJWSmZHWUg3S0hzcit0c0dQUkxLT2V2L2NTNlJJOWxkbUxMejBFc2UwWGFU?=
 =?utf-8?B?ZkZOTU5JbkNDYVd4bDlKZWRsUzVNWlVBSitKcXRveHZrbEtEbEJNRCtWb3ov?=
 =?utf-8?B?SUppZXBhWGtlTDRsamlwOUJiNXg4dUZWTVpsT0RDMzhhOVRoNno4bUE1WG9G?=
 =?utf-8?B?V0NBNVRIckd6RnF0V2RHZ3VudTNFN2lrSW8zRi9aTlo4dmNKZ1NxRFpNWjRz?=
 =?utf-8?B?cEE4cCs5NER2MFprMGVmdS9adzBndkRQYWxlZzQrK2FzQ0hodjlMMmNUMGVV?=
 =?utf-8?B?S0dHN256dEdTeHJsdU9LU3d2ZXlWM25qMUxWMEdCOXlYTGxYV2cvK3lyYmY1?=
 =?utf-8?B?eldud0VYWk51ekwyaUY5NFdKS1graVRnRGpkaUhUNUJyRkdzVlM3cWVxTWhQ?=
 =?utf-8?B?aE84SUpuQ3JPUFpHT0IxdXZzUkVxOEUrbWYxQngvcGVJMEg1a2J1QUtrelhy?=
 =?utf-8?B?NElRTjhZN3YrTzVOR2FxQmwvZnE0Y2hWdmx5Nno2aW1XNml3Q3RjMVcyVlVp?=
 =?utf-8?B?SGFDcTJDNy9FYXJOOXk4TGxUVE5pQkM5SU1nMTNncWNoZTlYZEk4Ykw1dHdv?=
 =?utf-8?B?OWU5MklZcTc2VjZjQjVyTzlvVE1rUzhxUXNNUThaa09RNW1uazBQd3pCNDhs?=
 =?utf-8?B?VE85WUx2OG04bStSUytCNDdNOEYxdnZNeUhBVlNlenhxZ3lZblpua2JHeFM3?=
 =?utf-8?B?RzdJcmNmZ29GQzBwR2R1eE9pcGFVd1JNWU01Y1RWRVRtRE9xd01rQUlwa3hu?=
 =?utf-8?B?bGR2eTlJdzNqM053SDJkdGtaT1g5OFJJL1dKS3pqU0xJL2s0dEdVWDlQRjND?=
 =?utf-8?B?QkNJQmRQTGRYbkJnNFNpYXVQVlNUYU40MklGaU5UWHJobXlqTjVkRVcvbGtP?=
 =?utf-8?B?SUdpWWpDTTJ1dTZtS1hXRFpUWGJOelZQYndwZEhiZXZXaVVmdnJsZCtkbkF4?=
 =?utf-8?B?RHpub1JMVUh0aHMzQllYazIyWmlCV0NwbzZNdjFJUTBhcDkxbmc2RkExcDJv?=
 =?utf-8?B?NGJEeUNPbHBGOThHTEhuQk1KRnFnYW9JSnl1Nm1RZnJOQndIQVVycUxaK1Y0?=
 =?utf-8?B?RUxDeWhxZllBbjJ2YUQ0SWdteGFmcFRaN1pvY1lHQllLVWdGcjhocUl6Nzly?=
 =?utf-8?B?Z2dtdjBPeUViSVlXaDFsR216WjY1RzJZdlRQNHJEMGlpQm9lRmFSdDdjMTFJ?=
 =?utf-8?B?U040SzF4aS9RNXpQc0lvNjU3N2J6dEVRS09UMGQ4R3AvYWFkMjBSWWkySHZ1?=
 =?utf-8?B?dDhCMzZyaERtSFR3dlJvd2pYTFZ6RWNWTnRPaXlPanRZWEJ5VWQ3aXYvRHpj?=
 =?utf-8?B?ZU9PWjNTZitMcVZPbTk0OTRtdXJ0ZERkYU91emY4Z2RxWlppUDZUWWoxMGdl?=
 =?utf-8?B?WjhoTEpjb1dkUjcrWEtBOGZveGd1ZmJockVOZ215aW9yOVRqQWF1Q0QzS0hw?=
 =?utf-8?B?VEE0d211QzBMT3IwOWpIOUxFWERGTzg0VFhRbUo1M1dTV3Z4YkZlT0I1NnFq?=
 =?utf-8?B?OGtHQ3J4NVVBT2JXQ09vOFpUdFRvMU1BeXdiNzhEY0dLUkd4cG4vbDRKQVV4?=
 =?utf-8?Q?JKYiim/L3Vf/LvwBXsBw59z4d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b2ffd2-d730-4098-047b-08dcecc650d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 03:06:08.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHpmAdq6aFV9DeNlTWPrRVAVNaSlZpulaNOsRMTW3Z59Uh1cfVZYAExDeFqmp9G62FHdBwdrkf7Gp1Ngskz0sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173

From: Peng Fan <peng.fan@nxp.com>

i.MX95 eDMA3 connects to DSU ACP, supporting dma coherent memory to
memory operations. However TBU is in the path between eDMA3 and ACP,
need to bypass the default SID 0 to make eDMA3 work properly.

Introduce the property "nxp,imx95-bypass-sid-zero" for bypassing SID 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 75fcf4cb52d9f6449238578f20288966af35cab3..88ab908154e31aabf98f3bbe4df348956f49d5e1 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -69,6 +69,10 @@ properties:
       register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
       doesn't support SMMU page1 register space.
 
+  nxp,imx95-bypass-sid-zero:
+    type: boolean
+    description: StreamID 0 that needs transaction set as bypass mode.
+
 required:
   - compatible
   - reg

-- 
2.37.1

