Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018207;
	b=TeSservgcaRA+fEUcOFlvFbKO9pgIe/0Qy+yC5TCvA8KjT7mQ61P4P8FERxK+Wbn+U0x
	 tKBNHjMpf/cU8JYRNUWY8Kc/9Wm1eRtNYb6AoFb6wb8y5Q88EXyfav0A3Dtmux4hxitGD
	 1i+rXxfVkgdEYWlPSnZK+66ujLJKUIRv/BaZnd8g/SKXqdxgmK5ClBmxhoe20TqFv6qPh
	 g7FOzhQqWjG+sC7juJpfIczyzWhF5nYWvUukgqaV7WBW/ZM2NYa26vd0A730UEpz804bd
	 ETknFf0+kVAQKT6g4HyAdk1hvG3pmPLCB/TDVRI+EKWHySknr9hwHJD9BGH/w9vCsJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018207;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HICHL9vZkQCWXFVCM7oneoRD1DunhAvGDTsJhni/qVE=;
	b=LZGwT6C3FQKwlG0ZQt1JdV3enUf0q3BZVvCEjVZLuTxC+bozRNhz5wK+c9j89qwE6VG3
	 cis1p78K3ED6iHdwBgGkdgBkpOiFaQmdnIAhuSHkm6dWUEuoKRCk9L2U0aCdx+zFRn+gE
	 mgVeKNQfzE0Vc/xCBGKtFRmQ5JUxJMMkNLM57C1ub10T5wXdfmV2OPR/kVDoE1OOAfgUx
	 t2zIb09JP/EpHB4m6LAiYspakApEso1ta2kYFT1F/S9IZDskmSm/6iRt4Ot4sQ1paO7A+
	 XuFjHOh44mC52agN/la43lSlz41m+6ei+KnilXAZ9Hu/ou1Tu0gjM4vw41sR/OMMfOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxsw.ie;
	spf=pass smtp.mailfrom=nxsw.ie;
	dkim=pass header.d=nxsw.ie header.i=@nxsw.ie header.a=rsa-sha256 header.s=protonmail2 header.b=FRE4tG1L;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8831606A327
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 12:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8831606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nxsw.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxsw.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxsw.ie header.i=@nxsw.ie header.a=rsa-sha256 header.s=protonmail2 header.b=FRE4tG1L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxsw.ie;
	s=protonmail2; t=1793018201; x=1793277401;
	bh=HICHL9vZkQCWXFVCM7oneoRD1DunhAvGDTsJhni/qVE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FRE4tG1LnrwPMi1Cs6EYtxZmcPtPXX2/SE4okIEdW9rVrzobdakT2R0CKf5fvUEO0
	 t+b2C6WctcLo25xN0blezizIBQ8tTHsebLDUTR22hRjDssJcZBzHNwJhxMYOpPeS5R
	 MzenK5/ceoCP91tpKPETj17/y2UldqApEelbaDn9f6umXCZrYU7EvrR2i/GhmFzXo0
	 04w6Hn9zZg1nVwENTV7ibIOUs9+HxT9EAmWz+AP1b+jJBGAKlijhjkQKgKEXouFtkT
	 j+XmIZjV1bu41kGShv/ZA//Q1IE9RgHQkYSP8IAzxU6fWsqsV4r7HGYgnJ3GB3WeuD
	 tAE1+HOiS5Y7A==
Date: Mon, 26 Oct 2026 12:36:36 +0000
To: Bryan O'Donoghue <bod@kernel.org>, Vikash Garodia <vikash.garodia@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
From: Bryan O'Donoghue <bod@nxsw.ie>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/13] iommu: of_iommu: Add support for "iommu-ranges" on a device node
Message-ID: <0b9fff7e-f284-4d46-a384-098bf90542aa@nxsw.ie>
In-Reply-To: <a0ed3cf6-a58d-4a74-939d-62c9e6643b79@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com> <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com> <99a419c3-81a8-4b37-b9c7-2dd56978162d@linaro.org> <a0ed3cf6-a58d-4a74-939d-62c9e6643b79@oss.qualcomm.com>
Feedback-ID: 54899767:user:proton
X-Pm-Message-ID: 068be5f842ec7b780e5c7dece63d821971e308a8
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/10/2026 12:31, Bryan O'Donoghue wrote:
> On 26/10/2026 12:08, Vikash Garodia wrote:
>>> https://github.com/devicetree-org/dt-schema/pull/207
>>>
>>> Perhaps splitting this into two patches as an iommu-series would be=20
>>> best.
>> Intention was to keep the patch to add iommu-ranges property as part of
>> iris driver patches to show the usage of this new property.
>>
>> I am fine either ways, whatever it takes for the maintainers of this
>> file to review.
>>
>> Regards,
>> Vikash
>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =3D m=
aps + size / sizeof(__be32);
>>>> @@ -258,6 +367,9 @@ void of_iommu_get_resv_regions(struct device *dev,
>>>> struct list_head *list)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D iommu_resv_region_get_t=
ype(dev, &phys, iova,
>>>> length);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (type !=3D IOMMU_RESV_DIRECT)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>> +
>>> If you look in iommu_resv_region_get_type() you can emit
>>>
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_warn(dev, "treati=
ng non-direct mapping [%pr] -> [%pap-=20
>>> %pap]
>>> as reservation\n", phys,
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &start, &end);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IOMMU_RESV_RES=
ERVED;
>>>
>>> on a mismatch - which is not what the code will do now. Mismatch will
>>> warn and then not map.
>>>
>>> So maybe dev_err() saying you won't map - in the new patch for reg.
>>> Either way this isn't a change specific to iommu-ranges.
>=20
> Sure the above needs to be addressed though because its not a straight=20
> change.
>=20
> Before if there was a mismatch it would sill be mapped - now we print a=
=20
> warning and _don't_ map.
>=20
> I'm not sure that's really what you meant to do here but if it is it=20
> should be stated in the git log and IMO it should be a follow on change=
=20
> _after_ the initial addition (or before it) stating why mismatched will=
=20
> no longer be mapped.
>=20
> Because add iommu-ranges !=3D don't map mismatched, basically.
>=20
> ---
> bod

sic - "before it was reserved, now we will print a warning stating=20
something we don't do and won't reserve it"

---
bod

