Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D62D059;
	Thu, 26 Oct 2023 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="0FhfDv/K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z/GpDOuJ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id A7C0032009D0;
	Thu, 26 Oct 2023 06:35:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 26 Oct 2023 06:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1698316509; x=1698402909; bh=6+tEepzRhbdqOl9MvWwXAiJ7s
	lUiFVVeF7abKCPfm54=; b=0FhfDv/KuaeIZtneUDMGrWLD1ZJiTNqf17t4XuEB2
	kZJbinjrfZEJLXTmxZ9oQgiWiAF2Kfpks2Jvm9VwN1AlEAjcSlEKKqjaY9cxIs/J
	rrQ0xBmmCgFUSJ0ARA8Dv9x0OwA3RD3eRLFicr/ZXPI4eWccXTl5oo+9FB9lPb9O
	VDHvG3Uni7/CY/TXKzNHusP93vQX9FrFk2Ovpfi4oDEBnkVoLpWROOGgdXCGZHe5
	f4sHmun5mmPDFX8t9MU4qUZk2hFscjGLsyeaLNCCLaQFtQHqoM/H7/57+3iycwVm
	pPH/moj08A6xa/oZNvMnfKaOmUGdbwYcdrP+1zhdTJ/3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698316509; x=1698402909; bh=6+tEepzRhbdqOl9MvWwXAiJ7slUiFVVeF7a
	bKCPfm54=; b=Z/GpDOuJxjpBrSe1P9TbIfdEJm4mziK6+DKBFDZx4c5jTzaTgRs
	yagsPVCJSxz2gnnLpuHrgvSJDAKzwcGbez1H9FZAP3m37Cq08Xo/Z3M4GhpH3IfJ
	J2NvmOQXZpxqfcAQ38ZXeRGzB4+AbdkhphRiFjg+n0g4/+Rzv81bLKO4wJptW6Sf
	S/T3I4iqRX5BRyiT0V0cAKvEu01IFBVltMiBLV1VX5f1ziQWM7695voVc7h7kU/F
	Yxh53DQmU9pX3ZJdjKLgJrnqk9WUntEZamRID33lJTKUBpuK+sC8eQxsVPrXjt6m
	qUMvehFXEkrgCEBWDyV9FpVAO7DarIQANNA==
X-ME-Sender: <xms:20A6Zf-FHDUZINSEU_EOssEXtwfNoH3iXVp_wmsvcyBwRLHemeETbQ>
    <xme:20A6ZbtDki5Jg2R3ymkLBnMsKAfVSErf21xKvc1wxPOgyEACrobgNbaiZl8NbmpT1
    1qLf-jeNTFxlKvIkyE>
X-ME-Received: <xmr:20A6ZdAw5c4da6kJapVoXjcA4rE6gumZw2-SgokMN2zWuxCxr_D2Ru7w7BzW_ON1rneS8bzpQI4lMBaoVDqXf9FQuKX7QeD3y7xqMY4I2Pr2o8EelGJo47FXPVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegtgffhggfufffkfhevjgfvofesthhqmhdthhdtjeenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpedvhfdtudduvdeujeeufffgudekvdefvefgueeiiedvledtheegieevffdtteek
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:20A6ZbcUFKYSw09WrpR9ZGvX0qEvZZFsUkabN8756-wfQfW4GnqVvg>
    <xmx:20A6ZUMAIcgtj2Gpkgi6PkKhCGR8EZcPcOR-x862bEmwaz2T2-nEag>
    <xmx:20A6Zdnq87T4UyMpFpjL9OOX4M8PPL2xyeAIpPPOgZsbgrqc-xvbKQ>
    <xmx:3UA6ZZs-p2ku1VBDSNY2vf3ANsa4KAmVOibmLjzOO1uwXs7ODj5LHg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 06:35:07 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sven Peter <sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/9] iommu: Convert dart & iommufd to the new domain_alloc_paging()
Date: Thu, 26 Oct 2023 12:34:54 +0200
Message-Id: <20F398C2-8F87-4149-9154-44EFF2A966DE@svenpeter.dev>
References: <ZToaD1tuNJ7tra-g@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Hector Martin <marcan@marcan.st>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Janne Grunau <j@jannau.net>
In-Reply-To: <ZToaD1tuNJ7tra-g@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (21A360)


>=20
> On 26. Oct 2023, at 09:49, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> =EF=BB=BFOn Wed, Sep 27, 2023 at 08:47:30PM -0300, Jason Gunthorpe wrote:
>> Jason Gunthorpe (9):
>>  iommu: Move IOMMU_DOMAIN_BLOCKED global statics to ops->blocked_domain
>>  iommu/vt-d: Update the definition of the blocking domain
>>  iommu/vt-d: Use ops->blocked_domain
>>  iommufd: Convert to alloc_domain_paging()
>=20
> Applied these 4, the dart patches need reviewed-by/tested-by/acked-by
> from one of the Dart maintainers.

Sorry, must=E2=80=99ve missed the series. I took a brief look and this all l=
ooks good to me. Given that Janne already reviewed it in detail:

Acked-by: Sven Peter <sven@svenpeter.dev>=20


Thanks,


Sven


> Regards,
>=20
>    Joerg

