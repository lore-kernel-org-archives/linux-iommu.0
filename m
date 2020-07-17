Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A0FC433E0
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 09:21:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9F820691
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 09:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="JXocbVQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9F820691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D626D2046C;
	Fri, 17 Jul 2020 09:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bNyYKKc3PWXv; Fri, 17 Jul 2020 09:21:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2FB3C20446;
	Fri, 17 Jul 2020 09:21:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 153E4C07FF;
	Fri, 17 Jul 2020 09:21:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D09FDC0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 09:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BA8A020446
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 09:21:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kwFTkJdN0zx9 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 09:21:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.190.10])
 by silver.osuosl.org (Postfix) with ESMTPS id E40FA20460
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 09:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1594977665; x=1626513665;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=hmoDJXrP/pZojT4LtXb2RKQMBes3JAopMeTUJtQhqbA=;
 b=JXocbVQTBUnGsfbHd1jaEuyAErTeZAYSU2yx1vlJnvYOzppreByqf4Mf
 gWdGug/3/L9cN+N49BrBlav6PPVIHKHN80OIChBqo4TuSAMVuUBsOl/gq
 H35o2uFgbIQfUApGaR3x6+HhYr2oF5UT3UmlTaA6XdpkWoCjVzQ7OsC+r g=;
IronPort-SDR: SPhSNqfEnLyF0z+FKU4UU3IKBx0JQ5UJY3lJGAuLBP+1qpK8rd37QX1ryz2AE0JqmIPRvj6A+5
 bgFMEfeIP5RA==
X-IronPort-AV: E=Sophos;i="5.75,362,1589241600"; d="scan'208";a="59303964"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 17 Jul 2020 09:21:02 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS
 id 614C7A266A; Fri, 17 Jul 2020 09:21:01 +0000 (UTC)
Received: from EX13D29UWC004.ant.amazon.com (10.43.162.25) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 09:21:00 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D29UWC004.ant.amazon.com (10.43.162.25) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Jul 2020 09:21:00 +0000
Received: from uc7682112f22859.ant.amazon.com (10.1.213.26) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 17 Jul 2020 09:20:58 +0000
Subject: Re: [PATCH v2 0/3] iommu/amd: I/O VA address limits
To: Joerg Roedel <joro@8bytes.org>
References: <20200630093039.GC28824@8bytes.org>
 <20200630224634.319-1-sebott@amazon.de> <20200710123059.GF27672@8bytes.org>
Message-ID: <751e403f-7095-f761-465b-9e187b423b0b@amazon.de>
Date: Fri, 17 Jul 2020 11:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710123059.GF27672@8bytes.org>
Content-Language: en-US
Cc: Benjamin Serebrin <serebrin@amazon.com>, Filippo Sironi <sironi@amazon.de>,
 iommu@lists.linux-foundation.org
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
From: Sebastian Ott via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sebastian Ott <sebott@amazon.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hello Joerg,

On 2020-07-10 14:31, Joerg Roedel wrote:
> On Wed, Jul 01, 2020 at 12:46:31AM +0200, Sebastian Ott wrote:
>> The IVRS ACPI table specifies maximum address sizes for I/O virtual
>> addresses that can be handled by the IOMMUs in the system. Parse that
>> data from the IVRS header to provide aperture information for DMA
>> mappings and users of the iommu API.
>>
>> Changes for V2:
>>   - use limits in iommu_setup_dma_ops()
>>   - rebased to current upstream
>>
>> Sebastian Ott (3):
>>    iommu/amd: Parse supported address sizes from IVRS
>>    iommu/amd: Restrict aperture for domains to conform with IVRS
>>    iommu/amd: Actually enforce geometry aperture
> Thanks for the changes. May I ask what the reason for those changes are?
> AFAIK all AMD IOMMU implementations (in hardware) support full 64bit
> address spaces, and the IVRS table might actually be wrong, limiting the
> address space in the worst case to only 32 bit.

It's not the IOMMU, but we've encountered devices that are capable of 
more than
32- but less than 64- bit IOVA, and there's no way to express that to 
the IOVA
allocator in the PCIe spec. Our solution was to have our platforms 
express an
IVRS entry that says the IOMMU is capable of 48-bit, which these devices 
can generate.
48 bits is plenty of address space in this generation for the 
application we have.

Sebastian




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
