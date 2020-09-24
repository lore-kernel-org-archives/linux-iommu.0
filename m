Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597BDC4727D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 18:29:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7E22344C
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 18:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7E22344C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6EA0220422;
	Thu, 24 Sep 2020 18:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGkWpiwqoFaZ; Thu, 24 Sep 2020 18:29:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A270E203E2;
	Thu, 24 Sep 2020 18:29:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BB89C0889;
	Thu, 24 Sep 2020 18:29:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89EC7C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 18:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7E7B5869B8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 18:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UjrQrKyuqZF5 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 18:29:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B534886975
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 18:29:03 +0000 (UTC)
IronPort-SDR: zt0b7qLAefKPhJt2JpAKc2ILUNOEO+HkTYbarLwa4rDQbpZbYfBXPowVt1TOoE7/EZot5qfKPT
 nKKwpkSF+KFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="160578874"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="160578874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 11:29:01 -0700
IronPort-SDR: QXlCgJfZs4NQkVasYkmAuphEPC/dg9mtM1psTJODac5uq50sWC7/wkE/AoLsNbcbtEeyi2hQ5f
 p9K5dySYZ1Ww==
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; d="scan'208";a="305931568"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 11:29:01 -0700
Date: Thu, 24 Sep 2020 11:31:07 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v9 3/7] iommu/uapi: Introduce enum type for PASID data
 format
Message-ID: <20200924113107.75379e6e@jacob-builder>
In-Reply-To: <20200924084015.GC27174@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200918094450.GP31590@8bytes.org>
 <20200918101108.672c2f5a@jacob-builder>
 <20200924084015.GC27174@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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

Hi Joerg,

On Thu, 24 Sep 2020 10:40:16 +0200, Joerg Roedel <joro@8bytes.org> wrote:

> > On Fri, 18 Sep 2020 11:44:50 +0200, Joerg Roedel <joro@8bytes.org>
> > wrote: 
> > > On Fri, Sep 11, 2020 at 02:57:52PM -0700, Jacob Pan wrote:  
> > > > There can be multiple vendor-specific PASID data formats used in
> > > > UAPI structures. This patch adds enum type with a last entry which
> > > > makes range checking much easier.    
> > > 
> > > But it also makes it much easier to screw up the numbers (which are
> > > ABI) by inserting a new value into the middle. I prefer defines here,
> > > or alternativly BUILD_BUG_ON() checks for the numbers.
> > >   
> > I am not following, the purpose of IOMMU_PASID_FORMAT_LAST *is* for
> > preparing the future insertion of new value into the middle.
> > The checking against IOMMU_PASID_FORMAT_LAST is to protect ABI
> > compatibility by making sure that out of range format are rejected in
> > all versions of the ABI.  
> 
> But with the enum you could have:
> 
> enum {
> 	VTD_FOO,
> 	SMMU_FOO,
> 	LAST,
> };
> 
> which makes VTD_FOO==0 and SMMU_FOO==1, and when in the next version
> someone adds:
> 
> enum {
> 	VTD_FOO,
> 	VTD_BAR,
> 	SMMU_FOO,
> 	LAST,
> };
> 
> then SMMU_FOO will become 2 and break ABI. So I'd like to have this
> checked somewhere.
Got your point, will change to defines.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
