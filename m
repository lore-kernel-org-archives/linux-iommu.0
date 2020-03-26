Return-Path: <SRS0=Ybkk=5L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B30AC43331
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 16:39:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD96B2078E
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 16:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD96B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 88A302153D;
	Thu, 26 Mar 2020 16:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CkR27t+OVDh7; Thu, 26 Mar 2020 16:39:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7804420360;
	Thu, 26 Mar 2020 16:39:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A4B6C1D7C;
	Thu, 26 Mar 2020 16:39:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAF65C0177
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 16:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D9ED02042A
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 16:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kA7UWb6Tun79 for <iommu@lists.linux-foundation.org>;
 Thu, 26 Mar 2020 16:38:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 155E120360
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 16:38:59 +0000 (UTC)
IronPort-SDR: tSdojn6DozlHH7/JM0ZWYYiXojR2PSYJYeOMAbTlFHMxX+G9pGIDk00gjb7JZ3a30kOAxLN5X5
 CE91QQMp+3rA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 09:38:58 -0700
IronPort-SDR: 5qAPNHMPSfUJ2crJnR1N0kbPgi0WNOKmtBXLIv/QW9b1irnPu+DsZbog/yh3hn+zQuOdOnAb5L
 +QiA/Z+IxVng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; d="scan'208";a="326618818"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 26 Mar 2020 09:38:58 -0700
Date: Thu, 26 Mar 2020 09:44:42 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200326094442.5be042ce@jacob-builder>
In-Reply-To: <20200326092316.GA31648@infradead.org>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200326092316.GA31648@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
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

Hi Christoph,

Thanks for the review. Please see my comments inline.

On Thu, 26 Mar 2020 02:23:16 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Mar 25, 2020 at 04:17:05PM -0700, Jacob Pan wrote:
> > Having a single UAPI version to govern the user-kernel data
> > structures makes compatibility check straightforward. On the
> > contrary, supporting combinations of multiple versions of the data
> > can be a nightmare to maintain.
> > 
> > This patch defines a unified UAPI version to be used for
> > compatibility checks between user and kernel.  
> 
> This is bullshit.  Version numbers don't scale and we've avoided them
> everywhere.  You need need flags specifying specific behavior.
> 
We have flags or the equivalent in each UAPI structures. The flags
are used for checking validity of extensions as well. And you are right
we can use them for checking specific behavior.

So we have two options here:
1. Have a overall version for a quick compatibility check while
starting a VM. If not compatible, we will stop guest SVA entirely.

2. Let each API calls check its own capabilities/flags at runtime. It
may fail later on and lead to more complex error handling.
For example, guest starts with SVA support, allocate a PASID, bind
guest PASID works great. Then when IO page fault happens, it try to do
page request service and found out certain flags are not compatible.
This case is more complex to handle.

I am guessing your proposal is #2. right?

Overall, we don;t expect much change to the UAPI other than adding some
vendor specific part of the union. Is the scalability concern based on
frequent changes?

> > +#define IOMMU_UAPI_VERSION	1
> > +static inline int iommu_get_uapi_version(void)
> > +{
> > +	return IOMMU_UAPI_VERSION;
> > +}  
> 
> Also inline functions like this in UAPI headers that actually get
> included by userspace programs simply don't work.

I will remove that, user can just use IOMMU_UAPI_VERSION directly.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
