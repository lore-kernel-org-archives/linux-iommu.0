Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.162.42
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925862;
	b=J9scqqQCr/6Sfxv+AkEau1iow5HheinCQ5mjeHZG8h7LLnmnvOED/gM4TjKAVWeGWZwO
	 VrbD1lr0Ly3NJQBZwZKTPKnTJyAYXnGiKN5B2UDd8lTFgWQUsK4m9QuYvAJvXoj8UWbYH
	 A6Gbil2YFZw8ItMWZsEj1MDGIZAZlFI8bNwuE7xrNhtfUzGmJMr87q7mOEbPpXpUH63jl
	 eFYrQWh5KTfP3SA/35oMC2AlJUWmh6fqJ9xVSspT/O4v62wo0AQEL1yqrm4JzKL7t/k4p
	 eu+gbSeemmeGUzBbe2+oon0+e9IC2rN9JWHZF76BZSo+P/btnbJi9AUAZxN0q2a9EVg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925862;
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
	bh=mSgZAo2mesbk7WooWs40RKryz8l/f62/vPo9vEe588Q=;
	b=C+5fZgeQk7BQIvCbpZRIYQ9DsZWakdYwh05TPu2hvYUmCw0hJUHvZI45AFy+13PsBiOH
	 0vDQsJZ9Csbt3/ZbADpEigj9sjVahKXt+gRwQ6QDz9mgReeSHzDirazPj64bCTsZ0+yRt
	 cS3w68e8XlqhjIlgN+ITmc8+5ld8WxhKpO8rwFMWjuhE/AYoiYCDvQ4lRKb14/ZKncR6h
	 7Nlg4jiO4lL17X9CQmPARcY2bYe8YDTiyidq1ZiesWrVOWYcHyoTbi20d1+6S1H1Ne9TN
	 lhP7fZI9/kWbZUrPH+l/n07SjEzSCqyVOA1LUAdIN3OQICV6BxD5dSAXN+9L1TlHrgQ==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PTRMPtKn;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PTRMPtKn;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.162.42
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF5606A323
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 14:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89FF5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PTRMPtKn;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PTRMPtKn
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vyrF4a++f+bi3jwNA0I3W8VsQMf25SwapOaSW/b5wVZQ72JVRB305neN8cCB/UCvBhFUmU33AyKq1F2FgEGcDD0Jdz4f+Rn5xRnsQyLDRDM7eZc9YxXaG/hXPpHp3W0kPErRucsbss5OJrXRgeSyKtnxau37sDecMwW77HgTK5sc3xYB6nWbTlapI7uMmvaW3SkyrNKw4tKprdmcJsKj5Vlxdc1xHp4fAQU4ecgZLdDNzntkkpjA0e8GyfHFU6f9xyQJCEY+IFURUXAnGq7e3iI+3pndPdR092w+/+DzUbx/6vZABn0+BInGwKk2ZaIlidTsBLPATkaEd4iYQ+Dz4A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSgZAo2mesbk7WooWs40RKryz8l/f62/vPo9vEe588Q=;
 b=MqiSxAPUrUGuSxpxD/VAeEiihMZ5fcUJttKaEIk2C4QRWvnjJQ9mLhZIFgbOtNBbJ7Ay4x8/3EnyNaPRsYp0IuW+CETLuvQa9gEWQtpsYdbqVz0ekUyqdkquu7cEzAoKd9HiECload5zqG4C4ddTIpRrv8TJoedXM+iT/Ykxs/aTM+cQJ9YOMpKMlz2NMF2BIKpmPAdBLVshE/XSq9UM489kPJaHCdW2CFZzznVbKu/tuJQiyIrMS7nGNakOYcG3foWKToweA6I4E6Th0ZuMWZ+nhUnsT95a8flAf1UOE9jlP8ZNu+BwtwIY2QYgUHwR+j2mX7HgYytps2dnmuC4aA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSgZAo2mesbk7WooWs40RKryz8l/f62/vPo9vEe588Q=;
 b=PTRMPtKneAcuEQ4wTbbRUnKmGd8103+YsvOuO9ruVvbNwYlDKkO0GP8FvnFE0B99nk8t2A3M+T+e+iwOlRfORuuoS8f71yKkzOmPvK+Rc2+fnyUOwfjjlw1jrVgrpxVMI1L8ztVmaDVmD5xuw2z6HvQVMXBzkLLt3b7noONZhAA=
Received: from AM6P194CA0009.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::15)
 by AS8PR08MB6085.eurprd08.prod.outlook.com (2603:10a6:20b:294::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:30:55 +0000
Received: from AM2PEPF00070CF4.eurprd02.prod.outlook.com
 (2603:10a6:209:84:cafe::77) by AM6P194CA0009.outlook.office365.com
 (2603:10a6:209:84::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 14:30:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF00070CF4.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 14:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4gZdqJu7dz5ymafcbLlVnW0OX73/vZNsvvrjdY0+n1TR0rUNc/GnMvVoLkJBKmeU0e47ZwpeJ4hnsm8ia/XPdCgGzFpp+5sgMPWK7UlBdbzTRjicvsuXz8Fvps1n8i+u9BGJJRZdRIXy7lAHNeBciL5YeoM6375ZnchbO9vdmwxCqyneK4Hfdhuqd46K8isGIVmFCKddMBD+x+v4twoncb2msGSqnQQTUvDlCuKpsXUqi5QvCkpdaQsqvFd+7UBuwVRn6OIH5+L/8Dx803w3aHUJKXIdl50oAjkYbuiqqE0uFMIDXMGmQpQptjkqVot2es4xdOp8iP7SI7kCnxBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSgZAo2mesbk7WooWs40RKryz8l/f62/vPo9vEe588Q=;
 b=UBOc7mxFkwfroeQJ8Zl/126tiUM6RvgVdzTQBBao4tDj88TYf2Lk/SW5dzK+5iFRqo4HIiRDvJ0BTA1C6mWBs4TIEpGuRbTxigmuvT0qXO7wREVm4kTtECjKD/ZIUft6F4KowxgRom1TZ2Mq5Ez2l/7Z+m58grQB275E5RCSHtiVxY3G1x8rf/QPBOCq15tfAblQWnarkydLCZBdge0LHhCEym72OiZo1Tqih68bQTQCfjBO+BoGuGYdNb73M6ePX8JaVAo+FGwEigTPTdvtCVsqktzPRJr+S73x3g0Aq0UhCOIY024HONEHH/ic8nxyFfcYIxj2QQSmW8BYZVYNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSgZAo2mesbk7WooWs40RKryz8l/f62/vPo9vEe588Q=;
 b=PTRMPtKneAcuEQ4wTbbRUnKmGd8103+YsvOuO9ruVvbNwYlDKkO0GP8FvnFE0B99nk8t2A3M+T+e+iwOlRfORuuoS8f71yKkzOmPvK+Rc2+fnyUOwfjjlw1jrVgrpxVMI1L8ztVmaDVmD5xuw2z6HvQVMXBzkLLt3b7noONZhAA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by PA1PR08MB402775.eurprd08.prod.outlook.com (2603:10a6:102:54f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:30:21 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 14:30:21 +0000
Message-ID: <cef6ee03-7b2a-41a2-b7bf-b321ad6a03b9@arm.com>
Date: Tue, 17 Nov 2026 14:30:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/12] iommu/arm-smmu-v3: Pack the MSI vectors of the
 used sources
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jgg@nvidia.com, robin.murphy@arm.com, joro@8bytes.org,
 praan@google.com, kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <0d28afd67694fc6882e0ff5f054027488b1cf816.1793593923.git.nicolinc@nvidia.com>
 <db4f83f3-d35b-49b7-8570-04e158125b53@arm.com> <avtSD34Rj5+XAz3t@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <avtSD34Rj5+XAz3t@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0565.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::19) To PAWPR08MB8959.eurprd08.prod.outlook.com
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
	PAWPR08MB8959:EE_|PA1PR08MB402775:EE_|AM2PEPF00070CF4:EE_|AS8PR08MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: df195cad-322d-4138-4f79-08df44b763bc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261026121527099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 /c3YS6fhfwTObEdz2yneW3geVobrGwfFS9Bb/fJy/Kx5c8rC/an/Q85+4GRp4OVB9x8XEvV+oQ/PWUav+Es9OWwyx17bigZv812l1ufdTgFWFlkZOYczLxZKYkP+6clvxhvdcAoOMol4u/vqRV5Dm0Pr1jXctTMfHnUrPwlbHVn6HglVkrRtMxWO74DOtVx/yVbwYQA/I0Wubj9Kvz9SF52ql8j6swvr8xW6TbGj58EISliLoULM36TZmYDXRfio+f3IEf7Xz2P4mpn6/pkAh8p5p6IPNfIsK+uGdt7IVdXALp7tpQ22TorrMmPYoyTvGuPkXKZMf9kvgRh52rrGlkKoPaIhWTzqC01Ah9AXqmdJfXGkOyaahSR34IWF5p1Byc4bX6or8hTkJKqHmwPd+ALYsJUrTYOmBrxrMnqaM1rVCta2WJHL5cx2SlOcK2zF+ayKCrO4jmPOGEwxfuQ0Rwasm3+traXoE2ZWe6IqP6JK4PAeUhntpF9LMQdom32ZU5O8rH0lUtBMME4uepPgycBuAxiBTmJiryL2Y58AhTjIYDqBFendHRGbagUxKiptaTsKMqhwREmiJc1px9m29FTk6Lb6omSSdjrJgiCjiM3j8apfbqTmXh0bDMWa+Y+xgC8ISDFU1QzG4wqjoOYWGFSLr7k3tWcIssqLz6Vq9zY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Nl3lvyhhLbdMDu5tIOpjQ2sAH+Qtnx/nzlI1Qd21JUMh1R/FlysTIEj/wwDE36Iz5WsvwqVA2LukcKWDY07EBGxssVyNbgxZGHOoZEzVLzYyqPVAa+17Hh+bQCumSplxkzizUzu14q/melU2aSzkXEThK2895kfvT6OrEnz60N6Ibdk7D16jkNOKUgqFDEPvSX6cE+h6oKSyyie2vVhNt8CsGEb37OOC5sm7XvXzgUBW9ySX0w6/bxrv+fI1HJAzygsAelKmpAX7X4hUwaAEDHdHC7D/i1+6wEPJxDeEaGBo39ib/Ni7g+7mvZo5EFYuwX4bkc5O+d99n5AKTpzXBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR08MB402775
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	487cdb67-1f2b-491c-4968-08df44b74f52
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|14060799003|1800799024|376014|35042699022|7416014|22082099003|18002099003|261009223027099003|56012099006|4143699003|11063799006|261102123227099003|261021121427099003|261026121527099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0uQtSX4JbOYkDLURxxegr10BI/cCF2/zm7cZywvxBeNcEkDVhLpSinXhF4WVDWE0iy+iKL+V6O3Li68NOmGl6NkDXhEDPb9sAurXP6L/Ew1aWlzM0UGQk/W//9Jxgvmr4Y6VGaQEQtyl3CoTTPBgghTteMkBKNmcG4+m3Wp36j0mKuq+Qf3IRFsPkT/3ewYeKhUnYVHD+SK0QdjdoMyuAYW01+ySD5bJmoKhVrqcHe5I7YNi4xZSG4cPG4RS61hcmLXeYhIoInlyXQdgT4FxQyEH//jJTZAEJAuvLktiiJridEKv9tHYVg7a2VHAU87zmQiNPbM5y7qBrwoCqKfyD6j6FlFWkEfu4Ki8d32UJQwLP3cCkS8xZsLnIC6VL1u15pZjSUfBajwGa/Mii51qMFNaJQ2gVOlhmZeQPtbLXe3xnHf8rqiflcKbg0rpbl9QnJipIjZgOVDmQPZQIxPWkru4yRgpWvP+VkFn6UJCI/+Xf1Y+rakBW/0ir//nl97Va2AsNsAHp87US60OPAnpTY7FeLAYmbvsWPd8wTWDozeJ4ODivfOmxiup8jETHT/OH7BMUJ9Q7kPyV4qrtMXcykPaZQ9nZtbOf6lWypr+MvpLezNRgnhY59rVWfSEioLGJ9FlW+Fue2GRnTC0yIx971BEJ4gX26htw9T+bO9EbuZHHbVqXZ/D1iZVJq/6CsWyK/6Y1y/smRgraYREZb2vOA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(14060799003)(1800799024)(376014)(35042699022)(7416014)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(11063799006)(261102123227099003)(261021121427099003)(261026121527099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VSwaeOv5LHM/wfP4KxmS5N+uUeyQAvK6OGkGOp54UpGR0/N+xrVqKHg6ji8RaUnKO4BVW9W0wf/K6YtQhOZz0Ls7tR5ksGSEcukGhvj1XytTSJChv0MXKY//c9HcRluWdnWIuz8fM/kq4jrFF9DuQvKuIwHOOimp8/P1FfTlguw3w5laD9pr/62rhJs20eoaOB5DgAbM/imxURQEKhCRWnNGH5dH71bHPBOE9bRttpicPT9ZmDBK6XVl2rllEwylxen3q+RtM+Kb1X1AVxBySyvUQDCkJerE2wAEiHrLFdnaMLYGABFwtz8YzZHo2h2pSRCluVlhr1J9Kp0HqDvLzphTBri0RAEYqPLn9SrqQZ3MKH3WakMx51ypNIZUYmdC/cSlW0ZoOTVnxVCqerqz/4BHEWPejR9Mpn7DWg2pyoxqRVDojmtMZC/BD9uXEGKr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:30:55.2035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df195cad-322d-4138-4f79-08df44b763bc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6085

On 11/16/26 18:57, Nicolin Chen wrote:
>>> @@ -993,6 +1000,8 @@ struct arm_smmu_device {
>>>    	int				gerr_irq;
>>>    	int				combined_irq;
>>> +	/* MSI vector index to enum arm_smmu_msi_index */
>>> +	u8				msi_map[ARM_SMMU_MAX_MSIS];
>> should this be an array of enum arm_smmu_msi_index, as in
>> arm_smmu_setup_msi_vector() we write a enum arm_smmu_msi_index? I am
>> assuming that is why enum arm_smmu_msi_index was relocated.
> u8 is optimal in cost of memory; ARM_SMMU_MAX_MSIS is needed here.

Since ARM_SMMU_MAX_MSIS would be 3, I don't think that the memory saving 
would be so large. And since the next member in arm_smmu_device - oas - 
is unsigned long, I'm guessing that a gap is formed anyway.

Thanks,
John
