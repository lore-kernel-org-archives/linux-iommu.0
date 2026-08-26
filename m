Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73044C646
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761967; cv=fail; b=nBPbv9DlgHd+uz8Tjc7Vmbb+sx6R9JIa7ltJtzLmYdmdTPNY8rrt1ZCG8H9uPcfJWaYkKUukPHQFQBSI9ryZN6k8m1procnOWRUmd9F65Msun7jO41dYfSOfd4Ag6eMYAr8EMkEUGHRRSXTxCIdWNzb8D1rUXRwjve35+fy8s/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761967; c=relaxed/simple;
	bh=Q92kkrfCDBg+yUK3ar/4Q14YOu1rmNrZWmVKqODgM+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H9TFRsdkeipqhA2s5aG7A70J7P1qOIST3RYk55F0DSUaeFueM9rDBRFah6g1zFuohcAkzL2ylc4eszExCYzguXVKV+6Awa1fRmksbsAPHI/1zvSM+zAB0sGpRmVWHMuIRlIvfgCUoPfWfC8t2CN/LGmedTtmOEDKt+yyliVHaQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CsY5i2Tf; arc=fail smtp.client-ip=52.101.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CsY5i2Tf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSNT1aS4bbUlTN7iTbNfW2JqUnEA5KinjcMF8BRY5JJzUbV0Io1+3QH0rMrfOIXAlxFt6I0LWjBWcWbDbGKvVTVHXN6nhPobCMGdemQYVsZ0/KFXHqzX6816j71HPbSPJ0OMB44Uer0lxuClgR52E03gPrEsz0sdejoUZyAxa9oVtIT43EWeCOrWbl27ORgFZfzccmq0drujv6CwNTGc3ZnPhRRisWMDkNJr71ON96GjNQF8Op7Ohxf+N/wnnAsa37jd/2TUmAtms2U5NwVPDbquQ9R5Bgi9pIejlmHfee7kCaFMKG9RPDNV39qs0jVX3Z4tFyoU6ofITsZ2bB3LxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q92kkrfCDBg+yUK3ar/4Q14YOu1rmNrZWmVKqODgM+c=;
 b=ADGHOtGIsO7N4VZjb+yfxw1OTe88S3ZSbJDgiTao2pswghifCUzTn2YOfnaw8hq4m4IB3USnoZe0hQF0gNED3Kc6fzljIEc/WGdcSQW/h9E1kCWIZvwP6qRSJzMqCWGsJej684AlvxAla4BKtSL7cyfVGdW4cMmovbbGHxgZb2hoZLKHP5MggR/XhR1ZapMaVjhHR53nkg8q6lcm4LUNnHp24Crv8ifvuYkg79bRfsaKPOdw8o9dOnbyP0Vb8EDCYyHWoRunFMs7GkUEDUX68T6KbUZdipn5CwKKecESHV8EfWJio0wE9aCm4mzIKjrVRWA6Nrisj7JscNr3cG9CSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q92kkrfCDBg+yUK3ar/4Q14YOu1rmNrZWmVKqODgM+c=;
 b=CsY5i2TfLPgvy42h8kwxER0YITYnanX8GB23m5sAVWTQFaUQl2TiytSB19sqaBth2W/fL6Z8aBl64uBbtmwk1B90nracsT5gVw8ue5DcrS8UxsheGr2I0mCFsA6kSJ6E0TRWc5bKESS9+TSSPaB9raBWvcD4g1RXOHrRmT9eb04eQPrg+TQqq8KPHMj5CaGtM797opKG8KGFsBmfgXx5nDv9cJsvEUFXqWtryujJ1XLpARMtcbuf8h9ydSyC6LeuA0KXtG5w2XT2bh9J5wEtKVQQePJ31zwmAFX/wJBYShu/gD1MbNgQEaxy9xfotZeeX7kpXlPo1/RN/uRrGJTMDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 16:32:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 16:32:35 +0000
Date: Wed, 26 Aug 2026 13:32:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260826163234.GN3325090@nvidia.com>
References: <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
 <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
 <20260825165209.GB3325090@nvidia.com>
 <iltwtfmgnmofsroo7eqrvjx6yhqbptwutywq65mgm7adudz7pq@2mdg3dhvtoud>
 <20260825175901.GE3325090@nvidia.com>
 <pzutriwhwe4whonj3veoo4hzxmq5tlmmyui5u6gt4bgl5wxxrg@qjsq2pvd7by3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pzutriwhwe4whonj3veoo4hzxmq5tlmmyui5u6gt4bgl5wxxrg@qjsq2pvd7by3>
X-ClientProxiedBy: BN9PR03CA0423.namprd03.prod.outlook.com
 (2603:10b6:408:113::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: c34f0b8c-6bea-4488-5040-08df038fa26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	oJv3Bm6RTV+3SQlovTgYRcTSF0Es5SK1WJK0X3NOw/qpu1v9zTBkrPlN+vqoFyNLjpSXeBG66y20JfUcjtmX9t5uT5pEWmPJcGx45V+05n0bBnT6nfB5DJztsVuGKovt1NrQYIQtypG/i2eQs6diD3AEVV+ISpYheUVjdWUhnxwjMWVUig7uxtScoJbtuEthjquMDgDMKT9sW4NnAaqgIZwzu4JYA5slXicnXu3ILjQXrnrFaDlcmsOv7Yy6SsKasltvgNhmFKHjMQOnpstwwwEPXJnZLhn5IFMbI4kxKdX8yOYIbqVtnYM3GAeRpFHv0XTl8wo30jMfXg0IdXh6LfEZ5CEB9I5fPugEiDW4fkXFXFntAV4FSWWIJUp8yFay3t9d9hIGJMggoq6zZnaDggnCGLdcImaI+A08IwNAtNKDQsjYaG7OpCCnMwYgE+xwQxs+SMuoU0JPQv756L+8B8ioCTza9dXlOLuAYvwvXJS7CXmgpJM57bgOd8Zt7xqLBYCsvbOtVl8iW71+p6ykJxJzGS0WbKHr6FS96keqF0fQBAB6EarbBSmfyR317nGxWI11ljhmpHElYAEeM6cqQpJjCAVTY3lDiqK0G0xIqah7HlhmlLIq1n73qTTuyaBbqkGpiu6zgUTQ/6yvOLWeO4JX0jfHA7Fu8dYdIDwGU2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9BUEj3+AQJUuaxgkVh4yn5cJiqVa54Jod7qMRcDdbYM3+p7qcTPsNVoaqZwi?=
 =?us-ascii?Q?lBt/xHOVDb2HQ1MRVGap/XznPPvMBaJGvbwVjABhniaQfFG4lkdIhbm41g+c?=
 =?us-ascii?Q?3xkfYQPSnBa2QrNA8o7T1xHNKbxuTZr37P3KvvICOgm6YmiiW3jQc+280E//?=
 =?us-ascii?Q?4O1RBVwaNDPfNJS2gTPt7zlvJ89diwP48cqMgFpRY8yKqoJYaPt0dRTUoI/v?=
 =?us-ascii?Q?BhKOjvS+y5kAixIrJIpKnVm/pW6/HWAleTZpovBAso4bTaTMS0aLIoRsgWmW?=
 =?us-ascii?Q?4m02IrBZD2DCCkXKucGxyNIKiEgogCzsxEgsSKqwloIUUTupb7fqdM7W25Mi?=
 =?us-ascii?Q?yWWyrB3hJ0hOPUBsaVK6FCQd9oJBHj8ZjcL4sKyfr0z0DxoIUua5LaJo9Crq?=
 =?us-ascii?Q?Ua84DoTEliBsPBZZCQNRrmT5AWTFcXwYs7oFRk7K/aej0/odZC+Uny07VFMg?=
 =?us-ascii?Q?3zRt8P6/AXwvQ+LNhgid6/ceU9fSIh6TSITdLrpWsZjj1J70SgwV23VWKvuI?=
 =?us-ascii?Q?udoytXMrAOPta7sTLgCxDnOeFSOFIsq+dqLQn6z9ifmtce43qNRmzcNO1FYn?=
 =?us-ascii?Q?qQKoR4qtU+3U0+14MoveICYn0RuIxzCS/0e4Imhd58xBGqxoTWp815ve+fu2?=
 =?us-ascii?Q?f6Hpe18y8Mm8d1W+43Nz238Ui6dfBAkarQc3KZiDvAQnhNQItOpISMRmyYSc?=
 =?us-ascii?Q?xLSRb+S/K2cE6T5JU3XOX6A4otKYPY045uxPsIUuPPTaQDOjDVHdyZvsfnDZ?=
 =?us-ascii?Q?L6OOL+LEXPDM3NGltuVPZhVdzWRnMQ+hkRo7Uz/rQd8kGzjUiLAVDQNevo5J?=
 =?us-ascii?Q?K8z7WJjreUYeB0loARuKMghX65FtDRPhThtJf2URWFMbQPz2jhOHKhLmWSWE?=
 =?us-ascii?Q?pYtMAYTpjoL+MyvogMgGJJ46t57+IMxx+YsJdLGv8GPV3UJlALXOeIIcNt1W?=
 =?us-ascii?Q?A3uJ1PMrp7O0Lyiy7dQCPIEI8Nu9PcHtDshvNE7FshSENS3aFhnM0iX9L98N?=
 =?us-ascii?Q?te06ZQU3vx6YSTakj542T2mWRby40+ChRjcyIWP2eWPBZNU6WLcmVWW4abnD?=
 =?us-ascii?Q?OQu7AoLb+/9TRC8xXZ9HBcbWj5XchZQmT5L3fzuMknP81dpTJ36t0Ljepya7?=
 =?us-ascii?Q?rUAQ6P06dIV4U1fKFaDhZ13MugdZudUG3i2fXHo236tMrN+HKsqsSIDJ/SGb?=
 =?us-ascii?Q?Y/BDFQg1jXX9H7Glhuru+6wex67ElyAyYfGMIHELcokCmI9Ylqxe4JfxCn0A?=
 =?us-ascii?Q?5g1r6Him5Nld1RIv20h+kLRP4GXx2BrFEFOZHRKcpR9L1EetI0TJ6fA1Lmtv?=
 =?us-ascii?Q?rOTVyfIMX0Chmfn5ls/qDMkiJMY/E2nviPijB/ykQrhcECHeRfAxGkIVU4CP?=
 =?us-ascii?Q?B494nVxDKaOuN/sEzc/YV5R3fF3OHRsG44A9ejuTjIWU1V8D6D5DFNlNQgoo?=
 =?us-ascii?Q?KLt4e12he+iq8RVUFOMm2K6da967FC2Dgw/xaKtXCc0pH8v1Uw2myevLgPa3?=
 =?us-ascii?Q?8jr7/EaofPa2NTwOo0bcPJsCkjG9RfkFAqoSUfKQqR720ZZ9h7nx/0TSbMbx?=
 =?us-ascii?Q?/4Mc35l5e0C7Y88Qd0p42lx4Q10hw3f7b2p6b+8A7g0p3lZ4M/Ome07VwbeH?=
 =?us-ascii?Q?qU4SiQDr+SPYs6huBG1+5EjuO5+nFKIFJ8p0h7hbUAs8ZPn3PY5PqmrrWBTA?=
 =?us-ascii?Q?ZZAnhZI296Vri0xioe/u0zJY3CDC7z4JD6JlQ6g2vmfNhGIk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34f0b8c-6bea-4488-5040-08df038fa26f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 16:32:35.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa8E4iv6RtF8CZBG9OiZiAHfNlTsH+aP+RESeIGdNxi0A60u59VivW79OvdfOEp2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A

On Wed, Aug 26, 2026 at 10:23:20AM +0200, Andrew Jones wrote:
> RISC-V uses the same basic model as x86 (an IOMMU-owned interrupt
> remapping IRQ domain). x86 makes that domain per-IOMMU because its IRTE
> resources belong to the IOMMU instance. RISC-V makes it per-device because
> its callbacks operate on the device's attached IOMMU domain and preserve
> that device's existing MSI parent. The IRQ callbacks provide the lifecycle
> hooks, even though the mappings, MSI table, and device context all remain
> IOMMU state.

The irq domain isn't per device, it is per msi table, many devices can
share the same table, and the VM should have a single shared table
across all devices. That's the core uniquely RISCV wrinkle I think.

IDK how Thomas would like to model this, but you will get a better
result if it is very clearly explained and asked.

I would like to keep the iommu out of it, so I prefer if IRQ code
patches in its MSI table pointer broadly the same way AMD does.
Though AMD doesn't have the restriction that remapping only works with
a S2 domain :(

Jason
