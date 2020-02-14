Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA7BC352A3
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 02:44:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E7420848
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 02:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IPZYguxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E7420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8F1298746D;
	Fri, 14 Feb 2020 02:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6BIGpQUf9gdK; Fri, 14 Feb 2020 02:44:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DDD338746B;
	Fri, 14 Feb 2020 02:44:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3EC7C07FE;
	Fri, 14 Feb 2020 02:44:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00858C0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 02:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D5C5D20395
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 02:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fG-U+BMBlPLK for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 02:44:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 2B10220377
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 02:44:13 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id z12so4186123pgl.4
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 18:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:in-reply-to:references
 :subject:from:cc:to:date:message-id:user-agent;
 bh=niNApjCO06O7a+lFbqctq/E/HFCOZGM44slzM8VnlEo=;
 b=IPZYguxYwiX88hRwH7QTLPVac3hJ/RngX14B4KoZqW6OiO/2xsVmTwj+HhOFyfg7nh
 TT0vT38gm9VGUvEz2ocWIbn+qo8hKz8aOteojzMKPNJwdp3Ifg8ap0Hv7Ilq+x9zZLw8
 7xsWgM62nwwp1kelkqj+SxQtFQoO+K1f4zu1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding
 :in-reply-to:references:subject:from:cc:to:date:message-id
 :user-agent;
 bh=niNApjCO06O7a+lFbqctq/E/HFCOZGM44slzM8VnlEo=;
 b=HJDPDAaUiI/vItEFSg0t7Cz4uX0WiUwKXDsYzmlimDXpukNNtkg4BI7Xn6EZXT6Opa
 2LPl0o8EjewvHq4gHbdlMFYKZfVrorDyug7P6KIYLeUcHgPEvVo039rHJOrdv8FkPdGq
 mgxVLJhKIKn72YYfbI1VZGwsmSpHLXE5Q+Udh+2BcfGde6uzdDMC2R1qQATHDFLX2NMV
 ULq+Jij1LQEhs0tI2LY1YoYpZtOtTiXNod7yTYqtBVwUD4t5mA2XUL4GlhDXZfJjMxHb
 /9uv0+47SpsPmwMlmF0TwTIpexL6W2KmJbvXVTNy+CXIcgZ6GAWuiarDr+58MO7JhFoh
 BBew==
X-Gm-Message-State: APjAAAWDU/7tCStej+qr0I9AYCC5OXnGZ7Op3qosY1Kl/poUNmR7sgrD
 06f7jVS5s/kolvXlvhMreM318/8XFyM=
X-Google-Smtp-Source: APXvYqwzYj+wvXbHesIqdU5LMCnildAw4yCq+8revIbEfOsWKVii3zdqeKtfxcBEcLKIdQKk+eTHGA==
X-Received: by 2002:a63:74b:: with SMTP id 72mr1052514pgh.162.1581648252362;
 Thu, 13 Feb 2020 18:44:12 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id c10sm4575360pgj.49.2020.02.13.18.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 18:44:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e7ba4dbd8e9c8aedd6f5db1b3453d9782b7943cd.1579692800.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <e7ba4dbd8e9c8aedd6f5db1b3453d9782b7943cd.1579692800.git.saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 1/2] iommu: arm-smmu-impl: Convert to a generic reset
 implementation
From: Stephen Boyd <swboyd@chromium.org>
To: Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>
Date: Thu, 13 Feb 2020 18:44:10 -0800
Message-ID: <158164825099.184098.18396989716299086067@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
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

Quoting Sai Prakash Ranjan (2020-01-22 03:48:01)
> Currently the QCOM specific smmu reset implementation is very
> specific to SDM845 SoC and has a wait-for-safe logic which
> may not be required for other SoCs. So move the SDM845 specific
> logic to its specific reset function. Also add SC7180 SMMU
> compatible for calling into QCOM specific implementation.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
