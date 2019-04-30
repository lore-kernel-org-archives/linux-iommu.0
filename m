Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFBDC43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 13:39:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46A221670
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 13:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46A221670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8F373194D;
	Tue, 30 Apr 2019 13:39:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 68C5513D1
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 13:38:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EDD33608
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 13:38:48 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C80F3091783;
	Tue, 30 Apr 2019 13:38:48 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E9BE75290;
	Tue, 30 Apr 2019 13:38:45 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
To: Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
References: <20190429144428.29254-1-julien.grall@arm.com>
	<20190429144428.29254-8-julien.grall@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6bd88d63-2e8a-77fb-f4e5-250e8d0c5eff@redhat.com>
Date: Tue, 30 Apr 2019 15:38:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190429144428.29254-8-julien.grall@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 30 Apr 2019 13:38:48 +0000 (UTC)
Cc: jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
	logang@deltatee.com, bigeasy@linutronix.de,
	miquel.raynal@bootlin.com, tglx@linutronix.de,
	robin.murphy@arm.com, linux-rt-users@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430133844.Fu2McvofwA4Sh_lCEzLeK7mMUnw-ggADzky0X6X1Npc@z>

Hi Julien,

On 4/29/19 4:44 PM, Julien Grall wrote:
> A recent change split iommu_dma_map_msi_msg() in two new functions. The
> function was still implemented to avoid modifying all the callers at
> once.
> 
> Now that all the callers have been reworked, iommu_dma_map_msi_msg() can
> be removed.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> ---
>     Changes in v2:
>         - Rework the commit message
> ---
>  drivers/iommu/dma-iommu.c | 20 --------------------
>  include/linux/dma-iommu.h |  5 -----
>  2 files changed, 25 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2309f59cefa4..12f4464828a4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -936,23 +936,3 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>  	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
>  	msg->address_lo += lower_32_bits(msi_page->iova);
>  }
> -
> -void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> -{
> -	struct msi_desc *desc = irq_get_msi_desc(irq);
> -	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
> -
> -	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
> -		/*
> -		 * We're called from a void callback, so the best we can do is
> -		 * 'fail' by filling the message with obviously bogus values.
> -		 * Since we got this far due to an IOMMU being present, it's
> -		 * not like the existing address would have worked anyway...
> -		 */
> -		msg->address_hi = ~0U;
> -		msg->address_lo = ~0U;
> -		msg->data = ~0U;
> -	} else {
> -		iommu_dma_compose_msi_msg(desc, msg);
> -	}
> -}
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 3fc48fbd6f63..ddd217c197df 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -82,7 +82,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
>  void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>  			       struct msi_msg *msg);
>  
> -void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>  void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>  
>  #else
> @@ -122,10 +121,6 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>  {
>  }
>  
> -static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> -{
> -}
> -
>  static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>  {
>  }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
