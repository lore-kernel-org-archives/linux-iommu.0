Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB248C433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 09:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E4BC4093E;
	Fri, 10 Dec 2021 09:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7PmT4Tg1gPuK; Fri, 10 Dec 2021 09:55:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9676F40166;
	Fri, 10 Dec 2021 09:55:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 652ABC002F;
	Fri, 10 Dec 2021 09:55:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07C67C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 09:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4B1361274
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 09:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2AE5Gf7y3sJB for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 09:55:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA66661251
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 09:55:23 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id u17so13999790wrt.3
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=W8FUODtsxIgRcCAdpogX9Uv8kSzYBLqxbGwgE8yOqHc=;
 b=vsDgL5lWIC1QJt5et+dAzzDtq2+Zo5yEeM+zRcvXvRo3M7HX0JPy5k3sDjLCH92VrB
 p/fZTUILZRFLXswagFeY4vjXWhahK9x02mvXkSOMdTqJPBK9DoDSqcfnPaFvy3c0J2NK
 +RXwTJX3YP4FoJye68ShO1/1ok3enMkj5ECAZpr6u8rvv0Gav+Yh5KuktY6M573YSwkE
 8zzUmtvssm64cieIW8UQnrCc8U0hTXI81IvrqEg3DOrRQvSBx0kS8iIeJZ2RBSzQuaMP
 W8uG0dgs0tsMYeLsA5+EENTv2nUEw9JCPjnt2dO5FURbpHcTfH2vVUK34XgpayGnvpWQ
 ixHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W8FUODtsxIgRcCAdpogX9Uv8kSzYBLqxbGwgE8yOqHc=;
 b=qwjnOi9VEfAkdn3CpG2JMD+To3nvo5JQgOPGATOHMWTj6Qxf69xhl++ODmC9nV/rm8
 8YeGjhe2GKUr+mWmWMOBkK9U0IlwWF3LNDd4KBoZGjGrLcvKIdQMUXkz0km585wLf0oi
 RpDtVVbQ/9zOw+Xmte7R7dxb9/AquPqlmbttVtmpgD3FsXlZglhbrPLc5IgL46qiKtdo
 1lTPaiaAi4qtXFp6vHW8H35YfV7qDZzPoziGb9YfiivOORCyE9MCj/qe8ZbYhzPrhNMo
 e00O549IJrnL/d17w7LjyxpUTticdG6KPX5vH6/UrEpuTWTJHZkgJyL0m32xABO2Q9AU
 BGrw==
X-Gm-Message-State: AOAM5306ay7XLpxaPMwq8+KY1AZoRzZQ36gm1lXUxr7nMSgghnM6vB01
 ndF2oLBEH8Kzq7u27mgsLjzpfA==
X-Google-Smtp-Source: ABdhPJzWhxWBlJvAwdV5dPSr/L6/G4eeC8jA44FTGzewKfVfxc1toGCSu36ebCmedWG97D7MdQX/sA==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr12991313wri.438.1639130121899; 
 Fri, 10 Dec 2021 01:55:21 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id v2sm2248183wmc.36.2021.12.10.01.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Dec 2021 01:55:21 -0800 (PST)
Date: Fri, 10 Dec 2021 09:54:59 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops
Message-ID: <YbMj85nqwNCZ4mFg@myrica>
References: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

On Sat, Dec 04, 2021 at 11:33:01PM +0100, Rikard Falkeborn wrote:
> The only usage of arm_smmu_mmu_notifier_ops is to assign its address to
> the ops field in the mmu_notifier struct, which is a pointer to const
> struct mmu_notifier_ops. Make it const to allow the compiler to put it
> in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index ee66d1f4cb81..a737ba5f727e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -220,7 +220,7 @@ static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
>  	kfree(mn_to_smmu(mn));
>  }
>  
> -static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
> +static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
>  	.invalidate_range	= arm_smmu_mm_invalidate_range,
>  	.release		= arm_smmu_mm_release,
>  	.free_notifier		= arm_smmu_mmu_notifier_free,
> -- 
> 2.34.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
