Return-Path: <SRS0=m6Z5=YW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5A8CA9EC4
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 07:57:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F4E20862
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 07:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F4E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5AFB6E60;
	Tue, 29 Oct 2019 07:57:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7C6F3E5E
	for <iommu@lists.linux-foundation.org>;
	Tue, 29 Oct 2019 07:57:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 177B48A
	for <iommu@lists.linux-foundation.org>;
	Tue, 29 Oct 2019 07:57:23 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 Oct 2019 00:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; d="scan'208";a="224890907"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
	by fmsmga004.fm.intel.com with ESMTP; 29 Oct 2019 00:57:23 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
	FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Tue, 29 Oct 2019 00:57:23 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
	fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
	15.1.1713.5; Tue, 29 Oct 2019 00:57:22 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
	fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
	(version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
	via Frontend Transport; Tue, 29 Oct 2019 00:57:22 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
	SHSMSX106.ccr.corp.intel.com ([169.254.10.248]) with mapi id
	14.03.0439.000; Tue, 29 Oct 2019 15:57:21 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v7 09/11] iommu/vt-d: Add bind guest PASID support
Thread-Topic: [PATCH v7 09/11] iommu/vt-d: Add bind guest PASID support
Thread-Index: AQHViqRYHs7rkU/ej0S5OBwc0DBZHqdq78JwgAApg4CABHtLgIAAIj+AgAGQXhA=
Date: Tue, 29 Oct 2019 07:57:21 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5DE3D3@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-10-git-send-email-jacob.jun.pan@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5CDDA6@SHSMSX104.ccr.corp.intel.com>
	<20191025103337.1e51c0c9@jacob-builder>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7B8@SHSMSX104.ccr.corp.intel.com>
	<20191028090231.4777c6a9@jacob-builder>
In-Reply-To: <20191028090231.4777c6a9@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDI5YWJlMTMtZTdmYS00Njk4LTk3NTEtYjZmNzM4YjExYjkwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieVFHdUhSeEh5alAwcUtaNk5rNENId2hcL003RW03VVBncGprUXFNY3AySGdYOW5uU1h4KzA3TWI0amhjOUszc3YifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Jonathan Cameron <jic23@kernel.org>
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

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Tuesday, October 29, 2019 12:03 AM
> 
> On Mon, 28 Oct 2019 06:03:36 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > > > +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> > > > > +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> > > > > +#endif
> > > >
> > > > again, pure PASID management logic should be separated from SVM.
> > > >
> > > I am not following, these two functions are SVM functionality, not
> > > pure PASID management which is already separated in ioasid.c
> >
> > I should say pure "scalable mode" logic. Above callbacks are not
> > related to host SVM per se. They are serving gpasid requests from
> > guest side, thus part of generic scalable mode capability.
> Got your point, but we are sharing data structures with host SVM, it is
> very difficult and inefficient to separate the two.

I don't think difficulty is the reason against such direction. We need 
do things right. :-) I'm fine with putting it in a TODO list, but at least
need the right information in the 1st place to tell that current way
is just a short-term approach, and we should revisit later.

thanks
Kevin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
