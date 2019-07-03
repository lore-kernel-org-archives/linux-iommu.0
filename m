Return-Path: <SRS0=mxFs=VA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8114AC5B57D
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 02:01:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6084F21721
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 02:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6084F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 12EBC107A;
	Wed,  3 Jul 2019 02:01:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9987EF81
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 02:01:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 50BBC70D
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 02:01:36 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Jul 2019 19:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; d="scan'208";a="362879110"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
	by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2019 19:01:35 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
	ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Tue, 2 Jul 2019 19:01:35 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.32]) by
	ORSMSX155.amr.corp.intel.com ([169.254.7.237]) with mapi id
	14.03.0439.000; Tue, 2 Jul 2019 19:01:34 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: Device specific pass through in host systems - discuss user
	interface
Thread-Topic: Device specific pass through in host systems - discuss user
	interface
Thread-Index: AdUczaahXstQhucvR3yNMqqPH3ycoQB31J8AACg+/sAAID+CAAAPfpCQAA/veAAACvTtIAPrYDMAAEc9kpA=
Date: Wed, 3 Jul 2019 02:01:34 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4F84A40E@ORSMSX114.amr.corp.intel.com>
References: <FFF73D592F13FD46B8700F0A279B802F48DA796E@ORSMSX114.amr.corp.intel.com>
	<b7a71b22-aa3b-5ac3-7285-5231f84ee979@intel.com>
	<FFF73D592F13FD46B8700F0A279B802F48DD2A02@ORSMSX114.amr.corp.intel.com>
	<20190610135617.GA27166@araj-mobl1.jf.intel.com>
	<FFF73D592F13FD46B8700F0A279B802F48DE19EC@ORSMSX114.amr.corp.intel.com>
	<20190611045614.GB6469@araj-mobl1.jf.intel.com>
	<FFF73D592F13FD46B8700F0A279B802F48DE94B3@ORSMSX114.amr.corp.intel.com>
	<20190701085944.GB3131@suse.de>
In-Reply-To: <20190701085944.GB3131@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzIyODMzZDAtMDg2OS00NzU2LThmYjItNjZiNmRmOTRmMzk1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicU0xaGlRVFloUXlcL251UTVEMDUyeGJwemdmemhtWjdtU0ZtbTVEdVNrSEgrWnk5UWJzcEdcL2ZCaGVUOTM4Q0U3In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, "Raj,
	Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Pan, Jacob jun" <jacob.jun.pan@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"hch@lst.de" <hch@lst.de>, "Lu, Baolu" <baolu.lu@intel.com>
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

> > The present value shows the existing type of default domain.
> > If user wants to change it (Eg: from DMA to IDENTITY or vice versa), he
> attempts to write the new value.
> > Kernel performs checks to make sure that the driver in unbinded and it's safe
> to change the default domain type.
> > After successfully changing the default_domain type internally, kernel reflects
> the new value in the file.
> > Ay errors in the process will be reported in dmesg.
> 
> I prefer this way. Writing to the file should fail with -EBUSY when it is not safe to
> change the default domain-type. Writing should only succeed when no device in
> the group is assigned to a device driver.

Thanks a lot! Joerg for the reply.
I have just sent out an RFC of this patch set to the IOMMU mailing list.
Could you please take a look at it and let me know your feedback?

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
