Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED915C433DF
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 16:27:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CFE20658
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltF5tFRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CFE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 766E7887D3;
	Thu, 13 Aug 2020 16:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wLjL4G8PetvA; Thu, 13 Aug 2020 16:27:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D882C8877C;
	Thu, 13 Aug 2020 16:27:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C08D7C07FF;
	Thu, 13 Aug 2020 16:27:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBAC2C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 16:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B2718204D2
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 16:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o3UTsmEm8W8N for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 16:27:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 2B49F2048C
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 16:27:18 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id a15so5821146wrh.10
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i8A41jTFfKzD80jObOhia7RlfQfORZCQM0sSroioat0=;
 b=ltF5tFROgFAZgA5ykWdfcsD7a6IqKI1lHnkqk0uW8c1mUO/qzVluK8J1t8jmVU4Job
 +Vtmoin3OAPiYr73l3JEOUZ2gUWG37ta+25nQ1mYsZAe1/7npia4seT0uQnwwQMEYozf
 HfIw62D1Rw2pf0hw8IK2fApNoBdewGrJ4hMkkeVIkyeLNEO+zqe9XwTT+LvaIITCC1xv
 1xyi8enK2pWVuiyvYNl+LV1Nbe+j4UkavqT8Slf48jxAMw7lbGS2y6k/TeSnT1m1qkQ8
 UbQwWVqGIXGph/HTTeOyWh4MAQje6Nxo0grB6X9N0p8EBYF4hrSCRZEs/R2Kdx8WoFc6
 EwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i8A41jTFfKzD80jObOhia7RlfQfORZCQM0sSroioat0=;
 b=e/lfmjRob1anRBkQGAK9m7PR+w/sXk06nfdcnOQ5rXbrmEpd031I7YaLLWSxNnLanQ
 N2nRx/6VzRfz1d/pCXqkfnQhejtDrhIdNw6QF7NZ+OC7rRI1emdTzVOPAr0tysz3KO41
 fnpsS9gJB40mGw9jXUYx3+Jn42q7Wv0D9FXRoewBSGhxPNbDLoW9JGvmlPQqMUhzng25
 i18Y43+DOXrHbGlWaQInPddSH9ajxSS4ZU4kwnKxcUN/snoZTWFciMMN0vSi6qPiTa/1
 ORzu57alWhM7iABwxqamYhcEuHOO7z2QGZYGYKPBBeSM0/taPl3ItAfWkmUEECczcDQD
 tzuw==
X-Gm-Message-State: AOAM532wqSPYxgyyPkJi3AcsIZ2trB/1MMpMqHRm1+DN2jkgKEGV0ftK
 x0HqmNGCzdisC/YkMlk7XvM2v91jkyD7Ab3z2jo=
X-Google-Smtp-Source: ABdhPJzH/J7FP/7qCdkL8eeSCxCr1qpeQTRxwqPrMBjocRjU8savD+CGNSock5FfU9Bf2OHfq/Jig6M1BNJ0N1f/Sso=
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr4512119wrq.327.1597336036448; 
 Thu, 13 Aug 2020 09:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200810222657.1841322-5-jcrouse@codeaurora.org>
 <20200813131412.GB10256@willie-the-truck>
 <CAF6AEGuCubnXu7FKuCHPx0Bow4O7M8NSBThHDusev7xX6v2zQQ@mail.gmail.com>
 <20200813151934.GA10534@willie-the-truck>
In-Reply-To: <20200813151934.GA10534@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 13 Aug 2020 09:28:02 -0700
Message-ID: <CAF6AEGsfP14bJzdJP70YonM6J00+PAZVk2neURT3rb2+PcRNDg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v12 04/13] iommu: Add a domain attribute to
 get/set a pagetable configuration
To: Will Deacon <will@kernel.org>
Cc: freedreno <freedreno@lists.freedesktop.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Aug 13, 2020 at 8:19 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Aug 13, 2020 at 08:11:02AM -0700, Rob Clark wrote:
> > On Thu, Aug 13, 2020 at 6:14 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Aug 10, 2020 at 04:26:48PM -0600, Jordan Crouse wrote:
> > > > Add domain attribute DOMAIN_ATTR_PGTABLE_CFG. This will be used by
> > > > arm-smmu to share the current pagetable configuration with the
> > > > leaf driver and to allow the leaf driver to set up a new pagetable
> > > > configuration under certain circumstances.
> > > >
> > > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > > ---
> > > >
> > > >  include/linux/iommu.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > > index fee209efb756..995ab8c47ef2 100644
> > > > --- a/include/linux/iommu.h
> > > > +++ b/include/linux/iommu.h
> > > > @@ -118,6 +118,7 @@ enum iommu_attr {
> > > >       DOMAIN_ATTR_FSL_PAMUV1,
> > > >       DOMAIN_ATTR_NESTING,    /* two stages of translation */
> > > >       DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> > > > +     DOMAIN_ATTR_PGTABLE_CFG,
> > > >       DOMAIN_ATTR_MAX,
> > > >  };
> > >
> > > Nobody other than the adreno gpu uses this, so can we avoid exposing it
> > > in the IOMMU API, please? Given that you have a reference to the adreno
> > > GPU device in the SMMU implementation code thanks to .alloc_context_bank(),
> > > can you squirrel some function pointers away in the driver data (i.e. with
> > > dev_set_drvdata()) instead?
> > >
> >
> > Hmm, we are already using drvdata on the gpu side, and it looks like
> > arm-smmu is also using it.  Could we get away with stashing an extra
> > 'void *' in iommu_domain itself?
>
> What I meant was, expose the type of whatever you put in there on the GPU
> side so that the SMMU impl can install its function pointers into a field of
> that structure. As far as I'm concerned, the SMMU impl code and the GPU
> driver are the same entity and we should keep their communication private,
> rather than expose it up the stack. After all, the GPU writes to the SMMU
> registers!
>
> If you really don't want to expose all of your gubbins, I suppose you
> could have a structure just for the SMMU view and container_of() out of
> that on the GPU side.

yeah, msm_gpu has a lot of internal state.. but I suppose we could
define a 'struct adreno_smmu_priv' and embed that in msm_gpu, and
throw in a get_gpu_drvdata() type wrapper for get_drvdata() to make
this not totally horrible in the various cases places that use
get_drvdata() currently.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
