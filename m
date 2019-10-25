Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27430CA9EBD
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 15:52:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E811B21D82
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 15:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E811B21D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9E969CA8;
	Fri, 25 Oct 2019 15:52:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1EBA0C6A
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 15:52:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B32B987E
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 15:52:43 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Oct 2019 08:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; d="scan'208";a="282292991"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
	by orsmga001.jf.intel.com with ESMTP; 25 Oct 2019 08:52:41 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
	FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 08:52:41 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
	fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 08:52:41 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
	SHSMSX153.ccr.corp.intel.com ([10.239.6.53]) with mapi id
	14.03.0439.000; Fri, 25 Oct 2019 23:52:39 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
Thread-Topic: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
Thread-Index: AQHViqRVDFt/7gHf3E+EfuPtxXQ8nKdqHQYAgAAk/YCAAKNMUIAAA0iAgACaPUA=
Date: Fri, 25 Oct 2019 15:52:39 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0FF0@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<ae437be4-e633-e670-0e1f-d07b4364f651@linux.intel.com>
	<20191024214311.43d76a5c@jacob-builder>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC60@SHSMSX104.ccr.corp.intel.com>
	<e950cde8-8cd9-6089-c833-23d2ffb539d1@linux.intel.com>
In-Reply-To: <e950cde8-8cd9-6089-c833-23d2ffb539d1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmFmZjZmYjctOTM0NC00NDg5LWIxMzMtMDRmYjJmZTY1OTA4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibTRTM1RTWTlRN20zYmtjSDI0OStFVnFUNnkzNW5ucU83YUxoUGlzM05CbWgwdEtsc0J1UkR1SnJlSkkreXNBRCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>, Jonathan
	Cameron <jic23@kernel.org>
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

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Friday, October 25, 2019 10:39 PM
> 
> Hi,
> 
> On 10/25/19 2:40 PM, Tian, Kevin wrote:
> >>>> ioasid_register_allocator(&iommu->pasid_allocator);
> >>>> +			if (ret) {
> >>>> +				pr_warn("Custom PASID allocator
> >>>> registeration failed\n");
> >>>> +				/*
> >>>> +				 * Disable scalable mode on this
> >>>> IOMMU if there
> >>>> +				 * is no custom allocator. Mixing
> >>>> SM capable vIOMMU
> >>>> +				 * and non-SM vIOMMU are not
> >>>> supported.
> >>>> +				 */
> >>>> +				intel_iommu_sm = 0;
> >>> It's insufficient to disable scalable mode by only clearing
> >>> intel_iommu_sm. The DMA_RTADDR_SMT bit in root entry has already
> >> been
> >>> set. Probably, you need to
> >>>
> >>> for each iommu
> >>> 	clear DMA_RTADDR_SMT in root entry
> >>>
> >>> Alternatively, since vSVA is the only customer of this custom PASID
> >>> allocator, is it possible to only disable SVA here?
> >>>
> >> Yeah, I think disable SVA is better. We can still do gIOVA in SM. I
> >> guess we need to introduce a flag for sva_enabled.
> > I'm not sure whether tying above logic to SVA is the right approach.
> > If vcmd interface doesn't work, the whole SM mode doesn't make
> > sense which is based on PASID-granular protection (SVA is only one
> > usage atop). If the only remaining usage of SM is to map gIOVA using
> > reserved PASID#0, then why not disabling SM and just fallback to
> > legacy mode?
> >
> > Based on that I prefer to disabling the SM mode completely (better
> > through an interface), and move the logic out of CONFIG_INTEL_
> > IOMMU_SVM
> >
> 
> Unfortunately, it is dangerous to disable SM after boot. SM uses
> different root/device contexts and pasid table formats. Disabling SM
> after boot requires changing above from SM format into legacy format.

You are correct.

> 
> Since ioasid registration failure is a rare case. How about moving this
> part of code up to the early stage of intel_iommu_init() and returning
> error if hardware present vcmd capability but software fails to register
> a custom ioasid allocator?
> 

It makes sense to me.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
