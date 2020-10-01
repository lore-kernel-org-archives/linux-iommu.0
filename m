Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0488BC4727F
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 21:17:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7637320708
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 21:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="II+kAhiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7637320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 28A95872E7;
	Thu,  1 Oct 2020 21:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EYu8ntl+RcEa; Thu,  1 Oct 2020 21:17:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5EEE9871CF;
	Thu,  1 Oct 2020 21:17:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51523C016F;
	Thu,  1 Oct 2020 21:17:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D9B6C0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 21:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 843EF871E3
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 21:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ZdpRMuX7Ab8 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 21:17:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3E657871CF
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 21:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hefvlh0ArBsIJRrdxVb8ZMvmEzM/8dfDueDLa3SqvBE=; b=II+kAhiqMFp53BkZhEKEIAZOGX
 Hf5R/UxJcuMpM1xKOtQiVLnXgHKpY3ATzLuzklegYpm8Lzd1IU8qbxICyHmjkg0Qz2qpCS1bBEP8S
 HH28gugNZV5UTgyncQIejXImuXayo+8VmT10XfdhXQI5u8R5f9WbfEl5R5I0IT8rf6srCIXu4FuU4
 LkJGSFOsfVVrzpphiDb6nyv0gbGpMmiFMBmRQXZ8/pSNuY7NINGyaZXcwsZgqVEvlUOKzVawggh7A
 tut4634lIqWIr54WPvoIxDjlbPT9ChDuA/3NfJEUjDRYWNClm+jYg8mM1rvruUCkLWbKSnLBSv76k
 bKlc7H2w==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kO5wx-0005DJ-Nq; Thu, 01 Oct 2020 15:17:20 -0600
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b620cd26-91cc-b564-dbb7-9c7381263f46@deltatee.com>
Date: Thu, 1 Oct 2020 15:17:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200927063437.13988-1-baolu.lu@linux.intel.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Intel-gfx@lists.freedesktop.org,
 ashok.raj@intel.com, tvrtko.ursulin@linux.intel.com, hch@infradead.org,
 dwmw2@infradead.org, murphyt7@tcd.ie, joro@8bytes.org,
 baolu.lu@linux.intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu api
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Lu,

On 2020-09-27 12:34 a.m., Lu Baolu wrote:
> Hi,
> 
> The previous post of this series could be found here.
> 
> https://lore.kernel.org/linux-iommu/20200912032200.11489-1-baolu.lu@linux.intel.com/
> 
> This version introduce a new patch [4/7] to fix an issue reported here.
> 
> https://lore.kernel.org/linux-iommu/51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com/
> 
> There aren't any other changes.
> 
> Please help to test and review.

I've tested this patchset on my Sandy Bridge machine and found no issues (while including a 
patch to ioat I've sent to that maintainer).

Tested-By: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
