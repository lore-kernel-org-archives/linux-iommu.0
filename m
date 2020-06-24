Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBA0C433DF
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 15:41:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25ADD20706
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 15:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ADD20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE08487A33;
	Wed, 24 Jun 2020 15:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9HAb8KCSj-i5; Wed, 24 Jun 2020 15:41:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E59A879EF;
	Wed, 24 Jun 2020 15:41:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69E13C088E;
	Wed, 24 Jun 2020 15:41:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91D8AC016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 15:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7838C2010A
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 15:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5+EJMd0OeeCq for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 15:41:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 767DA2001C
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 15:41:31 +0000 (UTC)
IronPort-SDR: JMPUnktu5toWGWSc4RRTnbmmXlVlieKxj4DLArFAQxhB9v9xryR35wEQ00AZpUPgXWEANbKfIF
 WojKqWzxrrGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="131945586"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; d="scan'208";a="131945586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 08:41:29 -0700
IronPort-SDR: rzdLG36kkSS7oyD7HLRd8ixwCO09LluAN6+s2jm/57l2vznZFZ8k/4vp/rSV+PmGUhPAWXkTGI
 EZ7XvfSZV1wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; d="scan'208";a="275729014"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 24 Jun 2020 08:41:29 -0700
Date: Wed, 24 Jun 2020 08:48:01 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 3/5] iommu/uapi: Use named union for user data
Message-ID: <20200624084801.297c9c0b@jacob-builder>
In-Reply-To: <96f6d717-e9b3-2a6b-5cff-c38dbe97aa7c@linux.intel.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592931837-58223-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <96f6d717-e9b3-2a6b-5cff-c38dbe97aa7c@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Wed, 24 Jun 2020 14:29:57 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> >   		case IOMMU_CACHE_INV_TYPE_IOTLB:
> >   			/* HW will ignore LSB bits based on
> > address mask */ if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> >   			    size &&
> > -			    (inv_info->addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> > +				(inv_info->granu.addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {  
> 
> Nit: Keep it aligned. With this tweaked,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
will do. Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
