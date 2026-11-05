Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887440;
	b=Ohi5icRhtl82bWFxMVOGlrbzhoTv0x5+LOs1itE1mCRP2OA8A3s1NAnXjBVefNipLKsj
	 vdOaVbwofighjD0hSI7Mz2mpKN8omX3mLRPParFqc7uo8LwnoIfE0gUVP3N9LsDDCU2Yq
	 4uf56L2FXjWRnLmUM/o4QL12Didl5RDoBWRpkJxTbSa38k34sC69iIR+WdvQNXNHkS0ui
	 ozxZE9nB/iYolbaW4HdJME4ZSLtPFXLIdYHzoYPc1w64rIHH3Uhizht9uz1UM0zZkwMDj
	 ezs+qob3lFpcI+iK2QTZvapomtbNjoTKeeuYpFfUOSsTida6hujdi6zBfOPaWSbdMbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
	b=dEb/jf03Ty5+eXT701kCFhX/kKbup1+Sbs4XKXtNRlV5f2KJSlCfGeQSG4s+M1psk1uU
	 sDfy7RpljsFvz17uoKCNRh3IHKHL4YIM1A/5roLSJapIBMv+t2wvLDgtUxExa2J6OAJKC
	 /fMve//y43K6ra8KdXOw0o+qlqZB8sTfJ+KFwwZ+rtpJAZneQQGUGV7PzU0FrlvLDPW0l
	 Lc0g+7X2v9BOKtop7ojMwy+T1MXovIexd6lpNNEBIfVnsE6fyPWtgHAD/vSkIPDv+87U4
	 sdAyqfrejYZ7epKjV8unpl6G0pdpEMGwfabRDPPP7wU0SYeuKXj5NDM1omajz4A2ZeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE66606D801
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 14:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DE66606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so689461e0c.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887434; x=1794492234; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=DsXYl0ez/ZuuC/c7V6/g0Fz33P+t7s6OAAdfJUljWhRCbmL2t0lTZSyT5gGByiEfmb
         8YlBsy4ideERvikNKgfR5ZbgoXvYXSbe9S3J35EXRYQJG6Vv2sRKT96it9FDDtEXaQsE
         0mIIeyEzjXF5z69A1cfJ1tqCmobPYxYweuyvMKsHCvTiAZgHvii+uugqTktv+umGvZXJ
         K5M0JC5KQjKvkx6i2BuVNmjZy/DcWX/ASL464nG/WY7MdwSx6oLYvuImhUmNg747ntwH
         03dW78hScbCmItqEngOgOAVGYWCb6VWNljf9T0vN/wdLbDu/pjBuIPZhHT5dZK7JiN9l
         4f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887434; x=1794492234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=pEKx6woq+3XgDD6IhRs1Gv6h/oAUcZs/HqU/Hu1np4vzcJe7FWIycB8uOdTydQxbIX
         RTAvML23GUleyphWf+lAN6jNYnNSiCVRylN2wTbUSeC9XCPRPSWx9lxQh6nbrk5ZHUYm
         TbNGS+TY0xQx0oNK3Gak2ZyOMbu6gJu9MngCbeULy2bmdKiU4XSJvLnm0BJjwOmaBF+g
         rr7+SJ7KfeJFLW9Fofuzngoob06gD3h7J0y6uPYdNA7Mc0LtpwNHLwNez4WjofytU/g8
         zZouDxZdpru8Pj9lGORmCiQmqhKuNIPBLlWH5h+rP985QOYGjiTYb0Orz0bJg7puIMG7
         U8bQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgTMpz0FkLpELfJ7W6GTs+LXv+5EaDr3ucEdSlAU/QIfcX+qZr7q4eZCDEYZM9krJ1wqzuDw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+KgS9eAmbGRJcldPHZLsk6pMBE24hrOPjUmC1+W1s8NJSc9iKZ
	JjXouPoPc2e1bj4SqlJGv8pgXUkssmAFNq4yTuhNV+SX0VGmIz+nKbkCswx/Ft7SUtw=
X-Gm-Gg: AYBFou21sGLNogHB3J4GEEoLlW8BOFa8DPrxIjg2zGPOAEoK2feqcXG297RqSYigmCs
	YSGtu0DJbE6AkG011BmjUBe06+soSlzTwxG2tCVBrC4xZoN4CvIEbptQMleQKfjWodLSR8BzLJH
	O0gDzxNaF2C0TBO+zloQSAcOmtO6LM39gkXdcFpqQUqxLfOUnr0zdc/ntBtt53Dej5nAKqvKogr
	k4WoCUfxDe9pmWZyaExB5GJR749QSLwTiM/McP8ZFrhd4UG1CZ8Q7C8P7foZemimkbRUYcV4vAy
	ta7kDmUmP1YqLuYdKoRZ+Vgq5l8ZdYHLSLqXlOKaV3a2OA3gqb2+FkPc1cUS2IASjazy9cNaYb9
	bFxf1rZONaYhquk+gGa2Is5uXyQvwAiAxFt0KiqtpH2k2REq5LCSMizlvuReXUhA0SXsYfX7JKR
	bo2AB4OUtG1XtAdom6lry65u/ve1A2pf4kwYaJ/mryhblcCCV7ZdiorRAAKuO6kv0rBb1g7fvYj
	MpaQftLf6o33bk5f6Vv6p+IKSeAOxc9BeBsL0xTIYntDwAdPZYFCbHEdDhCC3nOWimpN1LFAQuq
	mabckhgZV4Q2SLXBORz9ZtkRtt2qeibZGTuC+rDzBIU/IXMKYvUvQyArjoJChK49rmNp9i593ug
	MtegDpqHzrg==
X-Received: by 2002:a05:6122:8f88:b0:5ea:cfd9:8fbd with SMTP id 71dfb90a1353d-5ec689b0f30mr9760208e0c.17.1793887433885;
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8de4908sm4235128e0c.15.2026.11.05.06.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy4G-00000002ecj-0pCb;
	Thu, 05 Nov 2026 10:03:52 -0400
Date: Thu, 5 Nov 2026 10:03:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261105140352.GF3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
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
In-Reply-To: <20261105131856.GA8298@unreal>

On Thu, Nov 05, 2026 at 03:18:56PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 08:12:51AM -0500, Greg Kroah-Hartman wrote:
> > On Thu, Nov 05, 2026 at 01:42:30PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Convert the PCI specific untrusted to use the common device trust
> > > level. Adversarial means the same thing untrusted does.
> > 
> > What about for USB?  Will that "move" to use this common trust level?
> > If not, I don't think it's very "common" :)
> 
> It supposed to work for all buses out-of-the box, at least this is the
> intention.

You mean DISABLED/FULL should work with this patch series on USB
right? Meaning the core code will not bind a USB driver when DISABLED?

I was wondering if some of the broader things we are doing on PCIe
also apply to USB, like device authentication. I don't know alot about
USB, but I got AI to help me find some relavent spec information.

 https://usb.org/authentication

This looks like the parallel to PCIe SPDM device authentication. I
would expect it to work broadly the same way as PCIe if anyone wanted
to implement it:

1) USB discovery discovers authentication support and creates an
   attestation subsystem device for it
2) The struct device starts up with trust = DISABLED
3) Userspace runs the crypto flow through attestation subsystem. This
   is extremely similar looking to PCIe SPDM:
    1. GET_DIGESTS -> device returns a hash for each certificate chain
       slot it has.
    2. GET_CERTIFICATE -> device returns its certificate chain, read
       in pieces.
    3. CHALLENGE (nonce) -> device returns CHALLENGE_AUTH: the chain
       hash, a salt, a hash of its descriptors, and a signature over the
       challenge and the response.
4) Userspace inspects the above and approves the device
5) trust = FULL, driver is probed.

But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..

Jason
