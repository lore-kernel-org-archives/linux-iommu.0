Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835249;
	b=dgAlzSXaTVZey+sbTZHLqiHhb4a+kVQoqigbHQDiKdjVkBw+wedhVL1fOD5NQUGWSFVU
	 O7WTDDV04/9mv0fxUmq1SwdS4KRygCFWgWes9HQasxD+mXoyauy2eh7RUriw6B6JCFc11
	 zDVP1RcjvOEe1sBfSJ3ztOt7B/j3YAF7HckQnOJ60zMByD+HBZJpcvkgwFDJjzFPCVSmW
	 nf57HpecSaNF3FzLTmW99reHqK2q7baTx79iuLs6mSk2DRhIEosX9TLSOG6NkkCyiZ9vh
	 gq3E+j4TRLIQeOhX9YahYTBMZk7fMP5EokXnwz/r2B1WkXCyC+vLrQV++/TFt88uGtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pW6Ljdl+VPjn0HqbJ5aXeG19kylCTPtUMbKY6fBA+PE=;
	b=X/Zygv+VRshhmTznS8UZYpW+/MAR7EcTklBsK27lBqYATKDwEmxu89UkDxuxbvCkmQND
	 2JiOOmXgD29EItPCzN4Thdmcg1AnxrFRoNOaEa2629zgMTK43PHTHVLBQzBVn1Y8dWMA6
	 +DNKUDYh/kJM49DH6RLYgQI65UklXmWfq5Fd9uobaT5uGSSmpIO+7pxywItrf9zp4hvX5
	 zPz3M7SmdxAl8P9pox/mcaHQn1LemQ/ECQCXMUwYGndCQp/P0l1Mw2Nt+YF6x6LRf7/Kd
	 PSew5uyjIQRkyEr0gyxZdBHzx1fbUCNY/JMTyF8+SxP2C7kxB1fJYHX4VlQYOLoq0pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="bopOo/Mz";
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D104606A335
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D104606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bopOo/Mz
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91f1e3dd08cso13821736d6.3
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794835248; x=1795440048; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pW6Ljdl+VPjn0HqbJ5aXeG19kylCTPtUMbKY6fBA+PE=;
        b=bopOo/Mzq7ySDNj/Zr8bVV9LCsaeSWwuU+C3SuF/f1K+3JGvkFVtiV6QbyS2xso80Z
         HihaREdtgjCOGPbAKwP12V7CeKqVTdlhIrm5d3YmhOVBcAQiUZ4FYtOoEn3QRn5D2f5u
         D2q5LISfFxkGD80I5ph9O0BXEcG7LWBlLfq0nFPu9kaxyd3nK/D7GdLtHFNJetRmpnI7
         Au+OxkSNljjCh7HsHBBXesOAmxNu4nG1OroBiTiLFFfnS0lRpcVVq9tYR/h8bPg/9+ot
         0eu+6GqSeaugqdSj7udORaibsbajRco1m0rZLrdm3QV3ZVXn/+1Fq3nHRrTaT4ZiGp8P
         RQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835248; x=1795440048;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pW6Ljdl+VPjn0HqbJ5aXeG19kylCTPtUMbKY6fBA+PE=;
        b=KP2BAHjwSVobw5FaEgEDgceN4+PlamyzpTMtwHsc8bSgjs1eezAmoZd7TcMIXeuLVR
         /9+UrWSzfOqNQUnleOY+kArtbUxqXz1L1WugXrF9IGFEwBeDrMmcE6npgwI2NtSlKqUi
         xfKldwoWF1Ptftr+sb/qWSpZTdgrIXz0CoD8jV6rf8jLDDPGIhMqrpoHPRv9Wpt5XE87
         ZjmPBsr6MOerDa8f1hlHVe0LbXaWm9h795UHTSsIRprfUoVRBffzVYC+kEEdNQghR5ue
         vVR1q7HLgeUaLHbnb5iX1o4hIoDmGmTn813pvPxYGoiTBAwnWymO+2F1FOFlh4RuHmBg
         2qmA==
X-Forwarded-Encrypted: i=1; AL+hErEwTdB7/gEamjPR0HpJ/II1NYrcYl3fDAN3C1ZVVEOwBa0gX7C9QuUAyLPrhu6tu8m0cVvTyg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/fwheeTNLf1wOAA3TzbNgiD14ucM8jajr5E9Mj/kRalsgezoWp
	WMdNqPhCTbeTjdVj8PvGHNU3yheNEBDJQd/QCVhqwtlutULuYx1cuXqxEPzrqrhTs+8=
X-Gm-Gg: AZFdTZeT17yBhhWFRS876ncMMbBHl+nWXc8gFraR5BKbSP0X/bxBT1+8/XtafBb4zuO
	tHJZGjQ7b1n0Ff3DuGp1PPVgFzNI6PRhK9oRw6GJl/neRj9KMWw4TuT4cfVFfOcpg1oHbDFItrd
	DM80p5qAOwXoo3Mc4QgzYL6bpVHyVl63R4mtXTL1yz00A9l7xC0eEj5sVJ+AKKafEypvKBRCs6B
	K2dh5/EeGA0RQ+ANNmTj2vrIal4nFRmfrGMZ+7eLfjUWwl9QNX37tS23WSdsjnrAjnjOql5CQmI
	RkbVfyBq6h2AmoFMi2S9hqDr7w34vuljCweRcCu7rwxTlF2XetU+vZccGUpnsJKfQ0ffpiWkv/K
	AekmVxnyIOAJoSmIl4Q8q1U4YIggOQXnY+n8eLmKO+4/Ht/d7XUt/ifOHwApj9ljWURsYzHCnDa
	jNEw1oAh8OkjaNlsZumhRtEFm6EzT8FKKxPjwrP/gIe9kESt8+80pZw+AETj/V3czG/JrWeYNRY
	D5Qy3yDT/INvWlEKvZ5rU1FrVgdzyJggdb/XM2Sl1/mxMFUvvY0hEba9jiX50wh5QX7Ix611+nq
	H6qBgw==
X-Received: by 2002:ad4:5744:0:b0:91f:3230:2a4 with SMTP id 6a1803df08f44-91f32300351mr126741416d6.53.1794835247815;
        Mon, 16 Nov 2026 05:20:47 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm85758876d6.28.2026.11.16.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:20:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSwda-00000009KhK-1awf;
	Mon, 16 Nov 2026 09:20:46 -0400
Date: Mon, 16 Nov 2026 09:20:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20261116132046.GI2532299@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
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
In-Reply-To: <yq5amrr8yldi.fsf@kernel.org>

On Mon, Nov 16, 2026 at 06:38:25PM +0530, Aneesh Kumar K.V wrote:
> > +static inline bool
> > +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> > +{
> > +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> > +
> > +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
> > +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
> > +}
> > +
> 
> Could you clarify how this series will work alongside device acceptance
> and private-memory access?
> 
> In particular, what should callers of device_cc_accepted() use under
> this model?

Who is calling device_cc_accepted? I thought we were keeping that
internal to the DMA PI?

> My understanding is that trust describes the operating
> policy, not TDISP acceptance or DMA access to private memory.

Right.

> Therefore,
> neither FULL nor ADVERSARY alone indicates whether a device can access
> private memory?

Right.

Once you turn on TDISP you effectively activate DMA, just like turning
on the IOMMU.

Userspace then gets to choose how the rest of the system behavess. You
can still run a strict viommu with an adversarial driver even if you
enabled TDISP and can DMA to all memory.

I don't know if many people would choose that combination, but it is
there.

> You also mention that once a trust level other than DISABLED is set, it
> cannot be changed during the device's lifetime. If a device initially
> operates in ADVERSARY mode and later attestation justifies FULL
> operation, is that transition intentionally unsupported for the existing
> device object? As documented, unbind/rebind and reset preserve the
> committed level.

I think it should only be for the duration of a bound driver?

> It would help to describe how the trust framework fits together with
> those separate mechanisms, including which pieces are left for follow-up
> series.

The main thing it brings is the pause to allow userspace to measure
the device and put it into RUN if it so chooses before any driver is
bound.

It doesn't change how any of the DMA or TDSIP flows work.

Jason
