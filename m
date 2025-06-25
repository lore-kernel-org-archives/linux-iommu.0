Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012031.outbound.protection.outlook.com [52.101.71.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D42BD59C;
	Wed, 25 Jun 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.31
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848137; cv=fail; b=KLSVt6q5T/eGF0jRro/WxTloibKwkOnTKaMjSu0jHF6AJtW1jDPWCYDAX+of4LcRNH5LiWzhbHYxU5g2/BtrXCXsa8giswQMYGKOA5NF7vIjJfNdxBYc2d10qwmehZy4AKctYyIUCRJtbwg3AUcs+hGfRk/JkFuMSYZI6Un/DuM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848137; c=relaxed/simple;
	bh=0fG2wx7X8FBGD3gTUBaxkiFJuSyaCrh3/XDI6CtY4QI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPvMrqi5krUgbCkSvTbYfb/qWYbA+bDvYCGgKfPYK6foEY4wLX7txLMSe7Ga6txoMXQSwQ0QnYqacKOdIYwG45wKzD2JVhHBzyNQVKrLlVtFg0ul2nHEVYttASLcmpKBnnWmNtwszxsygNxQXph80Jf4QXVcDp3VIm9/4XHpB2o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O1DvjvSr; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O1DvjvSr; arc=fail smtp.client-ip=52.101.71.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O1DvjvSr";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O1DvjvSr"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SmyJbswUgG8Rw2qj2r/0RUgaqcAgvppJ4IXuA2lcRma1lkpYWGL4/s26FRQxGVSmLQIZW59AvzQjEDpRq0elCj9SSsvyaCUWCfZ7XR2VDmdfcIb2cegje6T8AShq1zQ0a9tpetxJ0nyM5YROz+ounpnSC+6Hd183IIPKYwOXGgUeXefETes+rhQtcUX3IsHUU1t4CgYthVGX1afle4zdbdJ4vEQSEip8SQnooX8NMjaGa3zqU0LSA4sJAU2jYCKq4Sk21HrKpkRi9BvrTf05bL6OiNFfi7LCf+Fa05ywrWNEMh9B1xK57acPN37BxDPoqbbxzMj4AADiqYvHo+sK6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRhHiRZhBoGmNlMLKTsjbkQfA5hlOD517y2RPoD7AT4=;
 b=QYCOBUhF4Z8N6zkBuDP6tEGiw+BwqOojbukMQg2VAoe0nYZEUZ8ITC8J7LPIghFsyCx0Gp1FIpRzRdOMNS7nEHYkNXZFFbRx8Hst8SydtryNuprWVJ+FnGk+A2SauOiW/P0KwmfLIHXepHs3oYGZYxtobF34n5TfN4aHlRA7jYpIscGvWdDiJM0S9lyyWBQoMcuUsosoYgDZaXoerm8BJoCCcag8BHcqXeFEzyzUaVxDn0zoZSH7kf4Nd2jmvFozAFsGTNYlTbIbIZioON+rtS1sp1LphiKcRmd9KMLVNG75hHLHuFvMkDCPLOXWk97teBUfPZjiQHQyzCj3bTVUuw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=foxmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRhHiRZhBoGmNlMLKTsjbkQfA5hlOD517y2RPoD7AT4=;
 b=O1DvjvSryTll6gCgfjaynd+kd/oEX5BQdYe/zk1wMkdHO7T+dgHkX3ewBqJouht+p9FGTSRYuwcpKodQ0HcB1g+qt3s1YIXhbUoYQI35qySTpQLX5TyLtmlCPx6GcwZgzioOaqJdSVvThY+U/JNmpdPII8argc/DshQjOdPTN/4=
Received: from DB8P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::22)
 by AS8PR08MB8946.eurprd08.prod.outlook.com (2603:10a6:20b:5b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 10:42:11 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::2b) by DB8P191CA0012.outlook.office365.com
 (2603:10a6:10:130::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Wed,
 25 Jun 2025 10:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Wed, 25 Jun 2025 10:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJzSe3u77PqFvB9KFa6SXnAtBPta8KdUMrYk5sp75jc8+xQ1dc7i3hdHkoWyxb2sVYjRwwyI8IduWztS4kAvv2RY9Hr2O2Dh4faTbhIQilAVH2jSULGgZ1o3Zdk65RZ3ApClY1KuzR5acDSLPUve/DBROHi+LCmuhhEpBYOAoeCawMydIYcKvHNU4bDReWMoWOQmlivDH2KnKoecco+qvfd9N1dJZPzJkPOORI7nXHPIfsMTJfZleWofpkoOwAFxsZQI6HaG85bDJyz/k2AmhY/danQEkjE7ZzD6Vtpdud/7DCnxE5xlX62w8x++0ZAp4mlL5TemoYi9Ish0kBn7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRhHiRZhBoGmNlMLKTsjbkQfA5hlOD517y2RPoD7AT4=;
 b=gTkHKV/tYiCNymlXNm954UnIaO4T2XagObcvryI6T11AROmOb+TyJDng99ICxmYo5gb8t5SHFJrTngkRc1lyftVT5OOiFHml1dNSXQd3x9Jih5z6M3F/R91fr4MkVaOqsG2KQ7P1+tGE1GtoBF69mgKWBjGET87TTV1AMsWh7jtrSgEY5OpaQ7K/+7D+SwObBe560YmRHyYrJrtiwn8/Qu70PHd+zktkktzVAUDzjuqyhSLMPUKAHG6KLyBjYNE0zHV5tMJd6B1YMWrXO0ICeqkr83zUFlKWYzhFFa2Bepx1IIlpFgbzZE+grV+AnbNx/P0KswO6TkX7X+/tzTOyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRhHiRZhBoGmNlMLKTsjbkQfA5hlOD517y2RPoD7AT4=;
 b=O1DvjvSryTll6gCgfjaynd+kd/oEX5BQdYe/zk1wMkdHO7T+dgHkX3ewBqJouht+p9FGTSRYuwcpKodQ0HcB1g+qt3s1YIXhbUoYQI35qySTpQLX5TyLtmlCPx6GcwZgzioOaqJdSVvThY+U/JNmpdPII8argc/DshQjOdPTN/4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6650.eurprd08.prod.outlook.com (2603:10a6:10:26d::23)
 by AS4PR08MB8243.eurprd08.prod.outlook.com (2603:10a6:20b:51f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 10:41:37 +0000
Received: from DB9PR08MB6650.eurprd08.prod.outlook.com
 ([fe80::f628:7b8a:8001:a01d]) by DB9PR08MB6650.eurprd08.prod.outlook.com
 ([fe80::f628:7b8a:8001:a01d%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:41:37 +0000
Message-ID: <ad58db6e-7c1d-42c4-8039-0d7f0f057726@arm.com>
Date: Wed, 25 Jun 2025 11:41:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] The sun50i_iommu_of_xlate() function didn't properly
 handle the case where of_find_device_by_node() returns NULL. This could lead
 to a NULL pointer dereference when accessing platform_get_drvdata(iommu_pdev)
 if the device node couldn't be found.
To: Zhang Shurong <zhang_shurong@foxmail.com>, joro@8bytes.org
Cc: will@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <tencent_889D023A2A9B04DE8D592DFE961C5893C706@qq.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <tencent_889D023A2A9B04DE8D592DFE961C5893C706@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To DB9PR08MB6650.eurprd08.prod.outlook.com
 (2603:10a6:10:26d::23)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB6650:EE_|AS4PR08MB8243:EE_|DB1PEPF000509E4:EE_|AS8PR08MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 4009031e-7f05-4fda-d26f-08ddb3d4f0f6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Lzl1ZmxHY00veVlSNUxKVUU2QlEranZiaTZsOWZ6RURYUmlpY3c3OU9YdVI4?=
 =?utf-8?B?N09hMG8wbktIL2FsWnZMTkd0c0NrTHBOQjN5SVYrTHo0RmtHcktlNDh4bjV1?=
 =?utf-8?B?Uk5ZTVM2NjRpekQrQTlnWkllRHhBZU5uRUF2OHJJQnBPTEpaNVpkVTk5L25U?=
 =?utf-8?B?WW5pSlhNN1BPMVV5UFRDVVpLNFJQaWVUUU9YUStDdTVwSks0NzNvSjdBYm1F?=
 =?utf-8?B?UWxra0hoOXF1WnNtdnpvQVUxd2oyd2Q1STRwMG0rV0NPMThLN3crU3B1REpz?=
 =?utf-8?B?eDM2ZmVNTTB4aWcydUpsd1JCRERGd25mSlhtRmx5QUNNTmNHa1U2ZHZjd1l0?=
 =?utf-8?B?VnNyN3E3RnpOaTNSZlp5N1gvVlBuUldxREIwZll1NzNPVEsrWm9POG5la0ZK?=
 =?utf-8?B?K2Z0d2tBbURYWTVlcmZ5VzBOd09CQlFwWGVmQWdHc3VWaStLalVwUVkxNlRJ?=
 =?utf-8?B?b1UvTXpkcnUzcklZa29yeDRZVjJ5ZGQ5Qksxb2d5bk42MHdTNGFzb2Q1VlN4?=
 =?utf-8?B?aXBtcVBJb2lDUS8vNlJUbUp5QnlkbXVSQnFwcThrd2dXbWRNcDJ0NFNkaVZH?=
 =?utf-8?B?eldURGYraEdPT3M3Sk1sTE9hOGc5S0crbmVBMjNUQWl2QUV2SWdTK2EzKzE5?=
 =?utf-8?B?L1VvaDUyWW5nQVdOOHF4bUxod2VaMStNTDdVRzVFNHd6U1dJRi9qcE1zL1Bo?=
 =?utf-8?B?R1hhbjZBRGcrWCs0N3dRVWhwbFdNVUNXQitiY3NWRXBkTDA1Y0J5WC94QnFw?=
 =?utf-8?B?dC9nNGh1T0ovQ3A4Z2wweloxN0t3Y0l5cUZ1ZllQZFF0QVJRTHRYQ1NiMVNL?=
 =?utf-8?B?bmdRY3I1R0owMHhWNVZSRGlkVzZaY1F5Tm10dzhJRVNGc3ozSXE4SmRGSlBt?=
 =?utf-8?B?WHlpRVNQNjEzZHhKK25Gb3ZRSzhldmZjMk92VnVuZnE5aDJuTXYyT1lVTVNU?=
 =?utf-8?B?WlhpZGQrM3BTTTVSTUJUdWNHN1lVNkJOZFlzMmg4OFBsLytFZ0pnVnFMbzdx?=
 =?utf-8?B?N2FGM0lDK0VyV3RMWnV3R2RQS09jYWF1VUlGdzlRZXFoMmhKZWhWR1N3YUhl?=
 =?utf-8?B?ZHhvdGM4djN6UEdycmFtMmhzOEp3Z1JTV0V5bk8wWGUwVzdjZmYyWG9aNysy?=
 =?utf-8?B?Z2lFWHNPdGRGQjBudTFMdmFka2tXS0NQWlMyUm11c3k1YmgvSmJyUmRuNFlY?=
 =?utf-8?B?d3B5WTF5Sk85bDBYRUxIL0l3RE9uamJWdGdiRW4zMVVRL1pjMUp1WlRZY1hm?=
 =?utf-8?B?QndwZDVJQnY3bzFvN042YUcyaHM2d2dKWkV3dnl2Yks0TlpPbDlMYWpUZXZa?=
 =?utf-8?B?cENXamdnT0RHNkpqZkxldmdHTWp5bDVUVC9vWmwrSlcxSTkzV29vWG42WEFX?=
 =?utf-8?B?elFydTIwaGdaZnUyOHZUVnF4eGpxS01waGNieFVmSHNiRCs2a1l5aUZxaG5P?=
 =?utf-8?B?VW9LRXBkT0hrR09ZQVAzb3UyNm9kcWpRT3ZyeW5kaU1KY3Rjc083bENBZ2NH?=
 =?utf-8?B?b0kvNlhQa2ZnRmVjWTdkWXVpcHUxVHV2ZFhKTXJFOStGN1NIc211MVZNbDls?=
 =?utf-8?B?ZFBmMS9ja0Z6cVBrQUNkVmV4bExmRU5Na1RaTHZNdGRLbnR6V010alM2Vkoy?=
 =?utf-8?B?NjdWcjRsQnJ1NW5iem0zRUtURGpRajJLZ21adk41YkRoa1UzZjE4RFd1MEhI?=
 =?utf-8?B?ZUJNeEd3NUd2bGFCTm5nNnp5Z3BGMXN5bWkzckJreEZwbnFtaFVzWk9uQ2Zz?=
 =?utf-8?B?bndzNW9SV2tnNnE2TnBtQWxOZC9KVTB6ZmgreFJjWlF0UHpJaXpQdG9LdDhn?=
 =?utf-8?B?MW9Jd0FwcDdTVUxVdktWdlFoQlQ3V0RIRFBaOVFXaEMzeFF5LzZKUlNqN1Mw?=
 =?utf-8?B?d0NFVk8veUZLUjRXVjR3bVVXVUxxR2RoOGJqR1NLMWJMT3lDVVovRk1ab0Yw?=
 =?utf-8?Q?0ttJZRYpDm4=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6650.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8243
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1e0560a7-67d4-4c03-8772-08ddb3d4dc91
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|82310400026|7416014|35042699022|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGt3R1Qxcms5OEt5azkzV0VWTTR1VGxDN3d4bk8zV2d2a3loS0xzSjlhNGVB?=
 =?utf-8?B?NG9WMzEwNnlFWVBPWkFYTkxERmNXRk9IeENDR1RXR0k2QVg0TmpHM2Uvc21X?=
 =?utf-8?B?UkpucUo2b2RxVStxL2ZmOUpuVzlDemZIakFKeHZqRUFKMitySG5xNzBTdklV?=
 =?utf-8?B?RDh3ajB0YnQ2cDVLWWZUa2E5L1FLZm9vK29RdUo1REt3SjhTTFFqd0o2MjQv?=
 =?utf-8?B?YW9VbDYraWVHdXlyUnJ4SXAwLzlZeW9TUjRVRmpjSW9wdU1EVnVTUGlPSkxw?=
 =?utf-8?B?eEhadGtDTys2MGZQRlJjRkJlN3RSNGFzZlRVSXdlaFhhdUt3cGc4NjVINUJy?=
 =?utf-8?B?azFqbEVaWXhyZTZCdXRRUWVpa1RjQ01aZ3k4ZXRWdWYxYnZJdXgrWGdhNTlm?=
 =?utf-8?B?UGwvRlZyd0p6UjdhQ2pTeTR1TWJaNm1IM1Z1QXY5Unp6Tno5Sk0wMmxENDZn?=
 =?utf-8?B?alRLWGF6QTVKWkdWMHVDalJDaGRPUjU3YmN4RUlaVWZsalJSV0p3dzlwSGVz?=
 =?utf-8?B?YjI4M0hhalRNblFQNi9sQWZYWWh5dk5GbTF6d0Zia0xsc0t5MXZXNWc0cWZj?=
 =?utf-8?B?c3FKcVRLc3JxUVBoa1FvVkhLMGpueFFQWnpjL05uYlo0T0dZSDNjWVp0RnBM?=
 =?utf-8?B?OXNsMmswTmlScFZQWEwzRzg0YXdqM0pyY3ZROGJkdm9ZV3pEL2ZwdU5BUmFR?=
 =?utf-8?B?WGlTSkE4eVFqT3VLeVpXc2dpUnRNQUdud0R4Z1ZxajhweGcrOTlWa1dIR0N0?=
 =?utf-8?B?K0NBcXBQUDNScUtxOWpXdWQ2RG9KSHVLb21KZXJndTBiQzcwaG1hc3BwL25Q?=
 =?utf-8?B?OE4ya0xtSEVXVWs3VXBUN2IvSlNLRVpCMS94QWJpZ3VMOUQycEU1a1FmU0Mv?=
 =?utf-8?B?Y0VOeHRyc00wL1JmUGlac2FrWFd2ZEJhcHpMOHAwbFZldk5Sb2VQeWFzWFlm?=
 =?utf-8?B?cXdMN3pKeGthQjZTS0tod0RoK1FiVUkramhGVFdqZzVHYkRTZTVTZGlabW5F?=
 =?utf-8?B?ak9vMXViM1c5b3pVUFg5S2gxR0F5QmsrbjByR1d4aVlsRDJzWng0YjlXUWd0?=
 =?utf-8?B?Z3JyV0dJVWZkQlZjWHBXanNBRkhIazZ6QXNXS016WVpodmVTVnJQcXRiYllY?=
 =?utf-8?B?WXY3RTZIbVY2R3NhZEExZTAvNk5OQzNLMytLUjZaSTNtcHZMZUxnbm85MzVN?=
 =?utf-8?B?aElTZWR2TmltbkxGY09JVWlrcmZva2txUGFoYUZEaGJvWmxJUWlHWEZwNVJH?=
 =?utf-8?B?aWRqcjdZQ3V4eWZCMk5nZ1k3RHNvZk4wM2Z0WTE4V3JBNU5pbVk5M3kvYnIx?=
 =?utf-8?B?OThFMC8vcjlzYTE5TG9MWkd3TXpkSU5taXJuTXd1MjMzR0JUaDl5azA1cXZ3?=
 =?utf-8?B?VW1vQ2k4MFFjSjMwNnVEK1FXUEFQWXN3dVBvbDE5THFPVzlnRyt2S2NHY3BF?=
 =?utf-8?B?b2NqOHRRbktxaXkvRXNBalpzNnFtMGE0WFhWT1VGMGIzY0FqTVk4Sk1NcVcz?=
 =?utf-8?B?N1g1OUU4M3NPZ0RVQmc3YnBVcDduOWFDVHRGZHp1emIyYVA0MHRRTVF6aEN6?=
 =?utf-8?B?OWU4Z2lRZTI1RGdadFJZRG1aNGpzS2h5MlMySWgxYjBob25qU2d6aTlmZnlo?=
 =?utf-8?B?Ny81UmxBcWxuQlB6dFloQURyekJIbExoY0ppem85Z0w5ZE1QZDdZWmVQVHNT?=
 =?utf-8?B?WFZuOXZnbnJHSWtsbmNyZzRoVDZFMHBuQVZCY2VsWXVBUmVaaHNNWENTdXlR?=
 =?utf-8?B?THRObnlaL3pTd0FvMmdpM1pGZkJIeW1yMTVUWFBBN0ZqT2NDS3orbERTRnov?=
 =?utf-8?B?aktlWjhpOXZobzRTMXlRYXVCVjRLdTNIekg1bkxxUTJGb3o3TzlLNjBaTXRj?=
 =?utf-8?B?LzJqNkUxZCtTYnVqZE1EQ3VnVUdIK01ES0JHMElBYldiNDU2OTcvS1l0Q253?=
 =?utf-8?B?YjJhL3BidjNPNVBKM2tYVVdhcnBUTXMwRWJETEZCNzkxMmdlbXQyU3gwUW1S?=
 =?utf-8?B?ZmVtek9vQ0VpZ2VhbWhWb3dpRG5jSWVMRWVzeU92bU9VUDYzcU50cHJRdmZ0?=
 =?utf-8?Q?Wmk3Ry?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(82310400026)(7416014)(35042699022)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 10:42:11.2619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4009031e-7f05-4fda-d26f-08ddb3d4f0f6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8946

On 2025-06-24 9:35 am, Zhang Shurong wrote:
> Add a WARN_ON() check to detect this condition and return -ENODEV when it
> occurs. This ensures proper error handling and helps diagnose incorrect
> device tree configurations at runtime.

Please look at how this op is called in of_iommu_xlate(), then at how 
the ops are registered by sun50i_iommu_probe(), and then clarify how you 
think the driver could ever be bound to a device which does not exist.

Thanks,
Robin.

> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>   drivers/iommu/sun50i-iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 76c9620af4bb..0f85850269ae 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -833,6 +833,9 @@ static int sun50i_iommu_of_xlate(struct device *dev,
>   				 const struct of_phandle_args *args)
>   {
>   	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
> +	if (WARN_ON(!iommu_pdev))
> +		return -ENODEV;
> +
>   	unsigned id = args->args[0];
>   
>   	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));

