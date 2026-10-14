Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57B2D738F
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994615; cv=fail; b=WDGpLPx/69mY83SFNfdURMvrtDCss8mQtbQ0RJsSBDY0EjL8xZeKhracksqmZD/Npq6bi65YNZl+h7Ou3x4U0XSGrzo2VbxxxxOxH89koDic5SEXFFTR+1sL3BmHRnvF3bVja8YQbaTvAgGbRoUKQeOxliObF96BAlVXuHvOQs4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994615; c=relaxed/simple;
	bh=5wbt4hzrQzWyugHWW96rTIQiSnaxQzMH94OA54Xbac8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RijQWDAwA6EcGh//RE+KZeRzOC+Q94v0dzdj+OzMnF4zGEwlhtssMK/+gvMG4P1ilhmstSl4Y+Bzui8g9/HKPKlw9IB/VC2RWh33euy/o9H3wqzixJPzHd12gEwY7dQrmIpVdOPJreBEnlZ6HJxAHyKjfQJqAUF9FXzOFkRDCoE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FqP9bNDO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FqP9bNDO; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FqP9bNDO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FqP9bNDO"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IMxDLKk2tbP+DrfKostEjweIPEsQLXg3nra6uMv9HcxhLDvddfKgLelhaSXBm7thhTtH3Lx48VOsCayjs/Eyh7iPPLs0nYQem36JeYgZ3zEm2P/r3rW4Od/mTpcGiDO4vzLDff4f7Zqk1C1gOVWQMk6qeeR8CKJtwzFgcmjIoTC/swClP+BbhVhK+e4q92hC4czdox773kitYzYhaNPnCX20YDwHT0hVKZoh+ts/mVAq1LZ4R1YlO1XkqCxDcUIZutL643ATD2abkqgRZVNh5sZbQJD3y8+5wvRxPVA7JeJ+ZeEsHpMKpXFXv50q8t4WPZoE5+G72Uu0e/aehzMYcA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXpof7pnQphkIZzCps970+n9zznG2XF6tbptkJsiRO8=;
 b=c4o6948nbHXcfwkkUK5z4tHbnqsI1bNXVEgRGDEmTFbVRE/vTuW3ZlmXFjN81zA8k3130xpz/ftRFxUa57QzG96n4Rsbjwcp3vf3TbptZlj8RoN1r81POXGjyK/Ha9fZuA+jaObYzaIQ+RfrwRn62osJU9S93VGytWnTZVtNaHohuXFjpHkEQeL1LAnHd0quUqE21JjWfj6GogPZy1+1Mj8pawIQ3itzFDpvHdHLhgcetr2XwPg/XIXV8lCHkY2x0OLgZrhlI9jmbVm/96MQqWX0xODbw4++GDVhwYWfF6oMmUf3uRBwX3H9y3ApThI9Er6vpKEJ7ffprl3Cmy2z/g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=qti.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXpof7pnQphkIZzCps970+n9zznG2XF6tbptkJsiRO8=;
 b=FqP9bNDOubvgW0t5nhIijrVohI2LAyE7+DzGJxiCQ0rHHgVOukn4qhOKRCXZeLcmgvQpbQR3otZAAchx6DR/H6/djXwV4XvYFcHXImbiToK+IdMYt37ClFrMEv50/7Fn/iZnhWYHMyBeAnyoOldLbGGsgzL2jMV0yZf5ZOQQVb0=
Received: from AS4P189CA0010.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::14)
 by GV2PR08MB11561.eurprd08.prod.outlook.com (2603:10a6:150:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 16:16:47 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::46) by AS4P189CA0010.outlook.office365.com
 (2603:10a6:20b:5d7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 16:16:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6 via
 Frontend Transport; Wed, 14 Oct 2026 16:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF3kTOWPH8t/IHeZYlQLmYW6G/K9OBDc/IUM/DXyvvveYSGo9nr1mx4WbUZLXlrFnjiSxQXL6XIF9PbnOokGVLJMfzd8p7gAEnIuHSvOIpo5qaiW8cpZ3I1HmmA9z5HG5z6d8TMp0hbR9GLte8E59aXYhmH6fD0hTKCgEKCxAPnh1jKcV6R1ec9xGJIMwUozo94XfSN7Y4yixPDpQ0anYA5E4fGBsFcnBSs4ocG6LB2sZGSYs3AQcSSWz/PzgjWV8mT8+/AQQYN5sKP1ha72hplD8f5r3LnCV38HVF9qeXsG4vrDwT8qBc8Sk8D/J+DlkrvcxqjUtWIL6mKzUYvsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXpof7pnQphkIZzCps970+n9zznG2XF6tbptkJsiRO8=;
 b=Jmlrh2m0dZLyl4GeCQGKzggq3MCZrAFvI71g63rC6fp68Hbdhlsbgh8+q6FATyOqRyubF8WkoCcXLftnugTVVBg8oIf72ZdLrbTqF6izMpEQH/KyGtzFO2DD9iGdopMCl3p9P9oMDoHu0azxaBqmNn520PK3jFvX80Vu8pSxMK+FSsDftzAkRA7RkikL7S37LZ4BJH1LARgeXPPMGV8MvMxsXbC2hDNy28nbsLVB7m8z9lC0pJJ2LgrfXDqTOBiZPuT5sjjR8M2EnWRmpSF+HqRn42zkn+SMyWejAGqxCoR/LEA5UK9FvW0/qDn2eUT1YT5M5p3W01krDNMPKmVzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXpof7pnQphkIZzCps970+n9zznG2XF6tbptkJsiRO8=;
 b=FqP9bNDOubvgW0t5nhIijrVohI2LAyE7+DzGJxiCQ0rHHgVOukn4qhOKRCXZeLcmgvQpbQR3otZAAchx6DR/H6/djXwV4XvYFcHXImbiToK+IdMYt37ClFrMEv50/7Fn/iZnhWYHMyBeAnyoOldLbGGsgzL2jMV0yZf5ZOQQVb0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10683.eurprd08.prod.outlook.com (2603:10a6:800:208::8)
 by GVXPR08MB11227.eurprd08.prod.outlook.com (2603:10a6:150:289::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 16:16:13 +0000
Received: from VI0PR08MB10683.eurprd08.prod.outlook.com
 ([fe80::7fcd:1ea6:477b:e5b9]) by VI0PR08MB10683.eurprd08.prod.outlook.com
 ([fe80::7fcd:1ea6:477b:e5b9%4]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 16:16:12 +0000
Message-ID: <30683c6f-08d5-47a9-ba0d-24622c3a54bc@arm.com>
Date: Wed, 14 Oct 2026 17:16:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Support for ARM ECMDQs
To: Sukadev Bhattiprolu <sukadev@qti.qualcomm.com>, will@kernel.org,
 robin.murphy@arm.com
Cc: thunder.leizhen@huawei.com, tanmay@marvell.com,
 linux-arm-kernel@lists.infradead.org, pdaly@qti.qualcomm.com,
 iommu@lists.linux.dev
References: <as+Mh1Ah3FFpCZlK@hu-sukadev-lv.qualcomm.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <as+Mh1Ah3FFpCZlK@hu-sukadev-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0064.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::16) To VI0PR08MB10683.eurprd08.prod.outlook.com
 (2603:10a6:800:208::8)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10683:EE_|GVXPR08MB11227:EE_|DU6PEPF0000A7DE:EE_|GV2PR08MB11561:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad8c8cd-613f-45d5-3b79-08df2a0e8b85
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 /ZgNESrGHLxhGuuFyKXThzHzQHjKdYIHPoWExvXxFvkJvHbF47jJBu9WOZVdVmMmLgU7vMebH+9BMshyDUN91RE1GeychOCI0H3xlQObL2T3mCSBrBEndkQwEInd2sumGdoZbd7JnwN0X5y3hDOgqxkjW6M/QiBe5YkPwsvMEiVbDSpjMZyMbrNpuCTm0Q7AOqHJg+O/cQ3RZAIhzY1Qplaxt3XYYbbyYjle7ogDriEg9Df7sX8d+IW0VUnI+DkDCABbBRmRvskyH5haH1StIj+glTelyeBmRxXW2915iabnsipNI49YeYqT88nwL3hmwf4mHzWWFaPDqONJNumj2938LXfRDFXeeAlJGuxt3kNFKGKK1lpoEGV2uV5MfPK3OXhYatQnYNMQfSSoUHruqV/FbI27uxC+taF1h2q9R2Z6709/cXKM/eXtaTUZSyUbLd8XRQcStaft4Ps7JNpX1zLXICSUFimzBoEds1v4RzjM0aMwG3xUvHlJ8/3VMjvEMpvLbC1zLc/pxegS7T1Ecyq0SxVIiYmO7x7SoqSyB6d/rR95q21T5f3ZHXujaja7dSYjYUprm6O9W3j2q+ZbFrdI1RhZgCQpihnc771VbgasUKHtLqMJkjCOPgE9Yz3bR38IEDMrxRUc3xdqtk+aONcxzORY3K4FprLhIJ3Rgf0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10683.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 XR7YziS1LVDLwaq3SMuF+mVL+HIVcKw7XswYtushpaiZ2rwLdMCROvotJXLSBCrh46x6Pop+v1cO72Vl6/le52mJJh0/8jnsWbTd7vsHrTuDdtkkdCYm3GmxB2ZeAvr0UOvyc2FD9QPwbzh4udxVcgKe4D9TmHWnGRtnKe9n07LJqhv54tL1rkuS5o/xjFoD1ga/2ImM1r0rmnZ36VsE+K5Zb/1JSmsXtIwYv6ha9Ueg7aN2iLI4HIYovAMKW2cajOuZLHUdCrKlJ3JAZczYkXQOg0+jqWYhTIbON1fJKE+eU4EaJ4Ligu4KJqldDQIAKO2DxMIsKcguoz5XJniu5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11227
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	de5f2bdb-ea36-4fee-10ee-08df2a0e76a3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|35042699022|14060799003|36860700016|23010399003|10067099003|56012099006|22082099003|18002099003|11063799006|13003099007|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	O4dzhz5pdsIp76tfOVn5l6yGbZnpGYBxm4xNTJ8Qr80fm4PaoKQnaJU3D/lvlQzvH2uuPlDoffeJNKn6IBzVvvZcN0LA1PuQ6wH+wcmvv1xU3u8D2nyZdFN0XmxCEHNVid5b2aAmXas11HYaLJyjijp0ap/YXgukqpwSn/n18ywzB05jKnJxTbMedaDVrcPbX3xp/Jvp+MQlxcqBPkBItnPfPUNt/tdHfYAQZQOvgwx43ZRR5jGdfehUPABJv2XeFEkJcHlM17rkYwBjJ+OOS8wwztGts8xdV1BXgrthZk8BK/Wbt3PG2iFFn8E7XVLnJ139mPnyxrDHXFH4bMBHsyrsa4iODHId983SkqRBXus1uJ3di7RmGioBKOzo4eBHH7xI1hT0r30Mh6uSbkIjEvatDOl8SKfsCo3n1upxiQEAM3RveQ2wSISJUSqLSniZKG0KsI5WC5xrJvnEdXVa3CkdRz1VkascQ60XHjyIN/VeqqmtAlGwgsVoFPZdRgMvAZAnj78yfrYjRSk6G7pJALcDjLuHuPgDQJeB6CbDhpuSjhj29tGVCAf7DNLrYPRCuyHqrZRqYGeNzyJva53QwidnASJ4ZXr0f8Gv0LYI06w7Ep6IyVWP9jND0hJv6WTOAWSFNIJAdFQ6UuK47dfF3lRpom7gkyxO3VBDzSY7Y9QMBWaQP46USEma+qLCPsMtIVauavXS2DhD8vOGYXwc6g==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(35042699022)(14060799003)(36860700016)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(13003099007)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tLNMh+7HQ9cBLTEMeVAm6hIOQsNnZRL53W86LwO7J+rDMCG+bTP8JnlJqvfv/cujg8l6uYKXzAF10cxqxZtBtyc6zw276jeVkYYnksRw3Rjrr/k2937SdjyOEtr7XiEZG5OqWP0FWe5MUgfqUqOYptz8ZUNZTWdm9t3Jlm3LJE75YUNhQKGVrF3IT48feENp5AyghR8fhYk2hq/81obsKwl3+6KbzDoO1iuvOFN1o2Znbxc6upXDUiCuUkzFYcAm87crx3RBRTk1v9PcvwLvBaS3IcJ9yN5Wlg1iXct42IL3fzH4NSieUkuAiqXj88016uaKIDplkzkqNjnl8Q6wXBS4bLmmaXHWmzf1+X/d3szU4a3467A9Bjq2roXd6DvxD7UGNRm27OYronLCAYrsU07iUW7JYXWlxhGUs0Nbl97gd9BrbGkPnNEXa2/caFCn
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:16:46.7554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad8c8cd-613f-45d5-3b79-08df2a0e8b85
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11561

On 10/14/26 15:07, Sukadev Bhattiprolu wrote:
> Hi,
> 
> We are trying to understand the direction or ongoing efforts to support enhanced
> command queues (ECMDQs) in Linux.
> 
> Earlier version of patches [1] seem to have stalled due to lack of real-world
> workload data.
> 
> Also, any recommendations on policies to distribute available eCMDQs - one per
> CPU as in [1] or, round-robin when # of eCMDQs are less than # of CPUs or others?
> 

I'd expect a static spread over all CPUs to improve caching of the cmdq 
memory structures.

> Thanks,
> Sukadev
> 
> [1] https://lkml.indiana.edu/hypermail/linux/kernel/2404.3/07988.html

As you can see in that thread, the maintainers wanted to see results 
from real-world workloads (which never appeared).

And I think that the preemption disabling scheme in that series can be 
improved (dropped).
