Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4162DC43331
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 12:31:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8A22078A
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 12:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8A22078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A5B01237C8;
	Wed, 25 Mar 2020 12:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJrn8-skBkks; Wed, 25 Mar 2020 12:31:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D826B22854;
	Wed, 25 Mar 2020 12:31:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B46DBC1D74;
	Wed, 25 Mar 2020 12:31:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB6D2C0177
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 12:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B0CE387FEA
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 12:31:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zfm768ilzd+v for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 12:31:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id A74C087FE8
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 12:31:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4A3D31B;
 Wed, 25 Mar 2020 05:31:49 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8983F71F;
 Wed, 25 Mar 2020 05:31:47 -0700 (PDT)
Subject: Re: [PATCH v3 10/15] iommu/arm-smmu: Use accessor functions for iommu
 private data
To: Joerg Roedel <joro@8bytes.org>
References: <20200320091414.3941-1-joro@8bytes.org>
 <20200320091414.3941-11-joro@8bytes.org>
 <09ed4676-449e-c6eb-8c51-c15b326c206c@arm.com>
 <20200324100819.GA4038@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d69dad81-d025-96ef-863c-553b5ed2dd8e@arm.com>
Date: Wed, 25 Mar 2020 12:31:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324100819.GA4038@8bytes.org>
Content-Language: en-GB
Cc: Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Andy Gross <agross@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Paul <sean@poorly.run>
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

On 2020-03-24 10:08 am, Joerg Roedel wrote:
> Hey Robin,
> 
> On Mon, Mar 23, 2020 at 04:02:33PM +0000, Robin Murphy wrote:
>> Yikes, this ends up pretty ugly, and I'd prefer not have this much
>> complexity hidden in macros that were intended just to be convenient
>> shorthand. Would you mind pulling in the patch below as a precursor?
> 
> Sure thing, but your mail-client seemed to have fiddled with the patch
> so that is is unusable to me. I tried to fix it up, but it still doesn't
> apply. Can you please re-send it to me either via git-send-email or just
> as a mime-attachement?

Oops, sorry - as you might imagine I'm not in my normal workflow :)

Let me rebase that onto something actually in your tree (rather than 
whatever detached HEAD this is checked out out on my laptop...) and try 
resending it properly.

>> Other than that, the rest of the series looks OK at a glance. We should also
>> move fwspec->ops to dev_iommu, as those are "IOMMU API" data rather than
>> "firmware" data, but let's consider that separately as this series is
>> already long enough.
> 
> Yes, moving ops out of fwspec is next on the list, and moving the
> iommu_group pointer into dev_iommu.

Cool, let me know if you need a hand with all the *_iommu_configure() 
stuff - I still have plans for overhauling that lot anyway, but not 
imminently, so it probably is worthwhile to do the straightforward 
housekeeping first.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
