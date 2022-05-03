Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ABBC433FE
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 12:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39CB9416F9;
	Tue,  3 May 2022 12:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xuZjX3wXIG2J; Tue,  3 May 2022 12:26:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E008D416B7;
	Tue,  3 May 2022 12:26:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9061FC0032;
	Tue,  3 May 2022 12:26:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF92CC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 12:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A840D81C58
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 12:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3vBivCNFaNVY for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 12:25:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31845819F3
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 12:25:58 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id z99so19643689ede.5
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=GCGJOVaFvPi2cdZAa6UPkRWwapZJfoD9FjLKsOzvOl8=;
 b=zZpYb09NzsULIdZvqjDWB34wsfCyTIW5qhy/Esiwqa0TJfdQ0n7LVmNrsNmV9pyYX/
 DOXjArMo3aj+3DszDWbmUxffbbzRcO+PfFNXvLHttb9IL3AsZ4t55iSPu5Kep3RbgDEI
 On09x1duQp/RjmK699DnwteUsXUHhTlQEUoRxhk2VrDxk3RpN38pfzvawTR0tWOjYm9M
 NsQGospBzheK8/z/zqufHgKDQv1LNN2yESPk6B4p4fhOF/kUPU3RIFmN0X0DTOwxxVbx
 J7mFj0hO6o6JoWysUrtCd3xUCy3izDNsJTqNfb6Cw4OqLBR3Y44FMnkLGAYLH4Gox31N
 zHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=GCGJOVaFvPi2cdZAa6UPkRWwapZJfoD9FjLKsOzvOl8=;
 b=YLFhR43ir4zAqyK2m1kFHYcefmyjZ6eCzwqcizjqP0AoSHoG9PrUNHLjL1KxCrR6lq
 V7bSu32IszeVl/yyPxmBXcUIMUaWnnrTgOb8nnU0twCP+DwzOxH5mUuzY0w08BeE/Rpy
 ysyeJ+VfX0HlP128z7yawoRj+rsN1LXvmZVUnVxn5m/GI7xCj4OdqFYVf1Wi71z3yxge
 5vhUB7MAOcbGeJOFJZfBD4kjgDDDBzv53SaFJV1tVESwbDq6padWCMmDo13gAfhk3cDZ
 aXtYacbXiljVBgn3aXbv5Rw9sbxbUuyutUQvVVOzQsV1z52mvFhaXHTcWB42v6PDTuVq
 48GA==
X-Gm-Message-State: AOAM532Y4N97i7bQ+Mtoft3VhPktT++6CspjHjhOP2cbSxa3PgU5SlfY
 BhR9fCVglWMCurs8CKU8jF7BJg==
X-Google-Smtp-Source: ABdhPJxaIEfqBaZo/WyNo6ukWwIiffhWb+nMnmw0GMvJWG2DxptvaFbjV2ed02Ff/JuclfPWdiESsQ==
X-Received: by 2002:a05:6402:2554:b0:423:f3e3:81da with SMTP id
 l20-20020a056402255400b00423f3e381damr17651983edb.87.1651580756428; 
 Tue, 03 May 2022 05:25:56 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 ia15-20020a170907a06f00b006f3ef214e78sm4554780ejc.222.2022.05.03.05.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 05:25:55 -0700 (PDT)
Message-ID: <9868ae89-57fc-0f1a-89a5-5ee0cd9207aa@linaro.org>
Date: Tue, 3 May 2022 14:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] dt-bindings: arm-smmu: Add binding for SDX65 SMMU
Content-Language: en-US
To: Rohit Agarwal <quic_rohiagar@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, ulf.hansson@linaro.org,
 agross@kernel.org, bjorn.andersson@linaro.org, adrian.hunter@intel.com,
 bhupesh.sharma@linaro.org
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651480665-14978-4-git-send-email-quic_rohiagar@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1651480665-14978-4-git-send-email-quic_rohiagar@quicinc.com>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 02/05/2022 10:37, Rohit Agarwal wrote:
> Add devicetree binding for Qualcomm SDX65 SMMU.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
