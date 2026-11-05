Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898336;
	b=1diiitv3N5Mib54fkDH/StRJz8Gqod83AUgssrdi6pp31jtYX7OSQv6HOw42rEjKuHs3
	 E8EBgqCRvX3q3Z5EneKKn1EJ+M9BtEpclG0dRuUh80+B68AtSsJ+R3GsngfEp2wpG59L7
	 6YdetKPqT1TWR2yN+/r3J5AAcEAMhxGwFvxsIrEDrK5N3VKX937x8Sg6CdtMv9T5FjL8j
	 UYH11URqaLCIn0HPyy+7ACXcYDpWsbX51AEMMRXfbyfqP9dn/G9Nc+GOXBuQnu6haVnYp
	 eRgo/VIxxmtqGCcQOOkwNygbTLG04tgBtRxOmYKpAhz2+fgZ8YsEJTLz27r438kI1Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
	b=GMytKZz1X5Vboo86iGv5lCTxGIpp2j/quxSMCsAq0an5yBOjVZ+9ivGcHRnqi9HwVj55
	 jJLaNo1dOFqn2nFPGBpwhfgUeNtbJQoOlzi9RZ5fzgMreGFtAguuMlx6ZM9oamwUnAHC4
	 vgzJw+aTqTsisCOF4b9h9kHt9M6Tll2w7/0bGKc7EP0HuTyFYlKmVwKv/TyqnsO1TRbyp
	 WzIDpPLf1s3DGRBlV3rH/5+o5DVJB1N+ErTqhlBlzvR7K+EUfHrR6Kq3ZuzU1XREfpOXG
	 5UMvVZET+FQAjhmsUdLOIfG1Ed2sjDDRgAna3JpZXN2Q/++lOxKVKu9l4/Z0OmwZnPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CJUpeyCz;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA9B606D80B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 17:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAA9B606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CJUpeyCz
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3516062eec.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898335; x=1794503135; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=CJUpeyCz2dTrHhddC0k0KVO8hTfwamAxOdKVTbFnwXWj4X1WoWDgPljgF7ftT/aKC8
         QEL3yn5hwAIjT5F2ucjosiQJWImJyGIxWb9A6lHN5X2D1yPJ5GZ/0LDfuN8uX0u+uaY5
         YANe0tqHT+N9AWBxCVfvCIoodyGYIGelv3iA6shct5MwXIicMFMG0OqXfkZNFz+zIgQa
         2qm+uHWlyUuG5skMmmjKwe2v43vTj/lFympZDK8ryu6ev9a72S4JVH144TAnKLKTedfr
         Gqmnrnpyw3H+opg5r3KglKA0hhoG9H+zrHDfytsuKzoHocWa+hKiiy3ZIHCNKaue4u32
         sImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898335; x=1794503135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=mlfFw5w+4kCp4nfsCtleAkAttXg1/Xv7zW1RaWl6UB//97HGKZParagY/iQebkFSQY
         TpNx+c+ZyK1CM2Hrrl5ED3lO7Ry63n8IqhMhXV7it97gKSyW7KoIK5TqcTpAc3unmdAQ
         CM9DJKm7HSVzQ7DQJ/zCR/AafTc5FuMrWzvVzhreFLRA51FCNFhLnHzXnhxFuhmFw8Xz
         Wn2Zpl0yHWSZz9TwJy57daw/db4SrsGn5wp3EFsrMsIQSb3l0q4LOi2ZPo+hdt31LkU7
         RrptpMB96Ncfq/VlgtNbepKUATQHbK4X69cveysvG4cf8Raf+xozg75SVckiW86iz9Mu
         OvLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwihKmN8R5t88OibbAJSlOTp55lipm+4C1E1gLCilSHT69uSOir1KaKc9znmQRZ3cPn0sgRkQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9XqXdytYYufxG/8ErYk4QXHziOKvAqHt8URNdPVER7hlsdjqiI
	LUvQ9TdQPj8xsLpxHE6FyCwc4csILbpK6gSpu6Kk6ItxfTxTXdAHLgTY
X-Gm-Gg: AYBFou2BLb43t4tgtRnxCmZck8hC7wdIUuu2/xsFA8swrEgTiJROLgVLYMhx0ucZ8bR
	wAv3y2krLMKp3heP6qeTAsxU2yyImE2B8EqO9TGXkNMPMmd3ejTxFh9Z8EhCNC1G+mrqXukuLfP
	4iK4Ri7IR4WV8aRRxhKx2LHqMLSs3ptwxaRz0kZwdJTm+Dyle/LF+Ii+hOJ9SI6HiTXMJtBZbce
	sVAAbmqZr2Whwj/EmGCLJSiV1X0uoWV+IRRllOA7+EgIx9lDKdKBtz1Chbanf7vBsoOnvpgWrvg
	eNApEf7sGl/3E6n+KTEYEDpoC1LqmwdagnBcjIumS1HueXxAVqYBmYC7OGQCfksfc+KIvj5Le/k
	kGI6282p0SLiz3giWcyThxWWAWkZ3bvu1ahU+wz4eJK5RuNba2DMJ0PBrLvmyldbtacHJiRIZWd
	gyPZKW6O3qphcgQBianYccsFll9vMYkbdKa2XSx0Xi1g9IiRw00sOD0BItlB0t+/XFWcw8vA1Ie
	yIoH5EIGYxhqzGEZrkwlFNtK+hlQMhPvHAsB1LLpd7g1/Q9VGDSKemcv1UxQMgn/FtlcSvt//bP
	fwUj/gp429oA8VHB7DxdyfpHg83vVObK0Qs8PhZJhFs69Xhn6PkuNvdfc4a8NuftRVyW5I96nIM
	u7dWW7F8o/zDlXuw=
X-Received: by 2002:a05:7300:fa0d:b0:36d:7feb:8bd3 with SMTP id 5a478bee46e88-36d7feb8e1amr5835338eec.11.1793898334471;
        Thu, 05 Nov 2026 09:05:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm23943795eec.25.2026.11.05.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:05:33 -0800 (PST)
Date: Thu, 5 Nov 2026 09:05:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, linux-input@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 02/17] Input: serio - attach manual drivers through the
 driver core
Message-ID: <auy2plYVi723Qt42@google.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
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
In-Reply-To: <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:15PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Manual serio binding connects a driver before driver core can admit the
> device. A rejected binding therefore arrives after functional setup.
> 
> Keep the port ID check and use device_driver_attach() for the existing bus
> probe path. Driver core then serializes admission and handles probe failure
> before publishing the binding.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/input/serio/serio.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 54dd26249b027..604440244c1ca 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
>  
>  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
>  {
> -	int error;
> -
> -	if (serio_match_port(drv->id_table, serio)) {
> -
> -		serio->dev.driver = &drv->driver;
> -		if (serio_connect_driver(serio, drv)) {
> -			serio->dev.driver = NULL;
> -			return -ENODEV;
> -		}
> +	if (!serio_match_port(drv->id_table, serio))
> +		return 0;
>  
> -		error = device_bind_driver(&serio->dev);
> -		if (error) {
> -			dev_warn(&serio->dev,
> -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> -				 serio->phys, serio->name,
> -				 drv->description, error);
> -			serio_disconnect_driver(serio);
> -			serio->dev.driver = NULL;
> -			return error;
> -		}
> -	}
> -	return 0;
> +	return device_driver_attach(&drv->driver, &serio->dev);

I am not sure how safe it is, serio (and gameport) have pretty elaborate
structure and locking rules because they can recurse into themselves (to
support case of Synaptics touch-pads with pass-through PS/2 ports).

But this call is for user-initiated probing anyways, I am not sure if it
even needs "trust" handling.

... And I even thinking if we really need to keep these custom
attributes or if I can rip them out in the future ...

Thanks.

-- 
Dmitry
