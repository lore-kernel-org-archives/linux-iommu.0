Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B225C47420
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 12:57:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1E52076E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 12:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fPKN+2fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1E52076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CCEC786658;
	Wed, 30 Sep 2020 12:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xd-iR5pmmLi5; Wed, 30 Sep 2020 12:57:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2B29286569;
	Wed, 30 Sep 2020 12:57:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 040CFC0889;
	Wed, 30 Sep 2020 12:57:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0DC6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 12:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CC6BB86658
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 12:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Ypf8-Z8vP9X for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 12:57:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AEAA186569
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 12:57:55 +0000 (UTC)
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f7480d10000>; Wed, 30 Sep 2020 20:57:53 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 12:57:38 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 12:57:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjpbJ1re4W/9wjakAEdLliBAhIS7pf5Q5JGD5OgKeU/xsXuufIHTsAIqNWVC3hFhp2bHFEZjB9Jx8YqbXbA3kBSBmyXz+IEepXO64I2x5GC2y0S63sd1FaJVn7DEPIKHdSsSPFoZTTHYfA8noAxpVGsmAmouHtREEx7qVzj0Hh/lOaBQoFbUuRMn3IYZbxnMhxgNVEhzmlEb9zwAhDBxRbeJ1KR7Oqn475Y8rlvAWSyiwEQzxbpTPeAy+OBbY0Lfbql9xTXvBXIXgbM2QtihuoMtCoS6nVVZGetrBSKUn4B/+vW1x6doREhxK/2yFmwEJytFxSoh3k6JQUrQd6nOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUH51rA3HlHLJikqE7iyQmhXDVNQppUQ5K9nEJCgL5c=;
 b=bHLxeNeEd5yreVY5bWEPVBzjz/N8kto8yHsB2Pni3Ev3qLkaP0jScx7dCJMZJKyxNcQwbZw+kdgfD/g6bwML5lBlBm1PVaZB1sKDRGqZFJavvYvbR4Zcu28jLuIDmJSXjwZ5RQyFQtjVuz5u4f1754SRED/IDMLA8mBUyAhCVDtdD8bkjh0QFeHeEq2w+XzHlt9k6fejiJ8V8WMWVfomOLCuiSyb5b4Q+HwHHRy2LPTkdQSDDUHwxVPgyN+GSbitbFe7abYnsZImhiVyZ6nobzfBdDsYFkKi/tQQCpsEDPI98wCqH+IUpQj/hOD47r2OSDWrmlGp5+TWpFTDC1myFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Wed, 30 Sep
 2020 12:57:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 12:57:35 +0000
Date: Wed, 30 Sep 2020 09:57:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: Re: [patch V2 24/46] PCI: vmd: Mark VMD irqdomain with
 DOMAIN_BUS_VMD_MSI
Message-ID: <20200930125733.GI816047@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.047315047@linutronix.de>
 <20200831143940.GA1152540@nvidia.com>
 <1d284a478d4e5bf4a247ee83afa1b8b45f9e1b3f.camel@intel.com>
Content-Disposition: inline
In-Reply-To: <1d284a478d4e5bf4a247ee83afa1b8b45f9e1b3f.camel@intel.com>
X-ClientProxiedBy: MN2PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:208:e8::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR20CA0001.namprd20.prod.outlook.com (2603:10b6:208:e8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Wed, 30 Sep 2020 12:57:34 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kNbfp-003wyO-G7; Wed, 30 Sep 2020 09:57:33 -0300
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601470673; bh=xUH51rA3HlHLJikqE7iyQmhXDVNQppUQ5K9nEJCgL5c=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-LD-Processed;
 b=fPKN+2fo1SWx2AFfe5Sod7f9GcDofAGU4IIDgZh0mVcj3B1tjR7IeNneStA1aOGzC
 NOGoR1HZLm7J4/GUqSByIVkuXKWqM7TZt1zIYQ0XN1nvDf1IEjZrBQuIRxASftKi5w
 l7dwWIEpLXdcJ18SDsti6YtKpaSGriuCPFH6FN5rMZ9jlBfxXSFfF1ULUhe5ETStkN
 UxSB9/A6OUo8Yi+1YdkuzuDfor8d+BSwbitLNqtZNlhWHXwyMsuon3UNFWr12sRDv8
 bmpsocyTHzbsSzP3naiUDslkYVwp2kFLDVW5WWjVPp6H1clZUbMP4lLuVKM+P7kzof
 /zTQVFzW2Vwdw==
Cc: "sivanich@hpe.com" <sivanich@hpe.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "steve.wahl@hpe.com" <steve.wahl@hpe.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Lu, Baolu" <baolu.lu@intel.com>,
 "maz@kernel.org" <maz@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Dey, Megha" <megha.dey@intel.com>,
 "jgross@suse.com" <jgross@suse.com>, "rja@hpe.com" <rja@hpe.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

On Wed, Sep 30, 2020 at 12:45:30PM +0000, Derrick, Jonathan wrote:
> Hi Jason
> 
> On Mon, 2020-08-31 at 11:39 -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 26, 2020 at 01:16:52PM +0200, Thomas Gleixner wrote:
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > Devices on the VMD bus use their own MSI irq domain, but it is not
> > > distinguishable from regular PCI/MSI irq domains. This is required
> > > to exclude VMD devices from getting the irq domain pointer set by
> > > interrupt remapping.
> > > 
> > > Override the default bus token.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >  drivers/pci/controller/vmd.c |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -579,6 +579,12 @@ static int vmd_enable_domain(struct vmd_
> > >  		return -ENODEV;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Override the irq domain bus token so the domain can be distinguished
> > > +	 * from a regular PCI/MSI domain.
> > > +	 */
> > > +	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
> > > +
> > 
> > Having the non-transparent-bridge hold a MSI table and
> > multiplex/de-multiplex IRQs looks like another good use case for
> > something close to pci_subdevice_msi_create_irq_domain()?
> > 
> > If each device could have its own internal MSI-X table programmed
> > properly things would work alot better. Disable capture/remap of the
> > MSI range in the NTB.

> We can disable the capture and remap in newer devices so we don't even
> need the irq domain.

You'd still need an irq domain, it just comes from
pci_subdevice_msi_create_irq_domain() instead of internal to this
driver.

> I would however like to determine if the MSI data bits could be used
> for individual devices to have the IRQ domain subsystem demultiplex the
> virq from that and eliminate the IRQ list iteration.

Yes, exactly. This new pci_subdevice_msi_create_irq_domain() creates
*proper* fully functional interrupts, no need for any IRQ handler in
this driver.

> A concern I have about that scheme is virtualization as I think those
> bits are used to route to the virtual vector.

It should be fine with this patch series, consult with Megha how
virtualization is working with IDXD/etc

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
