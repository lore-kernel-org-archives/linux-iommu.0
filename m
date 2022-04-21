Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A025AC433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 06:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57AB5404B7;
	Thu, 21 Apr 2022 06:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S8gEwntEBfWF; Thu, 21 Apr 2022 06:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4BAD440241;
	Thu, 21 Apr 2022 06:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F359C002F;
	Thu, 21 Apr 2022 06:46:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C29F8C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 06:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1FA983F4D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 06:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f9fHEktvKXw8 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 06:46:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E17183EFB
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 06:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=qRe7vVjPJnHyP0cePRDkMY8xq1/p2U8RyI0nOsV3x/Y=; b=gXTsIB/cqOFjcI2VVEPlTTOA/z
 JkDaeAbQkTqWCmZQWPF2ud1tjTcCPl9gGvqF1cbbelDgbwib3XeammJKt5j6sFWVIOEU+dzKg7iSN
 yMZ2/K34n1kAt9TEZmdH+AadMMJ8x/SxyO96p7sMhG/8SiHufQvCmfTxVUK4J/O1zxY3hKzvRc5W7
 112L3TTd3hsNoKEUhHo1/RudxRQNIg4jeruHz1cfxbA15O8FvZN+JbMufRnYg++ECHv/w3OLD29nn
 xSimUZI8scvoZRvioaHzZXORXk3dRwdPdKYeX/5c0WPMTsPIG6w9kdEk2EQZqurSseYK4MsCdwIju
 cVmW2Y8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nhQa8-00Bpjs-FO; Thu, 21 Apr 2022 06:46:24 +0000
Date: Wed, 20 Apr 2022 23:46:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v10 1/9] iommu: Introduce a union to struct
 iommu_resv_region
Message-ID: <YmD9wBhR8/j8HOaX@infradead.org>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <20220420164836.1181-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220420164836.1181-2-shameerali.kolothum.thodi@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: will@kernel.org, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, wanghuiqiang@huawei.com,
 guohanjun@huawei.com, Sami.Mujawar@arm.com, robin.murphy@arm.com,
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

On Wed, Apr 20, 2022 at 05:48:28PM +0100, Shameer Kolothum wrote:
> @@ -141,6 +149,11 @@ struct iommu_resv_region {
>  	size_t			length;
>  	int			prot;
>  	enum iommu_resv_type	type;
> +	union {
> +		struct iommu_iort_rmr_data rmr;
> +	} fw_data;
> +	void (*resv_region_free_fw_data)(struct device *dev,
> +					 struct iommu_resv_region *region);

I'd shorten the name to just free.  Also any reason the call to this
method isn't also added in this patch as it logically belongs here?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
