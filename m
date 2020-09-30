Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200C8C47420
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 12:45:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98DC20789
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 12:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98DC20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 579A98669A;
	Wed, 30 Sep 2020 12:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zbj4zo0-8lDX; Wed, 30 Sep 2020 12:45:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9512386569;
	Wed, 30 Sep 2020 12:45:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 782DDC0889;
	Wed, 30 Sep 2020 12:45:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A2BAC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 12:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2ADBC20403
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 12:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GE0OaDNnWwhy for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 12:45:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id 7603B203EE
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 12:45:37 +0000 (UTC)
IronPort-SDR: F2JmUEmkBrMmJv4BwxeH7AvlgmuX5/XbCMKc40MAOy1nJb7fyH7E+m4I5Eqp6tsECxUUZtjvry
 ADwhQmeNHCGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="159774897"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="159774897"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 05:45:36 -0700
IronPort-SDR: eCF4X5a/gfpkch1z+Gghm8I69LMoYqlXRHSy3U79/H0p9P+ssLwnq/P9qK4gAmUKusgR7QnBwT
 59rJ3VZLCcBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="294597999"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2020 05:45:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Sep 2020 05:45:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Sep 2020 05:45:35 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 30 Sep 2020 05:45:30 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "jgg@nvidia.com"
 <jgg@nvidia.com>
Subject: Re: [patch V2 24/46] PCI: vmd: Mark VMD irqdomain with
 DOMAIN_BUS_VMD_MSI
Thread-Topic: [patch V2 24/46] PCI: vmd: Mark VMD irqdomain with
 DOMAIN_BUS_VMD_MSI
Thread-Index: AQHWe6Ci+RtSrJb+okaPJR2eu/FJZalSxzQAgC8GCIA=
Date: Wed, 30 Sep 2020 12:45:30 +0000
Message-ID: <1d284a478d4e5bf4a247ee83afa1b8b45f9e1b3f.camel@intel.com>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.047315047@linutronix.de>
 <20200831143940.GA1152540@nvidia.com>
In-Reply-To: <20200831143940.GA1152540@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.100]
Content-ID: <90C7529B4211014189DA743BA8288574@intel.com>
MIME-Version: 1.0
Cc: "sivanich@hpe.com" <sivanich@hpe.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "steve.wahl@hpe.com" <steve.wahl@hpe.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Lu, Baolu" <baolu.lu@intel.com>,
 "maz@kernel.org" <maz@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Dey, Megha" <megha.dey@intel.com>,
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

Hi Jason

On Mon, 2020-08-31 at 11:39 -0300, Jason Gunthorpe wrote:
> On Wed, Aug 26, 2020 at 01:16:52PM +0200, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Devices on the VMD bus use their own MSI irq domain, but it is not
> > distinguishable from regular PCI/MSI irq domains. This is required
> > to exclude VMD devices from getting the irq domain pointer set by
> > interrupt remapping.
> > 
> > Override the default bus token.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >  drivers/pci/controller/vmd.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -579,6 +579,12 @@ static int vmd_enable_domain(struct vmd_
> >  		return -ENODEV;
> >  	}
> >  
> > +	/*
> > +	 * Override the irq domain bus token so the domain can be distinguished
> > +	 * from a regular PCI/MSI domain.
> > +	 */
> > +	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
> > +
> 
> Having the non-transparent-bridge hold a MSI table and
> multiplex/de-multiplex IRQs looks like another good use case for
> something close to pci_subdevice_msi_create_irq_domain()?
> 
> If each device could have its own internal MSI-X table programmed
> properly things would work alot better. Disable capture/remap of the
> MSI range in the NTB.
We can disable the capture and remap in newer devices so we don't even
need the irq domain. Legacy VMD will automatically remap based on the
APIC dest bits in the MSI address.

I would however like to determine if the MSI data bits could be used
for individual devices to have the IRQ domain subsystem demultiplex the
virq from that and eliminate the IRQ list iteration.

A concern I have about that scheme is virtualization as I think those
bits are used to route to the virtual vector.

> 
> Then each device could have a proper non-multiplexed interrupt
> delivered to the CPU.. Affinity would work properly, no need to share
> IRQs (eg vmd_irq() goes away)/etc.
> 
> Something for the VMD maintainers to think about at least.
> 
> As I hear more about NTB these days a full MSI scheme for NTB seems
> interesting to have in the PCI-E core code..
> 
> Jason


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
