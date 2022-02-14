Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8ADC433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 09:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2365540491;
	Mon, 14 Feb 2022 09:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vOTURDpSZmCF; Mon, 14 Feb 2022 09:33:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 36FE6403AC;
	Mon, 14 Feb 2022 09:33:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08537C001A;
	Mon, 14 Feb 2022 09:33:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 616F6C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 09:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E213401FB
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 09:33:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pzeg0jXIpogA for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 09:32:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADB90403AC
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 09:32:56 +0000 (UTC)
Received: by mail-vs1-xe2b.google.com with SMTP id r20so18100450vsn.0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 01:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PLcOLPtWWBqmDDHWEpO34tYOTTm7+UHIWiSVGaIprIg=;
 b=kg7kZyOb9/YPB2k+M73IONRXz0ib37KQkPxENT9vkKJhUhnBd8pRRHgbxHfmDHuwaI
 Qp0xORBGpq8I118nzQGSimsTjEb/8C0E2jTHe4NQ39vqZnvaykMSBztw2sBlX7jIU20I
 kiZbcEw7bF3GAHyAntGEJZ50THUb/HaulyM4G1Y8nq+8KVTiTHr6iAL4nVJdIYXXKpL2
 bPROl28fDbRGWgfe4O1nqP5CGVm0w6sJq+14a0KLXytgO2KZS6zorANr24VCnVDLUZ5k
 eRp4SBUhHR/IHYZSa27xAmqszPkdSAIA/vvO2wCMBqeLB7xyLe3ZX5sDaHOOtHyqFLsb
 Bgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PLcOLPtWWBqmDDHWEpO34tYOTTm7+UHIWiSVGaIprIg=;
 b=wH332EEkSUKvTLnIxjmBRqyM8nNYndn01Q17zPrO0M9F+v4JnVUPLYd34DryTiH+sa
 lKKGwceMQqisGaYAv2D9djLUx9r+tyF03BXtwPruQcCuAiAVWgeKWZryk8dNb9i+E2/V
 YBOKtjJhaTTHPDQXmWJVUuUmXRhvIcabTAUoAmA2myZY0jvOa6rvLvelUoeYFP/uuayz
 mr4oOl+TQ/wTjjFd1EfvisL5MlcAMacJf14LQP6Qz1M/z6Xyw8FjxPoFZ4Rkz12tIn1I
 HYoWVxfePB61gw3Tav9WKDGkwh7IkvWyiC8v6kqIk8UABmDR+ErcmNDxkJ4dJLXXk+LP
 Bwiw==
X-Gm-Message-State: AOAM532FDjizH4LuM6kyznAuSDoSAPJg7yU8gkacghR0nlUSqxDc+edj
 geCtH1PbHOGOiyXGMZn3nlVkYEQGHVBXbiONELc=
X-Google-Smtp-Source: ABdhPJy4V/CniEFw8ajNIlkx7WvD0RKtlAJV/VatU6txf3/yRAN7MFYb/HrmUclI/GBtLwYDypffXY+IlaXcTaG1q7A=
X-Received: by 2002:a05:6102:3e90:: with SMTP id
 m16mr3333445vsv.4.1644831175514; 
 Mon, 14 Feb 2022 01:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20220211024515.21884-1-adrianhuang0701@gmail.com>
 <1627d563-ff48-6204-33be-361db75011f9@linux.intel.com>
In-Reply-To: <1627d563-ff48-6204-33be-361db75011f9@linux.intel.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Mon, 14 Feb 2022 17:32:43 +0800
Message-ID: <CAHKZfL3os22ADrC=C3JVO-4h-hAa_cLYNq7c3_+vo3jkbtrCrg@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix list_add double add when enabling VMD and
 scalable mode
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, iommu@lists.linux-foundation.org,
 Adrian Huang <ahuang12@lenovo.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 David Woodhouse <dwmw2@infradead.org>
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

Hi Baolu,

On Mon, Feb 14, 2022 at 8:35 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi Adrian,
>
> > The solution is to prevent from allocating pasid table if those
> > devices are subdevices of the VMD device.
>
> Thanks for your patch!
>
> Is this the only patch that is needed to make VMD devices work in VT-d
> scalable mode?

Yes, it is. With this patch, the system can boot successfully and the
RAID device connected to the VMD device can be recognized by the host
OS. I also ran a simple IO stress on the RAID device by compiling
kernel `$ make -j $(nproc)`. Everything looks good.

-- Adrian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
