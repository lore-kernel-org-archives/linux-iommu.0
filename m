Return-Path: <SRS0=1PsK=4P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE86C35DF9
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 18:19:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E801D246B2
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 18:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E801D246B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D87E4230A4;
	Thu, 27 Feb 2020 18:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WcVZk1xQM5wf; Thu, 27 Feb 2020 18:19:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C78552309D;
	Thu, 27 Feb 2020 18:19:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4AD7C08A0;
	Thu, 27 Feb 2020 18:19:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F04EC0177
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 09218864F3
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7lmvRoKwylvQ for <iommu@lists.linux-foundation.org>;
 Thu, 27 Feb 2020 18:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5465685B7C
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:19:30 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Feb 2020 10:19:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; d="scan'208";a="411120362"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by orsmga005.jf.intel.com with ESMTP; 27 Feb 2020 10:19:29 -0800
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 10:19:29 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.110]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.148]) with mapi id 14.03.0439.000;
 Thu, 27 Feb 2020 10:19:29 -0800
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "drake@endlessm.com" <drake@endlessm.com>
Subject: Re: [PATCH v4] iommu/vt-d: consider real PCI device when checking
 if mapping is needed
Thread-Topic: [PATCH v4] iommu/vt-d: consider real PCI device when checking
 if mapping is needed
Thread-Index: AQHV5tO6P1q7GPBOf0WbPL1Nv6XzmagiZPoAgAGRbgCAAGzJgIAAH1uAgAtqx4A=
Date: Thu, 27 Feb 2020 18:19:28 +0000
Message-ID: <199bcea7d614e57261ee34a02c8096e6ce725629.camel@intel.com>
References: <CAD8Lp47Bhv_58-Z+a+JFS9rTZW58_rWvE8N+XVtX7mmB-Tj55A@mail.gmail.com>
 <20200220100607.9044-1-drake@endlessm.com>
 <f8f494fa-3fc5-637a-ddab-0d25cc56262e@linux.intel.com>
In-Reply-To: <f8f494fa-3fc5-637a-ddab-0d25cc56262e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.4.216]
Content-ID: <31D2ACF0F3EB2344A785011624429961@intel.com>
MIME-Version: 1.0
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux@endlessm.com" <linux@endlessm.com>
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

Hi Baolu, Daniel,

Sorry for the delay. Was offline for the last week.

On Thu, 2020-02-20 at 19:58 +0800, Lu Baolu wrote:
> Hi,
> 
> On 2020/2/20 18:06, Daniel Drake wrote:
> > > On Wed, Feb 19, 2020 at 11:40 AM Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> > > > With respect, this is problematical. The parent and all subdevices share
> > > > a single translation entry. The DMA mask should be consistent.
> > > > 
> > > > Otherwise, for example, subdevice A has 64-bit DMA capability and uses
> > > > an identity domain for DMA translation. While subdevice B has 32-bit DMA
> > > > capability and is forced to switch to DMA domain. Subdevice A will be
> > > > impacted without any notification.
> > Looking closer, this problematic codepath may already be happening for VMD,
> > under intel_iommu_add_device(). Consider this function running for a VMD
> > subdevice, we hit:
> > 
> >      domain = iommu_get_domain_for_dev(dev);
> > 
> > I can't quite grasp the code flow here, but domain->type now always seems
> > to return the domain type of the real DMA device, which seems like pretty
> > reasonable behaviour.
> > 
> >      if (domain->type == IOMMU_DOMAIN_DMA) {
> > 
> > and as detailed in previous mails, the real VMD device seems to be in a DMA
> > domain by default, so we continue.
> > 
> >          if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
> > 
> > Now we checked the default domain type of the subdevice. This seems rather
> > likely to return IDENTITY because that's effectively the default type...
> > 
> >              ret = iommu_request_dm_for_dev(dev);
> >              if (ret) {
> >                  dmar_remove_one_dev_info(dev);
> >                  dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
> >                  domain_add_dev_info(si_domain, dev);
> >                  dev_info(dev,
> >                       "Device uses a private identity domain.\n");
> >              }
> >          }
> > 
> > and now we're doing the bad stuff that Lu pointed out: we only have one
> > mapping shared for all the subdevices, so if we end up changing it for one
> > subdevice, we're likely to be breaking another.
> 
> Yes. Agreed.
> 
> By the way, do all subdevices stay in a same iommu group?
> 
> Best regards,
> baolu


The VMD endpoint and all subdevices in the VMD domain are in the same
IOMMU group. The real dma device for VMD (the VMD endpoint) only
represents the DMA requester as determined by the PCIe source-id. The
VMD endpoint itself doesn't have a DMA engine so only the subdevices
matter for mapping.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
