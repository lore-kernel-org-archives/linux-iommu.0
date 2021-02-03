Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537E1C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 01:50:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF45D64F78
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 01:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF45D64F78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 81A2B85755;
	Wed,  3 Feb 2021 01:50:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lzD8SrKKPDIK; Wed,  3 Feb 2021 01:50:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EFA0B84553;
	Wed,  3 Feb 2021 01:50:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4AF4C0174;
	Wed,  3 Feb 2021 01:50:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA2C3C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 01:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DD7AF868E2
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 01:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yf9oiyS8l-oP for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 01:50:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CF925868DA
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 01:50:20 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id b3so4293311wrj.5
 for <iommu@lists.linux-foundation.org>; Tue, 02 Feb 2021 17:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/sDnQCoBJzd+G1dm09IQlU+bQBdo7KOQBQfZsd1ArQ0=;
 b=nMRLLe8JMleMFMolDyysYg3G2GQLLGzj1p+0EBXMboUMqWvFbD+atIXFkqjAjLYCRk
 7q0uue/yRjX5F1PefvYifacevyoi+t3W9v/PsRcMdG7FP969aw/sZbN9C7jqRK2Kmjae
 +W83nZE99gLaJHAop3T+FycqEXEY5f3Jw1cKOgersHMzdqudPmhNe2yeWd77Xu7uwv51
 E9e8V2leRVC8tyhmmEL1rVBVeYDPuWn61QMwA2ErXa6s0fV+YYprSv5VaPqROjLnMkfA
 WtdiRiRCEWnDBAR3C1rzDR1NSDRnLmuZcAdu4l7nl0YXSuTlkyOehjqnfYu7pt7dHI/9
 OHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/sDnQCoBJzd+G1dm09IQlU+bQBdo7KOQBQfZsd1ArQ0=;
 b=AhVx53CFezrKiR6umqtMXgVj+zuTOkQVb0JpjWo9zb1M760O2JgFTssw2LZqVhBwze
 m3y9rP8D9mUxPEm8x3LdHkucZVlHA4p/OznFeptI7z9RsDq3YJZsJgDKpYqaSJpMVfYB
 pmnhnj8ZRYqQtVZWsZNEtij5W1ZgoRAduYWIpRw7SX7WoihCchP45ZLz3ZqO82UU05n7
 E9t5XipRnHtR1UGF1zDOhHv45UyL+xHL/ttjLN1/qOkKkd1ZUIwcYhIeWGkY+BCVjHm6
 lA9FIQElvz0Oq+1YJRuMXwljG6bmrIE9NQUgxfSlgEINArIqZ0BozTNuVY+QB/XApxf+
 eRVw==
X-Gm-Message-State: AOAM533/TmYkTaf/R0twQ6Hlqxj8qoDM4WZ+Yn7Z8GQ0egBVue1iG5u7
 85FSdtbXKgs7DGs9Kb75ZIdRO93av4kRsLNRIUI=
X-Google-Smtp-Source: ABdhPJyPpgBrxvykPqF+w1syFYv3dXpj7oxP5i2ZCmF+lg81VymYeH3nMLCZptiI1ZZ9uX/6Lz60WIqiFW5oI4LMSkg=
X-Received: by 2002:adf:9427:: with SMTP id 36mr779616wrq.271.1612317019328;
 Tue, 02 Feb 2021 17:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20210202073258.559443-3-zhang.lyra@gmail.com>
 <20210202104257.736836-1-zhang.lyra@gmail.com>
 <20210202140101.GA32671@8bytes.org>
 <992fad43-c457-d809-3bd7-7fd5b6e8fa22@arm.com>
 <20210202144126.GC32671@8bytes.org>
 <5e766b74-ab51-8c47-66c1-ca65bc5743cd@arm.com>
In-Reply-To: <5e766b74-ab51-8c47-66c1-ca65bc5743cd@arm.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 3 Feb 2021 09:49:43 +0800
Message-ID: <CAAfSe-s9ppQBuM81KB_KWaiY5hz3cFAycFP5jd8JXysicoqFGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu: add Unisoc iommu basic driver
To: Robin Murphy <robin.murphy@arm.com>
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>
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

On Wed, 3 Feb 2021 at 02:02, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-02-02 14:41, Joerg Roedel wrote:
> > On Tue, Feb 02, 2021 at 02:34:34PM +0000, Robin Murphy wrote:
> >> Nope, I believe if Arm Ltd. had any involvement in this I'd know about it :)
> >
> > Okay, got confused by thinking of ARM as the CPU architecture, not the
> > company :)
> > But given the intel/ and amd/ subdirectories refer to company names as
> > well, the same is true for arm/.
>
> Right, trying to group IOMMU drivers by supposed CPU architecture is
> already a demonstrable non-starter; does intel-iommu count as x86, or
> IA-64, or do you want two copies? :P
>
> I somehow doubt anyone would license one of Arm's SMMUs to go in a
> RISC-V/MIPS/etc. based SoC, but in principle, they *could*. In fact it's
> precisely cases like this one - where silicon vendors come up with their
> own little scatter-gather unit to go with their own display controller
> etc. - that I imagine are most likely to get reused if the vendor
> decides to experiment with different CPUs to reach new market segments.

Yes, I agree, I believe this iommu unit along with Unisoc's
multi-media modules can be used on other architecture SoCs, not only
ARM based.

>
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
