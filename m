Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B872FC4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 19:40:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBCA60E76
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 19:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FBCA60E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 338A940155;
	Mon, 16 Aug 2021 19:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LmLsKSAR6yGC; Mon, 16 Aug 2021 19:40:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CCA294010D;
	Mon, 16 Aug 2021 19:40:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A327AC001A;
	Mon, 16 Aug 2021 19:40:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D36D5C000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 19:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C22F780ECE
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 19:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x3WeGvY-jJVT for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 19:40:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12D0080E6D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 19:40:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7A3A60FD8
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629142820;
 bh=0NGchtMPqXcGzx6gjhgUu5kP909HOdwGq6mHakCZGwc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=PNgp5i1ZmTHXE84/dACTXBnZfelmk/5B0bB2QynpkqE3XleOGZjJiMRroy4GLv9Mr
 m5oCH5UVNMnpPL8RsV6R0zOYQSISSWlYOK6KIicnnkGOPZq5Z/yeQV2MBBGZZpZFm8
 ylJ+kPVxVPad3Xk+XT2ZaS76thIkTyOKoUQhjvbyS9ZamVQ8CjqFkdY1aVNv4Pvzwf
 HfnNcaDnMDKokNdezBiT4Yup3MRkaGd2uvz+akT+i/O18MHfcZ7CUCM7vxV+Z7RZD5
 19NBtR8U0l1zhigcXR2tV4NejYYb+/uqgx39MUp5jW9MNoVNo3OgCtaa+AOwje9aeX
 ZYZG3ZhheI+iQ==
Received: by mail-ed1-f45.google.com with SMTP id r19so24808887eds.13
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 12:40:20 -0700 (PDT)
X-Gm-Message-State: AOAM5319z0pZYVNbKE7IvOloWVqYsmZtIPXcoP1ySS3csyYolqHIWraI
 49l/iVu4nktNfMiVkDx+xggL5Sg9pFdR7tVmGg==
X-Google-Smtp-Source: ABdhPJyCHRTGwHhoWZVCC+L/ijlQKyXy+VyzVmiuJ6Onoccah+VfC+GD5IBBssfJrxh921yFciVB2LUPAtWxyYPXGrQ=
X-Received: by 2002:a50:9b52:: with SMTP id a18mr218882edj.165.1629142819250; 
 Mon, 16 Aug 2021 12:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210816132618.11707-1-will@kernel.org>
In-Reply-To: <20210816132618.11707-1-will@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 16 Aug 2021 14:40:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCxMPOZ-O6wpLbv7Fi2cuuo8mGZBjsA3Mhw0kcpBvK5w@mail.gmail.com>
Message-ID: <CAL_JsqKCxMPOZ-O6wpLbv7Fi2cuuo8mGZBjsA3Mhw0kcpBvK5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Don't fail device probing due to
 of_dma_set_restricted_buffer()
To: Will Deacon <will@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Claire Chang <tientzu@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Mon, Aug 16, 2021 at 8:26 AM Will Deacon <will@kernel.org> wrote:
>
> Hi all,
>
> This is v2 of the patch I previously posted here:
>
>   https://lore.kernel.org/r/20210805094736.902-1-will@kernel.org
>
> Changes since v1 are:
>
>   * Move of_dma_set_restricted_buffer() into of/device.c (Rob)
>   * Use IS_ENABLED() instead of 'static inline' stub (Rob)
>
> This applies on Konrad's devel/for-linus-5.15 branch in swiotlb.git
>
> Cheers,
>
> Will
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
>
> --->8
>
> Will Deacon (2):
>   of: Move of_dma_set_restricted_buffer() into device.c
>   of: restricted dma: Don't fail device probe on rmem init failure
>
>  drivers/of/address.c    | 33 ---------------------------------
>  drivers/of/device.c     | 39 ++++++++++++++++++++++++++++++++++++++-
>  drivers/of/of_private.h |  7 -------
>  3 files changed, 38 insertions(+), 41 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
