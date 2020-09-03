Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD754C433E9
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 16:35:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C63620578
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 16:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C63620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5D03786BA1;
	Thu,  3 Sep 2020 16:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XtAExVlhd2UP; Thu,  3 Sep 2020 16:35:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7FBE4868D6;
	Thu,  3 Sep 2020 16:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC8CC07FF;
	Thu,  3 Sep 2020 16:35:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03806C0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 16:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F313B86BA1
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 16:35:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iEKuB3kf3imy for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 16:35:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AA60A868D6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 16:35:22 +0000 (UTC)
IronPort-SDR: 7AAmx6U4vYk9R1BGgQsBtGRHWqes/5jLhundLoS4gBMYm4KmO9icEMFpqOB/3vDVHqY7pv1RJz
 jWUDL8ad1ylw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="145352486"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="145352486"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 09:35:21 -0700
IronPort-SDR: fpm2EUkci2oTbjGtopGBquDwwKng+PMe+foZPSI3HK+bv08KmruAxr7wF/55ACFaKSLBoUxQVH
 vLRGOXY9BheA==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="503124720"
Received: from araj-mobl1.jf.intel.com ([10.254.124.120])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 09:35:18 -0700
Date: Thu, 3 Sep 2020 09:35:16 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
Message-ID: <20200903163516.GA23129@araj-mobl1.jf.intel.com>
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826111628.794979401@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Juergen Gross <jgross@suse.com>, Russ Anderson <rja@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Thomas,

Thanks a ton for jumping in helping on straightening it for IMS!!!


On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
> This is the second version of providing a base to support device MSI (non
> PCI based) and on top of that support for IMS (Interrupt Message Storm)

s/Storm/Store

maybe pun intended :-)

> based devices in a halfways architecture independent way.

You mean "halfways" because the message addr and data follow guidelines
per arch (x86 or such), but the location of the storage isn't dictated
by architecture? or did you have something else in mind? =


> =

> The first version can be found here:
> =

>     https://lore.kernel.org/r/20200821002424.119492231@linutronix.de
> =


[snip]

> =

> Changes vs. V1:
> =

>    - Addressed various review comments and addressed the 0day fallout.
>      - Corrected the XEN logic (J=FCrgen)
>      - Make the arch fallback in PCI/MSI opt-in not opt-out (Bjorn)
> =

>    - Fixed the compose MSI message inconsistency
> =

>    - Ensure that the necessary flags are set for device SMI

is that supposed to be MSI? =


Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
