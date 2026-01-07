Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D134B1A3
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798257; cv=none; b=tJN2WsZUR9f+yu9z4mer5usGoBFEO+kyxBNfjO9VEmIb25G7eX+3Z+zC7EDSdL6PNkme3RrMmIujdpNssdHpsgY5W5C0xVhAG3vAzezMIRrikOVVn/Ive3YWc1XaQU1WTW3eMDtPosr4kIbV1V+I9C6rJvO0i6qcrEmbt4W8GV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798257; c=relaxed/simple;
	bh=ZRBuLTKipxd1fNYBhk3aKWOCw8U3jNhhvJPS91X3rKw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ofoctQl28F31S1csWTpFtnVtbfGfI4c1gTWzT3yx4mWyeyAY0yl74tqMTmsTWVgPUzXvw5GGotHDPrOtYZvUgmNv3m0fns0FjMWy59YBQDNC9TUX7rLxeLH8GynmcFaU0fiEsHYeW2aj1lrq1SGGMjjTg2mrKkVUCfBMvdzZ6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfSmKHfC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfSmKHfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE962C4CEF1;
	Wed,  7 Jan 2026 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767798256;
	bh=ZRBuLTKipxd1fNYBhk3aKWOCw8U3jNhhvJPS91X3rKw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PfSmKHfCt0fEzuMSQ05U7csj3POxDznY2PzVpaBMw0RbSr/TXzQWCm8YkJX/TO8VG
	 /YIgHIWfA6m3VI422V77PPTns5qeRcv+wptXBBlrhqQUi4uunEOJBUZID0qhrf7RsK
	 yddYdCIe6dusK66GlRxsAk6Ez8wMc6JC5qMhJh8TZbuoA/eaftOKUPkRtE+CxxPhZ+
	 p4SpBmrb52fKFnwHCExNxlHoZaxBjfgp4zQk7tQWWxxoD6GKnV0Zj2WrfwR+U4JfRb
	 bbQ6AN9nPuBQFMnYcebp7nr/tUA3RO/Y3LO6ciZeN3bC6VCMzigZoFc6Dt7UBBbW8j
	 xcjiCTRQmgxYg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF376F40068;
	Wed,  7 Jan 2026 10:04:14 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 07 Jan 2026 10:04:14 -0500
X-ME-Sender: <xms:7nVeafpg6FoUjndLJoZHKEIRDIg1b_l2ZRrapVmI_7kt8vd46R6J-Q>
    <xme:7nVeaUe6GIotnqKPdtZW7SouU6CNbMLEZiIb07Z2yoAySp82KhcPfyUQz3VwAHaKX
    qosCMvd5C3Qur7Qn1hP9gxuKW9M3rISG9gJdz5uUQS0WVaUK-X4fTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeffeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepudefjeetteelhfegudekhfetffehtefhtdevkeehfefgtdehheeghfektdek
    vdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehr
    ohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopehsuhiiuhhkihdrph
    houhhlohhsvgesrghrmhdrtghomhdprhgtphhtthhopeguihhgvghtgiesghhmrghilhdr
    tghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpth
    htoheprghnvggvshhhrdhkuhhmrghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhhsfieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhomhhmuheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehtrhgvughinhhgsehnvhhiughirgdrtgho
    mhdprhgtphhtthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:7nVeaRNNQWaofk35rjI1dW25yZlnWumWk8JjGAxP9-EV2vmtG42n2w>
    <xmx:7nVeaf21dbMBoCWajCtUbz3diA2By4bMZsNftOvxU943KwpPThbmtA>
    <xmx:7nVeadTlpiXPio0noqQHSFpT9LbVfWPMvLG_fx3QtELjL38l3-_wJg>
    <xmx:7nVeaSm-LW9trnY7tEX2JzgOsIXtfSap7MMsbCoCQwJ0FfCusJhpLQ>
    <xmx:7nVeaeMGcBO_YLcogjP30ONEPS8lTgjVy8lAmlHpCribeX2iQSVvp3M->
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CD828700065; Wed,  7 Jan 2026 10:04:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AdM-YOrL1Uys
Date: Wed, 07 Jan 2026 16:03:54 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Linus Walleij" <linusw@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Dmitry Osipenko" <digetx@gmail.com>, "Thierry Reding" <treding@nvidia.com>
Message-Id: <0dccea36-0d79-42cc-a12f-5a890061ff59@app.fastmail.com>
In-Reply-To: 
 <CAD++jLnfWuoYavrOKoxd6=UvPhuWJmKzHWe76-FM2S+raUnEuw@mail.gmail.com>
References: <20260102155037.2551524-1-aneesh.kumar@kernel.org>
 <20260105175323.GF125261@ziepe.ca>
 <CAD++jLnfWuoYavrOKoxd6=UvPhuWJmKzHWe76-FM2S+raUnEuw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-direct: set decrypted flag for remapped DMA allocations
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026, at 15:26, Linus Walleij wrote:
> On Mon, Jan 5, 2026 at 6:53=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
>>
>> On Fri, Jan 02, 2026 at 09:20:37PM +0530, Aneesh Kumar K.V (Arm) wrot=
e:
>> > Devices that are DMA non-coherent and require a remap were skipping
>> > dma_set_decrypted(), leaving DMA buffers encrypted even when the de=
vice
>> > requires unencrypted access. Move the call after the if (remap) bra=
nch
>> > so that both the direct and remapped allocation paths correctly mar=
k the
>> > allocation as decrypted (or fail cleanly) before use.
>>
>> This is probably fine, but IMHO, we should be excluding the
>> combination of highmem and CC at the kconfig level :\
>
> The only way you can get CMA in highmem is by passing in a highmem
> location to the allocator from the command line.

What about those that declare a "shared-dma-pool" node in DT?

I don't quite understand how the alloc-ranges are picked here, but
from what I can tell, most of them are intentionally limiting
themselves to the smallest lowmem area (CONFIG_VMSPLIT_3G), while
at least three others seem to intentionally pick a highmem area,
specifically these tegra114 and tegra20 (but not tegra30) devices:

arch/arm/boot/dts/nvidia/tegra114-asus-tf701t.dts-                      =
alloc-ranges =3D <0x80000000 0x30000000>;
arch/arm/boot/dts/nvidia/tegra20-acer-a500-picasso.dts-                 =
alloc-ranges =3D <0x30000000 0x10000000>;
arch/arm/boot/dts/nvidia/tegra20-asus-transformer-common.dtsi-          =
        alloc-ranges =3D <0x30000000 0x10000000>;

[cc Dmitry and Thierry in case they remember why this was done]

With my proposed change to increase the default lowmem size,
all of these would be in the lowmem area after all, so it does
not actually matter, but there are probably other out-of-tree
dtbs doing the same thing.

> I have a strong urge to just patch CMA to not allow that and see what
> happens. Or at least have it print a big fat warning that this will go
> away soon.
>
> I think this is only used on legacy ARM32 products that are no longer
> maintained, but I might be wrong.

It's hard to know, I can definitely think of reasons to do this
intentionally on machines that are still supported, using either
a custom dtb or a custom command line. We can of course decide to not
support this configuration any more, and move the CMA area down
in those cases.

      Arnd
