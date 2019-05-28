Return-Path: <SRS0=b5RZ=T4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF24DC04AB6
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 09:19:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0B9208C3
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 09:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0B9208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7AA8C1BCC;
	Tue, 28 May 2019 09:19:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E31C31B5C;
	Tue, 28 May 2019 09:18:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 90492EC;
	Tue, 28 May 2019 09:18:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E8B3341;
	Tue, 28 May 2019 02:18:52 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0993F59C;
	Tue, 28 May 2019 02:18:48 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
To: "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
	<20190512123022-mutt-send-email-mst@kernel.org>
	<20190527092604.GB21613@8bytes.org>
	<20190527111345-mutt-send-email-mst@kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <99ff5494-bfdf-f4ef-b2d2-c177add385c6@arm.com>
Date: Tue, 28 May 2019 10:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527111345-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: Mark Rutland <Mark.Rutland@arm.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"frowand.list@gmail.com" <frowand.list@gmail.com>,
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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

On 27/05/2019 16:15, Michael S. Tsirkin wrote:
> On Mon, May 27, 2019 at 11:26:04AM +0200, Joerg Roedel wrote:
>> On Sun, May 12, 2019 at 12:31:59PM -0400, Michael S. Tsirkin wrote:
>>> OK this has been in next for a while.
>>>
>>> Last time IOMMU maintainers objected. Are objections
>>> still in force?
>>>
>>> If not could we get acks please?
>>
>> No objections against the code, I only hesitated because the Spec was
>> not yet official.
>>
>> So for the code:
>>
>> 	Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> Last spec patch had a bunch of comments not yet addressed.
> But I do not remember whether comments are just about wording
> or about the host/guest interface as well.
> Jean-Philippe could you remind me please?

It's mostly wording, but there is a small change in the config space
layout and two new feature bits. I'll send a new version of the driver
when possible.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
