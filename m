Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A9C433E4
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 15:19:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2365207DA
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIiIBqmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2365207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A040D24991;
	Thu, 13 Aug 2020 15:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hax-AgfyCn7; Thu, 13 Aug 2020 15:19:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 99FB723524;
	Thu, 13 Aug 2020 15:19:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EBEBC013C;
	Thu, 13 Aug 2020 15:19:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E24CC004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 15:19:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1C16224991
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 15:19:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XYnNjx4Ca1EI for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 15:19:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id C9F3B23524
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 15:19:40 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 026FC2078D;
 Thu, 13 Aug 2020 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597331980;
 bh=GUc3HeAnqqqqlsdI+PNr6Cgi6V9dzbFIkHuID4DZjzI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DIiIBqmnUPBmVeIvv4yjwhCDacHmHrEQHVUbgeg0ZB6vwx9bcaF4avc9PMhdS9tg4
 wmCpHDJVgeI8xWGlbAsKPNVAc5v0lwU9azqZ/Cj7xf41op7j3POQ+qqgoptGJcOgzS
 EkqphfYghJlApnHGgR4tE/oV7hq+0yoT9qJoTrJI=
Date: Thu, 13 Aug 2020 16:19:35 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [Freedreno] [PATCH v12 04/13] iommu: Add a domain attribute to
 get/set a pagetable configuration
Message-ID: <20200813151934.GA10534@willie-the-truck>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200810222657.1841322-5-jcrouse@codeaurora.org>
 <20200813131412.GB10256@willie-the-truck>
 <CAF6AEGuCubnXu7FKuCHPx0Bow4O7M8NSBThHDusev7xX6v2zQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGuCubnXu7FKuCHPx0Bow4O7M8NSBThHDusev7xX6v2zQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Thu, Aug 13, 2020 at 08:11:02AM -0700, Rob Clark wrote:
> On Thu, Aug 13, 2020 at 6:14 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Aug 10, 2020 at 04:26:48PM -0600, Jordan Crouse wrote:
> > > Add domain attribute DOMAIN_ATTR_PGTABLE_CFG. This will be used by
> > > arm-smmu to share the current pagetable configuration with the
> > > leaf driver and to allow the leaf driver to set up a new pagetable
> > > configuration under certain circumstances.
> > >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >
> > >  include/linux/iommu.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index fee209efb756..995ab8c47ef2 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -118,6 +118,7 @@ enum iommu_attr {
> > >       DOMAIN_ATTR_FSL_PAMUV1,
> > >       DOMAIN_ATTR_NESTING,    /* two stages of translation */
> > >       DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> > > +     DOMAIN_ATTR_PGTABLE_CFG,
> > >       DOMAIN_ATTR_MAX,
> > >  };
> >
> > Nobody other than the adreno gpu uses this, so can we avoid exposing it
> > in the IOMMU API, please? Given that you have a reference to the adreno
> > GPU device in the SMMU implementation code thanks to .alloc_context_bank(),
> > can you squirrel some function pointers away in the driver data (i.e. with
> > dev_set_drvdata()) instead?
> >
> 
> Hmm, we are already using drvdata on the gpu side, and it looks like
> arm-smmu is also using it.  Could we get away with stashing an extra
> 'void *' in iommu_domain itself?

What I meant was, expose the type of whatever you put in there on the GPU
side so that the SMMU impl can install its function pointers into a field of
that structure. As far as I'm concerned, the SMMU impl code and the GPU
driver are the same entity and we should keep their communication private,
rather than expose it up the stack. After all, the GPU writes to the SMMU
registers!

If you really don't want to expose all of your gubbins, I suppose you
could have a structure just for the SMMU view and container_of() out of
that on the GPU side.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
