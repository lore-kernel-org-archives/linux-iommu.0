Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF3AC4321A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 17:27:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71082089E
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 17:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71082089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8BEB6E23;
	Tue, 11 Jun 2019 17:27:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 949B9E25
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 17:27:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 48B0E896
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 17:27:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Jun 2019 10:27:16 -0700
X-ExtLoop1: 1
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
	by orsmga008.jf.intel.com with ESMTP; 11 Jun 2019 10:27:16 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
	ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Tue, 11 Jun 2019 10:27:16 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.154]) by
	ORSMSX161.amr.corp.intel.com ([169.254.4.126]) with mapi id
	14.03.0415.000; Tue, 11 Jun 2019 10:27:16 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: Device specific pass through in host systems - discuss user
	interface
Thread-Topic: Device specific pass through in host systems - discuss user
	interface
Thread-Index: AdUczaahXstQhucvR3yNMqqPH3ycoQB31J8AACg+/sAAID+CAAAPfpCQAA/veAAACvTtIA==
Date: Tue, 11 Jun 2019 17:27:15 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48DE94B3@ORSMSX114.amr.corp.intel.com>
References: <FFF73D592F13FD46B8700F0A279B802F48DA796E@ORSMSX114.amr.corp.intel.com>
	<b7a71b22-aa3b-5ac3-7285-5231f84ee979@intel.com>
	<FFF73D592F13FD46B8700F0A279B802F48DD2A02@ORSMSX114.amr.corp.intel.com>
	<20190610135617.GA27166@araj-mobl1.jf.intel.com>
	<FFF73D592F13FD46B8700F0A279B802F48DE19EC@ORSMSX114.amr.corp.intel.com>
	<20190611045614.GB6469@araj-mobl1.jf.intel.com>
In-Reply-To: <20190611045614.GB6469@araj-mobl1.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjk0ZTJjNjAtNDUyZC00NzcxLTk0NTctMzVlYTZlNzdkMTk2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTkFUc0YxZGFYV0dQYXZmSW05Yk5CNThFSm9ZdjZYSE9oblN6QWhFUm5SVVwvUVpOdTNFNnRvYlFFVW5lcE5OTm0ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, "jroedel@suse.de" <jroedel@suse.de>, "Lu,
	Baolu" <baolu.lu@intel.com>, Will Deacon <will.deacon@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

> > > > Sure! Makes sense.. per-group default domain type sounds good.
> >
> > I am planning to implement an RFC (supporting only runtime case for
> > now) which works as below
> >
> > 1. User unbinds the driver by writing to sysfs 2. User puts a group in
> > pass through mode by writing "1" to
> > /sys/kernel/iommu_groups/<group_id>/pt
> 
> might be better to read current value of default domain for that group..
> /sys/kernel/iommu_groups/<group_id>/default_domain

Presently, we already have a file that gives out "type" of default_domain and the file is
/sys/kernel/iommu_groups/<group_id>/type

> reading the above value shows current setting.
> provide a differnet file next_def_domain, and you can echo "pt" or
> "dma_domain"
> to switch to pass-through, or normal dma isolation mode.

We have couple of options here:

1. Since we already have "type" file, which is "read-only", we could make it R/W.

The present value shows the existing type of default domain.
If user wants to change it (Eg: from DMA to IDENTITY or vice versa), he attempts to write the new value.
Kernel performs checks to make sure that the driver in unbinded and it's safe to change the default domain type.
After successfully changing the default_domain type internally, kernel reflects the new value in the file.
Ay errors in the process will be reported in dmesg.

2. As you have suggested, we could have a *new* file named "next_def_domain_type", which takes string as an input.

Please let me know if there is any preference among these approaches and why :)

Regards,
Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
