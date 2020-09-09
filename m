Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02926C433E2
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 16:03:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7517E206D4
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 16:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7517E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A975D86B62;
	Wed,  9 Sep 2020 16:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KMLLx1bpVk4B; Wed,  9 Sep 2020 16:03:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8C5386AF4;
	Wed,  9 Sep 2020 16:03:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6367C0859;
	Wed,  9 Sep 2020 16:03:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AA95C0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 16:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E55E686B26
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 16:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGlca7xSuPwd for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 16:03:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A283686AF4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 16:03:41 +0000 (UTC)
IronPort-SDR: dMpMUl/EfnOPMjyNGEY/DlBXXuwfXnFHUuSS1zwbzqBLviLD0fDQ0o0lypa/y3UezW7yzSZUJj
 1DjHEO/tkq8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146072540"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; d="scan'208";a="146072540"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2020 09:03:40 -0700
IronPort-SDR: xy3KDPmftNRmodzebQIyAY/hR5HldsxXFlM4S6TuinX2uomzlHcFUwtVYKM+MpuyiEfASAs+iI
 qjnlBVUq1STw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; d="scan'208";a="333865397"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 09 Sep 2020 09:03:38 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1kG2V7-00FTRl-Ap; Wed, 09 Sep 2020 18:59:13 +0300
Date: Wed, 9 Sep 2020 18:59:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/3] swiotlb: Use %pa to print phys_addr_t variables
Message-ID: <20200909155913.GF1891694@smile.fi.intel.com>
References: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CMBer5VBWz0ruUUtVM9V4p0bYaTnV_bJnrORzug2=0Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5CMBer5VBWz0ruUUtVM9V4p0bYaTnV_bJnrORzug2=0Aw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pci@vger.kernel.org,
 x86@kernel.org, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Sep 02, 2020 at 11:02:46PM -0300, Fabio Estevam wrote:
> On Wed, Sep 2, 2020 at 2:31 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There is an extension to a %p to print phys_addr_t type of variables.
> > Use it here.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: dropped bytes replacement (Fabio)
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks!

Guys, can this series be applied?

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
