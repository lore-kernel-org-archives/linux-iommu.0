Return-Path: <SRS0=mJb0=T7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6735DC04AB6
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 11:14:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DAE2681C
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 11:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DAE2681C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 078891018;
	Fri, 31 May 2019 11:14:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 18C9F1011;
	Fri, 31 May 2019 11:14:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id AD3C0823;
	Fri, 31 May 2019 11:14:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A8B6341;
	Fri, 31 May 2019 04:14:13 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E6DF3F5AF;
	Fri, 31 May 2019 04:14:10 -0700 (PDT)
Subject: Re: [virtio-dev] Re: [PATCH v8 2/7] dt-bindings: virtio: Add
	virtio-pci-iommu node
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
	<20190530170929.19366-3-jean-philippe.brucker@arm.com>
	<20190530133523-mutt-send-email-mst@kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c3cd5dba-123d-e808-98b1-731ac2d4b950@arm.com>
Date: Fri, 31 May 2019 12:13:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530133523-mutt-send-email-mst@kernel.org>
Content-Language: en-US
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

On 30/05/2019 18:45, Michael S. Tsirkin wrote:
> On Thu, May 30, 2019 at 06:09:24PM +0100, Jean-Philippe Brucker wrote:
>> Some systems implement virtio-iommu as a PCI endpoint. The operating
>> system needs to discover the relationship between IOMMU and masters long
>> before the PCI endpoint gets probed. Add a PCI child node to describe the
>> virtio-iommu device.
>>
>> The virtio-pci-iommu is conceptually split between a PCI programming
>> interface and a translation component on the parent bus. The latter
>> doesn't have a node in the device tree. The virtio-pci-iommu node
>> describes both, by linking the PCI endpoint to "iommus" property of DMA
>> master nodes and to "iommu-map" properties of bus nodes.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> So this is just an example right?
> We are not defining any new properties or anything like that.

Yes it's just an example. The properties already exist but it's good to
describe how to put them together for this particular case, because
there isn't a precedent describing the topology for an IOMMU that
appears on the PCI bus.

> I think down the road for non dt platforms we want to put this
> info in the config space of the device. I do not think ACPI
> is the best option for this since not all systems have it.
> But that can wait.

There is the probe order problem - PCI needs this info before starting
to probe devices on the bus. Maybe we could store the info in a separate
memory region, that is referenced on the command-line and that the guest
can read early.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
