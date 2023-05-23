Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0E4A840
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 11:53:31 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 75D1B13EC96;
	Tue, 23 May 2023 13:53:22 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1684842803; bh=d6sBFXltoE20c/IX/UAU/Ri7MVflMAa8Fx6QDXIIeYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lSCFcHv/NCVANzoIXMtxnRDs3UobLxMl601xF8gYdPBua0rJrhRORYcDdp6FW2pxj
	 imlF/OMK1ueWXtYEvpcLJIBweA/xlyR9wx5rLxpKtYeripsM1Zp1Nx00okUBdb0zh7
	 fCjvtMpVjyGNeUWSyFJ8PzFdq9NuZ7AlyzO1hP+hw7i9q/aHuNYytc/lY5cebUTeoz
	 sQnvmTNSij9i0Lj9a//NncTW+YX00UVF6kmHAaKm4AsqxByN6K5hgY1o1nRuBXo/H0
	 dB6URP45McgxVE8PMjZHbDZK9u/slbhsJe8wAhpg0hdboZmUAkQaPPnaEXIC8gk2I7
	 NUlSP9iRKWbXA==
Date: Tue, 23 May 2023 13:53:17 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, "Michael Kelley (LINUX)"
 <mikelley@microsoft.com>, Petr Tesarik <petrtesarik@huaweicloud.com>,
 Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Borislav Petkov <bp@suse.de>, Randy Dunlap
 <rdunlap@infradead.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Kim Phillips <kim.phillips@amd.com>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees
 Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, Roberto Sassu <roberto.sassu@huawei.com>, Kefeng
 Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 RESEND 4/7] swiotlb: Dynamically allocated bounce
 buffers
Message-ID: <20230523135317.6b9e086f@meshulam.tesarici.cz>
In-Reply-To: <ZGyNQxY6By1QdXur@arm.com>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com>
	<346abecdb13b565820c414ecf3267275577dbbf3.1683623618.git.petr.tesarik.ext@huawei.com>
	<BYAPR21MB168874BC467BFCEC133A9DCDD7789@BYAPR21MB1688.namprd21.prod.outlook.com>
	<20230516061309.GA7219@lst.de>
	<20230516083942.0303b5fb@meshulam.tesarici.cz>
	<ZGPEgsplBSsI9li3@arm.com>
	<20230517083510.0cd7fa1a@meshulam.tesarici.cz>
	<20230517132748.2e250f9c@meshulam.tesarici.cz>
	<ZGyNQxY6By1QdXur@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 May 2023 10:54:11 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Wed, May 17, 2023 at 01:27:48PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 17 May 2023 08:35:10 +0200
> > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote: =20
> > > Anyway, my greatest objection to allocating additional swiotlb chunks=
 is
> > > that _all_ of them must be searched to determine that the physical
> > > address does _not_ belong to a swiotlb, incurring performance penalty=
 =20
> >=20
> > I thought about this part again, and I overlooked one option. We can
> > track only the _active_ swiotlbs for each device. If a device never
> > needs a swiotlb, there is no active swiotlb, and is_swiotlb_buffer()
> > short-circuits to false. This should avoid all collateral damage to
> > innocent devices. =20
>=20
> Does this work with dma-buf or does dma-buf not allow swiotlb bouncing?

Currently, it does work with dma-buf. OTOH Christoph is apparently not
very happy about it and would rather implement alternative mechanisms to
let dma-buf allocate buffers so that they do not require swiotlb. See
his reply here:

  https://lkml.org/lkml/2023/4/7/38

OTOH if you're asking because of swiotlb use by encrypted VM guests,
the answer might be different.

Cheers
Petr T
