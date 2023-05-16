Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23F34CF9
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 16:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDNdK40ozxlKHRI5Of0iNbHRa8+FZtG2AvjLI5jE8oGA10ItmPJQCTwUwi+6TESNtAm3ef7O+cOKUu+F4sl8EmqzxPTRuy+CtCJuLsqaJbD20hi6zra7YJLWUTX9AWocw6u4G2bydwWG18J/6ixFJjawFPRWZsrKT5uGxz3It9C9eDcRNOvzITNbZcHctP4EyWXiGTgXko+aSf9c9Yp2qaqESIhDrQBz4FsMd4d8bdP5p7UnLxNQ/5DdMhbWOBHWPvCbkcwE7Ow3CRN9nKU+LIVIcj9Ul7oyXXnZcFkkh6iAcp1mrGJlWwyF6PkmyeC/+Q672RMvtFydFKs8VoXUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW1SvQeWYRdTJYBZmSh/xwArBeyTRnzQuHm7hjccvLI=;
 b=Y7qiQdmjvtjqodk4Mvi0UnIRKCgnNs4Od780QfTN7SgISQjv2x3MvLawR8U6MhBoP1N5+o2wbCeS3ntV24Aqr44/gUT9JtwOPGmQxeJPrPHPSYrsZRNcbx8EEKPZWBr+sNrhqs6z5pdMGfGRNTYucZygsQI7J1oqW8yAna66QEeqOvjYgqs2AHLeH83ZrElZIO1rHYSTP7/TABUxVU4s6uokXgHT5vNMi2gVDo9+pvvCO8YzLDsWl/WHn3psCz08M7ZC353dhXHLkdTPVRdXzqCGFn+dE5xNssRYmHlX3MSaY8JcbDoU9f4SHxllHOFpiCLHrLh6Cv8KzCmJdaF6sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW1SvQeWYRdTJYBZmSh/xwArBeyTRnzQuHm7hjccvLI=;
 b=qmGVFK2WSzUbG4JnwdIJvOENO0I2ygsFPGKt9+KpfBo3tQpubC0lBjQx8f66A83kVXN+LIuKYeMQY97OhgeBr+uNL70Zuq16Pf5mRTcHu49SdXb9pF0TNUB1X5xkgcc7LMJKhcmIOeWeqfYYOAQEWeyyfh3926H5vh/MPh96l2RRnf1bxXFPu2TDhw3dh0vIxpKbTNz0xwZYkyF4saBycfjJtXWP7HHklMzEM3z+Y7tc3ndIiE0leuc5PlprNATGX3j1uDvpAWOoCBZwXce6CJqV76spHAVCXAfMKCRPvZYvWMvvqXqhjomQsUfQVKG6oErfwEk0CJ6fLnA2HEW+ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 16:09:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 16:09:02 +0000
Date: Tue, 16 May 2023 13:09:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] iommu/fsl: Do not use iommu_group_remove_device()
 under ops->device_group()
Message-ID: <ZGOqnWBspvDynyJ4@nvidia.com>
References: <1-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
 <33b25946-8970-6711-41a5-8b07ccff77c3@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b25946-8970-6711-41a5-8b07ccff77c3@arm.com>
X-ClientProxiedBy: MN2PR01CA0054.prod.exchangelabs.com (2603:10b6:208:23f::23)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d340364-c0a4-48a5-67b8-08db5627dd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q0tjm/BfOjXfUPiBIGEdL+YPLQiCsZt0L8p9rElroF4F33Kq34bJBmXrWuasryNpvPqdZIy6M2x3s7+b3FsGBok2CanmJLIZ+iHnVrSXCujVpblVDoNTdbky2eAuwprxsPWRFvmQzwK+JuGQ56Jcl2WFSrXBbFTa1tX4nXyDCHE6Y810c7rXa0l3PueBKv6urLLkaM8Sh34nNXhTCbSDVZjsVwICutIHvRC07g+pZJzZjkqksTyMiR1M4Lk9MDiqe7oaepS11dRj6PtPMyRuGUkAdwLhmY+3p+ZT1FZSpajTrAMvBaU/FbEKpVG7u4Iet18k/Ghv0sgCY5Z16z6VHdd7pcf9jqIfvMCDvBtWm8G0Y6OLWuriZ/X6LcrBi/AegOwwXx3Gw8msO+swSlpsbV4PpAVC4EAY462uPhj2pZr9S6qOgN5NGhge5n1tLpi9pA9oIrM7PJbOo3xjuBmDo01tAtC4HQRGimIsWlqsaa+3H9eplXX9uZ1saRb221Oe4gh8CcMQn5AQ/Nk7kBT+sKQBjcFmY94F6hWSYfI8Qs5NT6L3dD4AW++GLpoc26J6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(6916009)(4326008)(8936002)(8676002)(2906002)(86362001)(316002)(41300700001)(66946007)(66556008)(66476007)(54906003)(5660300002)(478600001)(38100700002)(6486002)(36756003)(186003)(6506007)(26005)(53546011)(6512007)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C1jtNOJloiNL8durrhIAfp7XWtmLPsC6KK+9n52bulYEDuE28ITCf0hxNxoe?=
 =?us-ascii?Q?+fgFbi+tTl8Yks15xGXeVYw+P1W2RqU4KPFNqkWla2hjf0FO+a/KmHSx2fIn?=
 =?us-ascii?Q?J58fFiZn7fsfLzGhK7fdccfBMIBOuQo1MW6/Be9YjGY4TpxWRJP5DrNWoLSA?=
 =?us-ascii?Q?glkhoGRkeU8QuUNTQgUk8RMdDJoVAmtpxVkChBeQuitOSL48Yl2qSu/wsXBK?=
 =?us-ascii?Q?dFrp9iPIHgCiriHtkDGZ125IaPcF5wADYHNL2Bj2ztW9gntDYmjRi5Kxh5fz?=
 =?us-ascii?Q?spGXrB3utDHuBcf3xJPPKVNsK+AVtzGV25GbrURgXD9PeANPblIajgV5fR4y?=
 =?us-ascii?Q?3sjz1EgnQZuexfzZBeWKZ7TQ7RsWTmILLfbKna3zauLuQu5Ap7v1/03COqAZ?=
 =?us-ascii?Q?k6J2UwGbaC1j8kwggIa/G2CWCStGL6MGKvzauWS7g6nUeoxkAFqfB4iMTYcP?=
 =?us-ascii?Q?BbIvHx5dumzkraEUkTaf7BYlRm8jKq68QPtpsmsaBMmVkvYWxM/DCZPJzGd1?=
 =?us-ascii?Q?68nql4X2I/9L0g8kc1AUiG/52+LvV3OBPnZEOCXj11zTyP5i/MAVS/zXcHqm?=
 =?us-ascii?Q?qxYbV/oCbNcTGo9JG+zDQwQM9YDt0zvNJ69yD7HelptPlz50K5kQnz8ZEspR?=
 =?us-ascii?Q?iMDhLydQBp0dz2TPFUt4TCb7/CXEbs+L7xR6aLbCUhV6+86BAV01sY8s6DIn?=
 =?us-ascii?Q?Z+nHbgVdAeNUXIAOH1dozVS/Rd4aDN1X4n1x8t1estocS5AqIw2UPKrQfK7X?=
 =?us-ascii?Q?ezDG+jfSq7JJZPyD4AOKyoOxJumAFNtgLCH3jlwjhR/Avq92XdFw0Q68l6ft?=
 =?us-ascii?Q?0OEE114Jw50/mQPuRAu1otvDqrD4XuHvCybjpeQs4unBmO+g69Fz2enyRiqa?=
 =?us-ascii?Q?uncCmxiD2gcl1bIjJPtghCM5Hei39Wy0rshRElnQwcUuIZNP7NwReW8zrbw+?=
 =?us-ascii?Q?oqNNzL08kj6bh584R1uzyo5xQlOMBZ8tknkpBj++f6yZwtBjwwG2BM6HJyyK?=
 =?us-ascii?Q?3jI2WYmbMUtZYDcd21SvbBIAT65P6/fjPFVe9kPBgS0ME2yuvcV/vzuVliNy?=
 =?us-ascii?Q?kObFXyqpUA0bqopYLz59h3OjzG7H38aKm4EL6HB1KlKMOLjLnXqGgNrDqOg4?=
 =?us-ascii?Q?ig7yyXPL7/y+niSC4rbQgOBnXO/v6N3QjkbrdZBgoTfz2/qkpz/zgX+8IRkr?=
 =?us-ascii?Q?cLH6llaQLcp1Cn+NsioZBIK3a9EQ/r/I/lIVXwxN0PcEDCBz4AUeHom6ZfES?=
 =?us-ascii?Q?VD/9sl+J+SgCrMubnMk37a/coTB8a2P3bZPw7MTpf0zqUDM3NNDrsWTHazDp?=
 =?us-ascii?Q?GiBpF8bJ25OT1t/WoXyi/Hy29u3ldwzJrZGUWpJS1nmaUJPcyKzriL1QyDPD?=
 =?us-ascii?Q?gAS+c743WW3j/Ot4X96cKk/4wfYEq18QLiQyK1uNVpAjzSoEHdhnhiDBHMwy?=
 =?us-ascii?Q?YFJbsXA9DUwSlDPT7xNikVki2JalMbSMaDdeW1FmkB1P7Tj87yzmOK5UpSan?=
 =?us-ascii?Q?sMHvctUbou0/7QNFL/6Sz/T+YDDoSKu+TyzCiQxxLWzEAJy1KdoXuhRxTI3N?=
 =?us-ascii?Q?TlIURBQbtAikrlewh6AaNAlLkv7vF19x7zcXxvhe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d340364-c0a4-48a5-67b8-08db5627dd71
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:09:02.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOmMJGiInitO9+Iec7cjCJNq3A0MnJl9FYHalSyEYfrrt8V5kAAnhWDfdV0RspSD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291

On Tue, May 16, 2023 at 04:00:47PM +0100, Robin Murphy wrote:
> On 2023-05-16 01:27, Jason Gunthorpe wrote:
> > This API is expected to be used only by POWER and VFIO no-iommu that
> > manually manage the group lifecycle. It should not be called under
> > ops->device_group().
> > 
> > This is already buggy as is since the core code does not expect a probed
> > driver to loose it's iommu_group without also releasing the device.
> > 
> > FSL seems to be trying to block the platform_device that represents the
> > pci_controller, eg the thing passed to fsl_add_bridge(), from having an
> > iommu_group.
> > 
> > Instead of creating an iommu_group that we don't want and then later
> > removing it, just don't create it at all in the first place.
> > 
> > For the 'pci_endpt_partitioning' case every PCI device already gets its
> > own iommu_group through the standard code, so it is unclear why having a
> > dedicated group for the controller could be problematic.
> > 
> > For the other case, the controller group was being used to bizarrely
> > de-duplicate the group in it's hose. Instead just directly create a group
> > for the hose the first time we encounter it. The code already searches the
> > entire hose to find any iommu_group. Again, it is unclear why having the
> > pci_controller inside the same iommu_group as the PCI devices would be
> > harmful.
> 
> It's harmful in that case because it prevents VFIO from working at all -
> even now that VFIO no longer rejects cross-bus groups on principle, the
> fsl-pci driver being bound to the platform device would then deny VFIO from
> taking ownership.

I think that was true before..

Today we block out VFIO based on iommu_device_use_default_domain()
which is called prior to probe. That function is a NOP if the iommu
group hasn't already been setup.

Thus the platform_device probed by fsl_pci_probe() does not block VFIO
any more, even if it is in the same group.

But, more broadly, we exclude things like PCI bridges from the VFIO
check by using driver_managed_dma:

index b7232c46b24481..6daf620b63a4d5 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1353,6 +1353,7 @@ static struct platform_driver fsl_pci_driver = {
                .of_match_table = pci_ids,
        },
        .probe = fsl_pci_probe,
+       .driver_managed_dma = true,
 };
 
 static int __init fsl_pci_init(void)

Even though it is a NOP in this case because of ordering, it still
would be good for documentation purposes.

> > +static int __is_pci_controller_parent(struct device *dev, void *data)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct pci_controller *pci_ctl = pci_bus_to_host(pdev->bus);
> > +
> > +	return dev == pci_ctl->parent;
> 
> If I'm not mistaken, this is testing every *PCI* device to see any of them
> are their own host bridge's platform parent...

er.. Hum, yes... How did I miss that :\

> It would be nice if we could still associate the "PCI group" directly with
> the pci_controller some other way, and avoid all the slightly-confusing bus
> walks altogether, but I don't see a sufficiently clean way to achieve that
> :(

Are you Ok with the above?

Jason
