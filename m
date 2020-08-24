Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F8C433DF
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:31:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0719120639
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tyAhmC5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0719120639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B50DD20BF8;
	Mon, 24 Aug 2020 18:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lM+lCgdFuoke; Mon, 24 Aug 2020 18:31:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8B4BA1FE32;
	Mon, 24 Aug 2020 18:31:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A3E3C016F;
	Mon, 24 Aug 2020 18:31:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0118AC0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DE262875A1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Htz0bjbm1ioQ for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 18:31:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7E34587594
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=eeb/lofeYf1TCWyrHZnrHrCwUORKtAAL/E3G5LqeoV8=; b=tyAhmC5NK1NmIxVurpWk0ICF7W
 0GOZihikQ5cGdlRZt9BfRQqngR5HtVAH3DQcGdXkOU+6cUocfIBerC91iW1CFEphd349WGoxVOq1p
 xKcoMVE9AA10kmv+1W+pxwTt7CDcZL/NGU17dUdS/b/KDvrAgH1xJKYmq8yWB3ak2y0QxiBr2GzB8
 G7eGKwOz3CPbCHCbKdZ+U+kFu9yxctqMNghSrfsOuKS2mjUGdDb8vhCsUEGr78vb08PmKHbwqmVeS
 RuQZzr3Lb7NmvjANm3CJOk4KvNuf2aRFkz2kmtT5ZFIQ3X2+C3MZqfWYTq9GSzHnF9el1bnHZoasu
 YjYeyNtg==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAHFF-0000zM-N6; Mon, 24 Aug 2020 18:31:02 +0000
Subject: Re: [PATCH v2 3/9] iommu/ioasid: Introduce ioasid_set APIs
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jacob Pan <jacob.pan.linux@gmail.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200824182848.GB3210689@myrica>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6bc666c-d327-998b-b740-d03b9f0f5ffc@infradead.org>
Date: Mon, 24 Aug 2020 11:30:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824182848.GB3210689@myrica>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Wu Hao <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On 8/24/20 11:28 AM, Jean-Philippe Brucker wrote:
>> +/**
>> + * struct ioasid_data - Meta data about ioasid
>> + *
>> + * @id:		Unique ID
>> + * @users	Number of active users
>> + * @state	Track state of the IOASID
>> + * @set		Meta data of the set this IOASID belongs to
>> + * @private	Private data associated with the IOASID
>> + * @rcu		For free after RCU grace period
> nit: it would be nicer to follow the struct order

and use a ':' after each struct member name, as is done for @id:

-- 
~Randy

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
