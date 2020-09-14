Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092BEC433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 16:23:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9981021BE5
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 16:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9981021BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E00986819;
	Mon, 14 Sep 2020 16:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qtGBIy1cse9G; Mon, 14 Sep 2020 16:23:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 50DF78686A;
	Mon, 14 Sep 2020 16:23:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AC5DC0859;
	Mon, 14 Sep 2020 16:23:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34810C0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 16:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1CB0987226
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 16:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GocB6NpjXKAx for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 16:22:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 210908721A
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 16:22:57 +0000 (UTC)
IronPort-SDR: Xo916Y7vrn8cIS9WE1TWXXLvn+wJzY8OEFAe+d8UD4zxaVDJz/jmK/AO+AlC6To5JKEak6B/SN
 1/rJ+b10xrCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="156499522"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; d="scan'208";a="156499522"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 09:22:54 -0700
IronPort-SDR: 4I677f4bZnFVVaRmbJ3faRKKb7j7nuoM+KQ72oWzlmSaz0A6vgDfXMSeGD288ocFGD6IlUTyDz
 7iml14FbGuvg==
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; d="scan'208";a="482406971"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 09:22:54 -0700
Date: Mon, 14 Sep 2020 09:22:47 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200914162247.GA63399@otc-nc-03>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <20200914133113.GB1375106@myrica>
 <20200914134738.GX904879@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914134738.GX904879@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 jun.j.tian@intel.com, alex.williamson@redhat.com, hao.wu@intel.com
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

Hi Jason,

On Mon, Sep 14, 2020 at 10:47:38AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 14, 2020 at 03:31:13PM +0200, Jean-Philippe Brucker wrote:
> 
> > > Jason suggest something like /dev/sva. There will be a lot of other
> > > subsystems that could benefit from this (e.g vDPA).
> > 
> > Do you have a more precise idea of the interface /dev/sva would provide,
> > how it would interact with VFIO and others?  vDPA could transport the
> > generic iommu.h structures via its own uAPI, and call the IOMMU API
> > directly without going through an intermediate /dev/sva handle.
> 
> Prior to PASID IOMMU really only makes sense as part of vfio-pci
> because the iommu can only key on the BDF. That can't work unless the
> whole PCI function can be assigned. It is hard to see how a shared PCI
> device can work with IOMMU like this, so may as well use vfio.
> 
> SVA and various vIOMMU models change this, a shared PCI driver can
> absoultely work with a PASID that is assigned to a VM safely, and
> actually don't need to know if their PASID maps a mm_struct or
> something else.

Well, IOMMU does care if its a native mm_struct or something that belongs
to guest. Because you need ability to forward page-requests and pickup
page-responses from guest. Since there is just one PRQ on the IOMMU and
responses can't be sent directly. You have to depend on vIOMMU type
interface in guest to make all of this magic work right?

> 
> So, some /dev/sva is another way to allocate a PASID that is not 1:1
> with mm_struct, as the existing SVA stuff enforces. ie it is a way to
> program the DMA address map of the PASID.
> 
> This new PASID allocator would match the guest memory layout and

Not sure what you mean by "match guest memory layout"? 
Probably, meaning first level is gVA or gIOVA? 

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
