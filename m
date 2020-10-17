Return-Path: <SRS0=0/ZC=DY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325A6C433E7
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 11:25:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FE920704
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 11:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FE920704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3F54488668;
	Sat, 17 Oct 2020 11:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zz1Kli9lynxz; Sat, 17 Oct 2020 11:25:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D9DF8865B;
	Sat, 17 Oct 2020 11:25:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4060BC07FF;
	Sat, 17 Oct 2020 11:25:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49DF4C0051
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 11:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3526886C74
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 11:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fDONjiqVJXAL for <iommu@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 11:25:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3A3C38694B
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 11:25:28 +0000 (UTC)
IronPort-SDR: RuL0lko5Sv2giNLKYnsVoKCOeXlcnWv9W0QE0VykC0xEcQLBb+etWjFVbhCm/lz7e1VVY3CYHW
 reQE6w6wpkXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="228428009"
X-IronPort-AV: E=Sophos;i="5.77,386,1596524400"; d="scan'208";a="228428009"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2020 04:25:27 -0700
IronPort-SDR: fJYorjHmM8rSDgf+AxOo8DQPaNgLXY2tWkNpbZAoBerP99MSi411fEqxxCXwYO+Iv27hZtjlge
 nyFknD9/+HXQ==
X-IronPort-AV: E=Sophos;i="5.77,386,1596524400"; d="scan'208";a="532052790"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2020 04:25:26 -0700
Date: Sat, 17 Oct 2020 04:25:25 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201017112525.GA47206@otc-nc-03>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016075923.GB1309464@myrica>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: kevin.tian@intel.com, "Lu, Baolu" <baolu.lu@intel.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jacon Jun Pan <jacob.jun.pan@intel.com>,
 linux-pci@vger.kernel.org, zhangfei.gao@linaro.org,
 Ashok Raj <ashok.raj@intel.com>, dwmw2@infradead.org,
 linux-accelerators@lists.ozlabs.org
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

Hi Jean

On Fri, Oct 16, 2020 at 09:59:23AM +0200, Jean-Philippe Brucker wrote:
> On Thu, Oct 15, 2020 at 11:22:11AM -0700, Raj, Ashok wrote:
> > Hi Jean
> > 
> > + Baolu who is looking into this.
> > 
> > 
> > On Thu, Oct 15, 2020 at 11:00:27AM +0200, Jean-Philippe Brucker wrote:
> > > Add a parameter to iommu_sva_unbind_device() that tells the IOMMU driver
> > > whether the PRI queue needs flushing. When looking at the PCIe spec
> > > again I noticed that most of the time the SMMUv3 driver doesn't actually
> > > need to flush the PRI queue. Does this make sense for Intel VT-d as well
> > > or did I overlook something?
> > > 
> > > Before calling iommu_sva_unbind_device(), device drivers must stop the
> > > device from using the PASID. For PCIe devices, that consists of
> > > completing any pending DMA, and completing any pending page request
> > > unless the device uses Stop Markers. So unless the device uses Stop
> > > Markers, we don't need to flush the PRI queue. For SMMUv3, stopping DMA
> > > means completing all stall events, so we never need to flush the event
> > > queue.
> > 
> > I don't think this is true. Baolu is working on an enhancement to this,
> > I'll quickly summarize this below:
> > 
> > Stop markers are weird, I'm not certain there is any device today that
> > sends STOP markers. Even if they did, markers don't have a required
> > response, they are fire and forget from the device pov.
> 
> Definitely agree with this, and I hope none will implement stop marker.
> For devices that *don't* use a stop marker, the PCIe spec says (10.4.1.2):
> 
>   To stop [using a PASID] without using a Stop Marker Message, the
>   function shall:
>   1. Stop queueing new Page Request Messages for this PASID.

The device driver would need to tell stop sending any new PR's.

>   2. Finish transmitting any multi-page Page Request Messages for this
>      PASID (i.e. send the Page Request Message with the L bit Set).
>   3. Wait for PRG Response Messages associated any outstanding Page
>      Request Messages for the PASID.
> 
> So they have to flush their PR themselves. And since the device driver
> completes this sequence before calling unbind(), then there shouldn't be
> any oustanding PR for the PASID, and unbind() doesn't need to flush,
> right?

I can see how the device can complete #2,3 above. But the device driver
isn't the one managing page-responses right. So in order for the device to
know the above sequence is complete, it would need to get some assist from
IOMMU driver?

How does the driver know that everything host received has been responded
back to device?

> 
> > I'm not sure about other IOMMU's how they behave, When there is no space in
> > the PRQ, IOMMU auto-responds to the device. This puts the device in a
> > while (1) loop. The fake successful response will let the device do a ATS
> > lookup, and that would fail forcing the device to do another PRQ.
> 
> But in the sequence above, step 1 should ensure that the device will not
> send another PR for any successful response coming back at step 3.

True, but there could be some page-request in flight on its way to the
IOMMU. By draining and getting that round trip back to IOMMU we gaurantee
things in flight are flushed to PRQ after that Drain completes.
> 
> So I agree with the below if we suspect there could be pending PR, but
> given that pending PR are a stop marker thing and we don't know any device
> using stop markers, I wondered why I bothered implementing PRIq flush at
> all for SMMUv3, hence this RFC.
> 

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
