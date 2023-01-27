Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86D23A8
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 07:23:53 +0000 (UTC)
Received: from [127.0.0.1] ([73.223.250.219])
	(authenticated bits=0)
	by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30R6qhuh3764081
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 26 Jan 2023 22:52:44 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30R6qhuh3764081
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023010601; t=1674802366;
	bh=b3YKjhFfbcn5/+mWnBhEeUVeuE8HPWoX5snX+0lZVVA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XB4jlMmsK9Zy+2cyyf6zHN5KWWZ58SEa3ySitW5VxHSJxxq/VlF/vPtI/8zcLKuME
	 NEWeCFPfWTKL8whIeftkgjfOet9uz7FrLYt+TFiwiJBH4QeBufdVjBBaV4oSVXZB8E
	 9GAmNONMnkxWY5sT8u7JuD+h7D3HXQTj4tZGdI71ZODR6dJUTLnJ4ajsBh1P4RYP1y
	 AO6vjgQPtwPNXjVQ0juDp28gjk/XqTNG78DpvgopfYSfo0v7k3noYICRey++3k+scp
	 +v/rVGCMQA6S41VwOmMnt9SGf6wRdOGsZm/rtWs1MJVEQwvWyCIXwCkcvWuxX0IhDs
	 6qjnhQOgNmUzw==
Date: Thu, 26 Jan 2023 22:52:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@intel.com>
CC: Georgi Djakov <quic_c_gdjako@quicinc.com>, catalin.marinas@arm.com,
        will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [RFC] mm: Allow ZONE_DMA32 to be disabled via kernel command line
User-Agent: K-9 Mail for Android
In-Reply-To: <20230127063555.GA3300@lst.de>
References: <20230126164352.17562-1-quic_c_gdjako@quicinc.com> <dca84e05-e376-c593-74fa-37c58f30767a@intel.com> <20230127063555.GA3300@lst.de>
Message-ID: <C7DCCCB1-AABE-4D3B-80B1-AB755A68D460@zytor.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 26, 2023 10:35:55 PM PST, Christoph Hellwig <hch@lst=2Ede> wrote=
:
>On Thu, Jan 26, 2023 at 10:51:17AM -0800, Dave Hansen wrote:
>>=20
>> Also, what are the practical implications here?  There are obviously an
>> ever decreasing number of 32-bit DMA devices out there=2E  Somebody tha=
t
>> has one and uses this option might be sad because now they're stuck
>> using ZONE_DMA which is quite tiny=2E
>>=20
>> What other ZONE_DMA32 users are left?  Will anyone else care?  There is
>> some DMA32 slab and vmalloc() functionality remaining=2E  Is it impacte=
d?
>
>DMA32 never supported lab=2E  But < 64-bit DMA device are unfortunately
>still not uncommon, and configuring out ZONE_DMA32 breaks them pretty
>badly as we guarantee that a DMA mask of 32-bit always works=2E
>
>So I'm not only very much against this patch, but also the currently
>existing way to configure out ZONE_DMA32 on arm64, which needs to
>go away=2E
>
>If people want ZONE_DMA32 to go away we need something to replace
>it first, like a large enough CMA region in the 32-bit addressable
>range=2E

Not to mention all kinds of odd masks like 30, 31, 39, 40, 46, =2E=2E=2E b=
its=2E
