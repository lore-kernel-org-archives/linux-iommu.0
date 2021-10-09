Return-Path: <SRS0=ijGq=O5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CADC433EF
	for <iommu@archiver.kernel.org>; Sat,  9 Oct 2021 06:58:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4006760F41
	for <iommu@archiver.kernel.org>; Sat,  9 Oct 2021 06:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4006760F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECF9640195;
	Sat,  9 Oct 2021 06:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bDkZfSeDSQuF; Sat,  9 Oct 2021 06:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8687240117;
	Sat,  9 Oct 2021 06:58:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54F4BC0011;
	Sat,  9 Oct 2021 06:58:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EB64C000D
 for <iommu@lists.linux-foundation.org>; Sat,  9 Oct 2021 06:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D95D60B00
 for <iommu@lists.linux-foundation.org>; Sat,  9 Oct 2021 06:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5T1vCMyfUuF for <iommu@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 06:58:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D10160AFE
 for <iommu@lists.linux-foundation.org>; Sat,  9 Oct 2021 06:58:30 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id v18so45055370edc.11
 for <iommu@lists.linux-foundation.org>; Fri, 08 Oct 2021 23:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mDTl8X5yoXokOqK2zdOQtAknCzTNXPqBW0n1XanS7MI=;
 b=rNu1qpoGLb1tS097DGxH3Ff2UIstvCzkt+qWo1qxgHvl4ifiX+oRjbrlAf7AY87uM9
 bo/PUkbQGmIDm909slkixSa/KvAnJrFJ5tU2nD6RpJBIu45BtT+m++TAJHKM6wMVfYax
 ATiBhIeL0s2haTGCWgxhiISiVmfowRhkC7zluCk0WkJN2l/dtq+jcPq8szphgEpYHU2h
 yN8/sltuCjhRJjhYvkWFwV2rzAzMWWDf0pDReJlQvMK0fKjeeguKveHcX5zYO6bLm40/
 T9AQ0GmQvVr+R07o3csoWa0jIlO8V5ewHRUy5rpN7mPMdfhr6lzi9s1ZrPM5hAmRCkBb
 iZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mDTl8X5yoXokOqK2zdOQtAknCzTNXPqBW0n1XanS7MI=;
 b=mxg0CZiSswYVGzgbdz0wCzs80blhsGx2ykE2kBZnxZtC7idcEqJBRg6WW5ZzT02BAf
 apH8hGaXexYG1UYKgN4di1Q0vkKxWKZahemg5jIaWOpyurK2RoexNZCHxmJ6vZ+sSS4o
 pUvH1gGBBvngPABe+kk1nuSbkWNnd0LaapBRVQlwiTEbLZzcTYjBwE74UaQmSdACO8Eh
 Q8agN0uJfla6CMputkh3tPAqjHSigy1f+NJrzoQijwvJbUkYKXoe0wD4A3kTCrCSWwxY
 hYPylNpaPq4njLkCalgbjtz6ZLeJBiZzhMSjnME/To601wsNGYz55/vRJesyK3wcxPVB
 epvg==
X-Gm-Message-State: AOAM530u3C5a6yp5G+enVLB38krbqu+ZSlhRYe1tjBGLL74yrMESdPUO
 ybMTDVLR7WDx10ZyZgmIJCscNxDjLk77ToxTUqBfnw==
X-Google-Smtp-Source: ABdhPJwhcPwL5hzWQI/NubQfQxK8my9q4PDNQMawMoHZUBGS3OG3sxm/edyZlPDpMWXoqcQyTK4dJMNAN0nF2LxRiUM=
X-Received: by 2002:a17:906:1e55:: with SMTP id
 i21mr9657898ejj.547.1633762708473; 
 Fri, 08 Oct 2021 23:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
 <a1eddd80-4a26-4809-e681-f338d9998a24@arm.com>
In-Reply-To: <a1eddd80-4a26-4809-e681-f338d9998a24@arm.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Sat, 9 Oct 2021 08:57:51 +0200
Message-ID: <CABdtJHtB7apg809UkrmDHQvtL012FqA_0+4_pL9NVD-mVm42YA@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
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

On Fri, Oct 8, 2021 at 2:14 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-05 09:07, Shameer Kolothum wrote:
> > A union is introduced to struct iommu_resv_region to hold
> > any firmware specific data. This is in preparation to add
> > support for IORT RMR reserve regions and the union now holds
> > the RMR specific information.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   include/linux/iommu.h | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 32d448050bf7..bd0e4641c569 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -114,6 +114,13 @@ enum iommu_resv_type {
> >       IOMMU_RESV_SW_MSI,
> >   };
> >
> > +struct iommu_iort_rmr_data {
> > +#define IOMMU_RMR_REMAP_PERMITTED    (1 << 0)
> > +     u32 flags;
> > +     u32 sid;        /* Stream Id associated with RMR entry */
> > +     void *smmu;     /* Associated IORT SMMU node pointer */
> > +};
>
> Do we really need to duplicate all this data? AFAICS we could just save
> the acpi_iort_rmr pointer in the iommu_resv_region (with a forward
> declaration here if necessary) and defer parsing its actual mappings
> until the point where we can directly consume the results.

From earlier discussions on this patchset, the original goal was also for
device-tree mechanisms to be able to hook into this code to support
similar RMR's and SMMU initialization, just not through the ACPI / IORT
path.

>
> Robin.
>
> > +
> >   /**
> >    * struct iommu_resv_region - descriptor for a reserved memory region
> >    * @list: Linked list pointers
> > @@ -121,6 +128,7 @@ enum iommu_resv_type {
> >    * @length: Length of the region in bytes
> >    * @prot: IOMMU Protection flags (READ/WRITE/...)
> >    * @type: Type of the reserved region
> > + * @rmr: ACPI IORT RMR specific data
> >    */
> >   struct iommu_resv_region {
> >       struct list_head        list;
> > @@ -128,6 +136,9 @@ struct iommu_resv_region {
> >       size_t                  length;
> >       int                     prot;
> >       enum iommu_resv_type    type;
> > +     union {
> > +             struct iommu_iort_rmr_data rmr;
> > +     } fw_data;
> >   };
> >
> >   /**
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
