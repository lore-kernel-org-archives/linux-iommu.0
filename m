Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8116DEAA
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728961570; cv=fail; b=NJEot9ODhtkAPTwF7MOjBY5vI/M4LH3K6T5ROXR3kt3JA1CPZSUWOro4SDMltUyHMUAfBeP9ldHiGBVpZnNrgD2/svZKhLeI7Tv+VBe6NeIb2kfXmHpV1kYEjQrlxqSHCHBg1zu0BDtiy2/yUS6rFjpdDllxaYsD2xWdzwxu1Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728961570; c=relaxed/simple;
	bh=yVoN1mzuYlVdHMfLZqf0oQQyfsNjmBG5zsG5zFYvhQE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DIOU0Qq4cm+lQnbiQrSIXepZ4ludQExXFRnLTd8oTLrSEjemIs2zzBHfBxIsXZc0KjvVtICHcrIielyd99C/KYQMnhZ/sD9hQ8YHPBdTpF84R15Fi9Eg5mnsETWi/4Fr0zP6TiDAW5FL2dl6zytBAmNgrb+uUNidRcGAviKKvSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ew3QvEW2; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ew3QvEW2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XByIXhY9v/CZmH46gtZX9jajjuQKnszMwbXEv7KsPNiOTVLCYiKWm5dBs1EP87n76GK0GGEM905YVMtDUBvolLK/UNRUyIGoy4NlKikVBkfpexWFtxg49VkzRnqkYy4OaY4BYWAs0F8FDMJriw0G6rtYEVBDD86LneeyTGYivPTqfoXBuLzfnpmC0gH6F3rYzysArD3lnYaWijIi47leWZVRR8yLTLIlXjvfvEPD2Z1qOsceiWgdxWOA7RR3+othXu70iYhr9whP0coREnSjSDGP9EltRzJRGPy9ImsLgH7AwzOscOOGleMtNcErsQDNgXBdsXvWUIvd/ci++UT7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEbcsazzLqwUbZ1m46RZkmjzRa29zyq4Wn07SvqtIdw=;
 b=NmSnCTgWSOpfFsKejFJ8op7RPEfpabORhZxvdt+s4WVrNjtbJ5RIhHHbt+P+Ufplrgbrl9RkinDWBFtQMv/+9QKaAHHgEJFT8weG+8oSLI9mDme1jjJPqA1Wsj2Wc/yYYDIMKUlJZ8VP6c/HUXxBQeW8pmrNSSJOolAKnjvO3vDKho1Os/52e11sBBYra4cvh49wA7xJbZDNoiexDMfkQds7pZaZBkNVpOdLO1Ver17nyIH3pkdmc/qZsf1D2fPTkL5RdVXExrYMefLqbT8mP0Tr6tMxZFuaV0lBGmMDvfl+nCTyJJ9WQSg4GSJtXfeJOho605FgSVHQ+WVrjVOd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEbcsazzLqwUbZ1m46RZkmjzRa29zyq4Wn07SvqtIdw=;
 b=ew3QvEW2DWgBNfGz/lglxGNSyq3M3liWs4soA9FTm0uaI5P01njou+cbOjiTKE1QTqb7TXsfUv47jEZQb565xP+XGIuLV1KeAJo8nOuHjhITgtH2vPBNlTdBzi2OV1/SVplY7MGEMHv5NLf7AjcLPbFCNQa6pkjqL6RO8Dabbvse1qnZ6OMxnytudaItNkT8rDVaYRiKwCkwk+P004lCu6oYPt2GLPMH84V3fVveISC9BTBmD1ui+L8/Ve1jzWwAmJl1zKUcG9NrTmEm17rN8PcTa5tKomkpgNtByk3VpL173YSjGl454gBDFzLenRN5t0xQQqS7MGTbsHaq6KXk5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 03:06:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 03:06:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid zero on i.MX95
Date: Tue, 15 Oct 2024 11:14:41 +0800
Message-Id: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACHeDWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MT3eLc3NIyY11DI4MkI5OkZBMzU0sloOKCotS0zAqwQdFKQW7OSrG
 1tQDx/lQtXQAAAA==
X-Change-ID: 20241014-smmuv3-120b24bc4659
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joy Zou <joy.zou@nxp.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728962092; l=980;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=yVoN1mzuYlVdHMfLZqf0oQQyfsNjmBG5zsG5zFYvhQE=;
 b=cHlqGRGtC17rbnhGdR7j7VfslwfGZV2SteeQrC3thpShtBPxVc3KOtzJ0ASSn0cdpABRHt6+o
 6GBFv2UdGwlCG7e4nfVRF4qUByEolWlBEddWa6AXi9d0ppdMXbVFZ+a
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
X-MS-Office365-Filtering-Correlation-Id: a0aee22c-555c-41fc-d486-08dcecc64e3b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGZvVDR5LzA1Y1JlV1Awbng3MXErN2VyM0lRUDlvZG5JWWNxTkptY3BpK3dT?=
 =?utf-8?B?bElEdTBWY0FYaUgraGNkUktjc2RpeHRLNkJ6dytITnkwZjNEWVkxbnJwY25S?=
 =?utf-8?B?UE8zOUVqaUsvT0lGVEpnUXU4eG8rUGw1Z0UxUnBIMVJpWjBWOFNMckpGMGdw?=
 =?utf-8?B?QWJZd0ZKN2VpVzNXQ1lBWGdrVVVtNmJLL2E2MnBWOTdCQ0l2dTg1OXZoWHhl?=
 =?utf-8?B?OUVvcXh4L2gza3JsMis5MzhzcVNnWm04NU0rMzRtTVRuK0Y2eCs2bmtIZ1Y4?=
 =?utf-8?B?Z3FNZkxMTzh3R3FOWVlwWDR5TjRnVUlJdld4b3VYajg4QmlFdmdNazN2akU5?=
 =?utf-8?B?LzdzWjQ2am1oVDRuS05EUExGR0Q1ZE0xWEdlUURxWFNQNlMvL3pQTXJKVzFE?=
 =?utf-8?B?ZnJxNjl6djdDaXpVTkhkWDA4N0hWOTA4ci95TWNOcUdUYVVVTDd1aFk2N2RZ?=
 =?utf-8?B?bXBjTE8vQldnTTVDL1g4b3JmWC9VbTdoWnpDZ09EMnVKak5EU0NKWmhsN3Bm?=
 =?utf-8?B?WDNBOTI4TkxqWHhFbE5UVEtNdVR0TmhGWnJ5VDdKamV0amlYeFJnSmY5Qll6?=
 =?utf-8?B?Y09LcVNnaU1scFNjNGxucURYT3NHQzJqVGJHazV3dXBwMWpnYmV0bFAyb0hY?=
 =?utf-8?B?bjNrRlpFaXNGNUFYcWNyVjZ4WkRqakpxWEJWTnJkcWxXZlNPRk9qVFBRT2d4?=
 =?utf-8?B?ZjRoaVhDKzFTb2RhUUV5SDErbVhlTG5GS1NSTDBReTJpRFJnTlRGK1puMU1r?=
 =?utf-8?B?UTUwWHd0N3dCQWgvZmNOWVNNWWJiSG1WOWc4RDdERmFEQkpNWm5tcktpT1Za?=
 =?utf-8?B?cWx4NUp3TDFUdzdsN3RBS29uczFvcTRZQ0VpaG5hZGl1ZWlsZndRRmdPbXB5?=
 =?utf-8?B?OWVtQnBEQUorMzF2MU1TOXdJVGgyWS95cWNpOEhtV3hZRjhsbDQ3cHRlaC9t?=
 =?utf-8?B?VVdGUTZ1SHNUWjUrQVZmU1MxcDIxVFhnTVJPODJaNkxwZHVTTDV5M0dWbEYv?=
 =?utf-8?B?WnJKa29OajkrRkJlY3F0aE0zdnFPSU9VS2srRnhyNmVpSUpSS1ZxS3N1VmNK?=
 =?utf-8?B?QTh1ZFBqL0pMNTBuM3hQTHJ0aytqelhLeGZvY2VlUXRhM1RqVmNVSXU2U2VO?=
 =?utf-8?B?cnYweGE4KzdYcExINVZ2N3FYeE02MnNhak1NZnZZZFZuaTdGSkNnSWV0ZXhn?=
 =?utf-8?B?bEFVVmZPUWgvb015cjdPSGx4aDdTdVRablB3dTJ0Z1BVRk9FZUtUbitsZ1lI?=
 =?utf-8?B?eVpzZStTNUF2L0VJVG8wRk5SNExYN2NzeFcrbWV1WWtXR1FXaUFVS0hLUWhv?=
 =?utf-8?B?RnJWc0VmbFN3QXJxalpHRERlLzRYNzBYM2RqTjRVQVJKTys2U1d1b1hYWk40?=
 =?utf-8?B?SjBhM1ZoTDc2WFo0UE8rdFdKV29YamZlbDFPREhSSFNXUlNHRGx6YXozSDdB?=
 =?utf-8?B?dG91SlpEWDlqSFZjbndsWUI1U04wdFM2OU8zLzAyN1RUR0tJbVc2RnJjeXly?=
 =?utf-8?B?NGUrSHBlTk16Mk1VOUxUWHd4RTk1Z3NyMWxIZitzNTNocE9ETHQyVlFUL2Fv?=
 =?utf-8?B?VXJJL3ZZd1ZjU2FOV21wNEQ5a2xZbCthUURMazZrQi9GSDBwNnBQbERTSWRx?=
 =?utf-8?B?d29DMnRZd012L2dWSjlUaGRLLzVhbnpmdTNMZE84MmZqNUViNzE1ck9lYkd1?=
 =?utf-8?B?S1VRUURWcXlnNlN6Mm90VHFhVnFCWi85RnpBZFF2eFNvK0JTRDRDbC9KMUZy?=
 =?utf-8?B?M2ozTGlSdDc3U0FsRlpCcU8xUlNwejBINURTN1lqOGtjNjRLelAzUC9XdUtX?=
 =?utf-8?B?ZFd4ZXN3b0lId2xHVnBPZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjlqcUc2c0lYdnlnK3h6ZzBGTFdiQW5NOUs0aTFEOWxaTXBHOXJObHA2U3o2?=
 =?utf-8?B?QmwrbEJUYVE2ei94V29mZmc1aENjaElod05BOHlhNktuMUlGU2RrNS8wODAy?=
 =?utf-8?B?cVNwL2tPM0lSbnZHMEVVc2FHZGRIN3YzQXF0dkxzQlJhVEJkK2hPQkVmV0JP?=
 =?utf-8?B?a1p0UXZTQ1ltOW1QeEF0YnEwdyt5Q0NheGxmbkJ4cjdEaS9oaGlubHFtS3VG?=
 =?utf-8?B?RVcydWJ2d3h4TVJGbnZ5NXlQbi9hMDBRZEFtdVhUMGI3SUFNT3dBWjZZMzdi?=
 =?utf-8?B?eUVIbU5YcWNjWHp1cDFnN09mODZUTWtaL1BIMTY3Mk51WDdQN1hxeGQxNlB2?=
 =?utf-8?B?dmlpdW1TSzJFMEFYSnNTTklzY3JOMXRBbkxkdG9rWDBiVzlwaGxNVy8rUXAv?=
 =?utf-8?B?Ni9HcUVRTzN4QlJSdjduMVZIV2U1T3M4ZVpZc1haOWp2ckIwblRoc09wYm1j?=
 =?utf-8?B?cm02TkExSHZMSUdRNld6Umt4dTI1bkJpNHBwSGhwMXRjSUF5UzZWOVlyWTlW?=
 =?utf-8?B?QkpSL0dPZjd1a1RUS2diU21zNyt5MlhQUkkxbXUzYmxhS3JtaXRQa01PRG5T?=
 =?utf-8?B?dnA5dFZrRVEydklFQzNyN2pFNmlJcjQ3cGFuRTVHNlJSSnhwRC9id2tYbDgv?=
 =?utf-8?B?NTlsam9Ea2krYnJhRFhEcjZWQ3NuVDJ1ZWJZNUZ1NUE4TlBMTUJTUUV2S3hP?=
 =?utf-8?B?b0pwM1FzZG8xZmFIQnREbkZFYk9UOVI2Vk41RkU1bUFxci9ZY2R4RGRrUFRQ?=
 =?utf-8?B?K2RCSGliRTNhTlRSemVLMWhUN05raW1LSWNQZ0lUdk5UbU1KTVpxZVZQNFVP?=
 =?utf-8?B?VjlkZWppbVhYYUVvYkE0MUtva2tSNnRWNmxiK2hJanl1UTBIa1p1ZmNGTXE2?=
 =?utf-8?B?TkhreDJLQmxDUCt2bDllMGppL09jN2RWdEs3NnlWME5oc1hWVU1qdVpPVFhV?=
 =?utf-8?B?VjlsYTJ4dW90aWRDUUpjay9BeEJhSEhlVVlEeERsbjRjeGwrM1lWc0lNcXhv?=
 =?utf-8?B?UVgwOTBFMUtPTFRXSU5YWkNQZTFGTHhhZzB5SWxaT1gyR0cwODFaeVBtbWFY?=
 =?utf-8?B?eHQzd3F6NlJNRkFXNHZNMTlZTGFZTEV6bzVpdCtqNnE4MllaV3dLYmdZVzNQ?=
 =?utf-8?B?TVdSd3FlWEY3S0sxNnhrWmE1SHV2SHd0NnpqVS85aWZkMmZiSC90RzZFekFk?=
 =?utf-8?B?dVlReTNnejdodkt1VDNHYW9TcWMwRFpodDNKczFNOVo0UkFOc3hMZ0x1c0lk?=
 =?utf-8?B?c01valpYSzN3UE9sVlM4SUxTWjJxYUd0bmdpNjJ6cG8xUzU1S3NMQy9MaUJ6?=
 =?utf-8?B?S25pWU91YTJvYnNrclo1NmJtZEw2eDlYYUpHd1UzbzRnVTJuelRHRXRMN2hL?=
 =?utf-8?B?UDIrVkJoMWk4cnZrY25vRmFId2d1amViNmo0ZzgwRUdtVmw1SEIrNHpYTzAw?=
 =?utf-8?B?eXBKRWJOTzQrSHowT2RkNVBObkpEYjZvNFNkNEMreE1uZFVDSXFJeEJaUEtR?=
 =?utf-8?B?UUVFb2lNUW9aS3A1WFU3RDNQSFh0eEdrN0lhcmJvY09QVWlJZ25lRHdDKzV0?=
 =?utf-8?B?OTYrUVR2Ny9MR0pqdGw5Q1F5eUFhYkloNHlETHFEVVI1ZlVFVkRTOGsweWZT?=
 =?utf-8?B?c1ZVNjUrbUtkZm1XenZFNGVITko2SHdjY3czY1NLL3pVKzBoWjBRTm1iUXU2?=
 =?utf-8?B?cTBlQjVPdWtKbDVGeHYzdXdEZjlxRTJtNkxIQXVtVFRmZUdlK2U4QW9DcUFP?=
 =?utf-8?B?ZkJuNFYwenNIWjF6WFNoUnB5emFESEk1OHlqdjIxaVNxcWo2WXZtNWgrYlpC?=
 =?utf-8?B?S3FzdU1iQVMrVWlpK1kzTDY2aVllZlV1bERYUmRzN3hKSzNCczVOWXN5VUV6?=
 =?utf-8?B?bndHTElNWGhVd1JIa3R1T1J5ZzAvVnJ3ZFFjeUZxcEhKbWthVDJXK0huMXhX?=
 =?utf-8?B?NDQyS3lBNVBNcVJGL3lOUUs1UDRIakY1WGU3eVo3K3JhUjV2eEVwb2RBYjhT?=
 =?utf-8?B?bWh4Z2pNbjR3VmVtelV5WXZvRjJQNEV5eU5XWFRPamNpZFBJNjhUOUcxWXp0?=
 =?utf-8?B?OVNiRWxrcjNtaDZBMENMR1VoVFZYajdWWEtxZmJKaE9KNXF1SmV4K2FKbXl2?=
 =?utf-8?Q?YiupGB2pn3KzQWPMeM/IXntew?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aee22c-555c-41fc-d486-08dcecc64e3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 03:06:04.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvqDWOTzmdEbRd/exj+LUQNjEPd5kDveoTr72+61gj4QdvFv8FPtcwVafEOjgPLCDQE0hGim5ICSWGHDhKxBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173

i.MX95 eDMA3 connects to DSU ACP, supporting dma coherent memory to
memory operations. However TBU is in the path between eDMA3 and ACP,
need to bypass the default SID 0 to make eDMA3 work properly.

I was also thinking to introduce "bypass-sids = <0xA 0xB 0xC ...>" to
make this reusable for others, but not sure. I could switch to
"bypass-sids" if you prefer.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      dt-bindings: iommu: arm,smmu-v3: introduce nxp,imx95-bypass-sid-zero
      iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95

 .../devicetree/bindings/iommu/arm,smmu-v3.yaml        |  4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           | 19 ++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h           |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)
---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241014-smmuv3-120b24bc4659

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

