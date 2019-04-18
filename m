Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98DBC282DD
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 15:36:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F1820675
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 15:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F1820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 82A8A1945;
	Thu, 18 Apr 2019 15:36:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6281F1188
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 15:36:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D4D0C828
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 15:36:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EFD015AB;
	Thu, 18 Apr 2019 08:36:06 -0700 (PDT)
Received: from [10.1.32.54] (unknown [10.1.32.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09D3E3F5AF;
	Thu, 18 Apr 2019 08:36:03 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 10/18] iommu/vt-d: Add custom allocator for IOASID
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
	<20190415143711.13c29308@x1.home>
	<20190415161015.564cb071@jacob-builder>
Message-ID: <70c6b197-029e-94cd-2745-d4a193cbbcd0@arm.com>
Date: Thu, 18 Apr 2019 16:36:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415161015.564cb071@jacob-builder>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418153602.Xf0Q9wtJiY7VJHoLwnqY9cnSpudP7r6rhMMfmMK3YPo@z>

On 16/04/2019 00:10, Jacob Pan wrote:[...]
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Register =
a custom ASID allocator if we
>> > are running
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * in a gues=
t, the purpose is to have a
>> > system wide PASID
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * namespace=
 among all PASID users.
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Note that=
 only one vIOMMU in each guest
>> > is supported.=A0 =

>> =

>> Why one vIOMMU per guest?=A0 This would prevent guests with multiple PCI
>> domains aiui.
>> =

> This is mainly for simplicity reasons. These are all virtual BDFs
> anyway. As long as guest BDF can be mapped to a host BDF, it should be
> sufficient, am I missing anything?
> =

> From PASID allocation perspective, it is not tied to any PCI device
> until bind call. We only need to track PASID ownership per guest.
> =

> virtio-IOMMU spec does support multiple PCI domains but I am not sure
> if that applies to all assigned devices, whether all assigned devices
> are under the same domain. Perhaps Jean can help to clarify how PASID
> allocation API looks like on virtio IOMMU.

[Ugh, this is much longer than I hoped. In short I don't think multiple
vIOMMUs is a problem, because the host uses the same allocator for all of
them.]

Yes there can be a single virtio-iommu instance for multiple PCI
domains, or multiple instances each managing assigned devices. It's up to
the hypervisor to decide on the topology.

For Linux and QEMU I was assuming that choosing the vIOMMU used for PASID
allocation isn't a big deal, since in the end they all use the same
allocator in the host. It gets complicated when some vIOMMUs can be
removed at runtime (unload the virtio-iommu module that was providing the
PASID allocator, and then you can't allocate PASIDs for the VT-d instance
anymore), so maybe limiting to one type of vIOMMU (don't mix VT-d and
virtio-iommu in the same VM) is more reasonable.

It's a bit more delicate from the virtio-iommu perspective. The
interface is portable and I can't tie it down to the choices we're making
for Linux and KVM. Having a system-wide PASID space is what we picked for
Linux but the PCIe architecture allows for each device to have
their own PASID space, and I suppose some hypervisors and guests might
prefer implementing it that way.

My plan for the moment is to implement global PASID allocation using one
feature bit and two new requests, but leave space for a per-device PASID
allocation, introduced with another feature bit if necessary. If it ever
gets added, I expect the per-device allocation to be done during the bind
request rather than with a separate PASID_ALLOC request.

So currently I have a new feature bit and two commands:

#define VIRTIO_IOMMU_F_PASID_ALLOC
#define VIRTIO_IOMMU_T_ALLOC_PASID
#define VIRTIO_IOMMU_T_FREE_PASID

struct virtio_iommu_req_alloc_pasid {
        struct virtio_iommu_req_head head;
        u32 reserved;

        /* Device-writeable */
        le32 pasid;
        struct virtio_iommu_req_tail tail;
};

struct virtio_iommu_req_free_pasid {
        struct virtio_iommu_req_head head;
        u32 reserved;
        le32 pasid;

        /* Device-writeable */
        struct virtio_iommu_req_tail tail;
};

If the feature bit is offered it must be used, and the guest can only use
PASIDs allocated via VIRTIO_IOMMU_T_ALLOC_PASID in its bind requests.

The PASID space is global at the host scope. If multiple virtio-iommu
devices in the VM offer the feature bit, then using either of their
command queue to issue a VIRTIO_IOMMU_F_ALLOC_PASID and
VIRTIO_IOMMU_F_FREE_PASID is equivalent. Another possibility is to require
that only one of the virtio-iommu instances per VM offers the feature bit.
I do prefer this option, but there is the vIOMMU removal problem mentioned
above - which, with the first option, could be solved by keeping a list of
PASID allocator functions rather than a single one.

I'm considering adding max_pasid field to virtio_iommu_req_alloc_pasid. If
VIRTIO_IOMMU_T_ALLOC_PASID returns a random 20-bit value then a lot of
space might be needed for storing PASID contexts (is that a real concern
though? For internal data it can use a binary tree, and the guest is not
in charge of hardware PASID tables here). If the guest is short on memory
then it could benefit from a smaller number of PASID bits. That could
either be globally configurable in the virtio-iommu config space, or using
a max_pasid field in the VIRTIO_IOMMU_T_ALLOC_PASID request. The latter
allows to support devices with less than 20 PASID bits, though we're
hoping that no one will implement that.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
