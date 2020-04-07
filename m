Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954BEC2BA80
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 00:09:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652D82076E
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 00:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652D82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 44AF28362E;
	Tue,  7 Apr 2020 00:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZRR4nbmozNrx; Tue,  7 Apr 2020 00:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D5AA083791;
	Tue,  7 Apr 2020 00:09:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0664C089E;
	Tue,  7 Apr 2020 00:09:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA181C0177
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 00:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B79EC817F4
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 00:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RnCVgHTCSlWo for <iommu@lists.linux-foundation.org>;
 Tue,  7 Apr 2020 00:09:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 158E0811FC
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 00:09:30 +0000 (UTC)
IronPort-SDR: t0KX9NVgRHv3RmmdBVyIQSsn2sdO188sjdlBXe9a9VeWgyb1ssBU6n9d5swvk4Kz6kxnLxojDU
 uzg6eOeXIX2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2020 17:09:29 -0700
IronPort-SDR: z8w+OadJU/nLC10CX42cASVpRzi+OLlarUHYJmo0AwDYGGfYDRvI82pQsT+RT2jUM8lZllz3fH
 UCGmGkoldWnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,352,1580803200"; d="scan'208";a="269245087"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.83])
 ([10.254.212.83])
 by orsmga002.jf.intel.com with ESMTP; 06 Apr 2020 17:09:27 -0700
Subject: Re: [PATCH 00/19] [PULL REQUEST] iommu/vt-d: patches for v5.7
To: Christoph Hellwig <hch@infradead.org>
References: <20200405083053.17865-1-baolu.lu@linux.intel.com>
 <20200406133625.GA13318@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <12d8a953-607b-34e3-2607-bbe043dbd573@linux.intel.com>
Date: Tue, 7 Apr 2020 08:09:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406133625.GA13318@infradead.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

On 2020/4/6 21:36, Christoph Hellwig wrote:
> On Sun, Apr 05, 2020 at 04:30:34PM +0800, Lu Baolu wrote:
>> Hi Joerg,
>>
>> Below patches have been piled up for v5.7. They enable below
>> features:
> 
> Err, this is not the time for 5.7 features that haven't been in
> linux-next before 5.6 was released.
> 

Really, my bad. I will resend the request after 5.7-rc1 and target them
to 5.8. Thanks for reminding.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
