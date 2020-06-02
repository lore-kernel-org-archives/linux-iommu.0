Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF9C433DF
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 07:02:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4530F206C3
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 07:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4530F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E4BD52051D;
	Tue,  2 Jun 2020 07:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GX797+d3WNUQ; Tue,  2 Jun 2020 07:02:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B2DE720466;
	Tue,  2 Jun 2020 07:02:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87AADC0865;
	Tue,  2 Jun 2020 07:02:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2335BC016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 17F9C88168
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ff15-gAL9SeO for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 07:02:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ED0838815C
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:02:15 +0000 (UTC)
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 4E6FEDF38B2B54A678CB;
 Tue,  2 Jun 2020 15:02:10 +0800 (CST)
Received: from DGGEMI423-HUB.china.huawei.com (10.1.199.152) by
 dggemi405-hub.china.huawei.com (10.3.17.143) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 2 Jun 2020 15:02:09 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.10]) by
 dggemi423-hub.china.huawei.com ([10.1.199.152]) with mapi id 14.03.0487.000;
 Tue, 2 Jun 2020 15:02:03 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] driver core: platform: expose numa_node to users in sysfs
Thread-Topic: [PATCH] driver core: platform: expose numa_node to users in sysfs
Thread-Index: AQHWOIpUwdvGGcJ/+UCxidEm0PhHvqjEM/4AgACJWmCAAAdA0P//jXEAgACHQ7CAAApY8A==
Date: Tue, 2 Jun 2020 07:02:03 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24D9167@DGGEMI525-MBS.china.huawei.com>
References: <20200602030139.73012-1-song.bao.hua@hisilicon.com>
 <20200602042340.GA2130884@kroah.com>
 <B926444035E5E2439431908E3842AFD24D8F9E@DGGEMI525-MBS.china.huawei.com>
 <20200602061112.GC2256033@kroah.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.37]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "rafael@kernel.org" <rafael@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> >
> > On Tue, Jun 02, 2020 at 05:09:57AM +0000, Song Bao Hua (Barry Song)
> wrote:
> > > > >
> > > > > Platform devices are NUMA?  That's crazy, and feels like a total
> > > > > abuse of platform devices and drivers that really should belong
> > > > > on a
> > "real"
> > > > > bus.
> > > >
> > > > I am not sure if it is an abuse of platform device. But smmu is a
> > > > platform device, drivers/iommu/arm-smmu-v3.c is a platform driver.
> > > > In a typical ARM server, there are maybe multiple SMMU devices
> > > > which can support IO virtual address and page tables for other
> > > > devices on PCI-like busses.
> > > > Each different SMMU device might be close to different NUMA node.
> > > > There is really a hardware topology.
> > > >
> > > > If you have multiple CPU packages in a NUMA server, some platform
> > > > devices might Belong to CPU0, some other might belong to CPU1.
> > >
> > > Those devices are populated by acpi_iort for an ARM server:
> > >
> > > drivers/acpi/arm64/iort.c:
> > >
> > > static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
> > >         .name = "arm-smmu-v3",
> > >         .dev_dma_configure = arm_smmu_v3_dma_configure,
> > >         .dev_count_resources = arm_smmu_v3_count_resources,
> > >         .dev_init_resources = arm_smmu_v3_init_resources,
> > >         .dev_set_proximity = arm_smmu_v3_set_proximity, };
> > >
> > > void __init acpi_iort_init(void)
> > > {
> > >         acpi_status status;
> > >
> > >         status = acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
> > >         ...
> > >         iort_check_id_count_workaround(iort_table);
> > >         iort_init_platform_devices(); }
> > >
> > > static void __init iort_init_platform_devices(void) {
> > >         ...
> > >
> > >         for (i = 0; i < iort->node_count; i++) {
> > >                 if (iort_node >= iort_end) {
> > >                         pr_err("iort node pointer overflows, bad
> > table\n");
> > >                         return;
> > >                 }
> > >
> > >                 iort_enable_acs(iort_node);
> > >
> > >                 ops = iort_get_dev_cfg(iort_node);
> > >                 if (ops) {
> > >                         fwnode = acpi_alloc_fwnode_static();
> > >                         if (!fwnode)
> > >                                 return;
> > >
> > >                         iort_set_fwnode(iort_node, fwnode);
> > >
> > >                         ret = iort_add_platform_device(iort_node,
> ops);
> > >                         if (ret) {
> > >                                 iort_delete_fwnode(iort_node);
> > >                                 acpi_free_fwnode_static(fwnode);
> > >                                 return;
> > >                         }
> > >                 }
> > >
> > >                 ...
> > >         }
> > > ...
> > > }
> > >
> > > NUMA node is got from ACPI:
> > >
> > > static int  __init arm_smmu_v3_set_proximity(struct device *dev,
> > >                                               struct
> acpi_iort_node
> > > *node) {
> > >         struct acpi_iort_smmu_v3 *smmu;
> > >
> > >         smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> > >         if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
> > >                 int dev_node = acpi_map_pxm_to_node(smmu->pxm);
> > >
> > >                 ...
> > >
> > >                 set_dev_node(dev, dev_node);
> > >                 ...
> > >         }
> > >         return 0;
> > > }
> > >
> > > Barry
> >
> > That's fine, but those are "real" devices, not platform devices, right?
> >
> 
> Most platform devices are "real" memory-mapped hardware devices. For an
> embedded system, almost all "simple-bus"
> devices are populated from device trees as platform devices. Only a part of
> platform devices are not "real" hardware.
> 
> Smmu is a memory-mapped device. It is totally like most other platform
> devices populated in a memory space mapped in cpu's local space. It uses
> ioremap to map registers, use readl/writel to read/write its space.
> 
> > What platform device has this issue?  What one will show up this way
> > with the new patch?

Meanwhile, this patch also only shows numa_node for those platform devices with "real"
hardware and acpi support. For those platform devices which are not "real", numa_node
sys entry will not be created as dev_to_node(dev) == NUMA_NO_NODE.

For instances, 
smmu is a platform device with "real" hardware backend, it gets a numa_node like:

root@ubuntu:/sys/bus/platform/devices/arm-smmu-v3.0.auto# cat numa_node
0

root@ubuntu:/sys/bus/platform/devices/arm-smmu-v3.7.auto# cat numa_node
2

snd-soc-dummy is a platform device without "real" hardware, then it gets no numa_node:

root@ubuntu:/sys/bus/platform/devices/snd-soc-dummy# ls
driver  driver_override  modalias  power  subsystem  uevent

-barry

> 
> if platform device shouldn't be a real hardware, there is no platform device
> with a hardware topology.
> But platform devices are "real" hardware at most time. Smmu is a "real" device,
> but it is a platform device in Linux.
> 
> >
> > thanks,
> >
> > greg k-h
> 
> -barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
