Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C70C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 09:45:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E77420663
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 09:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="d13uXAGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E77420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D853F87E17;
	Tue, 10 Dec 2019 09:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GjyceX6+u4qT; Tue, 10 Dec 2019 09:45:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B70587D60;
	Tue, 10 Dec 2019 09:45:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC0EC1796;
	Tue, 10 Dec 2019 09:45:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0168C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 09:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D98A585FC1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 09:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4HxtM5YheHul for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 09:40:45 +0000 (UTC)
X-Greylist: delayed 00:12:00 by SQLgrey-1.7.6
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.23])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6CA6F85FA1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575970843;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=C6rRi9vbRDeonnyR24txvDpcl8MM64R9S6m0RF7+eXI=;
 b=d13uXAGTqhIA2aYv3eMeji7XPcA7jZc/KTRcsCR7SIq9VSpNY7EP4fbKZFeli7bwUU
 /W2FtR4F3s61Il2jwmxniqQrwX9+JHErdOYdOd4oADpcOIxGtfKyY8JfzDyo37d8JoFM
 1TXAsFNykjIN8Wymm9XFyWwFvY+e7qVYL14mfWWp8s1kNUCgEUl14nOI3wWqxWovTIf5
 4wAvLisS1s1oM3r3Q+jwe3qCRn3IKUICpJ2RKxSsZ3PYzd1SMPlzPnW50BmtpMSBvNU8
 tMQBHcn6qWfJ8KKDf28CDog73UYD025cBMJi9P179WhfRd3PvoHkGpnMZlvLc3UnvtgJ
 ck+w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJGV8vHxv6O"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net by smtp.strato.de (RZmta 46.0.2 AUTH)
 with ESMTPSA id R01a59vBA9Sddes
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 10 Dec 2019 10:28:39 +0100 (CET)
Date: Tue, 10 Dec 2019 10:28:32 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Use a better type for dma_limit
Message-ID: <20191210092832.GA80115@gerhold.net>
References: <1276b72dec7803b377ede9030027a23aa4861d0c.1575896866.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1276b72dec7803b377ede9030027a23aa4861d0c.1575896866.git.robin.murphy@arm.com>
X-Mailman-Approved-At: Tue, 10 Dec 2019 09:45:01 +0000
Cc: Nathan Chancellor <natechancellor@gmail.com>,
 iommu@lists.linux-foundation.org, nsaenzjulienne@suse.de
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

On Mon, Dec 09, 2019 at 01:08:32PM +0000, Robin Murphy wrote:
> It makes little sense for dma_limit to be a dma_addr_t when we only use
> it to pass u64 arguments, and combine it with another u64 along the way.
> Just make it u64, and head off any possible size mismatches.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 0cc702a70a96..4acc4199a740 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -399,7 +399,7 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
>  }
>  
>  static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
> -		size_t size, dma_addr_t dma_limit, struct device *dev)
> +		size_t size, u64 dma_limit, struct device *dev)
>  {
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = &cookie->iovad;

Just wondering, maybe you should do the same for:

static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
		size_t size, int prot, dma_addr_t dma_mask)

since that passes on the dma_mask as dma_addr_t instead of u64?


Also FYI, this fixes the warning on arm32 reported by Nathan [1],
but introduces another similar warning on the min() macro below:

In file included from ../include/linux/list.h:9,
                 from ../include/linux/kobject.h:19,
                 from ../include/linux/of.h:17,
                 from ../include/linux/irqdomain.h:35,
                 from ../include/linux/acpi.h:13,
                 from ../include/linux/acpi_iort.h:10,
                 from ../drivers/iommu/dma-iommu.c:11:
../drivers/iommu/dma-iommu.c: In function 'iommu_dma_alloc_iova':
../include/linux/kernel.h:844:29: warning: comparison of distinct pointer types lacks a cast
  844 |   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                             ^~
../include/linux/kernel.h:858:4: note: in expansion of macro '__typecheck'
  858 |   (__typecheck(x, y) && __no_side_effects(x, y))
      |    ^~~~~~~~~~~
../include/linux/kernel.h:868:24: note: in expansion of macro '__safe_cmp'
  868 |  __builtin_choose_expr(__safe_cmp(x, y), \
      |                        ^~~~~~~~~~
../include/linux/kernel.h:877:19: note: in expansion of macro '__careful_cmp'
  877 | #define min(x, y) __careful_cmp(x, y, <)
      |                   ^~~~~~~~~~~~~
../drivers/iommu/dma-iommu.c:427:15: note: in expansion of macro 'min'
  427 |   dma_limit = min(dma_limit, domain->geometry.aperture_end);
      |               ^~~

min_t(u64, dma_limit, domain->geometry.aperture_end) seems to fix it,
but not sure if that is correct.

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-iommu/20191123165108.GA15306@ubuntu-x2-xlarge-x86/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
