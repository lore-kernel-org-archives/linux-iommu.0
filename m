Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70518C433E6
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:14:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDAA23437
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDAA23437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CDB3D87092;
	Fri, 22 Jan 2021 13:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Lcv9EjWgOdX; Fri, 22 Jan 2021 13:14:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 653B287079;
	Fri, 22 Jan 2021 13:14:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D5C7C08A1;
	Fri, 22 Jan 2021 13:14:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2FDFC013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AF41C87079
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k+tKH0yyoLzJ for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:14:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 926608692C
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:14:54 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67637223C8;
 Fri, 22 Jan 2021 13:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611321294;
 bh=aUNv5OQ3ojub5SgRUon07BSPkAi4qHPQy3X9xJmVeB4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BZ+pQP5nmlTsL6cfqqrg4vVEXsHM3mef5BJenNV8tLkjscSu8oIDUuSwU1XFX4yI2
 8CjOmtlWnOYht8UKRPWKt3fWdEukdWxqXjLzIpdpfu6Qmzj1ne5TMeV6+KVNuKm+6V
 3IdapU83G4pXT6Bt91Uf13rQLY/nC1QhJu5TcYLk4zokt2894YpnQRe85Ffcgv4LFE
 eNf/29Gf6IQVkadsqAf6EamffaNEyT9Adrr04IkNjcU8hmc7lbg8GtXM6ENaccvaWt
 XG4btFP3rhSDuWCTspUiMdglCq8Ali8jtJUD1YDWlp0KqnGeaFMLi9Z/pDO3741k87
 pQ2CUMMUzyrRw==
Date: Fri, 22 Jan 2021 13:14:49 +0000
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add binding for Qcom SDX55 SMMU
Message-ID: <20210122131448.GE24102@willie-the-truck>
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
 <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
 <20210113032223.GA1467511@robh.at.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210113032223.GA1467511@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Vinod Koul <vkoul@kernel.org>,
 robh+dt@kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Tue, Jan 12, 2021 at 09:22:23PM -0600, Rob Herring wrote:
> On Thu, 07 Jan 2021 20:01:18 +0530, Manivannan Sadhasivam wrote:
> > Add devicetree binding for Qualcomm SDX55 SMMU.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

Is there another patch adding driver support for matching this new binding?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
