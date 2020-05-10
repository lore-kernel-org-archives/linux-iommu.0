Return-Path: <SRS0=ml75=6Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136B1C38A2A
	for <iommu@archiver.kernel.org>; Sun, 10 May 2020 15:28:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2ADD2082E
	for <iommu@archiver.kernel.org>; Sun, 10 May 2020 15:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+MsY9WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ADD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6F9FA2049C;
	Sun, 10 May 2020 15:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c4w2H-YwJdGm; Sun, 10 May 2020 15:28:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4C95E2033E;
	Sun, 10 May 2020 15:28:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32377C0888;
	Sun, 10 May 2020 15:28:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B56A5C016F
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 15:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A289C868A8
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 15:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id neb0QjuA8206 for <iommu@lists.linux-foundation.org>;
 Sun, 10 May 2020 15:28:07 +0000 (UTC)
X-Greylist: delayed 00:28:44 by SQLgrey-1.7.6
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com
 [209.85.217.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B8E1087675
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 15:28:07 +0000 (UTC)
Received: by mail-vs1-f68.google.com with SMTP id g2so4063922vsb.4
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VB6QB0k6yF1xCUNO7qdS9eL2WdSOXXOnR9sFnZiLOd4=;
 b=R+MsY9WCtRMMxoxZF4KOot1ecgDsOPB1vYqBzsx/sSAFnQsx9ArlIiv1oWrbe6IYzM
 Zk2VyZUIcN0aB7+7F+8JD/UHUpzpXTubVIrv/E6LkNO2Guiz9jcOztegpRyY0GE9Pcvu
 tCW74BbqPjb/gEN6ITnZvVZDxPyiMjQpEKZieR+v/hGQJ5Sj3AQG05OZwCtLAz7iWZnF
 YGG7EPQZ685umqmg2iQn37HlDAlMZfaujGc/l6o+gOSBjXcFfJTtIsAat0fm8UZpDH9H
 lxZMu7JeudSu6i/Sa4g+vY0TUnSRefgt8matT62fUh8rEHNhj6DVXiBA3VM8gkamkaSq
 z4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VB6QB0k6yF1xCUNO7qdS9eL2WdSOXXOnR9sFnZiLOd4=;
 b=olc4Eium/QKDiZCBMk1IBoRPTu30jazdyry/tZK1xVon5+VN9GqJF9378mzxKVqXaw
 9BC7sxl1L6VG/njO/KgBrrewtKLN2chNl4ojmMokxL3R1snDWCb9TCpIQQIWU3Yi4Y1g
 4/Muy97i96RYatcf7RAhnYaisN+/eMpzkXvSP6GFAEhPeCFsy5DwIbUhNANUGUdIWTFh
 bGTg3tnaoIte7W+DOofceEtoUKk+ZA0JQUQitQGi+LtERzkMvuYAtgtAe+XOu/9RiPmr
 bFtZ5nf71e2Pl0TsxyFaSE57nvz7ruiLnx/IhvEXEdYoRuK5E9tTskUqezRsFeokT9Aw
 sfkQ==
X-Gm-Message-State: AGi0PuY0AyyZX8iSE9JhG8W2AV11Ut74MqTd++QaIKxLxoFiA/s9lg2A
 1exQuhNHHx1aHB4tVrYLFYf9gajBHEI=
X-Google-Smtp-Source: APiQypLVS+XTU5o7852M9jAyZ4wpgBqMnBWgIepU1EgoKyX04/8LK6qI8+34szonUh28DVcCpNNSNw==
X-Received: by 2002:a17:902:bc86:: with SMTP id
 bb6mr10879547plb.243.1589121033101; 
 Sun, 10 May 2020 07:30:33 -0700 (PDT)
Received: from dragon ([80.251.214.228])
 by smtp.gmail.com with ESMTPSA id g40sm7631138pje.38.2020.05.10.07.30.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 May 2020 07:30:32 -0700 (PDT)
Date: Sun, 10 May 2020 22:30:21 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH] iommu/qcom: add optional clock for TLB invalidate
Message-ID: <20200510143020.GA16939@dragon>
References: <20200509130825.28248-1-shawn.guo@linaro.org>
 <e8150781-6000-dedc-ca10-6cee232c4364@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e8150781-6000-dedc-ca10-6cee232c4364@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-arm-msm@vger.kernel.org, Konrad Dybcio <konradybcio@gmail.com>,
 iommu@lists.linux-foundation.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <agross@kernel.org>
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

Hi Stanimir,

On Sat, May 09, 2020 at 04:21:20PM +0300, Stanimir Varbanov wrote:
...
> > @@ -839,6 +849,12 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
> >  		return PTR_ERR(qcom_iommu->bus_clk);
> >  	}
> >  
> > +	qcom_iommu->tlb_clk = devm_clk_get(dev, "tlb");
> 
> IMO, devm_clk_get_optional() would be better.

Yes, indeed.  The function will make it clear that the clock is
an optional one.  I will make the change in v2.

Thanks for the comment!

Shawn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
