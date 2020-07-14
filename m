Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EF4C433E2
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 14:22:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5F522515
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 14:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmB0EueN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5F522515
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 449AF204F0;
	Tue, 14 Jul 2020 14:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M5BjEP0XRgWo; Tue, 14 Jul 2020 14:22:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D9E8C24804;
	Tue, 14 Jul 2020 14:22:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCC69C0888;
	Tue, 14 Jul 2020 14:22:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC744C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 14:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C924688423
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 14:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OYsHQcAN4zxO for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 14:22:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5F12D88410
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 14:22:56 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 23A1B22519
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594736576;
 bh=rd5OIlYx3b2juzE6QiM4oAmdyVKpLPJAqVO/kNES7eg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=PmB0EueNtgPHX2PIZw5HyzxDwaxVRzOwkSePCRZQxkefXAoStuJY3G5ocmAJHX+la
 yemTL8A5jKBcSxloLAbA443fa5XKv/kgtrnrPv0eGK30vnwYtNcS57d5TYFzXRwpMk
 4ojoqTORPROKHmG4o+HWInEO4xTKdJmcT20nSsSQ=
Received: by mail-oi1-f170.google.com with SMTP id 12so14050700oir.4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:22:56 -0700 (PDT)
X-Gm-Message-State: AOAM531wxvgZ/dXjdgnk8HERV0aurI0Kqvw+kaMbZmRv96jsSBWlQBc1
 dT3h5DYXowxjMYI5ra+JRVTYCOgYI1YQVkN5VQ==
X-Google-Smtp-Source: ABdhPJy6ZkarJ5J32IIpIQEGE/Wjp/cSwpg14EGOzfNSeRzwriu/1T8mkB7ZW+5hPoMCr1+/ya+Nb4Ie4kq7OvbrRc8=
X-Received: by 2002:aca:bb82:: with SMTP id l124mr3965827oif.106.1594736575478; 
 Tue, 14 Jul 2020 07:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-5-vdumpa@nvidia.com>
 <20200709201348.GA808454@bogus>
 <BYAPR12MB2822514F93F831507A811EE9B3650@BYAPR12MB2822.namprd12.prod.outlook.com>
 <c2ab2a0d-419d-555f-c124-2cfa1ecb2a81@arm.com>
In-Reply-To: <c2ab2a0d-419d-555f-c124-2cfa1ecb2a81@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 14 Jul 2020 08:22:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKg4CfGPxf-SzVevCaY0NU63oR+pqSqdV0aG+EaecGbvg@mail.gmail.com>
Message-ID: <CAL_JsqKg4CfGPxf-SzVevCaY0NU63oR+pqSqdV0aG+EaecGbvg@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] dt-bindings: arm-smmu: add binding for Tegra194
 SMMU
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Pritesh Raithatha <praithatha@nvidia.com>,
 Bryan Huntsman <bhuntsman@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Bitan Biswas <bbiswas@nvidia.com>
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

On Mon, Jul 13, 2020 at 8:10 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-07-10 21:29, Krishna Reddy wrote:
> > Thanks Rob. One question on setting "minItems: ". Please see below.
> >
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - nvidia,tegra194-smmu
> >>> +    then:
> >>> +      properties:
> >>> +        reg:
> >>> +          minItems: 2
> >>> +          maxItems: 2
> >
> >> This doesn't work. The main part of the schema already said there's only
> >> 1 reg region. This part is ANDed with that, not an override. You need to add an else clause with 'maxItems: 1' and change the base schema to
> >> {minItems: 1, maxItems: 2}.
> >
> > As the earlier version of base schema doesn't have "minItems: " set, should it be set to 0 for backward compatibility?  Or can it just be omitted setting in base schema as before?
>
> We've always needed at least 1 "reg" specifier in practice, so I don't
> think being backwards-compatible with broken DTs is a concern :)

'minItems: 0' would be a boolean (e.g. "reg;") and I'm not sure that's
even really valid json-schema. What you'd want here is 'reg' not
present (i.e. not in 'required').

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
