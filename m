Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873921;
	b=d344Ya1LIHecuBtlcn3aCBhOHyzmX7UdfgRxHxqARi97Oz3yIE3HC6Qprj9N756nxQ0b
	 4JZAEwdOFkihcLM4coNJQVWgJQqoa4R8UqQ57TGcdq0En2NmXQtzyX8wV1bPgUXP6jY07
	 MzceUKKWq6gONVvy/9sX5B9WU5ckwPTkZEhVTsi5UXp5jzYffbfjH25MQPdxcPM6mkOD+
	 L0Z0dAXP0G+f3NDqhetK32UhXSxhQagYkYAyjEDO8F4ELnHp3CnT0bD3C3rWubi/tiQv1
	 HPy5nMNTMQzDLfCJo4tJsumuwRvCi6cljb61pyfvFVH7ywEhLoaUqEGklGo0xkv1HQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eMx+CTkXv1VoOtSvi+6D1nYsmWu0vpvPd8N8huVVt6c=;
	b=lXkUS0V8pzMLMNJtFbw8cxdYQhwP5nU6klB/PoP2Kj/frAvgP20AAHMPwoqms6seF+dm
	 ZnHkzOBcgEIE0TrBZ4gsKIrNRFZ4e+QbI/X2VZEGsp5TDXaByHmWopEYphF36fCElxbw+
	 fcp2Bow63hGuzpTU9P1ypkDl089OhmF027hm3SvNpjpaTJocib5v/caELwj+mTNvQMABB
	 wmk09bymUug03+LPenYxoo1zkPXiGLKxzlb1uWH/5UHNU8AUU5nQ5JzRU4Rxk1IAVkjvx
	 OqphDTDPXQv0I1hP/BKX/BSqBYz06EsTE4ooTSYTYkCLm84HZVT/0A6Kk99crWP6bNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Zj78psXz;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C48606A330
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 00:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28C48606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Zj78psXz
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-94937a33cfbso433827385a.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 16:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794873920; x=1795478720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eMx+CTkXv1VoOtSvi+6D1nYsmWu0vpvPd8N8huVVt6c=;
        b=Zj78psXz04qLq58LGKt198o3T4FAbqXZ/y89h3KR7fpGQ1hU6rGoOTe18Apzc+22ga
         DvMiwwoc9EwC0HgoznHV3HqUwEUvtiWc14KwgNjs9kCTPQua55iCuYSRcsZea9HZcUvi
         kFgXcmNVL2d15KoP+coMdUQs5hqI9ACZvQoesIzcE6ygVQJnyZ6/DXeTqoppU9qxe+OX
         CnzPdPwMJbLc9vEbkgeNBMxuwA9KQTsu0R/F+fFGa9jddkYkosqmrDclej3+Z2FtUA1S
         bhlDW7JakK/pjai56NYfUbcLMz3qOmBfauRPnApgeZ5iibvGKctCvJAToTRAAZjbVnRD
         zW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794873920; x=1795478720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eMx+CTkXv1VoOtSvi+6D1nYsmWu0vpvPd8N8huVVt6c=;
        b=EqvDDMTlfJerceOFk20m59eT3H2YOT5aCdwjnuTUrp4SFqC2MhSa5BAz35xdaAVhdx
         H9Nt0UUHDKz+eo8WqT9i0nr2HDiw2+KwmrgWQTTxt/xl0iZL6IwsEZTqPZYPYqPDGwsz
         2GjoGb040oc/hCqxjF+sgeTaGIz597ETfyHND4n46IwU+PlGLfTluVed1xg65cZLK6FL
         ox3fmFdMXq24Qzc6P6Rv2ms+YfHmCpC/b4rZNGdYjb1wnXSMr/MAcDNlS5qiT8kCJZRy
         zw4C+Z5jaEZuV2Tb3J00L6ZULG4jSyR7kK85qQ4/tM9eCDOjuwsEtYfGi2q8sBgVp3yo
         gVLA==
X-Forwarded-Encrypted: i=1; AL+hErEOMed0d5+Vkz5RvtS6cZKdNgJGhBvLWEdy8246RQ7KngqtAZPknH1pIh/3Myyn3SFPe6H4qw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9nezu4DP8ANSmCllJMQRFr6FwCtWneDJx5PTG6nbhHHSjRluzd
	uFb5LZZJd20FcBWrGtGLVYLNHVBOJl1xDBhRBL+02qNevNsffyvGNfJEj9VlqWOt1aE=
X-Gm-Gg: AYBFou0Vb/SWMaQTGvKB+AredjF21RLmoMHf3X3v0W8aW1RwxRLfjOD53Ah7IccED41
	sHESlvKjWIIGpni1UW+RImqh1PV0NOqg2Va1c6xyD+1uFMpFhHbEYZ86ytIx3ShwZJQyzuQhhz5
	hM2qCH7f0ahaN5Dinmtx1kXyiq8BoXy49qP9vJT1c53fsIBkgP7GcE6LDdAObaZ9PLsV2aPXjTQ
	rNlUduTPk05eF7PCbAqO5Wkb3vIKDMutkChBhEQV4AHVyTPFwTvcdCfnw+osVQyQic2a/m7ZwzQ
	mbVzsTjzwvn8p/RbId9C6w0ExumpNEsqo+w28e3a6ojQInbkve8tJTPV75EBGPgAqSdKPv0yw1F
	VtDyxm7kBVP7LKOHwjDc7HhfaAUQ77O0T7/fKLx1nRIumZuqFun9y5FjeRcv7o1FKgfFNmihSo3
	25E+Is/xGoynQKNNUl/NTMordpdKyNROiw/5bmgvnud3cqPzlk7zhWACrANyt59dtk2miTluyXp
	bb9s/fIK5A9ohdZfWXfbioQLevybA86c+OfqxTqqhsHbaKnetuV+cy88YyFq6elcuQUiG59LDgr
	6ZCqLA==
X-Received: by 2002:a05:620a:aa0b:b0:949:7473:b1a5 with SMTP id af79cd13be357-9497473c077mr807892285a.55.1794873920005;
        Mon, 16 Nov 2026 16:05:20 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8b889csm969866585a.32.2026.11.16.16.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:05:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT6h7-0000000Apgy-1pGN;
	Mon, 16 Nov 2026 20:05:05 -0400
Date: Mon, 16 Nov 2026 20:05:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
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
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Message-ID: <20261117000505.GA2488304@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>
 <20261110122237.GG8635@unreal>
 <b4c2538f-8021-4abc-be2e-fcd1596f84ca@arm.com>
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
In-Reply-To: <b4c2538f-8021-4abc-be2e-fcd1596f84ca@arm.com>

On Mon, Nov 16, 2026 at 05:13:59PM +0000, Robin Murphy wrote:
> Even with the slightly dubious argument that this series only intends to
> shuffle the existing PCI code around rather than fully introduce the generic
> abstraction that it claims to, if the PCI behaviour is still just based on
> propagating the internal "untrusted" flag plus the new global override, both
> of which *are* known at add_device time into the common trust state, then
> there seems little excuse for not doing that up-front so that the new API
> *can* just work as expected.

The desired iommu flow is to start out as blocking and create the
default domain only right before driver binding when we have the
correct trust level.

If we try to do that without this series then we have to do it all the
time, which I'm really scared will break some embedded thing that
expects scanout to work or something like that. My hope was this
becomes opt-in based on the new command line stuff in this series.

On the other hand this series works properly on systems without an
iommu, which is pretty much all CC VMs today.

There are probably around 15 series to complete all of this PCI device
attestation. Without everything it isn't really usable, IMHO. I'm not
that worried about the series ordering.
> > We have two levels: policy - that describes the default of all devices
> > for that bus. level - actual decision on how that device is going to be
> > operated.
> > 
> > "Disabled" prevents driver probing until the device is authorized,
> > "Adversary" permits probing and requests the available protections
> > for operating an untrusted device.
> > 
> > Both need conservative initial IOMMU setup: a disabled device may later
> > be authorized as adversary, and authorization does not rebuild its IOMMU
> > domain.
> 
> Urgh, I can be absolutely certain I'm not the only one who is going to be
> confused this way... I see "disabled" and instinctively take it to mean
> disabling the device_trust *mechanism*, as the logical thing that people
> will reach for in terms of "I don't care what this new thing is, just get it
> out of my way and let my drivers work like they always used to; I want to
> disable the new thing."

Maybe "isolated" is a better word?

Jason
