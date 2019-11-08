Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F97BFA372C
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:31:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D43121882
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D43121882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 78172DB6;
	Fri,  8 Nov 2019 15:31:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B205BB43
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 09:11:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3797DEC
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 09:11:29 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Nov 2019 01:11:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,280,1569308400"; d="scan'208";a="193109548"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
	by orsmga007.jf.intel.com with ESMTP; 08 Nov 2019 01:11:27 -0800
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
	FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 8 Nov 2019 01:11:27 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.60]) by
	SHSMSX153.ccr.corp.intel.com ([169.254.12.215]) with mapi id
	14.03.0439.000; Fri, 8 Nov 2019 17:11:24 +0800
From: "Zeng, Jason" <jason.zeng@intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Deepa Dinamani
	<deepa.kernel@gmail.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Topic: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Index: AQHVlgnIrRA21rplp0+PB/+PXXgW6aeA7hBA//+Ew4CAAInEMA==
Date: Fri, 8 Nov 2019 09:11:24 +0000
Message-ID: <8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
	<1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
	<8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
	<addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
In-Reply-To: <addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmIxYjA3YjUtNGQ2My00MWM3LTg1NTYtOTE0ZDM3ZmM3YWU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSEZJdnhmXC92QjZJaXBscmdcL3FmMk93SzVkXC85R2tmRlBSTGZneFB0cmY2RGl5SndwSTVNODFMcHRTSXNhYzNXUiJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Nov 2019 15:31:10 +0000
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, "Zeng, Jason" <jason.zeng@intel.com>
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



> -----Original Message-----
> From: David Woodhouse <dwmw2@infradead.org>
> Sent: Friday, November 8, 2019 4:57 PM
> To: Zeng, Jason <jason.zeng@intel.com>; Deepa Dinamani
> <deepa.kernel@gmail.com>; joro@8bytes.org; linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org; Tian, Kevin <kevin.tian@intel.com>
> Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
> 
> On Fri, 2019-11-08 at 08:47 +0000, Zeng, Jason wrote:
> > > -----Original Message-----
> > > From: David Woodhouse <dwmw2@infradead.org>
> > > Sent: Friday, November 8, 2019 3:54 PM
> > > To: Deepa Dinamani <deepa.kernel@gmail.com>; joro@8bytes.org;
> linux-
> > > kernel@vger.kernel.org
> > > Cc: iommu@lists.linux-foundation.org; Zeng, Jason
> <jason.zeng@intel.com>;
> > > Tian, Kevin <kevin.tian@intel.com>
> > > Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
> > >
> > > On Thu, 2019-11-07 at 12:59 -0800, Deepa Dinamani wrote:
> > > > The intel-iommu driver assumes that the iommu state is
> > > > cleaned up at the start of the new kernel.
> > > > But, when we try to kexec boot something other than the
> > > > Linux kernel, the cleanup cannot be relied upon.
> > > > Hence, cleanup before we go down for reboot.
> > > >
> > > > Keeping the cleanup at initialization also, in case BIOS
> > > > leaves the IOMMU enabled.
> > > >
> > > > I considered turning off iommu only during kexec reboot,
> > > > but a clean shutdown seems always a good idea. But if
> > > > someone wants to make it conditional, we can do that.
> > >
> > > This is going to break things for the VMM live update scheme that Jason
> > > presented at KVM Forum, isn't it?
> > >
> > > In that case we rely on the IOMMU still operating during the
> > > transition.
> >
> > For VMM live update case, we should be able to detect and bypass
> > the shutdown that Deepa introduced here, so keep IOMMU still operating?
> 
> Is that a 'yes' to Deepa's "if someone wants to make it conditional, we
> can do that" ?

Yes, I think so. Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
