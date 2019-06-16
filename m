Return-Path: <SRS0=mBvT=UP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55CDC31E53
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 20:05:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD21720657
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 20:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD21720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1C40DC5D;
	Sun, 16 Jun 2019 20:04:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78610A5E
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 20:04:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
	[209.85.222.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0BCE12C3
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 20:04:54 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id p144so4958589qke.11
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 13:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=MSqaCoMGco6P2zrSK37/hWJH9CXgQkBw2hzb1U1jzNw=;
	b=jyS38rrFJNQL5SBzdfl/9bGGa+lcT/2japGNJTurujvPG0YMXyMc2uUVsLMHVjlGBp
	C+AL8AiiKUTApBE0X+WVLebqM9HnkQx8Fm1clk0FO/94xy39ChoGbL7BbReYp228nqM/
	qeXDh3eLHPrz6ItS2rt/ulCvTzQw3p8rvOyqptls3BBjPb3cPzJpnjm2R1SUklWtAYbk
	VIq5lrNjyI7DDZBYkm8mSVifUp5jfYU6/BXnzgYrbGMAIWWumit+20ZPU92UFFX7FWcS
	r2EpxhBQVwUTviBS6NcTELY9S5qkXQ+L+MqXvTx247Y6q8mbw7QY1fPXG91zPPDNF6Jb
	wWLA==
X-Gm-Message-State: APjAAAVimkVCGnaP/R9HV5vBGkrJ67+JxdsU5jWwBnntAoX2a8MI1bdM
	1w/9hnpayx+CBQTu5X/tJD17EA==
X-Google-Smtp-Source: APXvYqzk8vjSAyBVM9AEC2sCcZJe/bhI9soeo5hRV28lwc5eEPs3dYN+S5Bd7YkUw5B0eEUJ+IVZrA==
X-Received: by 2002:ae9:c21a:: with SMTP id j26mr65498831qkg.310.1560715494165;
	Sun, 16 Jun 2019 13:04:54 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	w51sm4943466qth.18.2019.06.16.13.04.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 16 Jun 2019 13:04:53 -0700 (PDT)
Date: Sun, 16 Jun 2019 16:04:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [virtio-dev] Re: [PATCH v8 2/7] dt-bindings: virtio: Add
	virtio-pci-iommu node
Message-ID: <20190616154841-mutt-send-email-mst@kernel.org>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
	<20190530170929.19366-3-jean-philippe.brucker@arm.com>
	<20190530133523-mutt-send-email-mst@kernel.org>
	<c3cd5dba-123d-e808-98b1-731ac2d4b950@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3cd5dba-123d-e808-98b1-731ac2d4b950@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
	"frowand.list@gmail.com" <frowand.list@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>
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

On Fri, May 31, 2019 at 12:13:47PM +0100, Jean-Philippe Brucker wrote:
> On 30/05/2019 18:45, Michael S. Tsirkin wrote:
> > On Thu, May 30, 2019 at 06:09:24PM +0100, Jean-Philippe Brucker wrote:
> >> Some systems implement virtio-iommu as a PCI endpoint. The operating
> >> system needs to discover the relationship between IOMMU and masters long
> >> before the PCI endpoint gets probed. Add a PCI child node to describe the
> >> virtio-iommu device.
> >>
> >> The virtio-pci-iommu is conceptually split between a PCI programming
> >> interface and a translation component on the parent bus. The latter
> >> doesn't have a node in the device tree. The virtio-pci-iommu node
> >> describes both, by linking the PCI endpoint to "iommus" property of DMA
> >> master nodes and to "iommu-map" properties of bus nodes.
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > So this is just an example right?
> > We are not defining any new properties or anything like that.
> 
> Yes it's just an example. The properties already exist but it's good to
> describe how to put them together for this particular case, because
> there isn't a precedent describing the topology for an IOMMU that
> appears on the PCI bus.
> 
> > I think down the road for non dt platforms we want to put this
> > info in the config space of the device. I do not think ACPI
> > is the best option for this since not all systems have it.
> > But that can wait.
> 
> There is the probe order problem - PCI needs this info before starting
> to probe devices on the bus.


This isn't all that special - it's pretty common for
IOMMUs to be pci devices. The solution is to have the device on
bus 0. For example, add it with

DECLARE_PCI_FIXUP_EARLY
or
DECLARE_PCI_FIXUP_CLASS_EARLY

in e.g.
arch/x86/kernel/quirks.c
or
drivers/pci/quirks.c

You can also use the configuration access capability
if there's need to access the device before its memory is
enabled.

> Maybe we could store the info in a separate
> memory region, that is referenced on the command-line and that the guest
> can read early.
> 
> Thanks,
> Jean

The point is to avoid command line hacks. Devices should be
self describing.

-- 
MST
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
