Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98221C433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 17:11:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A4A61397
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 17:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A4A61397
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15EFB4059C;
	Thu,  1 Apr 2021 17:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PghqCSUcze21; Thu,  1 Apr 2021 17:11:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0261F40015;
	Thu,  1 Apr 2021 17:11:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE9BDC000B;
	Thu,  1 Apr 2021 17:11:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D1A9C000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 17:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED45341866
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 17:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id te-2_KRqPfKT for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 17:11:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AD5241851
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 17:11:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39E5161398;
 Thu,  1 Apr 2021 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617297067;
 bh=PIT2jhNPPa9PR29r77Bt26sck2KltF1OUjlMOqD2BAw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WWQ9pVjULcj6wFn4SulQ8mjPjS0KQqpninOcoNTDiJT/MKxV4sXYbZ/4r4JRZIzVN
 UY6rpatTGL7J9Yt9aRVsYpXRHrePcl+HFzlbc0sju7FjMsCgPTirCXKqtBzDxwUuHa
 /ZGL017tvGMyxVh7H0JDMS2WoEbI0X5CNNPzB5YTZu2L5RvuS0qDCxErArsUCojRvZ
 fdJN5chmZLO+kGt1FAqQdIdqJLWyl5Hq7XorKUw/JZ+tRIDeNh75WhFL3dzV5Y1IgW
 mZ1x7ByZLf1em040i9Qe9RPG1JUD7jb03Iou8LO0JJAOeL5mByUXGtWFCBJ7rcB5LV
 Y4CxN2JKHR2Ew==
Date: Thu, 1 Apr 2021 18:11:02 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v14 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20210401171101.GB9447@willie-the-truck>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
 <20210401154718.307519-11-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210401154718.307519-11-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-acpi@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 vivek.gautam@arm.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Thu, Apr 01, 2021 at 05:47:19PM +0200, Jean-Philippe Brucker wrote:
> The SMMU provides a Stall model for handling page faults in platform
> devices. It is similar to PCIe PRI, but doesn't require devices to have
> their own translation cache. Instead, faulting transactions are parked
> and the OS is given a chance to fix the page tables and retry the
> transaction.
> 
> Enable stall for devices that support it (opt-in by firmware). When an
> event corresponds to a translation error, call the IOMMU fault handler.
> If the fault is recoverable, it will call us back to terminate or
> continue the stall.

Which hardware is this useful for? Stalling adds a fair amount of complexity
to the driver, so I don't think we should support it unless we're likely to
see platforms that both implement it and do something useful with it.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
