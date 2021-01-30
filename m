Return-Path: <SRS0=5nCU=HB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613A7C433DB
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 17:43:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080E464E0A
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 17:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080E464E0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7108F20344;
	Sat, 30 Jan 2021 17:43:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LLkuFTe0op8a; Sat, 30 Jan 2021 17:42:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C403920133;
	Sat, 30 Jan 2021 17:42:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8BDFC08A1;
	Sat, 30 Jan 2021 17:42:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B83EBC013A
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 17:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6F45F2013C
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 17:42:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FQy2pKlJyYlN for <iommu@lists.linux-foundation.org>;
 Sat, 30 Jan 2021 17:42:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by silver.osuosl.org (Postfix) with ESMTPS id 6E47220133
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=3aFRxX0fz2ePxoZOLeQ4qI/y3ZqjEwqLpDY+N2WR944=; b=Enjcl+HnCIQXEPaqA8N62o3me+
 /f9Fw8fcDvM66qqQ39P0x6EAMp4Lh9+7GcM0fRxmjFkgcg7p25JNy9pa6hF2DqvqQkXgpC/t2pRDC
 IC20snTmAKCL+ZUC5wR3knjWB3ksfD5snntOJwcunwu3CJ3773HjhOGR2zcWFR7McrmbI1bEg9LAV
 wiQB3/9BM07e0QsSdcL7JwG95qCIQYev6ugthkZ3qyPK7x8g6dXH7qZxPmQiiwrwL3VJkiENsfSAz
 hcAiF2YAxGTyqP1X2U2LoZaDt+yYKV7AJ2GzFRZ/g3SEH3+7EyDFYXowO19pfoeW63fpbFEfdqIgM
 HW8Cbo/A==;
Received: from [2601:1c0:6280:3f0::7650]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5uGm-00077M-Tf; Sat, 30 Jan 2021 17:42:49 +0000
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix compile error
 [-Werror=implicit-function-declaration]
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20210130151907.3929148-1-baolu.lu@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <84803c36-c29c-09a2-8731-af85ffdf26aa@infradead.org>
Date: Sat, 30 Jan 2021 09:42:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210130151907.3929148-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
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

On 1/30/21 7:19 AM, Lu Baolu wrote:
> trace_qi_submit() could be used when interrupt remapping is supported,
> but DMA remapping is not. In this case, the following compile error
> occurs.
> 
> ../drivers/iommu/intel/dmar.c: In function 'qi_submit_sync':
> ../drivers/iommu/intel/dmar.c:1311:3: error: implicit declaration of function 'trace_qi_submit';
>   did you mean 'ftrace_nmi_exit'? [-Werror=implicit-function-declaration]
>    trace_qi_submit(iommu, desc[i].qw0, desc[i].qw1,
>    ^~~~~~~~~~~~~~~
>    ftrace_nmi_exit
> 
> Fixes: f2dd871799ba5 ("iommu/vt-d: Add qi_submit trace event")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/Makefile       | 2 +-
>  drivers/iommu/intel/iommu.c        | 1 -
>  include/trace/events/intel_iommu.h | 2 --
>  3 files changed, 1 insertion(+), 4 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

-- 
~Randy

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
