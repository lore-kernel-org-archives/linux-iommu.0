Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A825EC2D0C1
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:47:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E2C206D7
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTKns+Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E2C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 420D4884BB;
	Thu, 19 Dec 2019 12:47:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mc2E9pxrhH0U; Thu, 19 Dec 2019 12:47:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FF0388581;
	Thu, 19 Dec 2019 12:47:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37C18C1D84;
	Thu, 19 Dec 2019 12:47:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37B71C077D;
 Thu, 19 Dec 2019 12:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2E7CE85B81;
 Thu, 19 Dec 2019 12:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eVu8IVwHWdsI; Thu, 19 Dec 2019 12:47:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AA272851CC;
 Thu, 19 Dec 2019 12:47:51 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id q9so5301635wmj.5;
 Thu, 19 Dec 2019 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=e2DBwRLOc0+NXX0lm+V606orQs3w/QtiskRtJFmTJpE=;
 b=PTKns+SdLLr4ZaCEfAh3ObI+jGZMo4+JOlU5CQQRWkDFIVSsPWz2iDbfKhjEq6MKIC
 aRbyCQCnk0cTs2UwulNsRgCaiGU5xFbr8ETxhumyOWd8x1/PXMy2lyyiNaGerK3cQHCZ
 QeXBFYNls7O+PoJIrEVsftRBKevjpiYvieUmujy9N2Ktd21t46Qo2yfAICnLpbqmV8sZ
 x7W+JNTruIQEteqTUii7U1vwxk7FLU6CCKbJhIp95hDFhijA9uokDokESBeuNby6NCnH
 QGAbDMuJK9ssD148eRuhFOTXZ4+6o1OxSY+LTgToJGv6UM3vYL+/4R7PHs2e8issXRYK
 N/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=e2DBwRLOc0+NXX0lm+V606orQs3w/QtiskRtJFmTJpE=;
 b=qQtmdU5jcNn7XTLGsALPxpjX3MjFPenaZaI+g1r8ewMYS/Dw+HldXKI3bcA4ZfhKmX
 8cRVAskgPsidXq263uIGcE71GRwE8JS9Xds6CTJjTkvxHoE0v4LqeIAZ2cVhVaMgxu1S
 FgXd3DAmF0U8SQC1uqCSJ2yVE0d5zLFqqxLSvve5tIL6xgGnB9QDHG48hI1YyRYavJpS
 +//GyWBPmRBVL769NTGXGfn0WPMBsnGZ6qrBGp5x3geQKggXwTUp5mbiPhKrWG17Obhr
 44ldITGPf5u/6dGwU7f32PlF+EZ8H3D6XtVj9gCJg/f4eik19roeWwQrs/ekSTD2lAsE
 j/Lg==
X-Gm-Message-State: APjAAAVfUtwgRZMGWJVQEy8RV771mWGz3kvogV1ee8UW0zntaFSS5KO3
 bJYFnD4izyNUOHivPGF/lik=
X-Google-Smtp-Source: APXvYqwa9Hu0h5qRLAIYGmBsvZFeHDEip3Ga9oDqR6+Q+7HjHlER5nfEI1KMGyTaWk8sZgzSPZaIvw==
X-Received: by 2002:a05:600c:2298:: with SMTP id
 24mr10205863wmf.65.1576759669976; 
 Thu, 19 Dec 2019 04:47:49 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id c195sm6591110wmd.45.2019.12.19.04.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 04:47:48 -0800 (PST)
Date: Thu, 19 Dec 2019 13:47:47 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 4/5] iommu: intel: Use generic_iommu_put_resv_regions()
Message-ID: <20191219124747.GA1440537@ulmo>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
 <20191218134205.1271740-5-thierry.reding@gmail.com>
 <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============2208390444444319011=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2208390444444319011==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 09:53:22AM +0800, Lu Baolu wrote:
> Please tweak the title to
>=20
> "iommu/vt-d: Use generic_iommu_put_resv_regions()"
>=20
> then,
>=20
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Best regards,
> baolu

Joerg, do you want me to resend with this change or is it more efficient
if you fix up the subject while applying?

Thierry

> On 12/18/19 9:42 PM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Use the new standard function instead of open-coding it.
> >=20
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >   drivers/iommu/intel-iommu.c | 11 +----------
> >   1 file changed, 1 insertion(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 42966611a192..a6d5b7cf9183 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5744,15 +5744,6 @@ static void intel_iommu_get_resv_regions(struct =
device *device,
> >   	list_add_tail(&reg->list, head);
> >   }
> > -static void intel_iommu_put_resv_regions(struct device *dev,
> > -					 struct list_head *head)
> > -{
> > -	struct iommu_resv_region *entry, *next;
> > -
> > -	list_for_each_entry_safe(entry, next, head, list)
> > -		kfree(entry);
> > -}
> > -
> >   int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device=
 *dev)
> >   {
> >   	struct device_domain_info *info;
> > @@ -5987,7 +5978,7 @@ const struct iommu_ops intel_iommu_ops =3D {
> >   	.add_device		=3D intel_iommu_add_device,
> >   	.remove_device		=3D intel_iommu_remove_device,
> >   	.get_resv_regions	=3D intel_iommu_get_resv_regions,
> > -	.put_resv_regions	=3D intel_iommu_put_resv_regions,
> > +	.put_resv_regions	=3D generic_iommu_put_resv_regions,
> >   	.apply_resv_region	=3D intel_iommu_apply_resv_region,
> >   	.device_group		=3D pci_device_group,
> >   	.dev_has_feat		=3D intel_iommu_dev_has_feat,
> >=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37cW8ACgkQ3SOs138+
s6HwMg//QTaq9qdL6boTSg1EAx8bgcGx/ElOv3yPZusDHrNbEG7C19YElgpyGquj
7x+Amfj9QD/8vIKJg+w2Z7VpKwUgrVyteYw+dOyFzSx5gjqLE7/r5klBFwR32/Uz
pGffIE2X3N6xtCfdzYrFt1ay9wM+cHJA0lvMy7oFX+XEOxc/eAorwm68g+UgkYAm
QigqZ/5cjjlkIkQL2FThNHnwpwd9zAhOMchjlyz+4UZv/4AvQqX0YSilx72T4JP0
3LOCto7pCGTmvv/4/E0bCOzIa+FOMZf56LLqOstqBhIoPeBWGuGNXUerZ5iV22E0
ah5RgWxHM0YwGufRGyHiJ8niUQlIuuIzFsJmjvXbDHdaIM7/tZMGRVRGNcZuINBb
5Addl123iKthkOTBBqNMoZwg9Y30E3mG07wZbH8tkZj91CRJPJ1Ui5uQsEtxlwvS
jwGcb9kVFk3PJO0AuKvDC9VTi40K1MDYW8NLAtTYV4UhLKA5XGuOWawKZWC20Q+X
88ie9W4l5+HhW9hgpSfawGdKAlOeeCzXTVmqzm8o5vaAIZ6qGnaf4peVVZ59YF70
HSty77b43BATtE0oL3ps6hzLgNMNQYSAd8hOnA1cqEwK4+wyCsRgfzx64jxyMOSB
vCaXjNxdpNsgZWqwqw5NVrsV2z3Jn/f11Wvsob4EMM5C3/ZDuVE=
=lKCJ
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

--===============2208390444444319011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2208390444444319011==--
