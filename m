Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923800;
	b=IBPigrNRB36YEF19TorMbtCCnCbaZL7iptTlaBrVWCKHBCDlqUTVTRJRLO5jk4EranM4
	 yGCW4YaaaRV47ctSA0LbIoqp8EFBOFtFgdBtunw8r7j15PYiSXMSi96oo/xHM5lxSqLeb
	 7DXuyjdng6n04KQ5/tZMdqT/YwAkuKE4hyu/5Oyp4VecTZtBXBGb46xgFzelcfXsE2k61
	 cHCOB7OQntX83wHvU1xglccPkE7FS5Gv57m7Mrii1KHHtCgMgO6lw7IUDF8t2ey0tOkYm
	 FJHgB2mzuojyyGdybKCqqPZLhH7YtxzIEXTl9Amez7Wo1taYkmzQbGw5mlv2BCh2gcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923800;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=955rSHytw353+kX4GJ/2ppKhYBxbDLqQad9xzhWOC6M=;
	b=o7WppcOmPgah/oKdHfNwkxZ/hJ+JErkMnzeR+OQAh5c1YSs5VMMr/o14poXAOZmFiQcC
	 LGj3sJVQafR049L4lty39qJs1R3sI11wNDaBWXS+fFJeuuCioaR/8kMV9/TFUOmX3Hb+I
	 ENaosIRMiqF/8FojdRIjOeQwTNyVqYD2ChiYVVSJeIGfLSsBOybehttWhRwI3JC85Su9E
	 BRBm0Xi90R3vPi8NRsfiz5lx5yzRiwGD8HRMY7sr1llkJpgLmCJlpkqEh1gy/li9qqtOZ
	 o/W5XfqvYhK6xYqhGPV5b/ycfDvAEkDM60BX5NxQUf7OIe/DOPAEVfitHNeNjffeFng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftnvz5rg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC191606A31C;
	Tue, 17 Nov 2026 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftnvz5rg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8331F000C5;
	Tue, 17 Nov 2026 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923799;
	bh=955rSHytw353+kX4GJ/2ppKhYBxbDLqQad9xzhWOC6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ftnvz5rgOCRpDUKPKNjy27R4QUmsnvYn1MxObcCQupIrYPOpPeedZT08WtgQMlDIz
	 Sgv6/DIlj/Bmf7mhLCB6+YabTLcGaJAoDsVdRiRmuWkZq9dnhrkqYG6hObsylMPNAf
	 2E8EEZGWoKFvcFWM5sZGwgfX+xT//mQ/oI/OGP8C6J1Xr3NqJmE5kTweHrVw9Ivtcs
	 CwzGzGWDs4Hf6/vfZdE+NFx45mhfzr1fmda9KVrW5DrRq/mp32dEZuYS9ssEYq3RBv
	 eUwUlK/dJ4SRwcougc0X1tci+mPxG3KlD+sKN53d+5OnOsU71ztp/R0uVaXxMfnc0s
	 QWqhiBhZbRHHQ==
Date: Tue, 17 Nov 2026 15:56:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Juan Yescas <jyescas@google.com>, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] iommu: Add iommu.passthrough_devs early command line
 parameter
Message-ID: <20261117135634.GA162713@unreal>
References: <20261116-b4-iommu-passthrough-devs-v1-1-dc5b493f7551@linaro.org>
 <20261116174238.GC2299285@ziepe.ca>
 <CADrjBPpyhKcvdH=jxiGSN46SZoFahaBdH4fAQ5KEzRvH_C3AJA@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrjBPpyhKcvdH=jxiGSN46SZoFahaBdH4fAQ5KEzRvH_C3AJA@mail.gmail.com>

On Tue, Nov 17, 2026 at 12:19:45PM +0000, Peter Griffin wrote:
> Hi Jason,
> 
> Thanks for the review feedback.
> 
> On Mon, 16 Nov 2026 at 17:42, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Nov 16, 2026 at 05:37:45PM +0000, Peter Griffin wrote:
> >
> > > Instead, I propose handling this in the generic IOMMU core via a
> > > kernel command-line parameter. This makes it available uniformly
> > > across both Device Tree and ACPI systems and across all IOMMU drivers.
> >
> > Something like this could be useful, but also Leon's series will allow
> > userspace to do it from the initrd too. IDK if that is more/less
> > interesting to Android.
> 
> Could you point me to the series you are referring to? I want to be
> sure I'm looking at the right patches :)

https://lore.kernel.org/all/20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com/

Thanks
