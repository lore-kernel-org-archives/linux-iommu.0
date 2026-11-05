Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898126;
	b=HLdP2KeefezjQaPxd7C/bQxZ1ICkym5QtDbBVE9+JuZUBSUG/o67VY/c7Wbce3Dcd/Ie
	 bpY+O8cfffeZKgYJTNu0MYwpMOnTJgD1YtRVAMxWgzhzD3utUtFC/bLVlVS2kwzklwWWE
	 f+FxIg7OOf9RL4d8oF1FP93TO0eifW9dk8NCCV19ntuQB8SSPHFJfiBYkAraU8tTZhS5R
	 9cAADgqthIVt7jPLXFVHUjC4i5KQMaMMZLw1bAViyOGAn9Rr6yQbSsFVPQbz9+q8GTkaG
	 PoyW28SSR8nqx3j4g1OHNDUey6F+lqDFf9Fk+1mZSL926micRRw1BGSK9DAd0FExSwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
	b=TYTCUCYtdMFMab8QMBXr0H5z5SlnllBap50y9UzL7NtuGynBvK73mqBnkhNaDS1o/s9T
	 XMXdHYDfFxXN4AXl4Q1hWLP2mCRuZsq65m2WCFRfVFIEnWF4AYiZjObeRmboJjYO2g6At
	 n7nXCRH0md6R/fPoQbAhqbea6nPYbMXT+3a6KDKP0kJhlj7ZYbvz/R5fCo6EH5xZOwatU
	 O5jb5QPyYUgqbY5CT33fURa9caBi5cGP5STXeYvWfgknjY7xyt6e6w1/rv1VZdAhVQ18L
	 w1AHtltUm11oyBzCKNyEouJChLLxdWKkcNXoukXEXYHGxuglUw14slCDweQqEKzOVWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RUc5cObO;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC7606D80B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 17:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14DC7606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RUc5cObO
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9950a7530d9so1043804241.2
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793898125; x=1794502925; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=RUc5cObOZ6O6+D0a7KmTBU3AgOTc8WE4LovmEw4x1QzzS7/ypDDyx2ySHcf5lla+CA
         5GBimoidWQT5MDI4ePZMyzVDUqUG1M3x/y8BwdQJ4GFzS2amN+YlDPwqvvlpXaKIlves
         V/CGe2OhW4agWFM0S7Tg4TynGn7JQuvpY4aZCO0YIXG51LJBORD1C5VvK88gNg+WdqA3
         XnHMji08194InHapylomPTlsgpazU3tAn1q0+7jM0Bud1hVUGx1nLQ85+19r3w6/S+qG
         TMFTxnLEsuC3m8sfZEXFzIvzWGm692mFY72FwTzjE4y+k4BUtaReyzAur5++rxtIHrxX
         6VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898125; x=1794502925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=b8pkrP485a+8dPpHvewhZKRwd8foyw5jokDDRATA8c2cyPhy/KwVbZaI6V67uY+Cyv
         u4KM9rlautoWF9u4XzHdndHVvb7g2gRcRF47aJLs94sJwG3TYquaU5N7KbpHgfhfygPb
         ZpDQg0vO4UjUOwEacChX37Y3sulcPLP85i83Ae0QEOovXN6BOC8CYQJcifTeM/Q4YGpp
         6ao7kxRwHs9WJAoQZZDo2yPL6wyZC9QZmm9dtayNqyR5M4csqWqhsPoR/zjrnBSfBQv8
         xK4pFrLXifgb0bQuxj1mtftrnsgpxqjMMOcN9ZcyTyVUGxBAqZRtrIqp0K5dHkrdhZOX
         EgIg==
X-Forwarded-Encrypted: i=1; AKwUvBxtXnA4i22yC3StFO5Sb52PLu0PpDG0SjW5X4Xh9bG5JCJYxmUlJbIA9mDgLVgFZ4md3wWW+w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8/5Iitl+qy8foGWJPIakISr6CyhIE4RQZvKNn90EmAHDmmOspH
	9LkCQBjNNliyvf79bqLyrXR0NXKdLRjw7TLDLn72bU6L45orwaz4DlVGfnvf3+o+Zis=
X-Gm-Gg: AYBFou0NHS5ZajNwUwhQ+qmB71yRtvk4tXTwX2xxUnzaz6FE5FiQURREozYipC4KAmM
	4JX257CZLZI0XnM6qwSPWcPxMsjiTqRqzB94DAyBsGTfOMtqvB5B1pjEioH4uLj79mKM2k0rx4B
	40jc23wIZdfnyLw74Dp9J4+lTwDp+Bumn6IOx2DeqG4XZNuY8FWfvFSKquF1UjlhKTRtjxMJDuu
	pT8z188kDIJ6pWhf05KLE2pb4BF3w+uojgXEq7W2/JHNrq+wKpRkHjsywc7p/eiKLc47WOkYqQT
	g9y84pyB9zyu+tAVkeOmfYmB6sc48WrGmfqdPpMEvxdK1bxkk04/HyLs4IJAkuglIufcslagt45
	cKN33JovlM5Hn+GYj4txYt7SWEN6pca6YZ+OOVXMDxrXZcWlwaVOVzgI9vbRcgu+wxPAzVjnnKv
	FinphRHAKvAmyHrpSe9m9tp3WedJFeeHaXnCL/9f7uaUcrKm8m0eKwWkavNT50PkcPtX8EZ8VMf
	/WnmBXbBaJDXH4fsrEcImExEPk7Zwvx7R8Tt4lWXs+q7TSvK90Ft/+V19uJ4dno5lcFWgSRpsKX
	yv+h+YvdX7+LklXSMXVGQxjJgha2U3sHiAnuMDnR7uvQj6k2VUYgqkSkX4JosInI1kAn6WGkvHc
	0NbAftPJsTEE33PNB290ciIm4sfq1Lmw=
X-Received: by 2002:a05:6102:2c1b:b0:7cc:2bb7:1335 with SMTP id ada2fe7eead31-7d2a16c7f35mr120203137.33.1793898124846;
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm4619225137.3.2026.11.05.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0qh-0000000388I-28Zd;
	Thu, 05 Nov 2026 13:02:03 -0400
Date: Thu, 5 Nov 2026 13:02:03 -0400
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105170203.GC663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
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
In-Reply-To: <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:23PM +0200, Leon Romanovsky wrote:
> +		(RW) The requested trust policy for the device. The initial
> +		value may be selected by the bus before the device is
> +		registered; otherwise it is "default". The policy is resolved
> +		to an active trust level before the device is probed.
> +
> +		The values are "default", "disabled", "adversary", and
> +		"full". "default" lets the bus select the active trust level.
> +		"disabled" prevents a functional driver from binding.

For making this more general:

"disabled" prevents a driver from binding and informs the kernel to
provide containment of the device. For example a PCIe device should be
unable to DMA to memory.

> +		"adversary" requests operation with the restrictions that the
> +		bus and DMA layers can enforce for a potentially malicious
> +		device; it does not isolate DMA by itself. "full" requests
> +		normal operation.


"adversary" informs the kernel that the userspace wants to opt into
any security defenses the kernel may have to restrict and further
validate interactions with the device. This may have a performance or
functional cost compared to "full". As an example the DMA API and
IOMMU layers will avoid exposing unrelated nearby memory to the device
during DMA.

> +		Successful resolution to an allowed level commits policy
> +		and operating level before driver or DMA setup. Both remain

"before driver startup"

> +		fixed for the device object's lifetime, including through
> +		failed or deferred probes, unbind, reset, and driver reload.
> +		Later binds must resolve to the same level, including when
> +		the policy is "default". A resolver error or disabled result
> +		before commitment leaves the policy's writability unchanged.

Not sure what "resolver error" is.

Jason
