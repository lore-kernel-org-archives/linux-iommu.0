Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A8C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 07:48:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF18F20775
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 07:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JuHGdSRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF18F20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF92687C13;
	Fri, 26 Jun 2020 07:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a1nAfXSwHCI2; Fri, 26 Jun 2020 07:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 16BBA879E9;
	Fri, 26 Jun 2020 07:48:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02F05C088C;
	Fri, 26 Jun 2020 07:48:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69D85C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 07:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5955F86A27
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 07:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nm8NZuHVshxa for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 07:47:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C5DED8698F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 07:47:58 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id h17so7331781oie.3
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:in-reply-to:references
 :subject:from:cc:to:date:message-id:user-agent;
 bh=OJIUC4k1mJAJPg8NhZJ50NxPEO+zBVx140Q/CxvWNvw=;
 b=JuHGdSRcBQGE3Lde78F313PsAZcPMsnhx/4TiHSLZEfd0kKmZO8VUORbl2ywLlLNYP
 SybuYbIXipyAqOoCEFVzfX+cyu1u//qdxZmUFkk1BZIbhZiDVvkT+r3ys2yo80bHbGon
 SsdxDCae+9fy02JYCpW6exl43BLdPHw76Jn1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding
 :in-reply-to:references:subject:from:cc:to:date:message-id
 :user-agent;
 bh=OJIUC4k1mJAJPg8NhZJ50NxPEO+zBVx140Q/CxvWNvw=;
 b=LShfuIjL9Msx/yDoQbd/dM4cudaSXUfZLEAZaIUJhaySx20BMbGUg2x8YX8EaFQ8nd
 I3p4cVNrOV/cEvIGTLSY8cTv2TriYmpP1vhsCwQJYel8FycCab9ww8bXWSKA39NM6xKg
 9i10yUQTwidh1yMcSsBc+8v3xj3nIgGtTq33D9LyauO9m5bNpLoNysC2Q9SzhL44pBhC
 TD9hFQvqPzG/f61AGYK8tP9VcCHRAZIlivOFdDtxUffSASATkz255S4xx2Nc+zDAOaEa
 3L+wLl9HLPNMYh/A7pErf8ZYk/ZQqOjXjHnQSgxtZ4pF0A5QxFFoPzL6AdvGv189ojdN
 oKCw==
X-Gm-Message-State: AOAM531ylb3rerKOlO63KspDKx/1+/ZmaBScikUKEVFFHD8GpYN9Y7lz
 UK4MBPbmSWU7ULroqcSzidueKxocvac=
X-Google-Smtp-Source: ABdhPJxJiBdKBJCg9hkKXPvaAZ1SMFSV7dxt8ZkrJwCH6KsPe6VyOeT252b+sGAmU5335uuNU45W2w==
X-Received: by 2002:a17:90a:1546:: with SMTP id
 y6mr2153667pja.92.1593157376534; 
 Fri, 26 Jun 2020 00:42:56 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id jz23sm10479542pjb.2.2020.06.26.00.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 00:42:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20200625001039.56174-4-john.stultz@linaro.org>
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-4-john.stultz@linaro.org>
Subject: Re: [PATCH v2 3/5] irqchip: Allow QCOM_PDC to be loadable as a
 permanent module
From: Stephen Boyd <swboyd@chromium.org>
To: John Stultz <john.stultz@linaro.org>, lkml <linux-kernel@vger.kernel.org>
Date: Fri, 26 Jun 2020 00:42:55 -0700
Message-ID: <159315737502.62212.16093934831673347066@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>, John Stultz <john.stultz@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm@vger.kernel.org, Todd Kjos <tkjos@google.com>
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

Quoting John Stultz (2020-06-24 17:10:37)
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index 6ae9e1f0819d..3fee8b655da1 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -430,4 +432,33 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>         return ret;
>  }
>  
> +#ifdef MODULE
> +static int qcom_pdc_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct device_node *parent = of_irq_find_parent(np);
> +
> +       return qcom_pdc_init(np, parent);
> +}
> +
> +static const struct of_device_id qcom_pdc_match_table[] = {
> +       { .compatible = "qcom,pdc" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_pdc_match_table);
> +
> +static struct platform_driver qcom_pdc_driver = {
> +       .probe = qcom_pdc_probe,
> +       .driver = {
> +               .name = "qcom-pdc",
> +               .of_match_table = qcom_pdc_match_table,
> +               .suppress_bind_attrs = true,
> +       },
> +};
> +module_platform_driver(qcom_pdc_driver);
> +#else
>  IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);

Is there any reason to use IRQCHIP_DECLARE if this can work as a
platform device driver?

> +#endif
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
> +MODULE_LICENSE("GPL v2");
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
