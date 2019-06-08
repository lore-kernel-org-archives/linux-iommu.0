Return-Path: <SRS0=0CRx=UH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F55AC28CC5
	for <iommu@archiver.kernel.org>; Sat,  8 Jun 2019 18:42:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69201214C6
	for <iommu@archiver.kernel.org>; Sat,  8 Jun 2019 18:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69201214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 20BEE16AA;
	Sat,  8 Jun 2019 18:42:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F304C16A9
	for <iommu@lists.linux-foundation.org>;
	Sat,  8 Jun 2019 18:42:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5BEDC711
	for <iommu@lists.linux-foundation.org>;
	Sat,  8 Jun 2019 18:42:04 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Jun 2019 11:42:03 -0700
X-ExtLoop1: 1
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2019 11:42:03 -0700
Message-ID: <0467c18559982ca9fd2c9ed4f3cf826fd3487dab.camel@intel.com>
Subject: Re: Device specific pass through in host systems - discuss user
	interface
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: "hch@lst.de" <hch@lst.de>
Date: Sat, 08 Jun 2019 11:38:58 -0700
In-Reply-To: <20190608072751.GA18928@lst.de>
References: <FFF73D592F13FD46B8700F0A279B802F48DA796E@ORSMSX114.amr.corp.intel.com>
	<3fa16135-b2bb-03b5-833a-bce8cc68f35f@arm.com>
	<12f8c572074b7963705ba066fdde0f9fdf0bfc62.camel@intel.com>
	<20190608072751.GA18928@lst.de>
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, "jroedel@suse.de" <jroedel@suse.de>, "Raj,
	Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, "Lu, Baolu" <baolu.lu@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sat, 2019-06-08 at 09:27 +0200, hch@lst.de wrote:
> Just curious, what exactly is the use case?  Explaining how someone
> would wan to use this should drive the way we design an interface for it.

Makes sense.

Some example use cases:
1. Assume an SR-IOV device and if the admin decides to use some VF's natively
(i.e. they are available only to host) and he wants them to be high performing
and also believes that his OS is secure enough (so decides to by pass IOMMU).

Presently, we don't support this use case because "iommu=pt" kernel command
line argument is an all or none feature i.e. either all BDF's are translated
through IOMMU or none. So, we would like to propose a per-BDF on/off feature.

We would also want it to be run-time (i.e. sysfs based interface) rather than
just boot-time interface (kernel command line argument).

Also, want to be clear that it's not just SR-IOV devices that we are looking
at but could be any unrelated PCIe devices i.e. a SATA device, USB, NIC or
GFx. Wherein the admin wants to selectively put NIC and GFx through IOMMU and
does not want transactions by SATA and USB to be translated by IOMMU.

Regards,
Sai

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
