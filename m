Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D40C2BA2B
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 22:34:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BFA221F9
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 22:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BFA221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1524984640;
	Thu, 16 Apr 2020 22:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aJ4m3HfcFhzA; Thu, 16 Apr 2020 22:33:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 50F8B8459A;
	Thu, 16 Apr 2020 22:33:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C21DC089E;
	Thu, 16 Apr 2020 22:33:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F23ADC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 22:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E0B4B84607
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 22:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jbaBiamSH0kX for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 22:33:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B05EC842F6
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 22:33:55 +0000 (UTC)
IronPort-SDR: HNsInG5glE54VMJN8rZrZHc/Yb8B2hCo5YWr6zDUTwD08kQR1Molr6kKfYJ2SBlH8azdYt/4mM
 qGyeYCZcza+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 15:33:54 -0700
IronPort-SDR: qL+HVzKL2Ic7CMcplwwLZTVPlnOUBNL6GpPH0JXLbt8+aCk6ATebQH08XRZ02j5/SnlXZ/sFFN
 OR1shIVLePIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; d="scan'208";a="333002219"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by orsmga001.jf.intel.com with ESMTP; 16 Apr 2020 15:33:54 -0700
Date: Thu, 16 Apr 2020 15:33:54 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v1 0/2] vfio/pci: expose device's PASID capability to VMs
Message-ID: <20200416223353.GC45480@otc-nc-03>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D801252@SHSMSX104.ccr.corp.intel.com>
 <ce615f64-a19b-a365-8f8e-ca29f69cc6c0@intel.com>
 <20200416221224.GA16688@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200416221224.GA16688@joy-OptiPlex-7040>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Lu, Baolu" <baolu.lu@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Ashok Raj <ashok.raj@intel.com>, "Tian, Jun J" <jun.j.tian@intel.com>, "Wu,
 Hao" <hao.wu@intel.com>
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

Hi Zhao


On Thu, Apr 16, 2020 at 06:12:26PM -0400, Yan Zhao wrote:
> On Tue, Mar 31, 2020 at 03:08:25PM +0800, Lu, Baolu wrote:
> > On 2020/3/31 14:35, Tian, Kevin wrote:
> > >> From: Liu, Yi L<yi.l.liu@intel.com>
> > >> Sent: Sunday, March 22, 2020 8:33 PM
> > >>
> > >> From: Liu Yi L<yi.l.liu@intel.com>
> > >>
> > >> Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on
> > >> Intel platforms allows address space sharing between device DMA and
> > >> applications. SVA can reduce programming complexity and enhance security.
> > >>
> > >> To enable SVA, device needs to have PASID capability, which is a key
> > >> capability for SVA. This patchset exposes the device's PASID capability
> > >> to guest instead of hiding it from guest.
> > >>
> > >> The second patch emulates PASID capability for VFs (Virtual Function) since
> > >> VFs don't implement such capability per PCIe spec. This patch emulates such
> > >> capability and expose to VM if the capability is enabled in PF (Physical
> > >> Function).
> > >>
> > >> However, there is an open for PASID emulation. If PF driver disables PASID
> > >> capability at runtime, then it may be an issue. e.g. PF should not disable
> > >> PASID capability if there is guest using this capability on any VF related
> > >> to this PF. To solve it, may need to introduce a generic communication
> > >> framework between vfio-pci driver and PF drivers. Please feel free to give
> > >> your suggestions on it.
> > > I'm not sure how this is addressed on bate metal today, i.e. between normal
> > > kernel PF and VF drivers. I look at pasid enable/disable code in intel-iommu.c.
> > > There is no check on PF/VF dependency so far. The cap is toggled when
> > > attaching/detaching the PF to its domain. Let's see how IOMMU guys
> > > respond, and if there is a way for VF driver to block PF driver from disabling
> > > the pasid cap when it's being actively used by VF driver, then we may
> > > leverage the same trick in VFIO when emulation is provided to guest.
> > 
> > IOMMU subsystem doesn't expose any APIs for pasid enabling/disabling.
> > The PCI subsystem does. It handles VF/PF like below.
> > 
> > /**
> >   * pci_enable_pasid - Enable the PASID capability
> >   * @pdev: PCI device structure
> >   * @features: Features to enable
> >   *
> >   * Returns 0 on success, negative value on error. This function checks
> >   * whether the features are actually supported by the device and returns
> >   * an error if not.
> >   */
> > int pci_enable_pasid(struct pci_dev *pdev, int features)
> > {
> >          u16 control, supported;
> >          int pasid = pdev->pasid_cap;
> > 
> >          /*
> >           * VFs must not implement the PASID Capability, but if a PF
> >           * supports PASID, its VFs share the PF PASID configuration.
> >           */
> >          if (pdev->is_virtfn) {
> >                  if (pci_physfn(pdev)->pasid_enabled)
> >                          return 0;
> >                  return -EINVAL;
> >          }
> > 
> > /**
> >   * pci_disable_pasid - Disable the PASID capability
> >   * @pdev: PCI device structure
> >   */
> > void pci_disable_pasid(struct pci_dev *pdev)
> > {
> >          u16 control = 0;
> >          int pasid = pdev->pasid_cap;
> > 
> >          /* VFs share the PF PASID configuration */
> >          if (pdev->is_virtfn)
> >                  return;
> > 
> > 
> > It doesn't block disabling PASID on PF even VFs are possibly using it.
> >
> hi
> I'm not sure, but is it possible for pci_enable_pasid() and
> pci_disable_pasid() to do the same thing as pdev->driver->sriov_configure,
> e.g. pci_sriov_configure_simple() below.
> 
> It checks whether there are VFs are assigned in pci_vfs_assigned(dev).
> and we can set the VF in assigned status if vfio_pci_open() is performed
> on the VF.

But you can still unbind the PF driver that magically causes the VF's to be
removed from the guest image too correct? 

Only the IOMMU mucks with pasid_enable/disable. And it doesn't look like
we have a path to disable without tearing down the PF binding. 

We originally had some refcounts and such and would do the real disable only
when the refcount drops to 0, but we found it wasn't actually necessary 
to protect these resources like that.

> 
> 
> int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn)
> {
>         int rc;
> 
>         might_sleep();
> 
>         if (!dev->is_physfn)
>                 return -ENODEV;
> 
>         if (pci_vfs_assigned(dev)) {
>                 pci_warn(dev, "Cannot modify SR-IOV while VFs are assigned\n");
>                 return -EPERM;
>         }
> 
>         if (nr_virtfn == 0) {
>                 sriov_disable(dev);
>                 return 0;
>         }
> 
>         rc = sriov_enable(dev, nr_virtfn);
>         if (rc < 0)
>                 return rc;
> 
>         return nr_virtfn;
> }
> 
> Thanks
> Yan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
