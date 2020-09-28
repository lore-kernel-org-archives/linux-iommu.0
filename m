Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536DDC2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:42:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D898523A52
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecGWt0qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D898523A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7740585BD5;
	Mon, 28 Sep 2020 22:42:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f6P2aBUpZxsN; Mon, 28 Sep 2020 22:42:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6DBA85BCF;
	Mon, 28 Sep 2020 22:42:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99748C0889;
	Mon, 28 Sep 2020 22:42:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE802C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:42:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B45E986554
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:42:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tz02USY2sXqF for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 22:42:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 56DED86508
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:42:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601332954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pawf0Nt5qToWpEZxVrQjuGmslo4NTUl8RBE8gKS2hhE=;
 b=ecGWt0qGYfH+SV38aRZe0V71+0q5SBPKgabFfSnqBP97e+cak1KS3iXE50qKcNu7+Ks0Yb
 rDbS/vVn26yGGQdhzkeWtj9Gu0FC3FvVEpiEvGnfo+vXAQ/gGu2Q3i+2RgsFBjXinAoWdg
 8FGrvEN99GjjUIRi7yxJ6dnYz8Lpx00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-wZwDfrq6MYqXbig9Vv5OqA-1; Mon, 28 Sep 2020 18:42:32 -0400
X-MC-Unique: wZwDfrq6MYqXbig9Vv5OqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15086802B61;
 Mon, 28 Sep 2020 22:42:30 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F035960C11;
 Mon, 28 Sep 2020 22:42:26 +0000 (UTC)
Date: Mon, 28 Sep 2020 16:42:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC 0/3] iommu: Reserved regions for IOVAs beyond dma_mask and
 iommu aperture
Message-ID: <20200928164224.12350d84@w520.home>
In-Reply-To: <20200928195037.22654-1-eric.auger@redhat.com>
References: <20200928195037.22654-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: jean-philippe.brucker@arm.com, dwmw2@infradead.org, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, eric.auger.pro@gmail.com
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

On Mon, 28 Sep 2020 21:50:34 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> VFIO currently exposes the usable IOVA regions through the
> VFIO_IOMMU_GET_INFO ioctl / VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> capability. However it fails to take into account the dma_mask
> of the devices within the container. The top limit currently is
> defined by the iommu aperture.

I think that dma_mask is traditionally a DMA API interface for a device
driver to indicate to the DMA layer which mappings are accessible to the
device.  On the other hand, vfio makes use of the IOMMU API where the
driver is in userspace.  That userspace driver has full control of the
IOVA range of the device, therefore dma_mask is mostly irrelevant to
vfio.  I think the issue you're trying to tackle is that the IORT code
is making use of the dma_mask to try to describe a DMA address
limitation imposed by the PCI root bus, living between the endpoint
device and the IOMMU.  Therefore, if the IORT code is exposing a
topology or system imposed device limitation, this seems much more akin
to something like an MSI reserved range, where it's not necessarily the
device or the IOMMU with the limitation, but something that sits
between them.

> So, for instance, if the IOMMU supports up to 48bits, it may give
> the impression the max IOVA is 48b while a device may have a
> dma_mask of 42b. So this API cannot really be used to compute
> the max usable IOVA.
> 
> This patch removes the IOVA region beyond the dma_mask's.

Rather it adds a reserved region accounting for the range above the
device's dma_mask.  I don't think the IOMMU API should be consuming
dma_mask like this though.  For example, what happens in
pci_dma_configure() when there are no OF or ACPI DMA restrictions?  It
appears to me that the dma_mask from whatever previous driver had the
device carries over to the new driver.  That's generally ok for the DMA
API because a driver is required to set the device's DMA mask.  It
doesn't make sense however to blindly consume that dma_mask and export
it via an IOMMU API.  For example I would expect to see different
results depending on whether a host driver has been bound to a device.
It seems the correct IOMMU API approach would be for the IORT code to
specifically register reserved ranges for the device.

> As we start to expose this reserved region in the sysfs file
> /sys/kernel/iommu_groups/<n>/reserved_regions, we also need to
> handle the IOVA range beyond the IOMMU aperture to handle the case
> where the dma_mask would have a higher number of bits than the iommu
> max input address.

Why?  The IOMMU geometry already describes this and vfio combines both
the IOMMU geometry and the device reserved regions when generating the
IOVA ranges?  Who is going to consume this information?  Additionally
it appears that reserved regions will report different information
depending on whether a device is attached to a domain.

> This is a change to the ABI as this reserved region was not yet
> exposed in sysfs /sys/kernel/iommu_groups/<n>/reserved_regions or
> through the VFIO ioctl. At VFIO level we increment the version of
> the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE capability to advertise
> that change.

Is this really an ABI change?  The original entry for reserved regions
includes:

  Not necessarily all reserved regions are listed. This is typically
  used to output direct-mapped, MSI, non mappable regions.

I imagine the intention here was non-mappable relative to the IOMMU,
but non-mappable to the device is essentially what we're including
here.

I'm also concerned about bumping the vfio interface version for the
IOVA range.  We're not changing the interface, we're modifying the
result, and even then only for a fraction of users.  How many users are
potentially broken by that change?  Are we going to bump the version
for everyone any time the result changes on any platform?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
