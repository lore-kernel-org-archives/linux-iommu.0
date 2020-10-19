Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A228C433E7
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:31:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858C622365
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858C622365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DFAC387692;
	Mon, 19 Oct 2020 18:31:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CqN8QpM7EgyN; Mon, 19 Oct 2020 18:31:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F1F1C87674;
	Mon, 19 Oct 2020 18:31:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7AACC088B;
	Mon, 19 Oct 2020 18:31:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4D8BC0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C4BAB8767E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fAOsDKnvxc5l for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 18:31:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 11ECF87674
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:31:01 +0000 (UTC)
IronPort-SDR: a13qlrNigHfrg53xqHP5VNjOC3oTctCZDIuHZjxKD15Jy47186VV9xp8eJjXDc1v5oCm+ddEeF
 BEMROSwz1gcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="163594630"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; d="scan'208";a="163594630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2020 11:30:57 -0700
IronPort-SDR: 3omxCU3HGeLsa9nXlDlOwZ+t4XZ/tEctu88AwdfLWv/at6Ju8X7n+ZGuTMytBbp8ditxc03TnY
 1nFtDlE1w56A==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; d="scan'208";a="532734880"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2020 11:30:56 -0700
Date: Mon, 19 Oct 2020 11:33:16 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201019113316.2957c5f0@jacob-builder>
In-Reply-To: <20201019140824.GA1478235@myrica>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
 <20201017112525.GA47206@otc-nc-03>
 <20201019140824.GA1478235@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: kevin.tian@intel.com, "Raj, Ashok" <ashok.raj@intel.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, "Lu, Baolu" <baolu.lu@intel.com>,
 Jacon Jun Pan <jacob.jun.pan@intel.com>, linux-pci@vger.kernel.org,
 zhangfei.gao@linaro.org, dwmw2@infradead.org,
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

Hi Jean-Philippe,

On Mon, 19 Oct 2020 16:08:24 +0200, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Sat, Oct 17, 2020 at 04:25:25AM -0700, Raj, Ashok wrote:
> > > For devices that *don't* use a stop marker, the PCIe spec says
> > > (10.4.1.2):
> > > 
> > >   To stop [using a PASID] without using a Stop Marker Message, the
> > >   function shall:
> > >   1. Stop queueing new Page Request Messages for this PASID.  
> > 
> > The device driver would need to tell stop sending any new PR's.
> >   
> > >   2. Finish transmitting any multi-page Page Request Messages for this
> > >      PASID (i.e. send the Page Request Message with the L bit Set).
> > >   3. Wait for PRG Response Messages associated any outstanding Page
> > >      Request Messages for the PASID.
> > > 
> > > So they have to flush their PR themselves. And since the device driver
> > > completes this sequence before calling unbind(), then there shouldn't
> > > be any oustanding PR for the PASID, and unbind() doesn't need to
> > > flush, right?  
> > 
> > I can see how the device can complete #2,3 above. But the device driver
> > isn't the one managing page-responses right. So in order for the device
> > to know the above sequence is complete, it would need to get some
> > assist from IOMMU driver?  
> 
> No the device driver just waits for the device to indicate that it has
> completed the sequence. That's what the magic stop-PASID mechanism
> described by PCIe does. In 6.20.1 "Managing PASID TLP Prefix Usage" it
> says:
> 
> "A Function must have a mechanism to request that it gracefully stop using
>  a specific PASID. This mechanism is device specific but must satisfy the
>  following rules:
>  [...]
>  * When the stop request mechanism indicates completion, the Function has:
>    [...]
>    * Complied with additional rules described in Address Translation
>      Services (Chapter 10 [10.4.1.2 quoted above]) if Address Translations
>      or Page Requests were issued on the behalf of this PASID."
> 
> So after the device driver initiates this mechanism in the device, the
> device must be able to indicate completion of the mechanism, which
> includes completing all in-flight Page Requests. At that point the device
> driver can call unbind() knowing there is no pending PR for this PASID.
> 
In step #3, I think it is possible that device driver received page response
as part of the auto page response, so it may not guarantee all the in-flight
PRQs are completed inside IOMMU. Therefore, drain is _always_ needed to be
sure?

> Thanks,
> Jean
> 
> > 
> > How does the driver know that everything host received has been
> > responded back to device?
> >   
> > >   
> > > > I'm not sure about other IOMMU's how they behave, When there is no
> > > > space in the PRQ, IOMMU auto-responds to the device. This puts the
> > > > device in a while (1) loop. The fake successful response will let
> > > > the device do a ATS lookup, and that would fail forcing the device
> > > > to do another PRQ.  
> > > 
> > > But in the sequence above, step 1 should ensure that the device will
> > > not send another PR for any successful response coming back at step
> > > 3.  
> > 
> > True, but there could be some page-request in flight on its way to the
> > IOMMU. By draining and getting that round trip back to IOMMU we
> > gaurantee things in flight are flushed to PRQ after that Drain
> > completes.  
> > > 
> > > So I agree with the below if we suspect there could be pending PR, but
> > > given that pending PR are a stop marker thing and we don't know any
> > > device using stop markers, I wondered why I bothered implementing
> > > PRIq flush at all for SMMUv3, hence this RFC.
> > >   
> > 
> > Cheers,
> > Ashok  


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
