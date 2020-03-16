Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6883CC0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:50:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321D82051A
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWi+mz5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321D82051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EAD3220529;
	Mon, 16 Mar 2020 15:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id orBp5jhHmSKD; Mon, 16 Mar 2020 15:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CDF6820499;
	Mon, 16 Mar 2020 15:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C12D0C1D88;
	Mon, 16 Mar 2020 15:50:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7047C013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C628888D97
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MEx2LyYUYgOc for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:50:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D10228884C
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:50:37 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id b2so15624708wrj.10
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ppucAR3jBSlUx3f6FMEJLnESjyE6tqFd9bVOCG9Ch70=;
 b=KWi+mz5Ml7txmdoZr19aVQmfuq4pxYfgRps9r2wW5ZsBdqZUhieYBFFgGOjP2Y6bx4
 Wyhz0sJVzU+ttJVQaciTpiR1C0VRxuyTIVO+dc22nAk47TiATbV0DDmHWZKNHrvm2d4C
 vUaa0hW1YGFbvsd4Uq2C+TXdm+UshPrNCJCR7kDzhdknhAK2c/faq2qcpOcTCILD4e73
 SanxGSnN9MZ59DsdmAjiBTz1XxdiLtNTzfhIHxG2HnSi1v3DnTsQ2LGv/Q8k3NkWXNkz
 QoSGyKn9pcROOSXjXbika5mVnv89BwzwPk4bOrNqAP29KhbsRRP7ajNL8l0XJVmaY1q3
 +MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ppucAR3jBSlUx3f6FMEJLnESjyE6tqFd9bVOCG9Ch70=;
 b=B3kv57fVRS2MGhqbfTdFxvyhqn/DuWFzsm0KvNEqH34Afe0S4UqvbCzeHUyviH4Ver
 T1/PcQKLGz6y9vZdhUTCI4Ti0h9o+t6qJsARS2wRGwsxI8NR27gOzFnAB5f3MCYiak9M
 0aeDZ2uVhInsHijBzdzclvGaoDJ8TQLbjT5G4PRjHKSBrXx3xXR27/DiEtYit9ZIN5M7
 1MPbQPtdQr93Ztas4nrCqVl5nYzKAX90r//wWHySJeTU6Yal8KkojgKTsM25huiicBGO
 4RU7JNqVBijLfblr+LDq61tCA77MIIyUNWDALtk3ylFAesq0Q1nun/baCNNQHr200zTr
 sUQA==
X-Gm-Message-State: ANhLgQ1A9nqurDSUzMgJUgJ52paAhFF9sX+4R8iGxN9hF/9XQUGQqMCw
 kn5BfMocMipMbyXwE0PBV9PHIg==
X-Google-Smtp-Source: ADFU+vvMLgpIudyWQDIKiFCwE2bd5t8QaZ3ZQI2eMwU4VsE9JIaD98F8TicbYAXHc+pSTvK+AYpoyA==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr43953wrn.62.1584373836280;
 Mon, 16 Mar 2020 08:50:36 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p16sm147962wmg.22.2020.03.16.08.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:50:35 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:50:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 11/15] iommu/renesas: Use accessor functions for iommu
 private data
Message-ID: <20200316155028.GK304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-12-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-12-joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Hanjun Guo <guohanjun@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Sean Paul <sean@poorly.run>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Mar 10, 2020 at 10:12:25AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index ecb3f9464dd5..310cf09feea3 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -89,9 +89,7 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
>  
>  static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	return fwspec ? fwspec->iommu_priv : NULL;
> +	return dev_iommu_priv_get(dev);

The removal of the fwspec NULL check was worrying me a little. Now any
user of to_ipmmu() directly dereferences dev->iommu->priv where they
previously tested first whether dev->fwspec was set. But I didn't find
anything that could go wrong, and the resulting code looks better.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

>  }
>  
>  #define TLB_LOOP_TIMEOUT		100	/* 100us */
> @@ -727,14 +725,13 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
>  static int ipmmu_init_platform_device(struct device *dev,
>  				      struct of_phandle_args *args)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct platform_device *ipmmu_pdev;
>  
>  	ipmmu_pdev = of_find_device_by_node(args->np);
>  	if (!ipmmu_pdev)
>  		return -ENODEV;
>  
> -	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
> +	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
