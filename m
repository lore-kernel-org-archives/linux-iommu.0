Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D430C433DF
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 09:32:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE22220739
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 09:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbutnNHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE22220739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7D7C2886D2;
	Wed, 17 Jun 2020 09:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7CcLPkXGAS1d; Wed, 17 Jun 2020 09:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5549588652;
	Wed, 17 Jun 2020 09:32:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 349F6C07FF;
	Wed, 17 Jun 2020 09:32:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAAC1C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 09:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 996AA88EFF
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 09:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4+ZIVBgJDltY for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 09:32:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AE3A688E5B
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 09:32:29 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id n24so1601407ejd.0
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cTmd5tX6YVYoIxY4tpUy+apEsuQqZLQPN2tP1qBmaWs=;
 b=UbutnNHTQwhmHowciBnS6G2F8ot4diXcsL2QMDte9vC4ANIEyGGtivu1J6xAobtx0l
 LG6+/q0CKuQhAUeehhOYn/ssnfAkMft+pGrNKiUyMcadMPsNf6SHPWMIqtqEReKqauwA
 DBH5tL6/XGPuA+RqoWP6waLtpNQrn0YKnyJ5kAnkLAcT2G+540YKljKU7joTcoy6Zzds
 K8p1U8PR88QXqO67erDw6E11SM42uV1S9b2OIwPyXK8ILyYP81IIrXi3mBJOoiVX7ksp
 NoOewQ7GoqzZ40VrhkW9eU4r07QVk2amn6UFFZ6v07P2n9uwqktaBwI0sEkgCDEyfuPE
 XtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cTmd5tX6YVYoIxY4tpUy+apEsuQqZLQPN2tP1qBmaWs=;
 b=CGvxGRFoptyTycjYA42WdtNpzKBHYTQdWb1ckSD/nVXPZH0bKo1B7m9cJQameEB1o/
 Zhbv6tJMQgxyxMawKJC3R7MU6yr0+PagS0zGyro0FVrRqNxPRl3vMuq8kIszCG38aMCB
 0GsKFtDB+TaG9MYuvF4E2UozFK3RH2EIAW1lcqmfLKYT3OwnU1bflsJlx/OQY5tFRD7R
 J4GPHXJzRl1SzBmZ7hu5SEnJlUxsPuEqIqcs6zodSd7heIIRF/ms+hxLSy82wYMWvlTf
 I3AP56kPRnL7lBgCIRv5r2ZBSn7iMS4vducvPb1D3grAwhk2ipnubbtMfMTKpZ+XP8YY
 pmNg==
X-Gm-Message-State: AOAM530duREnw8OXi6CzHIwRAIT96IQ5ww0WehEovONDjNEDd0Ld//Jd
 hVxsd+pLOqoGkCiYwoGpengL9g==
X-Google-Smtp-Source: ABdhPJyklQPyHL2n4G1KEjImmjswHON24/eVFkuz53itdZaig2qjcx7EF/rtovwtXuJ6CEqXcbsiLg==
X-Received: by 2002:a17:906:7693:: with SMTP id
 o19mr6318850ejm.295.1592386348039; 
 Wed, 17 Jun 2020 02:32:28 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y12sm9380552edj.37.2020.06.17.02.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 02:32:27 -0700 (PDT)
Date: Wed, 17 Jun 2020 11:32:17 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] uacce: remove uacce_vma_fault
Message-ID: <20200617093217.GD871763@myrica>
References: <1592229357-1904-1-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592229357-1904-1-git-send-email-zhangfei.gao@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org, kenneth-lee-2012@foxmail.com
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

On Mon, Jun 15, 2020 at 09:55:57PM +0800, Zhangfei Gao wrote:
> Fix NULL pointer error if removing uacce's parent module during app's
> running. SIGBUS is already reported by do_page_fault, so uacce_vma_fault
> is not needed. If providing vma_fault, vmf->page has to be filled as well,
> required by __do_fault.
> 
> Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/misc/uacce/uacce.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 107028e..aa91f69 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -179,14 +179,6 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
>  	return 0;
>  }
>  
> -static vm_fault_t uacce_vma_fault(struct vm_fault *vmf)
> -{
> -	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
> -		return VM_FAULT_SIGBUS;
> -
> -	return 0;
> -}
> -
>  static void uacce_vma_close(struct vm_area_struct *vma)
>  {
>  	struct uacce_queue *q = vma->vm_private_data;
> @@ -199,7 +191,6 @@ static void uacce_vma_close(struct vm_area_struct *vma)
>  }
>  
>  static const struct vm_operations_struct uacce_vm_ops = {
> -	.fault = uacce_vma_fault,
>  	.close = uacce_vma_close,
>  };
>  
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
