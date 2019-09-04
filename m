Return-Path: <SRS0=42j6=W7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F20C3A5A7
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 08:15:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A467922CF7
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 08:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A467922CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 87A4F1155;
	Wed,  4 Sep 2019 08:15:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 326961150
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 08:15:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 990B7887
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 08:15:19 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 8A42E445; Wed,  4 Sep 2019 10:15:17 +0200 (CEST)
Date: Wed, 4 Sep 2019 10:15:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH 2/3] iommu/pamu: Use kzfree rather than its implementation
Message-ID: <20190904081517.GA29855@8bytes.org>
References: <1567566079-7412-1-git-send-email-zhongjiang@huawei.com>
	<1567566079-7412-3-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1567566079-7412-3-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: herbert@gondor.apana.org.au, gregkh@linuxfoundation.org, arno@natisbad.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-crypto@vger.kernel.org, davem@davemloft.net
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

On Wed, Sep 04, 2019 at 11:01:18AM +0800, zhong jiang wrote:
> Use kzfree instead of memset() + kfree().
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/iommu/fsl_pamu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index cde281b..ca6d147 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -1174,10 +1174,8 @@ static int fsl_pamu_probe(struct platform_device *pdev)
>  	if (irq != NO_IRQ)
>  		free_irq(irq, data);
>  
> -	if (data) {
> -		memset(data, 0, sizeof(struct pamu_isr_data));
> -		kfree(data);
> -	}
> +	if (data)
> +		kzfree(data);

kzfree() is doing its own NULL-ptr check, no need to do it here.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
