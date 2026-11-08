Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157159;
	b=TlS6NN0aS75csxHi6/KrKGEc8GwafP4knbb0V0rtLrJDw9FopSC001hPliyoGLOo0EI5
	 +nmUm6vRBV2+BlcbT0bPyus31huzrN6Lovy8nhR7HkrEclz+TNrrfgb8/cyfRey9cyg4B
	 kOQ9OV5G4tbXaZDk07+4vg0ZHTudyCnn2ydkNSknxn7hUJ0PQGc8m46xS6uhNhi0s6Ex7
	 JOthHVkECJ05SUqQBbajyjnbBz9Xa7KY2dZUnNzRoouL7u+UySVyd9m37zU7fOjvjs5p7
	 S6nuxIazPH+vPqJpWASz+Ec1LZQsDzcr8mXKdrx3V8qr+rQiw4qgY9+vl/uTBbrXECg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
	b=irwdIvPlg1PgHbQ6WTMg3t50RjF0XDIhIzPtWig6pwCrb1fSx1mbLZKr+JsXBcgLYABe
	 VtpJeygKZVJD+nQPbfI6WM+z34P8y/sYtcdLIpeasjNr/cJzMYNdL9fbjjVXCtX9ekp6H
	 yrvvmtWedBsoPS1hs6i1KVJp0ySMNn3d05s2J4dnTzNQTYaST5ZuWjZKgkOx9GxlCAT8d
	 +r8hwkLQpC5JSK29ppRVggkeHFuouuFb5IHhX3IkGFdrqjoXv8nhRqFl/r9Bi0lEeMSUa
	 +4enFYx8BKwSsCgPC6hlwNZKUsU2+IZYjTpoPBrwmWMlQ3uIInpIPAImIULFbpTCeJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0DE606A31C
	for <iommu@lists.linux.dev>; Sun,  8 Nov 2026 16:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED0DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91ec14f4369so2096306d6.0
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794157158; x=1794761958; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
        b=TQOS5doud00tkS6qBnEOKRQCvE1/93V/TCUt0drTiMBaxn8/7sVyyDzftJhcPX4GGb
         br3GEWLP+mtdYGvT8xobLggmVEYkMUaZCUV/hBTrPk5kAuGm4XCmLf4LDdF5cHcbsBvW
         9V7hPCimT/HdE6lYrOT53MTo26XkLZutl5m0srsCzfMRs+xDzW0kfbsb5qkef5s48iaC
         kuPyLliQ7dXySkF1ctBFxJLqKBASrsTPLm+AXhcGPTow3yHqFMSFu2Z2ar75C7Uj9ylZ
         vPvScF0hIRhBVrWyKEYWZYr495q9NyFacEiRrwc28CIgagESWy8Mj3JMaBNUIK1U0Ssk
         LjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794157158; x=1794761958;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
        b=TUCqx2uT3fDihOriZJRnRhv0YaQl9FxCGclDkcL4CxxYZ86aalTagfvlbn5RFSZ8jJ
         /atHewZHfbO1InsudiTtJN/JwVgkHlJdABMwHnJ7XRhV3C/Az2T9wCC9sD5HGNpxQlSc
         lnYXTZCJdzSBsdRyOAGNcqTEkljc3eoq/zaPpIE+8OEvXBuZTFqFCPT0WAnZWU9MaRZJ
         BK70yhF0l80DcVZOcnIzkrLmeBy/eLUGCTrh8dKaN8Ol0+9eRGgGDAJEEE1GqWiujz2S
         X/4Ng+rmlWTVjfWKUWDxjxsdJRavaYlS57CaghJWObglJ4tD+X6kFJucnfJDgiQ6SqaM
         tprQ==
X-Forwarded-Encrypted: i=1; AL+hErFcjyz4rok2dhwFt846sEXz8a1MGif7l+w7QLq74AsdR/YQXBgeHw4xy3EF/MYBgJYTChfumg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Ft40kte0jBJ8ghf35oI/Eoh2wldabOUC56gpKK8yJG+t714/U
	lSJt9CwAfg5LxFQqZ9wh4S2cvL9MsjOvI3gdPcTNNI3YmJRJntfJ2PudxjqtT3d3XQ==
X-Gm-Gg: AYBFou2MHULmfgqSctaUGiu6F+o0VKC6n7Qn/rstA5WZQJP/IWwB4yHKajM9jA9c26h
	ImJ9Sc8yV0Eh243ku0GQOS/RgWSZbIb6V/+tI/wB5GmBrVMANdV4e3WWpd2pv4/LhM4t54H/pmX
	AYB95GRzHVptuqLwQMUkyTVG1QEEp6wSg6TZq/GBprjOuOL7tMlVFyDIn7p1QEZ0Revj8uHJ4vr
	H1hQR+6EcyBSFFvEn5eCXqabmtvVbToN7Ggg0QCR0xmguUA4eFkz/NbbWrRgTzeo3BUETZ524x8
	KGCjTiIfTy5NkgYZsQSMshpadHvqs1zF+D+BiMdibPaxCVNmzrlcdmNZJrX3OATSDbWsGZMYtMC
	qdLIp8y7QytVp2uzyHMx2u0U+hLXFGt2ywK01eAdrZMUy1v2jn5QnkM/2K5SXBGZpiTKDCwjmWw
	2kUxvi72hGHlayJShYToZ4F026eqz5kNNMibsdrN8OiWE0qb8ZdRm0zzPlzJuwqaH3tu2eGjebP
	nONpvfj36QNmWA21AyBJ96O58u3KbbgPoZ7nfweX1fzMUvNYFczyfPAkrJE8KHYhbOOEpYDKVzU
	DzLw9JMdyp6fpfmha5RofchwkCuV
X-Received: by 2002:ad4:5d62:0:b0:91e:9d64:3294 with SMTP id 6a1803df08f44-91ed240d34dmr24616736d6.30.1794157157397;
        Sun, 08 Nov 2026 08:59:17 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecedbefb2sm22431036d6.17.2026.11.08.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:59:16 -0800 (PST)
Date: Sun, 8 Nov 2026 11:59:11 -0500
From: Alan Stern <stern@rowland.harvard.edu>
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
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <647f3199-909d-425f-b485-b598a18844d1@rowland.harvard.edu>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
 <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
 <20261105184442.GF8298@unreal>
 <bf756e50-c77e-40f2-916d-e88887426806@rowland.harvard.edu>
 <20261108110909.GA8635@unreal>
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
In-Reply-To: <20261108110909.GA8635@unreal>

On Sun, Nov 08, 2026 at 01:09:09PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 03:04:18PM -0500, Alan Stern wrote:
> > >  it ensures that the lock is
> > > acquired when the driver is bound.
> > 
> > That may have been your intention when the patch was created, but if you 
> > read the patch you'll see that it includes a whole bunch of material 
> > not related to locking during binding.  Namely, this part:
> 
> Once I added `device_lock()` to `bind`, I had to add it to `unbind` as well.

Obviously I'm not making my points clear.  Let me try again.

The entire patch description, as you wrote it, is this:

> Interface claims hold the USB device lock, but device_bind_driver()
> requires the target interface lock. Without it, trust-policy writes  can
> race admission.

This says nothing about holding the interface lock during unbinding.  In 
other words, it isn't a complete description of the patch.  It implies 
that the patch changes nothing outside the device_bind_driver() 
function, which isn't true.

Furthermore, the patch does not change any of the code in 
usb_driver_release_interface(), which is where unbinding takes place, 
because that routine already takes the interface lock.  So to say that 
you had to add device_lock() to `unbind` is not accurate.

Instead the patch adds a new usb_driver_release_refused_claim() routine, 
plus code in usb_set_configuration() to call the new routine.  The patch 
description says nothing about either of these things.  Not to mention 
the fact that your other changes make it now possible for the driver 
core to delete an interface claim when the interface is registered, 
something which was not possible before.  This is another inadequacy in 
the patch description.

I'm not saying that any of the code is wrong.  But the description does 
a very bad job of explaining the new code.

Alan Stern
