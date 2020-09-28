Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2682BC4727C
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:23:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84837239E5
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpgej5UC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84837239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EFB1985B25;
	Mon, 28 Sep 2020 22:23:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p47vCiB0LTOv; Mon, 28 Sep 2020 22:22:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD54185B0C;
	Mon, 28 Sep 2020 22:22:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99F82C0889;
	Mon, 28 Sep 2020 22:22:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2048AC0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 14419868E7
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hUUwdOhotG11 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 22:22:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A116385948
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:22:57 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BB50A23976;
 Mon, 28 Sep 2020 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601331777;
 bh=KckGuHNjpXWgi3JvMZQ0Yewh2mKrNMi6Nq4AclxpP/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vpgej5UCzziq1X9FOdkJKve7/ui1qENMXIsoy6papwhzW+n3Kfh/kBthk9Od085D6
 /01kxZQxRBsJ6g59/7b/rpc5zD6P6J5ZLbNIPoUcWT3PN4h3wCXg0w9MpRtZZ72Idi
 5qkMxo/pxWThi01CSbWNg6KdX02ROJWZnJfIQ5zk=
Date: Mon, 28 Sep 2020 23:22:51 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 01/13] mm: Define pasid in mm
Message-ID: <20200928222250.GA12847@willie-the-truck>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918101852.582559-2-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
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

On Fri, Sep 18, 2020 at 12:18:41PM +0200, Jean-Philippe Brucker wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> PASID is shared by all threads in a process. So the logical place to keep
> track of it is in the "mm". Both ARM and X86 need to use the PASID in the
> "mm".
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> https://lore.kernel.org/linux-iommu/1600187413-163670-8-git-send-email-fenghua.yu@intel.com/
> ---
>  include/linux/mm_types.h | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
