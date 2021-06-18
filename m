Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D507CC48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 15:37:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C59610A2
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 15:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C59610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E3218305A;
	Fri, 18 Jun 2021 15:37:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bsxZ1rGnn8eG; Fri, 18 Jun 2021 15:37:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3DA2F82F9B;
	Fri, 18 Jun 2021 15:37:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 137CBC000D;
	Fri, 18 Jun 2021 15:37:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54B1AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 15:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48DDB400ED
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 15:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id phSXQ8AWA4pS for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:37:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 980AC400DC
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 15:37:42 +0000 (UTC)
IronPort-SDR: GOk+jKiKir1QOTm3j7KtWDD8v8Lg+U9cpjQ2jq2PTie5aSU6IGEAFaZOuWNgWXaxRJ97y1HK7v
 XFaHbslliDvw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206611426"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; d="scan'208";a="206611426"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2021 08:37:38 -0700
IronPort-SDR: xhESf2oMa+8VoQ5jV/dGg2MUo/FbH7/yt+V3DJLY/BhMChnHHNfE0MCQxRHVYZgqywzqx4n2m3
 RcB9xiGAa+tA==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; d="scan'208";a="489102206"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2021 08:37:37 -0700
Date: Fri, 18 Jun 2021 08:37:35 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <20210618153735.GA37688@otc-nc-03>
References: <20210612105711.7ac68c83.alex.williamson@redhat.com>
 <20210614140711.GI1002214@nvidia.com>
 <20210614102814.43ada8df.alex.williamson@redhat.com>
 <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
 <MWHPR11MB188692A6182B1292FADB3BDB8C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210616133937.59050e1a.alex.williamson@redhat.com>
 <MWHPR11MB18865DF9C50F295820D038798C0E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMykBzUHmATPbmdV@8bytes.org> <20210618151506.GG1002214@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210618151506.GG1002214@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Fri, Jun 18, 2021 at 12:15:06PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 18, 2021 at 03:47:51PM +0200, Joerg Roedel wrote:
> > Hi Kevin,
> > 
> > On Thu, Jun 17, 2021 at 07:31:03AM +0000, Tian, Kevin wrote:
> > > Now let's talk about the new IOMMU behavior:
> > > 
> > > -   A device is blocked from doing DMA to any resource outside of
> > >     its group when it's probed by the IOMMU driver. This could be a
> > >     special state w/o attaching to any domain, or a new special domain
> > >     type which differentiates it from existing domain types (identity, 
> > >     dma, or unmanged). Actually existing code already includes a
> > >     IOMMU_DOMAIN_BLOCKED type but nobody uses it.
> > 
> > There is a reason for the default domain to exist: Devices which require
> > RMRR mappings to be present. You can't just block all DMA from devices
> > until a driver takes over, we put much effort into making sure there is
> > not even a small window in time where RMRR regions (unity mapped regions
> > on AMD) are not mapped.
> 
> Yes, I think the DMA blocking can only start around/after a VFIO type
> driver has probed() and bound to a device in the group, not much
> different from today.

Does this mean when a device has a required "RMRR" that requires a unity
mapping we block assigning those devices to guests? I remember we had some
restriction but there was a need to go around it at some point in time.

- Either we disallow assigning devices with RMRR
- Break that unity map when the device is probed and after which any RMRR
  access from device will fault.

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
