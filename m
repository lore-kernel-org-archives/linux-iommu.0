Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA7C2D0EC
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 23:47:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279532071B
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 23:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279532071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E443089631;
	Fri, 27 Mar 2020 23:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k72M5u9lrGBD; Fri, 27 Mar 2020 23:47:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 198488962E;
	Fri, 27 Mar 2020 23:47:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02E66C1D7C;
	Fri, 27 Mar 2020 23:47:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65F07C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 23:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 61E1E87931
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 23:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ccjypzlGXWuC for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 23:47:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2A31B8791B
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 23:47:51 +0000 (UTC)
IronPort-SDR: uUce3k9LE+2uKxxRDQDD/V/3vdwhJ90fvg//zX+JCR9Tulzv54nHeb7RF0IyM0SZVV/P6Bzyei
 olZvq+ZAsE+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 16:47:50 -0700
IronPort-SDR: qlJo1yoZnNpykM2wi0KZD8GSGBaxeWa+7YA/XlRIpYQ3fJ2YnszxrD/P8TWLiGXMMqLuYuMWj6
 c5hhbWPQFp3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; d="scan'208";a="447595129"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2020 16:47:49 -0700
Date: Fri, 27 Mar 2020 16:53:35 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200327165335.397f24a3@jacob-builder>
In-Reply-To: <20200327074702.GA27959@infradead.org>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200326092316.GA31648@infradead.org>
 <20200326094442.5be042ce@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
 <20200327074702.GA27959@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, 27 Mar 2020 00:47:02 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian, Kevin wrote:
> > If those API calls are inter-dependent for composing a feature
> > (e.g. SVA), shouldn't we need a way to check them together before
> > exposing the feature to the guest, e.g. through a
> > iommu_get_uapi_capabilities interface?  
> 
> Yes, that makes sense.  The important bit is to have a capability
> flags and not version numbers.

The challenge is that there are two consumers in the kernel for this.
1. VFIO only look for compatibility, and size of each data struct such
that it can copy_from_user.

2. IOMMU driver, the "real consumer" of the content.

For 2, I agree and we do plan to use the capability flags to check
content and maintain backward compatibility etc.

For VFIO, it is difficult to do size look up based on capability flags.


Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
