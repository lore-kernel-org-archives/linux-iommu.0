Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5F1E3DDE
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768053622; cv=none; b=ZFqyMgm2RjSLbD0LR0gitE2gPKQsXXznnT17J6mzg+HmrBren1V5Uf3VUXjn4qNaTUyvIZzIYgb3Cr4PUullQl32nywNxE6wego4ncjmuq628ZJUimcn6QO00v80PsI2A0oiovKJ4ywRDT5p+Nb5zDFe3DSHd4hS8HXWD74Og74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768053622; c=relaxed/simple;
	bh=6DVq7ZlFIP2U7zqIthglAPzyLV1j9jsMbBspwBcCznE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=O2liIqtrQhNFynu863QqhX9InzHNcwDlNThit59lcMU5wlNND2nFS1vk96kko42hdYBCSzcKqPRmr1L6TknJz0m+yvXqCtKTKHSa+LMQLUFWJgbJ/Z/BoTPOr44s6b+jIpDJRo20Ib4Ko8F5yVvkQkJYwlkT49YDsEKdPPSmkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SYojlYr9; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SYojlYr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768053618; x=1768658418; i=markus.elfring@web.de;
	bh=+aM5gCZ2gCBwow/QNFKuCep9MZ3DefQ5VddxE9WwCF0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SYojlYr93bHi8Zu8Ft79AW3obKLnoJIz7O7ckOyIpxDG+tDoMBcuNDSgvPgHiwHa
	 cq18SQavsU7ByaytiNzP93eWaJI5ggT7TMBS2w7Yrm5R4IxlMbOv9DuACIqiSPk2p
	 aT9oSt1T1sxCnL37vy3AGFhDjqY6TcGMEA2M1ULDNOH+cBNr+0Ml1bLiWDRxaPDD6
	 70Ys1fp78IHENVKpb3FJZcbiglVEFTmTzQweElmtlYlIlP9e0hQ1uBwTrOlHKyZCd
	 Lmf2dyNr15VMEEdrT6+BiWPAYqj6kWQ4wSBSniBL8TB00l3P3TGxPZ2k4EIhgt0YG
	 zJhGJfJbsfXhQPeuag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.231]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14pE-1vp76m1EJW-00uVlu; Sat, 10
 Jan 2026 15:00:18 +0100
Message-ID: <34214ff1-3aed-4d6c-8ea6-379341bb0c29@web.de>
Date: Sat, 10 Jan 2026 15:00:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <60d2601b17c7008834fe393e75990371cdac74b5.1764591214.git.Ankit.Soni@amd.com>
Subject: Re: [PATCH] iommu/amd: move wait_on_sem() out of spinlock
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <60d2601b17c7008834fe393e75990371cdac74b5.1764591214.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FStUyh9BxDVQrdRLjokKtHRsfy3w7mS8/VI8/aV77qy7dx5JxmM
 Lt26Sb3VuSwjV9Ez9HOdMjwPMzxl2YOYJ16fwEx6yMiHgCTx89geo57sIOJtgMe8t0luIoo
 m4nxbSegilCOl5vQlVPyY1Fg6v1xXv4knsxxnz4Fh3q8jp+vVHTxzrC4cVg/TNlSDyUc5c8
 shYnFdz/UHwKVuKHrybzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZetqDgIcpLM=;npSltxuVNFzAlWSig6CqnoWJFSe
 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
 czAsrtbyquVP/4pYU=

=E2=80=A6
> +++ b/drivers/iommu/amd/iommu.c
=E2=80=A6
> @@ -3094,13 +3098,18 @@ static void iommu_flush_irt_and_complete(struct =
amd_iommu *iommu, u16 devid)
=E2=80=A6
> +out_err:
>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
> +	return;
>  }
=E2=80=A6

How do you think about to omit a return statement at the end of the implem=
entation
of such a function with the type =E2=80=9Cvoid=E2=80=9D?

See also:
https://elixir.bootlin.com/linux/v6.19-rc4/source/scripts/checkpatch.pl#L5=
612-L5622

Regards,
Markus
