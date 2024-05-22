Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0813D604
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381570; cv=fail; b=YSO4ArkRvYKDpzf98Y08gwenpS2yQTMgYGWs2cAFYROFtn3b217SxIcjqUlL7bY9Y5FTWEITi2Xu0gP2/YLFF0XZRQOLuJ/8PT/AFQSQgs9rpMp2hX7TyUUNfbhcRyqftDeTVMQ/ZqQA9hL7LJBFD6hc98/2ZW2uhaFqdg3i+D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381570; c=relaxed/simple;
	bh=1oKGPxiJqWpPxJeMFb3U5/1ye1fMXTGiJO74ATmflzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=npkBmtahwxFMj8toQEWbMe8jO8bOty+e7Hu4Bbe0hK4X96Rc/ALrenKcLO6A1pz39vRYJ9NHmBfuWTms3zCTFbPlU7IRITC87HLnADq+MC96IHe/VDsH0RwId9mRMBZZztH1a1t3pu+fojY3YWk0rbFjIregweKrotCDTxvgArQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T/bcSlYL; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T/bcSlYL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2/ys3ex81+UugMxKF9kyxqman668gCeXqtCioIIjtxBW6UThCUz4wno3GS9938JnzMPe1vtXyMBlpVFH+C3tCKbmmNqi4h0DTwayfXCTlQAk7Ai4SaW89dj1YJU/A4IowaZ4JG/qGkaP/NJfaT/hYGkCY7+9IeAoD0hwnMtTAOHOciXywZrlQOnnJLlKl0y1UHeQ/E/Kf/tKPKYaDsOc93JZvpKAZv18JqVPgoJ5wgCBGxYwQjr+W4YiTclitQ6rbBakPFnYZwW2wC4cLiKnpeK5HnGNRuk1PqqQNlboadH7mv/D55+6wQ2kItrQX1MV2p5hmRrmqzGECExZD6tAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsYPqEXLf3ryO+rTb2EGmLyHrRAzDOkd9tpcxEOeCDE=;
 b=ReA8qtxdWdkQ/X4IMPjsK6cmJW7xuxJqMuufuuOiL6p8BzhqQiwnoe6MbaE3HlKUbTNL8YknN8tPNMEOMwAdz2+5zdl6Y6yNLwqrNdM8iX8JI5KlMZeBkspLNiFg8zhW3zMocbVdrbRjOV85yHbSIKxaSLFn89MmHxbOSHlZSWrZ0Qfm002qZBS2pcqTgjcUomDzyTkvQVuTh+0vpsKP5II94Y+gjYFcKAmd1QCke4myloFJm+Vfzn0vO5WkZW/LAG7Hu6BCDf7+Tx/W9Cu0cuJJa0RYjEQUMkeCkLRocwagbxPclOnGbf2yy7/s1PQl3w8B1XI5DFaZUsTcIj4OLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsYPqEXLf3ryO+rTb2EGmLyHrRAzDOkd9tpcxEOeCDE=;
 b=T/bcSlYLENn0YP9EFbtL+X/YXUYbqXFWreWChzwmA0HVUNak8BXTD2tI9EfwVoP1wOnPAovnb/03xi5rhoqh/FiHdRgqW3uyBIdXKUmJoQ/o1ep5WYIdOX9Lpm3hk8U6awwN2XvClvd2LmKK9hAQNygPgB3tDOxq3YUJBzpDHQ384ZK8wn38lQj1x0Q+9N2x3nauR79JR14lg5GxjvJJSaaeYCjv5rbyqot9t2G3Rdag2jwPiBoarw0rPfsXDrL1/Aiq3H10RwgS8zSsWW1hnDgJwau6WI1dsr25qhlw7lUHj8nVTOqTHUOv9m7hv09kq9M4FT7vFDyJMJuLcuCSjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 12:39:25 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 12:39:25 +0000
Date: Wed, 22 May 2024 09:39:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
	"zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Message-ID: <20240522123923.GW20229@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-5-shameerali.kolothum.thodi@huawei.com>
 <ZkCxTWbkK0Domuwr@nvidia.com>
 <BN9PR11MB52764A677C40BE74610444D38CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764A677C40BE74610444D38CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:208:fc::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 47719f28-ee6a-41ef-7827-08dc7a5c36b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iMlJGq5U5uEAUD0mE2mlklZPA8WCW6ikSs5sILVNsf7FVe9cbMgKOCPLrUdL?=
 =?us-ascii?Q?3zShEQvYMfo7mo5IUKxRMQH/P5vgLNZqXVArW4cAe6rJrM3VEwJw2qzD9mX3?=
 =?us-ascii?Q?8hzndsIiKRc+/Wb2HBRQivCpGMJzeE2lCjEPYgWeA0bk41UMceKcFGXAHNDx?=
 =?us-ascii?Q?5nfSRpa9kmK5yXeX3X3gyK3+gYPVKuV3uCgHP2Pyk4ZYak27idE63OmOL9wI?=
 =?us-ascii?Q?TOyTxzfZYU3d0dQ+LMo0kekrgU2yBClT5ZP00DvePBXHnUYmDGDN1ruIlr5G?=
 =?us-ascii?Q?Iby4aBiHU3YjVfYkitF4k0/HUwpCN/CxWdS940n+/Pj8MaYDWf/X46zfhJlx?=
 =?us-ascii?Q?uVCbKnFn+on2MJqsQ48W/C3eXxb9IXpPCkWlePlbkJe1ZaQFZFQl7XSdaTde?=
 =?us-ascii?Q?giMTt/cA4XhBUpIHfMHcnU9+Nf0Rih3V0cOz4+W5xBr3B5EDGjwxQrhPRoue?=
 =?us-ascii?Q?2j43257cJljmSwoEieNmu7tYL4pu3S6R7JpcKiapXiicGrR4iqEfpil2Bc98?=
 =?us-ascii?Q?k7wFuY/RvcYmOpP14Oo4PVVATZyd2A1koq7Y7xQA6FYUBXuWIyBan4rtFEhd?=
 =?us-ascii?Q?b9qqkDYOUDr1PTBEit9ylt1lFtnl4V49JFEqifdC+gsgjDAV6xVrCvZRpr93?=
 =?us-ascii?Q?hReoJ4WyTzg5YsM9WeHgXVCQXl3CgQCK/LQnG2/6cprZMLOLdndm003lCU0S?=
 =?us-ascii?Q?N0nljeIf8+ujijrOiYOsZeBl/sNMmzRN01Sj/dpKT0NNzCk7Z9jSGUWysUwD?=
 =?us-ascii?Q?/JGtMgL6S3Y3YcVDqniK6/SKFGbdumWZsjxdN0Qaqr3BwKitOXw9Kfss7v/i?=
 =?us-ascii?Q?yM2Y/XFoiRW3zIdM3A1IrqBr4chQmWlBI3+of1C2jwbLSV75F58W6DeDYf6q?=
 =?us-ascii?Q?UbO4apOus+u/czEixoVRzFeHbPxeBmfrHPlw9XtOj00bQeL8euuan5ovALuu?=
 =?us-ascii?Q?KqBY0VBDQeg6FWoKObPmwXM6pCYYG4kOEvFS/fMnMwQzux+JL01wrlluu/No?=
 =?us-ascii?Q?5d1xOiGJZpVPmFyzXRvNFVi6S8fg2uiomEFStDsvtISf371mimvCaOeneF5g?=
 =?us-ascii?Q?Q0PvvksBx6D1WCUPn/L73boZmfPw86mfTkAMK3EiOra4Zfu6J5md3JpHDvr+?=
 =?us-ascii?Q?7QvXZCPAWj7RJKzi1dmietZ8Z6hV8TvdxAn+xLEG4i45d0xTllk+7K4ds9MK?=
 =?us-ascii?Q?l9kyfRKUJWr00I+24Xo8Ep69LFp7H4HGtt6XkRCQfwT7PDnP4O+z4xTC7Ju3?=
 =?us-ascii?Q?MbqEg0w1fcIzcjqDn1VVMTBJZ2/p+M2kvUgN3QL9IQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHuqBOU7/oWR1rbfbYg1GreIiJE2TqEkA+07yoZudza2kBPmTTkVKA1HUxDH?=
 =?us-ascii?Q?I+DK4tZ6qMtuNg4Y1IFDH/Hw1hQMzMracyy8MhD4UY6BdRXr4sn6uNJD4dqA?=
 =?us-ascii?Q?AwIPO/ZAsMYXDNsryTNCKkgn41mGhsneINFJaZASsbpgBJ0TfxN6njrxuk/z?=
 =?us-ascii?Q?LCC2hg8YoEl3fj+3xoTQ65pdyDs1Q5XtutfGF4uwPMTluGRH7k4JabIwRKhd?=
 =?us-ascii?Q?DzAQN6JWVa2UrlikJXPBKoJu4mykY+2CcWZTZMVzfHssmfyNeWSU0pYttJRN?=
 =?us-ascii?Q?X2K7tj8PTSEHCD5FgzpQAkcTmi16pOD4kpiA4idycueEna76jQpZ/lEHXkmI?=
 =?us-ascii?Q?CPqwJJaeSfyEFxdlVS6mLxKqZ9+8RN8Z4CpdVUs0C04egxQDIKOD0gJdBTVt?=
 =?us-ascii?Q?S/5LdC95+ADTlbDIVX5UMEHZarCfhfNYpcwy9yyODTtJHLXWvciCo7y7HAFo?=
 =?us-ascii?Q?5cxmFo1XlxRJY2h+n6pq2JjD/nuWjuaySeWCcDYPn+lCkE/EAJNmaKTEmv74?=
 =?us-ascii?Q?p/lwW7LinqZfvrNtZ85ShkIaZR3AQZgRpCuq2Rl7xMZt6Z1vhWde0DrBMZ5P?=
 =?us-ascii?Q?OT8IwKOCoNKNsQWe5952ZoxaSfbxS8GfELe3I3HqTVlFTGkfmH5lhK4XA4Gu?=
 =?us-ascii?Q?caDSwPKHNt9ObxukXlm71MO7RBCJrgG3BhTon2fSmgbm79rvlG5aJVk3GqPE?=
 =?us-ascii?Q?gZvXQmsSu8/o9H/DADlYddI4GbmDcViy42ELfhTFeok2rnFi689UEl1a1yTK?=
 =?us-ascii?Q?+YeQuLrM798HxJD/4/RilNNtU9J/njwpFm90kAwiHnQK3Cxtr3A3qrCfDeGv?=
 =?us-ascii?Q?nPGe7LqX+U4tr8Sb+ZhDR0Kkb2ply4J8S1yd8Ng+X8qGxVjgg3vCVdhEMGxX?=
 =?us-ascii?Q?7RCRzsaa2bFTAqIYJ/357izV5Nm55blWPP+4+zXw4SwGSpErp5wpCdyD4Rha?=
 =?us-ascii?Q?dI//I7Wwo0VVor8gaCH3gRrbKnekLQi6Hkzr6r8tXCxGVigOriKaBhks/65G?=
 =?us-ascii?Q?GqcgEahWIyrIZxNfWVB00e4dPnn4NMTYN/C8BaOPq8BwO9iPMwn9u6BX5yPq?=
 =?us-ascii?Q?zj92+1KM1+lmWXfTu1RkDISonUteYldo/FIkFcR+I3NSErLM6l/ZAxI7I834?=
 =?us-ascii?Q?0pXYS65oI801qRqnsmnkVddy3by0btxZ4sui+hTOSHu+0tcx20PbzMuQZf9p?=
 =?us-ascii?Q?WTnXZsBS+PR2jKkyN75tjqfBi+d8f36oqO6fdskyB80WlmnUvPQTdbAUoZ6z?=
 =?us-ascii?Q?C2ADFPy0MJtgjjS+rrE1nCIl0MUZzJZQYm+wcUAvm3Ecb06PbHVrmsjyecsz?=
 =?us-ascii?Q?ktrodC3oRE72QahL/vPrHrR8tbOqQ1tYCAWsTEw7xcy4uNRJHc/dPNyNuFCJ?=
 =?us-ascii?Q?b3HKYytJVfoqmUZifTzN9HJb4m5iO8FARUdjZWTrNGhgVAbnOEhaxE0SDzxu?=
 =?us-ascii?Q?+qZ6IeDUVBbbbFXLnK9Bv5VDYFsw+csmyZNOCc2il/JPaIPnvDZCpYX/A8um?=
 =?us-ascii?Q?7ytk4m/oDJiJw5mXOwJKmu4SYVu+bwQpA0R4oKKsxn2rMXojC8w10IuaDjAg?=
 =?us-ascii?Q?Mp4q7x8FcuV/5i2EM08=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47719f28-ee6a-41ef-7827-08dc7a5c36b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 12:39:25.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9k1HmZMNkOSFo8XUKJJtUGT6cQD5C7d6IgyQhkMfourPq8yx23J1JyUONi2eGRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

On Wed, May 22, 2024 at 07:19:05AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Sunday, May 12, 2024 8:09 PM
> > 
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
> > 
> > Should this start out as dirty and let the enable flow clean it to
> > turn it on?
> > 
> 
> this appears to be good for other vendors too?

I thought Intel and AMD both had a per-table flag to turn on tracking
and without that bit the dirties are not written back?

Jason
