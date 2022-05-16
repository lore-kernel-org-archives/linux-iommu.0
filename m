Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D90AC433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 23:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 140D583122;
	Mon, 16 May 2022 23:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTObOQsy9pj1; Mon, 16 May 2022 23:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF2CC830E6;
	Mon, 16 May 2022 23:04:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2940C0039;
	Mon, 16 May 2022 23:04:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD9D7C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 23:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B336C4049C
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 23:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kaVWfWVI_pEO for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 23:04:34 +0000 (UTC)
X-Greylist: delayed 00:29:01 by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0DBA40131
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=NpPlI000Df83tLILxBmUWAGtNMcZvLgAm6/3k71RE7c=; b=nbbvOq1l/AOdW8AAdrmqYaX3SU
 +BKP4b1ioPIDOKq5mxiC8mxgQx+PJa8pqsNHrgF9heI1XStQtL1VX0tf8YSfIeC5w751r6d+sGV4m
 YCJFqNXQKwgefLzj15o31jE+GfMK9z76fYxadtGnYb6i1FY8ViSnTzZpTyFZpPgGCEuUhOxKi5nQK
 WJT6Mvc2WszLg5OliMAGH7cR5pd8ttOWl3E9TEyQMAcmT2ojXYYVSMGZ9dYV0NQR93BLhEDhzYmBC
 M1DHMP1xM4/0qw7GLD84zbXyXZ3nZo4nwnI3t7/sGUsGgETlEkwd5jum/jgKn5WGfRo2VcUk4VTcz
 z7jevUug==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1nqjJC-0009d5-0n; Mon, 16 May 2022 16:35:22 -0600
Message-ID: <06e36931-33bf-7c3a-9b7f-afdd9686ccc5@deltatee.com>
Date: Mon, 16 May 2022 16:35:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-CA
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20220407154717.7695-1-logang@deltatee.com>
 <32d5901d-f7d3-0701-0b72-1493897b025e@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <32d5901d-f7d3-0701-0b72-1493897b025e@nvidia.com>
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: chaitanyak@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 iommu@lists.linux-foundation.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 00/21] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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



On 2022-05-16 16:31, Chaitanya Kulkarni wrote:
> Do you have any plans to re-spin this ?

I didn't get any feedback this cycle, so there haven't been any changes.
I'll probably do a rebase and resend after the merge window.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
