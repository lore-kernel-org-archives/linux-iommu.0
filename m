Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54E8C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 20:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27F4B610A2;
	Tue, 28 Jun 2022 20:19:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27F4B610A2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=actnBH/L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zaUF6SvD8T2f; Tue, 28 Jun 2022 20:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC97860B2B;
	Tue, 28 Jun 2022 20:19:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC97860B2B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4436C0039;
	Tue, 28 Jun 2022 20:19:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC664C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 20:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78EBA60EE1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 20:19:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78EBA60EE1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJEgWNwlzLLy for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 20:19:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C42D860B2B
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C42D860B2B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 20:19:45 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id bd16so18754434oib.6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L7X1tSt2iJ6DktLCRmPmCKw+/uL8cAeokrUaFc2RJPI=;
 b=actnBH/LAbmAGmzjAjA8870t8pTv0++Ozgzd1b8av4QHdzi0Sdb2uSzk7UPp4Ps9W0
 QpDYq+X8y9S53gjHtePp+LZQAN/MnSlmKdLkOy7gx3dj8SgiSl1rTSdznrxBPFt2/wRk
 JvrPD4y6S4dGNjQdq9wkciNMfUdYb/iGsvbCGp+hqzJYKjqklN1w/WhDkJ7AoAjDf/9X
 xnFWoBDTCSJ0nq/EQrtmMqAyS4UXDCaP18Jgq25spIEBe23YW/JhnplHURLHc6uLDBdV
 KpkhTJi3KPWcDCNFSDsM7sGWHAqY/HIlM6X7tBVCBZbhziD9xUSFzkItAuHB9FINhbr3
 Tzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L7X1tSt2iJ6DktLCRmPmCKw+/uL8cAeokrUaFc2RJPI=;
 b=oEmuTlKGJxWPs31FZi7biz6/ZVorEC/C2vwJ0FXFndgEdXfUR2AlvaK9Qh+yjFQeLl
 hHvHDS5Jd2G6Qcb9yUSY5EZHFE4tTcz/N9leKuCndnS/pmL86Js4YcVQw3KmLqYItOwM
 fNSfNQScobDdXkPu9Kmy385wj3zkQ6GpAOwdH09edGgGsMmK5jBtOkcx3v9Dd1SRRSGw
 CoTFdJORJ1FtpnPKta9iDrsEFYAPPVRNv4B0r2JdF1kZdzNyqPGH+eBYp3U/49S02a7c
 3Ccd6HhWshGyQis6/dfS9vfzOw2skCLmV+5BiY7A+b8DHJNQrtphJWGVvP09SnHO6ajZ
 dzAQ==
X-Gm-Message-State: AJIora8Z90X+sMfv+tOZuM27jupEVaC4dFGIgt8W6HZmouDngpntClfK
 Pd1vzV9EvAS9Z67irrPMPDuMIg==
X-Google-Smtp-Source: AGRyM1udZl9cYOZCTVRx2dP4aQ65DPh7kIknOz2yVcCQK0jjiEHNvsMvE3gxfKUp/+0eGVjssG4YBg==
X-Received: by 2002:aca:abc9:0:b0:335:796f:abba with SMTP id
 u192-20020acaabc9000000b00335796fabbamr920913oie.35.1656447584789; 
 Tue, 28 Jun 2022 13:19:44 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186]) by smtp.gmail.com with ESMTPSA id
 a12-20020a056870d60c00b000f30837129esm9536923oaq.55.2022.06.28.13.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 13:19:43 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: will@kernel.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
 robh+dt@kernel.org, adrian.hunter@intel.com, bhupesh.sharma@linaro.org,
 joro@8bytes.org, ulf.hansson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 robin.murphy@arm.com, agross@kernel.org
Subject: Re: (subset) [PATCH 4/4] ARM: dts: qcom: sdx65: Add Shared memory
 manager support
Date: Tue, 28 Jun 2022 15:19:11 -0500
Message-Id: <165644753307.10525.4712451269370492524.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1651480665-14978-5-git-send-email-quic_rohiagar@quicinc.com>
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651480665-14978-5-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
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

On Mon, 2 May 2022 14:07:45 +0530, Rohit Agarwal wrote:
> Add smem node to support shared memory manager on SDX65 platform.
> 
> 

Applied, thanks!

[4/4] ARM: dts: qcom: sdx65: Add Shared memory manager support
      commit: e378b965330d99e8622eb369021d0dac01591046

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
