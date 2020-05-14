Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4B3C433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 18:44:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C4320657
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 18:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C4320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20AB588F88;
	Thu, 14 May 2020 18:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VMT4p5K-mKP; Thu, 14 May 2020 18:44:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 21DB289372;
	Thu, 14 May 2020 18:44:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 146B5C0863;
	Thu, 14 May 2020 18:44:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB044C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 18:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AA8688937E
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 18:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nDiv4Eo+DezJ for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 18:44:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CBDF489372
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 18:44:18 +0000 (UTC)
IronPort-SDR: DXslCA0h+esOB7PPX4RHSlyF2T0Y9m1DuQheCnulsgykg9Yy7Cec1G0qZxiORvesawmUPuM1Nj
 zMRER+EYy38A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2020 11:44:18 -0700
IronPort-SDR: clwtLNbK2lr8moZ1L+4Jj2a3i7bi+EZpALq253BGp/4dJ5inA1gtnnEn5BIDbzCV7mNrqj3HUv
 xDYCFfMuvWeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; d="scan'208";a="298799480"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by orsmga008.jf.intel.com with ESMTP; 14 May 2020 11:44:17 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.99]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.248]) with mapi id 14.03.0439.000;
 Thu, 14 May 2020 11:44:17 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH] iommu: Remove functions that support private domain
Thread-Topic: [PATCH] iommu: Remove functions that support private domain
Thread-Index: AQHWKXk9fV5tekATV0S4blj7EpvL1KioBUCA///Q9SCAAIhBgP//i0rw
Date: Thu, 14 May 2020 18:44:16 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573A651E@ORSMSX114.amr.corp.intel.com>
References: <20200513224721.20504-1-sai.praneeth.prakhya@intel.com>
 <20200514131315.GJ18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6427@ORSMSX114.amr.corp.intel.com>
 <20200514183233.GO18353@8bytes.org>
In-Reply-To: <20200514183233.GO18353@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Thursday, May 14, 2020 11:33 AM
> To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>
> Cc: iommu@lists.linux-foundation.org; Lu Baolu <baolu.lu@linux.intel.com>
> Subject: Re: [PATCH] iommu: Remove functions that support private domain
> 
> On Thu, May 14, 2020 at 05:51:39PM +0000, Prakhya, Sai Praneeth wrote:
> > Sorry! didn't get that quite well. When you meant "per-group
> > default-domain patch-set", do you mean the patch set that I am working
> > on which changes iommu group default domain dynamically by writing to
> > sysfs file?
> 
> Not only the sysfs file, but also changing it at boot already. Note that changing
> the default-domain at runtime is only possible for single-device groups.

Could you please explain why we shouldn't change default-domain for an iommu group that has multiple devices?

I am asking this particularly because the patch set I am working on allows to change default-domain for an iommu group that has multiple devices. The pre-requisite being that all the devices in the group should already be unbounded from the device driver and the default-domain preferences of all the devices in the group shouldn't have conflicting types i.e. some devices cannot say they *only* need identity domain while other devices in the same group say that they *only* need to be in DMA domain. In this case, we will not be able to decide upon a default-domain for the iommu group.

> I'll queue that patch tomorrow.

Great! I will take a look at it.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
