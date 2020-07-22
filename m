Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F2BC433E1
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 18:13:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA6420787
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 18:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA6420787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 435DC22836;
	Wed, 22 Jul 2020 18:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mhW8yvjeDaFu; Wed, 22 Jul 2020 18:13:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2589F2280D;
	Wed, 22 Jul 2020 18:13:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 066C7C004E;
	Wed, 22 Jul 2020 18:13:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 637F4C004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 18:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 59539883FF
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 18:13:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lcollt-SWzdK for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 18:13:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BE318883F0
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 18:13:34 +0000 (UTC)
IronPort-SDR: racnQgPdBazg1BwQYfEBZGarBoDEs7Gq0WUo4VeeJkmqW1KkcDN4hXiXKUvwDeuAe+l4kSOJnD
 VTQVV227PzDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="148346195"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="148346195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 11:13:34 -0700
IronPort-SDR: JtosvAJzexhbLhNoi/bpHeYCke7S9aJw9zZ5psF19WXy3tSdooc7FEJ044mf0MaEnHkKcbQJBx
 FLxREYTzpqiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="328296444"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 22 Jul 2020 11:13:33 -0700
Date: Wed, 22 Jul 2020 11:20:20 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page aligned address
Message-ID: <20200722112020.62ff5acc@jacob-builder>
In-Reply-To: <7a8f70af-f39b-1b57-a9eb-db085ab63149@linux.intel.com>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200721095036.1977e3bf@jacob-builder>
 <7a8f70af-f39b-1b57-a9eb-db085ab63149@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
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

On Wed, 22 Jul 2020 09:01:27 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> > 
> > Not sure what state is this patch in, there is a bug in this patch
> > (see below), shall I send out an updated version of this one only?
> > or another incremental patch.  
> 
> Please send an updated version. I hope Joerg could pick these as 5.8
> fix.
OK, will do.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
