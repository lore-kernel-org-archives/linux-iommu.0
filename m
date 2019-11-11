Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F269CC43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 00:39:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5175206DF
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 00:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5175206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 812A6C03;
	Mon, 11 Nov 2019 00:39:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 45555BE7
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 00:39:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B5DCB5E4
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 00:39:19 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Nov 2019 16:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,290,1569308400"; d="scan'208";a="201908382"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
	by fmsmga008.fm.intel.com with ESMTP; 10 Nov 2019 16:39:17 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Sun, 10 Nov 2019 16:39:17 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.60]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.149]) with mapi id
	14.03.0439.000; Mon, 11 Nov 2019 08:39:16 +0800
From: "Zeng, Jason" <jason.zeng@intel.com>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: RE: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Topic: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Index: AQHVlgnIrRA21rplp0+PB/+PXXgW6aeA7hBA//+Ew4CAAInEMIAAXpqAgAPI5iA=
Date: Mon, 11 Nov 2019 00:39:15 +0000
Message-ID: <8D8B600C3EC1B64FAD4503F0B66C61F23BC0DC@SHSMSX103.ccr.corp.intel.com>
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
	<1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
	<8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
	<addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
	<8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
	<CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
In-Reply-To: <CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDk4ZTBhZTYtNWU2NS00MzA1LWFlYWItYmIzYmM2MjlkMjE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMmdRN1wvMnpTVWVMTENzR0JGbkI5MzdndWtBVDZFaDV6YkVhWlNkZmIzV25NVm8ya2hIUmVOVEExYkNVWFwvTWQ5In0=
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Zeng, Jason" <jason.zeng@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
> > > > For VMM live update case, we should be able to detect and bypass
> > > > the shutdown that Deepa introduced here, so keep IOMMU still
> operating?
> > >
> > > Is that a 'yes' to Deepa's "if someone wants to make it conditional,
> > > we can do that" ?
> >
> > Yes, I think so. Thanks!
> 
> Are these changes already part of the kernel like avoiding shutdown of the
> passthrough devices? device_shutdown() doesn't seem to be doing anything
> selectively as of now.
> 

No, it is not in upstream yet. It is an on-going effort, which tries to kexec reboot
the host while keeping IOMMU still working.

Thanks,
Jason

> Thanks,
> Deepa
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
