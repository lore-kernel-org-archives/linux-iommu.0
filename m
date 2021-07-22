Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81026C6377D
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 13:35:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2577860FF2
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 13:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2577860FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBA584014A;
	Thu, 22 Jul 2021 13:34:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YEiU2RGX_rFt; Thu, 22 Jul 2021 13:34:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC0AA400F4;
	Thu, 22 Jul 2021 13:34:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93185C0010;
	Thu, 22 Jul 2021 13:34:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1B40C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 13:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA6ED605A5
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 13:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmXzpESoir57 for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 13:34:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEBEE605B5
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 13:34:55 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C2E9867373; Thu, 22 Jul 2021 15:34:50 +0200 (CEST)
Date: Thu, 22 Jul 2021 15:34:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210722133450.GA29155@lst.de>
References: <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
 <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca> <YKJnPGonR+d8rbu/@8bytes.org>
 <20210517133500.GP1096940@ziepe.ca> <YKKNLrdQ4QjhLrKX@8bytes.org>
 <BN9PR11MB54331FC6BB31E8CBF11914A48C019@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB54331FC6BB31E8CBF11914A48C019@BN9PR11MB5433.namprd11.prod.outlook.com>
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

On Wed, Jun 30, 2021 at 09:08:19AM +0000, Tian, Kevin wrote:
> The iommu layer should maintain above attaching status per device and per
> iommu domain. There is no mdev/subdev concept in the iommu layer. It's
> just about RID or PASID.

Yes, I think that makes sense.

> And a new set of IOMMU-API:
> 
>     - iommu_{un}bind_pgtable(domain, dev, addr);
>     - iommu_{un}bind_pgtable_pasid(domain, dev, addr, pasid);
>     - iommu_cache_invalidate(domain, dev, invalid_info);

What caches is this supposed to "invalidate"?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
