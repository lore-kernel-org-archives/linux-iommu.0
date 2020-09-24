Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C58C4346E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 08:40:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F289523787
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 08:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F289523787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6FA462E0E9;
	Thu, 24 Sep 2020 08:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ka2uWFrh3oDB; Thu, 24 Sep 2020 08:40:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2AA1220113;
	Thu, 24 Sep 2020 08:40:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ACCDC0889;
	Thu, 24 Sep 2020 08:40:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0B78C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E4168874D8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id POcTssMFoTN9 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 08:40:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 94F06874D7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:40:20 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D53C3295; Thu, 24 Sep 2020 10:40:17 +0200 (CEST)
Date: Thu, 24 Sep 2020 10:40:16 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v9 3/7] iommu/uapi: Introduce enum type for PASID data
 format
Message-ID: <20200924084015.GC27174@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200918094450.GP31590@8bytes.org>
 <20200918101108.672c2f5a@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918101108.672c2f5a@jacob-builder>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Yi Sun <yi.y.sun@intel.com>
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

Hi Jacob,

On Fri, Sep 18, 2020 at 10:11:08AM -0700, Jacob Pan wrote:
> On Fri, 18 Sep 2020 11:44:50 +0200, Joerg Roedel <joro@8bytes.org> wrote:
> 
> > On Fri, Sep 11, 2020 at 02:57:52PM -0700, Jacob Pan wrote:
> > > There can be multiple vendor-specific PASID data formats used in UAPI
> > > structures. This patch adds enum type with a last entry which makes
> > > range checking much easier.  
> > 
> > But it also makes it much easier to screw up the numbers (which are ABI)
> > by inserting a new value into the middle. I prefer defines here, or
> > alternativly BUILD_BUG_ON() checks for the numbers.
> > 
> I am not following, the purpose of IOMMU_PASID_FORMAT_LAST *is* for
> preparing the future insertion of new value into the middle.
> The checking against IOMMU_PASID_FORMAT_LAST is to protect ABI
> compatibility by making sure that out of range format are rejected in all
> versions of the ABI.

But with the enum you could have:

enum {
	VTD_FOO,
	SMMU_FOO,
	LAST,
};

which makes VTD_FOO==0 and SMMU_FOO==1, and when in the next version
someone adds:

enum {
	VTD_FOO,
	VTD_BAR,
	SMMU_FOO,
	LAST,
};

then SMMU_FOO will become 2 and break ABI. So I'd like to have this
checked somewhere.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
