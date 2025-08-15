Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F3433AD
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265423; cv=none; b=HDVBo3yFre27SH9wQcKXXpejTVAlxYvCFEmbOyj9EW9rkNyPCnRHR74+0MRWzMM0WFCingVfMsLue45dBn+sFlDMRw/pkGEE11zSmEZlPneXN87+aBjlnP3P6U9gTvj/jn7/izXHIvErWdJ/Lm3J2BsAmRDuhp2GDdkOj1y2Ik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265423; c=relaxed/simple;
	bh=Vrohmo6+Il6kXClzDJncm3wnSxmEfUIFFNEFlNBXjHg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qD4p47IdAvznWxNMwOXbMgSw9wbHbDed1AZvIQ7fPatNvyIyRptRDozvERx3t6jO1MY8AWUJdmCsHJ6oU3FPgpTFZmBFxFmZS0E35Yryk99HNWyZhhBQzSYvGDWXU4LX+J+vC96qhPWy7xnhlyg6UPZud0/hwc48GJU9/qhc+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WVLhul4Q; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WVLhul4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755265375; x=1755870175; i=markus.elfring@web.de;
	bh=Vrohmo6+Il6kXClzDJncm3wnSxmEfUIFFNEFlNBXjHg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WVLhul4Qz8ij9rwnCIYwyGTTIaAr2/q68slUKr1AUGJjcbMxqQMLYzakfkz0AeTy
	 wbPsIyXEUZk3yuI9UBOS3IWbjDAGghfFJLaGs/FXbQP0vSJDjb5Eb6onv7jdI8bw4
	 gSeas6UnRs+9US0ndJSrltOyqkON2h/JHfiA4E2WuuLFvcoiiLfxRTlOT70ucjFg7
	 4zckwVFhPrNab2eoF08GMJKHRlcf8uAd5c1vBzUb6fKvPcAiNeV0zTXMgZ89mTEgb
	 J8LHxDj3jFg+U/mEWxzG62QgCuZQ4H+yhlhM4khUK7Nu2z/xH2wYsZwWU5oQG/TgY
	 QyY/VGxnrW7fQ57aIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ZZo-1uhOvL06jM-003WXv; Fri, 15
 Aug 2025 15:42:55 +0200
Message-ID: <712b3b74-cfbd-45d8-8c19-6f2929b71358@web.de>
Date: Fri, 15 Aug 2025 15:42:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, iommu@lists.linux.dev
Cc: akhileshpatilvnit@gmail.com, LKML <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Will Deacon <will@kernel.org>
References: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH] iommufd: viommu: free memory allocated by kvcalloc()
 using kvfree()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rBdso/384yFSH5Whb6QSwa2Gp3kXgDgYHFfqSp97PbMQQ8N9xUK
 /iKyIiHTOHWOhXwTQzScbx27zepCrgyZICXsF2zjsXFB3GdLGlWJfgiMQnrpC1BuHicsh9D
 9A4WMf8vmbRQ2xVTef2grCJ+qofyyZhgCRR0eeUaE3XEU1YjnOPPXUf8YihgW/BKDSRbmmI
 7YAS29t+yBwobzIVu+r4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q7MgzLkJsZc=;DFVhjj7Y4DWB/bBDqYLMJUt1Y+Y
 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

> Use kvfree() instead of kfree() to free pages allocated by kvcalloc()
> in iommufs_hw_queue_alloc_phys() to fix potential memory corruption.
> Ensure the memory is properly freed, as kvcalloc may internally use
> vmalloc or kmalloc depending on available memory in the system.

Will another bit of background information become helpful
for an improved change description?

Test command example:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> /usr/bin/spat=
ch -D report scripts/coccinelle/api/kfree_mismatch.cocci drivers/iommu/iom=
mufd/viommu.c
=E2=80=A6

Regards,
Markus
