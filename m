Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45738C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 20:43:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3022076B
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 20:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3022076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D678220554;
	Mon,  1 Jun 2020 20:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRKfSkMJqUIS; Mon,  1 Jun 2020 20:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 73FB020518;
	Mon,  1 Jun 2020 20:43:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 588A8C0178;
	Mon,  1 Jun 2020 20:43:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72EDAC0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 20:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6E43986D78
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 20:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jTCJaMe7IFXu for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 20:43:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E5E686BAF
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 20:43:26 +0000 (UTC)
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 4198766B57FCA23C5AD2;
 Tue,  2 Jun 2020 04:43:23 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.10]) by
 dggemi406-hub.china.huawei.com ([10.3.17.144]) with mapi id 14.03.0487.000;
 Tue, 2 Jun 2020 04:43:15 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Robin Murphy <robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>, 
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] iommu/arm-smmu-v3: expose numa_node attribute to users
 in sysfs
Thread-Topic: [PATCH] iommu/arm-smmu-v3: expose numa_node attribute to users
 in sysfs
Thread-Index: AQHWNmL+BAaoTPaXd0CO3TAe6c7BnKjDOhgAgAD/rYA=
Date: Mon, 1 Jun 2020 20:43:14 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24D83EB@DGGEMI525-MBS.china.huawei.com>
References: <20200530091505.56664-1-song.bao.hua@hisilicon.com>
 <4e902884-7ac3-9e79-ec01-f56f2fc5ebad@arm.com>
In-Reply-To: <4e902884-7ac3-9e79-ec01-f56f2fc5ebad@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.97]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
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



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Tuesday, June 2, 2020 1:14 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; will@kernel.org;
> hch@lst.de; m.szyprowski@samsung.com; iommu@lists.linux-foundation.org
> Cc: Linuxarm <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] iommu/arm-smmu-v3: expose numa_node attribute to
> users in sysfs
> 
> On 2020-05-30 10:15, Barry Song wrote:
> > As tests show the latency of dma_unmap can increase dramatically while
> > calling them cross NUMA nodes, especially cross CPU packages, eg.
> > 300ns vs 800ns while waiting for the completion of CMD_SYNC in an
> > empty command queue. The large latency causing by remote node will
> > in turn make contention of the command queue more serious, and enlarge
> > the latency of DMA users within local NUMA nodes.
> >
> > Users might intend to enforce NUMA locality with the consideration of
> > the position of SMMU. The patch provides minor benefit by presenting
> > this information to users directly, as they might want to know it without
> > checking hardware spec at all.
> 
> Hmm, given that dev-to_node() is a standard driver model thing, is there
> not already some generic device property that can expose it - and if
> not, should there be? Presumably if userspace cares enough to want to
> know whereabouts in the system an IOMMU is, it probably also cares where
> the actual endpoint devices are too.
> 
> At the very least, it doesn't seem right for it to be specific to one
> single IOMMU driver.

Right now pci devices have generally got the numa_node in sysfs by drivers/pci/pci-sysfs.c

static ssize_t numa_node_store(struct device *dev,
                               struct device_attribute *attr, const char *buf,
                               size_t count)
{
        ...

        add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
        pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
                  node);

        dev->numa_node = node;
        return count;
}

static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
                              char *buf)
{
        return sprintf(buf, "%d\n", dev->numa_node);
}
static DEVICE_ATTR_RW(numa_node);

for other devices who care about numa information, the specific drivers are doing that, for example:

drivers/dax/bus.c:      if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
drivers/dax/bus.c:      &dev_attr_numa_node.attr,
drivers/dma/idxd/sysfs.c:       &dev_attr_numa_node.attr,
drivers/hv/vmbus_drv.c: &dev_attr_numa_node.attr,
drivers/nvdimm/bus.c:   &dev_attr_numa_node.attr,
drivers/nvme/host/core.c:       &dev_attr_numa_node.attr,

smmu is usually a platform device, we can actually expose numa_node for platform_device, or globally expose numa_node
for general "device" if people don't opposite.

Barry

> 
> Robin.
> 
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >   drivers/iommu/arm-smmu-v3.c | 40
> ++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 82508730feb7..754c4d59498b 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -4021,6 +4021,44 @@ err_reset_pci_ops: __maybe_unused;
> >   	return err;
> >   }
> >
> > +static ssize_t numa_node_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "%d\n", dev_to_node(dev));
> > +}
> > +static DEVICE_ATTR_RO(numa_node);
> > +
> > +static umode_t arm_smmu_numa_attr_visible(struct kobject *kobj, struct
> attribute *a,
> > +		int n)
> > +{
> > +	struct device *dev = container_of(kobj, typeof(*dev), kobj);
> > +
> > +	if (!IS_ENABLED(CONFIG_NUMA))
> > +		return 0;
> > +
> > +	if (a == &dev_attr_numa_node.attr &&
> > +			dev_to_node(dev) == NUMA_NO_NODE)
> > +		return 0;
> > +
> > +	return a->mode;
> > +}
> > +
> > +static struct attribute *arm_smmu_dev_attrs[] = {
> > +	&dev_attr_numa_node.attr,
> > +	NULL
> > +};
> > +
> > +static struct attribute_group arm_smmu_dev_attrs_group = {
> > +	.attrs          = arm_smmu_dev_attrs,
> > +	.is_visible     = arm_smmu_numa_attr_visible,
> > +};
> > +
> > +
> > +static const struct attribute_group *arm_smmu_dev_attrs_groups[] = {
> > +	&arm_smmu_dev_attrs_group,
> > +	NULL,
> > +};
> > +
> >   static int arm_smmu_device_probe(struct platform_device *pdev)
> >   {
> >   	int irq, ret;
> > @@ -4097,7 +4135,7 @@ static int arm_smmu_device_probe(struct
> platform_device *pdev)
> >   		return ret;
> >
> >   	/* And we're up. Go go go! */
> > -	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
> > +	ret = iommu_device_sysfs_add(&smmu->iommu, dev,
> arm_smmu_dev_attrs_groups,
> >   				     "smmu3.%pa", &ioaddr);
> >   	if (ret)
> >   		return ret;
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
