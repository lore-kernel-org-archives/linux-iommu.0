Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066FEC433DF
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 17:42:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34ED206DA
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 17:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34ED206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9FF8187447;
	Wed, 19 Aug 2020 17:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dI3rZxTEQnlU; Wed, 19 Aug 2020 17:42:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 157008731C;
	Wed, 19 Aug 2020 17:42:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE7AFC0889;
	Wed, 19 Aug 2020 17:42:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9368BC0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7E85C87D1D
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U4hlnDC0i3oc for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 17:42:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0304687D11
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:41:59 +0000 (UTC)
IronPort-SDR: k6/J25GjzGdaLUgcnTaSKg4LYc6V82TxuEKu/OMwf3Cbct5LQ4SW+lhmUbBClkLaXGAav10pIP
 N//EHeyZMDuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152580331"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="152580331"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 10:41:59 -0700
IronPort-SDR: /Gw14F3T8MavSsw3w+CZqaHM4PiaxwU3a5v7JUXi420k8E2r9jXx2lHUbjBfc2ZPH65C/BQLuH
 iWMvySpupPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="327159666"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 19 Aug 2020 10:41:56 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1k8S3s-009w8o-L8; Wed, 19 Aug 2020 20:39:44 +0300
Date: Wed, 19 Aug 2020 20:39:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 1/3] swiotlb: Use %pa to print phys_addr_t variables
Message-ID: <20200819173944.GR1891694@smile.fi.intel.com>
References: <20200819171326.35931-1-andriy.shevchenko@linux.intel.com>
 <CAOMZO5B9FGqSsnQcw1hhyOQnvkgxXK_xAkvNbjdtNuH+5V8kBA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5B9FGqSsnQcw1hhyOQnvkgxXK_xAkvNbjdtNuH+5V8kBA@mail.gmail.com>
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

On Wed, Aug 19, 2020 at 02:24:10PM -0300, Fabio Estevam wrote:
> On Wed, Aug 19, 2020 at 2:16 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > -       unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> > +       unsigned long mb = (io_tlb_nslabs << IO_TLB_SHIFT) >> 20;
> 
> Looks like an unrelated change.

To put pr_info() onto one (not so long) line. But of course, can leave it.

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
