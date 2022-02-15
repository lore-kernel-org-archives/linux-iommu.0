Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E6AC433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 04:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D34A682865;
	Tue, 15 Feb 2022 04:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yXOousDAVynk; Tue, 15 Feb 2022 04:28:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A62DF818CA;
	Tue, 15 Feb 2022 04:28:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F8A3C001A;
	Tue, 15 Feb 2022 04:28:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1D9EC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 04:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C136E40932
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 04:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x4mAfQqX3Jdt for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 04:28:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21ECE4092D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 04:28:25 +0000 (UTC)
Received: by mail-vk1-xa34.google.com with SMTP id d196so2618445vke.5
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 20:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qvPMOSdhC/xQAbb97VZ8kOvExLfCoSyVG2mFuU8iamA=;
 b=HY7cnPKOG7aGWCWW0pR0phjW43+YCILDFSONv0M7Iz3KsZbRSG+MTU/ajyA84AF/d/
 EOi/tozvwH3EU5yiEgRX/Pdx0ma+FV2UTneB15G9oC12k2DmZuqn4LuXvCF1Omv/HZ0e
 cTDrwHByIIJVJ8nkUP8fYOZBZr43RPDwAGCFp3Kx5fxXHRCZ6Qk9BVs/8AVtlTw+pMCk
 AtjEYo8jNieihQ1QKOnRfIVdQmRXM2/AXqCK9x+LtkPZrwXsMyVS0I+G1UtD1I6x7MmZ
 E3Uuye00P2OQemUnSiL0c8osLs1IEAM6g+/dvYp59zLgKDBL2D7hNykNfH2uHZdT4ej0
 zSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qvPMOSdhC/xQAbb97VZ8kOvExLfCoSyVG2mFuU8iamA=;
 b=hLTE7Aa4aTU81ekqcCrtPnop+Q13TBy6ksy5CBLG8EG/wKxjaLrkb9qL1vl5I5c5uu
 f1FhwM18juESObEONdy3QmTNE8rxin3X5j6JRMYnWN2Y3ntGve+Q9wJMd+AIdwC8Ehyc
 kh3ebLTIasz5JA0Jh2RziADPu1XYE++xIK4/JDzscXqwGh6SZxYf4eFScILi8sEMtmg3
 4irUVdfxomHcHg5FezhYnPKWRVO1Kh8B8zn2SbrN97CqYOCAgfTcgW8TwmcwzPzOvl6q
 sTJGHrHPHIurb6rONm5brXFOzFv8GImx4F4r4zmLj2sQZ40B8IfEfGx+Krjt0yPLj33C
 V6rw==
X-Gm-Message-State: AOAM532xZOvV5KF4D8R7QCJouS8EHEdqf70sxInnb93prfRFDpP36Nys
 Qk5++gVHBYM4AF6KzwP1KNy0zBiL2tFqKkfimXY=
X-Google-Smtp-Source: ABdhPJyv3l96108QqdpyBtaBtMgBwDL2AGYnujQhO6bcLehU+DaihsVkH5qbijRslB3bO8Hk3hxr3v03hGPjk+JJuec=
X-Received: by 2002:a05:6122:130b:: with SMTP id
 e11mr607282vkp.33.1644899303826; 
 Mon, 14 Feb 2022 20:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20220211024515.21884-1-adrianhuang0701@gmail.com>
 <1627d563-ff48-6204-33be-361db75011f9@linux.intel.com>
 <CAHKZfL3os22ADrC=C3JVO-4h-hAa_cLYNq7c3_+vo3jkbtrCrg@mail.gmail.com>
 <464ca69f-7f59-bb1e-45f9-f352d80fbcbe@linux.intel.com>
In-Reply-To: <464ca69f-7f59-bb1e-45f9-f352d80fbcbe@linux.intel.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Tue, 15 Feb 2022 12:28:11 +0800
Message-ID: <CAHKZfL2xEybeVu=DWqX6okJd32hU3k4-sauRVA8v-JTedBPwnQ@mail.gmail.com>
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

On Tue, Feb 15, 2022 at 9:26 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> On 2/14/22 5:32 PM, Huang Adrian wrote:
> > Hi Baolu,
> >
> > On Mon, Feb 14, 2022 at 8:35 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >>
> >> Hi Adrian,
> >>
> >>> The solution is to prevent from allocating pasid table if those
> >>> devices are subdevices of the VMD device.
> >>
> >> Thanks for your patch!
> >>
> >> Is this the only patch that is needed to make VMD devices work in VT-d
> >> scalable mode?
> >
> > Yes, it is. With this patch, the system can boot successfully and the
> > RAID device connected to the VMD device can be recognized by the host
> > OS. I also ran a simple IO stress on the RAID device by compiling
> > kernel `$ make -j $(nproc)`. Everything looks good.
>
> Thank you! So how far should this patch be back ported?

Thanks for the feedback.

Do you mean the CC stable kernel tag? Something like: "Cc:
stable@vger.kernel.org # v5.8+"?

> Can you please add a Fixes tag?

Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")

Do you want me to send a v2 with the CC stable kernel tag and Fixes
tag? Or, do you just need to take the Fixes tag directly without
sending a v2?

-- Adrian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
