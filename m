Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FA7C433B4
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 10:25:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA7C61430
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 10:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA7C61430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 010E660C0D;
	Wed, 28 Apr 2021 10:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dktamrlx0jDP; Wed, 28 Apr 2021 10:25:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCA56608D2;
	Wed, 28 Apr 2021 10:25:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFFD1C0022;
	Wed, 28 Apr 2021 10:25:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FB92C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 10:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4986840132
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 10:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Btk1zhOZvbn for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 10:25:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 856E0400C4
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 10:25:39 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id k14so12530946wrv.5
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Bwu2rvkvN7gIZgfFitfEHTzbFUX5cjTsDc1ntVZl3eQ=;
 b=PHZeQvSpD9gY/jZeF+Zw2eXX30t8tvzRaZFemI+co9ssuQJ5VmkKic+in5tGy1voiI
 +JbG2h+dGoZ/G7jodqkrWRnDvqMHa+gVEgnr4zHczTntfWyOoWVoXaxQcHqXpiK2yXjl
 bkhPD5asbliuzx3DkFvnuveaTuLwFkNVRijOUe8uTOsvWAizVeIoXmThi2TrC3YVMc7p
 20iUBDZKOaklWfdjYQI1TquVFSrnj8YFJvZwGlQPSh3rmsqoU0DQGOYUCqKey8oVkujI
 zDpM/DGNrIlmm0i4MBPcsp16t4/kmCEMcJMHglWv4NzCh/y3+uPg0kqcwq6iidzS3XZ5
 Yc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Bwu2rvkvN7gIZgfFitfEHTzbFUX5cjTsDc1ntVZl3eQ=;
 b=pLJAJcHllYn+SiHwCEkcG1y9RdNKDPlcGGx02pk765Z6HpIKD67HK/H/SoGi618j+F
 hqoMqRbzoBUUVoI+rQMtMaNilxIjSYtIt4+G04uysfKPx34G32/FCivi/QewmyC8AFDo
 6kSBq/FKiMo5aWmYIj+9kS7yt3h6eitc4gwJ+9RWmyWi3DseiROB44TBzC5l2gXcGD0u
 J2pHP7Wr00uWp94VJcmdtbgSqGEtrV2KL6klbQYjugdA8qaaWlZB2yemhlAB4vZlNkhm
 PfEMvmnVu6n+FBglkkd8ZjYVgHm8/MNJlE5F1Q5ZDRyj82FTU4BhKmFf1HsRcmltdBvc
 lZiw==
X-Gm-Message-State: AOAM531bH69skA1WMDUCA2oXXHGYLLF5ilebp4vWxCosHTQdG0Ph0AwB
 A9hg0mRrL3ukNqiEJcAq77Y=
X-Google-Smtp-Source: ABdhPJyg7JPa6ZNYGm2DugdINct82FO1jCIP+1ZhYmTKZMahiNC6lNjGXCn7YoYbQE30oSy2QINbiA==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr20283167wrw.108.1619605537794; 
 Wed, 28 Apr 2021 03:25:37 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
 by smtp.googlemail.com with ESMTPSA id a9sm3381689wmj.1.2021.04.28.03.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Apr 2021 03:25:37 -0700 (PDT)
Date: Wed, 28 Apr 2021 12:25:35 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: DMA mapping fill dma_address to 0
Message-ID: <YIk4H82yrx+Yzp/U@Red>
References: <YIkf4yqt14dGPoyr@Red>
 <6ce3614e-af79-2a36-de83-6cbb4d9fe9a4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ce3614e-af79-2a36-de83-6cbb4d9fe9a4@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Le Wed, Apr 28, 2021 at 11:06:10AM +0100, Robin Murphy a =E9crit :
> On 2021-04-28 09:42, Corentin Labbe wrote:
> > Hello
> > =

> > I work on the crypto offloader driver of cortina/gemini SL3516 SoC.
> > I test it by filling a LUKS2 partition.
> > I got a reproductible problem when handling skcipher requests.
> > I use dma_map_sg() and when iterating other the result, sg_dma_address(=
sg) return 0.
> > But sg_dma_len(sg) is still correct (4096 in my case).
> > =

> > Below is a simplified view of my code:
> > nr_sgs =3D dma_map_sg(ce->dev, areq->src, sg_nents(areq->src), DMA_TO_D=
EVICE);
> > (nr_sgs =3D 1 in my case)
> > sg =3D areq->src;
> > if (!sg_dma_address(sg))
> > 	FAIL
> =

> What is this check supposed to be for in the first place? 0 is a valid =

> DMA address, because it's also a valid physical address, and I recall =

> RAM at PA 0 on Hikey 960 flushing out some bugs in the past when we =

> tried to use 0 for DMA_MAPPING_ERROR. All the Gemini DTs appear to show =

> RAM starting at PA 0 too, so I'd have to guess that it's simply the case =

> that your DMA buffer happened to end up using that particular page.
> =

> Robin.
> =


Yes, 0 is a valid DMA address.
I just find it by going further and printing mem_map value and testing it a=
gainst sg_page() return.

So my original problem was not related to this.
Sorry for the noise.
Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
