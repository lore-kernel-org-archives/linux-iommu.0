Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD4FC282DA
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 16:41:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455842084F
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 16:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455842084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2C363D8B;
	Tue,  9 Apr 2019 16:41:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F29EAD84
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 16:41:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D4C2B76D
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 16:41:47 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Apr 2019 09:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; d="scan'208";a="221936212"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2019 09:41:47 -0700
Date: Tue, 9 Apr 2019 09:44:21 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 05/18] iommu: introduce device fault data
Message-ID: <20190409094421.7d5bffca@jacob-builder>
In-Reply-To: <20190409100315.GD9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20190409100315.GD9224@smile.fi.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Liu@smile.fi.intel.com, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409164421.8PJSuSH2OB_8-Q2N4VQNkvIuEz1pk1Ogm5HKhdWo6fM@z>

On Tue, 9 Apr 2019 13:03:15 +0300
Andriy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 08, 2019 at 04:59:20PM -0700, Jacob Pan wrote:
> > Device faults detected by IOMMU can be reported outside the IOMMU
> > subsystem for further processing. This patch introduces
> > a generic device fault data structure.
> > 
> > The fault can be either an unrecoverable fault or a page request,
> > also referred to as a recoverable fault.
> > 
> > We only care about non internal faults that are likely to be
> > reported to an external subsystem.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>  
> 
> JFYI: we have a Co-developed-by tag as well for better granularity of
> what certain person/people did.
> 
Good to know, thank!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
