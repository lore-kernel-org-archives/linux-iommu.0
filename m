Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EECBC48BE0
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 16:50:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6183613C3
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 16:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6183613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8585883E5B;
	Fri, 11 Jun 2021 16:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id htm4wOSuUEnU; Fri, 11 Jun 2021 16:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C11283AF4;
	Fri, 11 Jun 2021 16:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 065D2C000D;
	Fri, 11 Jun 2021 16:50:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7C6CC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C96784016D
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EnSmXBcPfBFr for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 16:50:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A70A14012A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:50:34 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id h12so4926067pfe.2
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=YxiModSScxrX6wWlEE0AEHNoN023vebR9RIyb3JQrHo=;
 b=TY+8/u7kG9aTVxM5eVsmnRQsN3HnGN8R42yXl3Ws2EBv2+N0JClnaMf2orLQfMtz/W
 e4YDzf08xvSGpj+S6YzlxHkjFigXzNHAkNG1MWjo97hLqwiS9ZLb5kulmRPkJ31lKF78
 6JO9qjkZ2loDpi+yfwM/sW9NtUyeI2d3DdZ5+fwCY//Bq6B2JyaOJns2XfzKk+2j8CE8
 AIyLI+/FjhDxs2cRSa28Si/2AfFAANJboEk9EiYeojtIZlI72gHGdBTUrVzNaC7YSHeC
 a3pz1IOquw/XUDP7KbfvI57ykBHjNnZbxeaXeUfKzHCGNqRO7VFoFjDjTahfrXwPXbBY
 ovQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=YxiModSScxrX6wWlEE0AEHNoN023vebR9RIyb3JQrHo=;
 b=quqwg5MuJ2UZh7FPbG+8qoDA0ZZE5kyJBKTITyRJRQOt+tsgnZR+QJSXE9tnUrMggM
 FZZDi+WKSuq8bPC0P8ohzn8G+OORudOtGchgC9gIJxr/XDS5zTcvvg8bPWXdgdE8SzaW
 Bd5RtSD6tDBYvHjo93wiadBEsRXKoRILdV9bEaqelIY8InA/GFbvifNmbzQbYeXOrQWe
 e7TA0lmcIgDMy6a9YGsOTSB7/6lbj+sCqnVosTJefukf5RYrArL6rUOMfpIv4S0v2MtR
 xtb3Vs6eeXn9Uh3XopGqCV8x6qNfZP40S4eW2+k3Ug4QHgUKloCiCzIoCTPDUVRrcBpo
 3xEA==
X-Gm-Message-State: AOAM531f9+c7699+pooiRsMOfCxcwPRre/6ULqMAGhSOppumBJUb+JI1
 jxUFVmvcvXXdbgEgpi5kcjg=
X-Google-Smtp-Source: ABdhPJzRaHiA/tU5kv1KSjGXKSf5EXl3CidBPqHwIaYUedvh9iRfEN9EVAU2EogEJpU5K7kFm0IjYQ==
X-Received: by 2002:a62:1d0f:0:b029:2d5:3ec2:feb8 with SMTP id
 d15-20020a621d0f0000b02902d53ec2feb8mr9364468pfd.19.1623430233840; 
 Fri, 11 Jun 2021 09:50:33 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id k1sm5599107pfa.30.2021.06.11.09.50.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jun 2021 09:50:32 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Message-Id: <D76DA59C-023F-43D1-B4ED-BFA65D9D064F@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date: Fri, 11 Jun 2021 09:50:31 -0700
In-Reply-To: <20210611135746.GC15776@willie-the-truck>
To: Will Deacon <will@kernel.org>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-5-namit@vmware.com>
 <20210611135746.GC15776@willie-the-truck>
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
Content-Type: multipart/mixed; boundary="===============1209085731192686754=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1209085731192686754==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_76AC0899-3851-4BEA-A8FB-C0802A2D5203";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_76AC0899-3851-4BEA-A8FB-C0802A2D5203
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jun 11, 2021, at 6:57 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Mon, Jun 07, 2021 at 11:25:39AM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Refactor iommu_iotlb_gather_add_page() and factor out the logic that
>> detects whether IOTLB gather range and a new range are disjoint. To =
be
>> used by the next patch that implements different gathering logic for
>> AMD.
>>=20
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jiajun Cao <caojiajun@vmware.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> include/linux/iommu.h | 41 +++++++++++++++++++++++++++++++++--------
>> 1 file changed, 33 insertions(+), 8 deletions(-)
>=20
> [...]
>=20
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index f254c62f3720..b5a2bfc68fb0 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct =
iommu_domain *domain,
>> 	iommu_iotlb_gather_init(iotlb_gather);
>> }
>>=20
>> +/**
>> + * iommu_iotlb_gather_is_disjoint - Checks whether a new range is =
disjoint
>> + *
>> + * @gather: TLB gather data
>> + * @iova: start of page to invalidate
>> + * @size: size of page to invalidate
>> + *
>> + * Helper for IOMMU drivers to check whether a new range is and the =
gathered
>> + * range are disjoint.
>=20
> I can't quite parse this. Delete the "is"?

Indeed. Will do (I mean I will do ;-) )

>=20
>>    For many IOMMUs, flushing the IOMMU in this case is
>> + * better than merging the two, which might lead to unnecessary =
invalidations.
>> + */
>> +static inline
>> +bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather =
*gather,
>> +				    unsigned long iova, size_t size)
>> +{
>> +	unsigned long start =3D iova, end =3D start + size - 1;
>> +
>> +	return gather->end !=3D 0 &&
>> +		(end + 1 < gather->start || start > gather->end + 1);
>> +}
>> +
>> +
>> /**
>>  * iommu_iotlb_gather_add_range - Gather for address-based TLB =
invalidation
>>  * @gather: TLB gather data
>> @@ -533,20 +555,16 @@ static inline void =
iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>> 					       struct iommu_iotlb_gather =
*gather,
>> 					       unsigned long iova, =
size_t size)
>> {
>> -	unsigned long start =3D iova, end =3D start + size - 1;
>> -
>> 	/*
>> 	 * If the new page is disjoint from the current range or is =
mapped at
>> 	 * a different granularity, then sync the TLB so that the gather
>> 	 * structure can be rewritten.
>> 	 */
>> -	if (gather->pgsize !=3D size ||
>> -	    end + 1 < gather->start || start > gather->end + 1) {
>> -		if (gather->pgsize)
>> -			iommu_iotlb_sync(domain, gather);
>> -		gather->pgsize =3D size;
>> -	}
>> +	if ((gather->pgsize && gather->pgsize !=3D size) ||
>> +	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
>> +		iommu_iotlb_sync(domain, gather);
>>=20
>> +	gather->pgsize =3D size;
>=20
> Why have you made this unconditional? I think it's ok, but just not =
sure
> if it's necessary or not.

In regard to gather->pgsize, this function had (and has) an
invariant, in which gather->pgsize always represents the flushing
granularity of its range. Arguably, =E2=80=9Csize" should never be
zero, but lets assume for the matter of discussion that it might.

If =E2=80=9Csize=E2=80=9D equals to =E2=80=9Cgather->pgsize=E2=80=9D, =
then the assignment in
question has no impact.

Otherwise, if =E2=80=9Csize=E2=80=9D is non-zero, then =
iommu_iotlb_sync() would
initialize the size and range (see iommu_iotlb_gather_init()),
and the invariant is kept.

Otherwise, =E2=80=9Csize=E2=80=9D is zero, and =E2=80=9Cgather=E2=80=9D =
already holds a range,
so gather->pgsize is non-zero and
(gather->pgsize && gather->pgsize !=3D size) is true. Therefore,
again, iommu_iotlb_sync() would be called and initialize the
size.

I think that this change makes the code much simpler to read.
It probably has no performance impact as =E2=80=9Cgather=E2=80=9D is =
probably
cached and anyhow accessed shortly after.

If anything, I can add a VM_BUG_ON() to check =E2=80=9Csize=E2=80=9D is
non-zero, although this code seems correct regardless of that.


--Apple-Mail=_76AC0899-3851-4BEA-A8FB-C0802A2D5203
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmDDlFcACgkQHaAqSaba
D1psvQ/9HvxhhClEEFqeQtBqS9yRwDhDfY5kgTJ+JKhwRPTTqTwa2FfULTlEPbhe
jbVQyUC+PfpxrxInOWkhJuwHAHlC8YnYW4Gc3Pvdd4m6IQzjbAkqpYBCq663Bd52
TPk75QPBDT9IAKfWXquU69qoe4qqTq/Kh9NZay5bpdMU7ScZDOnyrUc1rH2SyqUE
wt8x0uo+ml4IR61lfth29EiDj4k0inoUNHnf9fWQNGklNKOY3dEqhYb6C3qlIK1K
5B/2NkPFWGhdwysDDV/R37oR05OdYGskYE6a7paUHTFW8c1iPZqmR0PRAVQ79V/5
fFZCjeBp9Rp0rPvLVd6+tWHL++Wg5rvacmcFeGuBTCPXw3rJ/l1k8jdu0PZSK73M
TsRoczp+43Xg9BiAIoh5eJ/hH5pGSOYl9co12pGkjEHDguz6vG+6U3VyC04yBkPB
xz7CiDJ8fGlotm/zUbDPBpFNsW5yJgrsze2TvXTvF8ZOP4Pcc7CMQRbSTW2KbIVk
KbxnGPbGKmuECyVFhO1eC18uZOzClDYYg1TnxeYsXpoNAfJrJFdzb1QLvqwnmq7q
Oy+XfvvHjgYTLXH7cykdGwykP1p1CH1iK9NROpR6EHoKdjG1g0PJU+nNGJxiYrZ1
EXkbzwgn+LJG5U98nFzgt8Awe83fk6InMtfFzZ5zapnjtzFfvqg=
=Q2i+
-----END PGP SIGNATURE-----

--Apple-Mail=_76AC0899-3851-4BEA-A8FB-C0802A2D5203--

--===============1209085731192686754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1209085731192686754==--
