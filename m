Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8C1C433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:43:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C99C61423
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C99C61423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BCBC8403C5;
	Tue, 16 Nov 2021 15:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zf1APnSb1dps; Tue, 16 Nov 2021 15:43:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4764940168;
	Tue, 16 Nov 2021 15:43:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22F3CC001E;
	Tue, 16 Nov 2021 15:43:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF687C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C054F80B71
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S1r4Cs4J7kMu for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 15:43:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB30D80B6D
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:43:35 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id m20so43978593edc.5
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5aVRsL9BgtWuBmT3ahZ2vhpwBbSn39kzECaSNgBwqKw=;
 b=c6X7kn2AIS1OZtKHSE0inktLzjU5KSCa/Nb8TqkJsa/pBXkM5v+Fv/W7SlBRWYzds4
 1OzuvsxfGBXNrAwZxTi1zPS99/9Y1OYaabugz6BcFZOOEUUorUxA7SxLfFB/5BBalCNU
 K5TvJd6/5TqQUzxYnlL05T/iQvSBoJT+Jgh/IGk1avf9+lfx5qR/OlqwUSkhKJcz/V1J
 NAdvpIOtwxQqD/7L1Z1LFEJEFU198X5LZYl/P101uGbR2oOAGeZOOIKFYoDgazHnmzfq
 3A12fIy/lPG7KwUNztHd34ZiPgZKPpUCtd7iwyc5a5x2FBqFiOyYQsDizIi+BPVuXPg4
 DMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5aVRsL9BgtWuBmT3ahZ2vhpwBbSn39kzECaSNgBwqKw=;
 b=1Wbyn5B3Nn+nXalb+UBHgPRoWGiikNYayWipbpVWTyvUfsOjbUnudMfCMpMwS7Io4D
 RT9Q+DfUAqTfaMb4/55l2OU6YSCaTUf+nmkHvuwb/7pm8m9Zvau4D+Xu6iHsJywMAYo2
 PXnX6bw2r73vnDVqeTHlRPMZB5SUVbkVYWmVw5Hx6rHU+02efyI5QX0Quk/3t06lsKxq
 BK/QlyaWkNH6hEgrzcmVBA0iY8c1bZMVPLVFs3FwpVItKGbiyGbsTAOeCMUJPY1poibE
 bKLQaEyA/Sows71vthn99eaQZR64K3n/eTcBXtReIr8YojD1d5aaZP5+nPN5oQwQeEkZ
 gxHw==
X-Gm-Message-State: AOAM530wezZeCF2QbZ4Zlj8hcO4LrRW9/u8dAebHWVeI1DoeBGDMQevw
 IDmmWmvpjAbyAcF+aJ0qfSQTAw==
X-Google-Smtp-Source: ABdhPJwi9H2HaoW1lVB301nRq/HD7R3uM+Gy4F0+t0NQ+v3dJyqfgmfCwqm49KVqXUeLazSns2evNA==
X-Received: by 2002:a50:e683:: with SMTP id z3mr11614453edm.206.1637077413955; 
 Tue, 16 Nov 2021 07:43:33 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id hd18sm8603095ejc.84.2021.11.16.07.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 07:43:33 -0800 (PST)
Date: Tue, 16 Nov 2021 15:43:12 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Add Arm SMMUv3 PMCG binding
Message-ID: <YZPRkOii110K6dr2@myrica>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
 <20211116113536.69758-2-jean-philippe@linaro.org>
 <1637071373.514426.3444644.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1637071373.514426.3444644.nullmailer@robh.at.kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, uchida.jun@socionext.com,
 leo.yan@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Tue, Nov 16, 2021 at 08:02:53AM -0600, Rob Herring wrote:
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml:24:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml:25:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.example.dt.yaml: example-0: pmu@2b420000:reg:0: [0, 725745664, 0, 4096] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.example.dt.yaml: example-0: pmu@2b420000:reg:1: [0, 725811200, 0, 4096] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.example.dt.yaml: example-0: pmu@2b440000:reg:0: [0, 725876736, 0, 4096] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.example.dt.yaml: example-0: pmu@2b440000:reg:1: [0, 725942272, 0, 4096] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1555758
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

Right I'll fix those, I had only run dtbs_check

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
