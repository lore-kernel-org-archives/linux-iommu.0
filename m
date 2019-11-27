Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E1C432C0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 17:09:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487FF206E0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 17:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487FF206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EB43C86462;
	Wed, 27 Nov 2019 17:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rxqgix4hZtzr; Wed, 27 Nov 2019 17:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4994885B7C;
	Wed, 27 Nov 2019 17:09:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B3D1C1DD5;
	Wed, 27 Nov 2019 17:09:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21792C0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 17:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0E58085B8D
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 17:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4uzvA8mnFri3 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 17:09:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id D31DA85B7C
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 17:09:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12FDB30E;
 Wed, 27 Nov 2019 09:09:46 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 019323F6C4;
 Wed, 27 Nov 2019 09:09:44 -0800 (PST)
Subject: Re: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-3-thierry.reding@gmail.com>
 <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com> <20190902145245.GC1445@ulmo>
 <20190917175950.wrwiqnh5bp62uy3c@willie-the-truck>
 <20191126172910.GA2669319@ulmo> <20191127141631.GA280099@ulmo>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <864d5afb-72b4-a3ef-9c93-3a8ad4864c56@arm.com>
Date: Wed, 27 Nov 2019 17:09:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127141631.GA280099@ulmo>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>
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

On 27/11/2019 2:16 pm, Thierry Reding wrote:
[...]
> Nevermind that, I figured out that I was missingthe initialization of
> some of the S2CR variables. I've got something that I think is working
> now, though I don't know yet how to go about cleaning up the initial
> mapping and "recycling" it.
> 
> I'll clean things up a bit, run some more tests and post a new patch
> that can serve as a basis for discussion.

I'm a little puzzled by the smmu->identity domain - disregarding the 
fact that it's not actually used by the given diff ;) - if isolation is 
the reason for not simply using a bypass S2CR for the window between 
reset and the relevant .add_device call where the default domain proper 
comes in[1], then surely exposing the union of memory regions to the 
union of all associated devices isn't all that desirable either.

Either way, I'll give you the pre-emptive warning that this is the SMMU 
in the way of my EFI framebuffer ;)

...
arm-smmu 7fb20000.iommu: 	1 context banks (1 stage-2 only)
...

Robin.

[1] the fact that it currently depends on probe order whether getting 
that .add_device call requires a driver probing for the device is an 
error as discussed elsewhere, and will get fixed separately, I promise.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
