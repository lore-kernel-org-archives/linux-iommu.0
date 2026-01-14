Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD08374176
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373630; cv=none; b=IlBckyGS/OXL6O4Bek9YdSgP/yst+AXSTgy2YNJF6rUnxmCNdY4zbxKEf69D1iQb4kq/EyKbjOZz50ANZWu3uuuF1i75CgtMqKTKl9qAtaaZAoFOnOYkb5ah7FuCXA3Z7qbGo4TU1jGjxXK90dB3oSkUJZB8wycxH9MfXIQzLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373630; c=relaxed/simple;
	bh=UuE2NEMPmZND9HfmUMJ62Ma7N5cw20GBidbbm4X+/qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7pZlD5qvaLzDqfag7R4TyxODRwrUquipDKL/02i1eznU2CXzD7SwBfeMW6/94egjpvfNbWKINnbHVfDSbAlA4Q9Ymi/QF58mBuM0zE0oNaWDx6+IW7yVAHG3dIRAEGVP712iO0GVy56vLob9RoK0rzWxDguqtpv1G3+Murh400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=B/L1ox3H; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="B/L1ox3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768373588; x=1768978388; i=markus.elfring@web.de;
	bh=4tlCx2XIEio4++jba8riKJqG/c7JTdEBZyiuxQvCPGw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B/L1ox3HeGvijt7oTmtQoBz9zTO1bE+r1ZKxoWvuP0Ltw+l6t9wDAe1auFysBSJH
	 2zbcaEP9nIL1YCHy3glGMCD3EHB1P7W2xDWbey/6U/uxVhv/UzIMalfiYm/KLIdT1
	 qB63SQ2MRd0Bj5rk3HYHImmH1GBWvkbMG0lMisr6+pFW+SBxB+018jjhGihN3uCg+
	 +Uy1s+OUPr71Qw1JLrFzP2jQ9Q/eE0LmbcFIpMl0ySlN7YpACT3lUpbiFPH1oNYvS
	 i7fySqbx0xVA2yzgWcDf5HMLpOKZTDhxB1YFnzK6N+6q/YQvxRLuXx50QnFPSDnco
	 nuheiyxxvAze7XY4vA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgibY-1wKigC18Mm-00jf9Y; Wed, 14
 Jan 2026 07:53:08 +0100
Message-ID: <bc0973d7-33d2-4fd7-82ac-4f3420bfd4d2@web.de>
Date: Wed, 14 Jan 2026 07:52:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu: use LIST_HEAD() for group_resv_regions
 initialization
To: Can Peng <pengcan@kylinos.cn>, iommu@lists.linux.dev,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260114055320.399056-1-pengcan@kylinos.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260114055320.399056-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yEAnF9F8CLNaUhSlZYSuMmIKlKmhaDTGFU2WHJsFV/iP4umK2/Y
 uvAipuUSUa5bFFEVdZgjdFZk/B70B72pGN7wQvkht1e09SKDwKnHQITpReB6nHMv0F0xTi0
 z/qxpQGL4McWOKHehOFCMp3QOx7IXcNJIH6DpnDoiSqQhTKL7tRxYE3KI61ueQJ+5+9IAwg
 sSVNPLMHf6djLODpIkAzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4EeYNVHIn7Y=;tbNCmIhw/Tztrnj7fhAW5+P26P0
 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

> Replace the manual declaration and INIT_LIST_HEAD() call with the
> LIST_HEAD() macro when initializing group_resv_regions in
> iommu_group_show_resv_regions(). This simplifies the code and makes

                                   Simplify?                    make?


> the list initialization more concise.
=E2=80=A6
> ---
> ### Changes since v2:
=E2=80=A6
> - Retained the LIST_HEAD() cleanup pattern consistently across the file.

Can you recognise further adjustment opportunities from the presented smal=
l script
for the semantic patch language?
https://lore.kernel.org/cocci/34ed442d-6ebd-4907-a77c-2c08db799411@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2026-01/msg00002.html
https://lkml.org/lkml/2026/1/12/932

Example for another update candidate:
iommu_get_group_resv_regions()
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/iommu/iommu.c#L9=
20-L946

Regards,
Markus
