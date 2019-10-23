Return-Path: <SRS0=/ROq=YQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA80CA9EB6
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 16:55:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF3221925
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 16:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6EnkV+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF3221925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 392C2B62;
	Wed, 23 Oct 2019 16:55:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9A6D8B43
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 16:55:50 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3ACFD8A9
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 16:55:50 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 255AC21906;
	Wed, 23 Oct 2019 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571849750;
	bh=VPyPC4LePKk7uWBltRmK/Fded+OjFkz/1MBUzjK69yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6EnkV+NncnzhwMOW6V6hkw45lZgsqg3/2TZtCGHZozEzQIq3KdMfSDzhP1HG7DEk
	M7mlDDT1+IBGeBeN7wjqNdxT1gyRg8gcrMld2vzIAOeKMgU6M5qaR4w4RXQRM3f8MR
	nDVUOk8sxVo9dbcnWMOHzMooezkVxez8zgQU2eWs=
Date: Wed, 23 Oct 2019 17:55:44 +0100
From: Will Deacon <will@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 3/7] iommu/mediatek: Use gather to achieve the tlb
	range flush
Message-ID: <20191023165543.GB27471@willie-the-truck>
References: <1571196792-12382-1-git-send-email-yong.wu@mediatek.com>
	<1571196792-12382-4-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1571196792-12382-4-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	edison.hsieh@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Oct 16, 2019 at 11:33:08AM +0800, Yong Wu wrote:
> Use the iommu_gather mechanism to achieve the tlb range flush.
> Gather the iova range in the "tlb_add_page", then flush the merged iova
> range in iotlb_sync.
> 
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c2f6c78..81ac95f 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -245,11 +245,9 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>  					    void *cookie)
>  {
>  	struct mtk_iommu_data *data = cookie;
> -	unsigned long flags;
> +	struct iommu_domain *domain = &data->m4u_dom->domain;
>  
> -	spin_lock_irqsave(&data->tlb_lock, flags);
> -	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
> -	spin_unlock_irqrestore(&data->tlb_lock, flags);
> +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);

You need to be careful here, because iommu_iotlb_gather_add_page() can
call iommu_tlb_sync() in some situations and you don't hold the lock.

>  static const struct iommu_flush_ops mtk_iommu_flush_ops = {
> @@ -469,9 +467,15 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>  				 struct iommu_iotlb_gather *gather)
>  {
>  	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
> +	size_t length = gather->end - gather->start;
>  	unsigned long flags;
>  
> +	if (gather->start == ULONG_MAX)
> +		return;
> +
>  	spin_lock_irqsave(&data->tlb_lock, flags);
> +	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
> +				       false, data);
>  	mtk_iommu_tlb_sync(data);
>  	spin_unlock_irqrestore(&data->tlb_lock, flags);

Modulo my comment above, this fixes my previous comment. Given that mainline
is already broken, I guess the runtime bisectability isn't a problem.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
