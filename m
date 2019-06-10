Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D508CC468C1
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 05:41:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B028C20820
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 05:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B028C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8545CB88;
	Mon, 10 Jun 2019 05:41:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 22E54B7D
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 05:41:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B72C187E
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 05:41:12 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jun 2019 22:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,573,1557212400"; d="scan'208";a="183307840"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
	by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2019 22:41:11 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
	ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 9 Jun 2019 22:41:11 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.154]) by
	ORSMSX115.amr.corp.intel.com ([169.254.4.229]) with mapi id
	14.03.0415.000; Sun, 9 Jun 2019 22:41:10 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: "Lu, Baolu" <baolu.lu@intel.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>
Subject: RE: Device specific pass through in host systems - discuss user
	interface
Thread-Topic: Device specific pass through in host systems - discuss user
	interface
Thread-Index: AdUczaahXstQhucvR3yNMqqPH3ycoQB31J8AACg+/sA=
Date: Mon, 10 Jun 2019 05:41:10 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48DD2A02@ORSMSX114.amr.corp.intel.com>
References: <FFF73D592F13FD46B8700F0A279B802F48DA796E@ORSMSX114.amr.corp.intel.com>
	<b7a71b22-aa3b-5ac3-7285-5231f84ee979@intel.com>
In-Reply-To: <b7a71b22-aa3b-5ac3-7285-5231f84ee979@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTI5NTZiMTItNjRlYS00YWY3LWFlMjMtM2M3NTk1OTQxYTJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK3Qwd3RYcHVUVFhzcUVQM3F1Vk1nVHI1M0RqTzJ4eEZNWFwvQzlqanEzdnZWK25DZExZQ2ptTTJYRmZLbERnbUkifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, "jroedel@suse.de" <jroedel@suse.de>, "Raj,
	Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
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

> > I am working on an IOMMU driver feature that allows a user to specify
> > if the DMA from a device should be translated by IOMMU or not.
> > Presently, we support only all devices or none mode i.e. if user
> > specifies "iommu=pt" [X86] or "iommu.passthrough" [ARM64] through
> > kernel command line, all the devices would be in pass through mode and
> > we don't have per device granularity, but, we were requested by a
> > customer to selectively put devices in pass through mode and not all.
> 
> Most iommu vendor drivers have switched from per-device to per-group domain
> (a.k.a. default domain). So per-group pass-through mode makes more sense?
> 
> By the way, can we extend this to "per-group default domain type", instead of
> only "per-group pass-through mode"? Currently we have system level default
> domain type, if we have finer granularity of default domain type, both iommu
> drivers and end users will benefit from it.

Sure! Makes sense.. per-group default domain type sounds good.

> > I am looking for a consensus on **how the kernel command line argument
> > should look like and path for sysfs entry**. Also, please note that if
> > a device is put in pass through mode it won't be available for the
> > guest and that's ok.
> 
> Just out of curiosity, what's the limitation for a device using pass- through DMA
> domain to be assignable.

Sorry! I don't know about assignable devices. Probably, Ashok or Jacob could answer this question

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
