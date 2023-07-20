Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59E17FFF
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 12:27:17 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 5F1E0167B3D;
	Thu, 20 Jul 2023 14:27:13 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1689856033; bh=Sy15tdSUh75Kyy0EKSX/r/RpOL8nRcOu9kVoTovs9Uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FP+LjtMSc0sf3lDo+Te+5LTKxW+4HtUmYkgN/XmiJ+LTxwyoVKCOVISvr6qA1n54o
	 AZi5SA1NID+w81Ij7hZxzKW56ukZ7Vdn0ZMcpIv6kGywuXKOOCwd6f3hzOTQ6ZFmPz
	 Qf9ggxu+sA3uwa4mrapH6fESYG8zPK7NmVb/QMIMD0MFfty0POHqpn+8VyyOMyOZbC
	 9Gjm4ZQRBYpMZOz1YOkmBH/SJBIF1j5aOG8og2+upta5x7iq7eBFx2KL0xUMO9qqwb
	 1k48i2ObRWTs3PeK/P1mWnUNg3qCIIBrsvPGmDGy/T7jzMwqiqrIlXMfYvgYOKFRYZ
	 NOfXCITBF19sg==
Date: Thu, 20 Jul 2023 14:27:12 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Yajun Deng <yajun.deng@linux.dev>, corbet@lwn.net,
 m.szyprowski@samsung.com, robin.murphy@arm.com, akpm@linux-foundation.org,
 paulmck@kernel.org, catalin.marinas@arm.com, rdunlap@infradead.org,
 peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
Message-ID: <20230720142712.295834d0@meshulam.tesarici.cz>
In-Reply-To: <20230720115408.GA13114@lst.de>
References: <20230720082517.GA7057@lst.de>
	<20230712074758.1133272-1-yajun.deng@linux.dev>
	<25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
	<20230720115408.GA13114@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

V Thu, 20 Jul 2023 13:54:08 +0200
Christoph Hellwig <hch@lst.de> naps=C3=A1no:

> On Thu, Jul 20, 2023 at 08:47:37AM +0000, Yajun Deng wrote:
> > It's based on linux-next tree.
> >=20
> > This patch should be after my other patch in linux-next tree.
> > a960925a6b23("dma-contiguous: support per-numa CMA for all architecture=
s"). =20
>=20
> Where did this land?

Well... in the linux-next tree:

https://www.kernel.org/doc/man-pages/linux-next.html

>  dma patches really should be going through the DMA tree..

Indeed. The other patch was also sent to the iommu ML back in May. It's
the thread where we were looking for Barry Song's current email address.

Petr T
