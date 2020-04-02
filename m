Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7759C43331
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 06:52:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6706820784
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 06:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNE5T8qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6706820784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2635020423;
	Thu,  2 Apr 2020 06:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id koX3LaXLMYJn; Thu,  2 Apr 2020 06:52:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3DC9C2041F;
	Thu,  2 Apr 2020 06:52:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14FADC089F;
	Thu,  2 Apr 2020 06:52:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 437BFC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 06:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2B02420423
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 06:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UrDtI4hA2XyB for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 06:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 1FF952041F
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 06:52:04 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id s23so967354plq.13
 for <iommu@lists.linux-foundation.org>; Wed, 01 Apr 2020 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QnW1FRwTH4xbg6LjM8uAuRTxGm5LQR9zZzf7WroNXlk=;
 b=KNE5T8qnOrg8DU2Uf0oSMAWQslv7RAp37B4JyeQ3UXi+xSSIhp/xde1qIF/pvqxL9J
 uxZGuNG4rugzfgwvQE8KO6Q9zN4Gn2dem01V61dEZ4+yTTmhAUzhQuxb4qetrbd2QzQ9
 VZ/5M5Ai8cumWOzOutq4YrufW5MGwo0BkntamiaU4X7bIamT+y67fMt8yADlN9TylaUH
 K8F9HomtVYyoxklKUgsWeuDhjNcxaJbb5dhX4UFj73+0sZW+WkOrdQTHhP3RSnke6AVV
 0GUCdQa0Egz+xressXuZyWEB+f5tjVbuymp2GuRRrw4Q0lliCdINuQjSevox+BOjLR+G
 QQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QnW1FRwTH4xbg6LjM8uAuRTxGm5LQR9zZzf7WroNXlk=;
 b=GgYfQrMCXroT7UjJVkI+wc4HubxG2M4f3gWn2Kaz14vOyXVbrW0/H7X3FOl94kEzBU
 SYNIRQScnfMGBdCYClHXdCVNrOBCiMBO9gXH/2cL/ny+i5bH6yC7XqBGInYlF5KZpJzH
 9JTAo3iM9F8MZDTuM468l3RLYfpcDCF2b9L4AzbfhGBkPdtftX45216UBZ3Mp+O7RqMj
 364OtdQsbwnLmatNM5hKG5rtEYSIpa4jROCnF7+rG9fHnjtG6gEZB+1cnNS5nteIl2cE
 OYa1Oiid0jtQ6jffOp8EkvKN1J6TgxSbia1TcjenTT2+MLvnT+0Lcle8k+SsffImUjsD
 8CaA==
X-Gm-Message-State: AGi0Pub8bxXVdZNqkUdGWrmecMm7QADPT13d53px/lkgM8ep2Bp566ip
 UE7RWQdrMEdJmTioiVHfgi9E0tU/W0o=
X-Google-Smtp-Source: APiQypLGCELqQ+CVBf3q8b/1bk+rBZgF5Fqa4XWZ5iwiVgkfN8O0vF2RVSrCHg3HEEPGfX83+uu63Q==
X-Received: by 2002:a62:cdcc:: with SMTP id o195mr1696130pfg.323.1585809955390; 
 Wed, 01 Apr 2020 23:45:55 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id ck3sm3006406pjb.44.2020.04.01.23.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 23:45:54 -0700 (PDT)
Date: Wed, 1 Apr 2020 23:45:52 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] iommu/qcom:fix local_base status check
Message-ID: <20200402064552.GG663905@yoga>
References: <20200402063302.20640-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200402063302.20640-1-tangbin@cmss.chinamobile.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, agross@kernel.org
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

On Wed 01 Apr 23:33 PDT 2020, Tang Bin wrote:

> Release resources when exiting on error.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/iommu/qcom_iommu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 4328da0b0..c08aa9651 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -813,8 +813,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	qcom_iommu->dev = dev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res)
> +	if (res) {
>  		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(qcom_iommu->local_base))
> +			return PTR_ERR(qcom_iommu->local_base);
> +	}
>  
>  	qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
>  	if (IS_ERR(qcom_iommu->iface_clk)) {
> -- 
> 2.20.1.windows.1
> 
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
