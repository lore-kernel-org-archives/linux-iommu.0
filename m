Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD8C17442
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 02:35:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7402067B
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 02:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7402067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 854BEC6A;
	Mon, 11 Nov 2019 02:35:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 96883C64
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 02:35:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2C08F12E
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 02:35:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Nov 2019 18:35:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; d="scan'208";a="403673432"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
	by fmsmga005.fm.intel.com with ESMTP; 10 Nov 2019 18:35:41 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
	fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Sun, 10 Nov 2019 18:35:41 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Sun, 10 Nov 2019 18:35:41 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.60]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.213]) with mapi id
	14.03.0439.000; Mon, 11 Nov 2019 10:35:39 +0800
From: "Zeng, Jason" <jason.zeng@intel.com>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: RE: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Topic: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Index: AQHVlgnIrRA21rplp0+PB/+PXXgW6aeA7hBA//+Ew4CAAInEMIAAXpqAgALawYCAACUFgIAAyexg
Date: Mon, 11 Nov 2019 02:35:38 +0000
Message-ID: <8D8B600C3EC1B64FAD4503F0B66C61F23BC208@SHSMSX103.ccr.corp.intel.com>
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
	<1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
	<8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
	<addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
	<8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
	<CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
	<CABeXuvqMpXbSNasET4-u16Hrj710fe-V706tsFZhOTJoir8Xjw@mail.gmail.com>
	<CABeXuvrYzLoc7YGtmXDJqEovwyERbndN4cC6UaYAw5+qABRr8A@mail.gmail.com>
In-Reply-To: <CABeXuvrYzLoc7YGtmXDJqEovwyERbndN4cC6UaYAw5+qABRr8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmNhNjc0ODctNjRkOC00YTYxLTk5Y2QtYjc1MjI4OGNjMTM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieUZINjZDZ2JtT2szZlowWENvOVlwa1NMTUoyNmZcL0ZYQktVY1BxQ0pQenZYSmlmMHdtMzgyRHZQOXhlMkR4SWcifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Zeng, Jason" <jason.zeng@intel.com>,
	"rminnich@google.com" <rminnich@google.com>,
	David Woodhouse <dwmw2@infradead.org>
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
> On Sun, Nov 10, 2019 at 10:24 AM Deepa Dinamani
> > I've posted the v2 without the conditional for now:
> > https://lore.kernel.org/patchwork/patch/1151225/
> >
> > As a side topic, I'm trying to support https://www.linuxboot.org/. I
> > have a couple of more such cleanups coming. The VMM live updates and
> > linuxboot seem to have contradicting requirements and they both use
> > kexec. So kexec_in_progress doesn't seem like a sufficient indicator
> > to distinguish between the two. Do you already have an idea on how to
> > distiguish between them? Does a separate sys_reboot() command
> > parameter sound ok? Or, we could use the flags in the sys_kexec_load()
> > depending on how the live update feature is implemented.
> 
> Also, the AMD driver disables iommu at shutdown already. So the live update
> feature is already broken on AMD.
> 

Hi Deepa,

I think you may not need to consider too much VMM live update here (although it
would be good to consider possible future features), after all it is an on-going effort,
we are still not quite sure what exact modifications it needs. The VMM live update
itself will figure out what is the best way to modify the code.

Thanks,
Jason

> -Deepa
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
