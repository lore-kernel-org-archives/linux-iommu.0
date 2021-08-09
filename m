Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FF1C4320A
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 16:52:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271E560F8F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 16:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 271E560F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D68DA8300C;
	Mon,  9 Aug 2021 16:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a3cAXAFRQ1qr; Mon,  9 Aug 2021 16:52:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BEB9482796;
	Mon,  9 Aug 2021 16:52:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77A89C0010;
	Mon,  9 Aug 2021 16:52:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6F29C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 16:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E95B60632
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 16:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f4Hzz6mX42Dw for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 16:52:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B970F6062D
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 16:52:54 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id c9so22285224wri.8
 for <iommu@lists.linux-foundation.org>; Mon, 09 Aug 2021 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2L7Xy+kSkSB8kPBmIgw8tzfzAzeFGsrynvKM4ncobGg=;
 b=X9+0wF2GaQ7raosWSwV5iH/q+LeWIwvCWz2IaaE74LjXgHsBzH0N2oMvKWCCUPUI2v
 QvnXtiMI/URrt6JkXvSomugHApm3fFv5CTUEO8CByeqntudTGtq6flenWU/iFH7bmslv
 xazckccAGsQcUoD0I/hdLb0sydlhEhqBG0tVtq0UKp3as90BLY0LI4274JK2oqQ+RZns
 oeGC3VT6ZHBMVhiifzgcIolMfka6YwlkJrKdfHyx2DtJKochxNh3Ft1l1BVcEJBufZN1
 xGoMQYGN3wMXLJnSxYARL18Mpu4s3q+Y8ul4/fMG59sx+AlsKnc/Er1fmMwEQwGm6Qwn
 lPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2L7Xy+kSkSB8kPBmIgw8tzfzAzeFGsrynvKM4ncobGg=;
 b=NIGiiMb6eIxTdbWGlFkfwkTNo8oTLAWzNy8oExX8DXB1SqpNp+V0ADG8Y2V5+nxvZo
 5G3T08F6bN4o/ciy1o+UHtnfXuyVsMit44woUnjpVoD1aALIit8YaCK08v2hpympQjWx
 e4Q0EcfyDpHRINRwNrrkD9LaA+yDyFMe5wLNgeXG2hUvWj0MFhJ2UV5Ibvv8cxu5z08n
 HdMM/QJcM0sy9TV6S79luqXrVVDIge0yJazcWuRfS+SBpOOl7yVsoa0uj5bNnIVbFiaO
 4v+gVcrim5n8xqHK/bHogORaqeUhKqK3CQFB+F1nSB/W5IO+InqUFYEIPbo7idBqNzFB
 NkRw==
X-Gm-Message-State: AOAM531nonWBsxW6bswRKXcAG5RRFEpLrwLTrFOxBjzQ6GXS7YHKW0qP
 xR5dgCWxGvhhtxE3ONJ6OnM3mq5oGotUvgt8SPY=
X-Google-Smtp-Source: ABdhPJy6ue4KJGDE546ehJ8INdeemYfG8Io5+/EyyprVgfEQ9kTzuxHWC5wcNwTW8rcvqKRArNanUuaOU/l04vSEgs0=
X-Received: by 2002:a5d:504d:: with SMTP id h13mr25875481wrt.132.1628527972734; 
 Mon, 09 Aug 2021 09:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210728140052.GB22887@mms-0441>
 <8b2742c8891abe4fec3664730717a089@codeaurora.org>
 <20210802105544.GA27657@willie-the-truck>
 <CAF6AEGvtpFu8st=ZFNoKjP9YsAenciLxL1zMFi_iqMCvdby73w@mail.gmail.com>
 <20210802151409.GE28735@willie-the-truck>
 <CAF6AEGtzvyEUm0Fc8QT5t9KNK7i0FbFyi7zDM2_PMCzZBp7qbw@mail.gmail.com>
 <20210809145651.GC1458@willie-the-truck>
In-Reply-To: <20210809145651.GC1458@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 9 Aug 2021 09:57:08 -0700
Message-ID: <CAF6AEGsSUojA=V0n2iRWTCn++buqN=Eoxo0r3=+=PBu1O=H-AQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 0/3] iommu/drm/msm: Allow non-coherent masters
 to use system cache
To: Will Deacon <will@kernel.org>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Kristian H Kristensen <hoegsberg@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sean Paul <sean@poorly.run>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Aug 9, 2021 at 7:56 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Aug 02, 2021 at 06:36:04PM -0700, Rob Clark wrote:
> > On Mon, Aug 2, 2021 at 8:14 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Aug 02, 2021 at 08:08:07AM -0700, Rob Clark wrote:
> > > > On Mon, Aug 2, 2021 at 3:55 AM Will Deacon <will@kernel.org> wrote:
> > > > >
> > > > > On Thu, Jul 29, 2021 at 10:08:22AM +0530, Sai Prakash Ranjan wrote:
> > > > > > On 2021-07-28 19:30, Georgi Djakov wrote:
> > > > > > > On Mon, Jan 11, 2021 at 07:45:02PM +0530, Sai Prakash Ranjan wrote:
> > > > > > > > commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
> > > > > > > > removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
> > > > > > > > the memory type setting required for the non-coherent masters to use
> > > > > > > > system cache. Now that system cache support for GPU is added, we will
> > > > > > > > need to set the right PTE attribute for GPU buffers to be sys cached.
> > > > > > > > Without this, the system cache lines are not allocated for GPU.
> > > > > > > >
> > > > > > > > So the patches in this series introduces a new prot flag IOMMU_LLC,
> > > > > > > > renames IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
> > > > > > > > and makes GPU the user of this protection flag.
> > > > > > >
> > > > > > > Thank you for the patchset! Are you planning to refresh it, as it does
> > > > > > > not apply anymore?
> > > > > > >
> > > > > >
> > > > > > I was waiting on Will's reply [1]. If there are no changes needed, then
> > > > > > I can repost the patch.
> > > > >
> > > > > I still think you need to handle the mismatched alias, no? You're adding
> > > > > a new memory type to the SMMU which doesn't exist on the CPU side. That
> > > > > can't be right.
> > > > >
> > > >
> > > > Just curious, and maybe this is a dumb question, but what is your
> > > > concern about mismatched aliases?  I mean the cache hierarchy on the
> > > > GPU device side (anything beyond the LLC) is pretty different and
> > > > doesn't really care about the smmu pgtable attributes..
> > >
> > > If the CPU accesses a shared buffer with different attributes to those which
> > > the device is using then you fall into the "mismatched memory attributes"
> > > part of the Arm architecture. It's reasonably unforgiving (you should go and
> > > read it) and in some cases can apply to speculative accesses as well, but
> > > the end result is typically loss of coherency.
> >
> > Ok, I might have a few other sections to read first to decipher the
> > terminology..
> >
> > But my understanding of LLC is that it looks just like system memory
> > to the CPU and GPU (I think that would make it "the point of
> > coherence" between the GPU and CPU?)  If that is true, shouldn't it be
> > invisible from the point of view of different CPU mapping options?
>
> You could certainly build a system where mismatched attributes don't cause
> loss of coherence, but as it's not guaranteed by the architecture and the
> changes proposed here affect APIs which are exposed across SoCs, then I
> don't think it helps much.
>

Hmm, the description of the new mapping flag is that it applies only
to transparent outer level cache:

+/*
+ * Non-coherent masters can use this page protection flag to set cacheable
+ * memory attributes for only a transparent outer level of cache, also known as
+ * the last-level or system cache.
+ */
+#define IOMMU_LLC      (1 << 6)

But I suppose we could call it instead IOMMU_QCOM_LLC or something
like that to make it more clear that it is not necessarily something
that would work with a different outer level cache implementation?

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
