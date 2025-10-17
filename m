Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398029B77E
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723684; cv=fail; b=c3Ahlm+5lfcRC7rw0KPg3a86XULwTseg22atVGiH+o+1/4Nbv5t7ZLQmsy/ThKh36dxVoQyrZdTYETAlEfXVf31IurzjeinIPGbaVU0JoP9ZZtrRPPYXjvmdjCATl1V45bZWdNkTiGVJOwIzlk+/j5IsuWeePOVYYHBj6VgR1qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723684; c=relaxed/simple;
	bh=nxPhpiuwGDCpM4Qz2s2Ui1mqUl6XBAbEAXA/o08ayqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XB1kjCE3PLthKk+M+W0+kgeCZhmHTbJp9fEm0hZqTMziNrCy1rDPaiuiJ8nInfivCfEPtLXVMKMq4ki7+lRusvJFyuW2xFG3QRaTBdf05KlHXQ1ITILRLjjNkHjMc8KWz3fjoaS9/w4e8GQHhzRrXbKR2b7CsMfdrBbbxqFTcyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MBdGMXNl; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MBdGMXNl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOCzOkInEg+SNtL/ROb/3eGP/W6JtgL5Zmqxb62pJ0Jbe33/wIkQezFicMArvVdPmU51zxE1lnCrM1ImlShMJcVdUasa7IYhYOMsAwJ08pVgzXH1HU+MMj7hm9l0/XX33Kzei0MsB1dY7D/zr7kCTx7qZdT2AGVB750f7JhZxKeV7ne/IwTQtlgW914uQI336EpFIFr5CY2vtq2yNlODyBAz9R/9KUjH6L9T9umsD9ysjw2m73cb3o9RvbQSkIdbxwSNPBuOM22UVfZBIlaHK+XSLYNNzILY6ohGzu0ak8nzPZ0zWzHhQAWpY9mhfZKChKFfhVcHqAgP4RrmL6CxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHeIpbAr7lhnDIynFyxa1V0L1zRQmg4uW8W5tiYNSqk=;
 b=aHCLTSGQqwABQk15m1Oogdmhp3JM9A8zNvzteLhXsJcFSgDXjDuAvmLuMMy+jWugI5A9PpjIikbW7+MZE3CZwT8a/UofKfm8wdzAjKa4BMjaAuX21PGyk4rK5ZHvSU4buPmYqN/1fmQybAe75r9cJQEU8WZX3gT82xXZxnc0Rqtu8HN9jN3He6iQUEMX+OyK6YYf8TuKUDu9iHCmvWYnIylqcCWxdNnBH6tiX2zDMqZOdyBsKQI6+UcjY26w0hGxB79J7c/XLRu0zVgZ4t/N/klMcioDwhPuBvWjCStRb/fGROnrT0jDlBqXnWeFPq3lGf79qLm4fAKSjgB+QH/+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHeIpbAr7lhnDIynFyxa1V0L1zRQmg4uW8W5tiYNSqk=;
 b=MBdGMXNlhqf98ro+6hjC9rIiXjRygFq6IL9buDv6T96m9RfhGE5/rb+bg/9t27wEYO58Tw7NsNEbmuyUeZyYbIrwcR0uVMixouQHAxygnURWSbqVsxKgfFZfudlR6e734DoBBMBa8TppfR12SFVXahVi9We6Wrjv7BJ9RxgnnNeqpolVOKAhUi9/U/6/ttwVKH+7x/HSc/Naez00hrWhjlm/r14Yaci4+X6ZZSsRqZwYjlqNkTzH+ESyjNx3qSVRe7GaJJ20f2ASrXD0NHpp6UI0i6ad2KFd+AjSCiSbFDcLboTgyxhMLYGdm8jDS6Y3DcR6UURpq53ktHNiLmuHMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 17:54:39 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 17:54:39 +0000
Date: Fri, 17 Oct 2025 14:54:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, iommu@lists.linux.dev,
	security@kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, "Jiang, Dave" <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH v6 0/7] Fix stale IOTLB entries for kernel address space
Message-ID: <20251017175437.GD316284@nvidia.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014174339.c7b7d2cfb9f60d225e4fe5ec@linux-foundation.org>
 <6b187b20-6017-4f85-93ac-529d5df33aa2@linux.intel.com>
 <ecee3200-c8e2-47ec-a219-c88e8e905b32@intel.com>
 <11cad2be-9402-4d45-8d2b-c92d8962edfc@linux.intel.com>
 <20251017140101.GM3901471@nvidia.com>
 <c3eee56a-7fe3-454c-878f-cff37467fb7e@intel.com>
 <c4f7c23f-48b3-49c1-8a40-fa388a1baa68@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f7c23f-48b3-49c1-8a40-fa388a1baa68@intel.com>
X-ClientProxiedBy: BN9PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:408:f9::6) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 740e2139-35a2-4e0a-b17e-08de0da63e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k18iL2rY93E9v80AxPnurNP3wGazC65X/Fgbhl7WPX/L6RvbfmoBRw20FW2p?=
 =?us-ascii?Q?5DtWd8uxi8aPr8sGgkE/fPVB0L5+kK8+Dk/i9gugsn8X5kZVhKw8evdzW6eD?=
 =?us-ascii?Q?hIjjYLxTWltbvloghPzEVufcNd3C50LiZiI9QqMEjqxhfe5tbhXq7hBuTR7E?=
 =?us-ascii?Q?HipU7uTBfoFoCk3WbP+FvfAMINxo0wlDsThaJ0pBJfCEBhIbXk1FasCtNXCr?=
 =?us-ascii?Q?v4RZGDFH8HJA31lJVnFzIKSczoO+Xi/uZ0UGw6gvm0j8nQnhqI+PKp0+84DX?=
 =?us-ascii?Q?3ZkRjs5sxHkP3BtaPwz3er00WlEaJjH7N3zFUiKFJZwXPNKaEaaV0DIfmQaV?=
 =?us-ascii?Q?XgqAon1z3LxfD8Lo2dgmq/HBfHxqOTC7aV2zIZXrSaXPJaBSb7aCor0c5uZn?=
 =?us-ascii?Q?oyXE32V6C3NAJA0/ReugEVFHUP5gzvDB0t0wwdkiZho19s8IqKMXgrRfoQVs?=
 =?us-ascii?Q?88vmuLZWUpKp5h/a1QZ4uhjUwcBrrRKXNl5FkSaMKXbD6kTemy+SrKEYh+DA?=
 =?us-ascii?Q?9HloRF9lNFxKG2xRTsLGCreLbKSmMmGhZtpcuET2dkvK41hZ4Wd7A4OOeIZN?=
 =?us-ascii?Q?xIRcRLOsG0KbcwKBS30bz0RZNO+fknlEKdj5nopW+K/CqbFQgXPB5EEQxO6n?=
 =?us-ascii?Q?6z9MMVrMLCC4XMdxO7zbC5rsnocKfEonJJeDafAeoweCF2ig3Cf1cxfQxx12?=
 =?us-ascii?Q?L+gZgRR9T8T/eVDIhCygFYtTHnaBhj43AqF7NS31R4MstFJSSd3npvg609iE?=
 =?us-ascii?Q?tu8B47J4pAi84TdU0okIprRvDY6h0WUzipZFeSd5UI8fYofEgDVu5AcpHIM5?=
 =?us-ascii?Q?LtHSy0OOzmU13E+weX2s23zYCne6jE394W8N1nf0sI+KImWh5V+bBvfu+64K?=
 =?us-ascii?Q?L119VinM3HJg64uYfI9zJ8v0W76YpG407h1CND9pR6ptXbGgiUheAkdBWzEz?=
 =?us-ascii?Q?Xw5i7dR6BJeEXCe4p0EZks4m1RiAwiFpYkk044JyS49879r+StqryCsCHzs/?=
 =?us-ascii?Q?87WmVyt5VJwF221285u7RqGjcTvzapaJVvFEQHa6xxrd+h3aidvaaI/8eDaT?=
 =?us-ascii?Q?5kaIYeAjdQKkbYPaMQ6TzQYw4ZwIjcDYCdYmroFmkVKRh7HAc49Pu0OCjq8O?=
 =?us-ascii?Q?yk6VmVt8KDYHmPE5Qe3FQSGRMm3xXXlkhxxINl7vIAVqF6oPM97dMmvmMOLT?=
 =?us-ascii?Q?tivTzOItxWPjNrrBRNmFPAzeR7N2HQKVkp7PG4UHsBbOJR6YYq9KFhs/1Id/?=
 =?us-ascii?Q?Jp8rqTBfQzFCqKjZ6D3DLc5u6ArUwxTN5hdO+LG1P0CFPDl3tqWhKFKJAoH5?=
 =?us-ascii?Q?VzdkB3O/IZqBAZCFgjqYWQe9p2Y/KXG124OQQXAeFoayPhaFrn9Ja/K54GnJ?=
 =?us-ascii?Q?r+9retrJ6WO4c2fWmpoKzkXkt5NRWkuYPXTmz5O+LiHIxrmu97o8wRxE+PMb?=
 =?us-ascii?Q?8THE3GKBfoJETvel0kCU512X4KemVoO7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IUv9250BGBUtNUsIz+eBDMG17Pduivv7eueeuDnnT92lfRu1VSfJgmui6zr0?=
 =?us-ascii?Q?7SoxM5Mt/G7t+VpMeF94UHaY8av/Hc98Fluc3s8QCdWte5NDlRVhCqUQ81Z2?=
 =?us-ascii?Q?7oAkUy+pX+7Z4TxZndupJCbJ5g0jXPmTKTtnaGkJkoFwW8AYnlGjdp6YIM1s?=
 =?us-ascii?Q?mMZjWMd5Hku+JnswjV/3HYVq0AH0v902tA4CMXPXeuId64pknufOPf5tNHuE?=
 =?us-ascii?Q?lHjrmdqciMUn1EUfpr8woPvQpy6+QRkpV3XrwHI4iUgqGUqY3fhFVf6av2q8?=
 =?us-ascii?Q?swfOmLZzQyEijWXBzOqkLhRT2XX43c2Ovg8QapiBMNyrQuOS8g4LG/7Eh3iv?=
 =?us-ascii?Q?wl/jfr5i8fNCsO0iIyqbkjnF/+33lwF52sClO7AHtq4PatOJytyXRJxWhQ6I?=
 =?us-ascii?Q?FGsTNdoLAEDyQeXc8nIm+y6HjaSi3LXs7eJNbURqZbRdkTjc2AiVzoOF1AuZ?=
 =?us-ascii?Q?cVolzTC87nfAd7zIEKxG/FoHnPIeQsf3gVLmcIhlrZeD2FgU3d6s2wvO3X4E?=
 =?us-ascii?Q?sj2M2zPwSWG4dQ9dx5pbR1J7nxxreB2+ZkRboLj/t3pcHSySsXhXuKW98YmZ?=
 =?us-ascii?Q?Z5dQ/wif7wSunpYy3jo+Du0lyq/Z4XvysW6nteUONQilYBDB/zD5n/ws3eQQ?=
 =?us-ascii?Q?z8fbgPmOe5+Gkgs8ZkBbhLuRYxbbB8YtvwGhdHFlsmYChYjxvHtnEPZAlBCA?=
 =?us-ascii?Q?3IRzrnYIuAEFh3VuBDe1EBc31WlFtt1DKwrt4x/E2vEv7zInEEwP5WEXAJn9?=
 =?us-ascii?Q?qpRoEMzv/773OM07vlp8l5U/yoJ9LArA8oPymDmjgGUDF1l3MGfVarPQa7hQ?=
 =?us-ascii?Q?zUB2F8WaGuC/aCM6ewzV5ryTKSnawyp/EnHt+OVsSo09Pg5yqSnz+4h3vKXH?=
 =?us-ascii?Q?/hx+vlfiuH4NCs0qZSzPyx4fsr4mTJHT11k+myfBHMYEbvUx8Jg7++G8Vg8e?=
 =?us-ascii?Q?Un4S18yDFRvvvzb1lnEVf3S2BPTH2UO5t9Fhbpy0MeRG6LtsqTM0l57KL79i?=
 =?us-ascii?Q?t/i3uwMu7C4WRoF8uZDJLCR0vX3mw4SMX9KlMz3HDftQdR+XDtUOL/6ty2/a?=
 =?us-ascii?Q?bfm3w32aT5izBPPc0T/kDinGUZr7PWF1WyyF76wRVAhNV0aainLfxuAbkRV1?=
 =?us-ascii?Q?drI07TDT4lJvNVHZCkO2lfENql2pTxFRQP2sxAt2IYHGotkfcRr8KUZcYeEn?=
 =?us-ascii?Q?AMoXCFgrOng+sRc4VPZ617cADemWRWGisV01hC3ZhN91ZmkconTcTt5KbHcO?=
 =?us-ascii?Q?GqYa7t/F4p+XemF4JwhYFUwkWpIL2dxauC46amtRtK94Y1nweNquJy/OePdZ?=
 =?us-ascii?Q?mk5cUZlRhpYSnORE2QOfijjGdYRKHc9AMiZATn5NmSs0wm6dingOHlQe0HYD?=
 =?us-ascii?Q?rWG+B2fnXNaCkBUdyq0pY0iEhpvxYqc49iCC5mVSD3gbIPhO2MB4X9moZpks?=
 =?us-ascii?Q?99c2AQgZgcD13kXr8LADnTLsm0JESDC0aZuJo6aMBLSY4LNL+RS/UvvpmA6/?=
 =?us-ascii?Q?mDfEmxG2MJ18P6sS4uykx9KX9RnXN6C8qwOpbnHZOVJgp5rYBCQvWwTFLCWc?=
 =?us-ascii?Q?x14A3gw8g1PH3q4ivtTg7qXCbgdRh/hPTaHaqjPr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740e2139-35a2-4e0a-b17e-08de0da63e2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 17:54:39.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dP+uc9lSS4Co/K/bfUufmIqiwL15Zu79mub0l2bNA7y0ONbAlFmlZERXgRxAoeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361

On Fri, Oct 17, 2025 at 10:31:54AM -0700, Dave Hansen wrote:
> On 10/17/25 10:28, Dave Hansen wrote:
> > I'm thinking that even messing with arch_vmap_pmd_supported() would be
> > suboptimal. The easiest thing is to just stick the attached patch in
> > stable kernels and disable SVA at compile time.
> 
> Gah, please just ignore the hunks in that patch other than the
> drivers/iommu/intel/Kconfig one.

The AMD driver has to be disabled too and there is no kconfig for it.

I think it would be simpler to just patch iommu_sva_bind_device()
with like:

if (IS_ENABLED(CONFIG_X86))
   return ERR_PTR(-EOPNOTSUPP);

Jason
