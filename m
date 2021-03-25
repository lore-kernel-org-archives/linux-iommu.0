Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0195DC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 08:41:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840B561A1A
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 08:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840B561A1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25F0B401C6;
	Thu, 25 Mar 2021 08:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XcQOkbmK5Liw; Thu, 25 Mar 2021 08:41:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B960E40187;
	Thu, 25 Mar 2021 08:41:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9194FC000E;
	Thu, 25 Mar 2021 08:41:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43F8FC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 08:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D50D8496C
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 08:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GanpHPOumrxo for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 08:41:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D503A84984
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 08:41:08 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id l18so1453407edc.9
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WsfdlrzZwaQUGlbzbbRFzp2tp5Odd7hk+8T93wyQeVk=;
 b=AGRdPZJf107faAWLYl2hiDFZtQiwGsNLdZGgIm0Uuh5uIMA7x0K+3s/B0Ru6hH+WSG
 WGt+cPuGLVYOA8HpnNn53HD7zD0thWM8J4mdRUPZ7kQ6W80fMMHsxSuvYh5vr3tHQ3Pe
 xlTWgSj/abYDMryHkX58UELCFL/tQnKy5ytVadUk36kQSLZm4DEPOE+GewEz1/IiARLp
 GPPY8JIdFt1x1nfme2l8wbLtWTPe8aIkfuVsHJ2K37kD103BgCbhMna5Y/OhFItJc8/A
 X99A9ubqADAZqCHRWJbgyToqL0KJAqPiz8ExIn9WXzBPLttDaykEhUjXpJyisn+OHAvo
 MvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WsfdlrzZwaQUGlbzbbRFzp2tp5Odd7hk+8T93wyQeVk=;
 b=t0goJ1RS25smgjka5NxWBiM8MgwyE1iRqpVpuLaXrl7JOY3Zmw3eWKSU88Mh+WBspi
 1MZaOKVNQiooY1/DLlkM+ujgjdavVR/gfucw0/01jQ4mgpgqDjsStUL+RYb1l3cCuuq1
 1kB18p/yX5s42BtDUSmKufuFPSsDcrEgIwZsu3auK5oPPM/gRBhBdKkcA3OUN+spH+9B
 iLwLI9kycz8BenMS6vElq/quekOSaxMJ+z2xa/aZjpysst2Uz4nDq0orIwfKMYi39GFU
 WjT+2jOsX4zgFtK9BTyTkZhoZBDuDs4lhMx65T39SFJOnEuM8Khs9OwNwuDE4GfcIjch
 bG6g==
X-Gm-Message-State: AOAM532BwNv3iukvXCWDZZy/sGCPhuazs5Xxt8vtiblpDH+98M5yILjh
 r1/EBP5dAsQOzQz3TPzWk/sctEEQKSt0E6U2B8uMTw==
X-Google-Smtp-Source: ABdhPJz5d82sxLC89VlxaSjlkGqOftoNRfakhu8Zm+u1x5+OI5OjnA4F90hSLeEU2bBqOB0BGdxncDG7YwW4euoUEsI=
X-Received: by 2002:a05:6402:31a7:: with SMTP id
 dj7mr7852439edb.33.1616661666928; 
 Thu, 25 Mar 2021 01:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
 <b7a2424941214b33803e34ba3e532440@huawei.com>
In-Reply-To: <b7a2424941214b33803e34ba3e532440@huawei.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Thu, 25 Mar 2021 09:40:29 +0100
Message-ID: <CABdtJHtZPyWpXN9JZbgdu=HswreTc2o2pRhrwHFzQJqz-kFSBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
 "robert.moore@intel.com" <robert.moore@intel.com>,
 Linuxarm <linuxarm@huawei.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devel@acpica.org" <devel@acpica.org>
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

On Mon, Mar 22, 2021 at 11:37 AM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> [+]
>
> Hi Erik,
>
> As this is now just merged ino acpica-master and based on the discussion we had here,
>
> https://github.com/acpica/acpica/pull/638
>
> I had a discussion with ARM folks(Lorenzo) in the linaro-open-discussions call and
> can confirm that the IORT Revision E is not the final specification and has some issues
> which is now corrected in the latest E.b revision[1]. Also there are no current users
> for the Rev E and it may not be a good idea to push this version into the Linux kernel
> or elsewhere.

Well it was a released revision, although it was found to have issues.
Currently
HoneyComb Systems Ready certified firmware does include support for this table,
although incomplete.  Without agreement on mainline support I am fine to update
to the latest spec bump.

>
> So could you please revert the merge and I am planning to work on the E.b soon.
> Please let me know if I need to explicitly send a revert pull request or not.

Can you please CC. me on your next release.  I was planning on spending time
on this regardless.  I already have a patchset for the fsl-mc-bus driver that
needs to change in order to function properly with RMR support.

Thanks.

>
> Thanks,
> Shameer
>
> 1. https://developer.arm.com/documentation/den0049/latest/
>
> > -----Original Message-----
> > From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of
> > Shameer Kolothum
> > Sent: 19 November 2020 12:12
> > To: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > iommu@lists.linux-foundation.org; devel@acpica.org
> > Cc: Linuxarm <linuxarm@huawei.com>; steven.price@arm.com; Guohanjun
> > (Hanjun Guo) <guohanjun@huawei.com>; Sami.Mujawar@arm.com;
> > robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> > Subject: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
> >
> > IORT revision E contains a few additions like,
> >     -Added an identifier field in the node descriptors to aid table
> >      cross-referencing.
> >     -Introduced the Reserved Memory Range(RMR) node. This is used
> >      to describe memory ranges that are used by endpoints and requires
> >      a unity mapping in SMMU.
> >     -Introduced a flag in the RC node to express support for PRI.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  include/acpi/actbl2.h | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > ec66779cb193..274fce7b5c01 100644
> > --- a/include/acpi/actbl2.h
> > +++ b/include/acpi/actbl2.h
> > @@ -68,7 +68,7 @@
> >   * IORT - IO Remapping Table
> >   *
> >   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> > - * Document number: ARM DEN 0049D, March 2018
> > + * Document number: ARM DEN 0049E, June 2020
> >   *
> >
> > ****************************************************************
> > **************/
> >
> > @@ -86,7 +86,8 @@ struct acpi_iort_node {
> >       u8 type;
> >       u16 length;
> >       u8 revision;
> > -     u32 reserved;
> > +     u16 reserved;
> > +     u16 identifier;
> >       u32 mapping_count;
> >       u32 mapping_offset;
> >       char node_data[1];
> > @@ -100,7 +101,8 @@ enum acpi_iort_node_type {
> >       ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
> >       ACPI_IORT_NODE_SMMU = 0x03,
> >       ACPI_IORT_NODE_SMMU_V3 = 0x04,
> > -     ACPI_IORT_NODE_PMCG = 0x05
> > +     ACPI_IORT_NODE_PMCG = 0x05,
> > +     ACPI_IORT_NODE_RMR = 0x06,
> >  };
> >
> >  struct acpi_iort_id_mapping {
> > @@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
> >       u8 reserved[3];         /* Reserved, must be zero */
> >  };
> >
> > -/* Values for ats_attribute field above */
> > +/* Masks for ats_attribute field above */
> >
> > -#define ACPI_IORT_ATS_SUPPORTED         0x00000001   /* The root
> > complex supports ATS */
> > -#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000   /* The root
> > complex doesn't support ATS */
> > +#define ACPI_IORT_ATS_SUPPORTED         (1)  /* The root complex
> > supports ATS */
> > +#define ACPI_IORT_PRI_SUPPORTED         (1<<1)       /* The root complex
> > supports PRI */
> >
> >  struct acpi_iort_smmu {
> >       u64 base_address;       /* SMMU base address */
> > @@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
> >       u64 page1_base_address;
> >  };
> >
> > +struct acpi_iort_rmr {
> > +     u32 rmr_count;
> > +     u32 rmr_offset;
> > +};
> > +
> > +struct acpi_iort_rmr_desc {
> > +     u64 base_address;
> > +     u64 length;
> > +     u32 reserved;
> > +};
> > +
> >
> > /***************************************************************
> > ****************
> >   *
> >   * IVRS - I/O Virtualization Reporting Structure
> > --
> > 2.17.1
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
