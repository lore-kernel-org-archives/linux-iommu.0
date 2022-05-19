Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEEFC433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 17:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A4B741033;
	Thu, 19 May 2022 17:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2cFbo97Ao8J5; Thu, 19 May 2022 17:03:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C662E41002;
	Thu, 19 May 2022 17:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B9B9C0039;
	Thu, 19 May 2022 17:03:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7A27C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 17:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D52141033
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 17:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20NXe8AeIgA7 for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 17:03:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AC2141002
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 17:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itpk1Lg+apJC0xIZydm6Ii1zZslRsyNkWNFLR8F3KbF479hB82T2FPF9SfPZBZCeR8v3sjlDFfyciXNgQO3zObkgmzYGYmjTb2y8Cu8aA7hpbscIdUaogF2aNnvKWsFmFJ/WPRiyccVSH+UhgH02dmtSrM/bplzVRaIVJN8MjXLs2RM2RwEAyVSDALY+Tx6gSVYsd1y9rGQQSK1meqmmte4NHeVM9FCZRusbEH/yC+DD5LV6JomaX7XiA9eQsUSql9+YwRvgiqdy1DcVdAzaOpj1qX4OyHZXn/zQ7fdhRw6j7dA8PojCVytA7mAvBwRrRlswmTWRGbcSv9ZgltHnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPR+u3x6/aCfbiH+NsJXKdY7hVEaD0+pfv3gL6HbZiQ=;
 b=ZdZk+X6e0xHmhC5tDtEOxWw/Te1OMC3Ca2z/fIIsY1OHxfLWXchUCyAqLyhno6uJpYwFVinpMr2JGl3TezUh10o+DfAQtzoLmaFEjdV50P8lPXudQOSvOkhZX9rnKq75fIhUD0i/4AJayXaEQIEZMUXMw3noCoTpqNHPOFWQRIaf/AGF8znJ5c2y1bcb+vwstznAsC0161Ta6OZzDSazcergaPZDM0UpMvkyofjbGWEIoV6BjxQOuK1QJheOSKq75i0qO5gNe/vuh+W5TjYVxpzQQSKF+NA2/egArROzljA1uh5I2Xr6fBVuqsEg2CbNDvHbr6+e340y7FpRHqSWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPR+u3x6/aCfbiH+NsJXKdY7hVEaD0+pfv3gL6HbZiQ=;
 b=MkyeDxp7kRjo3fIN0RWbxeVpMbmFNjHiYZ6hvhUF6SXRyTEkqaSPrb1vw/xlnJppHbtSWQLGEb99mPmE2xC33ZQJ1bf42Z+FiwH9x6kzNwq4dnpYSUR28zVFUeqx3oWL36Jjt/zplWieixy/yk/BREHRNV9Xc3um0cj/SKDsSnppargG8/KjSbTxxv6mTnYahbW2N+EbdfEUFodvyypjUC8OIWy5DFyQNvkcFVRf+ak80MJP6sVuJxkeH+fUwf1LVgTkC8uA5AharLntFikZDlx3wpRqzylHQaWOSGdzj3qV3cGKKcBOfPbKPLwsamUaMQ+nwKKngQgP17RFw07NhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1370.namprd12.prod.outlook.com (2603:10b6:3:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 17:03:49 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 17:03:49 +0000
To: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] vfio: Do not manipulate iommu dma_owner for fake iommu groups
Date: Thu, 19 May 2022 14:03:48 -0300
Message-Id: <0-v1-9cfc47edbcd4+13546-vfio_dma_owner_fix_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27)
 To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0060d7b7-3761-433e-8676-08da39b98afa
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13709D7DA836665E278526A6C2D09@DM5PR12MB1370.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hC+EfhEHdZGG+340fTM1hxLT3+BT7ugKigyWPmnjczpbt9pyaZ52E+UaTSFDA2T9LsMBAB736Zna/zclfmTUoBNFwMbOimXaOebphEV78rfCuo7Fmlhm0ZMI9OKYpSAvcN3XCh7YrvRVo2tUQrtyZUGL8uYg1ogQCXJkm5ILhA5zSN++8uZNZg8ouzBjNVKcdOIc/wHu+ERM/WfRsiBTnA3YqVW+yuXqoQJ6/V6bO9QELOzsvNEjXPl9FkvVysaoaU6zPm6oGO9ZsjnE+5f1qRttU1Pim7/wMkWIe6YdxmHjg88OyvaaiwMpygHbMUmk/rDtOqkTu8reuuG+bNrSJFb3ZfGc4B9uxDHJS/xNB5IdAu2QCml5+fPM/7nVnvQujJwe0xYL3iQ9DRhkkbqjE97BTcFifoEOW2jXz6IQOwA+SKHMB6SMaBIinCRfA7TDdwLEtfgfR3eEKDdd6MfqLUg1r8BzJ9rfVqmPYjLAJWnWNTtxlbzVMioAdwfVzFDnYkD/sXN42antQCqUKJguCR8dpnXKmI1wSHA7CfviGiT8G0oZsF1fW/8hX19NLd6PNI50sfpX4Ey371xSRxML76AEsxzDYeO71U3IVYErzZdkMyzV3PCOQi6cG3uAYgFKwqZ6/d8b0Wj0WQofXIGc+21UhOwSQIjWnntbzbrquEeNXWtVeJmC00GqbKiDVyOM8oBvNf+tzfsGxBhPsg+GyZ0f4BgZHE8I+rrilfaWU7BZYZzGUMbhE4vPvwMLEDbXyWzoPUmMVlkaSYpxbyF3IhPtwxu4u4B1KNACwn1+Q8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(2906002)(38100700002)(86362001)(966005)(6486002)(54906003)(110136005)(316002)(8936002)(5660300002)(83380400001)(8676002)(36756003)(6512007)(26005)(66476007)(66556008)(6506007)(2616005)(186003)(66946007)(4326008)(4216001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlY+chPt2Jca/lBoig+HeolevKoGOV3Lo7QMAAL1KdI1RiNU2kqBn2wxn7n6?=
 =?us-ascii?Q?hTseEj/JBhaB0WQtYJlGxgnUawQBJER1d33m7tg1TOxwaySub2EXZXs1ozJD?=
 =?us-ascii?Q?WEof3KXBRCZroMLAEBGgDBYbKf7u+DAuwooCg+9bOxD6yxOZN7wRjDdTgXx8?=
 =?us-ascii?Q?Wt/2oaWmZHEMf5OnW8pa/N0ivwF3S2Wha5+j9Sa56LhRYF6YfjHuGc5+Pq9R?=
 =?us-ascii?Q?DRUSzHbS2sfUTilkCSco95Fa7lVShLEBdxV0uF58XvL+qEVH8ke9StPMMjvn?=
 =?us-ascii?Q?VQ5tsL/PnXaZB3bsTrKrZLoKN2mV3m79If7FmrRi3d4if2vtmAL1r9pu/rRR?=
 =?us-ascii?Q?0cLXaoORdeyxoK/dBCLmNknUdbNjRV5fYvaQcYG5qVEEoiMWJh/7qjyCSNZB?=
 =?us-ascii?Q?hu8rFXPf2qmoKugpVRiykJkWqoTTbrcXdaSpRM4ilcKLHaWZAKU8dVXXhCWB?=
 =?us-ascii?Q?CnY7WDCtFahK4qbKbppzXKqPoHfEsHmi9Nx8roC/nBcZX4V7DaNRtLP+M4k7?=
 =?us-ascii?Q?R0g8waewvxCM/qpuMDHu4fG3Uh1rxeRHxN4gD030hjyV/rf3i//HdwXPuzcQ?=
 =?us-ascii?Q?IObEP0LC4PWHgzpeQYUBT38rPK02vmEv40R0i3Hws6xNzcRM2n5x5BTI7Yk+?=
 =?us-ascii?Q?qHs+dnUYRv+Gi3xEZBYtgf7vY7Oe+U3Yt3XYJiRWzGXFHSijzuNzmUVmTwic?=
 =?us-ascii?Q?/Dwm9WZMz9Rql/HksWMeFRJloPJMCzyqTO4o2KC2VxvACaRN8ufGpN3OI6Ay?=
 =?us-ascii?Q?B0ZbKzJJBS1Fp/4UucW//UD8ZbIaan6kmJ3XtkWpLwGe5Q+p1fFVNp35QblL?=
 =?us-ascii?Q?OR+0vUOPAgdV5p8n0g1pMBSGlq+ULKpKn2KqVAU4r2d7IJE0oyKh1ihegmAI?=
 =?us-ascii?Q?jqGn6mD2KduGYgyxftCKkZbqzioI+RGHYjZkglaGDt5bBdoL372+aaMFfi7M?=
 =?us-ascii?Q?ajp9rUMvk2jOjB9V8d7T/cmemQallSiFimSlFinfXV1veFK0WPnVsWCeplC9?=
 =?us-ascii?Q?xtPx65pxiR+07z4OXrscssvsKAf90fpdZ4ypD0kRkZE2IqeEpMpumm22d0ac?=
 =?us-ascii?Q?w8zxr/s0vG8eGvYtjrt1EXR7lLUXwTYjIyLJQhg2lmdpiV61yPcSfjIvJ6E+?=
 =?us-ascii?Q?BZEMjnptKn07aXkQs2EN+CgXVaogtMZrkfJxOzldEk9lFkaLYR1TOs+TQ5JT?=
 =?us-ascii?Q?ZvAY0TaZ1EVrwSY0N//V+li+ch71zv7lBV28NlZAVyWL/hGfH99DSMFTEFFa?=
 =?us-ascii?Q?Cu2hIiuOIJg/rDP1gokMd/hTP9D7i3YgHMiFjZC8GqotEQ2fBp0AwF7HD4Xh?=
 =?us-ascii?Q?w+5dPikwXW12AZ2g/18mNQoSGCrf2a+nw33xmdPmu8I85w3hrbKGdnyWJMCx?=
 =?us-ascii?Q?c5Oher/rjl4fCi7k3NkvdRitAEErMXHeFwv10ui9NdY/55tCGKIo+aP8QqJR?=
 =?us-ascii?Q?WwfKyWbMtE22W6Uxywbg/b+i9t3Zmr8eHEJwywozLIvHcsGDxQ+61kR07Jwz?=
 =?us-ascii?Q?ZR69HuBG1bdX41LG1e4+ALTWIknFJtENN3FJUQWSOzG5nftiGY55Hwn+GWW0?=
 =?us-ascii?Q?RjhPLJh1AcTtBjNzh/mseVcSqm464yJI7SG1LrZaCeOEAfDB+6F08LGIbhQZ?=
 =?us-ascii?Q?SK4aZmU658KOw5zFep4vKEXrPwzNwZPqE/ArvMa3WrjBR4QSPh03d0UjM0xY?=
 =?us-ascii?Q?Y8YC4F+wHNO07zjIGkZee+YjZaPUFVIi2uKSEztRJjmwKFOFizOx7Ge2O/bS?=
 =?us-ascii?Q?zi0SE2azdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0060d7b7-3761-433e-8676-08da39b98afa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 17:03:49.0378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QumTmd/iYGl86Ipk6UxJixzEqjExNfFzCz8yj5RluoPTm0r5OHbYQG+JhSMq8xC9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
Cc: Eric Farman <farman@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
 Kevin Tian <kevin.tian@intel.com>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Since asserting dma ownership now causes the group to have its DMA blocked
the iommu layer requires a working iommu. This means the dma_owner APIs
cannot be used on the fake groups that VFIO creates. Test for this and
avoid calling them.

Otherwise asserting dma ownership will fail for VFIO mdev devices as a
BLOCKING iommu_domain cannot be allocated due to the NULL iommu ops.

Fixes: 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must always assign a domain")
Reported-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/vfio/vfio.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Sort of a v2 from here:

https://lore.kernel.org/all/20220518191446.GU1343366@nvidia.com/

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index cfcff7764403fc..f5ed03897210c3 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -927,7 +927,8 @@ static void __vfio_group_unset_container(struct vfio_group *group)
 		driver->ops->detach_group(container->iommu_data,
 					  group->iommu_group);
 
-	iommu_group_release_dma_owner(group->iommu_group);
+	if (group->type == VFIO_IOMMU)
+		iommu_group_release_dma_owner(group->iommu_group);
 
 	group->container = NULL;
 	group->container_users = 0;
@@ -1001,9 +1002,11 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 		goto unlock_out;
 	}
 
-	ret = iommu_group_claim_dma_owner(group->iommu_group, f.file);
-	if (ret)
-		goto unlock_out;
+	if (group->type == VFIO_IOMMU) {
+		ret = iommu_group_claim_dma_owner(group->iommu_group, f.file);
+		if (ret)
+			goto unlock_out;
+	}
 
 	driver = container->iommu_driver;
 	if (driver) {
@@ -1011,7 +1014,9 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 						group->iommu_group,
 						group->type);
 		if (ret) {
-			iommu_group_release_dma_owner(group->iommu_group);
+			if (group->type == VFIO_IOMMU)
+				iommu_group_release_dma_owner(
+					group->iommu_group);
 			goto unlock_out;
 		}
 	}

base-commit: 7ab5e10eda02da1d9562ffde562c51055d368e9c
-- 
2.36.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
