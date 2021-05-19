Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACFBC433ED
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 15:23:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B914611B0
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 15:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B914611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 456C8403ED;
	Wed, 19 May 2021 15:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1iBs0LgwDFGx; Wed, 19 May 2021 15:23:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E848400FA;
	Wed, 19 May 2021 15:23:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EE5DC000E;
	Wed, 19 May 2021 15:23:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30E2FC0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 15:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10DA860719
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 15:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JdhUx54SjGhp for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 15:23:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17E3360710
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 15:23:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34EF511D4;
 Wed, 19 May 2021 08:23:29 -0700 (PDT)
Received: from [10.57.66.179] (unknown [10.57.66.179])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E1C63F73D;
 Wed, 19 May 2021 08:23:27 -0700 (PDT)
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
 <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca> <YKJnPGonR+d8rbu/@8bytes.org>
 <20210517133500.GP1096940@ziepe.ca> <YKKNLrdQ4QjhLrKX@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <131327e3-5066-7a88-5b3c-07013585eb01@arm.com>
Date: Wed, 19 May 2021 16:23:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKKNLrdQ4QjhLrKX@8bytes.org>
Content-Language: en-GB
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-05-17 16:35, Joerg Roedel wrote:
> On Mon, May 17, 2021 at 10:35:00AM -0300, Jason Gunthorpe wrote:
>> Well, I'm sorry, but there is a huge other thread talking about the
>> IOASID design in great detail and why this is all needed. Jumping into
>> this thread without context and basically rejecting all the
>> conclusions that were reached over the last several weeks is really
>> not helpful - especially since your objection is not technical.
>>
>> I think you should wait for Intel to put together the /dev/ioasid uAPI
>> proposal and the example use cases it should address then you can give
>> feedback there, with proper context.
> 
> Yes, I think the next step is that someone who read the whole thread
> writes up the conclusions and a rough /dev/ioasid API proposal, also
> mentioning the use-cases it addresses. Based on that we can discuss the
> implications this needs to have for IOMMU-API and code.
> 
>  From the use-cases I know the mdev concept is just fine. But if there is
> a more generic one we can talk about it.

Just to add another voice here, I have some colleagues working on 
drivers where they want to use SMMU Substream IDs for a single hardware 
block to operate on multiple iommu_domains managed entirely within the 
kernel. Using an mdev-like approach with aux domains is pretty much the 
ideal fit for this use-case, while all the IOASID discussion appears 
centred on SVA and userspace interfaces, and as such barely relevant if 
at all.

I seem to recall a non-trivial amount of effort going into the aux 
domain design too, so the promise of replacing it with "a big TBD" just 
because vfio-mdev turned out to be awful hardly fills me with enthusiasm 
either :/

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
