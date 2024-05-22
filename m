Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB49140361
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385298; cv=fail; b=kB8ZBIFan3s8h4HFaM2qsstH1aU1k1ltdTbeo4Ux+Fgqd0O4zyeB/Q5IHbOFElrwQZT2Zqe8XR7z6tiJScJqK6tM23lkCmDvTWUGCcsLX25tUBliNtkEPuWSoaXxEYM52raO7AbM2hE8xaf5Rfbdj8TlnGgS8MlQzY7hIVhir0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385298; c=relaxed/simple;
	bh=YJyyLlTH1QvSOa/zrqDAGLSngSMsuzueCbzJ3EfeRqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sl8wWAWjmruWqWXO7ZFMlwaEnNb9zMnkFYLsX+OWAbJ2gDKe/TelAv9JTSM0+rpWa2XiuWYkvHFBfwp3uWGftCakmURVCtZOgWSKrG/I/CGFGAsdQWwyoaLRPAJ7Smhs7CKDcZ9j+nsWtr7Mqm4bLfAXCksyidq0BCf0qazGURI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S8KdGIuE; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S8KdGIuE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbMRrO9cFuBMD0ntrXCnGR7+0WxcGvnVtfG/2WQsMM8yv+2Ds29QwgYArnhUK3FAT4IHOHaO2yPpJdukL+dwL2G//hZi0BNEAxCVhSvW0DjHQbsKx94+ytOVApAAV6rS/7E4XwUyMv7eV12/yYwsGfSGYPDkWvyvx5toXHa3Z51GN4iMXJxzCXvUt5yeNF8UcotOJOKOuVOEEW6b+NEIENglG4mqbr8BW9JgWO2pUeN/RCJVgxbSLwT9V9hzjcS434kKRXmzUvnZ2qHTVUH2Xvw4BKcUcY6+VTntStFyjWGjBTkQYHag2kxTQkNpxIEmYq85FU5u+OF6IvCg9/urHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru1KYYQ/FV162WYTwUV+NqcPbs8b2DBgfXF/2ak7nbg=;
 b=hFI5a7RmTTW2hFqMxLb8yeqRTvfWkh/y06TycWbMTNsjVfTvmniIxqxNnf715xtu2UFN3Y7aF1IRXTyEU1+TrWQbsQb+By01594iG0N88I7ebE5oUWLZFLLAWwEBCJ0gfqB7q8oduqX8KM4od2gJ+XEgjfZ6VHSO4zZWOzzmyb/qSjJeRthymTVrCPTJHIZi7KoBXUHs2oWRZfv8IxBCLCHE0xYKyQFJ1bRsXwJKlGyM49t2onLJUp6iC/NVpPJ4ZZb0b4WlXLRM5vw13gQBZgC4lPtVpTp30X40pzEcqcXhfR+33NitMvqyw0LX+CL6SWUAE7q0DD6zvxzdBMuOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru1KYYQ/FV162WYTwUV+NqcPbs8b2DBgfXF/2ak7nbg=;
 b=S8KdGIuEjicslKI4bGjby1Egq+qzpg+So/xEYAshBanmfMmD/mbaTYzr7L4lHmMSUCKKZ+KtJ1QaOIFl+zjeGQgCxBgclKmFZjuyavXoY0Y9hCpHnGIOkYyiuFW1ciH62jEr9XgsDJMeQfRrcGVBW+Mn1mDgVptZyF79pulCldSUHFxY8SLryIf88mWNEQcZheH8C5Wnu5VONFapfll1CfQ9aqtxN6/HsGUJTRWz2R5OcePNQLvPDMigv8JihVLhK0XFLk+Az5P6tFwkmotPgBjNFl5sbW+8xGMlmGaWQxaNJpNBDQ8j9Zhnpw1Q/2MzpuKLzJlDPjShEX0ewNlQhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 13:41:33 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 13:41:33 +0000
Date: Wed, 22 May 2024 10:41:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Message-ID: <20240522134131.GY20229@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-5-shameerali.kolothum.thodi@huawei.com>
 <ZkCxTWbkK0Domuwr@nvidia.com>
 <3d0aa20bbb97452cb78b3bb94af24ebd@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d0aa20bbb97452cb78b3bb94af24ebd@huawei.com>
X-ClientProxiedBy: MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: cb30e24f-fe81-4c39-43f9-08dc7a64e47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1qm5YHGJ6/ZfZLPrEizko5WJWv8xcbX8rwyCZEl64PkaYmsqFvZEx4oh+s+l?=
 =?us-ascii?Q?RCHx93ik21fNDIlVvzC4LANYxXRe8YVtVOP5J+m5LwUP1qKGqGebRNb7dVgQ?=
 =?us-ascii?Q?PHGdfe/PCs2/sJkqrSvscFiywqxI3KuCpW8H81P0VAu/Z5NhVfgQ6PoFGLyk?=
 =?us-ascii?Q?tBu8qI9d+33/41podu+oKrB3OUmC/MBEIVUW5DtggFSnEsn2jH6vEpo+OWiZ?=
 =?us-ascii?Q?Y8nFsKNZbmEHd8/NQXr19smdolAZdV8kIIS1LY+e1NN/LRPZ/n/vouDSdyz7?=
 =?us-ascii?Q?4klxYPeS3q47wy+ncEoRqqRufC5SCSN6eZpIzeWsCDSpFF3c85IXGzkYV++F?=
 =?us-ascii?Q?WpIx5HVfZRYP2n1wM+HFUQNHhhF9rcW8HFsoR0Y5ygfVdpCp1XgqHlQ3oNX4?=
 =?us-ascii?Q?GSSW3W1EnzWpf6bMCsvYVDp/D+HobPk4a9dgist8hAnb+bemjuHQaVFRb5G1?=
 =?us-ascii?Q?DvEY+DyyvA2aCsroo6oDqR1ks2HdjVauK8Yna+uGvqSbF4brmHD0Dsn95X2b?=
 =?us-ascii?Q?skjGWWp08JBGQrSXw2ZB++CAoAS7IvaO53jC8qCSTE+fXH8OdHJrTQAVFWjO?=
 =?us-ascii?Q?ew0XrQLnzxfmh1oRMcY2BobLdgBgLS+G2DCvhzpq86RUen0XXZ8f4Sq2T0mT?=
 =?us-ascii?Q?lL8CiPt50Vq+gUMl1A1iFhjoRkuiYDgkbN33EOZW5h749ad+kVzXY2CEtOGS?=
 =?us-ascii?Q?Nj9p8ETHD3ABK4gL0Tn1t2R18Q6mhtNklsv7g9wUwWg0XTJJTmKbucdzWucw?=
 =?us-ascii?Q?svQYLMqcNE+Fj/wANVmJ4MJlnMdD+UObA10mnaKOC5JnWBrwoL8vQzL8imjy?=
 =?us-ascii?Q?gM7/g73Jbu/fzSW9o5ULUd6m/lZA2o7MBlJbeDkzy8SLXgnYvcdSkCa2Xqvv?=
 =?us-ascii?Q?zts9HzYj/pnlSWpp4VMdLWv98tmA238yRnnUYKOjGoknizgdoSqZQAKUgIvo?=
 =?us-ascii?Q?kBUObZ3LJNvvNmHgTN4/RKYj8t3mwT8H0gQIzlEtLeAUnyGsfJ6E6/4f/L8s?=
 =?us-ascii?Q?aBvM9kfuWd302VaJURUjhGrJ5d7w3T54pzKlIQ+662T7YWgRYRvL/uaPK2vV?=
 =?us-ascii?Q?5StdAFvGp0wpAwyT2ipY41W9e9A3Bg4oKBB8p51Mo3IJsyurexu0Qs9rEkch?=
 =?us-ascii?Q?J9aw8pYcJAKkBKy1PXa39z7SbD+Rtd5vT2oZR22l75qWhC0bOHt0JFu/Jbst?=
 =?us-ascii?Q?EGn0kP0gSBCN8hGmwwi5E2oYgfGnf/g+Cx/3V+edo8H+N0aeivL8WmUGKyCX?=
 =?us-ascii?Q?gnVKfxbVDzbn3Az0D33GY+gTW3HVfLtZ9OjUOJmErg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LAWpKifjU+9nHwqU/4/GGpH4N2BVtbMFndOCSCCF6R8CT8TxLMLyr4GdCAVY?=
 =?us-ascii?Q?80ReSC0ki6ZOBGRVLroFH3bStlGklUyU6JdfzUqU0vLABTMob0VS/Vx0dztm?=
 =?us-ascii?Q?d1eb4RPhLlUONRncpdtCw4Q6sb6F/MT5XRJH7oUwfEEq73LhNJPJWOmObWnD?=
 =?us-ascii?Q?4x6Pdy6EJCvXeZTx7nHgubuXzLbBUDoiY/ELQ9VsJih1bJYwmpdTiI02WWgx?=
 =?us-ascii?Q?Vr+JUA6ovryiDpiez5p4u+Rh/tn17TP8+VnwrS3PDyB047cMn/0OpyraxaOE?=
 =?us-ascii?Q?VsqUlfEy/gT+UtcqH4pKG+oq72nlo1lpqlDscJ4AkRmkmVCpz4hQELibFAsw?=
 =?us-ascii?Q?QPTegPuOQmymHkCQsd7+w74HJyRWFwaaa2O+xW27of6MxH3zqyuUv3sz0cbM?=
 =?us-ascii?Q?V/eN6Eeonr4q/wt9qdElHXxALc7rf1tu2R8z8K1jrniA0mDixS+EDwcJXd9r?=
 =?us-ascii?Q?cc2Pf5E5Tf14xk0/PQgqrMfSWUVUEFFhhe8ZEzl5xSemX/s7LDVopTqEXHbA?=
 =?us-ascii?Q?DX92S5wDNweh1+AGqxovYgLUkx0h0+Ov6gRByK3dTJfL89csvVs6Rvu3Yk8p?=
 =?us-ascii?Q?vcJOyRZA7Jszv+F5MnGFCZDaq3vaPr6w2v+gR1vt++I+tS3fxgUuPUUAro8E?=
 =?us-ascii?Q?tSxiEHRnhbkvkBJ8qp6FEgaqfs+PhhdQqeyvJUbsfjZ2RuAXEHjJ9Citnr82?=
 =?us-ascii?Q?Nv5mn5t+HF5PCGdJOlRqTVp1scDF2a59Kt6Of158k3pjFQU7j2fTcH8Qa6Rx?=
 =?us-ascii?Q?Y7fszll7Ipv6BLYy55QBIwugA7cWPucM1DkIvJ90IqWiVq+6nnQZrbMukxj8?=
 =?us-ascii?Q?gluir8dPcBYSy2EXWEuqzBjD3cSjKqQ6kAASig8JgJd+vQdVs11W+atKGEzv?=
 =?us-ascii?Q?ZQr2p4o/529f8RHs5RIb6+w+QJhX/9ErMMVqbmkpGUPK8iZIP620aq01JHo3?=
 =?us-ascii?Q?C0Fc+w54HBR7QP4qXQfVujzrd6mgE8aVtjrqV/MRzkMOtY741wj6be32ikKI?=
 =?us-ascii?Q?pMNR0ly4YaIQ1dy/3XTMDAPQl3WXBaDZszs6pxQOirlw4I/RD0HPRWBrHXLv?=
 =?us-ascii?Q?KkPgqhxTsr3Mt6ruFQKUPPhbLS68nbh0PXmrLKGrMfeFphSFA1M+qwpt2y9q?=
 =?us-ascii?Q?JdHvp5LVxh7y7+UsGWSW4ytlDN/1BN3XE9WQ8u70q67CnhwT72Zmo07SpuvX?=
 =?us-ascii?Q?4uDc0K2XDqOvUEfxlDm05B3jK2tyMW4dY13XCa/saVlpddw2mBDEpP7JC02z?=
 =?us-ascii?Q?UefplwMg2WTzDiv5ZAsTP+amfN8T5GWxnM/OnwDJbs5G/eE5sPIWz4iG5Dvf?=
 =?us-ascii?Q?jiyge/5Mc3suW1XO8KEZQtPBnrktAWqifKzx99Dju0QPn9apkompV3+H3HQi?=
 =?us-ascii?Q?0iHFtEkEjxbaemRIMM5/8iJjpKmlq9nfP02LS1Xw+FsWF6B3cMn01kXGEgrx?=
 =?us-ascii?Q?UEGkRVq6SieRKRF78zlNyymjrhRmws1vJkHcTGzSbGOp925XMmKMdR403ylQ?=
 =?us-ascii?Q?xI3nrCM0UAB4tq55vBq+sMV45NbIXtYv3ss4P7gN/M9Ez5hPe13fSrcsbx2x?=
 =?us-ascii?Q?xgru7TpmHjfXKH3/3oQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb30e24f-fe81-4c39-43f9-08dc7a64e47e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 13:41:33.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ydrS6yOuZyFOQ26o4F1pA8lfKdA/A+zB7zPozfyDZtCjuYtTffunIuowSPKwrHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391

On Wed, May 22, 2024 at 01:26:20PM +0000, Shameerali Kolothum Thodi wrote:

> > On Tue, Apr 30, 2024 at 02:43:08PM +0100, Shameer Kolothum wrote:
> > 
> > > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-
> > arm.c
> > > index da6cc52859ba..20ac0e833c7b 100644
> > > --- a/drivers/iommu/io-pgtable-arm.c
> > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > @@ -433,6 +433,8 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct
> > arm_lpae_io_pgtable *data,
> > >  		pte = ARM_LPAE_PTE_nG;
> > >  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> > >  			pte |= ARM_LPAE_PTE_AP_RDONLY;
> > > +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
> > > +			pte |= ARM_LPAE_PTE_AP_WRITABLE_CLEAN;
> > 
> > This seems a bit suboptimal, it means the HTTU will be generating
> > dirty's before the tracking is turned on. As I understand it if the
> > SMMU wants to write a dirty bit it has to do an atomic RMW to memory,
> > so this would be a drag on baseline performance?
> 
> Our initial tests has not shown any difference so far. But it is a possibility.

That is good news, it means the setting is quite low overhead

> > Should this start out as dirty and let the enable flow clean it to
> > turn it on?
> 
> Ok. Just to be clear, so the suggestion is just set the DBM bit here and let the
> read_and_clear_dirty() set the  AP_RDONLY_BIT through the iopt_set_dirty_tracking()
> path.

Yes, but it would be good to check with someone who knows what the IP
does to be sure. My guess is that should avoid memory writes.

Jason
