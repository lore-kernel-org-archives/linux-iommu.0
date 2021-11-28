Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7DEC433EF
	for <iommu@archiver.kernel.org>; Sun, 28 Nov 2021 23:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64141605C3;
	Sun, 28 Nov 2021 23:15:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRmjUr_uPI8N; Sun, 28 Nov 2021 23:15:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 325306059D;
	Sun, 28 Nov 2021 23:15:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05945C001C;
	Sun, 28 Nov 2021 23:15:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E939C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 23:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0890540367
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 23:15:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y3EqtkdUf2MT for <iommu@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 23:15:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99BEC40322
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 23:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T790aj4vQI51GLcDLz7ZkoVc55E9hxbPqzFf4ZgLOGNo2Fu6XXbIqNW5wLGOqHNwaDtkgMX/VDNdqYh92qQXJCbXySqHE78d9OnODc38n2L+4lI+X3uynAOT+LU77ZsbKFiQ34Wa71Ikt8+HggZc0rUiOi/Mr9sIP7OAW+jd7mucgyVBRc4XGpLZDc/EXjXd7pA4KRVc5Ym7G16i6OtJ/4wjODQBEB4CUdQKpSKxF5RWWj5LzB3F6YLE6c/iG71hatDMnNIRCConWoDKSMF3eF2iBgvXKQEZK7wEs7EiKoLaiIdaJOLQYd0op4TiayuF7P/+5I5r4pdVmw9ulmq7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkejUlGblP/Hs4k11891feUqJxy8urZzuXTlYQ0EIwQ=;
 b=YSqPSeODahV5iT/VQtNnp7J3T1PQRv1ZvV80jhJLQPgG5rYOYlMaWokfC1Z8agrhwxWKIFty39RTO/ujqmc0X8WyTq5mTrWjNFCXir+gcO7H9t0cmXKhX5g8QWRkqRyuT8+mab1umrYY01Uoib65B//EwB077DbKX/wruUhmT6frL4dXxPHu76FsIO2/wctaVbXCOY8PEEa3Vd7MWCzp9MZyZprfYhe62pbJmTknHRDRtsU7KuQdrXq3vrZNXLGB5S4VBTq3MuaXFGu8s+LPM5IGOpYr01rG1ScXe5cmzjy9Z8kO4AuDRow2PwMUXtCVQ8nzFEmEO9VfuQIHyWM89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkejUlGblP/Hs4k11891feUqJxy8urZzuXTlYQ0EIwQ=;
 b=eJG7ulktoEcYABUxsJqa5nUR4Vxzjyt6cdKuX0ywKIR08hHny9stV8UUqiyjb0nmcSYAdn8XjS/KXmO4frOzM9fZnsbT/rKBmN7uU/CI3wJ1uxTD+nWnOsy0++0b6j5igH/mU1+XTy/OOh5rGjhTxuQKUiS+ct5JPy4MxHsDRP+1Ws1ZuCtoO44mrAEoihrdxCuhZjuj7GwfB1EvA4ubPOYc5q1XWSAv7iZw2y8C6XjEU15bfeqWQKoY9W0S8oK8ixF9XcjrfVVDbAf1purQSUqS7CKpoBWZVHix3zzlAADf/HAC37OOGvcuWyfCLrlmnHFKbEHPJ4muCLf1yHpxqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24; Sun, 28 Nov 2021 23:15:11 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87%8]) with mapi id 15.20.4734.024; Sun, 28 Nov 2021
 23:15:11 +0000
Date: Sun, 28 Nov 2021 19:15:09 -0400
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 04/17] driver core: platform: Add driver dma ownership
 management
Message-ID: <20211128231509.GA966332@nvidia.com>
References: <20211128025051.355578-1-baolu.lu@linux.intel.com>
 <20211128025051.355578-5-baolu.lu@linux.intel.com>
 <YaM5Zv1RrdidycKe@kroah.com>
Content-Disposition: inline
In-Reply-To: <YaM5Zv1RrdidycKe@kroah.com>
X-ClientProxiedBy: BL0PR0102CA0004.prod.exchangelabs.com
 (2603:10b6:207:18::17) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL0PR0102CA0004.prod.exchangelabs.com (2603:10b6:207:18::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Sun, 28 Nov 2021 23:15:11 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mrTO1-0043dU-PF; Sun, 28 Nov 2021 19:15:09 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991b8fec-218f-4c14-8a29-08d9b2c4ed15
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5184BC54C36A511056C9CB53C2659@DM4PR12MB5184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUrHJFKGpj9DFCO8yWnv2C/0sLBlbGIeTntuBpR/NnsBgHmyoNFACTpz2itM54dKN7+2OrlC9O00amTCI+ViRjSJtVbW8VkWD5A96YCn9a3uPFzvWDNvfXxwISVEE8ldU+nhGoW2eDqTpDoN/exnv/Y1oCg4Eqim0+KXFBLwf93+sILJkPwzmCYa9uUBhCiM17asmg02PIDlRUcdO6zKwrulVJAK3cRMdK2BYbA4q/m1ZFOaTZGy3C01AWJb0DWab27NW/qlgBgE+xySRjrUugE9qkCRV1Oq1HvNDsCAfmp0ln5OIRfRh8/4kIxo+LuDXv7lJQpXp+RzyCaM7lgYldkeBwjVJcUSNt8uWeOyNvpLBdKDAiCur+jREV8snlGrp1UB0rxFggsHUoFfw6zbqwrOzF1px17pVz0h5zqdTmoxyNKs5/JlrUxHbsp2Ei97tzGa5UCZ3dSQuO7gUPvin5fKy+GsdQOh34LPqNjm43ErmfaK1JqWlhfhj0qAiVIWPy1To5IB5cersa2HvzU0GuNfqcBsrnpZfDAc476teerJzuVy9A887TSiNrV8dFZfMa7nItifEMIsjw6N2UJ1NGMP0cGzUg8CQAjsug9qDlv+3VjCcTkf0HnzskdwtE+5V6i1DEaOlObeL9CtEresJx02jvG2Aiivov8KVQB1G/TkBLwROzvP4+9FQ1ISZc6KFCrG8BR2xurOSzb3Mfp+QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5520.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(426003)(36756003)(8676002)(1076003)(26005)(508600001)(86362001)(4326008)(316002)(66946007)(83380400001)(66556008)(66476007)(2906002)(38100700002)(54906003)(33656002)(9786002)(5660300002)(186003)(7416002)(9746002)(6916009)(8936002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WKYfsd0upuURuda1GH0txehgS04iJpAZbL8qam9bKa/jGScvrKmWvNXAiDS9?=
 =?us-ascii?Q?uA1RVcrkvgImNisNr0Uo6k9MyEcJSOdPYSpjduVgsEx4hLpwn4CVyWwm+cWa?=
 =?us-ascii?Q?hyPGkazcuxt75gFBL0Ry3LwtFNXiJnsYqCnVarqS0yEzwOhGGsbjuplCnOgv?=
 =?us-ascii?Q?BG/eV4R4yrWOV6oT6PojOtZD/Hd/TjTxPFDPIDEUqEN0dMrZH5VbB1byyHVP?=
 =?us-ascii?Q?XuqFeKq9fwKvajwTPxaU7GNQkF1XgUkYTLIO/xz64pmsuoxSgndRWE67gt2w?=
 =?us-ascii?Q?QBpIlRXGkXwD9WP/kfF2zR2l0GpLGVaEvQB6e2FVu+1z584Gir0gR9vJRvuL?=
 =?us-ascii?Q?CMBZ1HlANET1L1ZSLy3vl7HCXIR2FgC7E4QGaegNyEGg2jXtGyYcSdLwD/x1?=
 =?us-ascii?Q?2y0M8LugmrvQiVwtARPGGeurWQS5RdQmU2y1tAsctOa1XBsR8rKVen8Kvhs9?=
 =?us-ascii?Q?6bU3TbZnCLR9C93XbAyEpXJ2OUw4CToRDtmffQeXlN/pNBplHuyZDSWg3+2A?=
 =?us-ascii?Q?xxQwQSAf+QGM6uTMsKM/tcIzxv7SibogUbpKOyFUTSdK1Ezpb0eKJnyzSaN0?=
 =?us-ascii?Q?FR95OVJ5C1ASl+iMQznRWM4H7ubRZxPounpeSMbDXAjRqknYwvLCHdyxLbxG?=
 =?us-ascii?Q?NQBkfRDlc3loY/58DixC4eYG+OoeQQMUHInulbT7mzIgGawHwk8HMqMtJdMq?=
 =?us-ascii?Q?ZYxt7/ZKWzzBanhLVjA9NnRpjfihx6rkpVN0tGonQcSKGTpJrUqMdxUuyfWp?=
 =?us-ascii?Q?widbmZSM1xC5RX7rCJBi1gILGY7Lr6+UP8CM/uE27KxMCY4K2RSK5Qmiekh1?=
 =?us-ascii?Q?Kb5xBQpxnB0qx8TOB+meUYtO+zbC0XERetzzXKnDmX2ep35R7UMiE767rTg0?=
 =?us-ascii?Q?lRFIA1FGahYhINnisf4LVsh48OwSs/YLrkMuMyXd14MWVjHNxOHTep4zunR0?=
 =?us-ascii?Q?ziVHBJlCdLDx7JcpQCSWIIYWzakWTRZTgtsJRWH9vh16C8AwHWgMHelgyH5y?=
 =?us-ascii?Q?apWh32xS2no/fP/mnTBCorv6fjL6V/NBxMAleeJD7KhjcXOR8r53JOvwSm9w?=
 =?us-ascii?Q?vxE6mj2h9Q452lYMUCVdVwwvJAEJdWlhpk0RrbY6LOt6j/9y0dxVP1tKHtpW?=
 =?us-ascii?Q?vrnRqtC6/M4qv0RNYjS7BkQJPm9ZM0DeTmd64vbrG7Rh0X/vtKQbr8QJd8JY?=
 =?us-ascii?Q?kh5aPhpRKiuGwVIl80ibXFjOWm8eAt9sXHlz1XBNLko8Q0i7oIQ7tkUX4qDx?=
 =?us-ascii?Q?TWWqdgnj3yrnpyieh9x+8etJ3B1v224FHaWB0d7j9IvGSSfyIkZOnqB6jZX+?=
 =?us-ascii?Q?/TO7Lnv2RyYZ4Yf1b8AIC+4yQWff1fF7BoMzAzo05cNqiFkdQWnHga076zGt?=
 =?us-ascii?Q?n3nfeSJs1q6yH+oL1RlDfS6IQ/I/NgQT5LfPBwiaONWrUEb5TxcZiLvdTSuQ?=
 =?us-ascii?Q?NLBKllJfLEHDBq5V3ic57uOXeSwE8F4evVYfJVcRZhwrb1dYKnTGpmgO4PrP?=
 =?us-ascii?Q?iMuoxd9EB74ZbmAW8iYml9mrWDvVTsidzWWSt2uMD0eFCN5YPyQUQ6ooGRXY?=
 =?us-ascii?Q?fNQm/e1MO77dAVTKUS8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991b8fec-218f-4c14-8a29-08d9b2c4ed15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 23:15:11.3080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0bZ7M2nxC5HgZMAlBwlT8u6SjfxyZibfi0M8LQhOPGivBaz0LabhdLF4p9NTj6H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Sun, Nov 28, 2021 at 09:10:14AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Nov 28, 2021 at 10:50:38AM +0800, Lu Baolu wrote:
> > Multiple platform devices may be placed in the same IOMMU group because
> > they cannot be isolated from each other. These devices must either be
> > entirely under kernel control or userspace control, never a mixture. This
> > checks and sets DMA ownership during driver binding, and release the
> > ownership during driver unbinding.
> > 
> > Driver may set a new flag (suppress_auto_claim_dma_owner) to disable auto
> > claiming DMA_OWNER_DMA_API ownership in the binding process. For instance,
> > the userspace framework drivers (vfio etc.) which need to manually claim
> > DMA_OWNER_PRIVATE_DOMAIN_USER when assigning a device to userspace.
> 
> Why would any vfio driver be a platform driver?  

Why not? VFIO implements drivers for most physical device types
these days. Why wouldn't platform be included?

> That should never be the case as they obviously are not platform
> drivers, they are virtual ones.

Huh?

> > diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> > index 7c96f169d274..779bcf2a851c 100644
> > +++ b/include/linux/platform_device.h
> > @@ -210,6 +210,7 @@ struct platform_driver {
> >  	struct device_driver driver;
> >  	const struct platform_device_id *id_table;
> >  	bool prevent_deferred_probe;
> > +	bool suppress_auto_claim_dma_owner;
> 
> What platform driver needs this change?

It is in patch 12:

--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -76,6 +76,7 @@ static struct platform_driver vfio_platform_driver = {
        .driver = {
                .name   = "vfio-platform",
        },
+       .suppress_auto_claim_dma_owner = true,
 };

Which is how VFIO provides support to DPDK for some Ethernet
controllers embedded in a few ARM SOCs.

It is also used in patch 17 in five tegra platform_drivers to make
their sharing of an iommu group between possibly related
platform_driver's safer.

> >  	USE_PLATFORM_PM_SLEEP_OPS
> > @@ -1478,7 +1505,8 @@ struct bus_type platform_bus_type = {
> >  	.probe		= platform_probe,
> >  	.remove		= platform_remove,
> >  	.shutdown	= platform_shutdown,
> > -	.dma_configure	= platform_dma_configure,
> > +	.dma_configure	= _platform_dma_configure,
> 
> What happened to the original platform_dma_configure() function?

It is still called. The issue here is that platform_dma_configure has
nothing to do with platform and is being re-used by AMBA.

Probably the resolution to both remarks is to rename
platform_dma_configure to something sensible (firwmare dma configure
maybe?) and use it in all places that do the of & acpi stuff -
pci/amba/platform at least.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
