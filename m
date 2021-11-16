Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8440CC433F5
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 14:03:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA4B61BE6
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 14:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BA4B61BE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1D6740432;
	Tue, 16 Nov 2021 14:03:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Go8zHoh4dj-Z; Tue, 16 Nov 2021 14:03:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 44C474020D;
	Tue, 16 Nov 2021 14:03:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1693EC001E;
	Tue, 16 Nov 2021 14:03:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B029C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 14:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B2DE60726
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 14:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z0MNAh6Y9hcM for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:03:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3CD5C606F2
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 14:03:01 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 w30-20020a4a355e000000b002c2649b8d5fso7242293oog.10
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 06:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=aRxOvxuYhfSjyyWHzEXHeQoimCcPflvJ9I7H8ssvLL8=;
 b=Qwq0z50hJqOzmfpbuyEjKdTek91Imyv6wZd0onE+6cApcO82yE7ftHcsWOSsJJiZ/E
 kxtRjX+PZRtB1uO7okbsNpc9tbSKyda6GD1E5Oss2oPwJhLo1x6yK768f7uwF2zhQDD1
 hLe+hV3QrPpbxWLTsBM4ATb8dkuVmu1NsczEKO/w8HnF0GgJPX80G7+aVyD2HQaEZ+fe
 kPTOqlsPHH7fIgcgD+FWubuzhIYuWRv754V9lKyeVYj7VuD4wABYv0bk+r3wWLiEj2K4
 Mw6JJfGOTAMbqOdkuh5lS+jBKOcqIMzDZ1TZLzM0yBXXnqDjjIJsDv//6iBeHmrgPBNN
 r8bw==
X-Gm-Message-State: AOAM531gL6tIsitccdDrT3ERbksn5oCtSKhtn3dE2wp2AjG44tOI2+3V
 41ENvhhP+JJm+HfzSobGBQ==
X-Google-Smtp-Source: ABdhPJyZgLhINqHQgKbvpIWeu7RfnoRggYC8kVxIjFnwsU5FGCNQJWnfPucnXss8XrvmGzjMmuFQew==
X-Received: by 2002:a4a:d00a:: with SMTP id h10mr3888859oor.60.1637071380162; 
 Tue, 16 Nov 2021 06:03:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id v19sm3627393ott.13.2021.11.16.06.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 06:02:59 -0800 (PST)
Received: (nullmailer pid 3444645 invoked by uid 1000);
 Tue, 16 Nov 2021 14:02:53 -0000
From: Rob Herring <robh@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
In-Reply-To: <20211116113536.69758-2-jean-philippe@linaro.org>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
 <20211116113536.69758-2-jean-philippe@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: Add Arm SMMUv3 PMCG binding
Date: Tue, 16 Nov 2021 08:02:53 -0600
Message-Id: <1637071373.514426.3444644.nullmailer@robh.at.kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 16 Nov 2021 11:35:36 +0000, Jean-Philippe Brucker wrote:
> Add binding for the Arm SMMUv3 PMU. Each node represents a PMCG, and is
> placed as a sibling node of the SMMU. Although the PMCGs registers may
> be within the SMMU MMIO region, they are separate devices, and there can
> be multiple PMCG devices for each SMMU (for example one for the TCU and
> one for each TBU).
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  .../bindings/iommu/arm,smmu-v3-pmcg.yaml      | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml:24:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml:25:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.example.dt.yaml: example-0: pmu@2b420000:reg:0: [0, 725745664, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.example.dt.yaml: example-0: pmu@2b420000:reg:1: [0, 725811200, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.example.dt.yaml: example-0: pmu@2b440000:reg:0: [0, 725876736, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.example.dt.yaml: example-0: pmu@2b440000:reg:1: [0, 725942272, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1555758

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
