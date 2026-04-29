Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAD39D6F9;
	Wed, 29 Apr 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445930; cv=none; b=Rn/YptPs2ZTVP90S54BZp1+14Gwm0YKr5QAIFWkt7Dn075/r8sInjuhNGNn7l8/ArzwrL8xricpvAoqG6mf7hKTR0crmm08EXU72Zv0oPRiSJkWl2fly41YcPe2zpUyFxLfx+FkmBTHejd7W0LMyTgVBUmBmxTvO23wnI+LrqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445930; c=relaxed/simple;
	bh=u4Pfn5a/U0AlGb8AqkEdtAoy0eLj8UmNKcvMgCHYYec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/SCrNPrHImbFaGur/XhHpSTXVwcJUyZ6uzBYw5BtBfGJ2iT5xNXpenbjzpsmHvFSn77Q1QodZpQILoUQ4xqy+ucEwHzM8tO+AzGCCtTEutqd4b4+7PHzLaw3mk/2/A0x+pnmTd+w30PfAlqe4A+sZABTgk5lvATbjXRuR4t/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuSlswfz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuSlswfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28B9C19425;
	Wed, 29 Apr 2026 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777445930;
	bh=u4Pfn5a/U0AlGb8AqkEdtAoy0eLj8UmNKcvMgCHYYec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuSlswfzB7iS01np7vobw5kDq/S0raz1Y/72kRLxRYcbyrLrEdn4ZOR8t2PNUMkzt
	 u1OP4+iIAGHPqITBECrxxjDugEXnmIfRf/Rm2L831QdbQB4mH5TChRjrlBt78n/nO6
	 PLrX9vFwp7OL6chDwF0DODIPk7lXFnIF5kHCyPz7HUAsnoMWuZza0o4BodA+a5/DNI
	 HCpRZXJhV94y2RAWQ2wNfTDmS9Oiz7E4U7p4aYSIN6xUG4pv8jzCadXvGp6ki3hCg1
	 oBkLSGLOP3wnrkXi6ai2/+5mCBUCrzxueCKz48RCeVHQd3OzLeRZnG8akIcBbxV/TO
	 ISSB8xNmlZd/g==
Date: Wed, 29 Apr 2026 08:58:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 02/12] dt-bindings: media: qcom,glymur-iris: Add
 glymur video codec
Message-ID: <20260429-calm-shark-of-tempest-3a7bcb@quoll>
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
 <20260428-glymur-v3-2-8f28930f47d3@oss.qualcomm.com>
 <20260428-nifty-quaint-hoatzin-6de65d@quoll>
 <97aa5f18-d1d5-f082-9075-a385255f2e97@oss.qualcomm.com>
 <7d775357-c7b1-4cf5-af90-012d1364e773@kernel.org>
 <6ebe28dc-b8a3-db92-0e66-3f0541e23e13@oss.qualcomm.com>
 <1f88a8eb-1725-4e6a-b4f3-287ec538ee7d@kernel.org>
 <e39df722-3868-60d4-07f3-768d11762e12@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e39df722-3868-60d4-07f3-768d11762e12@oss.qualcomm.com>

On Tue, Apr 28, 2026 at 05:46:55PM +0530, Vishnu Reddy wrote:
> >> Glymur is the first platform where the common schema limits become a h=
ard
> >> blocker, unlike all prior platforms that happened to stay within those=
 limits.
> > Hard blocker? What? How? you are imagining some problems here which do
> > not exist in any other devices, any other IP blocks.
> >
> > Why is this special and GPU is not? Or display is not? Or anything else?
> > Why standard rules of writing bindings do not apply here? What is
> > exactly different? Write like this:
>=20
> The intent is not to treat Glymur as =E2=80=9Cspecial=E2=80=9D in the sen=
se of resource
> count alone. The key difference is architectural:
>=20
> The existing qcom,venus-common.yaml was originally written with single
> Venus/Iris video core and its maxItems for clocks and power domains were
> defined accordingly. All existing platforms fit within that assumption,
> even if their exact counts differ slightly.

I don't think that's anyhow relevant difference here. Just change the
common binding and be 100% SURE that all devices have correct/fixed
consrtaints.

Best regards,
Krzysztof

