Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95117C48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 19:48:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296786128C
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 19:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296786128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DEB5B4011B;
	Fri, 18 Jun 2021 19:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jf9PSF54Oc0z; Fri, 18 Jun 2021 19:48:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BAC48400C0;
	Fri, 18 Jun 2021 19:48:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F4A5C000D;
	Fri, 18 Jun 2021 19:48:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D1C4C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 19:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9CFE605CE
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 19:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SFr3cf4DQyRv for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 19:48:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FD93605D9
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 19:48:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF7F4613D1
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 19:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624045691;
 bh=qkc2MGqHvyVub+dZlUlMfi1Ge8BQxPm0xrrh4ob2XuQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UvBXGpsCp4GW2OXicEqRgt1naVvarBwoMXPrd0uoEna1yVXUvQvJYhNXWIkPuyC50
 /nsrsENo9dEmMXiyhQa+Ru7REIc760yyNX39bjmShonUWwfaH/SSa+21d9sRs+d3id
 +83vyUUHNWVG8Y50m8vEQw07K0Q67hUkx1PK/g5pEidQngjffg15xBJ1Ik/mQGEUs7
 4V9d2FrvdrEL7Pby7/QAF5MqPq8ATPDrMnPVzr65EyTH96vTM8DDrbRmq3ugwkceKB
 hFNNw4dhCX7WcXu862CNnHK0lQbopHAYIFAjQKDacAZpF3MKmU5xF984C3svs7Nzpy
 zmcHRmXvyDE4w==
Received: by mail-ed1-f54.google.com with SMTP id t7so10101299edd.5
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 12:48:11 -0700 (PDT)
X-Gm-Message-State: AOAM530N8MctjFyPzZx4neiXqZwWg3RvgqvS/Q84IkwOUubjNRuf7Hov
 hEC28p6EaHd8C6C9JKZpNa/XpOx+isTuqrk+Rg==
X-Google-Smtp-Source: ABdhPJw1eLcJOIk68SqoUPZvUGfPSxyK19pxr4bmx3ZN67yWYW4HyzECYtMFKa8UGYfyjdFuPr6pihmA0/bbVI3Vg40=
X-Received: by 2002:aa7:cac9:: with SMTP id l9mr7102053edt.373.1624045690409; 
 Fri, 18 Jun 2021 12:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
 <20210603164632.1000458-3-thierry.reding@gmail.com>
In-Reply-To: <20210603164632.1000458-3-thierry.reding@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 18 Jun 2021 13:47:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLDKxwANn2Pba0Db6J9337pK0dNL=bBN8ucn-k4DZ3gyg@mail.gmail.com>
Message-ID: <CAL_JsqLDKxwANn2Pba0Db6J9337pK0dNL=bBN8ucn-k4DZ3gyg@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: arm-smmu: Add Tegra186 compatible
 string
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Jon Hunter <jonathanh@nvidia.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Thu, Jun 3, 2021 at 10:49 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> The ARM SMMU instantiations found on Tegra186 and later need inter-
> operation with the memory controller in order to correctly program
> stream ID overrides.
>
> Furthermore, on Tegra194 multiple instances of the SMMU can gang up
> to achieve higher throughput. In order to do this, they have to be
> programmed identically so that the memory controller can interleave
> memory accesses between them.
>
> Add the Tegra186 compatible string to make sure the interoperation
> with the memory controller can be enabled on that SoC generation.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9d27aa5111d4..1181b590db71 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -54,8 +54,14 @@ properties:
>            - const: arm,mmu-500
>        - description: NVIDIA SoCs that program two ARM MMU-500s identically
>          items:
> +      - description: NVIDIA SoCs that require memory controller interaction

This is not valid jsonschema:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
properties:compatible:oneOf:4:items: 'anyOf' conditional failed, one
must be fixed:
None is not of type 'object', 'boolean'
None is not of type 'array'
from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
must be fixed:
None is not of type 'object'
None is not of type 'array'
from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
must be fixed:
None is not of type 'object'
None is not of type 'array'
from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
properties:compatible:oneOf:5:items: 'oneOf' conditional failed, one
must be fixed:
[{'enum': [{'const': 'nvidia,tegra194-smmu'}, {'const':
'nvidia,tegra186-smmu'}]}, {'const': 'nvidia,smmu-500'}] is not of
type 'object'
{'const': 'nvidia,tegra194-smmu'} is not of type 'string'
{'const': 'nvidia,tegra186-smmu'} is not of type 'string'
from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#


This was not reviewed nor tested since the DT list was not Cc'ed.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
