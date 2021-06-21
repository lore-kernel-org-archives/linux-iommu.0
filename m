Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A2C4743C
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 15:54:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4E961151
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 15:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4E961151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44DA26070C;
	Mon, 21 Jun 2021 15:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lKOPNVKZKb5l; Mon, 21 Jun 2021 15:54:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 14C72606DA;
	Mon, 21 Jun 2021 15:54:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3510C0010;
	Mon, 21 Jun 2021 15:54:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BFEFC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 15:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27D3A401F8
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 15:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4DMvwUnhc-8E for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 15:54:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49DAD40107
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 15:54:25 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CF3C60FD8;
 Mon, 21 Jun 2021 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624290864;
 bh=JhMpx8Btj48mWJ1v62+IDUgjcau8pNUf2ATlJwM7KBc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JMMs3rcvrsK6Z8kam8EVgcWu+GQKGhDR9FObycLAaG/aS4SCnAcqUM/2XiMFB1DYL
 8S1RnbRWfKUGHN2KIX0RQ4c6q3pd9E9Xhba3+ilZRxI94D64gtUArchgmHp2e6FPor
 tDlXWzIPVEWMfVlFBqexX70nTMpt+Vwcj8enWL5xrqoxvCMAklMQ5YYDytS8p+yeVD
 nx7JH2MTvTKFBonRqhi+V5BYQbRH//saxNr+22NE8sH7b9H67EmEUoOfcivN+gQF8q
 3K92tPk2GcUOgB6AgBpZ1BWcb41IcONtN5s6rCK9SG5O7IgPXYsgCMQHb6Ap3+uOlm
 NULHbwM2QXj8w==
Date: Mon, 21 Jun 2021 16:54:18 +0100
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: arm-smmu: Add Tegra186 compatible
 string
Message-ID: <20210621155418.GA29488@willie-the-truck>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
 <20210603164632.1000458-3-thierry.reding@gmail.com>
 <CAL_JsqLDKxwANn2Pba0Db6J9337pK0dNL=bBN8ucn-k4DZ3gyg@mail.gmail.com>
 <14551e79-853d-471f-bb5e-0d2d6581a9b6@canonical.com>
 <YNCeK9cdMPf+serd@orome.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNCeK9cdMPf+serd@orome.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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

On Mon, Jun 21, 2021 at 04:11:55PM +0200, Thierry Reding wrote:
> On Mon, Jun 21, 2021 at 08:46:54AM +0200, Krzysztof Kozlowski wrote:
> > On 18/06/2021 21:47, Rob Herring wrote:
> > > On Thu, Jun 3, 2021 at 10:49 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > >> index 9d27aa5111d4..1181b590db71 100644
> > >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > >> @@ -54,8 +54,14 @@ properties:
> > >>            - const: arm,mmu-500
> > >>        - description: NVIDIA SoCs that program two ARM MMU-500s identically
> > >>          items:
> > >> +      - description: NVIDIA SoCs that require memory controller interaction
> > > 
> > > This is not valid jsonschema:
> > > 
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
> > > properties:compatible:oneOf:4:items: 'anyOf' conditional failed, one
> > > must be fixed:
> > > None is not of type 'object', 'boolean'
> > > None is not of type 'array'
> > > from schema $id: http://json-schema.org/draft-07/schema#
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
> > > properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
> > > must be fixed:
> > > None is not of type 'object'
> > > None is not of type 'array'
> > > from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
> > > properties:compatible:oneOf:4:items: 'oneOf' conditional failed, one
> > > must be fixed:
> > > None is not of type 'object'
> > > None is not of type 'array'
> > > from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/iommu/arm,smmu.yaml:
> > > properties:compatible:oneOf:5:items: 'oneOf' conditional failed, one
> > > must be fixed:
> > > [{'enum': [{'const': 'nvidia,tegra194-smmu'}, {'const':
> > > 'nvidia,tegra186-smmu'}]}, {'const': 'nvidia,smmu-500'}] is not of
> > > type 'object'
> > > {'const': 'nvidia,tegra194-smmu'} is not of type 'string'
> > > {'const': 'nvidia,tegra186-smmu'} is not of type 'string'
> > > from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> > > 
> > > 
> > > This was not reviewed nor tested since the DT list was not Cc'ed.
> > 
> > Ugh, I see now weird empty item on a list... and not only DT list was
> > skipped - Thierry did not Cc you either.
> 
> This seemed like a too trivial addition to waste Rob's time on, so I
> didn't add him (or the DT list for that matter) on Cc. The ARM SMMU
> maintainers had reviewed this, which seemed like it was enough for what
> the DT bindings change was doing.

Hmm, I didn't review it. I find the yaml stuff unreadable so I usually
wait for the DT folks to ack bindings changes before I queue them in the
SMMU tree.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
