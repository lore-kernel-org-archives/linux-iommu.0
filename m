Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29397C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 06:11:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59D3206A2
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 06:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n87q5ssQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59D3206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 87DA120C41;
	Tue,  2 Jun 2020 06:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4iOyKukFoNUl; Tue,  2 Jun 2020 06:11:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 12C9021549;
	Tue,  2 Jun 2020 06:11:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E20D3C0178;
	Tue,  2 Jun 2020 06:11:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88559C0176
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 06:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 762D98807C
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 06:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nFHq44ChGkKs for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 06:11:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DE62C8807B
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 06:11:15 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 063F2206A2;
 Tue,  2 Jun 2020 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591078275;
 bh=S9BDyCPZ3sQBve1F7WjZIz76qdGdT07Qbc97K/4Wka8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n87q5ssQcTPcbQPy4ii4n0LRx2wpWrJK9vvsAw36MC/vsEKsffyUpXOPjcSlIES5S
 7xuP9hHliVR4456n+8uSoDhnx0jlpwwagPijeMfWRc12Xan8GvfXsYVOEzPi+TcaCf
 ZWUj/cuJlMa/67FTh0lUj8p8GeGkZ8AozWLEYUvE=
Date: Tue, 2 Jun 2020 08:11:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] driver core: platform: expose numa_node to users in sysfs
Message-ID: <20200602061112.GC2256033@kroah.com>
References: <20200602030139.73012-1-song.bao.hua@hisilicon.com>
 <20200602042340.GA2130884@kroah.com>
 <B926444035E5E2439431908E3842AFD24D8F9E@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD24D8F9E@DGGEMI525-MBS.china.huawei.com>
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

On Tue, Jun 02, 2020 at 05:09:57AM +0000, Song Bao Hua (Barry Song) wrote:
> > >
> > > Platform devices are NUMA?  That's crazy, and feels like a total abuse
> > > of platform devices and drivers that really should belong on a "real"
> > > bus.
> > 
> > I am not sure if it is an abuse of platform device. But smmu is a platform
> > device,
> > drivers/iommu/arm-smmu-v3.c is a platform driver.
> > In a typical ARM server, there are maybe multiple SMMU devices which can
> > support
> > IO virtual address and page tables for other devices on PCI-like busses.
> > Each different SMMU device might be close to different NUMA node. There is
> > really a hardware topology.
> > 
> > If you have multiple CPU packages in a NUMA server, some platform devices
> > might
> > Belong to CPU0, some other might belong to CPU1.
> 
> Those devices are populated by acpi_iort for an ARM server:
> 
> drivers/acpi/arm64/iort.c:
> 
> static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
>         .name = "arm-smmu-v3",
>         .dev_dma_configure = arm_smmu_v3_dma_configure,
>         .dev_count_resources = arm_smmu_v3_count_resources,
>         .dev_init_resources = arm_smmu_v3_init_resources,
>         .dev_set_proximity = arm_smmu_v3_set_proximity,
> };
> 
> void __init acpi_iort_init(void)
> {
>         acpi_status status;
> 
>         status = acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
>         ...
>         iort_check_id_count_workaround(iort_table);
>         iort_init_platform_devices();
> }
> 
> static void __init iort_init_platform_devices(void)
> {
>         ...
> 
>         for (i = 0; i < iort->node_count; i++) {
>                 if (iort_node >= iort_end) {
>                         pr_err("iort node pointer overflows, bad table\n");
>                         return;
>                 }
> 
>                 iort_enable_acs(iort_node);
> 
>                 ops = iort_get_dev_cfg(iort_node);
>                 if (ops) {
>                         fwnode = acpi_alloc_fwnode_static();
>                         if (!fwnode)
>                                 return;
> 
>                         iort_set_fwnode(iort_node, fwnode);
> 
>                         ret = iort_add_platform_device(iort_node, ops);
>                         if (ret) {
>                                 iort_delete_fwnode(iort_node);
>                                 acpi_free_fwnode_static(fwnode);
>                                 return;
>                         }
>                 }
> 
>                 ...
>         }
> ...
> }
> 
> NUMA node is got from ACPI:
> 
> static int  __init arm_smmu_v3_set_proximity(struct device *dev,
>                                               struct acpi_iort_node *node)
> {
>         struct acpi_iort_smmu_v3 *smmu;
> 
>         smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>         if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
>                 int dev_node = acpi_map_pxm_to_node(smmu->pxm);
> 
>                 ...
> 
>                 set_dev_node(dev, dev_node);
>                 ...
>         }
>         return 0;
> }
> 
> Barry

That's fine, but those are "real" devices, not platform devices, right?

What platform device has this issue?  What one will show up this way
with the new patch?

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
