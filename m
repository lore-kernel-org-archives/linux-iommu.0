Return-Path: <SRS0=7x6w=CV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66064C433E2
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 02:55:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2F1206E6
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 02:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2F1206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8804A876F4;
	Sat, 12 Sep 2020 02:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WETYk7F73uyq; Sat, 12 Sep 2020 02:55:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D65C2876EE;
	Sat, 12 Sep 2020 02:55:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBC13C0052;
	Sat, 12 Sep 2020 02:55:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90B89C0051
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 02:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7F6BD87533
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 02:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9TFVhNZLGYfu for <iommu@lists.linux-foundation.org>;
 Sat, 12 Sep 2020 02:55:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 14B8987525
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 02:55:32 +0000 (UTC)
IronPort-SDR: 0L8Z9rNlxOXelSbMCFm4laFiGNEYX2VJ1DAf+5eKG7Eq/65/vt95DqUFqgekloHHxKj+gcM28N
 qC+OaJBtsvfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="176945569"
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; d="scan'208";a="176945569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2020 19:55:27 -0700
IronPort-SDR: vmC/Wd5hOLTiV2dszSt254LC3VzenID53RVvXqFy/H+n6u9sy4umjtG4kNvygYn98l+geOki29
 l7U+xqRl/kVA==
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; d="scan'208";a="450185364"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.203])
 ([10.254.212.203])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2020 19:55:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 2/5] iommu: Add iommu_dma_free_cpu_cached_iovas function
To: Christoph Hellwig <hch@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-3-murphyt7@tcd.ie>
 <b30be538-a4dd-987e-78df-ff23b703bbe3@linux.intel.com>
 <20200909070540.GA28245@infradead.org>
Message-ID: <5b146104-34cb-00c5-fecc-0cbc41838682@linux.intel.com>
Date: Sat, 12 Sep 2020 10:55:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909070540.GA28245@infradead.org>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On 2020/9/9 15:05, Christoph Hellwig wrote:
>> +static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
>> +                                                  struct iommu_domain
>> *domain)
> 
> This adds a crazy long line.  Which is rather pointless as other
> bits of code in the patch use the more compact two tab indentations
> for the prototype continuation lines anyway.
>

Okay. I will use two tabs instead.

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
