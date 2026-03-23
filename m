Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81EF3AA50A
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272112; cv=fail; b=sdbFSdK1NjWWjnZivnhvGzLiuhm8P17L3L1CVoLSOe0PYcfve5rYU575kFdSwaIDqxpt281D0lTYVKpqs0VaMbdKL56nOZTSIESVuU6tIoQJ+hzm23+a+1KVaVE45FyzXD99NZaI2p2kWS4lrop1ydTA5qV5CVjFazdXfyY1Ohg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272112; c=relaxed/simple;
	bh=GJql/ZvknxIYUk0GulwWpU7aCaaQF+B5vanyfbW6q6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X0VpOjGmRLHN3qkiOkLWhhla1OjjzlxPVOety0PGl49vCxyAJGhPuGLHG2whqrEPU/JA8ln3y4sudoe0SCbTjRx6HH/Z/QPb7YUuKUkplTkm9NCB4yv/CGXdW7/JbbjYBTWyMlue/SZNtD4F5nEz9CzXAFHZee3hDXDUH52Wdus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C/D3BVyz; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C/D3BVyz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXyb7z9Er3JTY+2jCxxBMGt+o4K880J/ObUNppYSJ5QBm9sB9umvsySXzC3b1QRCYvWR7xfZgx27tSLfN+FcBc/46YObFGoRh7lZIYEAn58f66TdyT4ZxPKyPSC8KsTRbphfwaFozUaFAAv9we7GC/9NvEpzRgv4YkGtlYBJjwfAAHI3KHd46yFYvMc79GTbq/XHgseZTyh479jAtMLBhDmFDA6BiKWs5k+ZGt4Thm6AH6sbz00PjRFerObNmtV3WhvEVP/wFRdCzRyHgAcBJErutMMCpQgb80/rGNGhiM+afM8clxigh2fRlVF6HPIw23+Mc5za4/I3OeWPz0iOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJql/ZvknxIYUk0GulwWpU7aCaaQF+B5vanyfbW6q6s=;
 b=rTSwFUKfPhXkUF+S0736DILEVTUNOoqYf5w1WhEWGUFyNajbdE2bhehUzqh8ENdH+5UgP/z3zKXz5KT/X6P19nwEANAmd79CtyetFat8bAbv3HuHu3Tfpx3fKMuM56wHs0ioekNK1MIJ0B/hFUT+AcU5kbUisiy/xF5rvGUBDxfbwYFpJ85cZyQF+k7kQ4kVkrkedYP9RKLBgK/YwgUwu4ifH0N2Qbu/xNdb6flXhLdXXxPF+o5HXsfZ0NtgQWpgz6eDCpsjL+1zSqkWMosmLo9mg1ik0Bhe/Aq942yXFInpEHbt0RWA8W8HqXhdFX7sMiXPUACSBTgEOUDHTTs6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJql/ZvknxIYUk0GulwWpU7aCaaQF+B5vanyfbW6q6s=;
 b=C/D3BVyzY3cug7asha0pF9zjHUr1nRVEyfIm/h5ESUkYSvdrLp4x0P6iDWlS8xKiUz2mt2ou42NKHUbmGgUOAjvqynLvla4JbVuQ08QurCownlqTOoSuMqwPg5BYksi6G3T4ZJikLVvelkAjCIW7VybESW9KRSKe6E6SFktL+LjYugYm9LVNX0fAbnnCiEJbaOCTlNXQLO3YzXe9pZBdGRBEUlMb/z7oXp5M1MlVW3VuNvyTngemwMPTZSt2dG07v5hzcnyAm92i74lerZlLzkeiD3J7gcCNtacb/E7w+tT5e8xPodYZNlfIqWzEt/gLtrmDwXEPGUTBX87PY9W/eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:21:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:21:44 +0000
Date: Mon, 23 Mar 2026 10:21:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 05/11] vfio: Allow null group for noiommu without
 containers
Message-ID: <20260323132143.GI7340@nvidia.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-6-jacob.pan@linux.microsoft.com>
 <ab-9c4mm7WTlxcOc@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab-9c4mm7WTlxcOc@google.com>
X-ClientProxiedBy: BN0PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:408:142::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 44465747-1293-4a8b-dc20-08de88df2112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CGc4x0xRau1dAdpEv8JF1LyqqDMj15gLAphzwEYQz94vUu8mlA8/8Kp05PhRKr3128uJcbZJxLPgPrUNK2XpOofkeiqUdV/QUho94NFYf4vGgEbiileKk3yX2ho31E54p/AYIJjqthKKJ2QAGKdkwIE30SuNqoSzte/eFjvb/tYGooKrJNB0etlZMY9q6D1NO/EMGhOepuHgZQwuYTsrWLZpTP/zhbU4WHIyGhT5mIxmEgolDchfr5DrGg1zh0z6kpRwJ354gZu40yZ6eAlvn35gyfOdtAZqskPl86WRIN/iLZ7UVZ+644EGQUQ3+ZwTDjy1Pcshp7qz1SYRWj9HnJi6+6SsPIZtPpXyn4UjApfStMAeNmha534pnpr3xx4mMGuSerCtPcTIO+yLYIOD7/VYE/e5dPn8VJvQor97Yc95K9/aFgny/P8tMFJjjV+GQ+aaoDBo56ZcO1lkQgT+HxOA2hp7KuUl1zR9LvKgVo1C90CC4dSRaqCWFrhiGIfprAUldglr6JDr+Grq4HeeqZ0URYMiR4HKHeKjGw52IaHa8dcizkDHWkQoBujl2Q3I5CMDfdXRksDwZg9kVIX3Ws4NBZcZQNyB6uE8M8myCMxBRGYpO6forgSQuzoAGUVtNRzCWK4XKyxtZJnNI3b8l7hQp/mhAOztpywlif3xpIRdBnUEWbBErucsCLy4XZvdNCdC3Ct3Y97knAfIhHeh2tWRTEMXwEO6VWvoebsXrog=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fg64lzpv/of90byuAmwoF356jqkLzuOseuk6oE4yy5frJ4Hl5niLSjaqMiex?=
 =?us-ascii?Q?JKmX3K8HumZTy1l7fz7VW/VdKvEwLf9eJwZvxPEJVyP8Of8OFaCxW7brG7bv?=
 =?us-ascii?Q?5vvdv/3h0bMuiK+tX1Dsq6WI52ki+WWOMlsoj7I12jwqcBwSSOaHc65p6krk?=
 =?us-ascii?Q?1I3l3Bl2xbvw/boyYM6FcuapfclGjUymAoCe9aPY51LnudnpQB2Lf0IvUNLQ?=
 =?us-ascii?Q?CSK5vPGJcRAgGzIptB3V8mUGwkDCyuvwAUVSL/kaW1iOPTDL/uIEw5gzIOT7?=
 =?us-ascii?Q?yneAq7APaMh3HqVETcHE9JyqhX2PotylA/G9w0bJklmS89t4MFqf88ukS97o?=
 =?us-ascii?Q?2pXYts0KxrXi9lXT9h5VaOQHrmfG3jyJGdylaHPpE2gfyK76ukjR0tsD8DVx?=
 =?us-ascii?Q?+8NwgmPt1VCVsZ8qc9RYSF6QNzVfTezrlVdJ+NPE/SN/Yee9ms5kCZ6evoeu?=
 =?us-ascii?Q?QFxI8X9Qo+Exx4lijcll5TTSKQgHVqkyy6RRjodG9Cr4FmBbsXPVPnthQsP+?=
 =?us-ascii?Q?z3gBcwLzNC8qe2D8WG3QkrNanAMsxWkbfdidT5mHQx0AExETtpfuuiYl578l?=
 =?us-ascii?Q?M0fIHhsrwEkCFFi95VJq4uchZIN0NwwoF0PreDaT1CUsxW+9wuSGGwHiYTPt?=
 =?us-ascii?Q?WmJpRsSnwHbAgaOOH6gI+pIcM524odkb3b8jUD3KI/WaAruZ1QC2iRaL7Ra1?=
 =?us-ascii?Q?y0e/RC+RKMcXmILlM/bqs/U0V6yRznJQsRDYHYir3NrS/W5hXeAdMarjsDxP?=
 =?us-ascii?Q?UVtgE99BD1tr8ZoCrFA7mr8OkJ+bSKEoLX5SXEQV+xePXbicdv9sGmFD7GYm?=
 =?us-ascii?Q?0fYu2TtahA2JU8M4658UTJicPJduxF1l2hLLLB6Rjwqicc7LhWrbW63Exarb?=
 =?us-ascii?Q?sGxmQvz2vrLwr3Z2s8x7ED3x6ZxBWOAHh416tqtXMRk4Mil1wAJ9oUSBDk+A?=
 =?us-ascii?Q?eieL/6KqijnAgnJSBKC2Xjxje7cVDHE4F+toB7N+RWLTsD6kGf28Tgc3SI7s?=
 =?us-ascii?Q?C0Ftk93F4sBLxVw6bk6+BY/XdDaZfdnkP6+xnmlhP49bEEcgQSlhgHEYXqcE?=
 =?us-ascii?Q?NIES3dPg4G6SQKi8a8+aovnAHbnSNYW0qBZ0sAad16MWa1iYSU5Bo6uzMbDG?=
 =?us-ascii?Q?RLEm9DdizHFHtrhNrqaQc5cHMhtbHr7v2D8phBCI5Rr+Gsxkc6Xgh+tyoGUZ?=
 =?us-ascii?Q?YQ55BFMLSSCEs2KaMIKaJ04GF292fVNP5woedEOe5dwgfdVLCbm93HGoQIOe?=
 =?us-ascii?Q?4t8mCf5K8oGuDqsCbsfEurVn/lYFBy5fkiMW5l/gwP1pqVuf8V5to36kBe90?=
 =?us-ascii?Q?+rtoF1WGWxGDKK8h4Dbg7g/ufg9o7QT/4E2m4pV7OgPFEXoZMyHBRdcg0bMn?=
 =?us-ascii?Q?OL0kIw8xA51hyuwUhC1eORI6753a2snVU/DGg1b+MJbcnYCeibkZ28XUP61P?=
 =?us-ascii?Q?KiahC5SZvVTWz9S5EozCT3wsbslCRJ16g+bxRbfNMnR+IQZIOnTcPygoLwLd?=
 =?us-ascii?Q?UDEH3cs65oioYYtStsV0hNDM7O4HaBt5spEN42NcswV9hbxr6d8UqVMYh6kP?=
 =?us-ascii?Q?FUXA51U5qug4u7Qsijpok5aK1pTsUOvKawTeHkjpv5FdIGVERr4Two4r//rW?=
 =?us-ascii?Q?8oHqe5+x6KMVh7LCVFMdVcgLa+tOJ2xsd8xyueWdhkZ4rxeus1QWbbk9l3eP?=
 =?us-ascii?Q?svBhBsggBu9L/Yjdo0m95g2kGVsh5nNPbzFZpc298oZSaHpn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44465747-1293-4a8b-dc20-08de88df2112
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:21:44.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEAgJJjg9N0fzN7UEx7buwNeFilNnSicJPEWo+7LsNaIEY2ZUhYmPYJyPiImxBVm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728

On Sun, Mar 22, 2026 at 09:59:15AM +0000, Mostafa Saleh wrote:

> But is that really needed, I feel like this optimization is not worth
> the extra effort to add those checks and the possiblity of missing
> some. what do you think?

I don't think it is an optimization, this is cleaning the uapi visible
stuff not not require these hacks anymore.

Jason
