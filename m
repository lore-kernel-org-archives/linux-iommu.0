Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.70.38
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825037;
	b=G9q7vxJjPSlryi8znvzDtZ8v+90OXid2suoAt/jKZGgtri+DMrbVI/V/ORAVY6e6Btgl
	 AwUbSlNN8wWeLqO6lqK6ij7zhZE7LiIn9juPx7heegqtwSMZdagYOjWYJdI73Gonaa9NB
	 gNqR0/xNgSC0e2VOF4kWJOKanmP5TyS2Acr9hX9l/8WjVsY5KGyoHixYjllgiGb/BEPBh
	 h9I9HKU//SGowlCnvrE79nga4dXQgeDR5jgqAs/neUocKTwl+EdWPYFNFC8icQOEvMILa
	 eEzGJZOQMQv/o5fbkwKUx+5nKqKGyd03Mezya7gAR+TmIp5qOVYr3J+8J5p0HqRFJwA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825037;
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
	bh=fLE8+3OQOfF6IUhuX3KQW6DM/Na8lB7h3OcXiQ54uDc=;
	b=MAhaNoGFUPABBuC22Z83RQPfovCpVI+AaiK0/KpCyhdKiqhTet8+Hvji+fcCP9P3+VYl
	 F8VOS4SZ/5sZBBU8nM8KrX/RhRLKqRA1vc9yIkK0fWLv39h0xCBLWdUZaEWkqKZJ1XxxW
	 Fe9gy7qK5AjLfcSViuNjxVkS5J8E+PXodwi6mjiYI8ra62qMIAnA9NO3/6QNhXstEA7K2
	 PRaXtagfnEKKnptNpcoDvFoRBG/qQFE5eqEDeiqhgAAllpX0bCnnmgbNupYbI7RkloN9f
	 xX3TMPM1cyzJzPoEfkXTvX547dTLtyen2CR7Y+rCkr5gpXDy67RrFtklpsrwfsGevxA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=kMaE9ML8;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=kMaE9ML8;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.70.38
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF09606A32A
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 10:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EF09606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=kMaE9ML8;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=kMaE9ML8
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KEOepP2n5YWWGwB5Mx8B7dKx3KUxIzP//xoOPqrMXQaq6eHOvZhqfh2trQlERf5WxbLan96yrd97quxEElxnM8hSZxbq6b2Htcp0ds+1pEcoyS8tDBG+0Hs20uFEXGrHH56JFKZMkj+bGDBYjnXD7+/EMGSSkfvjiW4eLrNjWR8ikhO+Dv4fXrngADkWhBvVQWZF7Yl1q+3nXY4rDYX9enuzUtkb6pt2cXHhr4Z2BZqrBHQOVwRGtSYZloCLnHlIXSiEMez2Gq1JPcGp4My/cb1491gz5O7HzK6Ys3yagJmt8/ICuiP3iJU8DzrGUzu4xzxyAWpMgOcF5yF9fxlJKw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLE8+3OQOfF6IUhuX3KQW6DM/Na8lB7h3OcXiQ54uDc=;
 b=XWir4w9KIBRFhhfqrV//XLMgVpctQFRJZMwbRGx5KQCDoG/RukGKxirO/knDZApjVKXnCo2TkkMopGSYQTatNdaOHTllhG+tUxYetdtGHTESnr4EXXLC89Trco22jh4d7jCXX59EoH2od62RmQvcwWr97JAam4Dd9S5189KqAkN1PsLaf2q8LknHftoloooYGcl9sKAmTg5bN12rvFP9BUkEtm8YCv9mgDijjcPB8D+ryZT60LHZgjxtPWOG7wwFMA/GJ9sB7t8kDUak7rQtC9V2rC8UbhKCgCHBsml5CTQbg7HvR4vs/SRbSZhnH7HUEMaEU1VI//hLytkhK5qp6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLE8+3OQOfF6IUhuX3KQW6DM/Na8lB7h3OcXiQ54uDc=;
 b=kMaE9ML8lmv4LlBvR3+QPtvy0vMekuvtTa8JYwqGv/0JO6+fnoHqOK2LXnMMZnVodxGMDCINpTDiFBqR1qpzvTp4DbgD0SCBo2RJcTnpWnj4jneNfipYhbJlD0WLnmEIPyvVMoFKwNKngfIsM/vU1QRHygdww1SEVTaWl2vEwug=
Received: from DU7P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::23)
 by DB9PR08MB7796.eurprd08.prod.outlook.com (2603:10a6:10:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:30:26 +0000
Received: from MAD0EPF000008B9.eurprd04.prod.outlook.com
 (2603:10a6:10:550:cafe::6d) by DU7P190CA0029.outlook.office365.com
 (2603:10a6:10:550::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 10:30:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B9.mail.protection.outlook.com (10.167.241.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 16 Nov 2026 10:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRvyCYpTsBMR5vVFszTbLEXm9ql3SA5mIXDlqtW3beX71/tEgRsOZWmmY20Mqi/hOz2IOODXzSyVg/bDRt5iMGJnfjO+0aa56AoIDNBngmo+pleBrvzyWRdY/gxrd33g9dep2nsdgCnynfE8NkYFJFX9oGI1Xul40pUVUsBjiDMuMZ5wphmoZG+RQBYqJuMOZg9Vdn1WkrcCdA/5J2ElFfoSkksWczrQda0cM2h9wdiYhHrvt3Nf9v2q8C+BlnPhwZa5PMFoXo4QBu/e4cx20VseZ6zSrV39eNhUIj+p+Fc8vmyn+4lsI9rKCll5F5OmL/x7m3yXlZ8IcGkQyTQtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLE8+3OQOfF6IUhuX3KQW6DM/Na8lB7h3OcXiQ54uDc=;
 b=AINQlL3lER3xJYxr48AXgrbbRlXbgxst2+hZPM17nqGn8DWNKKEgVCiforgLUdBzEA/a2wP2u228v3dp0pGUMfFLutjCNGx0fop7oBaFktyeZ7/I1sl6XFdGNWEXj7Wk7fZCqutqJVd1bQcaXrMyJ690/y5M4rleA8+h4VudGDoF8UrpUA196UgPd9/x3QsEfWaFW0AzDPbtiL+BqTlq/9p4srMXVaUlSF4AaPWOq8hOEeuGWtzgPq+Zb7R4E6geDt08lGYV2W9ix41SYb3IY4nxnldojvbwiU+Pt/gubGb9uwpzRM+FoCwg7omxLhox8m1ClAOeEwC/6G7iOsHohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLE8+3OQOfF6IUhuX3KQW6DM/Na8lB7h3OcXiQ54uDc=;
 b=kMaE9ML8lmv4LlBvR3+QPtvy0vMekuvtTa8JYwqGv/0JO6+fnoHqOK2LXnMMZnVodxGMDCINpTDiFBqR1qpzvTp4DbgD0SCBo2RJcTnpWnj4jneNfipYhbJlD0WLnmEIPyvVMoFKwNKngfIsM/vU1QRHygdww1SEVTaWl2vEwug=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by DU0PR08MB8836.eurprd08.prod.outlook.com (2603:10a6:10:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 16 Nov
 2026 10:29:48 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 10:29:48 +0000
Message-ID: <db4f83f3-d35b-49b7-8570-04e158125b53@arm.com>
Date: Mon, 16 Nov 2026 10:29:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/12] iommu/arm-smmu-v3: Pack the MSI vectors of the
 used sources
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <0d28afd67694fc6882e0ff5f054027488b1cf816.1793593923.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <0d28afd67694fc6882e0ff5f054027488b1cf816.1793593923.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::21) To PAWPR08MB8959.eurprd08.prod.outlook.com
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
	PAWPR08MB8959:EE_|DU0PR08MB8836:EE_|MAD0EPF000008B9:EE_|DB9PR08MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d83546-e4fb-4880-ee6b-08df43cca073
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|11063799006|4143699003|261026140227099003|261021123027099003|261022105027099003|261009223027099003|261102123227099003|56012099006|261021135927099003|261021121427099003|261028144727099003|261026121527099003|261022075727099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 2J9ircnhFagvL7iEQ5DkLmfurG8G4z08aH893KQ4WjR5ulP91a/0Eet5r8+C1H6jXO3CwYgjQxTuEdgsgHe3ujj8HHeugY2q7+iVMM2mNFXHkMyDyfwqZ0DIYRM7UAxht1Q5D5P8E1TAj/TKTsHxyZ2dsiaOkPOhCrDp9kM5JEWk0zHu9wkNhvxkBaHZ1UT2gCH0WK/msCvogX0rZddmRbcEbZXw3SLl/tt3csGKlhfBCp3ha3KEldm/VJ6K48W77+sJ0R7axU4eNdrYvlWLPAeZVAnV72qbdjDVahwQpi7RUWejIne5caOn/ksh95li/jU1RtkwDwIQS/qPdldyjN7SWRs3SV42bINzk5FKCaB74FciOMUoSqzmYKDS/Bzh+H+NcGmuhq63Loe0Tu9JXs+Oy/Nf0gmn7Hc/pe/fAPil/A08ZaR5vtHsYlMXz+LJ2Isqjaml/W0Y9aa3O3S8SGdLm7pGtAspz9TU17T/ZnVievugGRdMQJq2DQjuiYm4xhOgYEjCBpDG4R/ZpSAxDLuPa++1L5NNlIitojPLF3iHzc4SskT2pHpxh/jCIHteCqMoPdwHJViqgJrYayvk7QyGx2EHnaxcG12ai57EJLTRv407nl++1V4XzR45SE/DmDhNAJBCPAokxZ6zFwJe79eWH2mu9/jn7FTdPPO5tbw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(11063799006)(4143699003)(261026140227099003)(261021123027099003)(261022105027099003)(261009223027099003)(261102123227099003)(56012099006)(261021135927099003)(261021121427099003)(261028144727099003)(261026121527099003)(261022075727099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 JPYSZIkv8KZ+ozRukxatjOYc3xmvDHbtPTHpuQii2lNygRoviLfmIeiQXEAYivr+eUqcykJuLpk1/xWq3nwc3/3Yr5D3YoTJSdfNd5DEobRysJTtjAn9xzMsRCcS/CZ2tUY3CmIMubaLXn8WpaiN6IkzkZGEgWATPf94Lv9RzNdqaNQnwXiHNWXBOMqkzyVRe/PtSLSg3EQgQPECClsRVTSSL3LLcV3XclrLn1dolJ2Ss7q8mjEMjzqkpoVDHunkOs2CYCGlbU1xy5DudJ/7C/dLi+5YOAVHV6ErA8p9V9l5WYTOnB7BshT4ea0R7wVHwGCJuhyp6IhbibW/+GnDiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8836
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008B9.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	823efe75-9bb9-4e3d-5051-08df43cc8a22
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|35042699022|14060799003|376014|1800799024|82310400026|36860700016|10067099003|4143699003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021135927099003|261021123027099003|261021121427099003|261022075727099003|261102123227099003|261022105027099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FmdhcIG5CP9hRvwXGRJL8h4sgqW2b4P9LybX94tMFa94jE/q+W5QnAC2uja0yoO6YdtMOvlRNMKhQ8YlYrz9zt3EZXomXoiTLaKU4/v4lBmCEY7/RBmN1akDffwhB8Yhl/cVETjkx7zNl1l1S2V9OhmzVV5VMS97s4kf4JxO5Lh/uERtZIrXnMTAwn6yv382oUSXFPcUigA0u3oCfm0Ho279lzfVhnoA11y2EF26X6mUK59Pql7rT7A0bzjhDSWENSf08UYXzf/QA7eqXB5LCBrdNnCe37k0JochxwZ1uDSgK3+kQfkz/jj9TDUoUr/1ZuZ+IgL+U1UvXDgwsvzjyqX0vu4vin2eGxY40OaJRi3Vw+boK3DFkxlasjOWqpbAjD/+8ZrRyDM1NnrFpRTIqP7fKmIO4b4bDDB82q54nEak8LR8n27c7bxBz8B6xyxnjErc3PfysIJgoKZ1HO9MKT1d3fRW1oFe5aTfBQReyZMtqQq9jb+BdubRdDQiJ/C91OK8XTFrhEmXiF1sbZyYxQWYEkY0QSnFOXKkQ+D8uRQC325+r2+fI16+snJQpd1UO05FKXXh0MF0Ihd6OOQCJgZA6cBoMpO11Ky4u8/75gaLGtq6gSsm6EvctR9he2a2AV6aPmU6LYDwJUG3ojjdvBSKhnCcXkERZs8bWTyVvlXqtmqI85actMoQoZKhkGUML7eg4Mo3WBC2eEKtcVMWiw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(35042699022)(14060799003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022075727099003)(261102123227099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FhbB7MUTfOaz6nQMLlgZKLt2XSwU3sk10ugeC2Bk3CsyTjr2o8No07YxoSfyCd5qt4AnGahfCOUKF+mycCI5bJhEWe6PuUAsnJ5pEvwpTEd/fQAi4Am5NAb+SgnoFFNRBLg0B+Bdtmpn24CsR4+iC4uWxdMJxMGTaw0z7e5P2qsgNfu7fPW9NkhoMLcjhGLhz9Ek/LI3MzPGcUlGQMdJLvfnN7IDlDTAUYqJ/tNL/tnTKaXaOj0TQGOBUaDVG0JlEaMrwk3reiNnHFvc/eIDh5znclNjlqBDP9dcKH5J/CilQY8bpZJPV+/pl6mY6lNrvqMGlFps5hT1Aj1qbY57ULTS+5gSF4o3/7GdY68h30/cv+iNo0Db07lc/17lCn4CEuMmcevihU+EJA4K22iN1orj1UiRj3OYcvVzzLzl19p5rek4lMfLSA/X54hfM8+A
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:30:25.2295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d83546-e4fb-4880-ee6b-08df43cca073
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7796

On 11/2/26 05:19, Nicolin Chen wrote:
> arm_smmu_setup_msis() skips the PRIQ vector by decreasing nvec, which only
> works since PRIQ_MSI_INDEX is the last index. A subsequent change will make
> the EVTQ optional for kdump, whose index is 0, so that trick won't work.
> 
> Pack the vectors of the used sources instead, and record the source of each
> vector in a new msi_map, for arm_smmu_write_msi_msg() to find the register
> set, regardless of the sources in use.
> 
> No functional change intended.

I just have a few comments/questions on this patch, below.

Thanks,
John

> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 42 +++++++++++----------
>   2 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8f2c0b1cc4a8d..bce592fff0b12 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -936,6 +936,13 @@ struct arm_smmu_impl_ops {
>   			  const struct iommu_user_data *user_data);
>   };
>   
> +enum arm_smmu_msi_index {
> +	EVTQ_MSI_INDEX,
> +	GERROR_MSI_INDEX,
> +	PRIQ_MSI_INDEX,
> +	ARM_SMMU_MAX_MSIS,

nit: I don't really think that the trailing ',' is required after 
ARM_SMMU_MAX_MSIS, as I asusme that we will never see any entry added 
after 'max'. I appreciate that this enum is just being relocated in this 
patch.

> +};
> +
>   /* An SMMUv3 instance */
>   struct arm_smmu_device {
>   	struct device			*dev;
> @@ -993,6 +1000,8 @@ struct arm_smmu_device {
>   
>   	int				gerr_irq;
>   	int				combined_irq;
> +	/* MSI vector index to enum arm_smmu_msi_index */
> +	u8				msi_map[ARM_SMMU_MAX_MSIS];

should this be an array of enum arm_smmu_msi_index, as in 
arm_smmu_setup_msi_vector() we write a enum arm_smmu_msi_index? I am 
assuming that is why enum arm_smmu_msi_index was relocated.

>   
>   	unsigned long			oas; /* PA */
>   	unsigned long			pgsize_bitmap;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index cb45bd154c9e5..a312984bc6a0e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -56,13 +56,6 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops;
>    */
>   static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
>   
> -enum arm_smmu_msi_index {
> -	EVTQ_MSI_INDEX,
> -	GERROR_MSI_INDEX,
> -	PRIQ_MSI_INDEX,
> -	ARM_SMMU_MAX_MSIS,
> -};
> -
>   #define NUM_ENTRY_QWORDS 8
>   static_assert(sizeof(struct arm_smmu_ste) == NUM_ENTRY_QWORDS * sizeof(u64));
>   static_assert(sizeof(struct arm_smmu_cd) == NUM_ENTRY_QWORDS * sizeof(u64));
> @@ -4933,7 +4926,7 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>   	phys_addr_t doorbell;
>   	struct device *dev = msi_desc_to_dev(desc);
>   	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> -	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
> +	phys_addr_t *cfg = arm_smmu_msi_cfg[smmu->msi_map[desc->msi_index]];
>   
>   	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>   	doorbell &= MSI_CFG0_ADDR_MASK;
> @@ -4943,19 +4936,29 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>   	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>   }
>   
> +static void arm_smmu_setup_msi_vector(struct arm_smmu_device *smmu,
> +				      unsigned int *vec, unsigned int *nvec,
> +				      enum arm_smmu_msi_index index)

mega nit: "index" as a name is quite vague as we are indexing vec[] and 
smmu->msi_map[] in this function. Maybe "msi_index" would be better.

> +{
> +	writeq_relaxed(0, smmu->base + arm_smmu_msi_cfg[index][0]);
> +	vec[index] = *nvec;
> +	smmu->msi_map[(*nvec)++] = index;
> +}
> +
>   static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>   {
> -	int ret, nvec = ARM_SMMU_MAX_MSIS;
> +	unsigned int vec[ARM_SMMU_MAX_MSIS] = {
> +		/* An unused source maps to a vector past nvec */
> +		[0 ... ARM_SMMU_MAX_MSIS - 1] = ARM_SMMU_MAX_MSIS,
> +	};
>   	struct device *dev = smmu->dev;
> +	unsigned int nvec = 0;
> +	int ret;
>   
> -	/* Clear the MSI address regs */
> -	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
> -	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
> -
> +	arm_smmu_setup_msi_vector(smmu, vec, &nvec, EVTQ_MSI_INDEX);
> +	arm_smmu_setup_msi_vector(smmu, vec, &nvec, GERROR_MSI_INDEX);
>   	if (smmu->features & ARM_SMMU_FEAT_PRI)
> -		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
> -	else
> -		nvec--;
> +		arm_smmu_setup_msi_vector(smmu, vec, &nvec, PRIQ_MSI_INDEX);
>   
>   	if (!(smmu->features & ARM_SMMU_FEAT_MSI))

In this case (or any other time in which we return early in this 
function), it seems less than ideal - as a coding practice - that we 
have written values in smmu->msi_map and they won't be used.

>   		return;
> @@ -4972,9 +4975,10 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>   		return;
>   	}
>   
> -	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
> -	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
> -	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
> +	/* msi_get_virq() returns 0 for an unused source that has no vector */

So are you saying that msi_get_virq(dev, ARM_SMMU_MAX_MSIS) returns 0?

If so, do we really require checks like the following:

if (smmu->features & ARM_SMMU_FEAT_PRI) {
		irq = smmu->priq.q.irq;
		if (irq) {

I am talking about the ARM_SMMU_FEAT_PRI flag check, as smmu->priq.q.irq 
== 0 and ARM_SMMU_FEAT_PRI unset seem equivalent.

> +	smmu->evtq.q.irq = msi_get_virq(dev, vec[EVTQ_MSI_INDEX]);
> +	smmu->gerr_irq = msi_get_virq(dev, vec[GERROR_MSI_INDEX]);
> +	smmu->priq.q.irq = msi_get_virq(dev, vec[PRIQ_MSI_INDEX]);
>   
>   	/* Add callback to free MSIs on teardown */
>   	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);

