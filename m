Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36BBC7618B
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 06:44:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A144218B8
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 06:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A144218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 42675B50;
	Fri, 26 Jul 2019 06:44:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 81AD73EE
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 06:44:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EA973709
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 06:44:27 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Jul 2019 23:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,309,1559545200"; d="scan'208";a="175509571"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
	by orsmga006.jf.intel.com with ESMTP; 25 Jul 2019 23:44:26 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
	ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Thu, 25 Jul 2019 23:44:25 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.96]) by
	ORSMSX151.amr.corp.intel.com ([169.254.7.148]) with mapi id
	14.03.0439.000; Thu, 25 Jul 2019 23:44:25 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH RFC 0/4] iommu: Add support to change default domain of
	a group
Thread-Topic: [PATCH RFC 0/4] iommu: Add support to change default domain of
	a group
Thread-Index: AQHVMUKktMo1iV3/DEalKerYK5QUKabXScsAgAVNx0A=
Date: Fri, 26 Jul 2019 06:44:25 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4F96F7B2@ORSMSX114.amr.corp.intel.com>
References: <cover.1562116655.git.sai.praneeth.prakhya@intel.com>
	<20190722144102.GC12009@8bytes.org>
In-Reply-To: <20190722144102.GC12009@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWY4NmRmMDktNjkwMy00NDIzLTk0YzUtZjYwMTRjY2I1ZTIyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV3RwQVwvc3ViNGFMc09qcDVNdStFSlpnczJWWGZhRWJaXC9rQjVoRmxSdEJqMFgzWUQ5OTY0bUFUd1lRaUk1V2dmIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

> On Tue, Jul 02, 2019 at 06:53:58PM -0700, Sai Praneeth Prakhya wrote:
> > Assume a use case where-in the priviliged user would want to use the
> > device in pass-through mode when the device is used for host but would
> > want to switch to dma protected mode when switching for VFIO in user
> > space. Presently, this is not supported and hence add support to change
> default domain of a group dynamically.
> 
> VFIO does it's own iommu magic with the device and moves the group out of the
> default domain, so that doesn't sound like a valid use-case.

Thanks a lot! for the reply Joerg.
I wasn't aware about this as I have very limited exposure to VFIO.
I will take a look into this.

> More valid would be something like putting a device into passthrough 
>  mode to improve performance, or do you have other valid use-cases in mind?

Presently, we don't have anything else except that putting a device in pass through 
mode will improve its performance.

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
