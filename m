Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.33
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795085798;
	b=PeOKtr6ZMfGaRNZKSeY2L3b2CK0oO0FvidYOPBm4BVG4sm1x8p7OaQkDYSNFJXBL2v9q
	 ksNWFXkJ7ZsVNHMNvy9n7zfubpbPSbxtMnQWn/0BSncK1Vz8ScX3vtewwzoIzJpTL+K6T
	 e3yS464d5qD8Q+2JfTtZYz1DOM38F/vmZ4F85RKfUOzOZXwIpiHfH8hi/+T2Cw2iyoLNo
	 PtuJXPUxCMH6TIZiRIdHsdPwSMKDeHbIjvsWfZYrB7kCS526iEpoS9nr21Jiryf+LFryJ
	 99ev6kG47lNT4AZxHNb1zfuB54tFNUb1Xh5GXGtWCdO+XNel09pRb4a9Z4n9sWMAUlg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085798;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=REzwfMyOiBaQkPOp96Gw8/jCs79oWDtvcdIsziBLKrQ=;
	b=UXzsbAgIFeKLK3yOIyRN8YIqgnlFsi585oOIC3sHukfVGag88hzc3YORQ9jFVW/8Y0c2
	 5fc4Mbue/36M3buzRQ9k/V3LnkYajHuUyYj1KLEMoczx7+48aKkOldhk25EdK+9VtNuM3
	 Y2Tvd9of73IFRn61oxpxgkJdQyzbPcZgijOWIzebRYumgZG/97vJJxhMtsNgcEuKHLvWf
	 2oB84BsQLPS9vt5R5sEaxWvbzhmob4+/S/zdEPUrl/ttVvOkzHJgQqHVkXDi17LjpEFRg
	 jyAcRyWmiTJdWetyL8iHbxDZWmNdbAqO4ujfC4uDq9smgBbjtYs6Wmw7/xixIAeYYJw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ZPqKQ49Y;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ZPqKQ49Y;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.33
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7500606A326
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 10:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7500606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ZPqKQ49Y;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ZPqKQ49Y
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ugABvYqFFOa9t7CYfGFxogGA1vIoIw1908iqMU+NIGcit13E1JIT5f7zZKREszFUKF4HEfl/0bgYHLBbniYv7l/IcctUiOqD1PXoAiOIQeeiMSzmcdmKii9en5gvxmL0CJT+zOTUUUgroVESqNKNLzEAih3A/yypweK6FKk1WGnh2OelN574BCu13UiQfLQ/by3ufgCL+TiR9S/2XaJ7892+NQDbZ6PHh/MBQQSc+WDr+Sg2za0/tC/YHF+CJ8BTpX0o5AMdKh+BDwt1to/R6CHpvx/DuhWtru0rrChbqA+0lY8K0po0BjfMEATenn0e4bvqJVdRFJSaSsil3pY9gQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REzwfMyOiBaQkPOp96Gw8/jCs79oWDtvcdIsziBLKrQ=;
 b=Sq0ndzr9OeHkLqDlfLM3QGswaWnzN6T9pjBb85S7Kd94jQZtYNCVtdGU3uSB9TCXEkCmM+o8qWku44N/fYc/hDF8EPBRfmMPK3Ko+hmH9fPAJNnnn0nqd+inxCiZroOgAb+O/FzncjhfrI1raCI8+bAmv5Bv9b0Cqt6CGmwBeykpDa4ah7jX0js7MTvifZGgBFnuK4CliABrGgpB5ObIXvsCaKKn7gbXpt8YheTaLX3jayj15mfKKWANH4uZ0AVCi/NKMR++H9tIrIDsV4El7jZ5STV4bEzj5O3/L1MTm2cY+JSH+htQc0Hadgjr3f+tvfALgTZ5X66/TT2WGa5fpg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REzwfMyOiBaQkPOp96Gw8/jCs79oWDtvcdIsziBLKrQ=;
 b=ZPqKQ49Ydea1jj2f0cHyTrcQP/A93feX+u+76724wcaSWDD0Xo5LDR5783jclXnet69EbHRZ7NCc1PkKhsSJ1ZZzIrHhkVfaaqA6HxS2Bjw3Jp9Z4iyqeTK5E35PQgOZ/0ldgQ9H6gFtaFP+pI2uhxl9YybDvnafsdw7bHKMmuc=
Received: from DU2PR04CA0279.eurprd04.prod.outlook.com (2603:10a6:10:28c::14)
 by DU0PR08MB8786.eurprd08.prod.outlook.com (2603:10a6:10:473::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 10:56:34 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::5f) by DU2PR04CA0279.outlook.office365.com
 (2603:10a6:10:28c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.11 via Frontend Transport; Thu,
 19 Nov 2026 10:56:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 10:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUwXOhnr+Guyw11nogfLsrzkadm3eTsHQgMtOTcbzE8e8rA/h01SkdZitwMDlBiMngcAdrX3sa9fAXd5U/ECdt4RiXHkaFzMJiXFPVGpyng6XD5JgLL5hI+dAosiUr5WjjkWxxP7b73G4iMwE63qtxpx5eicd7+18gjgAmVEe4ejI+6TtoKNdaRFIwWQo2T3UE6qqeAdQiUkabCTyG0qoN80HyXeH6h/AzuXQ/AeBPASDz71wugsFUkFfxafhQ8riUGjmx6EXxwOQ871Es6qp7H5rvHNDd73fe2yWzzaf6AezOSaFYLgeeUOVUy+159W9PGYbu1HAVvlbKzpZK7amQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REzwfMyOiBaQkPOp96Gw8/jCs79oWDtvcdIsziBLKrQ=;
 b=dYTOqRNz0GD5yQ1iRLrzl9nIzL2EliZ6YQl4QuLfDWF1JPT0lNfBgukFOYeScu9zGjDhX46YnMpOMOTz8oFdC00F0hMLp/Ob9LTq5LEibcZBtz0WqVepaqwZKYIWC8iBShUn9orXgh6kTsioycqZemsq3BrY+tvFaqb4X0T3CZ3P+4EhvIY0TuQT4hkn0K78ZtywPprhKPPDgMao4N9DqDtqGB0XoPowmlFrXA2Q1cGZ+/Q7wgoPwWF41j7fcIQ6YBMt1hzxdSTthTnbVTxIEBARplQzwEGjHa4leSrZ5g8sW0gLif1kjCiIJ0gM/X5BHc9ctsc0+jBMWcYvyWRSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REzwfMyOiBaQkPOp96Gw8/jCs79oWDtvcdIsziBLKrQ=;
 b=ZPqKQ49Ydea1jj2f0cHyTrcQP/A93feX+u+76724wcaSWDD0Xo5LDR5783jclXnet69EbHRZ7NCc1PkKhsSJ1ZZzIrHhkVfaaqA6HxS2Bjw3Jp9Z4iyqeTK5E35PQgOZ/0ldgQ9H6gFtaFP+pI2uhxl9YybDvnafsdw7bHKMmuc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by BR0PR08MB693770.eurprd08.prod.outlook.com (2603:10a6:2c8:5d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:56:01 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 10:56:01 +0000
Message-ID: <bbe0db50-acd2-4fb2-a0a4-8fb80e85fb29@arm.com>
Date: Thu, 19 Nov 2026 10:55:59 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.garry@arm.com>
Subject: Re: [PATCH v13 07/12] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT
 for kdump kernel
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1794942324.git.nicolinc@nvidia.com>
 <d9b9d642e61c0b41bf0edb2165d2d37dc6b0c20d.1794942324.git.nicolinc@nvidia.com>
Content-Language: en-US
In-Reply-To: <d9b9d642e61c0b41bf0edb2165d2d37dc6b0c20d.1794942324.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0004.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::9) To PAWPR08MB8959.eurprd08.prod.outlook.com
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
	PAWPR08MB8959:EE_|BR0PR08MB693770:EE_|DB3PEPF0000885E:EE_|DU0PR08MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f65599-6fe9-4fc0-6929-08df462bc661
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261021135927099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 4q3BQhGxXZs40pNteNBMVMAlChOGcoR6plS7BPK1Cg30brMQDBSwMpHYX/03zKSVFsUvCl6iT2PdGlBCu7PemMIlTQ6ezpH9TIJJa0rOUEUkgYGwwUeGJ0u7nxhacWKYMZM9nkGpEQxYxDIxG1OfDY6dHUhGM2555v6w4v5XOKO1Vk0a56J2C2hGLe/WZxNI1KxhKOSabqAXolaAsy+MEXusmNlpraqbc4bRunZjdw1xZYUNTi12r6V51on2HnKuwI7WeI0Jvikcs8ZelLVvOGsrTQ7YYeYVQtQRn0agl7X1dn/Cz59wJ9kieJlCOghYk3Jpbk67wVCARCIXHosQ4tsio86L8W07hU3MGrjppr4kVoLxRIt1zic9t4V4nQ3mwmC+oojx90/Zy5rnnYTzuBCLyb6xf+x2xSE9zTGeeErJoXjPjLZrxkFTpCT/x7CqZESC87Hr69F/1aAQRDs03a5rtIgXIq5chVe3UTqnSlIfepr7Ko1J3RonmTVjd+EZ55aDbOVfRusUT6dp2m8ikDGzTfEXnSECNzZ9tWEvQP7qx53lRYgoUWA8gufIsJVYdPJXcc9XmmoLyAwCgtjniSnAF9+zUl2xSy4hi80ef0Qr7hSyWybGz9anQk83AbcGfp52xFCE2GJJK+Tu8taHueNf+SuZ9BIjZ2rQsL14pss=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261021135927099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 oadax+3xOrBYZ1oyyMkT2NyBfYo2pzoYcAZ4flungtxXeCaVaW3K3FnIEZDfHes2M0uNb1BNpwQ0s3X0maWiC7qrR4RoU9golJX+v51tMmZVAoPeog9iX9NcFlwFUXXCo5nBGA3x4m64yYtkVZV8AXXMwj94Y2q3vwcyZB/BJi5626VhiYqkl7IYLKqPJjnmEjALTs3mPgEuaSZ1Ier0QWFKGH86/GJpXPEkMm8wlbtkcFcftQz/gs8HcoiU5ZzsBtCpYUPcSS62iBq3qQgBKfEqyCeVSMn+0TFkwmYoVWEtxCwEPVCKHfWumUmf/y0RhAHJLfKVFOnwIuQEL4r5rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB693770
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ac347cf4-512e-4487-193a-08df462bb2e0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|35042699022|14060799003|1800799024|376014|22082099003|6133799003|18002099003|11063799006|5023799004|4143699003|56012099006|261102123227099003|261026140227099003|261021135927099003|261022075727099003|261021121427099003|261022105027099003|261026121527099003|261009223027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CG+IwxBGC442Uy+mIRGrzAC1+u5ZEGENJe6UgZWEYDx6aduIgAMv4RWHTLYCn9UtYjndUBEiiQ1CdX5Kf/1NBN43QcdbqqDvNq6ARyQlDxOjSqCo/h7/siwihA5GYfeiQyOXvSvIcRmItEIaN24J4F2l3ywiV7D1FxjC7BX7jFMiyoE/22av80lnxPL8xGjO+pcRezzCgaoXsTAIJirICcLpPU70fVFOlLQlRX9aeYyhHy84l4R35zpkVkZ2a/sWJv1H/+i9uFdrh4dx0BnbTO7g2TeXsuYyiisFzyg62qDDubl5dUhhGU0JksCE/NCxllphKPMgUnAiXG5hldXoz4GjK+0CN7nHb7QrIiOsb1MuLsg7sUQQz50rwg3DmrU6tgDBTq+UXTZ+5NSpoGy/Df3/ogZUTfvd8m6B2YkoASx9UI9UH9HNTkbX+cn3858+I5NzaJbf/8wxydMUaoOxZoj5Oi/ThpPmFl3j7D55rHI+yjXrqCWyI+9yCpWCi0DhsI7x/J5O25v3AsE/BBB66naBzbkOgOOQds/td2c941jidUZXZWn3Wz5Jh9vzhDtlSSLq8cbyNQNDPK7vhWCM5tYrX7ToB12OgTYKAQGvX36ZWmiie2OBU/cxSoftSsXUj1NMfbTqOHLFAicVjNBrmdfo9PmsySzosy3Vuy2uMeZejtWWKcTmCBwarXhlfhXY/lXN3gjzEPXIM6Y5dCgRlQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(35042699022)(14060799003)(1800799024)(376014)(22082099003)(6133799003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(261102123227099003)(261026140227099003)(261021135927099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261009223027099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wDWujXhNTUrhT2GAk3tW17hTpqrtn6e5tSdVfermRZ5QlzP3cBgPBZePnoVF7JOAm5e72HUgeeudZ+d0uyW3jyBYetaKv+eKyHCjEeIJFWo3t28JohphELv5ngiyn92Lg3t3G7MuKUuExB6PXodEzgQWWLO5oi3BMHWfTvOv8Cni/0qQsp4BddbZDMh7l8TfWwbT6QyH259OeFzgylU/o3xD1osQa6Jd+eKsbMBHzc6m7PPRL220zPm3KYHJPJ/azgkKB+GZmNKYktDGzXg8HXo9DHG92dAB0rb2y5jfcKBx+IuUNZdx1CrXNhNDl2kZxnpjgJEjZV/HReUlFtnRicSwsisPJ6uMgbw8WlDpgjx4G6/tQE7N+V+J7/eK36jFUy2hoSaPbMw8MT/nUIX++x/o/HoNVdSw1cXI8GfdX7VmU1P56C053OxUqe4sKzZP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:56:33.4723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f65599-6fe9-4fc0-6929-08df462bc661
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8786

On 11/17/26 19:21, Nicolin Chen wrote:
> +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> +		/*
> +		 * Both kernels run on the same hardware, so it's impossible for
> +		 * kdump kernel to see the support for linear stream table only.
> +		 */
> +		if (WARN_ON(FIELD_GET(IDR0_ST_LVL, idr0) != IDR0_ST_LVL_2LVL)) {
> +			ret = -EINVAL;
> +		} else {
> +			smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
> +			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
> +							       base);
> +		}
> +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> +		/*
> +		 * The kdump kernel need not match the crashed kernel. An older
> +		 * crashed kernel that predates two-level stream table support
> +		 * may have used a linear table on 2-level-capable hardware, so
> +		 * enforce the same format here to match the adopted table.
> +		 */

The mainline kernel has always supported and favoured a 2-level table, no?

> +		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
> +		if (!ret)
> +			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;

