Return-Path: <SRS0=YHJ+=6U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B27C28CBC
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 09:35:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0162082E
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 09:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQmDygjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0162082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B1F8C87765;
	Wed,  6 May 2020 09:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0bDlkXxybJXF; Wed,  6 May 2020 09:35:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6605687750;
	Wed,  6 May 2020 09:35:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82F93C088B;
	Wed,  6 May 2020 09:35:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9465DC0859
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 09:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 89832885C6
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 09:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LXuTm0b5m22D for <iommu@lists.linux-foundation.org>;
 Wed,  6 May 2020 09:35:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8CE3188557
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 09:35:35 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id v12so44801wrp.12
 for <iommu@lists.linux-foundation.org>; Wed, 06 May 2020 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hCCpyyCsOwf45inMt3o257A10/7eYZVNmL7O126puyY=;
 b=qQmDygjweLPcARZKtEeUbSr/HBXsPReN+4F8YbS6vvDa0tGq1EHXWrXA75PwpaRdjY
 mXiK+Z9ZeDkNeevpk4kqT3qKXBtxVsqTd0+msRTI9uCUkUr51sm73HUAZVDRr7C6OHBY
 vdEovuXdY87GlYoUTYozZ5pLMPDzr1vD4JSeHk8GGhmi9SWbc61tM5SHbcQPYjMeB1Bf
 9A6HoSI1Ck8eLfK6x8dOfo/L8/KpJJw3ITP42d6xcQyVuM46JE5qGEKHxJeGScrEg9by
 mk9TRYdKUIwdHujQ2wm11KE5z73mZ2TaE1PTlkPj3X+H+EG513sFepobGLXfwUyqe9BL
 zF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hCCpyyCsOwf45inMt3o257A10/7eYZVNmL7O126puyY=;
 b=KBrHITLa2wif2U/KyIecdTAEIQs9MOtIPqWsQPaOqi8GUluSFQif0zFOeHBiAlRHAB
 0PvVQ1JLlxvaUrU++/AGPOHR3rCWiQc+Vyuk47TeiOwmNHSegIk1tNhKthG4gccf8o6A
 krH5Xe7CD6nydR6z+DUl2W7FF7eRt+ST6Cw0XM0KAJ44U+FaKeRdk6LAUQbuhWbWrApy
 fw6bH5VPv7BrqJwbwY9GMtf2Wrwznf/VglrIc3AVsmkz6K72sB/SCghCCpAWYehIzgsx
 m9RNNF8nKOEyoa5EdvlB0XaSGXe0iVLsxQSfqrEACbnCoBKEQCmNHiv9tYvs22V9LKAI
 IojA==
X-Gm-Message-State: AGi0PuY+cqG2Uhj0R5DYi8dNKJoLi1v6mn2ZTUJqAwxZAAkW8wUu1naC
 tiQDda27Y/DW02luywQ80yYf8g==
X-Google-Smtp-Source: APiQypLQJjy5vw34J6eJsUP2ihdRbCpbrZFEgYI/5478WTJrZUym62sqJpQzFvaN9hsw6iitUy55kA==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr8373863wrt.163.1588757734052; 
 Wed, 06 May 2020 02:35:34 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id x7sm1677336wmi.17.2020.05.06.02.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 02:35:33 -0700 (PDT)
Date: Wed, 6 May 2020 11:35:24 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH] iommu/virtio: reverse arguments to list_add
Message-ID: <20200506093524.GA497896@myrica>
References: <1588704467-13431-1-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1588704467-13431-1-git-send-email-Julia.Lawall@inria.fr>
Cc: eugene.volanschi@inria.fr, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org
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

On Tue, May 05, 2020 at 08:47:47PM +0200, Julia Lawall wrote:
> Elsewhere in the file, there is a list_for_each_entry with
> &vdev->resv_regions as the second argument, suggesting that
> &vdev->resv_regions is the list head.  So exchange the
> arguments on the list_add call to put the list head in the
> second argument.
> 
> Fixes: 2a5a31487445 ("iommu/virtio: Add probe request")
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Thanks for the fix. The reason this hasn't blown up so far is
iommu_alloc_resv_region() initializes region->list, but adding more than
one item would break the list.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index d5cac4f46ca5..4e1d11af23c8 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -453,7 +453,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  	if (!region)
>  		return -ENOMEM;
>  
> -	list_add(&vdev->resv_regions, &region->list);
> +	list_add(&region->list, &vdev->resv_regions);
>  	return 0;
>  }
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
