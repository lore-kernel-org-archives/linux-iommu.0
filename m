Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156623043D8
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565348; cv=none; b=hMNWAN80Zhm68KyrmU2CCwoek/hQrBHdLCrsA230glmFYZWO74dPwvq+lXXhFr+2lS1EtFyjhaT2OVPfVl02ZIYz5jD0TZeUBAKMLUWVxZvD9vKODTFTpIGALv9nHCOv+fKcpI++ZBXSca5qGyD8EAaCZdj9t2Gm2LVBtznnzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565348; c=relaxed/simple;
	bh=OFUZEAn0tJfrAUbL/6gUV+/vHKjKd4aU7a2bK6qndOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkNXaxoRso9yCkWE/LMiSPbPd5ll4nNtA7eO+H6hCp28ebvUK5dI6TwVR6Zv/u4LclPzquyns6n0o/1/vmLt7J6uu3vNhslpXrmzBFPpwhnIvwTUHPBy7FsCm0AYyKgMf7YVZNwQcg5pGNMGTU5g3A/gSsU5S8k9m2hX4kGRBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTvrSye8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTvrSye8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45B2C2BC87
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 21:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760565347;
	bh=OFUZEAn0tJfrAUbL/6gUV+/vHKjKd4aU7a2bK6qndOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XTvrSye8LFx8I2EDZvSsssU9YDxQRmbmqRHNq8mr4JGiVimliYi1AnVP7b4fPYwBk
	 +RXItK/h6ga30VZfNUIUCRqViNq/TEoBTBBAT/qyoYGyhA5uZ71K0K39dyO4M1+dIE
	 3n2kFV9I4hTnwqSsp32+okXPWp35yrE4hKJey33ew9IbxD+Dc29TJ/w917qC4+cIBZ
	 UDCCsIJGA+X2/B/dH1KQYLXYuliBREwLhSyHzMGlP+2PjtPVPlile8xwTNCb2Rko7z
	 yjqZK/MR+tLdUGxeuk2yGm+H0a4+wskRo83Xd8EJKyXOQkG9Gs4Gz/sI/PMLaJJhBI
	 210BLmVi4phPQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b40f11a1027so9144166b.2
        for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 14:55:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuSnwnFd6bs/8JPEQLKqRZADmbYC9tJolqK3huxp9tgH8FFp6QvVZquZxP83SSltX92STSwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/CShmHXEAdkLSOjoB8B6EAeJ20tAALXP+Y32i6z6Xg5EcwM4u
	qb5Snjv5Xbu3s22ZX5Jw//53u/0+w3eBD/HPIpDJC82G611kxfC7lxWY0wRDMUdosippYswIdav
	fE5fCwsfwCEqKQ+3X9mvIlWSYdld5yA==
X-Google-Smtp-Source: AGHT+IFHESWupx/CTqIl66Cowsu3EvMAI/+jJbfasG4ZKwZXkzIfC23I0vb6ITIupl3h7wZ6qWU0Vk2BmLWIuje8Wec=
X-Received: by 2002:a17:906:ee89:b0:b3b:679d:7f4a with SMTP id
 a640c23a62f3a-b50aa387331mr3022927066b.5.1760565346012; Wed, 15 Oct 2025
 14:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
 <9d3eeb9f-b8ea-48e5-a1d9-0865f63ef991@arm.com> <fhb4woejzh3r6v5dxvdiopnsbuwstucfuuzbiymxg4wrxrjc7t@dt3z3utq6lwd>
 <8d88cd9d-16e8-43f9-8eb3-89862da1d0c1@arm.com> <hOs24ZavnUyKYyNwBWwRpYnrsefzBfp95yuy9zyp1ByxR9_3VacGX1Yntt8pCE4w3gllPwvevs1AZqghmwKoFg==@protonmail.internalid>
 <zcgn4xw2xghyna2eysavujbzbiydyki7p7upzzv7one5mdyjy6@sj7f75kc4vwu>
 <fb767586-a376-48eb-97b4-bf33061642b9@kernel.org> <a4WDx80rJP1GnGNEK0OOD5lh-m-MiAvireXdpiM9ETLKZ084sBJ2UthU_QqRbU_nwD4XtsdiyEqQ0AhxguzJ6g==@protonmail.internalid>
 <6gx74wxie4wcabq27wo5y7v36uuurez4jxlzanroepqazdlgtw@sdtv2ld47d3q>
 <fa3c1732-328d-46a2-8514-2e7f9ca6c63f@kernel.org> <aE5RMDRfrr2wxUAqjjsBMcodNQxLsUT_Soi_LXMJXYcfmmeBSHnPM3e5JUPOb89tSfeI1jQbt9LfLCOXFBZFSA==@protonmail.internalid>
 <mwthowuei7pcqp2b4hg5c45n47iakclkioumc6diyznhnldfv5@wloeoys224bg> <796770d1-024e-4967-a96a-b7f32b28ca64@kernel.org>
In-Reply-To: <796770d1-024e-4967-a96a-b7f32b28ca64@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 15 Oct 2025 16:55:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKNS9meBRxhMQvEym+yOK2r9ddpn4Q-FKb1efSm9sT3Bw@mail.gmail.com>
X-Gm-Features: AS18NWAIHJjzHLZj2uLa3SUxLobahI_sXDbl6LjepNIuAadyImOTozg2xUTbUqI
Message-ID: <CAL_JsqKNS9meBRxhMQvEym+yOK2r9ddpn4Q-FKb1efSm9sT3Bw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Robin Murphy <robin.murphy@arm.com>, 
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, joro@8bytes.org, will@kernel.org, 
	saravanak@google.com, conor+dt@kernel.org, mchehab@kernel.org, 
	krzk+dt@kernel.org, abhinav.kumar@linux.dev, vikash.garodia@oss.qualcomm.com, 
	dikshita.agarwal@oss.qualcomm.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, bjorn.andersson@oss.qualcomm.com, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:53=E2=80=AFAM Bryan O'Donoghue <bod@kernel.org> w=
rote:
>
> On 14/10/2025 23:18, Dmitry Baryshkov wrote:
> > On Tue, Oct 14, 2025 at 09:49:17PM +0100, Bryan O'Donoghue wrote:
> >> On 14/10/2025 19:35, Dmitry Baryshkov wrote:
> >>>> Each function id can be associated with a device and a compat string
> >>>> associated with it.
> >>> So, which part of the hardware is described by the -cb device? What d=
oes
> >>> it mean_here_?
> >>
> >> The non-pixel path video encoder, the tz video encoder...
> >>
> >> What's not clear about that ?
> >
> > Where do you have pixel encoders in the fastrpc device node?
> >
> > --
> > With best wishes
> > Dmitry
>
> Haha, no sorry I didn't mean to suggest that at all.
>
> I mean do something _like_ that, for these FUNCION_IDs.
>
> We could replicate that for a new iris add for say Glymur or Kanaapali.
>
> Sub-nodes of the main iris device. They have a real purpose in that the
> 'device' requirement is full range IOVA for the SID and implicit
> identification of the FUNCTION_ID with the compat string
>
> iris-video@0xdeadbeef {
>         video@0 {
>                 reg =3D <0>;  /* FUNCTION_ID HLOS could also go here */
>                 compat =3D "qcom,glymur-iris";
>
>                 iommus =3D <&apps_smmu 0x1940 0x0000>;
>         };
>
>         video@1 {
>                 reg =3D <1>;
>                 compat =3D "qcom,glymur-iris-non-pixel";
>                 iommus =3D <&apps_smmu 0x1947 0x0000>;
>         };
> };
>
> The reg property could also be the function_id
>
> video@FUNC_ID_HLOS {
>         reg =3D <FUNC_ID_HLOS>;
>         ...
> };
>
> There's no need for a new iommu specific property to help us fixup
> sm8550 iommu definition.
>
> As I say if that error wasn't already in sm8550, we wouldn't be trying
> to solve the problem this way.
>
> So lets solve the problem for Glymur and Kanaapali and then backport
> upstream if we can or downstream if we can't.
>
> What we need are new devices what we will do with the data in
> iommu-map-masked is make new devices. We are mapping data - iommu SID to
> device and implicit FUNCTION_ID to a device.
>
> So we should be declaring devices, instead of burying the data in a new
> property that is not obvious what it does or why it exists.

No, these aren't separate devices. Please stop going down this route.

Rob
