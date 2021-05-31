Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50058C47082
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 20:11:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7CB60E0B
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 20:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7CB60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71ED3403AA;
	Mon, 31 May 2021 20:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fCJLm4UB44Vk; Mon, 31 May 2021 20:11:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBE6F4033D;
	Mon, 31 May 2021 20:11:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF1E3C000E;
	Mon, 31 May 2021 20:11:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 047F9C0001
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 20:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA39740236
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 20:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LCnbG_Hr1ThL for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 20:11:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BECB1400CF
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 20:11:47 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id k15so3400531pfp.6
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=A5NonEOJI6X+iSa1j5osPVCbT473seVAsEqrZiOMN5A=;
 b=MnIags46LmxB6Q3GOsE+JBcoVjjvtUOdTgdH469mEKkf9XnO7u8VWTm3Z9n+4APOZG
 TsGINJN+9ZfelJHlECtn5k8xB46vAegxMKSJD6cWWBPOu6pRqFrYY+vXTclVMRfRwph/
 4quX0X6cSSWgyJRPAA+mQyOuvOlMNsT9B+CMWC9L7xBIG5iYNw48vjoAGQDeD9j5ZEHK
 Mp9cNrVCxiDHppyuOIeblbqZpW8ZtQbQ952neMXcinbmN/kidMUaylkqpXy9sPSbMDLq
 +8NIIlM6FG+MzcdKkcyASkXtfEddf/SLPWEmDqbvXmNPGo8dp1jyOfixLHUe2tfy4e0J
 JlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=A5NonEOJI6X+iSa1j5osPVCbT473seVAsEqrZiOMN5A=;
 b=L1GJJ+kz8MvCQzh2inJRQMstBVuFqxLcZF2wDo6/Y6GayYAkcWJFtMLGDoZYNvD3QP
 wB2YxlAdM+glwUDyBZ15KsZf/ZtugiGdYx0wYN7hsEnrNyzYPcPjE0fIfyUy3jMcckWr
 mFrEkZ60hrJGrnoUDKgaFa90IuO0ExExT1uMtRaDAVtCQy7m6Gmbxl8wcNZAXlqLLs24
 V7VduyCYjoiwMPRglGpkiDw8BubFHxZe0Evizf9r9vUP5jeQYvegfW8MnzfuUZ2bUEAQ
 QNksVudqVunji6bxjGFlI0cpkSjUDUft2ItYGJfDwbu7Z3a1jtkX4YdojIr98v23JCsV
 UcyQ==
X-Gm-Message-State: AOAM5322LplSCfzK3jPuyaNbi46F/cl0Jy65/9F9DpigwkZbgazMjS/j
 6lCHWXIZ4fE5McKmyss4anY=
X-Google-Smtp-Source: ABdhPJzIBUpoLRhn9O4HGxhm1gdX1K8+NSNS8yoK8dol192cODOR+oKQ4O6WZQJga2mvzz39zk6JvA==
X-Received: by 2002:a63:f209:: with SMTP id v9mr4093567pgh.98.1622491907026;
 Mon, 31 May 2021 13:11:47 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id z185sm6794716pgb.4.2021.05.31.13.11.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 May 2021 13:11:45 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <0CD8AE55-ACE2-4647-B88B-BD8CFB8EF710@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/4] iommu/amd: Fix wrong parentheses on page-specific
 invalidations
Date: Mon, 31 May 2021 13:11:44 -0700
In-Reply-To: <YKOHmQcqW0bX59nV@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
References: <20210502070001.1559127-1-namit@vmware.com>
 <20210502070001.1559127-2-namit@vmware.com> <YKOHmQcqW0bX59nV@8bytes.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Jiajun Cao <caojiajun@vmware.com>, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============6057156006906048488=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6057156006906048488==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_BBA08D47-C8FB-47BC-A7B3-A9C4053E98CB";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_BBA08D47-C8FB-47BC-A7B3-A9C4053E98CB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On May 18, 2021, at 2:23 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> On Sat, May 01, 2021 at 11:59:56PM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> The logic to determine the mask of page-specific invalidations was
>> tested in userspace. As the code was copied into the kernel, the
>> parentheses were mistakenly set in the wrong place, resulting in the
>> wrong mask.
>>=20
>> Fix it.
>>=20
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jiajun Cao <caojiajun@vmware.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
>> Fixes: 268aa4548277 ("iommu/amd: Page-specific invalidations for more =
than one page")
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> drivers/iommu/amd/iommu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Applied this one for v5.13, thanks Nadav.
>=20
> Somehow the rest of the patch-set got screwed up during sending or so,
> at least I see some patches twice in my inbox and with different
> subjects.
>=20
> Can you please re-send patches 2-4 when -rc3 it out?

Joerg,

Thanks for your understanding. I sent a version based on -rc3 a week
ago.

I noticed that there was some confusion regarding rc numbers. Do you
need a new version based on rc4 or can you apply the version I sent?

Thanks,
Nadav


--Apple-Mail=_BBA08D47-C8FB-47BC-A7B3-A9C4053E98CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmC1QwAACgkQHaAqSaba
D1pHBQ//bjXmrz56/GSk8vNkNa0Q9oZRsKy06eOkS+oUxh4qMwNQgBfbJ5oB2psG
5UBtczZyTK8QCLT4M8N/Ixp4wkpy0If1g7lJk+rmRGkwZCvjskZTTtJR1LFL7jcm
3BVeiM0K7VScOp/PPoKRXse7Aimx32RG+8a2DlYyYwVOXQ9hT4tOloc0pWP2QHYd
NAseialDlyb2t36IN2n5NaUGrXTRXomtOMLW8/aHHrmCBrU1X3mS1Wkm8NuL1p14
uetWJrrAlrmx3uOPRuZbgHlqA7Vw6X9GAoqVXrjaAkAXc7ucdtXN09u+H9jAG7pC
bV/qlFEQxXh8NTi4G16+ycGOyQ9WYR1fSUl6Y0/jYiEQPeI5eC0N54JICiQJ2QCk
9E7kJT78P+L9Ia3lpHWuECI1SIKidWgkqgFdaOvj3gtA5AEH2BSZC/+tkGchuPAT
GNzUeQjR172mmnX4L5LEYabN7MK9fOqH2FmcFIJCChGGW0Gc+IS+KANuMZk+7UoX
HGnHQIBmBvUe0oFvpIJdRvXwj/3mWARsGddyQpMcO+ifdp/GJOPBq1o6/y4PHDhe
6HVT0pkZlF/N2Le+73MLSsg/gn395i7MPeDy41BceljaqO+encNhEocq3IM59eZU
LaFcEG9pD/vhqZ4G8nPESMnqiLw9nmpAqkqwzmzBbOJvH23YSl0=
=BKpm
-----END PGP SIGNATURE-----

--Apple-Mail=_BBA08D47-C8FB-47BC-A7B3-A9C4053E98CB--

--===============6057156006906048488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6057156006906048488==--
