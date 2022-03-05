Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205D4C433F5
	for <iommu@archiver.kernel.org>; Sat,  5 Mar 2022 19:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACB5660B3A;
	Sat,  5 Mar 2022 19:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a3FUc9GElB-u; Sat,  5 Mar 2022 19:45:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6CCF960B10;
	Sat,  5 Mar 2022 19:45:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43F45C001D;
	Sat,  5 Mar 2022 19:45:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C409DC000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 19:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B305E8183D
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 19:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h5UWR5kI2XV9 for <iommu@lists.linux-foundation.org>;
 Sat,  5 Mar 2022 19:45:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED63081770
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 19:45:11 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id j15so19722877lfe.11
 for <iommu@lists.linux-foundation.org>; Sat, 05 Mar 2022 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LPoOJ4AaVNL3oCNAAPlELZgxMH2Mdvtu3dbXK4LFzGs=;
 b=VP5ml3rhFccJpQT10F3e7U/zoXUd4YieWbaCb33Zddq/fZ5PPyqKrvHehNKXJqspFK
 t0tbIAsfMCXqBZGAxQ7y5zWU067Uum1XlNQ1M5GMkpzR6hRmOjp5TBpqLxpXZ+9kLLXT
 asBh+rJ5Sj8uEdX26hAQGU9heQsqmTwvFUnvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LPoOJ4AaVNL3oCNAAPlELZgxMH2Mdvtu3dbXK4LFzGs=;
 b=EW5iOOKj8KYXSsiV1aRjw7WHC5qV2V3iiq7RfvCqpZjlMl99d7F0FB3IsGfip5l0B1
 XrzWfrEQZ69AoHJvgkp2dbr113duDSk8gN5ndv2+B5WyqT+5epUASgijHlJxRnc+S8Xu
 XVEQCuaK3JXUqTvAiev4IQxXN0fkHOZ+jsMn1CaGQf903oPYugvfIA8vb2AZ/I1zkcdi
 hWT1gAl9YNhviNnqqS9rjR15Fd/bPJltpGMokzNlS7oaVMC1wawqyHyxprkdxfiBgSV2
 OxqyNX7A5ZysXl0c0AEN8TeZx2vEuT3Mlr2tpAgtAPN+YcFuhJOJqdsKDtJy9vEPxb2l
 pmrA==
X-Gm-Message-State: AOAM533iRoUpGeaYLHTLY96q1JpGerdnlyoMykComTJ2hDrwKPHGwyTF
 jed5vEXHi75zasn22mRlyUrlNlQJTm8v83u2kU+dJA==
X-Google-Smtp-Source: ABdhPJxDlFoMaOTvofqQfG7/qJiHZe/Qj7zNKpXCba49MrmoAaG45TOTEjiqD66z4QiGOD9aQ3CPeg==
X-Received: by 2002:a05:6512:b04:b0:447:6d2f:3aa2 with SMTP id
 w4-20020a0565120b0400b004476d2f3aa2mr3006687lfu.69.1646509509638; 
 Sat, 05 Mar 2022 11:45:09 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49]) by smtp.gmail.com with ESMTPSA id
 u14-20020a056512094e00b0044382769fbesm1832874lft.181.2022.03.05.11.45.08
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Mar 2022 11:45:08 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id b11so19739946lfb.12
 for <iommu@lists.linux-foundation.org>; Sat, 05 Mar 2022 11:45:08 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr3118225lfi.52.1646509508091; Sat, 05
 Mar 2022 11:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20220305170714.2043896-1-pasic@linux.ibm.com>
In-Reply-To: <20220305170714.2043896-1-pasic@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Mar 2022 11:44:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZ6fNG03pd2pAVw9RtymwPDyHNvTLHr2Q3LX3S0Y1k5Q@mail.gmail.com>
Message-ID: <CAHk-=wgZ6fNG03pd2pAVw9RtymwPDyHNvTLHr2Q3LX3S0Y1k5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swiotlb: rework "fix info leak with
 DMA_FROM_DEVICE"
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>, Doug Gilbert <dgilbert@interlog.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
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

On Sat, Mar 5, 2022 at 9:07 AM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> Unfortunately, we ended up merging an old version of the patch "fix info
> leak with DMA_FROM_DEVICE" instead of merging the latest one. Christoph
> (the swiotlb maintainer), he asked me to create an incremental fix
> (after I have pointed this out the mix up, and asked him for guidance).
> So here we go.
 [...]

Christoph, I am assuming I'll get this from you, but if you have
nothing else pending, just holler and I can take it directly.

That said, it seems sad to bounce the buffer just in case the device
doesn't do what we expect it to do. Wouldn't it be better to just
clear the buffer instead of copying the old data into it?

Also, possibly stupid question - when is swiotlb used in practice
these days? What are the performance implications of this? Will this
mean completely unnecessary copies for all normal IO that will be
overwritten by the DMA? Can't we limit it to just SG_IO (or is it
already for some reason)?

                  Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
