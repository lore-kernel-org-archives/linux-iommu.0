Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC55C433E6
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 19:15:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054C62176B
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 19:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJmJA7W5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054C62176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C7409860C1;
	Mon, 20 Jul 2020 19:15:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q9BGtPyG4MlT; Mon, 20 Jul 2020 19:15:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 186C986078;
	Mon, 20 Jul 2020 19:15:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC6B9C0894;
	Mon, 20 Jul 2020 19:15:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5538CC016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 19:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 49CDC86099
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 19:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7H_X9O24y9qt for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 19:15:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DE33286078
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 19:15:30 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id b25so21446510ljp.6
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yGuMBA6E/vSm7fl9LnRsgWtmLNKdkZvYC3YgUG3ZT8g=;
 b=RJmJA7W5oOjqJFVdkWOdkKw4KCvmxZoLIj2fe1jKEQ2dOqowzKMbVxdN1uTcALheHY
 jqfocGUaeo/HvsKf2ZfETJwZglRLBe3G7KJGfj5+WUUEi4oeIuB+Q6dZgQUQGKbNrAOs
 3HiYjMewU2YMJQEIN1iIeQtYwh4g4/yxOMjaJkV86/xZ6xgeCUA6qyL8Wd5g2pj1q4yH
 /LO2oBBTVpTj3NNEF4Szw/lPCunp/lDHf0EQv9eMY5S7aStOXoRrhHbOC6nVLIE1NyWK
 dIO2LGjIZLcn3a1eSGASK4SdFDSUkCQXB8pTFHqBk0iGhBRJL+u7OrpqPIJwpoDCnldt
 Bfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yGuMBA6E/vSm7fl9LnRsgWtmLNKdkZvYC3YgUG3ZT8g=;
 b=oC9vemBX3X++V2QJz5yyDDDysBIu0qzlYUAy4W9ENcCj9yuM9RmhiMmBsvd0xeWDpT
 cRzkOz0/tb93NNy4aWh14PMW7rE4ab+1FuoMvuuRTra8LVf+ha3c6d6Qwnr7HG92BtxR
 78qtNGhtvyTvmsy8F4tevK2UoxAvO7uv+ycrGQeNYulGGdeGs2Py9UwzbKmhTB4+Q0CE
 PBBkDY1LxXvO5xALwk3/9+ZygVoTAtmhxQmriQfwSGqsECYRa99+YXTrMh053gSx0fFB
 nTXL0zLVabb7moPXhXnyFJ7PwC/zHZ1rAVJhuLLQU8JnEQH21ulGJm4YKmFD42G03xtQ
 XmcA==
X-Gm-Message-State: AOAM531+sGJNo5Pu89PQktS07vHXh9gmvtwkqZFuByK9NHgOb/i1RKYi
 XSscpJ9ZB/brAmgHv5BJVTNLI1KvpJmuToYLrU5TLw==
X-Google-Smtp-Source: ABdhPJxE9oSCTvloFD99u6WWlvG9kBvUdWJlKwIcb/cWsJhbJKf6vlAc5sJipWaVlq/hYOfmMndIQpe7rHGmVmFrjBQ=
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr10560158ljj.102.1595272528694; 
 Mon, 20 Jul 2020 12:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200720155217.274994-1-robdclark@gmail.com>
In-Reply-To: <20200720155217.274994-1-robdclark@gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 21 Jul 2020 00:45:17 +0530
Message-ID: <CA+G9fYtj1RBYcPhXZRm-qm5ygtdLj1jD8vFZSqQvwi_DNJLBwQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/qcom: Use domain rather than dev as tlb cookie
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, 20 Jul 2020 at 21:21, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The device may be torn down, but the domain should still be valid.  Lets
> use that as the tlb flush ops cookie.
>
> Fixes a problem reported in [1]

This proposed fix patch applied on top of linux mainline master
and boot test PASS on db410c.

The reported problem got fixed.

>
> [1] https://lkml.org/lkml/2020/7/20/104
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> ---
> Note I don't have a good setup to test this atm, but I think it should
> work.
>
>  drivers/iommu/qcom_iommu.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index c3e1fbd1988c..d176df569af8 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -65,6 +65,7 @@ struct qcom_iommu_domain {
>         struct mutex             init_mutex; /* Protects iommu pointer */
>         struct iommu_domain      domain;
>         struct qcom_iommu_dev   *iommu;
> +       struct iommu_fwspec     *fwspec;
>  };
>
>  static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
> @@ -84,9 +85,9 @@ static struct qcom_iommu_dev * to_iommu(struct device *dev)
>         return dev_iommu_priv_get(dev);
>  }
>
> -static struct qcom_iommu_ctx * to_ctx(struct device *dev, unsigned asid)
> +static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
>  {
> -       struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
> +       struct qcom_iommu_dev *qcom_iommu = d->iommu;
>         if (!qcom_iommu)
>                 return NULL;
>         return qcom_iommu->ctxs[asid - 1];
> @@ -118,14 +119,12 @@ iommu_readq(struct qcom_iommu_ctx *ctx, unsigned reg)
>
>  static void qcom_iommu_tlb_sync(void *cookie)
>  {
> -       struct iommu_fwspec *fwspec;
> -       struct device *dev = cookie;
> +       struct qcom_iommu_domain *qcom_domain = cookie;
> +       struct iommu_fwspec *fwspec = qcom_domain->fwspec;
>         unsigned i;
>
> -       fwspec = dev_iommu_fwspec_get(dev);
> -
>         for (i = 0; i < fwspec->num_ids; i++) {
> -               struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
> +               struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
>                 unsigned int val, ret;
>
>                 iommu_writel(ctx, ARM_SMMU_CB_TLBSYNC, 0);
> @@ -139,14 +138,12 @@ static void qcom_iommu_tlb_sync(void *cookie)
>
>  static void qcom_iommu_tlb_inv_context(void *cookie)
>  {
> -       struct device *dev = cookie;
> -       struct iommu_fwspec *fwspec;
> +       struct qcom_iommu_domain *qcom_domain = cookie;
> +       struct iommu_fwspec *fwspec = qcom_domain->fwspec;
>         unsigned i;
>
> -       fwspec = dev_iommu_fwspec_get(dev);
> -
>         for (i = 0; i < fwspec->num_ids; i++) {
> -               struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
> +               struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
>                 iommu_writel(ctx, ARM_SMMU_CB_S1_TLBIASID, ctx->asid);
>         }
>
> @@ -156,16 +153,14 @@ static void qcom_iommu_tlb_inv_context(void *cookie)
>  static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>                                             size_t granule, bool leaf, void *cookie)
>  {
> -       struct device *dev = cookie;
> -       struct iommu_fwspec *fwspec;
> +       struct qcom_iommu_domain *qcom_domain = cookie;
> +       struct iommu_fwspec *fwspec = qcom_domain->fwspec;
>         unsigned i, reg;
>
>         reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
>
> -       fwspec = dev_iommu_fwspec_get(dev);
> -
>         for (i = 0; i < fwspec->num_ids; i++) {
> -               struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
> +               struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
>                 size_t s = size;
>
>                 iova = (iova >> 12) << 12;
> @@ -256,7 +251,9 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>         };
>
>         qcom_domain->iommu = qcom_iommu;
> -       pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, dev);
> +       qcom_domain->fwspec = fwspec;
> +
> +       pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_domain);
>         if (!pgtbl_ops) {
>                 dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
>                 ret = -ENOMEM;
> @@ -269,7 +266,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>         domain->geometry.force_aperture = true;
>
>         for (i = 0; i < fwspec->num_ids; i++) {
> -               struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
> +               struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
>
>                 if (!ctx->secure_init) {
>                         ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
> @@ -419,7 +416,7 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
>
>         pm_runtime_get_sync(qcom_iommu->dev);
>         for (i = 0; i < fwspec->num_ids; i++) {
> -               struct qcom_iommu_ctx *ctx = to_ctx(dev, fwspec->ids[i]);
> +               struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
>
>                 /* Disable the context bank: */
>                 iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);

-- 
Linaro LKFT
https://lkft.linaro.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
