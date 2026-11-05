Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910900;
	b=jIhlIWI0lM6CTOvh1W9iikRiCBOHuBckBb9UfvkCt75qKrBV37LmVFgLAuyJBj3q1Dr6
	 OG95eLERK6aNFGZw2DbE0/RwtYFVexrOi/TwzzNOllzpzHZhwYnRuKR6qmN1WXepuHkJ9
	 TczcMxO0rQ8PRQJ/j9SdEwgyONRxl/jcqFIArqo4OxLL7jr4ahAGKXRNjx1qTEaWHabij
	 GMh9/ty/bgtLtuDG9gqrrl2ow1sXfc9eLscb+C/G/Be9jkAg8ARkn35g4XlpA6qdB5WsY
	 oe8Yg1C+4zNo/v1GAYgTpG4SsED+GSlgR7IjOUxSyplWD89bMwqJQACOG7nUJppeCfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
	b=zy8muS2HCYu2dmxTBsuFE4oz/QWrltWSSosszLgYehU5/gE80ZAhZ4fr9i/oKuQYCibz
	 Enxi72BK7991TpNPBAVXYWSetCYqtagqPayEShdwLvkYhv9xdlS4m9SETjUdM080rDxK+
	 MUO7YffY9n47fTVYp4SyqM00wabNFZsPOMdTZJotpR4gqu0gxQtZwS1v1ZQ0q9PSAnQ+O
	 DZEQRtUtoyvSUjTwxSKNypuWFnw2vAPLPpy88t8sqwjOliIHBI8PoDhdNlhtTofKdiPvv
	 Ml7/IkkXwZAPRRG/UbhXKTgcRzyqVRDkfVGFIrZ8fXneTyCdiIZ4FCpiw10eWx/36kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y9tRp2Ql;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3093606A330
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3093606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y9tRp2Ql
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-353804b591eso4388098eec.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910899; x=1794515699; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
        b=y9tRp2QlnJZOxg2xzvaAXeJWaX8ASQis8B5nbD8rESEO+ZhLyTFHMTN2cYi7JJmtUQ
         veiAHnEzkrKVkuKTDD4IWrYSYG01DOMRuCHdbTpiZvQ1INQEVryxnFYsMsksvTFZEn66
         C27R7xgFNUCIXsc2yNk08MV25utLuGEsvR00X7TIL1njS2mpmk9m+1buq7w7k9u3naBw
         fbrU10LTynbvULOZ5SCGwDdPoGx/SKQLdbhtNxv1wsPORsVPO9Q2bANuBCfkt2sMKFUU
         3hdDSlAyn0Ga4yGqZUbUA2c9BXi91bqCIVFY4iwsAIMet2GXlt0dqRNVNsui6yxuvbYE
         8wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910899; x=1794515699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
        b=C9ZUj6h18o1n8T56MgpJUj1vfaMJU7t0Q4k+10u4RnXoJ+uXLgeFQTsWBboDH5JI7O
         oQogkTSK6bPc+32ORSKTu7xbzzSPCHtr800oJt/Oh0UCETstg5L09YD82UMU+0ADv3/M
         /LA/vjZCAQuXiyBSZrbsp3XrNDaSbcY9sg7FlWHe5Ga0YGCloBcsQGzKUqZgsuj5s/Yq
         rjh150MdDqHNuZ62RI7t/wK3JSzPPyLmFBu/gwCa2CTypAHbgEKpTXyKLvA5zl1CbqPs
         o4ZLQYcTJrGxnFHlQqBS9y4X/3thbrgKOhmgADNfsBJ5VNwyrPwOSjToOJTX3OJkQlzb
         Q/qA==
X-Forwarded-Encrypted: i=1; AKwUvBxHPQsTr+RIFC+ykUSSdJZZgUb8FTbrbSVrCPmNMZlXS+L8UittROtgWScuFhjESXj8lct7xw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+vCY2qCbDlNBCzBS8f2ycEDdO1CAoYuyKjGoCvxUARn6SzN9EJ
	Obi+VGMZjqak6UQT7HHc3aj5sP/PWTO5LGS74cdvqH97m+IyBMackwHK
X-Gm-Gg: AYBFou3QqQLCNUA6H4IJn/cdpqFGw2Q+cej5he5fng0SpABiiAmeDz2TkyoTLEPQY0s
	piHmo9a7Dhk6Kgu31StW/TFR+uKYvXnGLLt/LbU34AhKHMQyIfTe1O6Y8QWM4bKlDrIbis/+WKV
	Bf0BXRF/NCOH3tZ5Wt/K1Gf3O/TE3hbgk0eH6U5MPqxutu1VuziKs5cQvoqD7H3142tVi1FCBve
	V5XUhTd92+R9HzhFD2GtiP+JBsAigpZO4rXHpcvdY3zlP/RdcDJTkvYh0/cGm4VYlPdlcVMiEch
	Rld4TJ0wxCH3LZVL762GY2oj+vj+7saF6rZDXzSBb1Skotj4mpx2+53c9N8+Aedespyg/is7HTQ
	nQImfyL9OkE30+/gJx2ZlJV2Ywhfy/KWlH5CJ0EWZSTVl9ofSLkz2JfvaqB52J9vDUMRTc1HOTL
	JyEq8KuYZqepuOfwYr9Y9PaSUBWymtcz8Sb9M8BcTBIDmDfMVDGYKoIW51Ekns9m9c+NSPcDeB0
	N2mgQ4fHtjVhhCLNWHwbon39wbx6OdK2f1sFBfgJ0VfyxyqLJ4pqZ4C+MT1h5RANPQiEtOkv/ge
	al5gaC83KFVMlluoXUUK2ARd3Q8n5r7hpjLti2OnWonOrLB5IP92c7s9d7XvIgsLFKQfTpw=
X-Received: by 2002:a05:701b:2050:20b0:166:5552:780a with SMTP id a92af1059eb24-1b25d31e5a2mr163714c88.8.1793910898553;
        Thu, 05 Nov 2026 12:34:58 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed274sm649631eec.18.2026.11.05.12.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:34:57 -0800 (PST)
Date: Thu, 5 Nov 2026 12:34:53 -0800
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
Message-ID: <auzno3uoL5Pfojfl@google.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
 <auy2plYVi723Qt42@google.com>
 <20261105191940.GI8298@unreal>
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
In-Reply-To: <20261105191940.GI8298@unreal>

On Thu, Nov 05, 2026 at 09:19:40PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 09:05:29AM -0800, Dmitry Torokhov wrote:
> > On Thu, Nov 05, 2026 at 01:42:15PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Manual serio binding connects a driver before driver core can admit the
> > > device. A rejected binding therefore arrives after functional setup.
> > > 
> > > Keep the port ID check and use device_driver_attach() for the existing bus
> > > probe path. Driver core then serializes admission and handles probe failure
> > > before publishing the binding.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/input/serio/serio.c | 24 +++---------------------
> > >  1 file changed, 3 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> > > index 54dd26249b027..604440244c1ca 100644
> > > --- a/drivers/input/serio/serio.c
> > > +++ b/drivers/input/serio/serio.c
> > > @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
> > >  
> > >  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
> > >  {
> > > -	int error;
> > > -
> > > -	if (serio_match_port(drv->id_table, serio)) {
> > > -
> > > -		serio->dev.driver = &drv->driver;
> > > -		if (serio_connect_driver(serio, drv)) {
> > > -			serio->dev.driver = NULL;
> > > -			return -ENODEV;
> > > -		}
> > > +	if (!serio_match_port(drv->id_table, serio))
> > > +		return 0;
> > >  
> > > -		error = device_bind_driver(&serio->dev);
> > > -		if (error) {
> > > -			dev_warn(&serio->dev,
> > > -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> > > -				 serio->phys, serio->name,
> > > -				 drv->description, error);
> > > -			serio_disconnect_driver(serio);
> > > -			serio->dev.driver = NULL;
> > > -			return error;
> > > -		}
> > > -	}
> > > -	return 0;
> > > +	return device_driver_attach(&drv->driver, &serio->dev);
> > 
> > I am not sure how safe it is, serio (and gameport) have pretty elaborate
> > structure and locking rules because they can recurse into themselves (to
> > support case of Synaptics touch-pads with pass-through PS/2 ports).
> > 
> > But this call is for user-initiated probing anyways, I am not sure if it
> > even needs "trust" handling.
> 
> This patch does not change the locking; the lock was already held on paths such
> as the rescan path. This change makes that explicit.

Does this enforce synchronous probing?

Anyway, I would like to get rid of this special probing in serio core.
Given that the code path is only triggered by explicit user request I do
not believe we need to worry about supporting trust notion here, so
please drop it from the series.

Thanks.

-- 
Dmitry
