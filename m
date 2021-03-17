Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1036C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 18:12:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC0864F33
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 18:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC0864F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C23483FB3;
	Wed, 17 Mar 2021 18:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a9BE2vB0HGtm; Wed, 17 Mar 2021 18:12:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id C49B583FAA;
	Wed, 17 Mar 2021 18:12:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A2EDC000B;
	Wed, 17 Mar 2021 18:12:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E942C0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 18:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50848606CA
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 18:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gJQW2e4h0kOJ for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 18:12:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAEAD606A7
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 18:12:47 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id v14so108567pgq.2
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=6R9Mv6f/SaNEKn5oS7zETSYUY2J99UPpRh2/DtC6WYo=;
 b=Ki7fQrXA+Vka3JLESy0J33tQRpDAB3nTPTLvw8wkEoA5vk0q61j5m3xPs7/E2/EHda
 g7E+7LX8pQDuINwjsj+glVU699Jq6cfOqpsy8Mk8IOF1muSUgNUt7zxaPHxgTg/yxXv+
 r+kmFRZ9GTktHCCDzbOGFyM1mvakcfnQOzsGR6eRuzGyBpM50an2ybRT2nOW3ul2QDuk
 rac5Ie8I4ZUAkhgEzfYrPL+SughP5UXMJ3Aj8t1qXHp6z+3QJ0GT6gOljI1btqeKwUNp
 ++Gr/4yjF4aP1WyZy49uxG7s8rYAheYL7SucAK4YT6k2Wx2iKjLDLR2YAtam8NJoYzWF
 DejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=6R9Mv6f/SaNEKn5oS7zETSYUY2J99UPpRh2/DtC6WYo=;
 b=pEuQl/+9YCJzxzlhwze7ojns5p/YFcE8ERE+7r4vLjutWf+/1AZc1yjVp+e+46llUE
 rQTx35oAs7QRkvjN3yXV2/ECLpfPfXeLRL2j2fLXLHBkLc50lGG2quNiKAYrnCqAz0hI
 Af1fFuMOs4Sb1NdL1J48SFQsMM9r5lOpeGIqD5fqaNTuFpP0YR9QIrSUfxf+LtBdPr/+
 T3u2Yz9VYaRSlKVC3X+5KOz0/5G3qdyWNMl4+H1nWC3+F5uUomfT5e9Kr9FskSG2pQc1
 NbacwrFBU6G7LyvloFjDRHcHdn24wknwlFr6Vwgo1jpA9oqCJ9+Y563SfFNO3Vupat/T
 MmKQ==
X-Gm-Message-State: AOAM532M9dZrrohvfIfN/1hR9e4LC9pN86z0PfNM1zEZxseZgwG6+PmS
 p5FIywMfSY4QoV4EIS+1Uco=
X-Google-Smtp-Source: ABdhPJw1qNhTe1UtCPMoD/xEOz3Hgnp4/s3ttvPRhs2IX2qHFVtIzt6dkiiDqvXfJponYkOR4Ks7jQ==
X-Received: by 2002:a63:e715:: with SMTP id b21mr3591899pgi.300.1616004766883; 
 Wed, 17 Mar 2021 11:12:46 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id t18sm21238894pfq.147.2021.03.17.11.12.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Mar 2021 11:12:46 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: =?utf-8?Q?Re=3A_A_problem_of_Intel_IOMMU_hardware_=EF=BC=9F?=
Date: Wed, 17 Mar 2021 11:12:44 -0700
In-Reply-To: <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Cc: chenjiashang <chenjiashang@huawei.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 "will@kernel.org" <will@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============5910671673957847982=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5910671673957847982==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_A150222F-8DB0-4FA5-A6D7-57FC77A26ACC";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_A150222F-8DB0-4FA5-A6D7-57FC77A26ACC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 17, 2021, at 2:35 AM, Longpeng (Mike, Cloud Infrastructure =
Service Product Dept.) <longpeng2@huawei.com> wrote:
>=20
> Hi Nadav,
>=20
>> -----Original Message-----
>> From: Nadav Amit [mailto:nadav.amit@gmail.com]
>>>  reproduce the problem with high probability (~50%).
>>=20
>> I saw Lu replied, and he is much more knowledgable than I am (I was =
just intrigued
>> by your email).
>>=20
>> However, if I were you I would try also to remove some =
=E2=80=9Coptimizations=E2=80=9D to look for
>> the root-cause (e.g., use domain specific invalidations instead of =
page-specific).
>>=20
>=20
> Good suggestion! But we did it these days, we tried to use global =
invalidations as follow:
> 		iommu->flush.flush_iotlb(iommu, did, 0, 0,
> 						DMA_TLB_DSI_FLUSH);
> But can not resolve the problem.
>=20
>> The first thing that comes to my mind is the invalidation hint (ih) =
in
>> iommu_flush_iotlb_psi(). I would remove it to see whether you get the =
failure
>> without it.
>=20
> We also notice the IH, but the IH is always ZERO in our case, as the =
spec says:
> '''
> Paging-structure-cache entries caching second-level mappings =
associated with the specified
> domain-id and the second-level-input-address range are invalidated, if =
the Invalidation Hint
> (IH) field is Clear.
> '''
>=20
> It seems the software is everything fine, so we've no choice but to =
suspect the hardware.

Ok, I am pretty much out of ideas. I have two more suggestions, but
they are much less likely to help. Yet, they can further help to rule
out software bugs:

1. dma_clear_pte() seems to be wrong IMHO. It should have used =
WRITE_ONCE()
to prevent split-write, which might potentially cause =E2=80=9Cinvalid=E2=80=
=9D (partially
cleared) PTE to be stored in the TLB. Having said that, the subsequent
IOTLB flush should have prevented the problem.

2. Consider ensuring that the problem is not somehow related to queued
invalidations. Try to use __iommu_flush_iotlb() instead of
qi_flush_iotlb().

Regards,
Nadav

--Apple-Mail=_A150222F-8DB0-4FA5-A6D7-57FC77A26ACC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBSRpwACgkQHaAqSaba
D1pSbA/+LqJLr9Y2YXuVIsHqaLxly8NVGMOQ+GsbFBn8WkKdGfFNKkbyqmIE73Oh
JrhXL8onOumvjBRp7XOFq1xoL+MMbE0yhoxsnl4NzSgyTYV+DcrIIT0rntg6ci4f
WTkjI4h8s+lS6FAmN6zFQlGz30vkVle+TuTN3ZJgye+Ydisi95pSNm1OQu6R2bvK
wmXEuxM2LjGd49yCSxbzBcNVNR6fEKWqF8ADpIs+PoNUtCcHoILH0To3lchKc937
p/MSII7D6rIu4q9upUzzTYO5OEfsJcIcFjTRgPJ8f6nzEM8OrMK5jzB8kFOtysvs
JJ+zxpodFwYZnhllYENrtQwDIsMhWHDUQeNqlpnBRLM6FpbF+AHOd/jSOjz6TV1c
dw64BMAINGVTFm6aVdkJdOpM/LW7So7hkrJoReMG5GJMAs1JXRBeWHTzKGd/Liyy
q6LPUPVbYzi29ebcleg9JH+2olgeSzKy+D9XxvpOnIX6g5ypp1ehJj4NYXCvIi8p
/1Tw84I1glMNfure/jNU/XUlyrNYAkMHPrFdSslTUMCUHzFgAP+u3VX7xdvaN0xO
VfUdjww5pZqrTiZoOZXlwCc1Rp2aoEz9wKfU3Rf7hnH4oQxQR0z201l4mEMhjW3/
7u3U2lEys6WuqaD2B/RfgKxqNQ6dgZXthvez6N0EvE1Duv8DH90=
=m29n
-----END PGP SIGNATURE-----

--Apple-Mail=_A150222F-8DB0-4FA5-A6D7-57FC77A26ACC--

--===============5910671673957847982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5910671673957847982==--
