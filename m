Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34443C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 09:54:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88F561051
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 09:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C88F561051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92A2D60670;
	Tue, 10 Aug 2021 09:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WTntDEOtj0TW; Tue, 10 Aug 2021 09:54:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B7C960777;
	Tue, 10 Aug 2021 09:54:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 401BCC0010;
	Tue, 10 Aug 2021 09:54:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F3BCC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 416C040273
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id TeVcvAnaf_Cp for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 09:54:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id D3C364024B
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:54:46 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1628589287; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=60vq8IZG6c8Gs1cuSWU7oo0+DBbyu3c+ZH4aBblmawM=;
 b=CvyviI5asBDsXg2RpLuNXKTOWz1Hye+NJH6jJgCI5hgVKNHf6qn5dcFWpfLzx5HSPyKGsJu9
 8dBPS5OTohj4TdctArNDTUo0biBq4dYA0QfncolO5+E3wxSQJVT8HEhfqc2NJt3zxVpTaLHa
 Rxf0a/gO7LeFkY7O8UcUqmaTKKA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61124ce491487ad52093f4db (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 09:54:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5146DC43147; Tue, 10 Aug 2021 09:54:43 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 05E71C4338A;
 Tue, 10 Aug 2021 09:54:41 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 10 Aug 2021 15:24:41 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [Freedreno] [PATCH 0/3] iommu/drm/msm: Allow non-coherent masters
 to use system cache
In-Reply-To: <20210810091619.GA2494@willie-the-truck>
References: <20210802105544.GA27657@willie-the-truck>
 <CAF6AEGvtpFu8st=ZFNoKjP9YsAenciLxL1zMFi_iqMCvdby73w@mail.gmail.com>
 <20210802151409.GE28735@willie-the-truck>
 <CAF6AEGtzvyEUm0Fc8QT5t9KNK7i0FbFyi7zDM2_PMCzZBp7qbw@mail.gmail.com>
 <20210809145651.GC1458@willie-the-truck>
 <CAF6AEGsSUojA=V0n2iRWTCn++buqN=Eoxo0r3=+=PBu1O=H-AQ@mail.gmail.com>
 <20210809170508.GB1589@willie-the-truck>
 <CAF6AEGtmZ3LzAJdtnKDQDbEN-a6_JgdN-fZ96pkU3dZqkiW91g@mail.gmail.com>
 <20210809174022.GA1840@willie-the-truck>
 <76bfd0b4248148dfbf9d174ddcb4c2a2@codeaurora.org>
 <20210810091619.GA2494@willie-the-truck>
Message-ID: <5b6953c5afdf566c248a2da59f91d9de@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 David Airlie <airlied@linux.ie>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Sean Paul <sean@poorly.run>,
 "list@263.net:IOMMU
 DRIVERS , Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Kristian H Kristensen <hoegsberg@google.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Daniel Vetter <daniel@ffwll.ch>,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-08-10 14:46, Will Deacon wrote:
> On Mon, Aug 09, 2021 at 11:17:40PM +0530, Sai Prakash Ranjan wrote:
>> On 2021-08-09 23:10, Will Deacon wrote:
>> > On Mon, Aug 09, 2021 at 10:18:21AM -0700, Rob Clark wrote:
>> > > On Mon, Aug 9, 2021 at 10:05 AM Will Deacon <will@kernel.org> wrote:
>> > > > On Mon, Aug 09, 2021 at 09:57:08AM -0700, Rob Clark wrote:
>> > > > > But I suppose we could call it instead IOMMU_QCOM_LLC or something
>> > > > > like that to make it more clear that it is not necessarily something
>> > > > > that would work with a different outer level cache implementation?
>> > > >
>> > > > ... or we could just deal with the problem so that other people can reuse
>> > > > the code. I haven't really understood the reluctance to solve this properly.
>> > > >
>> > > > Am I missing some reason this isn't solvable?
>> > >
>> > > Oh, was there another way to solve it (other than foregoing setting
>> > > INC_OCACHE in the pgtables)?  Maybe I misunderstood, is there a
>> > > corresponding setting on the MMU pgtables side of things?
>> >
>> > Right -- we just need to program the CPU's MMU with the matching memory
>> > attributes! It's a bit more fiddly if you're just using ioremap_wc()
>> > though, as it's usually the DMA API which handles the attributes under
>> > the
>> > hood.
>> >
>> > Anyway, sorry, I should've said that explicitly earlier on. We've done
>> > this
>> > sort of thing in the Android tree so I assumed Sai knew what needed to
>> > be
>> > done and then I didn't think to explain to you :(
>> >
>> 
>> Right I was aware of that but even in the android tree there is no 
>> user :)
> 
> I'm assuming there are vendor modules using it there, otherwise we 
> wouldn't
> have been asked to put it in. Since you work at Qualcomm, maybe you 
> could
> talk to your colleagues (Isaac and Patrick) directly?
> 

Right I will check with them regarding the vendor modules in android.

>> I think we can't have a new memory type without any user right in 
>> upstream
>> like android tree?
> 
> Correct. But I don't think we should be adding IOMMU_* anything 
> upstream
> if we don't have a user.
> 

Agreed, once we have the fix for GPU crash I can continue further on 
using
this properly.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
