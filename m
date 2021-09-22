Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8184EC433FE
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:39:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212A760555
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 212A760555
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9D8440794;
	Wed, 22 Sep 2021 12:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7woU4f8ovS0N; Wed, 22 Sep 2021 12:39:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC4A84078C;
	Wed, 22 Sep 2021 12:39:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71444C0011;
	Wed, 22 Sep 2021 12:39:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3430C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73CA282EB5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RhbcFbi5F7ur for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:39:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::60f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6FEC81801
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cenC1dct0s88Pobc5FWCVX6JrMMgVZq7axt0w5yxaxk22M4w6rQgQ5EobWYZDXRyNegpahCMtlIU+ySF/0HG3wFECvkZo3SKKwchxTaRbrRkUKeDrTX2Gp9VnAUBph6Q8E4saN+9YqNraTVkLPPmrbvW4hkO3Eh9LU9SrtH9vpij8yUGinj+cSvlQ85IYJnVLAOuFnNlh+KHzSCDcjIyfzOANpdwHMnzqIeBx1fWd7FoDYNRIc8LKf+NECQceUFt8Z0w+gGhlkL8KytP4zoUfTvY8C6dECSEF2kTf0H93xPkVYpc5Hyl6Gj4Jw8a5zqSfHxnm17QKKhST0V4geWmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=yDIAW2WLbFmU8KTv/a1YmOFch/yG1cTGJy255IXnLgw=;
 b=ZTYzZZJkq8VkiHPDnhwaSy0jvIQ5LjAeLJCxulvpuhP5pSu3lVeOa0NuRDZxajDUZonAZBU5jO86zyOSWOZQFhgPK64IMT+gkFSsV5aD+fcxDnxSZI9pTpvx/bgkjiFuy/aYdsumoIrk8MN6WHGyb7LzYgPIWrwF3/WP1jlfKXLEGtBxwkcYGEwJrW7fK4IvxqBTKwhvTHdQXULsW7MHYofF54coRXfDCysVBn4GcbLJ0dLP0xO315VjPDut/adkBM3YbnCNf82gdwD8LOOPlowc6+Ts2p0SstNHOjRwJCGuMaIbPWA3bp31G50VTYmkz7zxrJtaNkxfaWhDkEVUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDIAW2WLbFmU8KTv/a1YmOFch/yG1cTGJy255IXnLgw=;
 b=Fo/DJbxC8XmZIKn4v+2PuLT0lT45S5F+Qdc3gktJ7aSIydDOdrkqpmYvN9dbFrVRQJXVylBqGv032QZvq6MviQU0dIWeV69LSl2TPWzpncpLrdTkp316dktLcx8lGAm/zz0cDdi6mCoqzYtpwB/oX8mCAtN2WdS1iQNAH9mupYM7QgOzw6mvUFrGh+ZgHTfKABtakvreOmsSLV6D507mcDPgnsYmroxBE7qE1VaSf21p9wmABMhlFnl3ltn547X1ExKPIPDIK+nobTiXBBVY5RwAbd0aMuWBgnS7BcAFVsDQxl7fy1pScLNMzRq9y4DzTJBb6QUW53qwQxV/KJFgUg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 12:39:32 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 12:39:32 +0000
Date: Wed, 22 Sep 2021 09:39:31 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Message-ID: <20210922123931.GI327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <20210921170943.GS327412@nvidia.com>
 <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0374.namprd13.prod.outlook.com (2603:10b6:208:2c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend
 Transport; Wed, 22 Sep 2021 12:39:32 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mT1X9-003wvW-BV; Wed, 22 Sep 2021 09:39:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c03ed3b-8908-4e17-0ddf-08d97dc606ea
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB506351805C83E8FDA0F55C71C2A29@BL1PR12MB5063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3j8uoCJhUsyM012dK9CXr8YVzZ87sOFW7QJKZOxkkDYMCE05kNm1USuz8XwaAshlWn8DOZHhsbA3VIs0fBADSiF6FgQfxjZGawQStqKdQhpoesp+9OnJw5i1y7fC0x9kVEOmr7GFkM1q9qyTmXwMiAlordimWhkJp5Ub0/boeevMLV/BAZx67IvbPiKxGfFd79pm6i0Zb1gN6vZHK5rAscRbJo0Vq/1ruOjf902boArOIwvCI1n9U8sxSJjDnW2ldvs9aV3Cua1mXIloixjE/fymYPBll6hcjwanU5oqum0SScYmxyzCVsOG1kjGYLc45vklQdGjJTWFJBVTOEm2857RJZjZ9LiO4JbEzFIsPhbuZ60VMOIAkqmjL0jNumebxO/KPsi6YrZ0TUC48ckBaaPoHH52xRX/mQw1FBDGuNCWPT7PTSif1Dj7I6sRxDW6Ndjp75v6TO0KQ+OFjX2HKdCIcZR34Qg5mXYwi1EfDkFr5lywO6vdPqziX2FwzpBoAb+PA8PAubrAv/9pAxBc5u8iR+5U7JmmMuTXr40nIRMZH1WhKvrnJV1XkgUgblTz9+qvpPUFKi8nPEDMKRVrDzWhElsEG2rYkoYfO+X6PAY/GxdbDNf739RzmlYjvUUMK6ozZyvjrQIeE4VKM++KOh0QumnPEEUTQm7IvLKoRRYxNggt46G+D689VQzVXbF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(8936002)(54906003)(186003)(316002)(33656002)(9786002)(36756003)(9746002)(107886003)(26005)(1076003)(4326008)(2906002)(508600001)(66476007)(66556008)(6916009)(83380400001)(86362001)(7416002)(2616005)(38100700002)(8676002)(426003)(66946007)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?flNm2Bh7f2SQ83HwLHAo/PVQrmgziJzYZlYm6KOr1wDooJ5zH2P6s5k2LpEW?=
 =?us-ascii?Q?K1fZWrppQCDsbYmjc6DK2zMfpbXnjLWh51IKmU88tUljwv5+wdkaxlILRgcg?=
 =?us-ascii?Q?EyDX7imtcCzWatS/scYwrO8sO9HTRg1bpfy0OhSgZvRR0UXcRCKQW/VU1RbS?=
 =?us-ascii?Q?KPnHmNbVRCGcRRGeslEAzJ4kKRBMVWxbc3+BiMD5BF0TVjkC1TLMD844Sazn?=
 =?us-ascii?Q?d/VjSw4ZQS6ndcZQHkQPeNm6RVEs3yuOZ+fICrUQQZsdKDOZNzRUo9ub9Cvw?=
 =?us-ascii?Q?rXhJ9haw3aQpbFNvFtyoinL3kBmJloRRvk2Ql6eFUDQ2P71sabG5/MGn5NPO?=
 =?us-ascii?Q?70CnXkdJxdnlCJDILq3EKsS3cIQxYpbG0WtGw7Q1tYUq2bLov47rUESv/4Eu?=
 =?us-ascii?Q?uI7QETCc8N52abfgQWXhFTgPPduimHsXT+XZobA6JQe+giyWbjWk8vr/U7u/?=
 =?us-ascii?Q?ygs/FiOwKR7g9FJywCKVzJThncCkbCZUpw1dyC4nlwSbwRNaorJAmAVEhShX?=
 =?us-ascii?Q?abbGB5YfA9vNVFwq0yX6oE023VA0OkwflYPHBxyAHCyFpWNC3sipGb4Q/0xL?=
 =?us-ascii?Q?T0wpce3Vp7TzmyYdZAwSxOmEnNf7z1z4aY6CHmq0hwK5x6GWkF/Dro+/Odns?=
 =?us-ascii?Q?Ig4TTsDHzLR0E/xFnBItSPLRsHFsR71jVrLdu/LiqK1+Xj+TS1SRX0pg1bLW?=
 =?us-ascii?Q?bla0O3EZYHZVfOHUDi+TS/OcUPh33sZC8DC+YrF0RZhKpzXh1FYHsgxXyYZ9?=
 =?us-ascii?Q?DfciO6LVRm81Oz1zSBL0/cbfn4W5sF7AR4b4EdI6kgXCi1QLQ6BMQygJP2i9?=
 =?us-ascii?Q?V5yFVsGVYBv5gFwJD67PhFGWqEr6h666H/ciEIaUMcT6uzc+WPHWu1ni8+3K?=
 =?us-ascii?Q?x2S/vpSXEg2BLKKsB8BNOWl4ax5L57Knh/nDkY1bigaNPYJOmj4kb7cZCViL?=
 =?us-ascii?Q?JXOgcS1bjQie8m+l3ZBYa6OkonPbw3hT2LtcKGYiAnJkT7hz3s745fS13utQ?=
 =?us-ascii?Q?6zfD4qu3PdZuDoVsf5ibaKqttSia+gJ6H+1YsFj0iQNEaSHYdbxYpd7IpCnk?=
 =?us-ascii?Q?Va+sOJLqRIw+pi6gtZilJxLTrHJ0YsFX/uYdkWLsIFfGyBgtmjbnlOpnzKu0?=
 =?us-ascii?Q?Dlwxsqu7CQ5K7JBgjq8WirfIM6SkahdPmszztGI/mey7NgQrDijfovGt2S4x?=
 =?us-ascii?Q?xi0hoZJ8ahWd/8syBPLcNw7RADMnEgMzmT5RcEHbadS6VMxbQ3Sog0OoPaXN?=
 =?us-ascii?Q?KjbT0vAxbdrIoSNnZkTLRuO9ny9OwvJ0uYsNq/3EOTLdXJskxZv3BWQkvyso?=
 =?us-ascii?Q?tZtpNV7tMPauNVEUogeOW/ur?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c03ed3b-8908-4e17-0ddf-08d97dc606ea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:39:32.6487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7J7jW0oMgg9Q2P1rcJ8DOtZYYJtNWOVtZ0t4OLCyQCp9epp0K4OuRP/TuzriF9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Wed, Sep 22, 2021 at 01:47:05AM +0000, Tian, Kevin wrote:

> > IIRC in VFIO the container is the IOAS and when the group goes to
> > create the device fd it should simply do the
> > iommu_device_init_user_dma() followed immediately by a call to bind
> > the container IOAS as your #3.
> 
> a slight correction.
> 
> to meet vfio semantics we could do init_user_dma() at group attach
> time and then call binding to container IOAS when the device fd
> is created. This is because vfio requires the group in a security context
> before the device is opened. 

Is it? Until a device FD is opened the group fd is kind of idle, right?

> > Ie the basic flow would see the driver core doing some:
> 
> Just double confirm. Is there concern on having the driver core to
> call iommu functions? 

It is always an interesting question, but I'd say iommu is
foundantional to Linux and if it needs driver core help it shouldn't
be any different from PM, pinctl, or other subsystems that have
inserted themselves into the driver core.

Something kind of like the below.

If I recall, once it is done like this then the entire iommu notifier
infrastructure can be ripped out which is a lot of code.


diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 68ea1f949daa90..e39612c99c6123 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -566,6 +566,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
                goto done;
        }
 
+       ret = iommu_set_kernel_ownership(dev);
+       if (ret)
+               return ret;
+
 re_probe:
        dev->driver = drv;
 
@@ -673,6 +677,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
                dev->pm_domain->dismiss(dev);
        pm_runtime_reinit(dev);
        dev_pm_set_driver_flags(dev, 0);
+       iommu_release_kernel_ownership(dev);
 done:
        return ret;
 }
@@ -1214,6 +1219,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
                        dev->pm_domain->dismiss(dev);
                pm_runtime_reinit(dev);
                dev_pm_set_driver_flags(dev, 0);
+               iommu_release_kernel_ownership(dev);
 
                klist_remove(&dev->p->knode_driver);
                device_pm_check_callbacks(dev);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
