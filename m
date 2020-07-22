Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F12FC433E5
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 17:14:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E499206F5
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 17:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E499206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 32B14204D6;
	Wed, 22 Jul 2020 17:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oGYvOuawF3jD; Wed, 22 Jul 2020 17:14:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8431220477;
	Wed, 22 Jul 2020 17:14:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65A4CC004D;
	Wed, 22 Jul 2020 17:14:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2668FC004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 17:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0FD3C86117
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 17:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EiAbJxeFixRE for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 17:14:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2698385BCE
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 17:14:16 +0000 (UTC)
IronPort-SDR: 2IkpSCRpzwgzzgUNplRmOHv5Ow2Bqknk15HmfVUR6YnpJma5C3mRBW47VASFibst8WF3gz6eXx
 Y1x/pl/M4t+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="215012393"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="215012393"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 10:14:14 -0700
IronPort-SDR: 2IGztKYecv0SLsEBkh6rSTNn7OzqCsOGGqxqE1GPNGoR5RkAdVZiChawCCbeCAw41/bEkZheb4
 HgDngruGZIoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="272065944"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by fmsmga008.fm.intel.com with ESMTP; 22 Jul 2020 10:14:14 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.167]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.169]) with mapi id 14.03.0439.000;
 Wed, 22 Jul 2020 10:14:13 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH V4 1/3] iommu: Add support to change default domain of
 an iommu group
Thread-Topic: [PATCH V4 1/3] iommu: Add support to change default domain of
 an iommu group
Thread-Index: AQHWOtmTukvBBP3jY0KXbmuvXXR7xajxfcqAgACfu2CAFYPMwIAMvRQA///CZXA=
Date: Wed, 22 Jul 2020 17:14:13 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573DCEB6@ORSMSX114.amr.corp.intel.com>
References: <cover.1591290586.git.sai.praneeth.prakhya@intel.com>
 <3d7f5cf067437593e681751108860ea692bb10b1.1591290586.git.sai.praneeth.prakhya@intel.com>
 <20200630091601.GB28824@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573D8042@ORSMSX114.amr.corp.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F573DB164@ORSMSX114.amr.corp.intel.com>
 <20200722135244.GH27672@8bytes.org>
In-Reply-To: <20200722135244.GH27672@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>
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

Thanks for the reply. I will spin another version of the patch addressing your comments.

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Wednesday, July 22, 2020 6:53 AM
> To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>
> Cc: Raj, Ashok <ashok.raj@intel.com>; Will Deacon <will.deacon@arm.com>;
> iommu@lists.linux-foundation.org; Robin Murphy <robin.murphy@arm.com>;
> Christoph Hellwig <hch@lst.de>
> Subject: Re: [PATCH V4 1/3] iommu: Add support to change default domain of
> an iommu group
> 
> On Tue, Jul 14, 2020 at 06:23:54PM +0000, Prakhya, Sai Praneeth wrote:
> > Q1:
> > > Presently, iommu_change_dev_def_domain() checks if the iommu group
> > > still has only one device or not. Hence, checking if iommu group has
> > > one device or not is done twice, once before taking device_lock()
> > > and the other, after taking device_lock().
> > >
> > > I agree that the code isn't checking if the iommu group still has
> > > the _same_ device or not.
> > > One way, I could think of doing it is by storing "dev" temporarily
> > > and checking for it.
> > > Do you think that's ok? Or would you rather suggest something else?
> 
> That sounds reasonable, get the device from the group, lock it, take
> group->mutex, and check whether the same device is still alone in the
> group.

Sounds good! I will implement this.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
