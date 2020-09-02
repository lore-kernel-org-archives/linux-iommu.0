Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C00DC433E7
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 21:39:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6F6207EA
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 21:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6F6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9DCA98730E;
	Wed,  2 Sep 2020 21:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7gv5lZvTq-cF; Wed,  2 Sep 2020 21:39:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1AD4B86DA3;
	Wed,  2 Sep 2020 21:39:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11A11C0052;
	Wed,  2 Sep 2020 21:39:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D07BC0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 21:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6CB2587305
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 21:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c7zHzWCjWM1u for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 21:38:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E6EF486DA3
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 21:38:58 +0000 (UTC)
IronPort-SDR: ooRnaVnxrG8IaIy+ORXcFJ7t7gujVwDuuwg1oVYWsFvi67UxTdqypisalGEYZV1GSWPFgYrGNz
 x89w1HQv5A4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="156753019"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="156753019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:38:58 -0700
IronPort-SDR: R74Gpyyhve4xHettzn6a1t0Z9R83rkUlGOsa8XP8RCEr0J7K3iV8D7cgW5oHmkIDB3GkrFpHyl
 dpTz1U/zB2/g==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="325946433"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:38:58 -0700
Date: Wed, 2 Sep 2020 14:46:04 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/9] iommu/ioasid: Introduce ioasid_set APIs
Message-ID: <20200902144604.33595c0d@jacob-builder>
In-Reply-To: <a6bc666c-d327-998b-b740-d03b9f0f5ffc@infradead.org>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200824182848.GB3210689@myrica>
 <a6bc666c-d327-998b-b740-d03b9f0f5ffc@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

On Mon, 24 Aug 2020 11:30:47 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/24/20 11:28 AM, Jean-Philippe Brucker wrote:
> >> +/**
> >> + * struct ioasid_data - Meta data about ioasid
> >> + *
> >> + * @id:		Unique ID
> >> + * @users	Number of active users
> >> + * @state	Track state of the IOASID
> >> + * @set		Meta data of the set this IOASID belongs to
> >> + * @private	Private data associated with the IOASID
> >> + * @rcu		For free after RCU grace period  
> > nit: it would be nicer to follow the struct order  
> 
> and use a ':' after each struct member name, as is done for @id:
> 
Got it, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
