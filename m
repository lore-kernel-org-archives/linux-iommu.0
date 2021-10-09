Return-Path: <SRS0=ijGq=O5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3742FC433F5
	for <iommu@archiver.kernel.org>; Sat,  9 Oct 2021 07:08:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF29060F5B
	for <iommu@archiver.kernel.org>; Sat,  9 Oct 2021 07:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF29060F5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8960B401C0;
	Sat,  9 Oct 2021 07:08:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6tDhfgjTn_0A; Sat,  9 Oct 2021 07:08:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E7A8F400D2;
	Sat,  9 Oct 2021 07:08:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7566C0011;
	Sat,  9 Oct 2021 07:08:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18B40C000D
 for <iommu@lists.linux-foundation.org>; Sat,  9 Oct 2021 07:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05DF0401C0
 for <iommu@lists.linux-foundation.org>; Sat,  9 Oct 2021 07:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7by-vAJCTZQ for <iommu@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 07:08:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8B57400D2
 for <iommu@lists.linux-foundation.org>; Sat,  9 Oct 2021 07:08:32 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id g10so43883524edj.1
 for <iommu@lists.linux-foundation.org>; Sat, 09 Oct 2021 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YxbI/uuYtuMouh6gZMpilx8L0A4TIecSt2QZc/N1Qqk=;
 b=ut6b5FvP/h3dtW4M5RgbTfFdVAeUyT+OzMK9R+jzPqdcr2H1ROwxWb3o2DmZ7XocuM
 feAEDLNwM0fvh6acD4DfWfguur+oiGEOhT9LtoqEEUaw8a078IdWa44Nr2LVmAzmuDHy
 FZgL9jwXKunsOt8vuXAdwi2ZGRuAcY4Zg3KzMVHGllN7TkRPtauzvluOL21USJ8esIw9
 HSB3R+mSGFiuN9SFnqr69dhNQ4zrF3bcK6Cc9+w/3w1fJBkxwpaqNejStzOtd4bTz2p1
 sAIJES+DZs+hHnu6ry/Y3qTnd1R34Mp258AzYihD2y6iHzZE8jrPnHBoB5+mKF+dgG5R
 rFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YxbI/uuYtuMouh6gZMpilx8L0A4TIecSt2QZc/N1Qqk=;
 b=YOuSi5bhj5+YXLntul+vo9upXPe8UgbYPQ2SwRCsgRBdHOfRDpjjivLU6Dv4gv8RZR
 sbGEZkb6/IiWw4RW1Xn7Smj/4ozG5htczRPmEmvRMxueRwL/TTtDYYU0WknSsCULP0T5
 BZejhXeAjGSNuis2QBS/iRFMEFIEuOrVDTL4kBBp/f4XjyV7eUnq4VIT+El63FI4hKpG
 4sHEhCaphcN5eaWTS17+EaYfPPQ2fSFSkHDjBUTJxf2L/EwK3Elc80Rp1XLROTkYlGVY
 dElc6/e5MN45G8YQ02Xaq2zD5MwoVNsO9rPYDppi0DbOrTgFxWblAzl+cT+VaXfPLwN9
 Dt2Q==
X-Gm-Message-State: AOAM530Bl1YQqS9nSND+DtFlqbOXn8jHJGXflTNU0pMGvJxOFfNSVvKE
 QSo0pI760yO1q7w/3HpXCL3kkus7U7QEIbUPoZLcdA==
X-Google-Smtp-Source: ABdhPJxOqIbSsuLd/7QjzZhiZP9syTmIR3XdifKwNKBGqI/kiluRwbLDcDxx+CANT6FUsI8vO1wCW58iyhufMzS1Ckk=
X-Received: by 2002:a17:906:318b:: with SMTP id
 11mr10003258ejy.493.1633763311162; 
 Sat, 09 Oct 2021 00:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
 <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
In-Reply-To: <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Sat, 9 Oct 2021 09:07:54 +0200
Message-ID: <CABdtJHv+SZ15RcBaFt0w4iTsMMbAjGB2Wm4GST3cNw+2Q=OeVw@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated with
 a dev
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, Sami Mujawar <Sami.Mujawar@arm.com>,
 Will Deacon <will@kernel.org>,
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

On Fri, Oct 8, 2021 at 3:10 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-05 09:07, Shameer Kolothum wrote:
> > Get ACPI IORT RMR regions associated with a dev reserved
> > so that there is a unity mapping for them in SMMU.
>
> This feels like most of it belongs in the IORT code rather than
> iommu-dma (which should save the temporary list copy as well).

See previous comment.  The original intent was for device-tree to also
be able to use these mechanisms to create RMR's and support them
in the SMMU.

-Jon

>
> Robin.
>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 56 +++++++++++++++++++++++++++++++++++----
> >   1 file changed, 51 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 1b6e27475279..c1ae0c3d4b33 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -207,22 +207,68 @@ void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
> >   }
> >   EXPORT_SYMBOL(iommu_dma_put_rmrs);
> >
> > +static bool iommu_dma_dev_has_rmr(struct iommu_fwspec *fwspec,
> > +                               struct iommu_resv_region *e)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < fwspec->num_ids; i++) {
> > +             if (e->fw_data.rmr.sid == fwspec->ids[i])
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static void iommu_dma_get_rmr_resv_regions(struct device *dev,
> > +                                        struct list_head *list)
> > +{
> > +     struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +     struct list_head rmr_list;
> > +     struct iommu_resv_region *rmr, *tmp;
> > +
> > +     INIT_LIST_HEAD(&rmr_list);
> > +     if (iommu_dma_get_rmrs(fwspec->iommu_fwnode, &rmr_list))
> > +             return;
> > +
> > +     if (dev_is_pci(dev)) {
> > +             struct pci_dev *pdev = to_pci_dev(dev);
> > +             struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> > +
> > +             if (!host->preserve_config)
> > +                     return;
> > +     }
> > +
> > +     list_for_each_entry_safe(rmr, tmp, &rmr_list, list) {
> > +             if (!iommu_dma_dev_has_rmr(fwspec, rmr))
> > +                     continue;
> > +
> > +             /* Remove from iommu RMR list and add to dev resv_regions */
> > +             list_del_init(&rmr->list);
> > +             list_add_tail(&rmr->list, list);
> > +     }
> > +
> > +     iommu_dma_put_rmrs(fwspec->iommu_fwnode, &rmr_list);
> > +}
> > +
> >   /**
> >    * iommu_dma_get_resv_regions - Reserved region driver helper
> >    * @dev: Device from iommu_get_resv_regions()
> >    * @list: Reserved region list from iommu_get_resv_regions()
> >    *
> >    * IOMMU drivers can use this to implement their .get_resv_regions callback
> > - * for general non-IOMMU-specific reservations. Currently, this covers GICv3
> > - * ITS region reservation on ACPI based ARM platforms that may require HW MSI
> > - * reservation.
> > + * for general non-IOMMU-specific reservations. Currently this covers,
> > + *  -GICv3 ITS region reservation on ACPI based ARM platforms that may
> > + *   require HW MSI reservation.
> > + *  -Any ACPI IORT RMR memory range reservations (IORT spec rev E.b)
> >    */
> >   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
> >   {
> >
> > -     if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> > +     if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode)) {
> >               iort_iommu_msi_get_resv_regions(dev, list);
> > -
> > +             iommu_dma_get_rmr_resv_regions(dev, list);
> > +     }
> >   }
> >   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> >
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
