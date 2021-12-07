Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8B2C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 13:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E19560724;
	Tue,  7 Dec 2021 13:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ldv9WlOLpX6k; Tue,  7 Dec 2021 13:38:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CC5116067E;
	Tue,  7 Dec 2021 13:38:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F60EC001E;
	Tue,  7 Dec 2021 13:38:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21EEEC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A3D9606FA
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8x8exoHVO9Lz for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 13:20:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B4F460677
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:20:16 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id u11so9422251plf.3
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3pjdVhWR1OgHYWV0sxlZyJWoI2cI2Oh0roG7GoSp3nI=;
 b=qzUf+lPLoy8N93P9Uyf+2TLGaK4mOsKziqdfzRnbb3odO/2MhkPJKvrcCynajDarOc
 0THGTjNfBsgmZmrLXhnlX2PHkhf+t+S8DGprz2XsJPI0ssW4mr5US2djCTQuAptTwsaW
 Yx42eLAgNm2Loo4Srw6kmC0UM4OIceQdylrdnqGf32IzzCC5FAuJCbqvTYP9QCLo5S/u
 BPk+pV0Spfd5XWgjtmPyjvi/iFgXuJEdBuRlMCv3M+PXkekKFgeWCtU6nTaJZEoMP4VE
 9wicT9Ei6SKFJS1Iyw6g9RL4QSJ8I03RFrR7JF+9/K1QQvJzur8zkcrkQ9PB4aTUIzrp
 lAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3pjdVhWR1OgHYWV0sxlZyJWoI2cI2Oh0roG7GoSp3nI=;
 b=DkZsUv2QFjmE3xdYFG1bewyQzSkLfOAcZH/du24fgCOXazqiWd/YUQlxQeU7TpocPI
 MdUOFEvTtZWhU54KNmwVmN0GnGD6+gf6fcFmWkY1agqDAsbaYU1S+9UoRactZ0Q0omNH
 W1vLAtp67sbb4iaBaF7wqZltq7wFBfO1o8sKSR/B8/XtqTG339a2aQ7NTuNgu3j6xLW5
 Vm3kOQ6x6eGB+jhF+O3AneEfs4RXdj0szwnfEVo/JEFbkXTFBqa2zJNjkclXjJLCiUQe
 PzOM/suwMvYO39p8nin/Y9RklmUT8Mbu5LftMKPO9ExOxBEyUjCW7t1yRgDHTK9nEMKI
 x08w==
X-Gm-Message-State: AOAM530+bbZUUuhWRJHaPMrPpuLTGksWkbcOcwlgUveIOANOAsYgV7Gq
 B8hGnSKhJ6zo7/b2JRIdKM0Fww==
X-Google-Smtp-Source: ABdhPJyT36O+3PzDMnfYqToz8aS2UUJaqSeMsISrkbXJtNAy82ZKfJX+kRLQwdMUPlxd55dKVcedTg==
X-Received: by 2002:a17:902:c7c4:b0:141:deb4:1b2f with SMTP id
 r4-20020a170902c7c400b00141deb41b2fmr50916851pla.44.1638883216337; 
 Tue, 07 Dec 2021 05:20:16 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.207.71.6])
 by smtp.gmail.com with ESMTPSA id j15sm15751386pfh.35.2021.12.07.05.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Dec 2021 05:20:15 -0800 (PST)
Date: Tue, 7 Dec 2021 21:20:07 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] perf/smmuv3: Synthesize IIDR from CoreSight ID
 registers
Message-ID: <20211207132007.GB255238@leoy-ThinkPad-X240s>
References: <20211117144844.241072-1-jean-philippe@linaro.org>
 <20211117144844.241072-4-jean-philippe@linaro.org>
 <e60b15db-4e52-b5a6-1b17-203d250f1e65@huawei.com>
 <766ac58a-ffb7-f673-709b-0f0f740f3cfd@arm.com>
 <53f868a8-c7ae-b69d-b061-bb0a7dc98f8a@huawei.com>
 <d60110c4-c179-45d6-512d-3d058caac974@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d60110c4-c179-45d6-512d-3d058caac974@arm.com>
X-Mailman-Approved-At: Tue, 07 Dec 2021 13:38:56 +0000
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, uchida.jun@socionext.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Dec 07, 2021 at 12:48:13PM +0000, Robin Murphy wrote:
> On 2021-12-07 12:28, John Garry via iommu wrote:
> > On 07/12/2021 12:04, Robin Murphy wrote:
> > > > > 
> > > > So is there some userspace part to go with this now?
> > > 
> > > FWIW I've not looked into it - is it just a case of someone knocking
> > > out some JSON from the MMU-600/700 TRMs, or is there still mroe to
> > > do?
> > 
> > That should just be it.

Hope I didn't arrive too late :)

Yes, I think we just missed two things: the DT binding for SMMUv3 PMU
which is just addressed by this patchset; and the PMU event aliasing
for SMMUv3 PMU, before I inquired with John and John said he would
upstream the related patches after kernel can export a IIDR value via
sysfs node.

Seems to me, after this patchset for DT binding and PMU event alias
patches are landed to the mainline kernel, it would be perfect.

> > > I had the impression that *some* part of the process was stalled
> > > until implementations can start providing meaningful IIDRs, but I
> > > wasn't sure whether that was tooling or just data. I just work the
> > > low-level enablement angle :)
> > 
> > Tooling should be ok, but I would just like to see more of these JSONs
> > so any tooling issues can be ironed out.
> 
> Sounds good - Jean, Leo, is that something Linaro might like to pick up as
> part of the PMCG interest, or shall I make a note on my to-do list for the
> new year?

I took a look for current patch for using PIDR to synthesize IIDR, it
looks good to me.  But I tested it on Hisilicon D06 board and observed
the composed IIDR values are still zeros.

I added a printk sentence to dump iidr value at the end of the function
smmu_pmu_get_iidr():

  leoy@ubuntu:~$ dmesg | grep iidr
  [   28.674087] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.8.auto: iidr=0x0
  [   28.705239] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.9.auto: iidr=0x0
  [   28.729924] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.10.auto: iidr=0x0
  [   28.754855] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.11.auto: iidr=0x0
  [   28.779811] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.12.auto: iidr=0x0
  [   28.804755] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.13.auto: iidr=0x0
  [   28.829825] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.14.auto: iidr=0x0
  [   28.854767] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.15.auto: iidr=0x0

Please confirm if this is expected or not?  I think this might
introduce difficulty for John for the PMU event alias patches, which
is dependent on a non-zero IIDR.

At last, very appreciate your (Jean-Philippe, Robin and John) help!

Thanks,
Leo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
