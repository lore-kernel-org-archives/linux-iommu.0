Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887594;
	b=CT3HnHYsa6AJ5LbsrvT48gdExEt2fQsOeH1cuaK1EWlweHN/cJLdKYdvAjClotEmW9fb
	 Lueudm0Je9CtCe4OifSYICLEMb5t9KyHgWuXkogWexT5Eo+4utN5segpBs/+TJK25gNxf
	 mT0yh2v5NikftB2Dk12j5GgI0g3mOG+hKRJuCvmjsksQZwuuar2H+IEXrk7BildRcX4qj
	 nSWzsEJEoclrzjdU6oCjNm+ZVa230LwxR76nREYVV1YZjBuIsKy4OSt94tq/PC9cXS5rt
	 80V+Hy5rzSAmDPHxM4x73RPqRxZ8g9Q6LnTOxGpOo5lzDKmJpgWGRotR88wpsE/yw3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
	b=PryrT0h1CnTizpHzHjAisDKuIRJmLmz+1VqfWiM6ydzG4Ar+wniDFZllth6KKqBpdkgX
	 kKhRMY58tZ+uWg2wrttAG/DuL98yE/n8BEPv81fX5eZ211Q6gH3W7sf0P6V4T3meJaXCr
	 x1cFOCvzaNSaupl0M7sk+yuLcF/+e/lbiPebInq9I7e23IUMLwtT2CiELpqMPAR03JTL+
	 HcIK4HKKxlpRYwFl5d5Rr2aTpcDPpwkdXofgcPM7LJ53ZQA0lSSF82B74gyz3mzhbWi3t
	 JH+oX94JXEFz8AkdCxQQegJwNPbynhYoJQW2lzY9r4fozEMkx809C1sVVNrMYVPaUYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MbR957K9;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF67606D803
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CF67606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MbR957K9
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eabf243d05so731334e0c.2
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887593; x=1794492393; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=MbR957K9WRdc9Y60RgNFX5hOVWhtV7AeAr4S/IScatjKgjB8lKb4NivY343RNC6qXK
         GdfsdGZcguxLRvC8cfKuOuEc7LG9UmwHwrk0JUSYPpfyxjzKvwt2y65kDA3D8iMMmuq/
         jbhmXr2de/31BmhgfuZ53j/tq6Of6INt6LOGNOwKujcKENU1Bt0f2OTYW5G3lSRKSS37
         jUcMPoJPdg8nZxVUO3jLluyALbdArsWuoOBD+7hp1U+jupe5VeeemFOXrb/dbQ+6b97r
         hy8kJKchcJSlugumDb2lGhsUGnilUHDnauduUBc3gRgmuKoGqmJFwAXsHIYs3HOKrqPO
         aVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887593; x=1794492393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=SFBQ5AFwskVHO6m5VPGf0+d1VykEoIobxLZdC4aSe+Cf5+Q/fMWKkifdS/GNFiQf+w
         35lH8mX1bJm/nml9PCVua5ZAXaxAr0n6k+4cUSCd86aMuePMLvjKo12vCL6R0TjVg1Oa
         Tg2r4oc46a6XHdmeEUHV3rAhTT2pa/6DokIptWzJ6uilD9NtFfgWoHgo2xvL7zrUx8eQ
         mRGJCyqZvNPmg9QEL/Z2ZRjJHRHr4wlfT0pP4oFD7ZbpdiTrSmkCGYL35sJrsNWGIXrT
         PzZEaoEDJ0h9lN+0JP+w0cQF2PoaZq0u6jV/dq93N/8pw1jyCxE5K7HJMX/PJZvx1ROU
         VzUw==
X-Forwarded-Encrypted: i=1; AKwUvBxW0nfskzqQg/9BIBAvcJWJBn8ehR7W9eM1fNcQmubh16Yt4HaVP9/AUyGDsK2A8rAzUo+yAQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+o6vIkPxGbkzcM5/5eoT9VAEiEKHJGePIUiSjAAGfmWQnvxJtD
	mRe2j6h8MTVScTVqpx00NulcYJMC+4bgAS3GHboolvcM9ciUWY9p42dAt+FgytUvR0o=
X-Gm-Gg: AYBFou0749MyMVcoe3EBHh7svEvKsq0ZvgOtSfBX9l2kPSGcY87rqACaqGGuSnC6aYf
	R6lPS6Tph6i/LIQkcYIW9jtAwlKNNq2hnAyS3syzPbo4iqhLRwAsUM6zyNHqehNXH60WW/z7lVi
	nw2Vz7kQu7rog0NKQXfnMIdukaBb3FhvVyRTPNWAFlH6SwQhYFdUqZdZgfagSiRSvgGXggjXmJp
	vAXCIaeJrD9KCsGhJLkFPe/W45iy0XvsqUiJfj1ciZx7+rNRulwS10hqIwgJBCmNfiuUBVoDosm
	e+Xd6bVrZTzmE1J9vxcMO7OxuZ2zAR5AIeMjC16GLUWxyio7U1jdu96/DKuhOGp0rwsQjBgcwk5
	ipF6bhnu40eHQgijNItVvz0DbWcfqqbyQthvVG+d5f0MUaFdG7lXqAmJMsQywBqjxuDCRrk9QNe
	mYmhpG6zHKu5gExLqlLNczyqUnYJ+m4SKrUxpRXuraYsvJcjtH23aqp7xyYV3ys6g4cHLL4m4Kt
	gJc3zZSyPqKxTM7EfV69bY96O0LqEXOC9t+l5VJTVPP2f82GaVFpi4Dws6nBRQmdY47R+QZXLEg
	6rwzuyCH9aBnGDLrM2deOaT5mET/mgWjiRwEowtNSepher2zyYDhcjJL8jOfCLpS7P9HYn45+AS
	vJAUJ84ecnA==
X-Received: by 2002:a05:6122:4f9f:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ec68949c50mr9274698e0c.17.1793887592873;
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm4161881e0c.8.2026.11.05.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy6p-00000002ezu-00ao;
	Thu, 05 Nov 2026 10:06:31 -0400
Date: Thu, 5 Nov 2026 10:06:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105140630.GG3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
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
In-Reply-To: <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>

On Thu, Nov 05, 2026 at 01:59:20PM +0000, Robin Murphy wrote:
> Yup, and that's true even in the PCI TDISP case - there's a major amount of
> "communication" and "configuration" involved in that. The principle which
> should (hopefully) generalise is that a bus/host controller driver can
> always interrogate its child device to perform whatever attestation and
> general configuration is appropriate, but we won't hand off any _control_ of
> that device to a specific device driver (nor enable potentially-impactful
> bus-level features like DMA, interrupts, etc. if relevant) without the
> requisite agreement between the bus code and the user.

+1, I think that captures the idea very well.

Jason
