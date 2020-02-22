Return-Path: <SRS0=f0z+=4K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65603C35669
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 23:39:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3767C206EF
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 23:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3767C206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 21F758791E;
	Sat, 22 Feb 2020 23:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zyww7TAiPqqO; Sat, 22 Feb 2020 23:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9938C8712D;
	Sat, 22 Feb 2020 23:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D07DC1AE2;
	Sat, 22 Feb 2020 23:39:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74BC2C013E
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 23:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E55C84481
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 23:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9rckYx6fdrv8 for <iommu@lists.linux-foundation.org>;
 Sat, 22 Feb 2020 23:39:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2B60384471
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 23:39:33 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 15:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,473,1574150400"; d="scan'208";a="255199489"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by orsmga002.jf.intel.com with ESMTP; 22 Feb 2020 15:39:32 -0800
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 22 Feb 2020 15:39:31 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.135]) with mapi id 14.03.0439.000;
 Sat, 22 Feb 2020 15:39:31 -0800
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH V2 1/5] iommu: Add dev_def_domain_type() call back
 function to iommu_ops
Thread-Topic: [PATCH V2 1/5] iommu: Add dev_def_domain_type() call back
 function to iommu_ops
Thread-Index: AQHV6dkGEw2IVdZfXkGFluqdj8ahSqgn3sWQ
Date: Sat, 22 Feb 2020 23:39:31 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F57205110@ORSMSX114.amr.corp.intel.com>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <297e01568e24d1537e0d7d6c088e363552b8ea49.1581619464.git.sai.praneeth.prakhya@intel.com>
 <7c34585c-0ec4-09d9-dd4a-604f196a2ca8@linux.intel.com>
In-Reply-To: <7c34585c-0ec4-09d9-dd4a-604f196a2ca8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

> 
> On 2020/2/17 5:57, Sai Praneeth Prakhya wrote:
> > When user requests kernel to change the default domain type of a group
> > through sysfs, kernel has to make sure that it's ok to change the
> > domain type of every device in the group to the requested domain
> > (every device may not support both the domain types i.e. DMA and
> > identity). Hence, add a call back function that could be implemented
> > per architecture that performs the above check.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Sohil Mehta <sohil.mehta@intel.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > ---
> >   include/linux/iommu.h | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > d1b5f4d98569..3f4aaad0aeb7 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -248,6 +248,7 @@ struct iommu_iotlb_gather {
> >    * @cache_invalidate: invalidate translation caches
> >    * @sva_bind_gpasid: bind guest pasid and mm
> >    * @sva_unbind_gpasid: unbind guest pasid and mm
> > + * @dev_def_domain_type: Return the required default domain type for
> > + a device
> 
> Can you please define the return value of this callback?

Sure! I will add it in the next version

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
