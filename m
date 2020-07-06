Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A8AC433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 08:28:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39FF20724
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 08:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39FF20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6E30086D0F;
	Mon,  6 Jul 2020 08:28:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mSlmiCLcXSXK; Mon,  6 Jul 2020 08:28:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BAF6786CE7;
	Mon,  6 Jul 2020 08:28:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EB6DC0893;
	Mon,  6 Jul 2020 08:28:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED8AC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 08:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 259CE864EC
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 08:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6AdTLABJ0ZJ8 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 08:27:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CAAE686456
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 08:27:57 +0000 (UTC)
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 2B8676C15A69DC7537E0;
 Mon,  6 Jul 2020 09:27:55 +0100 (IST)
Received: from localhost (10.52.123.111) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 6 Jul 2020
 09:27:54 +0100
Date: Mon, 6 Jul 2020 09:26:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: expose numa_node attribute to users
 in sysfs
Message-ID: <20200706092649.0000676d@Huawei.com>
In-Reply-To: <B926444035E5E2439431908E3842AFD25559F2@DGGEMI525-MBS.china.huawei.com>
References: <20200530091505.56664-1-song.bao.hua@hisilicon.com>
 <20200703162137.GA19780@willie-the-truck>
 <B926444035E5E2439431908E3842AFD25559F2@DGGEMI525-MBS.china.huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.52.123.111]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Brice Goglin <Brice.Goglin@inria.fr>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
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


+CC Brice.  

On Sun, 5 Jul 2020 09:53:58 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Will Deacon [mailto:will@kernel.org]
> > Sent: Saturday, July 4, 2020 4:22 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: robin.murphy@arm.com; hch@lst.de; m.szyprowski@samsung.com;
> > iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> > Linuxarm <linuxarm@huawei.com>
> > Subject: Re: [PATCH] iommu/arm-smmu-v3: expose numa_node attribute to
> > users in sysfs
> > 
> > On Sat, May 30, 2020 at 09:15:05PM +1200, Barry Song wrote:  
> > > As tests show the latency of dma_unmap can increase dramatically while
> > > calling them cross NUMA nodes, especially cross CPU packages, eg.
> > > 300ns vs 800ns while waiting for the completion of CMD_SYNC in an
> > > empty command queue. The large latency causing by remote node will
> > > in turn make contention of the command queue more serious, and enlarge
> > > the latency of DMA users within local NUMA nodes.
> > >
> > > Users might intend to enforce NUMA locality with the consideration of
> > > the position of SMMU. The patch provides minor benefit by presenting
> > > this information to users directly, as they might want to know it without
> > > checking hardware spec at all.  
> > 
> > I don't think that's a very good reason to expose things to userspace.
> > I know sysfs shouldn't be treated as ABI, but the grim reality is that
> > once somebody relies on this stuff then we can't change it, so I'd
> > rather avoid exposing it unless it's absolutely necessary.  
> 
> Will, thanks for taking a look!
> 
> I am not sure if it is absolutely necessary, but it is useful to users. The whole story started
> from some users who wanted to know the hardware topology very clear by reading some
> sysfs node just like they are able to do that for pci devices. The intention is that users can
> know hardware topology of various devices easily from linux since they maybe don't know
> all the hardware details.
> 
> For pci devices, kernel has done that. And there are some other drivers out of pci
> exposing numa_node as well. It seems it is hard to say it is absolutely necessary
> for them too since sysfs shouldn't be treated as ABI. 
Brice,

Given hwloc is probably the most demanding user of topology information
currently...

How useful would this info be for hwloc and hwloc users?
Sort of feels like it might be useful in some cases.

The very brief description of what we have here is exposing the numa node
of an IOMMU.  The discussion also diverted into whether it just makes sense
to expose this for all platform devices or even do it at the device level.

Jonathan


> 
> I got some input from Linux users who also wanted to know the numa node for
> other devices which are not PCI, for example, platform devices. And I thought the
> requirement is kind of reasonable. So I also had another patch to generally support
> this kind of requirements, with the below patch, this smmu patch is not necessary
> any more:
> https://lkml.org/lkml/2020/6/18/1257
> 
> for platform device created by ARM ACPI/IORT and general acpi_create_platform_device()
> drivers/acpi/scan.c:
> static void acpi_default_enumeration(struct acpi_device *device)
> {
> 	...
> 	if (!device->flags.enumeration_by_parent) {
> 		acpi_create_platform_device(device, NULL);
> 		acpi_device_set_enumerated(device);
> 	}
> }
> 
> struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
> 					struct property_entry *properties)
> {
> 	...
> 
> 	pdev = platform_device_register_full(&pdevinfo);
> 	if (IS_ERR(pdev))
> 		...
> 	else {
> 		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
> 		...
> 	}
> 	...
> }
> numa_node is set for this kind of devices.
> 
> Anyway, just want to explain to you the background some people want to know the 
> hardware topology from Linux in same simple way. And it seems it is a reasonable
> requirement to me :-)
> 
> > 
> > Thanks,
> > 
> > Will  
> 
> Thanks
> barry
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
