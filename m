Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C9C2B9F4
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 02:48:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8563F610CD
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 02:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8563F610CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D1E940003;
	Fri, 18 Jun 2021 02:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IMaTbUtJlO6p; Fri, 18 Jun 2021 02:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 348DD401C3;
	Fri, 18 Jun 2021 02:48:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08225C000D;
	Fri, 18 Jun 2021 02:48:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C6DAC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 02:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id 806356074A
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 02:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id OWrpDCfo5kMl for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 02:47:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id F114E606C7
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 02:47:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1623984477; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=YkbRytX69iUvG0ZM+UxVcMo8JSuDp5vDTNk35atHQbA=;
 b=bnJZuuBP+C8eTl8r4QHQ0TW7xWh3IR0oyoziiuZSLCQ8sbZ9IECtvcB8Y+b0FuLUSo9Gdfnt
 4Ta2r8Fe97M1KeoD2m0/PSjmE2H0fpihSw+165IDJHEADY9D7GKvPysM0SRmzO+mAX5N2nRg
 +yOZiBSmuVDd0NxGMk+GsM+hCyU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60cc0949ed59bf69ccb06abc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 02:47:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E0F41C43217; Fri, 18 Jun 2021 02:47:36 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B35DC433F1;
 Fri, 18 Jun 2021 02:47:36 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 18 Jun 2021 08:17:36 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
In-Reply-To: <BY5PR12MB37641A153EAAC556C85A411FB30E9@BY5PR12MB3764.namprd12.prod.outlook.com>
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
 <8535b6c757a5584b495f135f4377053c@codeaurora.org>
 <d9226f4349c445c6ca63dc632b29e3e0@codeaurora.org>
 <BY5PR12MB37641A153EAAC556C85A411FB30E9@BY5PR12MB3764.namprd12.prod.outlook.com>
Message-ID: <32cb0645ce80db062291734464c7ef07@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi Krishna,

On 2021-06-18 02:48, Krishna Reddy wrote:
>> Instead of flush_ops in init_context hook, perhaps a io_pgtable quirk 
>> since this is
>> related to tlb, probably a bad name but IO_PGTABLE_QUIRK_TLB_INV which 
>> will
>> be set in init_context impl hook and the prev condition in
>> io_pgtable_tlb_flush_walk()
>> becomes something like below. Seems very minimal and neat instead of 
>> poking
>> into tlb_flush_walk functions or touching dma strict with some flag?
>> 
>> if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT ||
>>      iop->cfg.quirks & IO_PGTABLE_QUIRK_TLB_INV) {
>>          iop->cfg.tlb->tlb_flush_all(iop->cookie);
>>          return;
>> }
> 
> Can you name it as IO_PGTABLE_QUIRK_TLB_INV_ASID or
> IO_PGTABLE_QUIRK_TLB_INV_ALL_ASID?
> 

tlb_flush_all() callback implementations can use TLBIALL or TLBIASID. so
having ASID in the quirk name doesn't sound right given this quirk 
should
be generic enough to be usable on other implementations as well.
Instead I will go with IO_PGTABLE_QUIRK_TLB_INV_ALL and will be happy to
change if others have some other preference.

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
