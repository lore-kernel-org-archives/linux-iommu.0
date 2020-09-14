Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F4C433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 22:44:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4958020738
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 22:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4958020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E906487069;
	Mon, 14 Sep 2020 22:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id viCuOqQ6vwCh; Mon, 14 Sep 2020 22:44:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A28878705D;
	Mon, 14 Sep 2020 22:44:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85980C0859;
	Mon, 14 Sep 2020 22:44:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2C79C0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 22:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 891122034F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 22:44:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FDhLvHYkmqdK for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 22:44:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id E8EE120016
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 22:44:45 +0000 (UTC)
IronPort-SDR: Ujh4hb4jAGbtJA7lKcOOcaULMtLU5kzk3riTidkhV8HCj9lo4SAU4nVL1o8L+hQofLLpf8NECG
 4rkh/57JZfZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="223354301"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; d="scan'208";a="223354301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 15:44:44 -0700
IronPort-SDR: uB1ZmZ4KFxqP91j4vMmzpIdbASbHDA5HSnkzQobFxXgdVKhLO8WwjJo2VrPBCYAbGP9nov1xzc
 Kk+LxiRVqOyw==
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; d="scan'208";a="301914295"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 15:44:44 -0700
Date: Mon, 14 Sep 2020 15:44:38 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200914224438.GA65940@otc-nc-03>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <20200914133113.GB1375106@myrica>
 <20200914134738.GX904879@nvidia.com>
 <20200914162247.GA63399@otc-nc-03>
 <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home>
 <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home>
 <20200914190057.GM904879@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914190057.GM904879@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 jun.j.tian@intel.com, Alex Williamson <alex.williamson@redhat.com>,
 hao.wu@intel.com
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

I thought we discussed this at LPC, but still seems to be going in
circles :-(.


On Mon, Sep 14, 2020 at 04:00:57PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 14, 2020 at 12:23:28PM -0600, Alex Williamson wrote:
> > On Mon, 14 Sep 2020 14:41:21 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > > On Mon, Sep 14, 2020 at 10:58:57AM -0600, Alex Williamson wrote:
> > >  
> > > > "its own special way" is arguable, VFIO is just making use of what's
> > > > being proposed as the uapi via its existing IOMMU interface.  
> > > 
> > > I mean, if we have a /dev/sva then it makes no sense to extend the
> > > VFIO interfaces with the same stuff. VFIO should simply accept a PASID
> > > created from /dev/sva and use it just like any other user-DMA driver
> > > would.
> > 
> > I don't think that's absolutely true.  By the same logic, we could say
> > that pci-sysfs provides access to PCI BAR and config space
> > resources,
> 
> No, it is the reverse, VFIO is a better version of pci-sysfs, so
> pci-sysfs is the one that is obsoleted by VFIO. Similarly a /dev/sva
> would be the superset interface for PASID, so whatver VFIO has would
> be obsoleted.

As you had suggested earlier in the mail thread could Jason Wang maybe
build out what it takes to have a full fledged /dev/sva interface for vDPA
and figure out how the interfaces should emerge? otherwise it appears
everyone is talking very high level and with that limited understanding of
how things work at the moment. 

As Kevin pointed out there are several aspects, and a real prototype from
interested people would be the best way to understand the easy/hard aspects
of moving between the proposals.

- PASID allocation and life cycle management
  Managing both 1-1 (as its done today) and also support a guest PASID
  space. (Supporting guest PASID range is required for migration I suppose)
- Page request processing.
- Interaction with vIOMMU, vSVA requires vIOMMU for supporting
  invalidations, forwarding prq and such.
- Supporting ENQCMD in guest. (Today its just in Intel products, but its
  also submitted to PCIe SIG) and if you are a member should be able to see
  that. FWIW, it might already be open for public review, it not now maybe
  pretty soon.
  
  For Intel we have some KVM interaction setting up the guest pasid->host
  pasid interaces.

This has to move ahead of these email discussions, hoping somone with the
right ideas would help move this forward.

Cheers,
Ashok


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
