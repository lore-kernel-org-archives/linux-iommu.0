Return-Path: <SRS0=Ybkk=5L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A0C43331
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 17:11:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7084020714
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 17:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NjAEGI0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7084020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 332B626291;
	Thu, 26 Mar 2020 17:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dC49se2JZ4bw; Thu, 26 Mar 2020 17:11:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5E4D420451;
	Thu, 26 Mar 2020 17:11:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 451DAC1831;
	Thu, 26 Mar 2020 17:11:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE315C0177
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 17:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CA36C88E95
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 17:11:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jp6JX-0jIg0T for <iommu@lists.linux-foundation.org>;
 Thu, 26 Mar 2020 17:11:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-4101.amazon.com (smtp-fw-4101.amazon.com [72.21.198.25])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1661A88E5F
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1585242714; x=1616778714;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=7dKViaTkqgkOuleKzCaJ8koVRSroLTuB4+O9Hh8aggM=;
 b=NjAEGI0rWdDd6mfaT2wzf8mIGaTO42haxKu2YRkU6wuXUXZTkQlzEDf1
 GwlO0asAh8CaQK0PwfXojM2ycOuVgbRY+jt23KQewPwAy4fNl2/sqnSs1
 3i0Zrnd5WmmopirrpF+FfYUskwxljKhiWSUvS+lVAUrvGNJ9z0Peo0+8K g=;
IronPort-SDR: VLVG9KdHa9SYDLOS5XHvQwlSi5CKx1/HQVCocDXLl0fRLLxFzUUQLhJik/SBPYR9NgJKGCXbkw
 vTgHetDIaOrA==
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; d="scan'208";a="23030054"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 26 Mar 2020 17:11:39 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS
 id 15434A2102; Thu, 26 Mar 2020 17:11:39 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Mar 2020 17:11:38 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.162.39) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Mar 2020 17:11:34 +0000
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
To: Christoph Hellwig <hch@lst.de>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200326170516.GB6387@lst.de>
Message-ID: <cef4f2f5-3530-82f8-c0f5-ee0c2701ce6a@amazon.com>
Date: Thu, 26 Mar 2020 18:11:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326170516.GB6387@lst.de>
Content-Language: en-US
X-Originating-IP: [10.43.162.39]
X-ClientProxiedBy: EX13D36UWA004.ant.amazon.com (10.43.160.175) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Cc: Mark Rutland <mark.rutland@arm.com>, benh@amazon.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-doc@vger.kernel.org,
 Jan Kiszka <jan.kiszka@siemens.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, alcioa@amazon.com,
 iommu@lists.linux-foundation.org, aagch@amazon.com, dhr@amazon.com,
 dwmw@amazon.com, Robin Murphy <robin.murphy@arm.com>, aggh@amazon.com
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
From: Alexander Graf via iommu <iommu@lists.linux-foundation.org>
Reply-To: Alexander Graf <graf@amazon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 26.03.20 18:05, Christoph Hellwig wrote:
> 
> On Thu, Mar 26, 2020 at 05:29:22PM +0100, Alexander Graf wrote:
>> The swiotlb is a very convenient fallback mechanism for bounce buffering of
>> DMAable data. It is usually used for the compatibility case where devices
>> can only DMA to a "low region".
>>
>> However, in some scenarios this "low region" may be bound even more
>> heavily. For example, there are embedded system where only an SRAM region
>> is shared between device and CPU. There are also heterogeneous computing
>> scenarios where only a subset of RAM is cache coherent between the
>> components of the system. There are partitioning hypervisors, where
>> a "control VM" that implements device emulation has limited view into a
>> partition's memory for DMA capabilities due to safety concerns.
>>
>> This patch adds a command line driven mechanism to move all DMA memory into
>> a predefined shared memory region which may or may not be part of the
>> physical address layout of the Operating System.
>>
>> Ideally, the typical path to set this configuration would be through Device
>> Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
>> in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
>> instead configure the system purely through kernel command line options.
>>
>> I'm sure other people will find the functionality useful going forward
>> though and extend it to be triggered by DT/ACPI in the future.
> 
> I'm totally against hacking in a kernel parameter for this.  We'll need
> a proper documented DT or ACPI way.  

I'm with you on that sentiment, but in the environment I'm currently 
looking at, we have neither DT nor ACPI: The kernel gets purely 
configured via kernel command line. For other unenumerable artifacts on 
the system, such as virtio-mmio platform devices, that works well enough 
and also basically "hacks a kernel parameter" to specify the system layout.

> We also need to feed this information
> into the actual DMA bounce buffering decisions and not just the swiotlb
> placement.

Care to elaborate a bit here? I was under the impression that 
"swiotlb=force" basically allows you to steer the DMA bounce buffering 
decisions already.


Thanks!

Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
