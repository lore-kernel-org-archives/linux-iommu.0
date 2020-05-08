Return-Path: <SRS0=CQae=6W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97EDC47257
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 15:32:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A173021841
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 15:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO3PI6ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A173021841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5CB4D8762B;
	Fri,  8 May 2020 15:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rd7XdFFM2dsu; Fri,  8 May 2020 15:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B058A875D9;
	Fri,  8 May 2020 15:32:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EADBC0865;
	Fri,  8 May 2020 15:32:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B25CDC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 15:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9DB7E875EA
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 15:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HOvdvj7vTPDU for <iommu@lists.linux-foundation.org>;
 Fri,  8 May 2020 15:32:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 26181875D9
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 15:32:30 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id n17so1547183ejh.7
 for <iommu@lists.linux-foundation.org>; Fri, 08 May 2020 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GTz5l0c00hn6EnFjS5uVptjSE/ldgre8O5ShnulBHJM=;
 b=AO3PI6cefQSmPY9BgmqyKwHSBzaduMYzVaTdFLkqa1efLEjNVN0/u65uQJMDpCBIX3
 51zgKzcQzha+y6a7/OPfRXbr6m5R3VZIGkRkyTDGYpwMb9ECK4bvbMZ+I27CNLdLRx2F
 /L36lYnM+Jq+IapA90rdEI3gOI4L3lxmsVQOXfIVklcUVPeHUY3/H9D1d4mIBDkNiIU9
 bagZT/tZj6HuIh2pldNQ/3lRVSnEFjbyTjybV8POU8uwTdVqVCb8cSKFnIB3pmdiTvm1
 rCAQLwWDd+jK0407FPY3RGYnxPBMz4sNO7Vaec1et5f5T8f3vYyj4bQZPX/GYmSL1TmQ
 ac+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GTz5l0c00hn6EnFjS5uVptjSE/ldgre8O5ShnulBHJM=;
 b=M+UvYVJ7tK7ulzUBESuT2wrftLQt0MIRw6BOzYlxgilS+EhFFO/BBUy2XleymiP5qi
 dMZzayYkijykTMmnq6J0+Rh0dqpCKpgs0Q79fRjwamRodo1PHSSZGzhrsKwlhWNvKGTc
 0uftMCV/cbW1vh6igT9nkdWJkl4TcMxfd74Oe8fK13eOCqyV0pSfYxO06/TWy4NQ47oX
 pfjelYjiVP46aWI1F6LOb9B8s4suQd56U96V9CqL3RuN5lCy302znM8iNqu3UejLLMoF
 LYDSseXk2uwEGjOLqyalI+I8TzYmGPguI+Xmnfud89OwYU+SEIwF6LwejIeaYAvKwl/j
 LHJQ==
X-Gm-Message-State: AGi0PuZ1fNYb5yC5UdWOX1GkjVlbRIfQlGESla1pPltch2WireWi5YAb
 jCv6Ll+4vuLZwfpS5uk0Pc6vjFRLzozbTrKvnqw=
X-Google-Smtp-Source: APiQypJyshfUHi9pIvxw9h4TZSugZC/AW7KiccDfzWF16matIJfx7xWHDYc2iaGC9dsLuUF9c5YEOslnCiicxndfdLU=
X-Received: by 2002:a17:906:2503:: with SMTP id
 i3mr2165613ejb.293.1588951948487; 
 Fri, 08 May 2020 08:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
 <b491e02ad790a437115fdeab6b21bc48@codeaurora.org>
 <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
 <20200507125357.GA31783@willie-the-truck>
In-Reply-To: <20200507125357.GA31783@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 8 May 2020 08:32:45 -0700
Message-ID: <CAF6AEGuLU+_qP8HNO1s9PTPHqJnCMHzehmcT8NiJhiAwrfSH6w@mail.gmail.com>
Subject: Re: [PATCH] iomm/arm-smmu: Add stall implementation hook
To: Will Deacon <will@kernel.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Thu, May 7, 2020 at 5:54 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, May 07, 2020 at 11:55:54AM +0100, Robin Murphy wrote:
> > On 2020-05-07 11:14 am, Sai Prakash Ranjan wrote:
> > > On 2020-04-22 01:50, Sai Prakash Ranjan wrote:
> > > > Add stall implementation hook to enable stalling
> > > > faults on QCOM platforms which supports it without
> > > > causing any kind of hardware mishaps. Without this
> > > > on QCOM platforms, GPU faults can cause unrelated
> > > > GPU memory accesses to return zeroes. This has the
> > > > unfortunate result of command-stream reads from CP
> > > > getting invalid data, causing a cascade of fail.
> >
> > I think this came up before, but something about this rationale doesn't add
> > up - we're not *using* stalls at all, we're still terminating faulting
> > transactions unconditionally; we're just using CFCFG to terminate them with
> > a slight delay, rather than immediately. It's really not clear how or why
> > that makes a difference. Is it a GPU bug? Or an SMMU bug? Is this reliable
> > (or even a documented workaround for something), or might things start
> > blowing up again if any other behaviour subtly changes? I'm not dead set
> > against adding this, but I'd *really* like to have a lot more confidence in
> > it.
>
> Rob mentioned something about the "bus returning zeroes" before, but I agree
> that we need more information so that we can reason about this and maintain
> the code as the driver continues to change. That needs to be a comment in
> the driver, and I don't think "but android seems to work" is a good enough
> justification. There was some interaction with HUPCF as well.

The issue is that there are multiple parallel memory accesses
happening at the same time, for example CP (the cmdstream processor)
will be reading ahead and setting things up for the next draw or
compute grid, in parallel with some memory accesses from the shader
which could trigger a fault.  (And with faults triggered by something
in the shader, there are *many* shader threads running in parallel so
those tend to generate a big number of faults at the same time.)

We need either CFCFG or HUPCF, otherwise what I have observed is that
while the fault happens, CP's memory access will start returning
zero's instead of valid cmdstream data, which triggers a GPU hang.  I
can't say whether this is something unique to qcom's implementation of
the smmu spec or not.

*Often* a fault is the result of the usermode gl/vk/cl driver bug,
although I don't think that is an argument against fixing this in the
smmu driver.. I've been carrying around a local patch to set HUPCF for
*years* because debugging usermode driver issues is so much harder
without.  But there are some APIs where faults can be caused by the
user's app on top of the usermode driver.


BR,
-R

>
> As a template, I'd suggest:
>
> > > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > > index 8d1cd54d82a6..d5134e0d5cce 100644
> > > > --- a/drivers/iommu/arm-smmu.h
> > > > +++ b/drivers/iommu/arm-smmu.h
> > > > @@ -386,6 +386,7 @@ struct arm_smmu_impl {
> > > >      int (*init_context)(struct arm_smmu_domain *smmu_domain);
> > > >      void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
> > > >               int status);
>
> /*
>  * Stall transactions on a context fault, where they will be terminated
>  * in response to the resulting IRQ rather than immediately. This should
>  * pretty much always be set to "false" as stalling can introduce the
>  * potential for deadlock in most SoCs, however it is needed on Qualcomm
>  * XXXX because YYYY.
>  */
>
> > > > +    bool stall;
>
> Hmm, the more I think about this, the more I think this is an erratum
> workaround in disguise, in which case this could be better named...
>
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
