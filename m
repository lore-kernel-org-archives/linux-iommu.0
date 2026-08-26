Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF24302E1
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752098; cv=fail; b=Ia2rFqEDL4JGGKa1TzD8ndKC16y4MEp0y1vOXLzbmv9xJoLRt2ANBH9qE1QNeT8I5qjZLOSv7rvYT68N/rn8RRbL+4uMn33JljksFltE0c49e2t1VWAKrTwETe/EkM3tMDqqC0ER3b1yid7eeQvqV+fpj30Slf3Px/hV+9L/m2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752098; c=relaxed/simple;
	bh=CVK1CD7e/tXKAgOsj/LkrzO9UmYbuNCTmOJQPxov/Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CL677uQB5AYNJndQ7i8WF8y+IU16Uef5ClzCcD7+zczuny5TsAHA5NsOgU2GyiG7lcqOTFeHYEwvfrAbq1ywwnEletJUHmFx+vdPDt0qG8cVd2NL2mWOhpuIiOiTpK0hyZF89cWc1QQJ1CWuh/g8PrtuiDk5vYTrcB67rYOopMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PrySF1Kd; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PrySF1Kd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgmIZO0JuUvtazLbpKN/UVRiRD0lRwBoBD2Zbe+YE4meA307rr194vz3i9zPSfU60gT+WH6NLQ/Q/c2W+TlQMP1yNNOWKAUiOhBbSveWsOk5kOdCqhnEsOlEVwTUCWc+JxmKMQ7p/HXuhdVVYem8+gplCl7zfIl1Pxgir+BbOwanNhuZN+DiCpdZ+f840Qgt24YoQzmMTpn0oooKvSVcxjzrhnKZizeE5cybHV1YGrur0IyLGRi7vBeAFYWFumx0+yaedeyUaEn7L1PGfSfD0wAXBgaXWpzuhnenlM4pFBurbB/HreXWeqYqA02+npaQ6ohYyJXtCk5iGWO0WHiPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QHcx3mp31Ty6E4jyBzJiMx5x7ui7EzZ6OphWpr71S4=;
 b=l2ctyM0BpCWJvYFxCftkFhLVhucszePV9OZB7Va7dlD9lN+aMsNzarNL6uuO5b7aqhfbI5SB1+Ln1G9b3sLCsD6vOqe05BP2AuRI7rQgT8tzAMJW003/vs6c34prix7hnJeE4qq+r/dPxajCFIB9cz9rmaGMw0wIQIdnoMaEwinlZi4W/KAPtDIpPFhOpwPsbqWNkip8mBhyXadcv+gZYkL1XI47678ptPqWC8v7Nso9zTJ8dihSOmeeGgC+kpUcvtyVgYHbbs7OFaff2pFP7MzWncSnv1grMsv5dIzithUD4nMxUkX0/mpFo0ID8S88oiG0K5/S8Mi94LyJJgsuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QHcx3mp31Ty6E4jyBzJiMx5x7ui7EzZ6OphWpr71S4=;
 b=PrySF1KdwNwxervIxRddZZEpw7ONvyHUN4YmFiKusEAHm6mM/SdIIrqlF+zKzcoeyx9s9Ov7kDxlN7T+91IwuytiDmVxixWUU/7HlaTk5RDbPyaY3b/VxN8r/OWPFsXWzwoMKcl/vYYw9uy+I5nTlv5oQij+VYEzDENiDZ1eb6rIFci+H9axc/KcEGoAfPlya7pHGGRjSwQ1gn2LQYPvQSy3a3Ovqp0geb9WZgrjVcAtc3lqa28wYgVUbZ+rSR0kyzPW2trzdvcoMfTMbeMqKdCH/A8Zd5PrcemcCOZ2KQ+Kt56XIj79qzjJwwUDa+ADNg8ySfom94ZQ4h1x9b2/IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 13:48:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 13:48:00 +0000
Date: Wed, 26 Aug 2026 10:47:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <20260826134757.GK3325090@nvidia.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-10-praan@google.com>
 <178767577113.3356902.28128835506777632.b4-review@b4>
 <ao3kxwbwB9GC3EOM@google.com>
 <20260825201701.GG3325090@nvidia.com>
 <ao7TU2QSprRbGfEC@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao7TU2QSprRbGfEC@google.com>
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e05b77-ff96-47a7-5483-08df0378a470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|5023799004|11063799006|4143699003|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kL/KG0MDHf6fWE3K6Dq2Q0Q/SxFuqllHyw93OPYCezKH3xNGZaituULgpJeh+0iWQozlNIg1tHl1cg4pkNyyY0DSDqpE/IqDYgXE6u3sLOWwCa5s8p1PezCWo7w7XE4yBddidqdTo1p84x6mIIJgSQ9Suf84+Sf+05FZCjjCvoJivtprw5NAC6bPiQUA1j6dnc4O39nDSY8+lUGPs+0eeav94EFERwloezInM5Rce4pQJLzpV9iDUNRBmZE06GBgJYJFAOxaVnW3L4eL8XSrl1Z66e2LjBD1smsbfgBdhlBPji9Om/RmPoQa84aQ4tBfu0yhJnPrtwGEbooEEQXUm63BvNOIbkMvPO6YEyY+lOHIIMv8pTgn17ulTN3E6X5AIe61kcFKvP0nL7ZtT5Ixgb6ivm16VusT4DwGH0olDRal0uhV6a0uEb/S3x6PzljzNwb5UM9XmRt14PJr+97bvKwyXSjvmrGyOGgVl3j1DVJtkJio/C3/Lga8WvmxI2kuGI7XWVRv3FV7Qyk/8p4aK84cRmQxamk+UsDOM7ra+/fF6eG/zV/7vshHdSe9whu7jHBVdbNS9RE95TXJz18yjt3knUd9f1Fy/vfOGNkq0cuCeZQ3E9GVybPjddZAsEgmIKJEsKQa+9uFtGeKpq+mG70PQSHxmaf3GF6RLWCglVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTKZSPXQiHLS32Azw9Xe4mX95OVLNPQ9j9JmJGzM4DzjQvwEU+jrz2TJVOAC?=
 =?us-ascii?Q?iHyd9DYPQNPqsPhA6QaH/UDeSv4bS0pFDla000bIux/yKBfnxwz9WzWO3b9O?=
 =?us-ascii?Q?fa40msbgS0b2hDgTR9JKaWG/bZjQVtd8iSJOc5burTP9zzOUS5gcGkxmTAZf?=
 =?us-ascii?Q?MQM93E5Mpm5vkmdFRuOPtJMkhmVjg1CZu++0GRV+BN2pgSCMG0+NLR2/mKEz?=
 =?us-ascii?Q?nP3LCZgTUxpDwimo+PrrBMRYnvS67W+nUlm/xt1ZR5ezWHWsGUFHaBfLfjB3?=
 =?us-ascii?Q?V6vsEtky4AMGcFN7wjYPHe5G/+QJghGc7ZVjQCsJPWQ+mtqKb0UiqMTpw18X?=
 =?us-ascii?Q?A0oH8mL84GDO4DmoWg8XZG5vozXG/W4JDpimd1kugrdMonVUndrozHTXMHTE?=
 =?us-ascii?Q?HGgpuUixwWQ7V7mW0XWW8fCo/5tHGjnBOfK2m16NgrTKDsftm6YsdmEX68oV?=
 =?us-ascii?Q?0B/1soxXu3fnne0VgBIZOF9M7z62sNmcNNsz+TY3wp2J75rndbQm4pNRis7a?=
 =?us-ascii?Q?4T8/5n+z2jfOBzVzYz0Ni+GKR33DUhFbCcfmSreAGMrvIMUCwfbpknAwzHwj?=
 =?us-ascii?Q?mlmNZMthal1iwk08W0Smbf42ZZ8TnNf5/evyzV9RnZiujuj9ZnmLy9b99YgL?=
 =?us-ascii?Q?HDQxjGqAqOaG+Aqp97XG4y5HARC6jkDxh3JnSl5zkbWalhs2VJEiitMEMcL8?=
 =?us-ascii?Q?MEQ1kdPsVotlP4ndkBkMV2S0ANqDPoM2EP2sZ/1/vm2zh13hOJe5FnkQrfCX?=
 =?us-ascii?Q?HbxUFr0KYB0IPce554F1uGUm3WSvSMnCDVG8+IJ67ChJL7jCvmqbF6hItt8y?=
 =?us-ascii?Q?T9iSmCdfbVLLej7Ss+xPN9szZcxb3vCaOeeTLpOmhOR2iZ+vO5+42PcG+645?=
 =?us-ascii?Q?RI1GPrs73VOvlAsfhpgr566TJTF1uAa5ehM0OaklB6CXqFZvPbVzeVP4E/fV?=
 =?us-ascii?Q?GjF4/8M8ctlJUh6IavNOVsoePShAzuspPz4JhkRAnqvK1YS3z5aTTda3wNqu?=
 =?us-ascii?Q?iY3Uu7wO+itfCWJhwbcwrqvbgL9e0MS6J/hMs0F2HfwukGL+Ltdf4ECWn3HB?=
 =?us-ascii?Q?wBLroscTODyAwfcj0GsA2ffxiYTC1zsRVzWEiW5b+4Te4J5pFE3Vu7+Ksgvc?=
 =?us-ascii?Q?5Forvb0UquijmVWP9aUHldbJlwgYcF0b4vYg8XKnhh67XtXK1RdacxpN9Wbl?=
 =?us-ascii?Q?3i/Dp4TN8eHQtXcpKtwdq9qxM5nc2AfA36XxW72NKuGxh2uSQYIfPvZpAy/c?=
 =?us-ascii?Q?OJJEjBuKV8IZLswHDBgxtyhp3915XQlrzRmPo/WQNpzXqFQdd2VFjTkSiWVM?=
 =?us-ascii?Q?88wI0lwHHw5dwJ1x6s2uyaTYieTG/v05/5JzRvAp3uA8gcUC6UjnRUDbUoH1?=
 =?us-ascii?Q?4UbIChwXZo1EXppKbTsOyIgc0/4/i2/3Xm5fJy68H8R6lr7gIr5O8eZ+jfxH?=
 =?us-ascii?Q?haYFchMm2CeixgSkDulqgce65y9bnIiP40Le4ewbQFhHjt0bmZctmC6HmdZc?=
 =?us-ascii?Q?WwH5jsf0OfwMtVJpOVq/fQ7irIYm9PrZ98LAIzvUMv9DKnkxdkF6Nr+CBZw/?=
 =?us-ascii?Q?/EPRX57vpayjOEDY4dVYVBCzd3VvkaPYk9nw0QxUZjUC6nrd7O0cuVZ/QNfj?=
 =?us-ascii?Q?hl2fiTryWW0Fox2dmdMYLy9Py1EDe7SR8RfDqV84ctKlknFCaV8z0fsR+v0+?=
 =?us-ascii?Q?/4O8QtHtKhcr+kC45kzdtNz8sA1ruhb0YzqmUxeizRNqFNLR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e05b77-ff96-47a7-5483-08df0378a470
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:48:00.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNTomL5riM8nxQISW1fD8KTaVX5l/zZNwxe5USjaUWtTfA2pfgFRL1WjLYAZbhNc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915

On Wed, Aug 26, 2026 at 11:51:47AM +0000, Pranjal Shrivastava wrote:
> On Tue, Aug 25, 2026 at 05:17:01PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 25, 2026 at 06:53:59PM +0000, Pranjal Shrivastava wrote:
> > 
> > > > I agree.. I think there are only two options?
> > > >  1) After GBPA=Abort ATS requests are blocked, so you could full
> > > >     invalidate all the device ATC's and now it is safe to ignore
> > > >     ATC_INV
> > > >  2) Just don't perform suspend once ATS is activated
> > > 
> > > This is a little tricky, I'm leaning towards 1) since edge devices can
> > > have ATS enabled
> > 
> > Oh really? Surprising..
> > 
> > > However, the EP might've entered it's low power state by the time we 
> > > reach smmu's suspend. I'm not sure if we should be waking up the EP for
> > > ATC INV All (or if it would even wake up in such a case?)
> > 
> > Is its power down explicit? Could the PM stuff trigger wiping the ATC
> > and blocking DMA for a single device before allowing it to power down?
> > 
> 
> The power down is explicit, due to devlinks, the PCIe driver's suspend
> op (runtime / system) is called before the SMMU's suspend. I'm relying
> on PCIe driver's op to clear ATC and everything else before powering down 

So maybe everything is OK and it just need some commenting to define
this split up?

IIRC there is a PCI spec thing that says the ATC is cleared on certain
config cycles?

Jason
