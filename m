Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282918C34;
	Mon, 31 Jul 2023 17:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2HMEIPXRWHXnmFG7b+UOOBtu88drkaOAzsoS+gvk/YP5dU1fnREXf48tI78y38nL7PwCP+QXn4SR5q52YGLaTvJ4z9K8r0qusTI2Uei+m3n+1UmhsjuMgl5yLvw7Vf+BgjihLruvth+EdtMyfL/JWXr2DB+RUeQH2+RzbT24lwqKlm71qpMAwEUkW1zkg/LV35RVfCrb9hFw6zdfy1ys42uiBEENxWhwiZ4g4m+8eQ+Z9JdZaNUzf6hQWW8q/mDkdDRo42120NXHle+bbbohc9dZ6xwkx76sTvPVKby3GMymyucH2DJPHybV17Jh2MyhomS9mIMKir9+78UegsuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wyhbk5va218DoPtymtzpXj65Jm8E3ndEQ+y3/M0iGLc=;
 b=bu2o+S7KHT1LR0yH1e7bnJKY/D6KU0vGLw1kk2elgp3gEekEPhFEIenCersSjQm6PJqcncIMNg/PGdZ6SO1VJHEr3ykxk3On2I9YqBL8YqbOf6zhBRDPn03AImq/oZwIeNNlvHmzqC9qhEeIaMAhEC6PJD7/blQycFiZUDYNmOdfFyyZAWx1r587L+eMEuJy/7mfvYS64h502QO52hGWXitDM8gYnTyYJSi6XAf/st1eoE5PE1yEuQwWEJpGR1OviQ/nbBD1BTAw4VT60pclUoOrLW7GpeJiPG/qigLdFMqhHsy1PHWFHhJ4g9JJSqlb5W+fiFncaNH5O/Oc9ui/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyhbk5va218DoPtymtzpXj65Jm8E3ndEQ+y3/M0iGLc=;
 b=Bnpl1hqVnYXfZ6yGOBckMo3f6tAN7brJkPt61fIbe2TX8rzAgXkmT+5lRWHprNtt41ZvJ3wRdm8A7RL6U3Iqe6+akIvCRyhHtMgy+FrCZgx4+zYy1PPVAEWA5fRSfQV/JHid7aWGIvOKl6ArDktBSMzKMXqOL1cvQcRWpsH4gHBAsA9t5LczeMzO9knH+Tkqje3K5O383cncONCnovtvxRgW0+RDM2lMKRa/qS0bc4UfRLEDtCseGuyh0LYxcto2MtZBlOCY/3763vFJG6LGZunlPl2Tm2CZpxBEi9japcXA3CDYVJ6oi16gVQCXN8C4W25uMHSGlo2BilvviWEEkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 17:50:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 17:50:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 00/10] Refine the locking for dev->iommu_group
Date: Mon, 31 Jul 2023 14:50:23 -0300
Message-ID: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: face7454-67e1-48b4-d369-08db91eea44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZN89sLaUSVt1S+vJMg/GBkwB1tLR1DXjKeiZijkxcillopu7G01lc2e22rSS9VB9PM8chHyXmv0FA+3I2zd4bHh0FqYI2TYGv4yrbof60UeJXGzoxXjiaVFrP0xBCeve5rEbCGw5zg2NPfO6QhDOqSfh1VNyE8c/1Eor8dPGaFwiLY84qevS384UKnHe93WHvEBo3cjUqEaJGL5rQYUy2KthWUbt6DCz9D0Thh+JAPbrIIMzcNHghQVRI1bcNs5oCGVD1icMFSi0AhYJQ5vOHgFDhtWHfOUTehPSgxrHuqD5LeSRtQx2b+DjrF8gx7E0m646GgChBliE8IjR0mferEvggHHRsNBJT0rBrp2QbxHAERJ9eT+JRW/6p+qystyv7RO225k4tKCmVWn21n+K3q5PywJ3eZmyKfwRl8W5RQFaQMWB7MRwyGa3OVy7wjZ8on2a23BZDeDQ3j4bhhWHsOvzHR9Jm4/SjNcKW2TuQHVfYMX1MWu5ZblsN8ENxmukduShrhhjyoWIoQJhnRFrVnzn9SoV2tLcA30zGvIMUvSpKRGkz5cn0xKkpdLV6HYJEx7j1mNvG+X7JOmxr1pMrwVXDJCnNvJACxBCYUPxqzAqQUjy4i9D6q8eEejs8hMKMe3WediIB86CayzsOSF3weRtnh2VkOOOLSQh7hETiMSfUloyhzbKe+1oxNWmIRwr1LJQzKcNrhi/K81hpwdm/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(966005)(6512007)(6486002)(36756003)(2616005)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(7416002)(54906003)(41300700001)(921005)(110136005)(38100700002)(66476007)(86362001)(316002)(5660300002)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPwY/VgkMqsFCbgAUY7VRlddkFNjaZT3PzclgpLJ4BqW5zI3V/IPuaH2zJgA?=
 =?us-ascii?Q?nHErnKdiPJb+Dw8tU5qfqPrm1DU5vz+43pgzJkhCklk0nlW+2N+6A/aKa/H3?=
 =?us-ascii?Q?fLS2uAZAkx5HMia2RMBpYmPGSIiGGdoc86B9bvGBq6ou4EP7oswEpcMprhGt?=
 =?us-ascii?Q?6DWCB2fAnIyOPqbNYh8cacfKk9106k+vPvD9GyCw+OSzCILsgMMRKRjPKLUm?=
 =?us-ascii?Q?8OeTWkhmBUyyWQJyz20KacsMSJctXpLCUWsngDAuF5cG5Kt1tpSl361UsyKP?=
 =?us-ascii?Q?Uj6/gbKJhzPAvJouXGZ8uZKZ5SPQwzuel3ip3kRyL6UAuk1MIXbpca2ATSyn?=
 =?us-ascii?Q?bxRpVZwkpC2W7XXlgFZLt+tQsfZvh/zKcSj4myJJti7QucSWbpPu7sYsZmjY?=
 =?us-ascii?Q?fBgVPrVMo6gHLeS4vfmSD3NlN+tR2cNBRc/ADq+ekN92HwW7+tPCGZv9Fg7+?=
 =?us-ascii?Q?nJ4yyGNhYqAugNDwcJZ1QF4soy+X6JrxiehcQK9Di4PgCaUkKvw7bzIvzDmG?=
 =?us-ascii?Q?MtftVsUDFD/HtVP8g88JwKiS317asRZ1LU+GOZS85gSI6ilAq1r3bIiDL/qd?=
 =?us-ascii?Q?2J/FGgF6uM4S5cdlx6ikEixHl5nVzph1yOrN1wGTGPTb+LfLUuh47o9Qi4Fv?=
 =?us-ascii?Q?P4OQhbLSXSbxz5V2AkZRrnLCYpE0tUKcoxJUNMICj8XEGGcSs/irs17+90XU?=
 =?us-ascii?Q?GYHkttnXbBFwFqUI2chVvqKZcb9JJydHZe0f97F7AcS20t38MKk/QLFrykbB?=
 =?us-ascii?Q?05y/Z6FVz1o5M0yqChrvhJxRhT9X2Lp4/t1hPVB6bMxT2onkGS7Ck0LT8jXX?=
 =?us-ascii?Q?ZRUYpl82p/wN/gR8HqEOjweX130I4TLGbVdkX2S2wVv85wvdESfHzWiWD8Sw?=
 =?us-ascii?Q?zQp8862qTmbfk9EHh5qDwN+FBROfbpfZ7Hh6i79+0YYpPDn6EMSm0zYFUJ4m?=
 =?us-ascii?Q?36QDR+TPH5bSbRjp5FC/oL34nnqaydAN0jn3DIx0F98AhcZjflqnr4v87fy2?=
 =?us-ascii?Q?DsDPBd8W126aODbt1cB3KGNJV8AMiO/c/HxGEwx85Jo0ZW5oh+tU04wnHgIv?=
 =?us-ascii?Q?bMMRLgFWr6sSBp5qqnzBz4T83ydedoQvPvwg5RPZbhxAie0WCal6ulgU1kR4?=
 =?us-ascii?Q?jidPKfNQMz9KR7lB3KCQ1J9k1b+TeIqUO+nANZgMwDKRzHC+VNsQYWGH1m8Y?=
 =?us-ascii?Q?Ln8lFTOUDUkLcXlvT9dxtZ9eIGxz+Tmmxh+xXCzBbo7z2QXHfoXOSCxS9OlS?=
 =?us-ascii?Q?ALfxjZ4eAqNTMjMuavpPbXkgZ44mkMp58b2JqXakK+6d1lYJLcl3sBYKjW9N?=
 =?us-ascii?Q?k63c3s6IrEM45CSXRq0rZbaVgfw9oBqRPloxzSxZat2Sl67zwA0/OOo27j5+?=
 =?us-ascii?Q?40ULaEBQv1CmGCR4I4GxgtrWbudAfR91E5WDz9S17rmuvBWbnvmojq129dIo?=
 =?us-ascii?Q?uBqcv1MvibyQCx/cly2bgo3gnpQ41faYKWKOc67GYNwXcfTw2xS9sVKEzxh2?=
 =?us-ascii?Q?GGqqua9amIS24zq05dy/I4C0Id3lzRMPazQGU3qvuWQHDZY3XFSygPZQRBGg?=
 =?us-ascii?Q?dUQEScsVzhIjQYpfPzalmVJx9g9C8bwUBbRqBjmA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: face7454-67e1-48b4-d369-08db91eea44c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:50:34.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sZMtMjHoKzy38xPg+Moyx14+W1tlezu+216+hi2XIW0gRrRRG4M1Nu7wK1YGz1l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

This series puts the core code usage of dev->iommu_group under a
consistent set of locking rules. Currently a lot of places in the code
access this value without any locking or READ_ONCE/etc techniques and it
is not clear how or why this is safe.

Make it so the following locking rules are used:

 - It is readable by a probe'd device driver. So long as a device driver
   is probed the dev->iommu_group will be guaranteed stable without further
   locking. The reader should provide some kind of locking that ensure's
   its remove() struct device_driver op cannot progress.

 - Read/Write under the device_lock(), this primarily protects against
   parallel probe of the same device, and parallel probe/remove. This is
   useful for places that don't naturally have a device driver probed, and
   should be rare.

 - Read/Write under the global dev_iommu_group_lock. This is used during
   probe time discovery of groups. Device drivers will scan unlocked
   portions of the device tree to locate an already existing group. These
   scans can access the dev->iommu_group under the global lock to single
   thread determining and installing the group. This ensures that groups
   are reliably formed.

Add locking assertions to enforce this.

Along the way remove a bunch of opencoded group touching in drivers trying
to implement a 'single group per driver' approach by providing a core helper
that does this common algorithm.

Overall this significantly reduces the number of places within
drivers/iommu calling iommu_group_get or touching groups at all.

This goes on top of Joerg's next tree, it needs the prior series
"Consolidate the probe_device path".

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_group_locking

v2:
 - Revise comments
 - NULL singleton_group during iommu_device_unregister() for clarity
v1: https://lore.kernel.org/r/0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com

Jason Gunthorpe (10):
  iommu: Remove useless group refcounting
  iommu: Add a lockdep assertion for remaining dev->iommu_group reads
  iommu: Add generic_single_device_group()
  iommu/sun50i: Convert to generic_single_device_group()
  iommu/sprd: Convert to generic_single_device_group()
  iommu/rockchip: Convert to generic_single_device_group()
  iommu/ipmmu-vmsa: Convert to generic_single_device_group()
  iommu/omap: Convert to generic_single_device_group()
  iommu: Complete the locking for dev->iommu_group
  iommu/intel: Fix missing locking for show_device_domain_translation()

 drivers/iommu/intel/debugfs.c  |  34 ++++----
 drivers/iommu/iommu.c          | 155 +++++++++++++++++++++------------
 drivers/iommu/ipmmu-vmsa.c     |  22 ++---
 drivers/iommu/omap-iommu.c     |  30 +------
 drivers/iommu/omap-iommu.h     |   2 +-
 drivers/iommu/rockchip-iommu.c |  22 +----
 drivers/iommu/sprd-iommu.c     |  24 +----
 drivers/iommu/sun50i-iommu.c   |  29 ++----
 include/linux/iommu.h          |   3 +
 9 files changed, 138 insertions(+), 183 deletions(-)


base-commit: a5003e75a1714857c01317d04982eef81331fe2f
-- 
2.41.0

