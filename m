Return-Path: <SRS0=+KpI=US=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED86C31E49
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 11:44:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1896214AF
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 11:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1896214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9C27B11CA;
	Wed, 19 Jun 2019 11:44:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 180A411C8
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 11:44:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 9867F7C
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 11:44:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 284C7360;
	Wed, 19 Jun 2019 04:44:55 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A30193F738;
	Wed, 19 Jun 2019 04:46:39 -0700 (PDT)
Subject: Re: [PATCH v8 26/29] vfio-pci: Register an iommu fault handler
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
	<20190526161004.25232-27-eric.auger@redhat.com>
	<20190603163139.70fe8839@x1.home>
	<10dd60d9-4af0-c0eb-08c9-a0db7ee1925e@redhat.com>
	<20190605154553.0d00ad8d@jacob-builder>
	<2753d192-1c46-d78e-c425-0c828e48cde2@arm.com>
	<20190606132903.064f7ac4@jacob-builder>
	<dc051424-67d7-02ff-9b8e-0d7a8a4e59eb@arm.com>
	<20190607104301.6b1bbd74@jacob-builder>
	<e02b024f-6ebc-e8fa-c30c-5bf3f4b164d6@arm.com>
	<20190610143134.7bff96e9@jacob-builder>
	<905f130b-02dc-6971-8d5b-ce87d9bc96a4@arm.com>
	<20190612115358.0d90b322@jacob-builder>
	<77405d39-81a4-d9a8-5d35-27602199867a@arm.com>
	<20190618171908.76284cd7@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <138f6a16-d2ee-d7b8-7bfb-ac08b6cfb9da@arm.com>
Date: Wed, 19 Jun 2019 12:44:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618171908.76284cd7@jacob-builder>
Content-Language: en-US
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	Vincent Stehle <Vincent.Stehle@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"ashok.raj@intel.com" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Robin Murphy <Robin.Murphy@arm.com>,
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
	"eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
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

On 19/06/2019 01:19, Jacob Pan wrote:
>>> I see this as a future extension due to limited testing,   
>>
>> I'm wondering how we deal with:
>> (1) old userspace that won't fill the new private_data field in
>> page_response. A new kernel still has to support it.
>> (2) old kernel that won't recognize the new PRIVATE_DATA flag.
>> Currently iommu_page_response() rejects page responses with unknown
>> flags.
>>
>> I guess we'll need a two-way negotiation, where userspace queries
>> whether the kernel supports the flag (2), and the kernel learns
>> whether it should expect the private data to come back (1).
>>
> I am not sure case (1) exist in that there is no existing user space
> supports PRQ w/o private data. Am I missing something?
> 
> For VT-d emulation, private data is always part of the scalable mode
> PASID capability. If vIOMMU query host supports PASID and scalable
> mode, it will always support private data once PRQ is enabled.

Right if VT-d won't ever support page_response without private data then
I don't think we have to worry about (1).

> So I think we only need to negotiate (2) which should be covered by
> VT-d PASID cap.
> 
>>> perhaps for
>>> now, can you add paddings similar to page request? Make it 64B as
>>> well.  
>>
>> I don't think padding is necessary, because iommu_page_response is
>> sent by userspace to the kernel, unlike iommu_fault which is
>> allocated by userspace and filled by the kernel.
>>
>> Page response looks a lot more like existing VFIO mechanisms, so I
>> suppose we'll wrap the iommu_page_response structure and include an
>> argsz parameter at the top:
>>
>> 	struct vfio_iommu_page_response {
>> 		u32 argsz;
>> 		struct iommu_page_response pr;
>> 	};
>>
>> 	struct vfio_iommu_page_response vpr = {
>> 		.argsz = sizeof(vpr),
>> 		.pr = ...
>> 		...
>> 	};
>>
>> 	ioctl(devfd, VFIO_IOMMU_PAGE_RESPONSE, &vpr);
>>
>> In that case supporting private data can be done by simply appending a
>> field at the end (plus the negotiation above).
>>
> Do you mean at the end of struct vfio_iommu_page_response{}? or at
> the end of that seems struct iommu_page_response{}?
> 
> The consumer of the private data is iommu driver not vfio. So I think
> you want to add the new field at the end of struct iommu_page_response,
> right?

Yes that's what I meant

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
