Return-Path: <SRS0=Y/a2=IZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E402EC433DB
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 04:36:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258DC61993
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 04:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258DC61993
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C318D6060E;
	Sat, 27 Mar 2021 04:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPCCSRdDTnk9; Sat, 27 Mar 2021 04:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9441E6058A;
	Sat, 27 Mar 2021 04:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C159C000B;
	Sat, 27 Mar 2021 04:36:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6875C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 04:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95FBA418BF
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 04:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0CowJB7vjwEV for <iommu@lists.linux-foundation.org>;
 Sat, 27 Mar 2021 04:36:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D717418B8
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 04:36:50 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id w8so3498515pjf.4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 21:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=mkD8zOj3vYUxpklE5crr2Nc4MGr1kO5p6EdWYvS18hQ=;
 b=ncTg2Hsdw0l7VdTT1O9MouzHlSNItIIqMwfOeFwd0xpnARcBugYq5oCBKD1bbXZnt2
 dDMrHvS/oQs0sLTZrOspI+Xy2Ga3C7E/9XIrMJI4zTrX9jta+H1PKxLmLVenaK3HSms1
 I9OTnRm92lNMIi0SlQYK36SPKqexTwfuCkUBpBQU6oZjmY43IOOymAlYqM2UcOrOhNTD
 +uvcMuP4kONNxhM3zVL7oSAJU1I56j33TActSFOeZgrepZMfVL1EK9NcdjlIcRIN0OIY
 eLJapXUTi5+b0FwMgG9uf4+g7Bq0fiLBp64b4wWjCqNwvqecpHkL9P89SsBqW4trv9bZ
 qLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=mkD8zOj3vYUxpklE5crr2Nc4MGr1kO5p6EdWYvS18hQ=;
 b=ZzxzuwPPRz0qJMIZ4ENFGmRcjoMCJenm8RxJeDpzvtYvvreJIREGK/CYSQ2uBp6pwz
 bx+UqKXVQI3TFnYWwM+2W7eDyTgWAujdkOHiMbd21hAn8MOhpX00AadFeWE7loZPHvTE
 Txj6Mamh7FP3BXQhAgWLfK9nAX8nCJXGuxrLfj3LE2zVdBXg7oyJBWP+L9q8qTM0Yjy1
 wdFlMrgcghgv7PRRaN0bBf2KnI3C83HZHo0y6hgp4K44Gj/6m+ic6qwVyv0lS2QXikj+
 Pddp7aCxul4kNnq0Bjp/gAY3LQzlvVwpEl3wwksj+KCaUYKEf50Mc1iR7vrNC6K5xcT6
 oRHQ==
X-Gm-Message-State: AOAM531pVR9T06SWgGCyhJxpOzxIPryhHraRiF4nhAljDfg7sCA9m4Gm
 bWqZxScc0oZHtyMJVBLyyyc=
X-Google-Smtp-Source: ABdhPJztdRRCfYBCQaJM3p9Go8WBNZPrCGTEYryZrJpFQOrm8DnyUGICJ4lrSxBhHjDP4MFc6D8+Kw==
X-Received: by 2002:a17:90a:a414:: with SMTP id
 y20mr16640992pjp.77.1616819809644; 
 Fri, 26 Mar 2021 21:36:49 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id p25sm10875717pfe.100.2021.03.26.21.36.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Mar 2021 21:36:48 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <55A4B205-BC38-4F16-9EB9-54026C326E60@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: =?utf-8?Q?Re=3A_A_problem_of_Intel_IOMMU_hardware_=EF=BC=9F?=
Date: Fri, 26 Mar 2021 21:36:46 -0700
In-Reply-To: <14fe0083-cbff-884c-34db-ce3227e026f5@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <e5b262c1ee14481ab68074be2a76b9d9@huawei.com>
 <55E334BA-C6D2-4892-9207-32654FBF4360@gmail.com>
 <14fe0083-cbff-884c-34db-ce3227e026f5@linux.intel.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Cc: chenjiashang <chenjiashang@huawei.com>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, "Longpeng \(Mike,
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>,
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
Content-Type: multipart/mixed; boundary="===============0827179654087546388=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0827179654087546388==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_35D28607-8F18-4860-BA01-DF07CD351738";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_35D28607-8F18-4860-BA01-DF07CD351738
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 26, 2021, at 7:31 PM, Lu Baolu <baolu.lu@linux.intel.com> =
wrote:
>=20
> Hi Nadav,
>=20
> On 3/19/21 12:46 AM, Nadav Amit wrote:
>> So here is my guess:
>> Intel probably used as a basis for the IOTLB an implementation of
>> some other (regular) TLB design.
>> Intel SDM says regarding TLBs (4.10.4.2 =E2=80=9CRecommended =
Invalidation=E2=80=9D):
>> "Software wishing to prevent this uncertainty should not write to
>> a paging-structure entry in a way that would change, for any linear
>> address, both the page size and either the page frame, access rights,
>> or other attributes.=E2=80=9D
>> Now the aforementioned uncertainty is a bit different (multiple
>> *valid*  translations of a single address). Yet, perhaps this is
>> yet another thing that might happen.
>> =46rom a brief look on the handling of MMU (not IOMMU) hugepages
>> in Linux, indeed the PMD is first cleared and flushed before a
>> new valid PMD is set. This is possible for MMUs since they
>> allow the software to handle spurious page-faults gracefully.
>> This is not the case for the IOMMU though (without PRI).
>> Not sure this explains everything though. If that is the problem,
>> then during a mapping that changes page-sizes, a TLB flush is
>> needed, similarly to the one Longpeng did manually.
>=20
> I have been working with Longpeng on this issue these days. It turned
> out that your guess is right. The PMD is first cleared but not flushed
> before a new valid one is set. The previous entry might be cached in =
the
> paging structure caches hence leads to disaster.
>=20
> In __domain_mapping():
>=20
> 2352                                 /*
> 2353                                  * Ensure that old small page =
tables are
> 2354                                  * removed to make room for =
superpage(s).
> 2355                                  * We're adding new large pages, =
so make sure
> 2356                                  * we don't remove their parent =
tables.
> 2357                                  */
> 2358                                 dma_pte_free_pagetable(domain, =
iov_pfn, end_pfn,
> 2359 largepage_lvl + 1);
>=20
> I guess adding a cache flush operation after PMD switching should =
solve
> the problem.
>=20
> I am still not clear about this comment:
>=20
> "
> This is possible for MMUs since they allow the software to handle
> spurious page-faults gracefully. This is not the case for the IOMMU
> though (without PRI).
> "
>=20
> Can you please shed more light on this?

I was looking at the code in more detail, and apparently my concern
is incorrect.

I was under the assumption that the IOMMU map/unmap can merge/split
(specifically split) huge-pages. For instance, if you map 2MB and
then unmap 4KB out of the 2MB, then you would split the hugepage
and keep the rest of the mappings alive. This is the way MMU is
usually managed. To my defense, I also saw such partial unmappings
in Longpeng=E2=80=99s first scenario.

If this was possible, then you would have a case in which out of 2MB
(for instance), 4KB were unmapped, and you need to split the 2MB
hugepage into 4KB pages. If you try to clear the PMD, flush, and then
set the PMD to point to table with live 4KB PTES, you can have
an interim state in which the PMD is not present. DMAs that arrive
at this stage might fault, and without PRI (and device support)
you do not have a way of restarting the DMA after the hugepage split
is completed.

Anyhow, this concern is apparently not relevant. I guess I was too
naive to assume the IOMMU management is similar to the MMU. I now
see that there is a comment in intel_iommu_unmap() saying:

        /* Cope with horrid API which requires us to unmap more than the
           size argument if it happens to be a large-page mapping. */

Regards,
Nadav

--Apple-Mail=_35D28607-8F18-4860-BA01-DF07CD351738
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBetl8ACgkQHaAqSaba
D1q61Q/8CfEICk6tmSsbLNtp21OH6a/otwOCJzIOCoEAqSaRv5FlXXe+FedJWQqX
mg4KN1XuohWP7jxqXCBWTKxRF+TgEHoT3wfUp7JqmJxu040UQd9EUkcCwdzcBB+1
B7I3lf7AYPLYeIAy7iC+BMiiIrOASBThl4qzgBnNgigrYrOgVlnzF7YBs4lUTPKs
WZUqrrhLmzV/l58TuYsbtAtH/oQMdpaMKDAxCdagNMQbsAsZtz50B+vv1e+Olog7
bbKhec9psqhjR8zPfspwqyH6QR1UPM81eo8sHBeCBqbzn4bCELdm2jvCLTVhvszz
eo+z/InVgnji9PqObA5b8dFU6HFsld89nAb/ePQc49i3NcmZg50+j6tU9QaDi2Uk
1IR3X8shJSdm6pLxXhE+POJ4Ynrph0gbhdDJJNcWgDEr2h6GUjkY58yGhrSA+z02
JDWC5yaLYju75rnCnYvKcVzyGdKujvrWTVk201fILGJgQJGSqN8ixZKSouAjAPC9
cMernmrugecbMWB0yGL86XNMY8wjIOvhLIKcjzIGOfuiTTqaxMtVuY8u9fpRLR8/
00bqfwIkej9vBTDUF/zSy5WQeYrT+6OJXUgdxqaP1U1Qw+Fse50bsZjbxSWso512
KuqyucJkBJ+p6yVoENmQzEy+VLjODiRjMG9lYz37TcbaJWJ97ys=
=Vr9C
-----END PGP SIGNATURE-----

--Apple-Mail=_35D28607-8F18-4860-BA01-DF07CD351738--

--===============0827179654087546388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0827179654087546388==--
