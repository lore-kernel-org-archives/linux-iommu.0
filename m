Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD014C433FE
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 16:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 025FD80B65;
	Thu, 17 Mar 2022 16:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ut3oro6maHUn; Thu, 17 Mar 2022 16:13:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C518F84823;
	Thu, 17 Mar 2022 16:13:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC7E4C0012;
	Thu, 17 Mar 2022 16:13:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33F5AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22C26410E0
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:13:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8GP10c6EYBeU for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 16:13:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04492408F2
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLzN/OhbanPe3vVYMW+8WhCIZxsWgXd97JJvu7Qmu3bNRtUcTEiBkTVlmYtx85rIuKoqYla7glWF9Z3XDor13mpUIMA/guXE52iiOKI+LjgpRDy98Zg8DEQ8YbXFD39vImneY8mFs7bEIrucb4qv44JTuKKUuJSGRpN8qcJLxyl0esgm0hlW6q/MhoAlZwWSd9bSwuKIKznRe5zoid1fswuDINJdhkvaXig1uE98Lz2sK+9pBxwy96GtxNKKNAB4Rt1fy0zRgr9OFe1H5DwgJV53+s+vYm5NMGJZ0qRmCP/hWxiBZkZH9tUp0TCLo7ghXXegVWGceRnYLltKRS4hWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO1YdWsiEnaF9VQyrEJVPHKwnv+MhPiQSoaZvJ3DwgI=;
 b=KagHVo8lhKlVmhfHauJRHMqTKYY5/2u++phJHsNYhEUsrcWcZd2JriIzhdOV5OmWSp2wfeAXPax1YghSCa2H5yj+vWNPDNgg3sYI1yEVeeU9uEpD3BspoiG64w/pRGwP/XysEp+sbcZketzkNiumbkfL9zmAUtZTqT12xW+D9PhmFm8wyeyNY9Nt/Da1riKE0IanRrueO4gfu0OZq9E8FVUcda7Obm1sOHfcgv/zW/yX2yW6UVGP0drqVghwE8Pvp6Y9BJZp+Vj3dRiVJwDzrT3QCffqgXXHEwHOi6Y/5Zw4XJ7p5iQ1zSXYIIgylCV6qBvDqfuKkJklABZnsQUOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO1YdWsiEnaF9VQyrEJVPHKwnv+MhPiQSoaZvJ3DwgI=;
 b=ZqhDBm4l1xIbRE9Wv2qAgM7me4xuB7l9tsTx5Tay6cAFyrOypFOFrzbTE6XqQHXavLDYZHXJKj83wQSW8XfXKLE4lhijXSNoimX+yD9Zwb3ztxg+lyk2jnIkoyedWzDjy69dexdweItitovYEKHhwNJYrcSexP6mMeLv+SjT9cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB0995.namprd21.prod.outlook.com (2603:10b6:207:36::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 16:13:19 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:13:19 +0000
To: sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
 lenb@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
 bhelgass@google.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 0/4] Fix coherence for VMbus and PCI pass-thru devices in
 Hyper-V VM
Date: Thu, 17 Mar 2022 09:12:39 -0700
Message-Id: <1647533563-2170-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73609d37-2d96-4d66-c85c-08da08310cf1
X-MS-TrafficTypeDiagnostic: BL0PR2101MB0995:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB0995005F7E4BE8BA03737FC4D7129@BL0PR2101MB0995.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPxtzWIhT4uj8csDWBf/oPbwaFLBrNKhhyNPkMd6y149rVFqSWTR/OdlVchReScvPk7zh+Vgtw8hg/SO90sViHaF/+XnfJY8pwLp+9QQVs7VyHvR2nIeiwP/Qhjtq3nwB6kA7K1nmsFwIUoEB6xDW4Mn6qImBIX0KGN2wpHszdw3BZEalNvnlAe2D5TKM3wXhc5b7v6AT8Iqvaw6yKCmEGVO86qUisBJaLd5zwgvHioJL/SWW3jCaFAFaFvYPjBdmzYNJRelyKnS+PNa531IjglhkdCZUxyMlatHnLCWg8Zq5dZVG17IKo1AilkG0dqy9dtNutcjBO4rR+/yowjlJkpvPYYz1aF1crDB2OnQl+uZJwdghQfWnrvJqmqM3Y0pNiLqnt/T+SnzgguTZvfhEy3mMu8Qm+WX/wfyzJ2QeyWLJHu15/DToTX6OCwFTCJ1TB0SVfpW5AsflaGTgCClKE5WCjs0aw/aL3Eql7iB+m0gDFg8jlCMvDdNymEr1l/4zmQ5CDogDo9lgisYku20PPp0bqLnJdQFyVcVongUQYq1bazRcC6GaaK8b3hVWs4FovuGFUmXYHlsScTIn0Ly65x74JGxmHh0U902qo0bmlUxvNzmnz7JtSFvBo9hRceV4qlUJQTlnb7iE4RpA9qW949g2ljYC/mKa66GHZhAk4m0XMwY40jkDEOHyaAdSegF3kXV4zy5L7k8pDZXp5mxLfBBHG0tDW7k3E7JKcZB5gRastENzsuaHGptIHuu2mEeByunqRDUffwmv30wBMGGbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR21MB1514.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(186003)(26005)(4326008)(8676002)(2616005)(8936002)(66946007)(66476007)(66556008)(107886003)(38100700002)(38350700002)(316002)(36756003)(10290500003)(6486002)(86362001)(5660300002)(921005)(6512007)(82960400001)(7416002)(82950400001)(6506007)(2906002)(508600001)(6666004)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tZ6Lpu8LrHgb1aJq3omqdCAXMAps5ZKWhCPLtY1Ko2t1fsPWniSEVg73m5Fa?=
 =?us-ascii?Q?dt7j1x5OE4aHYns8PagRQR17htU9KBns8L0gZn/jHp66dy43fl25UYYwIOss?=
 =?us-ascii?Q?uUOQqwY/oWVyh2sIQvDr9rAWpw8YNGjk5Euk7a7/K+/G5A0qCf0Xmh255OMa?=
 =?us-ascii?Q?lV3bachgGKJkicYdcQZPMe9/E7eHQXvcpmYS5L3Cczq3Ix/UQ8JqTLN/ZmM4?=
 =?us-ascii?Q?Wr6x6HkoU8Z43xbDZfhf/3EQIVbG+7+qzs0CxD7kZtEl7UvfU4uQ5NFm89s6?=
 =?us-ascii?Q?5SVPO3I5McJMCBct6wlsXUdHmGixNF6DW33GPY+eVMWcaHgaH7YPPDFoEcWr?=
 =?us-ascii?Q?NZhCBhyJsBNnRZzX6dFuc0+s+ZANcbZ2trsa/y+fp99YgAZYmA4+7yaQgvMP?=
 =?us-ascii?Q?TDVr5ViherFy2ZO6+2b+NN2SyyP3WEsll2o43M0iswZSokZPpObUSdp25Vtm?=
 =?us-ascii?Q?yR1nPfOG8JprGN7HDkB6pef/2bx9sQbSjWznZNNXH5auLYXy/kiJW8CRnA4Z?=
 =?us-ascii?Q?gOXdWYc1pK6NDmkzMx9VnxhOcRHFB8AX15Z2vFjpIlIisGSK8zrEY0vHUTZc?=
 =?us-ascii?Q?gXJKTKoq1tmaDhEWBMPkQbVxRNIZP1M7XfNChTK26cErHFP76D49wXCL6yv2?=
 =?us-ascii?Q?LrvOhMsPabyADcRhJCB5YKF0A26OwzEEtLDycNkfKVQKNpQF6Z22G2HkBtLO?=
 =?us-ascii?Q?KA7QajJl/ocP+tBRXDrDHLYrr051TXYGfVQo2GyVMFQVHcMJqnWU/GUdwfmr?=
 =?us-ascii?Q?DfsNHloP5HD50sEMno8Wo/lV/A7yL37m86ODDcd2aXj91LP/ajVQtM0p5VLp?=
 =?us-ascii?Q?HZOT/hM4ybtTIfc9rRALNY/KqzxskO6xuKrK81Ah0u+GAEuhMvsIyjXZbgN9?=
 =?us-ascii?Q?QKepvWqhApC1P4/cBvNxrhQ5Rimi6WEaSyZGO9L1j+pqc5b0hyQ1b8DajJ1j?=
 =?us-ascii?Q?FaJ0DFPLjLRqPEUWfmtUKK6E1Pe9R4bUtkwgIr8Ynt1otmPfbnIcEnVgdQtJ?=
 =?us-ascii?Q?cKmIzdkHiOx6GE5zm2OgX9g7GEos/GX1srd7ri8UOakUj2UGtaFdNnPNggKT?=
 =?us-ascii?Q?uIjGo5MlL1HXWyZBmh+owCGvZ4HvmKfycAwIS3d3OGfNBGH5rEkQyqHSlutg?=
 =?us-ascii?Q?d7nLaAjaVg0kU/YFbaaKnD52arT1eJTXtcdhh0BO53Ko/C9f1Rf4nAdx6I46?=
 =?us-ascii?Q?rFAFgqqhGcxx50U9YARYtZK9kt7u7CezRJw0cUFG11o5bUaD8rwHFKres+9H?=
 =?us-ascii?Q?c6/M1+hBDudaKB06WkCGMpz1xlH/hZbjCjhQjDnfR2OTmkZ7+zPGdIr2veKF?=
 =?us-ascii?Q?Air6iwr6kjWHpAO8JwuXO4+IXv4PG0mMBMZWkjFKLe/nV7WC3RfrYvTbFty3?=
 =?us-ascii?Q?GTHVj2b7FlChfzSTSHGdrzsNpyCiVdp88lDiJXAGkcJfTrarTPe83NwdVM8m?=
 =?us-ascii?Q?3vyFH10M5S9pl1COoz5HDDbHLnfhuW5MRUdMvFy0TdqHxT5sE7kYCg=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73609d37-2d96-4d66-c85c-08da08310cf1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:13:19.1337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snRMojjKXjofr4oHeNQb1QzwyF8HWDkMxFGF6POyVlxjLxaV+A215yEYWNz/A/rDfbgDwAytrDrqIrjyO5dEiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Cc: mikelley@microsoft.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Michael Kelley via iommu <iommu@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hyper-V VMs have VMbus synthetic devices and PCI pass-thru devices that are added
dynamically via the VMbus protocol and are not represented in the ACPI DSDT. Only
the top level VMbus node exists in the DSDT. As such, on ARM64 these devices don't
pick up coherence information and default to not hardware coherent.  This results
in extra software coherence management overhead since the synthetic devices are
always hardware coherent. PCI pass-thru devices are also hardware coherent in all
current usage scenarios.

Fix this by propagating coherence information from the top level VMbus node in
the DSDT to all VMbus synthetic devices and PCI pass-thru devices. While smaller
granularity of control would be better, basing on the VMbus node in the DSDT
gives as escape path if a future scenario arises with devices that are not
hardware coherent.

The first two patches are prep to allow manipulating device coherence from a
module (since the VMbus driver can be built as a module) and from architecture
independent code without having a bunch of #ifdef's.

The third patch propagates the VMbus node coherence to VMbus synthetic devices.

The fourth patch propagates the coherence to PCI pass-thru devices.

Michael Kelley (4):
  ACPI: scan: Export acpi_get_dma_attr()
  dma-mapping: Add wrapper function to set dma_coherent
  Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
  PCI: hv: Propagate coherence from VMbus device to PCI device

 drivers/acpi/scan.c                 |  1 +
 drivers/hv/vmbus_drv.c              | 15 +++++++++++++++
 drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++----
 include/linux/dma-map-ops.h         |  9 +++++++++
 4 files changed, 38 insertions(+), 4 deletions(-)

-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
