Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F70C433DF
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 18:22:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C6020760
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 18:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C6020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7D23D203CC;
	Thu, 15 Oct 2020 18:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FLrj3QLwQ3qZ; Thu, 15 Oct 2020 18:22:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3070D20352;
	Thu, 15 Oct 2020 18:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 222EBC07FF;
	Thu, 15 Oct 2020 18:22:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C0C8C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 18:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 06CA7877DE
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 18:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9z6dQkHv+L4V for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 18:22:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D618A877DA
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 18:22:13 +0000 (UTC)
IronPort-SDR: RFTYqgdMW5APddBfIko2a9qh1KY9u0bCm6tegt+p6sMOUGSYM1FyKt1/Sq4LtkWe2Iu4l3BIip
 hiSzd29OnLYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="162955879"
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; d="scan'208";a="162955879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 11:22:13 -0700
IronPort-SDR: ttF7ZwHPrxPuTc6JfEHnZrBd7RNp2hy47u3std+EIzNHXG//TdQcJesemkY2F0ldWMI6WSCjVV
 JSI/CEeCn87Q==
X-IronPort-AV: E=Sophos;i="5.77,379,1596524400"; d="scan'208";a="521941595"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 11:22:12 -0700
Date: Thu, 15 Oct 2020 11:22:11 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201015182211.GA54780@otc-nc-03>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015090028.1278108-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: kevin.tian@intel.com, Ashok Raj <ashok.raj@intel.com>, arnd@arndb.de,
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

Hi Jean

+ Baolu who is looking into this.


On Thu, Oct 15, 2020 at 11:00:27AM +0200, Jean-Philippe Brucker wrote:
> Add a parameter to iommu_sva_unbind_device() that tells the IOMMU driver
> whether the PRI queue needs flushing. When looking at the PCIe spec
> again I noticed that most of the time the SMMUv3 driver doesn't actually
> need to flush the PRI queue. Does this make sense for Intel VT-d as well
> or did I overlook something?
> 
> Before calling iommu_sva_unbind_device(), device drivers must stop the
> device from using the PASID. For PCIe devices, that consists of
> completing any pending DMA, and completing any pending page request
> unless the device uses Stop Markers. So unless the device uses Stop
> Markers, we don't need to flush the PRI queue. For SMMUv3, stopping DMA
> means completing all stall events, so we never need to flush the event
> queue.

I don't think this is true. Baolu is working on an enhancement to this,
I'll quickly summarize this below:

Stop markers are weird, I'm not certain there is any device today that
sends STOP markers. Even if they did, markers don't have a required
response, they are fire and forget from the device pov.

I'm not sure about other IOMMU's how they behave, When there is no space in
the PRQ, IOMMU auto-responds to the device. This puts the device in a
while (1) loop. The fake successful response will let the device do a ATS
lookup, and that would fail forcing the device to do another PRQ. The idea
is somewhere there the OS has repeated the others and this will find a way
in the PRQ. The point is this is less reliable and can't be the only
indication. PRQ draining has a specific sequence. 

The detailed steps are outlined in 
"Chapter 7.10 "Software Steps to Drain Page Requests & Responses"

- Submit invalidation wait with fence flag to ensure all prior
  invalidations are processed.
- submit iotlb followed by devtlb invalidation
- Submit invalidation wait with page-drain to make sure any page-requests
  issued by the device are flushed when this invalidation wait completes.
- If during the above process there was a queue overflow SW can assume no
  outstanding page-requests are there. If we had a queue full condition,
  then sw must repeat step 2,3 above.


To that extent the proposal is as follows: names are suggestive :-) I'm
making this up as I go!

- iommu_stop_page_req() - Kernel needs to make sure we respond to all
  outstanding requests (since we can't drop responses) 
  - Ensure we respond immediatly for anything that comes before the drain
    sequence completes
- iommu_drain_page_req() - Which does the above invalidation with
  Page_drain set.

Once the driver has performed a reset and before issuing any new request,
it does iommu_resume_page_req() this will ensure we start processing
incoming page-req after this point.


> 
> First patch adds flags to unbind(), and the second one lets device
> drivers tell whether the PRI queue needs to be flushed.
> 
> Other remarks:
> 
> * The PCIe spec (see quote on patch 2), says that the device signals
>   whether it has sent a Stop Marker or not during Stop PASID. In reality
>   it's unlikely that a given device will sometimes use one stop method
>   and sometimes the other, so it could be a device-wide flag rather than
>   passing it at each unbind(). I don't want to speculate too much about
>   future implementation so I prefer having the flag in unbind().
> 
> * In patch 1, uacce passes 0 to unbind(). To pass the right flag I'm
>   thinking that uacce->ops->stop_queue(), which tells the device driver
>   to stop DMA, should return whether faults are pending. This can be
>   added later once uacce has an actual PCIe user, but we need to
>   remember to do it.

I think intel iommmu driver does this today for SVA when pasid is being
freed. Its still important to go through the drain before that PASID can be
re-purposed.

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
