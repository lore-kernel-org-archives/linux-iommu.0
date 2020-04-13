Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE2C352B6
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 16:08:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689542063A
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 16:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689542063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4161C86254;
	Mon, 13 Apr 2020 16:08:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11Q4RQb3qokW; Mon, 13 Apr 2020 16:08:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EC36286130;
	Mon, 13 Apr 2020 16:08:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D53B8C1797;
	Mon, 13 Apr 2020 16:08:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10555C0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 16:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F3CA386252
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 16:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kci66DmbY70d for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 16:08:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 45DDF86130
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 16:08:25 +0000 (UTC)
IronPort-SDR: 8dYIwz94mYsaUAs7lWXuEuAekij+4yuP7FdFGOjp0GhpO98N39072wVM9choWDMYkain0y7Fr4
 37emeupqDC/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2020 09:08:24 -0700
IronPort-SDR: +IdGpKVquQIPGC53fqDyu0ehYjNXf1exj6H17B6VKPtrbZUcRuA7zc3U2lPTYlbrGxO4W+afW1
 Nbb47dSbwuRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; d="scan'208";a="363109124"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2020 09:08:24 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Apr 2020 09:08:23 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.99]) with mapi id 14.03.0439.000;
 Mon, 13 Apr 2020 09:08:23 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "drake@endlessm.com" <drake@endlessm.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
Thread-Topic: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices
 and subdevices
Thread-Index: AQHWDqWd+ubRYvzlTkCJBotC6+FAWahyBPQAgATIvQCAAAaBgIAA31yA
Date: Mon, 13 Apr 2020 16:08:22 +0000
Message-ID: <a83908feee589be7922b069e802770b363cb5b2f.camel@intel.com>
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
 <20200409191736.6233-2-jonathan.derrick@intel.com>
 <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
 <CAD8Lp45dJ3-t6qqctiP1a=c44PEWZ-L04yv0r0=1Nrvwfouz1w@mail.gmail.com>
 <32cc4809-7029-bc5e-5a74-abbe43596e8d@linux.intel.com>
In-Reply-To: <32cc4809-7029-bc5e-5a74-abbe43596e8d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.111]
Content-ID: <F10BAF6423A26D44B521F52F13B7FD08@intel.com>
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux@endlessm.com" <linux@endlessm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 2020-04-13 at 10:48 +0800, Lu Baolu wrote:
> Hi Daniel,
> 
> On 2020/4/13 10:25, Daniel Drake wrote:
> > On Fri, Apr 10, 2020 at 9:22 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> > > This is caused by the fragile private domain implementation. We are in
> > > process of removing it by enhancing the iommu subsystem with per-group
> > > default domain.
> > > 
> > > https://www.spinics.net/lists/iommu/msg42976.html
> > > 
> > > So ultimately VMD subdevices should have their own per-device iommu data
> > > and support per-device dma ops.
> > 
> > Interesting. There's also this patchset you posted:
> > [PATCH 00/19] [PULL REQUEST] iommu/vt-d: patches for v5.7
> > https://lists.linuxfoundation.org/pipermail/iommu/2020-April/042967.html
> > (to be pushed out to 5.8)
> 
> Both are trying to solve a same problem.
> 
> I have sync'ed with Joerg. This patch set will be replaced with Joerg's
> proposal due to a race concern between domain switching and driver
> binding. I will rebase all vt-d patches in this set on top of Joerg's
> change.
> 
> Best regards,
> baolu
> 
Thanks Baolu. I'll pick this back up on top of the for-5.8 changes.


> > In there you have:
> > > iommu/vt-d: Don't force 32bit devices to uses DMA domain
> > which seems to clash with the approach being explored in this thread.
> > 
> > And:
> > > iommu/vt-d: Apply per-device dma_ops
> > This effectively solves the trip point that caused me to open these
> > discussions, where intel_map_page() -> iommu_need_mapping() would
> > incorrectly determine that a intel-iommu DMA mapping was needed for a
> > PCI subdevice running in identity mode. After this patch, a PCI
> > subdevice in identity mode uses the default system dma_ops and
> > completely avoids intel-iommu.
> > 
> > So that solves the issues I was looking at. Jon, you might want to
> > check if the problems you see are likewise solved for you by these
> > patches.
> > 
> > I didn't try Joerg's iommu group rework yet as it conflicts with those
> > patches above.
> > 
> > Daniel
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
