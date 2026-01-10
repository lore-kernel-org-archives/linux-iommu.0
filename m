Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BFE3148C6
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045723; cv=none; b=ia1X42dk4h6ifsjGI+OUOe6mITtlNW57DYMPeFIB4gax2Nfx1d1Vb0FIWAjb4bgJonmLTEFsnHs65cIQlc4y6ef68n5BTZEp2rDdVesqBYWbtYjCDE8ACGBbczFcmNS8waLgT3tQNDQmv7J3HczrMKIW+MHpGg8KQ+GG5HaxO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045723; c=relaxed/simple;
	bh=29d0Pykyr2lbP7VAiXHiIRGfXEbT9/jtOdH3tmOzW5E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gEckF6KuFJY2WwYBSmlO6blOfkqdjtUHX1Elr4vjKdtXiKGpvyXE98SvGuLSlBbPX576dBKNnCM+aVVe/U/Yq9PCFFJf1Sqj10yJpG7qIs6W1fKtgv2UCka609Mw5itSl509WalQxAetwigPCH+EhFuFRMe53Xk7leowDf57WC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZANQ6CIo; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZANQ6CIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768045701; x=1768650501; i=markus.elfring@web.de;
	bh=29d0Pykyr2lbP7VAiXHiIRGfXEbT9/jtOdH3tmOzW5E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZANQ6CIonwj+sinocRwZImyRoHbM5pWdG9rMb2ZaaMeIkFFRUEcG5ecSPE0tl2WT
	 cO1JDn2SepB8+zzg0EaVr3JIE3njMHsyaBAZ+V70k1/8ceMRgzKXJw+l/pUJVTGkF
	 X9hytnoHg8jUdfRbdPMIRCBLkUwdp6beiVYLb+0P3DcEacf3nA7+6IQb+hn+3ZnaD
	 njN2gHD5oH9ls6oJKtgWo62zGw5ELwegPrDahmsAf/L6SWGogTCWcTJUOM0tuopXt
	 r01kP8cxKYPLwQX+cJ0hwas0I42zJ57gz6KxzEZsurLCcFlEHSeiotlSVnVfVRVlc
	 yJrCdb5SZj+PiDc6Cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.231]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDQj-1wEhHe2TwN-00iFbx; Sat, 10
 Jan 2026 12:48:21 +0100
Message-ID: <6af1bb46-89fb-46a8-94d8-61df8f1a50f7@web.de>
Date: Sat, 10 Jan 2026 12:48:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Can Peng <pengcan@kylinos.cn>, iommu@lists.linux.dev,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251209071513.3105610-1-pengcan@kylinos.cn>
Subject: Re: [PATCH] iommu: simplify list initialization in
 iommu_create_device_direct_mappings()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251209071513.3105610-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y28RYBPwfIzZx5VJ6dWHUc1jAKtuun9FWMZATQCDC8kRKAkGVPg
 zI/gaLp0posMlRg/m6aoz5Pa/EExS8r08WBtzKp0+DcX+up/FCqCOiGdeI1ti+fYoeXBiaA
 nNAhIxZhBK/zKYD61K2OBCNIMHbs61zvnqc9wsNRJplTqKrNNBYGT24RB1EnLwP0dLKSET0
 uSWaXG+bfSijGYYfCMCCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nG2IoUooHEQ=;AqhEG/6JIwf6ExjqTOqgJAIURI6
 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
 vjlnA9/Men1nYDW+zuYp/z9dhxs8M

> Use LIST_HEAD() to declare and initialize the 'mappings' list head in
> iommu_create_device_direct_mappings() instead of separate declaration an=
d
> INIT_LIST_HEAD(). This simplifies the code by combining declaration and
> initialization into a single idiomatic form, improving readability witho=
ut
> changing functionality.
=E2=80=A6

How do you think about to repeat the mentioned transformation approach for=
 the implementation
of the function =E2=80=9Ciommu_group_show_resv_regions=E2=80=9D?
https://elixir.bootlin.com/linux/v6.19-rc4/source/drivers/iommu/iommu.c#L9=
49-L969

Regards,
Markus
