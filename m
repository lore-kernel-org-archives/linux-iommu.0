Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4A0C2BB1D
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 23:31:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135412074F
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 23:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fuWEoD/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135412074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C45F72039D;
	Thu,  9 Apr 2020 23:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f4RIDKt2xJnW; Thu,  9 Apr 2020 23:31:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E35B82036C;
	Thu,  9 Apr 2020 23:31:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7475C1D7E;
	Thu,  9 Apr 2020 23:31:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77E72C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 23:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7032A87969
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 23:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1B7LvYmBDy1x for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 23:31:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C69DF864FB
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 23:31:27 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id d17so234068pgo.0
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZkCPBxxxyjSx1oGDDyt3nqc/uvcZpVvRJITDOMA3zxE=;
 b=fuWEoD/XFcHkrla7dX8M4ijHH1Z+/O/saTKokpSm7SO9G2hVpT7AB3ekqHRvcftqVU
 yX59m7l+c9k2M/J1FKQtnPpz+9HwqkPIS42tskaufVbXLMtZXYFW0apDvgLoQca/ykdF
 eRmD7/0a4g8vckwgsGXGoj6mqkGyP+VmyUVj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZkCPBxxxyjSx1oGDDyt3nqc/uvcZpVvRJITDOMA3zxE=;
 b=kF0yxbk/H0/daeMEI2WiMMk17sopJRdbXzwR+de9/SsUYNEFNXOQao6JHREJST2I+g
 2scRdgE0HRGH1+veSteR6Yqj0Z87MIpq89Tf/p78AticHD8MJe2aSo2b1c3MuB2SRpAj
 o+3vT7/pyWUozjcxCl7SqINRfzIosR+ORxmzUjshE9DFhnHt/tr02lKa0IWCBvtvABc7
 iUWLbKGmCdyJWwdiMRfs/aXUDx1RjdZd9iOoNp8zICcRSza4cjn9NCzuMh/Ekcv+qMWw
 duuT9wNo1TrF07fh6U0NFXCzjbaqlJajsKmk0nhMf1fC8xsPnNAw2hu4N5PJXB5S7Ng0
 2yNw==
X-Gm-Message-State: AGi0PubYE5hfol9oyuJE6SqqbpdbTTwWU8OD2RG9O/KSaDfczzUGNfBq
 n5Sy54iLc9XWcUXUN9tW4j2F8A==
X-Google-Smtp-Source: APiQypLeHsiNvXa0fC/JPIAYREoiHIIj7McMv+L0VkX3HCS8JHN0sjKPyH19uJztvV+NMbXtBVLxZg==
X-Received: by 2002:a63:ee4f:: with SMTP id n15mr1817524pgk.149.1586475087419; 
 Thu, 09 Apr 2020 16:31:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
 by smtp.gmail.com with ESMTPSA id v25sm186190pgl.55.2020.04.09.16.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 16:31:26 -0700 (PDT)
Date: Thu, 9 Apr 2020 16:31:24 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Allow client devices to select
 direct mapping
Message-ID: <20200409233124.GW199755@google.com>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <7761534cdb4f1891d993e73931894a63@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7761534cdb4f1891d993e73931894a63@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-arm-msm@vger.kernel.org,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Feb 04, 2020 at 11:12:17PM +0530, Sai Prakash Ranjan wrote:
> Hello Robin, Will
> 
> On 2020-01-22 17:18, Sai Prakash Ranjan wrote:
> > This series allows drm devices to set a default identity
> > mapping using iommu_request_dm_for_dev(). First patch is
> > a cleanup to support other SoCs to call into QCOM specific
> > implementation and preparation for second patch.
> > Second patch sets the default identity domain for drm devices.
> > 
> > Jordan Crouse (1):
> >   iommu/arm-smmu: Allow client devices to select direct mapping
> > 
> > Sai Prakash Ranjan (1):
> >   iommu: arm-smmu-impl: Convert to a generic reset implementation
> > 
> >  drivers/iommu/arm-smmu-impl.c |  8 +++--
> >  drivers/iommu/arm-smmu-qcom.c | 55 +++++++++++++++++++++++++++++++++--
> >  drivers/iommu/arm-smmu.c      |  3 ++
> >  drivers/iommu/arm-smmu.h      |  5 ++++
> >  4 files changed, 65 insertions(+), 6 deletions(-)
> 
> Any review comments?

Ping

What is the status of this series, is it ready to land or are any changes
needed?

Thanks

Matthias
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
