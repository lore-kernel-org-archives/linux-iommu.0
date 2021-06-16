Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A88C48BE8
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 06:58:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A9E613B9
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 06:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A9E613B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCCD140305;
	Wed, 16 Jun 2021 06:58:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nMKM_ZGPvhsR; Wed, 16 Jun 2021 06:58:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7E7D740628;
	Wed, 16 Jun 2021 06:58:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35BD3C000E;
	Wed, 16 Jun 2021 06:58:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C89C4C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 06:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id BC8EC6066F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 06:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id l5eaEUmkx4r1 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 06:58:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id D89F660624
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 06:58:06 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1623826686; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=I0eydOR0xnXCnwZc0aveamd5PTl1UHcBko2iiIqk/Yg=;
 b=vB0rF0Q9G2mGW1YPGE16C88Dq+8F2kAT6CJUCQML8ED5jDk+ikaMVj6JOkHXKiQ1xXv8w6xs
 0Ma4426h9PW4t/6oItFHp5blETjgPM8i9sUNdmHFYEvnh5hb+Jq4nCMU95/MnLamTqfnRCBo
 e5TV/89kT6ModUr11Fe3UwAZzaY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60c9a0fdabfd22a3dc981bdc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Jun 2021 06:58:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 7231AC43460; Wed, 16 Jun 2021 06:58:04 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B795BC4338A;
 Wed, 16 Jun 2021 06:58:03 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 16 Jun 2021 12:28:03 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
In-Reply-To: <da62ff1c-9b49-34d3-69a1-1a674e4a30f7@arm.com>
References: <20210609145315.25750-1-saiprakash.ranjan@codeaurora.org>
 <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
 <c600e9b2534d54082a5272b508a7985f@codeaurora.org>
 <35bfd245-45e2-8083-b620-330d6dbd7bd7@arm.com>
 <12067ffb8243b220cf03e83aaac3e823@codeaurora.org>
 <266f190e-99ae-9175-cf13-7a77730af389@arm.com>
 <dfdabcdec99a4c6e3bf2b3c5eebe067f@codeaurora.org>
 <61c69d23-324a-85d7-2458-dfff8df9280b@arm.com>
 <BY5PR12MB37646698F37C00381EFF7C77B3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <07001b4ed6c0a491eacce6e4dc13ab5e@codeaurora.org>
 <BY5PR12MB376480219C42E5FCE0FE0FFBB3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <f749ba0957b516ab5f0ea57033d308c7@codeaurora.org>
 <BY5PR12MB376433B3FD0A59EF57C4522DB3319@BY5PR12MB3764.namprd12.prod.outlook.com>
 <5eb5146ab51a8fe0b558680d479a26cd@codeaurora.org>
 <da62ff1c-9b49-34d3-69a1-1a674e4a30f7@arm.com>
Message-ID: <8535b6c757a5584b495f135f4377053c@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thierry Reding <treding@nvidia.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Hi Robin,

On 2021-06-15 19:23, Robin Murphy wrote:
> On 2021-06-15 12:51, Sai Prakash Ranjan wrote:

<snip>...

>> Hi @Robin, from these discussions it seems they are not ok with the 
>> change
>> for all SoC vendor implementations and do not have any data on such 
>> impact.
>> As I mentioned above, on QCOM platforms we do have several 
>> optimizations in HW
>> for TLBIs and would like to make use of it and reduce the unmap 
>> latency.
>> What do you think, should this be made implementation specific?
> 
> Yes, it sounds like there's enough uncertainty for now that this needs
> to be an opt-in feature. However, I still think that non-strict mode
> could use it generically, since that's all about over-invalidating to
> save time on individual unmaps - and relatively non-deterministic -
> already.
> 
> So maybe we have a second set of iommu_flush_ops, or just a flag
> somewhere to control the tlb_flush_walk functions internally, and the
> choice can be made in the iommu_get_dma_strict() test, but also forced
> on all the time by your init_context hook. What do you reckon?
> 

Sounds good to me. Since you mentioned non-strict mode using it 
generically,
can't we just set tlb_flush_all() in io_pgtable_tlb_flush_walk() like 
below
based on quirk so that we don't need to add any check in 
iommu_get_dma_strict()
and just force the new flush_ops in init_context hook?

if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
         iop->cfg.tlb->tlb_flush_all(iop->cookie);
         return;
}

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
