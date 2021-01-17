Return-Path: <SRS0=4ZwB=GU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BB6C433DB
	for <iommu@archiver.kernel.org>; Sun, 17 Jan 2021 05:30:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EC52311F
	for <iommu@archiver.kernel.org>; Sun, 17 Jan 2021 05:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EC52311F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C4063229D4;
	Sun, 17 Jan 2021 05:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q6Qrm+u9Syxr; Sun, 17 Jan 2021 05:30:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 82AF722925;
	Sun, 17 Jan 2021 05:30:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63BC2C0893;
	Sun, 17 Jan 2021 05:30:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8906CC013A
 for <iommu@lists.linux-foundation.org>; Sun, 17 Jan 2021 05:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6FDAB87405
 for <iommu@lists.linux-foundation.org>; Sun, 17 Jan 2021 05:30:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mslHfDQDzMzr for <iommu@lists.linux-foundation.org>;
 Sun, 17 Jan 2021 05:30:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CD25F873FB
 for <iommu@lists.linux-foundation.org>; Sun, 17 Jan 2021 05:30:43 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E1E323107;
 Sun, 17 Jan 2021 05:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610861443;
 bh=DpapfS8CloHhWIyfLsKQuj+NWk694+ddY9JT8yb4Z6U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oXNqSd+dokYfehm1UYjzF5ow+mxEZgK6nonOZmGu3AgNjswSp1q0eAeRyJFfxbmVO
 n/n5xjUpZT1CtG/Z7KQkTqJr6VXJnUW7X5pfyyLtTT9tooiul5djn86uuY0vDSGlQT
 j7Ta3UEIceNucHDMt4alQf5oHlK6kAwYg/966t2LgB5dHSf9aixzKYdtcCGSPpIxNO
 NlXBWLtKnd2IbDinD6b3c/kX7CtXBw/5LxSwj3QGZG4RGRbzXkhJ5vn8J8dzi6D+vl
 JkbPPvcsrtJAse0SrFXbC2afUrfdaLRaHmWMMGZuAsH15Sn1v7ILYeGew9ByfE7iwJ
 cE3KQ/YK8hbAQ==
Date: Sun, 17 Jan 2021 07:30:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
Message-ID: <20210117053039.GO944463@unreal>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-2-baolu.lu@linux.intel.com>
 <20210114132627.GA944463@unreal>
 <b0c8b260-8e23-a5bd-d2da-ca1d67cdfa8a@linux.intel.com>
 <20210115063108.GI944463@unreal>
 <c58adc13-306a-8df8-19e1-27f834b3a7c9@linux.intel.com>
 <20210116083904.GN944463@unreal>
 <eda6ae9f-76eb-3254-ce58-ea355418a4b1@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eda6ae9f-76eb-3254-ce58-ea355418a4b1@linux.intel.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 sanjay.k.kumar@intel.com, mona.hossain@intel.com, samuel.ortiz@intel.com,
 kwankhede@nvidia.com, will@kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, netanelg@mellanox.com,
 maz@kernel.org, vkoul@kernel.org, jgg@mellanox.com, yan.y.zhao@linux.intel.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, bhelgaas@google.com, tglx@linutronix.de,
 megha.dey@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 dmaengine@vger.kernel.org, pbonzini@redhat.com, dwmw2@infradead.org
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

On Sat, Jan 16, 2021 at 04:47:40PM +0800, Lu Baolu wrote:
> Hi Leon,
>
> On 2021/1/16 16:39, Leon Romanovsky wrote:
> > On Sat, Jan 16, 2021 at 09:20:16AM +0800, Lu Baolu wrote:
> > > Hi,
> > >
> > > On 2021/1/15 14:31, Leon Romanovsky wrote:
> > > > On Fri, Jan 15, 2021 at 07:49:47AM +0800, Lu Baolu wrote:
> > > > > Hi Leon,
> > > > >
> > > > > On 1/14/21 9:26 PM, Leon Romanovsky wrote:
> > > > > > On Thu, Jan 14, 2021 at 09:30:02AM +0800, Lu Baolu wrote:
> > > > > > > Some vendor IOMMU drivers are able to declare that it is running in a VM
> > > > > > > context. This is very valuable for the features that only want to be
> > > > > > > supported on bare metal. Add a capability bit so that it could be used.
> > > > > >
> > > > > > And how is it used? Who and how will set it?
> > > > >
> > > > > Use the existing iommu_capable(). I should add more descriptions about
> > > > > who and how to use it.
> > > >
> > > > I want to see the code that sets this capability.
> > >
> > > Currently we have Intel VT-d and the virt-iommu setting this capability.
> > >
> > >   static bool intel_iommu_capable(enum iommu_cap cap)
> > >   {
> > >   	if (cap == IOMMU_CAP_CACHE_COHERENCY)
> > >   		return domain_update_iommu_snooping(NULL) == 1;
> > >   	if (cap == IOMMU_CAP_INTR_REMAP)
> > >   		return irq_remapping_enabled == 1;
> > > +	if (cap == IOMMU_CAP_VIOMMU)
> > > +		return caching_mode_enabled();
> > >
> > >   	return false;
> > >   }
> > >
> > > And,
> > >
> > > +static bool viommu_capable(enum iommu_cap cap)
> > > +{
> > > +	if (cap == IOMMU_CAP_VIOMMU)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> >
> > These two functions are reading this cap and not setting.
> > Where can I see code that does "cap = IOMMU_CAP_VIOMMU" and not "=="?
>
> The iommu_capable() is a generic IOMMU interface to query IOMMU
> capabilities. It takes @bus and @cap as input, and calls the callback
> of vendor iommu. If the vendor iommu driver supports the specific
> capability, it returns true. Otherwise, it returns false.
>
> bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
> {
>         if (!bus->iommu_ops || !bus->iommu_ops->capable)
>                 return false;
>
>         return bus->iommu_ops->capable(cap);
> }
> EXPORT_SYMBOL_GPL(iommu_capable);
>
> In the vendor iommu's callback, it checks the capability and returns a
> value according to its capability, just as showed above.

Ohh, sorry.
I missed "iommu_capable(dev->bus, IOMMU_CAP_VIOMMU)" from second patch.

Thanks

>
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
