Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088BBC433C1
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 12:58:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9602061934
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 12:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9602061934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C97A4030F;
	Mon, 29 Mar 2021 12:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0j5cz2LvWG1O; Mon, 29 Mar 2021 12:58:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 584A7402FD;
	Mon, 29 Mar 2021 12:58:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31916C000C;
	Mon, 29 Mar 2021 12:58:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A159C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 12:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A98240303
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 12:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J2BCx3pDn8TQ for <iommu@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 12:58:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A522402FD
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 12:58:02 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id f12so9199730qtq.4
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=pXwScAbp9Oc9UUM+Y5MFv/NyYb1m2Ax9bkESJHn7OoM=;
 b=jIMlPhrnPxBkc1eIt0loxmUFn7wXXfPXYhzlXGaYPnegO6aUyr7PCPcsU1Q/nPx2fP
 z9dSO77ODJpoGbIqBdLPzf7Hmx+na9zXd2cZJ4qd9BBfUIDW2OzJWYE465wjBIWAuRrr
 NWCMehNEk3cJZY3zjwb6ZOQi1NkbEq5fCcB0n+UlGn7E/x8I9ZccVrQAOLQEjvvAhPgW
 gyvGu7fxdumQ9rlYgMvh+Gznzjnn6Qsqul2TwzNQVb6EA6ue+DdlAwS1sDkE02lS2xyR
 3n4LD+Mz6IiTzqnrhisHrhIHhSDc4vM/80A7UAKxL/KmVUJHzyawP00LVXC3wRmxEBMs
 lnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=pXwScAbp9Oc9UUM+Y5MFv/NyYb1m2Ax9bkESJHn7OoM=;
 b=QS2lwWCL8rfJwUNESe7rZKu3Uv6G7+pwth69BeCbr2NgjK2b768/MUrC0Invv/lnM6
 XElhpCXNiERK4FlKx+fEurTUyBE79MP8tt45JRxaHr64j8ylI7i4J4bKziEC96+UxyTY
 +VMIuORtCn4WbZZ3Jfh8Z5nTvZdDh/8zSHw0yNW1J1zaWBahf0+JQ8mbztukcCWImO6E
 2WnFHU5HqWjw4DC++iesGnxWVeOO/7M+jJCngKSolvJlC1boJRSiZRcMHlrynsYafODL
 D0ObX7EMCpxlVMe7Li6pt2n/XLl1nhULlWITVPnorEei+X/Y8aKiBlR9/sizYTE8mx4H
 PpkQ==
X-Gm-Message-State: AOAM5327l6SNSG62shDImOb8mqGEI6WnajBE7TLY+yfuCpYZrVvaZ8QB
 eVRjFZZixs8lVntno6HTclw=
X-Google-Smtp-Source: ABdhPJzGuB5bAHBNMyTzE3y0baxdhpY1BDoada/eHGqWehXn5kNmFoyZ95oSsGX4Gf6P46twv8R/cA==
X-Received: by 2002:aed:2ea4:: with SMTP id k33mr22317560qtd.169.1617022681256; 
 Mon, 29 Mar 2021 05:58:01 -0700 (PDT)
Received: from Gentoo ([37.19.198.130])
 by smtp.gmail.com with ESMTPSA id y1sm13368206qki.9.2021.03.29.05.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Mar 2021 05:58:00 -0700 (PDT)
Date: Mon, 29 Mar 2021 18:27:43 +0530
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/30] DMA: Mundane typo fixes
Message-ID: <YGHOxwiqwhGAs819@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org
References: <cover.1616971780.git.unixbhaskar@gmail.com>
 <20210329052910.GB26495@lst.de> <YGFrvwX8QngvwPbA@Gentoo>
 <YGG+l1EfRuWp0J3A@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YGG+l1EfRuWp0J3A@kroah.com>
Cc: dave.jiang@intel.com, Linus Torvalds <torvalds@linux-foundation.org>,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============2607397375277405881=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2607397375277405881==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5zclouQno4veQbB1"
Content-Disposition: inline


--5zclouQno4veQbB1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:48 Mon 29 Mar 2021, Greg KH wrote:
>On Mon, Mar 29, 2021 at 11:25:11AM +0530, Bhaskar Chowdhury wrote:
>> On 07:29 Mon 29 Mar 2021, Christoph Hellwig wrote:
>> > I really don't think these typo patchbomb are that useful.  I'm all
>> > for fixing typos when working with a subsystem, but I'm not sure these
>> > patchbombs help anything.
>> >
>> I am sure you are holding the wrong end of the wand and grossly failing to
>> understand.
>
>Please stop statements like this, it is not helpful and is doing nothing
>but ensure that your patches will not be looked at in the future.
>
Greg, don't you think you are bit harsh and have an one sided view? People can
say in better way if they don't like some work. I Have always try to get
along.
>> Anyway, I hope I give a heads up ...find "your way" to fix those damn
>> thing...it's glaring....
>
>There is no requirement that anyone accept patches that are sent to
>them.  When you complain when receiving comments on them, that
>shows you do not wish to work with others.
>
Unfortunate you are only seeing my complains...I don't know why you are so
blindfolded.
>Sorry, but you are now on my local blacklist for a while, and I
>encourage other maintainers to just ignore these patches as well.
>
I can not overrule that ...I know my pathes are trivial ..but it seems some
other problems are looming large.

NOT good Greg....not good seriously.
>thanks,
>
>greg k-h

--5zclouQno4veQbB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBhzsAACgkQsjqdtxFL
KRW2qwf+LpIRIiK3vSyhfOkc5KEs6+JY1kuwY5zK8zNexJI+BFNVlKy2fiJDI5OJ
ohAkhZ7u6VPXdYX4JVipyUMEVaBJRI36ebb2fl5JhhjKdp+xaw+1pP+AMIXET/SS
mxlbUWkBiwZvlebkm26R/LDfJ6BMh8uOTth09mP9SEzfLvL41TJotFlJnCZ7+Akq
RtQfuF4c4a6g4rkBMbKz9GFP35UIl8xrQB9roiynNg8abT7mP0mfBYEa+yofDdA5
dmOmw22RwwuXueZhidrSifQYP4F0h/3zrUTetKYa4MZYUVnIR/Lvpa9K6U6xjuIb
rHZf1I6RXTsmUcErV7E2MR4mZEjStg==
=YLCg
-----END PGP SIGNATURE-----

--5zclouQno4veQbB1--

--===============2607397375277405881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2607397375277405881==--
