Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177A8C35666
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 20:20:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D945B2064C
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 20:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D945B2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AEAAD880F4;
	Fri, 21 Feb 2020 20:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ANNuUBqBba7J; Fri, 21 Feb 2020 20:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 473AD88084;
	Fri, 21 Feb 2020 20:20:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 324D6C07FE;
	Fri, 21 Feb 2020 20:20:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5700EC013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 20:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5077D86168
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 20:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wiCHTYsNFh9L for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 20:20:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C2800860FD
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 20:20:01 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Feb 2020 12:20:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; d="scan'208";a="316156726"
Received: from jacob-xps-13-9365.jf.intel.com (HELO jacob-XPS-13-9365)
 ([10.54.75.153])
 by orsmga001.jf.intel.com with ESMTP; 21 Feb 2020 12:19:55 -0800
Date: Fri, 21 Feb 2020 12:20:04 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V9 07/10] iommu/vt-d: Cache virtual command capability
 register
Message-ID: <20200221122004.0307c789@jacob-XPS-13-9365>
In-Reply-To: <5776bf45-7541-1576-9ced-38883447bf29@redhat.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277713-66934-8-git-send-email-jacob.jun.pan@linux.intel.com>
 <5776bf45-7541-1576-9ced-38883447bf29@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Wed, 12 Feb 2020 14:00:22 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 1/29/20 7:01 AM, Jacob Pan wrote:
> > Virtual command registers are used in the guest only, to prevent
> > vmexit cost, we cache the capability and store it during
> > initialization.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> I sent my R-b in https://lkml.org/lkml/2019/11/8/228
> Also Baolo did. Do I miss any change?
> 
> Again history log would help.
> 
You didn't miss any change. I forgot to add R-bs.

Thanks!

Jacob

> Thanks
> 
> Eric
>  [...]  
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
