Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E38C4708F
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:18:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA656613E9
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA656613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 84D4C404E6;
	Thu,  3 Jun 2021 02:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7yDaY-ggZIT0; Thu,  3 Jun 2021 02:18:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D01F404D7;
	Thu,  3 Jun 2021 02:18:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A1F0C000E;
	Thu,  3 Jun 2021 02:18:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F9D3C0001;
 Thu,  3 Jun 2021 02:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FA0540534;
 Thu,  3 Jun 2021 02:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id stAWbpUGzhLA; Thu,  3 Jun 2021 02:18:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FAF240511;
 Thu,  3 Jun 2021 02:18:23 +0000 (UTC)
IronPort-SDR: yCNqL0ffAu3wT/ptaFWYuCNEr4iG2fw9JvyAfyPKNLlqU3FYvJiQyhK6Bh41CS3+C7/rQaHM2Y
 bMCoRn9sj+GQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203975764"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="203975764"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 19:18:22 -0700
IronPort-SDR: aIgogudB/xgPovZkty4cGTTVDDPkaoIn4LK55UWXjGi7xxn4m2KSblfJrn5zToJE+9XWx2Tmjb
 bp5VXHB4Xb5Q==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="550525649"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193])
 ([10.209.87.193])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 19:18:21 -0700
Subject: Re: [PATCH v1 2/8] virtio: Add boundary checks to virtio ring
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-3-ak@linux.intel.com>
 <4be00b3a-a15f-7fee-317b-ddabed3c1347@redhat.com>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <ccf32bdc-a487-040b-5fe6-fcc8e71a57da@linux.intel.com>
Date: Wed, 2 Jun 2021 19:18:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <4be00b3a-a15f-7fee-317b-ddabed3c1347@redhat.com>
Content-Language: en-US
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, robin.murphy@arm.com, hch@lst.de
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


> It looks to me all the evils came from the fact that we depends on the 
> descriptor ring.
>
> So the checks in this patch could is unnecessary if we don't even read 
> from the descriptor ring which could be manipulated by the device.
>
> This is what my series tries to achieve:
>
> https://www.spinics.net/lists/kvm/msg241825.html

I would argue that you should boundary check in any case. It was always 
a bug to not have boundary checks in such a data structure with multiple 
users, trust or not.

But yes your patch series is interesting and definitely makes sense for 
TDX too.

Best would be to have both I guess, and always check the boundaries 
everywhere.

So what's the merge status of your series?

-Andi


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
