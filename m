Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC01DA21
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269562; cv=none; b=Asm7LXVl81AaO0FYadv2UZGucMTRlEFUMoyi5KZfiHhgVM5ualdCBOX7ih4xv16478b3Fynmn1dL+PPmmni6rhs4vEVakxgVNm/YlmEQIBhaVL5CKPlAVVX43bFFhNTwbra7h48Aocp81OfTSipubySEDBD+WOUzwYFQaDHtWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269562; c=relaxed/simple;
	bh=8cVDDJDNCmIkYtqlB5BkE5Bg0HuSAkM4ub+L4bGxI2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYIZ65ceYXCoWXd4139osKqKkR6cA6cvkdUeIULwC7LfvLalslwCVi45ucUX2C2pD2tWeVUj9S6OJYntAPQ2HDxZb/r8fU8bvQeI36Zb3RJbH5m90eWKNpoh/A2etcsQT55/kN2knMI+HPliw7/KQsBVrRMEde/mx5Z04xxSRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KgyO6Fhc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KgyO6Fhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755269552; x=1755874352; i=markus.elfring@web.de;
	bh=8cVDDJDNCmIkYtqlB5BkE5Bg0HuSAkM4ub+L4bGxI2E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KgyO6Fhc3vEGQgdFwuYGw/loeO2PTd7keE5MLmq6HFyPdR+4eoJgfoU7jpdI9FhR
	 OVYe1oOcQu8PzB4Bvn7cAm4dSAClY9tPqz8pJMwIUwZ4B/K2ZDYuk4gexjYfMZIje
	 8+7Ebad1foQTPzfURyZBSIjw5exWPUE/p1CNGAAWCCW9olugRXzJyQ2Gs16TvuB/o
	 yhGOKHk59Iu5fIT9qQhQD1d/Gcly5Wl7Yv0G3o8RqzAwaGcA+mQE5KF2qPatELLDj
	 zYdPdiGijAZy79WrjKmIyp1+9jgNnJ+cCoaY4VN7RZMLU2m0jmUVotVKcS7ox72Na
	 2ZcUyJU6DEiwKwWRnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1uxav302sz-00I2YW; Fri, 15
 Aug 2025 16:52:32 +0200
Message-ID: <9a52fae7-eb11-4f5c-ac6e-4bf4b9aeae93@web.de>
Date: Fri, 15 Aug 2025 16:52:29 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: viommu: free memory allocated by kvcalloc()
 using kvfree()
To: Robin Murphy <robin.murphy@foss.arm.com>,
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>, iommu@lists.linux.dev
Cc: akhileshpatilvnit@gmail.com, LKML <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>
References: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
 <712b3b74-cfbd-45d8-8c19-6f2929b71358@web.de>
 <5f0fa597-2f60-4110-8c52-6d006f5707b3@foss.arm.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5f0fa597-2f60-4110-8c52-6d006f5707b3@foss.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Il8U2cR9Hj/Xvoqzw/dZuiVJK2rqp4S90LN3l3wDTDrSIZa3+lb
 2Uv9TwqyXmTP6l2eHj0R5f3InSiv+p/+8lnE/HcqMRrMAHTjJYIv6Kh/7g/yIH1+qDlhLKS
 gGIoSI+y4pOFTeBptAFM/PnwQJ8FTF/RkosjUdLEGi+UeTe+G4VSpdhqR/w/tQ3Vc5BIhaq
 1G5hE88L1Xa3z35WYh+hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dl81L0Hkcgc=;iHX4QjTvr8hbpqWW9oaViDCBy7I
 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
 A+l9aB19xLeHGTWWaeO1hcd3F5XyIEBwSrico

>> Will another bit of background information become helpful
>> for an improved change description?
>=20
> No it will not. Please stop pointlessly nitpicking. =E2=80=A6

Do you care for help and further influence of automatic source code analys=
is tools?

Regards,
Markus
