Received: from OLAP279CU001.outbound.protection.outlook.com (mail-norwayeastazon11021096.outbound.protection.outlook.com [40.107.157.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A13DD52B
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.157.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043514; cv=fail; b=koKko5EtbNTxIpnVGbLZ8hfS9AT7+jmtFlQVSxzFX4gRToO9HygEE1KGi6KhFtE/WnqpOt2aPvBsz6Tv4B4g827JqgYSirYIKE1SEhBbemWq3V8FlGdEWWZaDq15CAXpwv2/aQNCZfkW6XvNZlHPZ49XbaGAXlOATJk0vGvWlSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043514; c=relaxed/simple;
	bh=QP2wmnMy6MOrwJZ0H8ZFt21Z+cn7T47pBCyKVtGNvVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYPP3oNoj5ftgESSIdPU4QqDs1Hz5xRebhceyxSod5FudsPFCY4Wpen8CXffiIwgGgTPaUd+wtaSx6TJTTtaZzqjdgUBTUjchQEihBxYrFOx4n2WkDx46XgL/tx4XKIa23VY6ZarrsZe7IbGCJvdj0e4WR4SXuWnFSYyyohxUec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=F8Kemsm4; arc=fail smtp.client-ip=40.107.157.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="F8Kemsm4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1+3YkG5CMnBbtpPPNy1fPUPSrqYtFwrMeMDCYJImdSlK9J4c0SsIppCgaqwBS3zWkqpwsQBUYFDQ0h6FEDTj7P4Kx+X4X6KYo8vOkutvPwPTthURG3AKkArpiQ4ZAa/GABjKIG7a8SOwLU3HlbYgwHbW9mYgqOo7HSAi192V0QY7bORC+p+2g+qOUfY9oEHPBWe2u6MktS1jgkvpdxyeFKoOdux9p4Cm5M/wRt2fFSpiCcJ/h3uddfkWOXtmo8/zEXAcioLGA+ZpwQqNZ+uNh7hALoZadpmCYenYEKuubC6co2nj6tjFn9HHN4Cd/k5yY9aHePXjXUbY8u3Yl0UWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP2wmnMy6MOrwJZ0H8ZFt21Z+cn7T47pBCyKVtGNvVE=;
 b=CmF7wyfFAw68/8zX8uWSH0ZwB80VhLzpeZ9gTZPkAIbaEh7YemKI4a5CBoAj35YYTuj6PHOJrj/1GBkGGvN+TXiCvhlMuKydZtHwxK2wfbAFaYZgf5Nf7HltVb0OaZ3wnqQv3v+G4Z+Ry6S4fnUjY4pv5X05nPVqNEHpI9ohciVn2CtURIB5BTJyLpwz9YdgHtOxbg5ZpbMnmBC8dLMkXvQ883JB6Zm7xBzy7xmtSdvvx5+pxwVekO7FFS51SCiU2kajLKu4FP6gbSc2qlvdjOBVDCEVo8QCgtoURb1QoDD6N38B3kUxbZECI+DiC7AA28ivc1nEhIEWEGkyVuZQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP2wmnMy6MOrwJZ0H8ZFt21Z+cn7T47pBCyKVtGNvVE=;
 b=F8Kemsm4bUkqImf/LiHmtgAaMaZqIpZmD7mIEfismmHt5YNgHq99M0IaF2KaLBoMtU3zw83jiZEJ1oIUaFJpRZf0+MBnUWnPDSlg8eNNUFhFXYJBekbD4eaNBuaFrLcZsUOuVs6Qdde21OHekvHgdABO1eWWRTi4MlVLmw5mGggKeJKhcr1KJgdLZ83Pt6e1H0P6L/wP1ZhJEIs7WLl9VCAjo180NkwOQo/q6uJ+WF81pWZV/PVOHSckva1oDjLqLQd79fqEsOyxpcB7SdogO2c6bWElnP4Sdq0Qo6MwK+L7SHSfd3DewqT4UPa7opNZZyU3dVPdllLnKr3xmiKsdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS5P279MB0959.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:56::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 11:38:28 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 11:38:28 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com
Cc: DheerajKumar.Srivastava@amd.com,
	dhsrivas@amd.com,
	iommu@lists.linux.dev,
	jonas@dolphinics.com,
	joro@8bytes.org,
	larsk@dolphinics.com,
	linux-kernel@vger.kernel.org,
	magnus@dolphinics.com,
	suravee.suthikulpanit@amd.com,
	torel@simula.no
Subject: Re: [PATCH v3 3/3] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Wed,  1 Apr 2026 13:38:10 +0200
Message-ID: <20260401113820.79881-1-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ea4cfd4d-9ad2-4451-a896-9f0435e72a06@amd.com>
References: <ea4cfd4d-9ad2-4451-a896-9f0435e72a06@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000239A0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::18e) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS5P279MB0959:EE_
X-MS-Office365-Filtering-Correlation-Id: e58d874e-e121-4fb3-ad4e-08de8fe3317d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P6g3pFgzKcGY9ciN8B9X+6h8MOI9PqJv9UfHNq7/21yUmbXRgydidEEUJ7KM3b3I5TmKsl4mKekTSLFCCjCoFaMXA4Hz1EauTdCnpyZeKpcUT+KuiuGEjrHpEGqiB+/MclL4b7ZShbv6mchSrzhytouvvusKMcV0/OM9tTy+TTDdSBuCu1/V5MAXmFPN29Tnx4dZ5xHaLubwieFMZFtNeaxZCyUrrJ4Trz2xiZP0/VlN0guDnDSbFjTnk0Mqk+msiaj1FtFNm66i0L7iIFyOnbpOq/HYBMJZVvP0SzxJ6ks1Z+MoyGtQfyV2XEaXFrh+YTHoi+342s5fXEvUEvOuVMKUUcdoWtk4JSYVsM+l1M7B+LlhUUtc7iNUKoBmR4j0t7d0lum8NsPHZaXdoA3WgcvpJsM5iDOUqHXDqy5AvKv4kWu4ie4rv/fhdFHkZtE8SKy7iuIV0x6GPgh+G27cFf0dQlTFBhmimRxtOuZOPftaxTl0kKIo75ZeTb5vivQtiWUSFh0cXjyPQ1jW+WRwA3HTKf07F7Qp92J3Hl+RECvi8zLE88uHQ9tr3JV7UCWO+GCdanN47V0K3rEvFLJTkQwZcoct/rduRZ6I0zvzr2jp6I8TyW8b/Lv53yfniwjcGcNXsVOlwRx6NR84KSjVhNBnbp5A+BYn6aVu3fUfnTPrEGlbT902t7/704Nt+toug+H9U4zuNWQorkvcur8MJp1h2eyJ4jymwizvjLcRM1M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MlBPoyBsB8H90sa7Vp1vCl/3yYkoK54DVr85smO0HJp9YPmCBDxHNtPGir/a?=
 =?us-ascii?Q?OcYwUs+cPocPEWFMr5rzOZPf9RT/doz5jG3MFxoQqgDlLcdKigW/y/faf+TR?=
 =?us-ascii?Q?pg9gRZCoDjLnU2TO4ZsvNUE6HDpjhYLvkAxheFlx7XJF3oLnRMxs9MJGi3Yh?=
 =?us-ascii?Q?hsY0pn6hr0ct5nbMYQQmCuwls8B1RFlbo1fS+Z3RJgfjm0giVf0AKRUczblq?=
 =?us-ascii?Q?jYO8Tazo9IwAxRnveFfeGyxm4vtssquLKzeroHt6A0t7N9HVxzciE/LuiJT/?=
 =?us-ascii?Q?HUHv0mJZZfHimzgNdBjdjtP9QNYufFqf0d3WTkcOkuZvHpEkjYd6tx8+qiMR?=
 =?us-ascii?Q?T3yYq50X6feFsAqmzTzu8mGJEOhnJa4OKineqT61R2YkwlRkiM2KUiz8zttn?=
 =?us-ascii?Q?0q+Jj51JkbPRgg2X/Yyz1cYh1SvMmavScfrok0XAJibsRTLCwL9Mdst1miK/?=
 =?us-ascii?Q?RA2d4WjsPhPYqq9ZANzFp8NpyjgR8SVgJlpcItZ6U3KXTcFrSSkms+I+rvle?=
 =?us-ascii?Q?flo3ZO0mkxaQ9HRIMqhOpCX9Wu/blck/MDyF2NjgFZBNr38gGigaMaRu3qjA?=
 =?us-ascii?Q?gFADqgJvXmAANBfwfa0ScVvmMtn6ICzX3T0tXYjwY/wcQU7vTciG4C/MjcQw?=
 =?us-ascii?Q?MfZLTy3MMAspI2JU6gfxeV5Nok9e+ytv8Uxt/g6yH9SvznmOtbJ3wi5K4H/v?=
 =?us-ascii?Q?uWnx7aYAuVELR/QGXISVawfUGm6VcOOxmnvEUv0adKX4X6UCxGQsfsQ4US+E?=
 =?us-ascii?Q?19EPxE7wQLdNHYXHyjAe8+9gK0OChIK+7LTXzGZGkfDhBHOTCGb223Y/CX1w?=
 =?us-ascii?Q?XFnzm1Btv/ZlEkt2rU+xz0smhg08XdM/4fWoroWFpJHD9+a8V9aewtNwWyG9?=
 =?us-ascii?Q?l+78HyxryT4a81nr+8QLbR/GwyCj/PYLpkuSXqVn7j1L8/JBeEpGCEvrTjqH?=
 =?us-ascii?Q?NF+//6NG/4IA9blOkuTdT+3INH2HX9Mzbz9MvfJqSCkZE65D8pOePtAXufwm?=
 =?us-ascii?Q?D6LQtZfNefoVLUwvNvBFJ8DJ67GH0sPr7zwM2DXHstnxLFPpOyLxmBMKjc/4?=
 =?us-ascii?Q?oMqdw0O6mUhN+Awj4oqzeo5YSThilA5oN8U4AtsFom8JIl474HwpHA5bH7pK?=
 =?us-ascii?Q?aRAXb1BGzbDMkjPIgqS9C+si9UpL/2X+TKUjRq7Wreo36WkO3EhsiuL611OE?=
 =?us-ascii?Q?OiWwXGhBPrRH2l/5zBqjlVUvhgiW1PK2voRggS/FzyFiQ79dqtMt3y3g0Dht?=
 =?us-ascii?Q?o3b5W5NgfafLY31DTlxmbEgxLWwkJonQs/HQYF2Xuxu5dZbMe+k56a3Dovkz?=
 =?us-ascii?Q?7gPs+Yy027MP6MRtiYKT0ga8PQJnum3AcbB5yJ6a7D+7x95rPry1troX6A59?=
 =?us-ascii?Q?UKsNMrlYrJcAB7+f8lqNP5ro40n9gCkU+IbZT7ogL4N5Wrt3vAs2u86rTjr/?=
 =?us-ascii?Q?lFhBeSphLNTEvd1JTby4DlpcTXZOOW5wnAPzeGGJfuiOhQPTyy9+e71prZEE?=
 =?us-ascii?Q?QQHfSYAPsi/tTuNwglLIv6giq47sjBrdH9yelbgVOomieY4na9Ped+LvqZ8d?=
 =?us-ascii?Q?a+ftBxEnkzGPkXMmzJgeAq/KlhmhkaWhGmbERkWRu2PvZzsPgQG41Uq3EIVh?=
 =?us-ascii?Q?wTuuPKVP1W+C0CMxIk3iWQziiQefApe+hOBl+55qElpQM1TSlm7uBlIgdusI?=
 =?us-ascii?Q?nfvNgtdVhHASrNpV6x0Jfaa8BxzRT4vt9DgsC5betYqfGSRash9FQSP35X3a?=
 =?us-ascii?Q?FjoUryv806itQdqLrqYtzYhn9Z8KWpXb61ycrEFfWB7tXt5T21zm/Bukho5R?=
X-MS-Exchange-AntiSpam-MessageData-1: zMG0p83AgieYcg==
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58d874e-e121-4fb3-ad4e-08de8fe3317d
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:38:28.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjo0CPaMj5AQcM2O1//VhoSbWSuxpbQoWFi9oY8JuePcdMwly0YAil1lfrod59bNL2YIcKvOzD2lwfRe8bCeMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS5P279MB0959

Hi Vasant,

> Nice! Please send v4.

> Also I have sent one more fix. Can you please test that patch in your setup?

> https://lore.kernel.org/linux-iommu/20260401080017.117549-1-vasant.hegde@amd.com/

> -Vasant

Tested with the clone_alias fix.

v4 sent:
https://lore.kernel.org/linux-iommu/20260401112021.76806-1-magnus@dolphinics.com/

Magnus
