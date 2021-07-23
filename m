Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F63C432BE
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 05:41:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E72460F02
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 05:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E72460F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 601A2401D9;
	Fri, 23 Jul 2021 05:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JGtkpSp3zaHx; Fri, 23 Jul 2021 05:41:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 22B43401BC;
	Fri, 23 Jul 2021 05:41:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03AFCC001A;
	Fri, 23 Jul 2021 05:41:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8991C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 05:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D061840153
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 05:41:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vj8N61rbvi8T for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 05:41:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40EF340004
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 05:41:11 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E180A67373; Fri, 23 Jul 2021 07:41:06 +0200 (CEST)
Date: Fri, 23 Jul 2021 07:41:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210723054106.GA31771@lst.de>
References: <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca> <YKJnPGonR+d8rbu/@8bytes.org>
 <20210517133500.GP1096940@ziepe.ca> <YKKNLrdQ4QjhLrKX@8bytes.org>
 <BN9PR11MB54331FC6BB31E8CBF11914A48C019@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210722133450.GA29155@lst.de>
 <BN9PR11MB5433440EED4E291C0DCD44BA8CE59@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433440EED4E291C0DCD44BA8CE59@BN9PR11MB5433.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@lst.de>,
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

On Fri, Jul 23, 2021 at 05:36:17AM +0000, Tian, Kevin wrote:
> > > And a new set of IOMMU-API:
> > >
> > >     - iommu_{un}bind_pgtable(domain, dev, addr);
> > >     - iommu_{un}bind_pgtable_pasid(domain, dev, addr, pasid);
> > >     - iommu_cache_invalidate(domain, dev, invalid_info);
> > 
> > What caches is this supposed to "invalidate"?
> 
> pasid cache, iotlb or dev_iotlb entries that are related to the bound 
> pgtable. the actual affected cache type and granularity (device-wide,
> pasid-wide, selected addr-range) are specified by the caller.

Maybe call it pgtable_invalidate or similar?  To avoid confusing it
with the CPUs dcache.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
