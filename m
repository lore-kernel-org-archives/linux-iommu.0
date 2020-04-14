Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0F9C2BA19
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 16:00:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA84620656
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 16:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA84620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A7E428574F;
	Tue, 14 Apr 2020 16:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqmqZmgHSbyO; Tue, 14 Apr 2020 16:00:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 249D884D74;
	Tue, 14 Apr 2020 16:00:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 054DDC1D7D;
	Tue, 14 Apr 2020 16:00:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFAEFC0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 16:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D7D3287B4D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 16:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1b5PDMRp77Qv for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 16:00:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9436A87AFE
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 16:00:42 +0000 (UTC)
IronPort-SDR: wQxqXLsZa+liNrfmPcoh5MH6bpKZ3ST3H6ml/Xkav8gUIk8oONrhRtLD/KPx3GbaybZZo54Jci
 eHH7isJ1Kxyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 09:00:41 -0700
IronPort-SDR: FM4ZlxhcT/aVlmT/AZL2mrP/IwuvOXgnjOtMwfo/CPoCI2buYptuu+D3vIGFEttw4e8azX4WEW
 IGORjgXUp+3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; d="scan'208";a="399994497"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 14 Apr 2020 09:00:41 -0700
Date: Tue, 14 Apr 2020 09:06:36 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200414090636.1798d0c2@jacob-builder>
In-Reply-To: <20200414081107.GA7315@infradead.org>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
 <20200327074702.GA27959@infradead.org>
 <20200327165335.397f24a3@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
 <20200330090746.23c5599c@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
 <20200331085444.44bee0bb@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
 <20200402113604.6eea1e6f@jacob-builder>
 <20200413134157.395981a6@jacob-builder>
 <20200414081107.GA7315@infradead.org>
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

On Tue, 14 Apr 2020 01:11:07 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Apr 13, 2020 at 01:41:57PM -0700, Jacob Pan wrote:
> > Hi All,
> > 
> > Just a gentle reminder, any feedback on the options I listed below?
> > New ideas will be even better.
> > 
> > Christoph, does the explanation make sense to you? We do have the
> > capability/flag based scheme for IOMMU API extension, the version is
> > mainly used for size lookup. Compatibility checking is another use
> > of the version, it makes checking easy when a vIOMMU is launched.  
> 
> No.  If you truely need different versions use different ioctl
> identifiers.
OK. I will drop the global version and keep the current per API/IOCTL
struct.

>  If it really is just the size pass the size and not a
> version.
OK, I think we have a path forward. I will remove the size-version
lookup.

My concern was that since we cannot trust the size provided by
userspace. We must sanity check the argsz based on knowledge of the
struct within the kernel. AFAIK, VFIO does this check by looking at
offsetofend(user_struct, last_element). But in this case, VFIO is not
the end consumer, and last_element can be a variable size union.
So we'd better let IOMMU driver deal with it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
