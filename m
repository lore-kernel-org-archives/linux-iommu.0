Received: from OS5P279CU001.outbound.protection.outlook.com (mail-norwayeastazon11022143.outbound.protection.outlook.com [40.107.158.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81169367F28
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.158.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745126; cv=fail; b=DdWvF6JoFe2rdaG36sy2fcJaOzYD8S5xevrMgqYrEavUBCQW4cWZLDzZsUzmpjtWjREfdqkF9HG9ALHzwTJucjErFXz8axhfmBmnTxmX24nkcSbx1zZQxBIhxk8gXr8VvwB4L+E5ZwddrhIqArBLVn4w/vq1sPWyOHWCbyf+vNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745126; c=relaxed/simple;
	bh=zInEvHnUWIEwn32eB86d4fgtXWihOxuZZU4JGrgddg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iz+Xrs7F2sBtSjYnzfzaijSKlq+8conkZarLyH13Lipk3SJb3akpJIvba5dIQQQG7OQdeYf0PYEMTbOM6Zg5lIf5Eb92v8pMOfrAeKiB9AybGESs9oWJ9O+7yw1PvjrwsheiL3w6ldGti2HNx8aAe9/g97v2Dfh2bBFanHYqDGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=E4TGQpJM; arc=fail smtp.client-ip=40.107.158.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="E4TGQpJM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM8FEro34AUtyOXMUdswHI4O/BJzx7jrE1IKLTF2p6mGbO02uhcvo3nNRZXIDxq6hjm5McGpZ1oc6Zl11emBiMZqQ+Iazkgv4KA6Bfhnzwnhvzn0tGUHNjnEwc5OvJ0f07KfRwRqPi132Wnl+cqh4M2a7vK5m0+hB9p42AamJQkYqf51pmgH6O3rOjNhLc0jcJIdKnhWtYP8h39rtd8/93tCRQSE2sd0sd+EpETKdDB41mE3n6blS8m2D4IRKCY6fgfaLbft0HB7t4oF/QKQBJqINgj3/wLhbDgqFYo7jxpLyoEFVEvNuauesD0KaNUmAWb0X78Phf+AvmVyWN7shg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zInEvHnUWIEwn32eB86d4fgtXWihOxuZZU4JGrgddg8=;
 b=UuIv/iySLWQz5Ter9T7PVaZB+EbFKvon7c1LwKvIK7lvW8f1bFeFLBwjlDtHVWQcsfXSj+DhQLTB+isaBQm4LGEbPCXVqp6Uh8AUZL2XzWLDftnt0++TPMt2tUvKv9jeGFAt+T8f+if+xpTiySnQ9T8CZUzWloLVdUV02uYjdWK1DzGX+p1+YUnJ11XSx2q0b7WDjSQGOY0BLvLAjXOYxYG+rDipMH3s5Yt4YE1dvrNV6YJJCee6x5OxA5V7zehMHdbrjCUkAvCfFjfQxP+w5eLIEUL8+WhGrPku11p6mu7VzLIjcLqGirYuIXFxJ8FYogNI1lhyC+uMNZZC27C4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zInEvHnUWIEwn32eB86d4fgtXWihOxuZZU4JGrgddg8=;
 b=E4TGQpJMaIticoHUWwxGj6jONJiduHgqwyIWwiYDmvLE8DebnugVHsOl4LrIdxx832JX54+vXR9q6JqkPDCgRJf/8PfIpz3ILH0n8TXuRkxflRcq2GBuBCjluHZYXpYaNGjGgyv1Dho/YOQHC9s7Ig3goXt7F90eTpjHPv6mpsMQUYtcCPYUc+XxKXuAbzT2I7TEYX9WWqvpSeaz0WgYoQZj6W55vUbZGNblfGAIJtoKfzNQaNn5zj7xJ4n+oT6nYztaPVYoa4Vouc2/AhfRESFkwuOHKzCjpeiyUxZ7nGzu16YB3WbQzlC8hsfU9Ofh7hrv9R2q/cecpy5t8CYVlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 SVZP279MB0816.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:26::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Tue, 17 Mar 2026 10:58:39 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9700.025; Tue, 17 Mar 2026
 10:58:39 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: dheerajkumar.srivastava@amd.com
Cc: dhsrivas@amd.com,
	iommu@lists.linux.dev,
	jonas@dolphinics.com,
	joro@8bytes.org,
	larsk@dolphinics.com,
	linux-kernel@vger.kernel.org,
	magnus@dolphinics.com,
	suravee.suthikulpanit@amd.com,
	torel@simula.no,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 0/3] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Tue, 17 Mar 2026 11:58:22 +0100
Message-ID: <20260317105822.420129-2-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5de2362c-61e2-4287-8735-8fcbc8a1ab09@amd.com>
References: <5de2362c-61e2-4287-8735-8fcbc8a1ab09@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0002.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:30::13) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|SVZP279MB0816:EE_
X-MS-Office365-Filtering-Correlation-Id: e19cafec-ba09-4731-be16-08de84142548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6VA5LcGf51dfgrkirAN41dpm5tu9YZSqaV8/6iFqWrQWyhG3eWRS89/vefEyCc8jZTo1BeY8RQrmFT7/IuZU36zgYXl8gcVv5R+ixA4opq9hr7Kubg/zAyrWisFmb7R763iJ4Au9yfREXs8Ecm9dWj7Buzo0V0qPDCUwjrrA1M3I/PLHSZ9j9aZ06YqoLEO4EmIV8+q605AA8dkW3W5IZSwXiGG4QjGZPR5XAxGG2WfUN2Gh/5/8X6tXxsWnJDJ6xvkydfJeZmqwCbOfg6NyA5wVy8+gCDNKJiCTr5Zt7JvVFxYgQryGWYcgJnNueZTnLmntEbBNDN9VQVVIgR0VX8yIUazF/TFBt9XGXnPp9ugTmKqIH3dXNFfhTht0FL5iRafvEjJLtGBYBC1xQUMlw7YDuooNR+NYHnOOSr2OaLBc4aLtSy2rgWYk+6ubgAesa2sGDUtjv0WH5byrqoCxYy95WkIRSJ6ZiH68O3GFK0kJDf5KgxGHQrdSHCX5Eg4YI/063wga+uiyGZZSDMFNMUv1X2UVAgGB0uyGpEjEDfheJw6ib2x3i0vegmRNa5a7eQgWVWPzzo4SrxC8hw814/s1OHGV/IYWZ22Y8d5YNv/Dfne0RB7CcoIscpPwp1zDJZxjjmdCdZpnxU+gEa0xP3KossyOX87egaFNX54YUmu/mxnxzdImyCXZD4gyrw9Xa1VvtHlXPURnnx8HxV2w1E4q1UDN/i/72Zljo3kzr+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5etbaH2n40lRdUczXrizOxGVtAaekWw08wilSdK0OgCu9FbFf5N9rBtkd08n?=
 =?us-ascii?Q?sf5BGL90sQWyU+U4Q6JWqLBzWK8womIXldSwrwSaGQxHqk1XAsqWywHumyLJ?=
 =?us-ascii?Q?OC91P8JMuFPn3xnVYKAoYHG6c45dgq3eRzBmgEgGCRNV0qPYzZoIsn9lUCq3?=
 =?us-ascii?Q?FlpV9ssPYKOWIo8JIwRdga+0elSOFSRJX7fgzlYXbjHmqQiKBWL0DuDBfkNq?=
 =?us-ascii?Q?z0L86/G0DOyqogTH7dcj/2ELDkMTQ0h3m3gYTPbGZiqRjX1vojvCPSCv7X8s?=
 =?us-ascii?Q?XloX3wbzT5xw2kz4CJyZEg34XGyZ2MSVFPn633LlYMQPONpHVbj1OjF4YXIy?=
 =?us-ascii?Q?UUYbqXU5d0MYZUc2ECXA8ieGsYxFPw9/xdwBYGOMDP5wv6QOFlg0JWIh8eEG?=
 =?us-ascii?Q?MDYnoTSGHfjfwBQJ6ABdNxc7PkJ++15967bM4fb+h7vWJEo+2BKwZcL2BFWy?=
 =?us-ascii?Q?YjHZGYH2uojbK56FtDmi/BWx+QDt57U+SZZ1ItesioM58aIDeuzJvWUOfMq+?=
 =?us-ascii?Q?vH3H6cG7X+P2ElUSySpgu2bq/BZq3NRyR8bzchXu0B3jLEBG0Zzo+Vjw9G15?=
 =?us-ascii?Q?7FqPZHzs60y5pvIHG8/p1kaqO9EE2bfy1y4BBZE8nam/tTf8w4Ta3nN3E4Ki?=
 =?us-ascii?Q?HPNvMpcWRH1g9HdfzGk1gBEEpQRmm6gG9A5EEcpU9k9L1xGZNdFL/8M0ggpQ?=
 =?us-ascii?Q?nZNFHNVxZV3Y1xTvrxCyM2NSGLE2djsnPAGn9V/0+uuPj4NG7gH6DiF5bWl9?=
 =?us-ascii?Q?mEwsSFv1upD7qFzz0GkX9PO3ztdVcjK6s+Anb4kQdygG7lHLPxWSGBr7zcBl?=
 =?us-ascii?Q?42KLWVHijmJFuhlPStxd0MYc+ZPE1fB6NOh/1RmnF3A+/Q8fVtPrXKrmpcV3?=
 =?us-ascii?Q?wdn4PKlBy873ZnADG9hzxndHxgekQLo/+FGa8/bMTfHg3GTppHBidjus4rA3?=
 =?us-ascii?Q?1jBnKBvKyxKODlrZryKWX4JRjVrkKQKeuErWN8zZ/j5D0uDp89k7UINZL+Q2?=
 =?us-ascii?Q?/WsCpvsKAUXTfSuuOxx3N/Y7FP1HHeL0brtniR9cw2UATud2VlDZjaLyDdN4?=
 =?us-ascii?Q?qb+QPcEzSJStl3HPgNGIm4CFQ3iabB0MRVEddTu7LLldJtyLdtqWNw3j/drN?=
 =?us-ascii?Q?Mcqi34I6ZV++ySZAt9R4lQT0Ys+BSQiciaSzwig8bDMUGLqGr0kB1b5eay8E?=
 =?us-ascii?Q?Fa1aolXFI6Pt7y2+Nr66pDSmRYlpbPMRl/LjNImbgXITWOlgBzR4Wybncnk/?=
 =?us-ascii?Q?xlYfA9GOolUfzknIl07ojadlGSqpDk1K9Py+OXeiNTUEjLtwHxrDJ2b5HTxV?=
 =?us-ascii?Q?gOztDPDaGyb6q8FH/uwK4PreCn7tFGFrpIXNNocYkv8nccIHictEFPaaP0qx?=
 =?us-ascii?Q?sWhQ09TR8L61hjWuqxeOWXrrDeAxNwIVEQAboN/9NaK7s+F1tlGg1xtVXoU8?=
 =?us-ascii?Q?3xM+PyldANDWkoRhyrCFdpfCYzla0e5FsZCw/zFHri2jf4B3cDiVEEZs7FUq?=
 =?us-ascii?Q?eq2lnIhZ9piO/SB6Po6pWC+mTX5/4twHdYowDqrxRiQXZ7cNETPcP8K1wZ2z?=
 =?us-ascii?Q?e0KdKJApddrCdj2hj0qn7IwLUTgKtzrIL069FMICdEP4H3J5tjPnakQOItw8?=
 =?us-ascii?Q?H3kgecea+pKLR80FvW0dDbGm/GfJtYLuv3RYkrD2/Yl/bewU/MVaHLJsx6Ld?=
 =?us-ascii?Q?cjIEdhxZ0xEvkqyQDeu00VBcYgyZkj5QUu6btoAmkxyChG5QFesaCND5UTDI?=
 =?us-ascii?Q?MNaGOvXGvw=3D=3D?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19cafec-ba09-4731-be16-08de84142548
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:58:39.3970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74XZYYAKpBUJAvI4JPJWgYC1LEpOqDIraybrXjfo5Di93PwsJqVu4kCsbszORP8PsAeSQ8AfP+EZE9N3gzucFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SVZP279MB0816

> I tested the patch with lockdep (CONFIG_PROVE_LOCKING=y) enabled and
> observed the following lockdep warnings in the kernel logs.

Thanks Dheeraj for the testing.

I believe we can make the dte_lock also a raw spinlock. What do you think?

I'll send a v4 addressing this lockdep issue and also with a fix for a
potential future lock-order inversion in iommu_flush_irt_and_complete.

Magnus
