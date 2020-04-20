Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C83C54FD0
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 04:52:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8C1206D4
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 04:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llneVi56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8C1206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 92A4B204A9;
	Mon, 20 Apr 2020 04:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8M3VcKKbeWw; Mon, 20 Apr 2020 04:52:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BC96920386;
	Mon, 20 Apr 2020 04:52:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0B22C1D74;
	Mon, 20 Apr 2020 04:52:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10DC2C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 04:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 071338575A
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 04:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTTfNjWbZW5r for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 04:52:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D11FD85810
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 04:52:40 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id b12so1392098pff.4
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 21:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oNKRiUuDH3HcT8/Qwk9sSK+q6T3XdbwZxPtum7dk+0k=;
 b=llneVi56W55NiLr4/oEdHvQsx+uYbkRQzHPT7RXrZNrdWl4RLJewuv+rVJiKFrxkY4
 nmoFjBHPPeFNYEhI0kfaqgQBF6znWdA/EnlSHtnOx4AclT+kIaTuWS5tm4iSecLCnJ2R
 dooRwMKfMVWt3HMIgWpLAcKKHUSvFmDPybPwq4jo9AkyuK8Dnd4CBBSVaOkqsH7FwfLR
 s0D/bjS8qTOYDnSracP58KpC0hBcOwJYF3kbiuPScSMwMAdeyIIRIryN1guKVbLzk3eE
 1Rl9U9+MmfT//SMqV+TPzyfgxNh7I+SU//n/RgeKQLzsejwKAlcB3D8JTWza3p0o0Svh
 WsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oNKRiUuDH3HcT8/Qwk9sSK+q6T3XdbwZxPtum7dk+0k=;
 b=IKB60C1onmzyrLU9/G++EdRsxfmtcMhQqR5AXUiYDDdv5YxHrqwqJf5GVAGScXotWS
 Ly2mevxJWiKkZq5RvjZNJvAJoQbJozhR1JrmYw47lRz1+yR4TsY6cwtn39oBMJZmJnjG
 ZlIK3DT+T1mdbGZJPV8nFD1dzlLfvsSqGehCzM+hAGjh3parJHSwnGr/taCVHATFrDwr
 t+1oO8LmhJ3WK1zopgSdO06LTcZgLAJgm8sVbgnBA33ETyHEZyojlwaCzbMNPm15y3DM
 QsEHlbHT7tGIOpZm4Y8N0tdQtxVgE/Umevh0AzvXCuKjqOvv7YTdEzt4FTwLBf4bd/sT
 AdHA==
X-Gm-Message-State: AGi0PuYU+ati236sWm2gg6FZP0MCvOu+z1Utdxk+a5hBpP2SI5sbYig+
 BvefSJWnPTjTt7oT8xb5leP9nA==
X-Google-Smtp-Source: APiQypL47lTKmGwxOxVtKUAf13H57l0+QHnxWnUbjOkYcpSlzaMu1RjcsaR+CpdIXKiQMYpYBNys4A==
X-Received: by 2002:a63:514a:: with SMTP id r10mr12687721pgl.246.1587358360091; 
 Sun, 19 Apr 2020 21:52:40 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id e26sm25908782pfi.84.2020.04.19.21.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2020 21:52:39 -0700 (PDT)
Date: Sun, 19 Apr 2020 21:52:37 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH v2]iommu/qcom:fix local_base status check
Message-ID: <20200420045237.GH987656@yoga>
References: <20200418134703.1760-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200418134703.1760-1-tangbin@cmss.chinamobile.com>
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

On Sat 18 Apr 06:47 PDT 2020, Tang Bin wrote:

> The function qcom_iommu_device_probe() does not perform sufficient
> error checking after executing devm_ioremap_resource(), which can
> result in crashes if a critical error path is encountered.
> 

Thanks, that's much better.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
> v2:
>  - fix commit message and add fixed tag
> ---
>  drivers/iommu/qcom_iommu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 4328da0b0..b160cf140 100644
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
