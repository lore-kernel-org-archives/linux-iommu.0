Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6047ECF3
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490713; cv=none; b=GGZh0O+c7ybBNWkKZpEYaDS13vZQz8LLztG1EVygkuwCDK6asL5fUqk68rAzMqTGn6i8Gn3BlWdhmUJCemPyIinHGzO9/H8PZG0J/Q9K2HKweq0BFJFOcg4e/J6bEygIvQaGAdui4JgKBsUOD2ym3DZfJibbVCIc/i49mdj3pgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490713; c=relaxed/simple;
	bh=pmCaLcV3BndJE4Up2tsUK1bVlYyaiT27VrWZVDi0Pvo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MEISq4JlY8ULZt7dJlE1OyFIfu5Zxf1cRWmBqGmruhyTxqPGDaDLr+6d8RzPMUOmXZ4dQg6TANZ3OJCBRtQVuHlPe3OBaG5XNodY+vguf9X63i8uKala5XsW3Ff0YTtvMkAUvB+3PIky7RO+VLg51E0fDvJBPttqoF/DT3XXSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alex-min.fr; spf=pass smtp.mailfrom=alex-min.fr; dkim=pass (2048-bit key) header.d=alex-min.fr header.i=@alex-min.fr header.b=jMb8Phkz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGjXwc+m; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alex-min.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alex-min.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alex-min.fr header.i=@alex-min.fr header.b="jMb8Phkz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGjXwc+m"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 51AF51D000F6;
	Wed,  3 Jun 2026 08:45:10 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 08:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alex-min.fr; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780490710;
	 x=1780577110; bh=0w4fKjgwyN1sYXvZXWscVp1/gGoJcvguUwQb4TJrhg0=; b=
	jMb8PhkzukIo0SYLecNSmZA01xaKX8vClWzSLEmPXDJiSCsTP8HWlAubG5XPDgnU
	5trqGD0zzBjAEdwnQ1CwAxpmpf533hbTFoeTk49I/jIF1Xg4JiB3pCK8x8/b7AO7
	mbRjZIIUoN+be1BF8yZ9OKVTJo636xHLX7E7EraYxgICZLdOQWhOmt+dYxzJ5oa0
	ExZSFf063fB9t91AhxyaNwHoBa9ARgqBxi1epfJpDXrcTQb4IfvPCQXE0Xg7quF0
	MzKEZ5/iXptuKVFUiz1ww1K7vI0T0hXa5Vw814sLXh16DushwC6e5MF3A6uZQpP3
	HTbNEji7RlplMMVOpG4V/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780490710; x=
	1780577110; bh=0w4fKjgwyN1sYXvZXWscVp1/gGoJcvguUwQb4TJrhg0=; b=Z
	GjXwc+mbSkH3xpVIzZsnAVu4D6JR1PuaYbhjquSAIqCMFGU9rMdIkpMKHD8FX6UE
	5CzNp6z++kt5vDuZw7m0bMv2Ce1mxUnDFIv9pXMD63lP2FMvV3nMPId8IF4v5TpB
	VZSz54nFjnn+MO5c4XJUX4T7DdoOFBoFik/Bg1rTz/W6KQt2ULaZ+EZguwfwtygH
	UGLGmWrTdvDcbWaQp8e0vR/PtXe8IpoM3ZFTo7GaWx/G8sP9EJ7qPkz8IxCWszet
	OPcxRcBGPAApEzSrrsKLMVh5Uvcf76O8nBYEXt0OmxmnUSpheT6KUJhsk6CmC7aw
	5Bbu9xTxlZTaXY9lTEcnQ==
X-ME-Sender: <xms:1CEgaqLBMLPgjcl95GtFHHUFBjUy19XtCWwLrIhRrjtYzTmlpp7GfQ>
    <xme:1CEgas_RoPLuGFSipaiWKnXSIE0DppRiPaNYIHmzs_J0guL4D2vRD92wtfVLQBiqA
    yPD3bWlpbY4jcVO-Lh06Jm_5QOlDbf6OnduJEsKP3oG6VO44et-YK8>
X-ME-Proxy-Cause: dmFkZTFKc6jEQ9TYKBUeYC5FWNyUnl0VlrqGUvFtj+p69xyNqcz9jlziX+utsFNH3pCofK
    7QwJyK+T202ofToUC3x7QCWne3wa3FCewYAwcIhX/k210mHxjS65VfoD+uXZkzBhVPEfq0
    o3SMlHT/qMbzfIdCi2jhahdfB8odVsD5DshhjXNK5pulYNh2Gfx/INZidrss9vTZHH17su
    mMrdkccuOfuqLwEFIC9mD/DhZe8TNkwBcgcxVZ0GIDHf/yj3D1k4R43Y88ns/ARGC6oimw
    LkM7pFlXX/1e5a8r0U+Vgq3LnSE15l3zgzGqTwxbRwAqz2+2OdLneQL4hm9jzSunEnieGb
    qIu2GndAmKyw4GoihhxfT9GGnPa7hnI4q9K/EgSFy/ScJbXfliKxLwE+2XxVq4M8cg+3q2
    TkiuuyxDg4RUpK1k1l7v6NDHQNOHQAJo1GNBaerf7k6/SMfSCpHW1f0s+9Tt4jNn98F72M
    Zho2+D8NjYiAbinZ7aBS+aPtlSOibCev8PcUV+Xty1nszWrwyrGNFOAGZGHEfgj5hdtvdc
    LqfS8uZYJb/hYkBg8y8pTKy5pLyiSmlBDxN3Zhanqid+wIepCb9yz6bWnfWPZpMGUMmq8S
    UZDZXdeGl7u9oYkLNTnkwNXj67AhjaSA8JEWQMGlYATkQs+ZnXYOLvEs0uUQ
X-ME-Proxy: <xmx:1CEgau7AmZ9inZRCKIuCt9XCXsyzb_2xjhKQpuVtSdWzpQrZn7_8YQ>
    <xmx:1CEgag_vo7DzsJKjaVAALEH1L8HzfRLJ6NuREs0f-rdYP7eSZMy8yA>
    <xmx:1CEgamig1OZTp704gUOqnVnxbgimKAPSEl2qtaMW0-tEa1r8zbwqKg>
    <xmx:1CEgam47aIGs3Op-THljAYksPRyCAtu84mk1woSdlgRX0JtDWzLjRg>
    <xmx:1iEgarnJZkm1Wf1fP7OZSQUsuYia_vZbHlxXbj2UnlamqlbN9wr-jawe>
Feedback-ID: i72694427:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9AC1218E0071; Wed,  3 Jun 2026 08:45:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: A511MZycEBGs
Date: Wed, 03 Jun 2026 14:44:47 +0200
From: "MINETTE Alexandre" <contact@alex-min.fr>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: "David Heidelberg" <david@ixit.cz>, "Linus Walleij" <linusw@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "MyungJoo Ham" <myungjoo.ham@samsung.com>,
 "Chanwoo Choi" <cw00.choi@samsung.com>,
 "Guru Das Srinagesh" <linux@gurudas.dev>,
 "Rob Clark" <robin.clark@oss.qualcomm.com>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "Kees Cook" <kees@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, iommu@lists.linux.dev,
 phone-devel@vger.kernel.org
Message-Id: <56ee469e-dab0-49fa-b808-d421b7505622@app.fastmail.com>
In-Reply-To: 
 <thj65jrvef3z3dmn5f52jplewrjgklomc5s32grktsjejs72sw@npk26yx2hpf7>
References: <20260519-mainline-send-v1-sending-v3-0-3dd7aa125353@alex-min.fr>
 <20260519-mainline-send-v1-sending-v3-3-3dd7aa125353@alex-min.fr>
 <CAD++jLm=BxHsPJ4rgqwY8SvaefZUO+Pfv8E8xizqPsdJZw5weA@mail.gmail.com>
 <298550eb-1bdf-4d7c-8111-8b8f0b5dc056@app.fastmail.com>
 <4b797a3f-01c9-4b02-be98-7b82099c2e0e@ixit.cz>
 <48cfedcb-a9f5-402e-9973-f5c175fd2740@app.fastmail.com>
 <thj65jrvef3z3dmn5f52jplewrjgklomc5s32grktsjejs72sw@npk26yx2hpf7>
Subject: Re: [PATCH v3 3/8] pinctrl: qcom: Register functions before enabling pinctrl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Right, thanks for checking.

I do not own the Nexus 7 flo/deb, so I cannot verify whether it needs
this in the same way as jflte. I mentioned it because another
postmarketOS contributor told me this patch helped on that device, but
it is also possible that I misunderstood the failure they were seeing.
--=20
  MINETTE Alexandre
  contact@alex-min.fr

Mer 03 juin 2026, =C3=A0 14:29, Dmitry Baryshkov a =C3=A9crit=E2=80=AF:
> On Wed, Jun 03, 2026 at 10:58:24AM +0200, MINETTE Alexandre wrote:
>> Thanks David.
>>=20
>> I initially considered adding a Fixes: tag, but I do not have a commi=
t I
>> can point to. This looks like a latent ordering issue in the
>> Qualcomm pinctrl probe path and could have happened at any time until=
 now.=20
>>=20
>> The failure became visible on APQ8064 boards such as this jflte, and =
I also
>> have a report that the same change helps flo/deb, but I do not want to
>> add a misleading Fixes tag as we don't really know which commit reall=
y triggered the race condition.
>
> But there are no gpio-hogs on Nexus7/flo.=20
>
>> --=20
>>   MINETTE Alexandre
>>   contact@alex-min.fr
>>=20
>> Mar 19 mai 2026, =C3=A0 23:03, David Heidelberg a =C3=A9crit=E2=80=AF:
>> > On 19/05/2026 10:48, MINETTE Alexandre wrote:
>> >> Thanks a lot Linus!
>> >>=20
>> >> This patch is required for my Samsung Galaxy S4 GT-I9505 to boot b=
ut I also
>> >> have confirmation from another contributor that the same pinctrl p=
atch
>> >> helped boot the ASUS Nexus 7 (2013), codenamed flo, which is also =
based
>> >> on APQ8064.
>> >>=20
>> >
>> > Hello Alex,
>> >
>> > if what you wrote about asus-flo/deb is true, then this patch shoul=
d have=20
>> > `Fixes: ` tag, as I remember it was booting with few limited patche=
s ~5 years=20
>> > back then (only one serious was hack for proper clock bringup).
>> >
>> > David
>> >
>> > --=20
>> > David Heidelberg
>
> --=20
> With best wishes
> Dmitry
