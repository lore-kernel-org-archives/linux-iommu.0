Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F4BCA9EC2
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 22:44:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FCE208C0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 22:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FCE208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4BDAFE8A;
	Mon, 28 Oct 2019 22:44:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 99151DB1
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 22:44:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 37AF487C
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 22:44:38 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Oct 2019 15:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; d="scan'208";a="210976010"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2019 15:44:36 -0700
Date: Mon, 28 Oct 2019 15:49:00 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20191028154900.0be0a48f@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0FF0@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<ae437be4-e633-e670-0e1f-d07b4364f651@linux.intel.com>
	<20191024214311.43d76a5c@jacob-builder>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC60@SHSMSX104.ccr.corp.intel.com>
	<e950cde8-8cd9-6089-c833-23d2ffb539d1@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5D0FF0@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Fri, 25 Oct 2019 15:52:39 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> > Sent: Friday, October 25, 2019 10:39 PM
> > 
> > Hi,
> > 
> > On 10/25/19 2:40 PM, Tian, Kevin wrote:  
> > >>>> ioasid_register_allocator(&iommu->pasid_allocator);
> > >>>> +			if (ret) {
> > >>>> +				pr_warn("Custom PASID
> > >>>> allocator registeration failed\n");
> > >>>> +				/*
> > >>>> +				 * Disable scalable mode on
> > >>>> this IOMMU if there
> > >>>> +				 * is no custom allocator.
> > >>>> Mixing SM capable vIOMMU
> > >>>> +				 * and non-SM vIOMMU are not
> > >>>> supported.
> > >>>> +				 */
> > >>>> +				intel_iommu_sm = 0;  
> > >>> It's insufficient to disable scalable mode by only clearing
> > >>> intel_iommu_sm. The DMA_RTADDR_SMT bit in root entry has
> > >>> already  
> > >> been  
> > >>> set. Probably, you need to
> > >>>
> > >>> for each iommu
> > >>> 	clear DMA_RTADDR_SMT in root entry
> > >>>
> > >>> Alternatively, since vSVA is the only customer of this custom
> > >>> PASID allocator, is it possible to only disable SVA here?
> > >>>  
> > >> Yeah, I think disable SVA is better. We can still do gIOVA in
> > >> SM. I guess we need to introduce a flag for sva_enabled.  
> > > I'm not sure whether tying above logic to SVA is the right
> > > approach. If vcmd interface doesn't work, the whole SM mode
> > > doesn't make sense which is based on PASID-granular protection
> > > (SVA is only one usage atop). If the only remaining usage of SM
> > > is to map gIOVA using reserved PASID#0, then why not disabling SM
> > > and just fallback to legacy mode?
> > >
> > > Based on that I prefer to disabling the SM mode completely (better
> > > through an interface), and move the logic out of CONFIG_INTEL_
> > > IOMMU_SVM
> > >  
> > 
> > Unfortunately, it is dangerous to disable SM after boot. SM uses
> > different root/device contexts and pasid table formats. Disabling SM
> > after boot requires changing above from SM format into legacy
> > format.  
> 
> You are correct.
> 
> > 
> > Since ioasid registration failure is a rare case. How about moving
> > this part of code up to the early stage of intel_iommu_init() and
> > returning error if hardware present vcmd capability but software
> > fails to register a custom ioasid allocator?
> >   
> 
> It makes sense to me.
> 
sounds good to me too, the earlier the less to clean up.
> Thanks
> Kevin

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
