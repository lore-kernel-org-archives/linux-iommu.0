Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0028EC433DF
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 20:57:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C202078A
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 20:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C202078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD6968835A;
	Wed, 26 Aug 2020 20:57:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NxrzCK3w0i3g; Wed, 26 Aug 2020 20:57:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D9CB7882EC;
	Wed, 26 Aug 2020 20:57:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF04EC016F;
	Wed, 26 Aug 2020 20:57:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AB8AC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 20:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 189E9866A3
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 20:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ud9vwcl7nLwi for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 20:57:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 78BD787727
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 20:57:39 +0000 (UTC)
IronPort-SDR: AnGs0idd8QwTX93kVdM5/SgbaBsyEmzujZ1xUV6fHAbW6PA54HIMAHJyptalJFnDmynlYhvyOH
 lHCH2th9s0jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136449748"
X-IronPort-AV: E=Sophos;i="5.76,357,1592895600"; d="scan'208";a="136449748"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 13:57:39 -0700
IronPort-SDR: uWEevjo2fcSLS632lk5XvO4XX4B7UKiqIdkS0Y90NWd9XPgDl0SbIVpxAt9IDuzj/jQabTIcbh
 D+Zjh/W/gpjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,357,1592895600"; d="scan'208";a="323341367"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com)
 ([10.18.84.213])
 by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2020 13:57:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 13:57:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 13:57:37 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 26 Aug 2020 13:57:37 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "maz@kernel.org" <maz@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>
Subject: Re: [patch V2 23/46] irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
Thread-Topic: [patch V2 23/46] irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
Thread-Index: AQHWe6ChLzvzi3ZHs0+G2tRNy2Bxi6lLUO2AgAACG4A=
Date: Wed, 26 Aug 2020 20:57:37 +0000
Message-ID: <0d68de22e417e73b17410172fae9414bf9ac455b.camel@intel.com>
References: <20200826111628.794979401@linutronix.de>
 <20200826112332.954409970@linutronix.de> <875z952l6w.wl-maz@kernel.org>
In-Reply-To: <875z952l6w.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.222.2]
Content-ID: <8982C94C84D0124FB278E32A1F74E921@intel.com>
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
 "x86@kernel.org" <x86@kernel.org>, "jgg@mellanox.com" <jgg@mellanox.com>,
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

On Wed, 2020-08-26 at 21:42 +0100, Marc Zyngier wrote:
> On Wed, 26 Aug 2020 12:16:51 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > PCI devices behind a VMD bus are not subject to interrupt remapping, but
> > the irq domain for VMD MSI cannot be distinguished from a regular PCI/MSI
> > irq domain.
> > 
> > Add a new domain bus token and allow it in the bus token check in
> > msi_check_reservation_mode() to keep the functionality the same once VMD
> > uses this token.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > ---
> >  include/linux/irqdomain.h |    1 +
> >  kernel/irq/msi.c          |    7 ++++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > --- a/include/linux/irqdomain.h
> > +++ b/include/linux/irqdomain.h
> > @@ -84,6 +84,7 @@ enum irq_domain_bus_token {
> >  	DOMAIN_BUS_FSL_MC_MSI,
> >  	DOMAIN_BUS_TI_SCI_INTA_MSI,
> >  	DOMAIN_BUS_WAKEUP,
> > +	DOMAIN_BUS_VMD_MSI,
> >  };
> >  
> >  /**
> > --- a/kernel/irq/msi.c
> > +++ b/kernel/irq/msi.c
> > @@ -370,8 +370,13 @@ static bool msi_check_reservation_mode(s
> >  {
> >  	struct msi_desc *desc;
> >  
> > -	if (domain->bus_token != DOMAIN_BUS_PCI_MSI)
> > +	switch(domain->bus_token) {
> > +	case DOMAIN_BUS_PCI_MSI:
> > +	case DOMAIN_BUS_VMD_MSI:
> > +		break;
> > +	default:
> >  		return false;
> > +	}
> >  
> >  	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
> >  		return false;
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> 	M.
> 

Acked-by: Jon Derrick <jonathan.derrick@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
