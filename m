Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7650DC48BE8
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:54:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E2C613B3
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 18:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E2C613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2ECA40523;
	Tue, 15 Jun 2021 18:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1MSnxyro5FA; Tue, 15 Jun 2021 18:54:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5CF7340482;
	Tue, 15 Jun 2021 18:54:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E26CC000D;
	Tue, 15 Jun 2021 18:54:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76C35C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56E0940523
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:54:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KgyRdQ_hSX77 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 18:54:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2978D40482
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 18:54:16 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id i34so12202323pgl.9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=2ACARb2OHjYtM8uD12/aj9c2MPs3FdaKsjjUZsSDgRU=;
 b=dFhZ9Q1ZWyPaAtn6vDYshJvBAJRXL+r5Cmmd9vQXGdqIUOblds8OPmUQwDVdV9HDgC
 Z6ZQlmwGgq+RAQS3ybRQ9Af+TXTWLRcF4AKAcF30Sm1m0JujWbQiNl86VFz9yyJLKiqw
 ztDyAPYdz+hCLuywRhhP8JOalSaxiue85qDVPJWFi+YIsPT7+cLBTOetkLL/6ySqAIob
 eTh/VrJTDaIvd9xM2PGKMy2z1LWwx/2RJgGLq8eZCOEjK+ql8sBR3fN4kWqapaZpuERN
 NBjp4QyjeSTlfxxiqWHZ51VmoEX5GO0DiRHriOJiSNZUuFTpWk73tm8wXLBubJjfkl7r
 kFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=2ACARb2OHjYtM8uD12/aj9c2MPs3FdaKsjjUZsSDgRU=;
 b=hlrnXQBq435aNeGWkjaaQVCcMW5JlfeC1gJXc5fDL6+l8oPCYFVhGLiBTU32BZq4IR
 kJxEqszOt7uljY8aHfdajuIMthNlzEcpRYVAJkcsd9KozghAvjPsBOz0fJD5v2eCeayv
 HkImpYZtXDjOyMU9hcA0Be/y4Z3iu+WdEgEVvgFaXGWKQKf2RrsdWsxxfRC/bmbRHKt4
 wzhSlSOJj0KnYQbtbl4n0u6hVroxP18EyR50lEEGkKTpfc5QDBxynm9fJ3z/PWgg27Um
 RbtJTsUz4/AJUVhg+m/SWMTJ/GoHC9aPjmq82s1Oo3Ke637W4v1pr5r+53WFl/B/OLKr
 t4Yg==
X-Gm-Message-State: AOAM531wbYyYH4UFbXIGbdJYMiwvymxA6SttS5bycq6EqbK/1//y4EuJ
 YY+7vGMasaWHEn7F58URxuQ=
X-Google-Smtp-Source: ABdhPJx0Xt0KX5S/R5+hY+GWDA4NQKhTMqDFyha1xSK7kOvx1M0ART6PMpE4gmIhd5qWAj0YDJ/cEA==
X-Received: by 2002:aa7:920d:0:b029:2d9:2ead:70dd with SMTP id
 13-20020aa7920d0000b02902d92ead70ddmr5575030pfo.67.1623783255160; 
 Tue, 15 Jun 2021 11:54:15 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id 20sm15880137pfi.170.2021.06.15.11.54.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jun 2021 11:54:14 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <2A56E50B-D577-4F84-8C95-D13042C96147@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date: Tue, 15 Jun 2021 11:54:13 -0700
In-Reply-To: <20210615102947.GB20225@willie-the-truck>
To: Will Deacon <will@kernel.org>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-5-namit@vmware.com>
 <20210611135746.GC15776@willie-the-truck>
 <D76DA59C-023F-43D1-B4ED-BFA65D9D064F@gmail.com>
 <20210615102947.GB20225@willie-the-truck>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jiajun Cao <caojiajun@vmware.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============7405291314398901885=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7405291314398901885==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_D4CD0FDC-849F-4E78-8CA9-CFD674D2A337";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_D4CD0FDC-849F-4E78-8CA9-CFD674D2A337
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jun 15, 2021, at 3:29 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Fri, Jun 11, 2021 at 09:50:31AM -0700, Nadav Amit wrote:
>>=20
>>=20
>>> On Jun 11, 2021, at 6:57 AM, Will Deacon <will@kernel.org> wrote:
>>>=20
>>> On Mon, Jun 07, 2021 at 11:25:39AM -0700, Nadav Amit wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>>=20
>>>> Refactor iommu_iotlb_gather_add_page() and factor out the logic =
that
>>>> detects whether IOTLB gather range and a new range are disjoint. To =
be
>>>> used by the next patch that implements different gathering logic =
for
>>>> AMD.
>>>>=20
>>>> Cc: Joerg Roedel <joro@8bytes.org>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Jiajun Cao <caojiajun@vmware.com>
>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Cc: iommu@lists.linux-foundation.org
>>>> Cc: linux-kernel@vger.kernel.org>
>>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>> ---
>>>> include/linux/iommu.h | 41 =
+++++++++++++++++++++++++++++++++--------
>>>> 1 file changed, 33 insertions(+), 8 deletions(-)
>>>=20
>>> [...]
>>>=20
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>> index f254c62f3720..b5a2bfc68fb0 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct =
iommu_domain *domain,
>>>> 	iommu_iotlb_gather_init(iotlb_gather);
>>>> }
>>>>=20
>>>> +/**
>>>> + * iommu_iotlb_gather_is_disjoint - Checks whether a new range is =
disjoint
>>>> + *
>>>> + * @gather: TLB gather data
>>>> + * @iova: start of page to invalidate
>>>> + * @size: size of page to invalidate
>>>> + *
>>>> + * Helper for IOMMU drivers to check whether a new range is and =
the gathered
>>>> + * range are disjoint.
>>>=20
>>> I can't quite parse this. Delete the "is"?
>>=20
>> Indeed. Will do (I mean I will do ;-) )
>>=20
>>>=20
>>>>   For many IOMMUs, flushing the IOMMU in this case is
>>>> + * better than merging the two, which might lead to unnecessary =
invalidations.
>>>> + */
>>>> +static inline
>>>> +bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather =
*gather,
>>>> +				    unsigned long iova, size_t size)
>>>> +{
>>>> +	unsigned long start =3D iova, end =3D start + size - 1;
>>>> +
>>>> +	return gather->end !=3D 0 &&
>>>> +		(end + 1 < gather->start || start > gather->end + 1);
>>>> +}
>>>> +
>>>> +
>>>> /**
>>>> * iommu_iotlb_gather_add_range - Gather for address-based TLB =
invalidation
>>>> * @gather: TLB gather data
>>>> @@ -533,20 +555,16 @@ static inline void =
iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>>>> 					       struct iommu_iotlb_gather =
*gather,
>>>> 					       unsigned long iova, =
size_t size)
>>>> {
>>>> -	unsigned long start =3D iova, end =3D start + size - 1;
>>>> -
>>>> 	/*
>>>> 	 * If the new page is disjoint from the current range or is =
mapped at
>>>> 	 * a different granularity, then sync the TLB so that the gather
>>>> 	 * structure can be rewritten.
>>>> 	 */
>>>> -	if (gather->pgsize !=3D size ||
>>>> -	    end + 1 < gather->start || start > gather->end + 1) {
>>>> -		if (gather->pgsize)
>>>> -			iommu_iotlb_sync(domain, gather);
>>>> -		gather->pgsize =3D size;
>>>> -	}
>>>> +	if ((gather->pgsize && gather->pgsize !=3D size) ||
>>>> +	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
>>>> +		iommu_iotlb_sync(domain, gather);
>>>>=20
>>>> +	gather->pgsize =3D size;
>>>=20
>>> Why have you made this unconditional? I think it's ok, but just not =
sure
>>> if it's necessary or not.
>>=20
>> In regard to gather->pgsize, this function had (and has) an
>> invariant, in which gather->pgsize always represents the flushing
>> granularity of its range. Arguably, =E2=80=9Csize" should never be
>> zero, but lets assume for the matter of discussion that it might.
>>=20
>> If =E2=80=9Csize=E2=80=9D equals to =E2=80=9Cgather->pgsize=E2=80=9D, =
then the assignment in
>> question has no impact.
>>=20
>> Otherwise, if =E2=80=9Csize=E2=80=9D is non-zero, then =
iommu_iotlb_sync() would
>> initialize the size and range (see iommu_iotlb_gather_init()),
>> and the invariant is kept.
>>=20
>> Otherwise, =E2=80=9Csize=E2=80=9D is zero, and =E2=80=9Cgather=E2=80=9D=
 already holds a range,
>> so gather->pgsize is non-zero and
>> (gather->pgsize && gather->pgsize !=3D size) is true. Therefore,
>> again, iommu_iotlb_sync() would be called and initialize the
>> size.
>>=20
>> I think that this change makes the code much simpler to read.
>> It probably has no performance impact as =E2=80=9Cgather=E2=80=9D is =
probably
>> cached and anyhow accessed shortly after.
>=20
> Thanks. I was just interested in whether it had a functional impact (I =
don't
> think it does) or whether it was just cleanup.
>=20
> With the updated comment:
>=20
> Acked-by: Will Deacon <will@kernel.org>

Thanks. I will add the explanation to the commit log, but not to the =
code in order not to inflate it too much.


--Apple-Mail=_D4CD0FDC-849F-4E78-8CA9-CFD674D2A337
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmDI91UACgkQHaAqSaba
D1rwyg/9GoaoYMhf+uaP86OBxYda+U2uFAA6GQ4ACRS1JKC9ki8j2OVNzmbK5+df
qYvA/Fp5MZ3dBfr7xEEwvM6AseNjSYRS84EF62x04ZxePRmNtTQ0Xw47qIGjJXLy
T39Qep/p84leB1e7caGN6ZjLlODllJk7ocPFx5fiKAb0mrQtMCz4D49GYCCregx4
Ml0oJo5LhngS+XK8+Iz32fmDUaShKnLuRqqNWM15VKTVGVz0L5TKPKFd2JH1uFne
/ynBYON5HSIUcxtlWfGT3xLnTiQJPqVGpDzS0Q4ZaJ8RkloNwd3/qwIsuhkNmPSR
9wgr+5S33LdjRmoOMQHmVVPsDqJFDNWbYL37Ceb2qdNsuZH9L1DwonKPJrHPcWo5
q3frnvsrSo66zyO0GLldDCmMYTOuy++7RN4aJTGNZTzi7qKuR/E195AvkCm4KmVK
HK+DQZy26g6hBb5SzHA6EPof6nex3cAbCJeBk2WVHRMBsOb3TMUkFW+X8Qywh98m
cvk4yNm4IaSTyjG5nAnbXwgSjSVPVvF3MEHXVtEaTMJ+bHINLxyDcCtXcXOqVA6A
irgb/+9B7iwnzNHrCo9Srq3s6liUbeEIGo04G4JG1UxGmAkR8AGySgtZhxvelQIZ
OpnBE5FKGV8MgXoNUFTdif7zRG1dZRAM3MtAIP0/CWwB9JYcfyU=
=7m8F
-----END PGP SIGNATURE-----

--Apple-Mail=_D4CD0FDC-849F-4E78-8CA9-CFD674D2A337--

--===============7405291314398901885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7405291314398901885==--
