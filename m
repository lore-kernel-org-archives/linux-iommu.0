Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D35C43334
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 00:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27E0F605A0;
	Mon,  6 Jun 2022 00:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FY9PLuQywRI1; Mon,  6 Jun 2022 00:55:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EE3B60093;
	Mon,  6 Jun 2022 00:55:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D552EC0032;
	Mon,  6 Jun 2022 00:55:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60842C002D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 22:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 413E38417D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 22:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CW1VpATTNi6U for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jun 2022 22:13:56 +0000 (UTC)
X-Greylist: delayed 00:07:31 by SQLgrey-1.8.0
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it
 [IPv6:2001:4b7a:2000:18::162])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2A258417A
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 22:13:55 +0000 (UTC)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl
 [94.209.165.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 93A3820569;
 Mon,  6 Jun 2022 00:06:19 +0200 (CEST)
Date: Mon, 6 Jun 2022 00:06:18 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID
 access behavior
Message-ID: <20220605220618.n6rkb6cfdzzgst3j@SoMainline.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
 <20220531155559.GB25502@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220531155559.GB25502@willie-the-truck>
X-Mailman-Approved-At: Mon, 06 Jun 2022 00:55:40 +0000
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>, jamipkettunen@somainline.org,
 iommu@lists.linux-foundation.org, martin.botka@somainline.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, Robin Murphy <robin.murphy@arm.com>,
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

On 2022-05-31 16:55:59, Will Deacon wrote:
> On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > 
> > As also stated in the arm-smmu driver, we must write the TCR before
> > writing the TTBRs, since the TCR determines the access behavior of
> > some fields.
> 
> Where is this stated in the arm-smmu driver?
> 
> > 
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > ---
> >  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> > index 1728d4d7fe25..75f353866c40 100644
> > --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> > +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> > @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
> >  			ctx->secure_init = true;
> >  		}
> >  
> > -		/* TTBRs */
> > -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> > -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
> > -				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
> > -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> > -
> >  		/* TCR */
> >  		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
> >  				arm_smmu_lpae_tcr2(&pgtbl_cfg));
> >  		iommu_writel(ctx, ARM_SMMU_CB_TCR,
> >  			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
> >  
> > +		/* TTBRs */
> > +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> > +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
> > +				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
> > +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> 
> I'd have thought that SCTLR.M would be clear here, so it shouldn't matter
> what order we write these in.

Having tested the series without this particular patch on 8976 (Sony
Loire Suzu), it doesn't seem to matter indeed.  I'll ask around if this
"access behaviour" was observed on a different board/platform.

- Marijn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
