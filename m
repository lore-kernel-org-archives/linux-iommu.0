Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF2C433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 16:46:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C6664F11
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 16:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C6664F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2847C4EDEC;
	Thu, 18 Mar 2021 16:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xiT-TmIlpbFB; Thu, 18 Mar 2021 16:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73BB54ECD1;
	Thu, 18 Mar 2021 16:46:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59091C000A;
	Thu, 18 Mar 2021 16:46:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74855C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 16:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 556A54EDEC
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 16:46:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6lK4aFnTPPpX for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 16:46:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A6FA4ECD1
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 16:46:28 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id v23so1587431ple.9
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=K7cmjlKDt5VlEvWEdEll0s99wacx/LQvmo6huy4XAJk=;
 b=uECoFQZHEhCoMa+8JG3mMIKst/32x14zADp2ac6b8nvnDnHDELenqdboXZ5JixjLUn
 yE2u+lR2cFrMnkDiLQ8vZEkDz+sHB8DP0hagBi3ZbKw/X7IC0gvrKYkYEliCC4KS1SV/
 2rG+SKp/cFR8yStqA5my3gInPyUV+aRunCzOpTDgmJfrJFJsJmM5iUnScVe/sik4LpTi
 SPij7y1/4DsvsgqKWRnnqmi2KEfvbNASmWsGe/UmjNzlCndPoH3eD4hHSpsUY81KwuhI
 RKCZjtGB8eNQsmeFzQpBWv6dHvMcTkNsVFYcoNjsfd9+9gVxeMEkkNKdOproRFup+I8z
 KQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=K7cmjlKDt5VlEvWEdEll0s99wacx/LQvmo6huy4XAJk=;
 b=iaJGILreRf1rMWzZDPS7EUZ/LKAdN+6UIeO6BTuwB3cgiptR/NeuHoubb7zavKiI6r
 rI/ucwlDMSPzt9AAfLCaWiY/T4VD5Vs7t+MK9I68h6cpEw4bEorXIXpR7UQ3NVLOqBn7
 1C6qmgc+v99LN0A3IkynW3RK7eN6dCjsyyUfo0Q7jrZ4Y6rjz6hH84lhIGpdaFJf/udk
 IDMUZeRP1SXdHrnikykHSy+CDjXcphqibhRY817acF8DQj5L0pzd72Jc7i+xp4Sr9ZCl
 NtbewJqLcBuUzbFCCdgTT6EiDo9DT8HsmUE9wXJoOBFUR5EiLA0jzLQDqB4t4aAgK5dy
 0bUw==
X-Gm-Message-State: AOAM531ntkD5+xZvktWJPmoj8wqW280OFbcv8A1BvbU1ORWTt4zWc9QJ
 TCaYRoTt6++9d2BHrnFG5hY=
X-Google-Smtp-Source: ABdhPJzsCY+w1rzWGEtojAeKogexNttlx77YmGhoAAvhZuY0BRLMYxhfPxDtzmKMtmT5QkCM2UNp0A==
X-Received: by 2002:a17:902:7792:b029:e6:caba:f836 with SMTP id
 o18-20020a1709027792b02900e6cabaf836mr7839440pll.41.1616085987457; 
 Thu, 18 Mar 2021 09:46:27 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id e1sm3110987pfd.72.2021.03.18.09.46.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Mar 2021 09:46:26 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <55E334BA-C6D2-4892-9207-32654FBF4360@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: =?utf-8?Q?Re=3A_A_problem_of_Intel_IOMMU_hardware_=EF=BC=9F?=
Date: Thu, 18 Mar 2021 09:46:24 -0700
In-Reply-To: <e5b262c1ee14481ab68074be2a76b9d9@huawei.com>
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <e5b262c1ee14481ab68074be2a76b9d9@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Cc: chenjiashang <chenjiashang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
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
Content-Type: multipart/mixed; boundary="===============2202559929731666306=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2202559929731666306==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_2461370B-E161-42A6-80A6-69B3716EF29B";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_2461370B-E161-42A6-80A6-69B3716EF29B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 18, 2021, at 2:25 AM, Longpeng (Mike, Cloud Infrastructure =
Service Product Dept.) <longpeng2@huawei.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: Tian, Kevin [mailto:kevin.tian@intel.com]
>> Sent: Thursday, March 18, 2021 4:56 PM
>> To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>> <longpeng2@huawei.com>; Nadav Amit <nadav.amit@gmail.com>
>> Cc: chenjiashang <chenjiashang@huawei.com>; David Woodhouse
>> <dwmw2@infradead.org>; iommu@lists.linux-foundation.org; LKML
>> <linux-kernel@vger.kernel.org>; alex.williamson@redhat.com; Gonglei =
(Arei)
>> <arei.gonglei@huawei.com>; will@kernel.org
>> Subject: RE: A problem of Intel IOMMU hardware =EF=BC=9F
>>=20
>>> From: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>>> <longpeng2@huawei.com>
>>>=20
>>>> -----Original Message-----
>>>> From: Tian, Kevin [mailto:kevin.tian@intel.com]
>>>> Sent: Thursday, March 18, 2021 4:27 PM
>>>> To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>>>> <longpeng2@huawei.com>; Nadav Amit <nadav.amit@gmail.com>
>>>> Cc: chenjiashang <chenjiashang@huawei.com>; David Woodhouse
>>>> <dwmw2@infradead.org>; iommu@lists.linux-foundation.org; LKML
>>>> <linux-kernel@vger.kernel.org>; alex.williamson@redhat.com; Gonglei
>>> (Arei)
>>>> <arei.gonglei@huawei.com>; will@kernel.org
>>>> Subject: RE: A problem of Intel IOMMU hardware =EF=BC=9F
>>>>=20
>>>>> From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf
>>>>> Of Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>>>>>=20
>>>>>> 2. Consider ensuring that the problem is not somehow related to
>>>>>> queued invalidations. Try to use __iommu_flush_iotlb() instead
>>>>>> of
>>>> qi_flush_iotlb().
>>>>>>=20
>>>>>=20
>>>>> I tried to force to use __iommu_flush_iotlb(), but maybe something
>>>>> wrong, the system crashed, so I prefer to lower the priority of
>>>>> this
>>> operation.
>>>>>=20
>>>>=20
>>>> The VT-d spec clearly says that register-based invalidation can be
>>>> used only
>>> when
>>>> queued-invalidations are not enabled. Intel-IOMMU driver doesn't
>>>> provide
>>> an
>>>> option to disable queued-invalidation though, when the hardware is
>>> capable. If you
>>>> really want to try, tweak the code in intel_iommu_init_qi.
>>>>=20
>>>=20
>>> Hi Kevin,
>>>=20
>>> Thanks to point out this. Do you have any ideas about this problem ? =
I
>>> tried to descript the problem much clear in my reply to Alex, hope =
you
>>> could have a look if you're interested.
>>>=20
>>=20
>> btw I saw you used 4.18 kernel in this test. What about latest =
kernel?
>>=20
>=20
> Not test yet. It's hard to upgrade kernel in our environment.
>=20
>> Also one way to separate sw/hw bug is to trace the low level =
interface (e.g.,
>> qi_flush_iotlb) which actually sends invalidation descriptors to the =
IOMMU
>> hardware. Check the window between b) and c) and see whether the =
software does
>> the right thing as expected there.
>>=20
>=20
> We add some log in iommu driver these days, the software seems fine. =
But we
> didn't look inside the qi_submit_sync yet, I'll try it tonight.

So here is my guess:

Intel probably used as a basis for the IOTLB an implementation of
some other (regular) TLB design.

Intel SDM says regarding TLBs (4.10.4.2 =E2=80=9CRecommended =
Invalidation=E2=80=9D):

"Software wishing to prevent this uncertainty should not write to
a paging-structure entry in a way that would change, for any linear
address, both the page size and either the page frame, access rights,
or other attributes.=E2=80=9D


Now the aforementioned uncertainty is a bit different (multiple
*valid* translations of a single address). Yet, perhaps this is
yet another thing that might happen.

=46rom a brief look on the handling of MMU (not IOMMU) hugepages
in Linux, indeed the PMD is first cleared and flushed before a
new valid PMD is set. This is possible for MMUs since they
allow the software to handle spurious page-faults gracefully.
This is not the case for the IOMMU though (without PRI).

Not sure this explains everything though. If that is the problem,
then during a mapping that changes page-sizes, a TLB flush is
needed, similarly to the one Longpeng did manually.



--Apple-Mail=_2461370B-E161-42A6-80A6-69B3716EF29B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBTg+AACgkQHaAqSaba
D1oXNQ/+M4yG2Y/ypG1/6PNYiemO9pw94yEWceYzEcFBfk42yXoCls0fzGnd5pRx
lG0BSQiOzDyQf4y2Vac0KtqRM4JG/bi6qYwS8rwnSqouC89I0axd1xvsa++ar8Cr
NTBd3Htrey1YhM+vsHVCY3vRJ35Mgdukw1OgcXPsrt5yGiTUkm1UFJ1c2ev1Skf4
mIr5L1A2obJ9T0rPmivpq5QDJwcUTUQRIARKazHsCG3xYOQZ6N/nyrh9kjrD/zQN
aKkcMdFG/N8xtOJ0/MpQH2nRMBNnlAB13H8pozP12FcKvXwq3pnoj/MNyCSO5bF6
zsflFOI3wB7tkYX2xXiGQUmRxv1jWY0Scc+Axm2zlQJxtvFQKFUuAWS5U/nwXeOp
Dl4ehEfc70LzSC2olZmQhlmFnJ1bSATY+X00Zwluo1qlF2DE2LuJ0Yi7yKcAxxoe
y3bhh+qSyFOC2f88Dmp8B3ya/Xqf4fEfOmdqnfeE7XRX5sNhCvkLq1/KAvZqNMI2
xk95GUr/NTeJ3lC+n4UM7RHMRJ0DKH5nw84SKT2cObGaUyHUEN303hwlgyvbMigM
TYy3Pb9Cw5jzOEqRQkxA2cuYNS+ru+T6hFRXx6PA4aOA5XuJGzgNnpVu9L30XV9o
bZux+uOoOFy9s/c6S/YHfZSz2yKy9UzPOkQmvFwtgNNkIr+NRiI=
=zZw2
-----END PGP SIGNATURE-----

--Apple-Mail=_2461370B-E161-42A6-80A6-69B3716EF29B--

--===============2202559929731666306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2202559929731666306==--
