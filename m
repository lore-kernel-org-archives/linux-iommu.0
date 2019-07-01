Return-Path: <SRS0=o8L7=U6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4AAC0650E
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 17:42:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B8021721
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 17:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B8021721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 39CC84B23;
	Mon,  1 Jul 2019 17:42:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 90B6A4B21
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 17:42:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 3C436782
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 17:42:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A200228;
	Mon,  1 Jul 2019 10:41:59 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155A33F703;
	Mon,  1 Jul 2019 10:41:57 -0700 (PDT)
Subject: Re: [PATCH v3 8/9] iommu/arm-smmu-v3: Add support for PCI ATS
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	will.deacon@arm.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
	<20190417182448.12382-9-jean-philippe.brucker@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7fcd5263-8a20-11cb-0c20-9fee35fe65c1@arm.com>
Date: Mon, 1 Jul 2019 18:41:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417182448.12382-9-jean-philippe.brucker@arm.com>
Content-Language: en-GB
Cc: zhongmiao@hisilicon.com, okaya@kernel.org, sudeep.holla@arm.com,
	rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Jean-Philippe,

I realise it's a bit late for a "review", but digging up the original 
patch seemed as good a place as any to raise this...

On 17/04/2019 19:24, Jean-Philippe Brucker wrote:
[...]
> @@ -1740,6 +1906,9 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>   
>   	master->domain = NULL;
>   	arm_smmu_install_ste_for_dev(master);
> +
> +	/* Disabling ATS invalidates all ATC entries */
> +	arm_smmu_disable_ats(master);
>   }

Is that actually true? I had initially overlooked this entirely while 
diagnosing something else and thought that we were missing any ATC 
invalidation on detach at all, but even having looked again I'm not 
entirely convinced it's bulletproof.

Firstly, the ATS spec only seems to say that *enabling* the ATS 
capability invalidates all ATC entries, although I think any corner 
cases that that alone opens up should be at best theoretical. More 
importantly though, pci_disable_ats() might not actually touch the 
capability - given that, it seems possible to move a VF to a new domain, 
and if it's not reset, end up preserving now-bogus ATC entries despite 
the old domain being torn down and freed. Do we need an explicit ATC 
invalidation here to be 100% safe, or is there something else I'm missing?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
