Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E75AC3A5A2
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 14:15:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A55206C1
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjy7cHW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A55206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CE4F2D36;
	Mon, 19 Aug 2019 14:15:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2777DB1F
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 14:15:04 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C48B08A6
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 14:15:03 +0000 (UTC)
Received: from localhost (78.sub-174-234-142.myvzw.com [174.234.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 177C5206BB;
	Mon, 19 Aug 2019 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566224103;
	bh=ghW8fQWaCxZlWzm+5hUKUnOvak9BgpeDNiI2UtpVk2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjy7cHW7cDzXr9c6ydEgJC1iqaPIevl3w8PG7pY8mVSo3M5TMNoauve1crI4U6QnP
	74eRNso599nMjiBcIwA6wsUIvoZ3ViLIQqyJKlCz3fCQNA0BwE3abUPm7tK5y0bLI8
	wM6uzc81k5lk9YPUtkM82bqvzqx32vKr7esW18BY=
Date: Mon, 19 Aug 2019 09:15:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5 4/7] PCI/ATS: Add PRI support for PCIe VF devices
Message-ID: <20190819141500.GQ253360@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<827d051ef8c8bbfa815908ce927e607870780cb6.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<20190815222049.GL253360@google.com>
	<f05eb779-9f78-f20f-7626-16b8bd28af40@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f05eb779-9f78-f20f-7626-16b8bd28af40@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ashok.raj@intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, keith.busch@intel.com,
	iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Thu, Aug 15, 2019 at 03:39:03PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 8/15/19 3:20 PM, Bjorn Helgaas wrote:
> > [+cc Joerg, David, iommu list: because IOMMU drivers are the only
> > callers of pci_enable_pri() and pci_enable_pasid()]
> > 
> > On Thu, Aug 01, 2019 at 05:06:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > When IOMMU tries to enable Page Request Interface (PRI) for VF device
> > > in iommu_enable_dev_iotlb(), it always fails because PRI support for
> > > PCIe VF device is currently broken. Current implementation expects
> > > the given PCIe device (PF & VF) to implement PRI capability before
> > > enabling the PRI support. But this assumption is incorrect. As per PCIe
> > > spec r4.0, sec 9.3.7.11, all VFs associated with PF can only use the
> > > PRI of the PF and not implement it. Hence we need to create exception
> > > for handling the PRI support for PCIe VF device.
> > > 
> > > Also, since PRI is a shared resource between PF/VF, following rules
> > > should apply.
> > > 
> > > 1. Use proper locking before accessing/modifying PF resources in VF
> > >     PRI enable/disable call.
> > > 2. Use reference count logic to track the usage of PRI resource.
> > > 3. Disable PRI only if the PRI reference count (pri_ref_cnt) is zero.

> > Wait, why do we need this at all?  I agree the spec says VFs may not
> > implement PRI or PASID capabilities and that VFs use the PRI and
> > PASID of the PF.
> > 
> > But why do we need to support pci_enable_pri() and pci_enable_pasid()
> > for VFs?  There's nothing interesting we can *do* in the VF, and
> > passing it off to the PF adds all this locking mess.  For VFs, can we
> > just make them do nothing or return -EINVAL?  What functionality would
> > we be missing if we did that?
> 
> Currently PRI/PASID capabilities are not enabled by default. IOMMU can
> enable PRI/PASID for VF first (and not enable it for PF). In this case,
> doing nothing for VF device will break the functionality.

What is the path where we can enable PRI/PASID for VF but not for the
PF?  The call chains leading to pci_enable_pri() go through the
iommu_ops.add_device interface, which makes me think this is part of
the device enumeration done by the PCI core, and in that case I would
think this it should be done for the PF before VFs.  But maybe this
path isn't exercised until a driver does a DMA map or something
similar?

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
