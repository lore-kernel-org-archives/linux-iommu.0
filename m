Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F038553F
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563302; cv=none; b=dykS6KUHBeKUnGvco3Khu25ilrbWdi54X4NXIZH6wXC5CDbFNtFLMDncsmgvJHmwQJu3wk8MByX8e8+xhS89soSJH3y3iGHeHzyl2tapM28d1T+4feVBC9S15Velwq4aXXN0MouKUzwzqvfyBf+WCTZMc9knhTOFUsfjp3criQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563302; c=relaxed/simple;
	bh=ikfWm5DL/5sYnkDYH488sa/zQcW6oHrRAu4seAl+qa4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQq4pm6TR/o/RFktMwKpzp63P4u3XT5YqmoZhxiQCq3nU54jA8DQ3LFhKeVK+co0dmIadrcvvSzmugxLSJZ33FfCdgmH6S4xycuqrtIvzqZO0UVzwpk+oOBc97+/nJOkbpkB2V33xFjDAJ6UrVdNf+6kixit5/m5pYUISJ5NEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmI9exjG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmI9exjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510641F00AC4
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784563301;
	bh=cy2ZkxCpNVSDLVTKtd8tQZtQMok6N80r7SDOQ9XS6Ps=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=CmI9exjGe/Q9lpN/jDKjGYcZAhE82h4JhNs/XWbdbT2QKOv9Vt/lJRkWSNzc2sTDK
	 bT7H2HlxBn7PRd35GrUlcJXAkBZ/htEGpxajzqT8x+LQ9JKk55GrVmyrUIS+VwrASy
	 ex7zrBxyL4kKER0PbZqRA66QIdxuVaYzzXmIP4+VcaHIcdtYLEOA+9DLMG2S+JTXPB
	 7Dja9EFj7xhGycntJmC877y3Ph7X6yhMSvvn0ClkvGzRg4VXz75VMJGEj8vEBkESvB
	 HWh8zfEm7bAVxCLzbZXYqaMpxHTM9TEEaYT8KSHa+fLKy+x1CPl/UGD5zTR0ZeiVqX
	 P9CvaeVK0zUyg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aec201b582so10280742e87.1
        for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:01:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZlGaQWbSO7HwuR7q6b7rJDREB2L/YhA5KQ0O3JawtsGX5rIvie7RpVAkqjJrxEoOZH023Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQCtXLT6u89MEdRfrvkT6iJ/f6wntq6ZoG9B/89hsNYOYIKhPS
	X7dIH1qmw0EXBV/J7XdHPon9EjWgSQpYI9fyeD9g/Op03F+tgbXb1tEfN2b/dcyTgQwkC4/UcsY
	DCgA1MU4P7LD0B09RpCYbptox25OteRXJJlhTUT+atg==
X-Received: by 2002:a05:6512:23a5:b0:5b0:1ab1:2640 with SMTP id
 2adb3069b0e04-5b28f9a56f2mr2858457e87.41.1784563299555; Mon, 20 Jul 2026
 09:01:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 18:01:37 +0200
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 18:01:37 +0200
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <86b2aba7-b049-47e6-bc94-6cb499b30ce4@lunn.ch>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>
 <86b2aba7-b049-47e6-bc94-6cb499b30ce4@lunn.ch>
Date: Mon, 20 Jul 2026 18:01:37 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mduv_KiB42d4AZddTrFSHmKogd2wh6vBDXomW6ssdfq9A@mail.gmail.com>
X-Gm-Features: AUfX_mzoRVqC1tUK_OfVS-B_bFewvPArrOEoPGLWKm-p7iGJrfuSSI_-EnPQPN4
Message-ID: <CAMRc=Mduv_KiB42d4AZddTrFSHmKogd2wh6vBDXomW6ssdfq9A@mail.gmail.com>
Subject: Re: [PATCH 7/8] net: mv643xx: use platform_device_set_fwnode()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 16:43:40 +0200, Andrew Lunn <andrew@lunn.ch> said:
> On Mon, Jul 20, 2026 at 11:24:54AM +0200, Bartosz Golaszewski wrote:
>> Prefer the higher-level platform_device_set_fwnode() over the
>> OF-specific platform_device_set_of_node() for dynamically allocated
>> platform devices.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> ---
>>  drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
>> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
>> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> @@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>>  		goto put_err;
>>  	}
>>  	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> -	platform_device_set_of_node(ppdev, pnp);
>> +	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));
>
> This is definitely an OF only driver. There are no other calls to
> fwnode functions in this driver, so this is the wrong thing to do.
>
> Sorry, NACK.
>

I'm not going to die on this hill but drivers are OF-only until they're not.
For example, Qualcomm is now working on a hybrid ACPI-OF approach for
laptops[1] and we may end up needing to start converting drivers to fwnode
after all.

There's no real benefit to sticking to OF-specific APIs unless you need to
iterate over all properties of a node or use some other functionality not
available in fwnode. The overhead is minimal and it's never a hot path.

Thanks,
Bartosz

[1] https://lore.kernel.org/all/20260623145225.143218-1-johannes.goede@oss.qualcomm.com/
