Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF639E6D5;
	Tue, 20 Jan 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920032; cv=fail; b=mvXdfLUYmuANgk/9mIIL9RGMaHK7wIbhEpE++8ckzGiX7IXbiSY2YXKAhg5mRpaBEiDNCMSNo1GSb96dQytOHsEYtAYJuQXKvPTjDj/19kWDaqnyTwP6dW7JktIqGqZJKb/yoaTWSlk8jhTb+taJVv31U6tjRUK54YIpIbWDPgY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920032; c=relaxed/simple;
	bh=n8LyyMqol4C86Z4rOLRC1GMwLPSAJhOGUk41Dw66lqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tp1AFwB2ItWVPnFlMRzARsYBYzhPzPr5Y9R2r7O2CX/8+54auTzNwMDatMrRedbVcdcDIzkZ4mpAy28OkyggUjunal8WNPCmo2M0lj4vm6kukdlLgmeJaUk9UUkRwBY639jwK8mIj3P2VG2PMx6bxKdTXE6S6aldJUyL8Qn21eo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sl+JBTGN; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sl+JBTGN; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sl+JBTGN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sl+JBTGN"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=o3/18zVnAXJK9VD7PtZ5wUalcc7p388hve0scNeBht4jjKUCLum0sSBp28j3Uw12nSbCzdpr3Xg/cQZZ9Q8yugzDZ8QsG36I209sWHQpvgxPFw5L4qA8/f09ESSLSJoI+TJqgb5/oOSr4rFzAd7AJsICqysgGkoirdROXGSikoUOyMDXsFZC///6+yR3ssSxDomzJQ5f0WOKz6V8pubUUqOFMw8dIyovWwERxMHtuQwi+0OZH7KIk64t+pA1TadA2Qcgp3ipXadcWVnd3SFYWUqvVE+QXD04tYifRgD5gzB7B7cBq5LLqt3FxL+Zb4WGQoqUs14pOL8x57P4iq25Zw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGvhNTw8OcBivV9heK8+XW2zR1HCrsFTyiGtetLxl/4=;
 b=uvIQfN1F3otxk8HpIFNyrU6xHSL09G37Qh1MXbSz7TGvsR+xi2lx4Q/TUrOvXy9Vp8k0oRt1JCKTVlDgZR6oKzeUyYTWn2VXsARBs+FBMyAQ1NYYFe8sUOKJxKVxzHkVx99RRTLpw2hQaOcrl7u1gbD1F7BmdLjcpCRJSGfFahtING75z92AxepI3cpwFRHCfbPVFUEUVuqNQFdyTApou6tW/vfuROSTFkd3/p8BKMqyqVIXkW/mf+I8Vb7QImoxENelyL2ECNJnP671fvuSv8vilnfyGErTtnjnwgIS9iMUG/++JF/ziSwiToG2QvDxJNQI2QZyXZNotgFkiXYwlA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGvhNTw8OcBivV9heK8+XW2zR1HCrsFTyiGtetLxl/4=;
 b=Sl+JBTGNo2oyrgQpUQSRGBNbOEWpuyxda1tFFJtDY94U1+1VIRWspsv1YDWy/mpFOWgPFvn8qgIkDyfhh1cDuUYoZz16i86hlR9WvbfwW4JYjUg/4Nr53sqKjVDc9QhmP+EM4aRNEdJKxhS2fiviSzXZHKDePG6OI9M+8XuDiDI=
Received: from CWLP123CA0042.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:58::30)
 by GVXPR08MB11542.eurprd08.prod.outlook.com (2603:10a6:150:2e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:40:24 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:401:58:cafe::63) by CWLP123CA0042.outlook.office365.com
 (2603:10a6:401:58::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 20 Jan 2026 14:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djGGRMrSBJW9Eue3SNWnqv7FaBqWnCD6MHnBCCcQtwdhP98dea8dFyCvQa57b0Oa/5TfpFh9T0ak9Uio03MhAjLuYW15CsTdm6YaB/zmKVDdyzuI+W2wRiNhHi4Qd1djbhKobAk5Ycbarikvpw0a3uA1+YpP4aWvgVu7+olV2NExGVMWNAJld1mi7OIZaZzgcRD2iT0SrpTJ6SUTDHALdJgUDZbC2LCsdoKLNhtgUwc2ddDczDWFIjk3r4gdKco7SsTH+/RbVYa+cLqWWOXS1mCSMh23GBPh3bnWS0IKhZXsPFRMKvF9fNVNX1dUCLq5OypmkTKc282+3sxevguITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGvhNTw8OcBivV9heK8+XW2zR1HCrsFTyiGtetLxl/4=;
 b=oXQ2MXHMdp5XocsLV9r0ihg6CBOUYmTnsWg2360lllzevHijRe1vvOrEQGmis2deebjRUUtqxRsd8sphzN8d6bJyfp4H2Pf6BGRkLcEbEEFOVXXGVDjI6/Emk7umLGWbfzvUYlqpilwMqMU3Vdd8QkxxM/cEAH1YzWHJV+QVs7u0OK7ox+NZ/hBZNmciWGG1kcrLU/nXgcGlyoNtZIa36YIPeOFHET/7WV4zTktARZXSm40Pg/KfgZkXLYOc5iPen3o650lWs0CP5BaGIyEPembL3cUVWqAoX9Uk87jE4sGwTkGHH/ijPMmaJtBKCaRPkM315rF1FHYcujCSCfEc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGvhNTw8OcBivV9heK8+XW2zR1HCrsFTyiGtetLxl/4=;
 b=Sl+JBTGNo2oyrgQpUQSRGBNbOEWpuyxda1tFFJtDY94U1+1VIRWspsv1YDWy/mpFOWgPFvn8qgIkDyfhh1cDuUYoZz16i86hlR9WvbfwW4JYjUg/4Nr53sqKjVDc9QhmP+EM4aRNEdJKxhS2fiviSzXZHKDePG6OI9M+8XuDiDI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11769.eurprd08.prod.outlook.com (2603:10a6:10:644::21)
 by DB9PR08MB8626.eurprd08.prod.outlook.com (2603:10a6:10:3d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:39:16 +0000
Received: from DU4PR08MB11769.eurprd08.prod.outlook.com
 ([fe80::d424:cd62:81a8:490f]) by DU4PR08MB11769.eurprd08.prod.outlook.com
 ([fe80::d424:cd62:81a8:490f%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 14:39:16 +0000
Message-ID: <0da8b73c-5bec-44c3-9902-221a11142c34@arm.com>
Date: Tue, 20 Jan 2026 14:39:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 robin.murphy@arm.com, jgg@ziepe.ca, steven.price@arm.com,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com> <yq5atswgjrkp.fsf@kernel.org>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <yq5atswgjrkp.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::21) To DU4PR08MB11769.eurprd08.prod.outlook.com
 (2603:10a6:10:644::21)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DU4PR08MB11769:EE_|DB9PR08MB8626:EE_|AM4PEPF00027A63:EE_|GVXPR08MB11542:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9ab6b5-97ec-4180-d606-08de5831d85f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bFRnSzA5aFhwUjdtMlpDVk90QmFpTE5mNTVBa280UFhyemd1c1lUbXJCMGlo?=
 =?utf-8?B?K2duN29EN1hEeDlLMHlxSFVrQTNDUTV4TmpnbkJBZnV0NElXWlBhOGROMHp2?=
 =?utf-8?B?RDVhSjZROCtQeUI0QTZpTTVaUnUvQitTeEZMMEF0QWJFRlBoS0duMTV2TDNE?=
 =?utf-8?B?WEFjeWVhTGhkRGV2SkN4SGxMMmwvV2hLZEpIQ21rSlRpWG9PdE1yb3czemQv?=
 =?utf-8?B?TWVla3ZOWXpFdnNNM3dEdU1CZGhPcnFtTWVRend4alR1dzlYNDVWd1ZPZFJP?=
 =?utf-8?B?aEpRVTQ4enpvL0NmdlRuU1UwNUtTcTJHcGloYS84Q2d4cWczYkRlT1dLK09v?=
 =?utf-8?B?NUgrQlR6bGMvRVUrTFJEWGtxNlpMNWxXSEQyVW5tYXBjcWZ4aU9saHplb3JR?=
 =?utf-8?B?TU8vSkhsMDZrSmh6Y2NjQmw4SHM1NXJwaUQvU0NGMDZhbHpJbURrc2V5L3dX?=
 =?utf-8?B?d1VJQWFyOWtlNnVHSWdSVmlUck5zOVJGQmdzZldiMkpFVkY0QjRFbU9WdXZr?=
 =?utf-8?B?bUtWMmFGYjVCd2dqVkFyVlpyWFordW50Mm9lTlpqUW9wV0RtcHVWZVpCRnVL?=
 =?utf-8?B?UFFxdENucjVBSFhtSFBOWEUvYUszQVhNNk4vVlF6RjVvc0taZy9HQnhzQ1U4?=
 =?utf-8?B?dXpNc2NhMndpNlpvUHoyNGdlTng1V2FoeHlCSW5NM3BqWWwxODIwMXpJaUVW?=
 =?utf-8?B?VHJFVEgrOFdJMmowUktrbTd1aXdYOFUzdFhPWUI4WTVZdkpQU2tLbmViVUdN?=
 =?utf-8?B?NGpDcjNGSlo5d3BnSzRkVCtoTUxodzI2cWNtMms3TDh3emE1U0ZTaE5DS3ND?=
 =?utf-8?B?Z3RuWUxaZS9KNVEvTkUyaFpzQ2FQeWIrb0s0elovQmhkV1ZweWhoYTNqWGRK?=
 =?utf-8?B?UENiSlJsL2xRVEVIV3UrcE5SRjFZRzJWbUJVSk0wOUs2aEF3NXVoVVcrQWFx?=
 =?utf-8?B?OGIyNSt3Zml6MGgzRUVudzBOMDZXUnArODN3WlR1dGhkNzY4NmdZUHRMYjNC?=
 =?utf-8?B?YU9sZmVBZ0JveDZGVys3WHpRVjAyMldrblMyZlV1MUVUK0ZkZ2NnKy9TR3RH?=
 =?utf-8?B?ZUJHYWdHYitsbjhUQ0NZL3hjaVoxUHZrUGpVZkdGbVhSTlRYNGxLUWdFTGYx?=
 =?utf-8?B?UmFLUWJYTmk2T2ZlTTNIN21Mc2N0cHZaMzYwYldmcHBnSGdWRGJyNGVFSXV3?=
 =?utf-8?B?SjhwYWYyeXVsWThtRjdBaFFLYjlnbGk4Zkozak1oUlhQZTVQMkNlcGhPNGs5?=
 =?utf-8?B?dEtxWjltaVFrdVBUQXA1VDhZQ1o5Mk5wa2J2MEh2Ky83WHJPT0xISnp0OExu?=
 =?utf-8?B?N3VkRXZ1V0RoR2ZmbkNDZVpCK050blp4c1BYTk1pbjBPb1lWWWUyVUw0Zk9m?=
 =?utf-8?B?QTRnZjJ0WkdVVUlCUk83SlVLZU9FWSs4aWVHTWRlK2N1RENWaUJjdSszUkdV?=
 =?utf-8?B?bzRsdDNmaUpFU3Z5SHkwL2Z5bXNpVDBKTmZJbVVMUmdYZ0JGWEdaYlcxYzEw?=
 =?utf-8?B?Z29nV3hsTDJBdEw5cUFJODBGQ1RpNW94Q1pkK1pDcDdqMDgxT3FFcU9xV202?=
 =?utf-8?B?b1d0T2xVLzRsSUlVczhGS09yZklvTVd3Y1M0RWNNZ1BPay9NdjNQN2d0R0xT?=
 =?utf-8?B?K3Z3SzNkZGIzSmhJdDlabHlkcHU0aUJNaHFTZ1RVd0psTytXaFZIaEkvLzVH?=
 =?utf-8?B?a3ZMVU1QbHU3OWN3S1JTeXF5M3RyU216SEl1UkpQTzV0clB1TGxRT2UwSXla?=
 =?utf-8?B?T0ZZMy85V0V5aDRqckdSVFlnMHhjbG9mSEdOaEpRTithNHZka3d2eFN0Q05Y?=
 =?utf-8?B?QU5jay9QZnNSbmdMK1hWdEpwcDlqNDgvWW1jeVREREdOb3B1cDlpZ01Da1My?=
 =?utf-8?B?WHlDYmdEbG9TandmVmdNSjZjaHNuaHZkbDFTMElyamFWdUY3REJJYWlkZW1M?=
 =?utf-8?B?bkl3ZGc2dzdCR3pyNlV1WlJtazg2b3dDRFAxVW5HVlkvaFZRODRCSWZBUWo2?=
 =?utf-8?B?SzJwQmZhVzBHRDBLOXorU2lGTVVMUENQQk1RL0tPSHJHeHJLVldaaVB1MUZN?=
 =?utf-8?B?WlFyeXlaWURXdkZoMlBqVnlNZjd0Yi9KU3E4cW9tY3V5dFRLZ2ZvTW45MW5P?=
 =?utf-8?Q?nCjg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR08MB11769.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8626
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	977f0de5-db0d-4c23-4e0b-08de5831afbd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|376014|82310400026|1800799024|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFNWUEliQ09wWWE0VkdIUngvQzlzVzVvdEtLLzFkY1hFMXpHWGZLZk8rQzFr?=
 =?utf-8?B?SXFaUVFXYjg3WndFMEQ0TitaQWZkWSs4SlgzSzEwY016RjIyNEZFc29FUUlE?=
 =?utf-8?B?U3hKaSt0SDZjK2psVm9KTlNkU2xVSHNla3hjRFp4WTB5QlFtd1RMWTJQdjMz?=
 =?utf-8?B?L05hd0ZPaXlzRDM3L0JySDI4Z0V4bDg0Z283enlQcXNyVGF5bytwZ1pBUHdr?=
 =?utf-8?B?c0FDaWNpTjYzelU3RG56VWFydnF3clBranBkd0Q3TjluRFJqMHVZRitoRVBJ?=
 =?utf-8?B?aGJkanBKaTRZY21NUjY3S1lDNlNmejhpMXYyTGlITUZDM1l3djRPV2FqejBh?=
 =?utf-8?B?anNRNHFyZUtVaDZ5dFpKMVVvVlp0Z0VSMFc4MlR5YTVmckdYakhpN2RjeTdS?=
 =?utf-8?B?MkRxenROeXp2TGViM3B3V1I1Ynk2MHZvRGhCdkxmL2g3S1l0dldITis2dVps?=
 =?utf-8?B?aHlmNEZCSnZ0S3FWM0xzL3BzM2xBNGtIUlpMOVhBdWk0ZEhsbk5Wa0UyRDN4?=
 =?utf-8?B?S1g5MjRiY2phanFCVm0wVlo4QmFBTjdlQURPakk0cklSOHAxQlVUZlZxVjNo?=
 =?utf-8?B?MU0rQTJjM051MGUwVzFCTmZtTC9CYytsZ0ZaNU85YVZ0dGdxVUQ5Rk5PRzFa?=
 =?utf-8?B?TWNtZnF4YStlbVNNaStkZ3RvWmlaaVd2ZzYzWWIzU2VXdk16VGFlVXJxYjNB?=
 =?utf-8?B?eWF6ZVNCOTRJcU9lNVordGdxVkh0UDVjMFdzbC9obW1zcVhhR0tsSU9aQ3hW?=
 =?utf-8?B?dVhqQkRvbDB1WFlvdGFOY3VVeEZCQkdYSUZJbUdCVzFqZGp0VWJZaXFDdVpn?=
 =?utf-8?B?L2RudmFJMG42eTg3cERYeU5OQlZZcHgxUmNyLzJDT1MrTVVzQlhyTDZRT3Bp?=
 =?utf-8?B?amhWbytDWWRZTjNtVWRGVUlZU3ZBQjMrdDk2ckZDaU42enhqSnlsN2ZVejN6?=
 =?utf-8?B?Mi9MRDE2RXE3MjZ0aWk1WGYxMkRGOStzMmhUSU1XK0cwTEpvaWVXZCtsQk5S?=
 =?utf-8?B?TVVEb2IzZlZzU3g2RWN2WmxKd2dCMEpUSW1sWDVIZkxtR0tjYmY4bGNXZDJz?=
 =?utf-8?B?WWZsak9rN2VSM2s4Qk5BbC81Ymx5ZzJrTkJuRE1WZCt1bVZaTlZLVEJ6c1Iy?=
 =?utf-8?B?T0xOZDREb1hhNnNDN2xyYTFPVkFCb0U4dzNuVmhrVUdMVlY4aXdyaUxZbEdu?=
 =?utf-8?B?ZnY1Y25lWHZidTlzM0xIRWF0NUw4ZU1GUEZlUk94YW40OUNXTmpicG9MN29K?=
 =?utf-8?B?MUtmZDFMNUlSQStJbGk1MVJITTM4Zk54TlF0aGRXSDRsRENwYTY2SWUxYk1I?=
 =?utf-8?B?RytyMW1Rd2Z3RmNQcWd5Wk5KTytZb2hVd1ZmTHgvYVJOc005VmRJWVFuUnNr?=
 =?utf-8?B?Qk15VWxXK0xIQWFFdnc1WTFtTFdxT0ROK0dIS1VEd1Fhb3N0VDRxbnE2Z2d5?=
 =?utf-8?B?RE80Y1pNZGNxZERVOWp0b2YyRHY4TnM0Nmg0dmRYUWNoVG1WZnI3WTJSanFk?=
 =?utf-8?B?Zm5MSHVRVzBweWJRSkcyVVFROU45THYvZTRsdGtQTVM4RHpDaE5TWTlvOW1T?=
 =?utf-8?B?d1BtbFhxU0d4R1dkNEQ2U1c2dksyeGVJNW9YTTJ0QlFvYytqaDFWRHNGY0Ey?=
 =?utf-8?B?NWpWNE9JVkswMmtoclJRRHJ4aDVYcktYVFNFNlNCSGZCQTJqb21neC9xalND?=
 =?utf-8?B?NFFtNExHZHJqUVJPV1liczV1Y0NGV3ZUUWVkcE5KSStON3JYS2lmMGgxSHVM?=
 =?utf-8?B?OHZYQ1NUVmVTdU9OTzNZTnQvTncrb0JFUEpMZCtpL0dHSHhtWGtWcEpCTlZQ?=
 =?utf-8?B?VDJUQ2wrMkdadFdzNTNUVlV3M0pDaG9EMU1lM1BJTXNVL01qTFRVTm9Ub0kz?=
 =?utf-8?B?UDVRWHhTZmY5WTNsdVdmN3RMVUxweDkrSFF0aHdkQk9CRU53U0NxdHZlWVN5?=
 =?utf-8?B?Y0NScGJ5YXVPRm84NU9XMTdkSGdJYTFoNXN1K1ZMSTlIRWFSMDlURmlvekp3?=
 =?utf-8?B?TEZJRUEzRFAzSDY2T3pEREJkNVhKelFFbytvUlhQN1lWaFpqVUtjaUxVVjBq?=
 =?utf-8?B?S045eXg4YzR0bWNkQW53b2lFNXFYaDEzSXpVWWNCNzFGQjRSdVZwelcrck1F?=
 =?utf-8?B?RlVvc3psZGJrOVhVUjZrZkZDVS9OL0dPa0cvZzkweTh0a2lWLzYzaVpnY1BT?=
 =?utf-8?B?UnRtbTRtL2kyRWFLVFQ0citLQit5aUxUTXA4c0FSUjVyN3dRY0pFdk1kc1Ux?=
 =?utf-8?B?cU12R1pWUitVZWhTMlNRZWF4VGhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(376014)(82310400026)(1800799024)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:40:23.9178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9ab6b5-97ec-4180-d606-08de5831d85f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11542

On 20/01/2026 14:18, Aneesh Kumar K.V wrote:
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
> 
>> On 20/01/2026 06:42, Aneesh Kumar K.V (Arm) wrote:
>>> On systems that apply an address encryption tag or mask to DMA addresses,
>>> DMA mask validation must be performed against the canonical DMA address.
>>> Using a non-canonical (e.g. encrypted or unencrypted) DMA address
>>> can incorrectly fail capability checks, since architecture-specific
>>> encryption bits are not part of the device’s actual DMA addressing
>>> capability. For example, arm64 adds PROT_NS_SHARED to unencrypted DMA
>>> addresses.
>>>
>>> Fix this by validating device DMA masks against __phys_to_dma(), ensuring
>>> that the architecture encryption mask does not influence the check.
>>>
>>> Fixes: b66e2ee7b6c8 ("dma: Introduce generic dma_addr_*crypted helpers")
>>
>>
>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>> ---
>>>    kernel/dma/direct.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 8e04f72baaa3..a5639e9415f5 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -580,12 +580,12 @@ int dma_direct_supported(struct device *dev, u64 mask)
>>>    
>>>    	/*
>>>    	 * This check needs to be against the actual bit mask value, so use
>>> -	 * phys_to_dma_unencrypted() here so that the SME encryption mask isn't
>>> +	 * __phys_to_dma() here so that the arch specific encryption mask isn't
>>>    	 * part of the check.
>>>    	 */
>>>    	if (IS_ENABLED(CONFIG_ZONE_DMA))
>>>    		min_mask = min_t(u64, min_mask, zone_dma_limit);
>>> -	return mask >= phys_to_dma_unencrypted(dev, min_mask);
>>> +	return mask >= __phys_to_dma(dev, min_mask);
>>
>> This is wrong, isn't it ? For e.g., for CCA, even though the "Flag" is
>> added to the PA, it is really part of the actual "PA" and thus must be
>> checked against the full PA ?
>>
> 
> That is true only when the device is operating in untrusted mode?. For a
> trusted device that mask is valid mask right?

Irrespective of the mode in which the device is operating, the DMA
address must include the fully qualified "{I}PA" address, right ?
i.e., "the Unencrypted" bit is only a software construct and the full
PA must be used, irrespective of the mode of the device.

Suzuki

> 
> -aneesh

