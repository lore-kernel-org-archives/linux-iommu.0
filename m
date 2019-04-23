Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2494C282E3
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 09:26:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BA020843
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 09:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BA020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6E297EFA;
	Tue, 23 Apr 2019 09:26:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 21D9BEF9
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 09:26:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D1577F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 09:26:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918EB374;
	Tue, 23 Apr 2019 02:26:15 -0700 (PDT)
Received: from [10.37.8.239] (unknown [10.37.8.239])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4991C3F557;
	Tue, 23 Apr 2019 02:26:13 -0700 (PDT)
Subject: Re: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an
	IOMMU cookie
To: Thomas Gleixner <tglx@linutronix.de>
References: <20190418172611.21561-1-julien.grall@arm.com>
	<20190418172611.21561-2-julien.grall@arm.com>
	<alpine.DEB.2.21.1904182126540.3174@nanos.tec.linutronix.de>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <943b0907-f2ee-63c1-7134-997ffaf6f348@arm.com>
Date: Tue, 23 Apr 2019 10:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904182126540.3174@nanos.tec.linutronix.de>
Content-Language: en-US
Cc: jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, miquel.raynal@bootlin.com,
	logang@deltatee.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423092611.Ojk3JBz_J4tyOqAb1jmr3jsMYlYAgv1Aj5_ROdYjxRc@z>

Hi Thomas,

On 4/18/19 8:28 PM, Thomas Gleixner wrote:
> On Thu, 18 Apr 2019, Julien Grall wrote:
> 
>> When an MSI doorbell is located downstream of an IOMMU, it is required
>> to swizzle the physical address with an appropriately-mapped IOVA for any
>> device attached to one of our DMA ops domain.
>>
>> At the moment, the allocation of the mapping may be done when composing
>> the message. However, the composing may be done in non-preemtible
>> context while the allocation requires to be called from preemptible
>> context.
>>
>> A follow-up patch will split the current logic in two functions
>> requiring to keep an IOMMU cookie per MSI.
>>
>> This patch introduces a new field in msi_desc to store an IOMMU cookie
>> when CONFIG_IOMMU_DMA is selected.
> 
> # git grep 'This patch' Documentation/process/
> 
> Applied to the whole series.

Sorry for that. I will rework all the commit messages and resend the series.

Cheers,

-- 
Julien Grall
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
