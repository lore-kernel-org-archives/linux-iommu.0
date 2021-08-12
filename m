Return-Path: <SRS0=jPbF=ND=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7511AC4338F
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 15:13:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B64610EA
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 15:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3B64610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DCE360B83;
	Thu, 12 Aug 2021 15:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iKHnsFSodhWn; Thu, 12 Aug 2021 15:13:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1EDBE60B76;
	Thu, 12 Aug 2021 15:13:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0449CC001A;
	Thu, 12 Aug 2021 15:13:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09E69C000E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 15:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06E2960B83
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 15:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQ_Kvm4eS-_1 for <iommu@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 15:13:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11C9E60B76
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:cc:content-disposition;
 bh=p8AIzbt/q5zCv5tnHxNN9eRHP8zhapwGao5kshd1jOA=; b=EdEyTR9gitR1YDlsstSMoaOwJT
 9bxxPonFOt8WqJHdBmqTMO/S1LTNXRwt4bcJL3kJIr0P0i4BTJV9gOkk0d1viXbDYfWFM/qcr1L+f
 gkKmYU2ujDvTiW0VIB/wqPhg361FbXwzSIFCW4jUmn8vKm4V8y/Qlc6+oAUKMlEK9w3Ep22mFz2Fa
 y7UPjkDDIFwDhsShP3i5GUF4RYSw1lXpbG7TfroRfBpdM8FgXCZNoQWEgRThenSJzBfG80+Pfah/F
 JBsGDhQsO2JqeSAJ3ZKc8q6TH41cDmulShv4A29fx+2nToiGmjaYOYGMd27KgmNy9uBZ+CkrJNNfT
 mm1ZckvA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mECOE-0000sx-Q5; Thu, 12 Aug 2021 09:13:07 -0600
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20210812130051.36839-1-hch@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <939a2737-4338-bdb1-3de5-a00b185cb181@deltatee.com>
Date: Thu, 12 Aug 2021 09:13:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812130051.36839-1-hch@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] dma-mapping: return an unsigned int from
 dma_map_sg{,_attrs}
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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




On 2021-08-12 7:00 a.m., Christoph Hellwig wrote:
> These can only return 0 for failure or the number of entries, so turn
> the return value into an unsigned int.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
