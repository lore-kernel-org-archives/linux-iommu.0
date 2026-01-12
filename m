Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F01531C8
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221064; cv=none; b=a6z6/rRESXOlyZm3e09Wmy13292j0L8gBgO2Cbkno3DTZNeZ+TQOpaeLcvE6dEEFcExfga/rfCt0dx8y2fIvSFdI3jCLm5YyNYmq+koLWM89Qwb8UeTm7RRVK+szm/cia0+xEASCA7gjKp6U0D07K2MUMdOM+/4zv2In3XI/n6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221064; c=relaxed/simple;
	bh=I9w/uPvWCAFwcUlwUtNKl2OcmM9ufReH3rqZUtAvmQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwO+c726rENWnKEUDDTPypoosx5I6sQtV4grfDr5PVzOI66a/WQCf4E6TwZXaKTDH61dsl8+SiY6tGur58s6wYVN8yXrlcZcZ2POFVT0o8sv4VqXW+8B6U+2C1FsIgTEMjnOEcze1ULV/Y1IweotjyxmxtzxMLYT+Dy4I05g5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EY79JJkT; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EY79JJkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768221044; x=1768825844; i=markus.elfring@web.de;
	bh=+TYJdP+0voSY4YMGGwNqz4sVZPOyXTpC3AYF9DYNOS4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EY79JJkTK9LYgd8HsTF3WAds1r1FDmiuQfpv1UQJj1dDnCgLHNxe8e9uxeQIlhry
	 TKv5zjj9ow5Vm4y1QRAu5gXRpWvNwsgKrFXwOPrFNy7+xyxiF53J64HDpJsYyQfg9
	 2hwLp2R1Qv/SNX+Br2FaFs7A9R77oT5oqLXrgB5s2n6z3dEa9VkNiyGVcX47BMRBu
	 VWt3AzEDk106hFZIhtheS4qxxGEXklhO1g7920FMg6t3rhPa7Qy34SdWaF6/ODHlL
	 8+FCn/yT/ZOm33KLNT5OU7keCCqlUj75x6+GORabhFYWQmWqfyB0UN44PLe2u50I3
	 5ZQcgE+vnV5F/96TOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.241]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5o3-1vWiLV2XNR-001j6Q; Mon, 12
 Jan 2026 13:30:44 +0100
Message-ID: <34ed442d-6ebd-4907-a77c-2c08db799411@web.de>
Date: Mon, 12 Jan 2026 13:30:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu: simplify list initialization in
 iommu_create_device_direct_mappings() and iommu_group_show_resv_regions()
To: Can Peng <pengcan@kylinos.cn>, iommu@lists.linux.dev, cocci@inria.fr,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260112032116.49781-1-pengcan@kylinos.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260112032116.49781-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9vd73EM2EVYwZ/jTJJySINMtqqeXYRo+qHK9ycIzOmpWHbPZW7T
 IPtCAjppJYD/BX0XlbOXY33iMVvINz86Q3lowmFxdwJG792WCzqjEUSoqopR5zeurM8Sy02
 fmqKtjKRrg190ucVvgsCwR/2h0alULJ99K1P2pEDoyR3aQX0byCsAd6LqpqkW5u2yfV2pBs
 FWwodPm+Ht6I2lVjRECLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y6DeUF/OvYU=;iEIzVPL9ty/VONNohzeO6htbGQE
 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
 1ta6Yg080bHWvQVpnaQFkHp7d1QRl6iaw==

> Changes since v1:
>  - Extend the cleanup to iommu_group_show_resv_regions() as suggested by
>    reviewer, applying the same LIST_HEAD() pattern consistently across
>    the file.

Thanks for your interest in further code adjustments.

* I wonder how they fit to the feedback =E2=80=9CApplied, thanks.=E2=80=9D=
 by J=C3=B6rg R=C3=B6del
  from 2026-01-10.
  https://lore.kernel.org/lkml/stpavkxy3sbevk7zmt4kxyecqy5gc6phubvcfutbtnu=
k7vphlh@a7aimtvk423i/
  https://lkml.org/lkml/2026/1/10/235

* A shorter summary phrase might become more desirable for this patch vari=
ant.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.19-rc4#n687

* Will development interests grow also for another transformation approach
  like the following by the means of the semantic patch language (Coccinel=
le software)?


@replacement@
expression e;
identifier i;
@@
-struct list_head i;
 ... when exists
     when !=3D i =3D e
-INIT_LIST_HEAD
+LIST_HEAD
               (
-               &
                i
               );


  I determined that 175 source files of the software =E2=80=9CLinux next-2=
0260109=E2=80=9D contain
  corresponding update candidates.

Regards,
Markus
