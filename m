Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840359;
	b=CHkjjwkXX+6zrJlbyM2SOK+FkuzoOMMl9NUiDvK8GzAlj39xLU97vFo3YDt1a8cv1mjI
	 4VoXHrnS3S3PaDys4dQJwlNMxw8lgLZoseJySMx/qgfMPr2Qlmxqh9sA4i7S/Gp3hQDka
	 ypcJ87vGFciuLfj3Pj2DGxXC6rhhsuy1QGp9G4a+0xvpUFzPjHTw4xVQVKHmqy2UAsFQj
	 fSsM3EkpyUjRsJpPatd7XV9V8ju3mDhvD4+6QiR9349NgzReMNqK+r4VP33ENpJAKYt0u
	 yKtOtvG9iKFBIzbIjaOjz9mtUzyKPjDyslmWZV9bJzL7DL/Q6h4znB4n2GHABUpZ3Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
	b=inTCGLxUseyA9nHudndlQUp9FTyQJDiS+izCuUafIPsZjLDRqenxtcoICJykUbpGCk+f
	 lXjr1kmud2vq6XWayqc8trPT1rNE/z92ToGJFTsEOt7d4R/CjvbHogmJrgpr+QkB1M62a
	 FivyK1nX7vcdt9Plwh4+7DTPDoX3oJsz5QS8GcT6sJNIHscLs9i98AM82HCJaU7ltqGW6
	 7KMHhTpgvVGSAnkUgmgm2ZUIH1lCP3ww18Y13LzQ3EmMIv65/WupLG55rFcYXuAzv6vPf
	 c8Ai57igI1tqujdSvhvay98VIpofPHCUJTUpWNd/VBXybKecHSmx2s3MsGvgnQfXl7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YJ1u7+3q;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021A606A336
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 14:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9021A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YJ1u7+3q
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9496400270fso215429585a.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794840358; x=1795445158; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=YJ1u7+3q8ho8S8Cmf/2w5wU4CUF80KQfEx0dIwjylesVJSVp27D0TnXVhGDFGsq/W7
         Yb8X2Sx75plWxB0mHvomzU/+SwheHamPTUSF84/eyfqxAOUo3KqKfLj8B1X+rg3Y/Cbl
         iH5BJ9I9aimPuYADSaa9rXgic7xW4xi4ybOfyScVe2rMyrDy+439om+gewLAqXNGlGak
         DFvqrV19hfYi3qwYmFJRlFwTwrxoUQgLLPiPhKihWQ7vE2eO+F347DEcxXDMHyISNihk
         FcZWIs6r9YWAmKVOdSENQbUB1Vu1/Yg0vLkHCD72z3r+cCLouGtUv1fhIM7YUXYqxWdd
         q2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840358; x=1795445158;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=vPF5CIXYgdH164GW/v/3tdNR934ky/BRE37RFaSAXRLRrh/gmfvFBAuDy/Ykt8CcRt
         ODvBTHT7780/s4A8o/AjW5ostnUAt/cvzmUVZeXrIVMPtXazfBdga7vq4dHkZWSVbHOe
         GqSDsbGAJPAWkpey/oIGrKhWxpRnBo9BSvkgwhuc03rD1N1OdaPj6klBR9rAUlvkwquj
         2YYeW9uGMcgbdBxEirFX8wIUF8QQzNoD18VxCzxGe9ofWXXZKmI5cNbEo6jO6tqsQwQk
         z+nXLhzBpkaskRxjX72we72mvXBHgz7vSvNZ6+4Hx227oqTsRx4+jhGr4tox7lt9liSi
         gc3w==
X-Forwarded-Encrypted: i=1; AL+hErF1wI0Cy6ZL8ko+tCBJ1hdb6LPyej2TXjodEqHTeU+guh+oarye4Q3qvi/HNfueeCThjSMmPw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+1RlN7SudQ5nN8aj8xPeRwpwil0qJmlmoyo6ARvJI9gXXF8tMZ
	nn8bRsrGJsPgVGeTxOu2+YP7aY86D9lDlqVVoAD3T9++/FaEWuyLF78t/ZJ/+/WzIiA=
X-Gm-Gg: AYBFou2j7TtO6G7m5scdPJlCGOoCKzSYsTZisugOAvgv9ZGx0pifDVPo6C3PMw1IzRk
	n0N1SX0pi+RBwwsUEn2X0zC0NyV5imXWUZ9RLwxJMsENTxOJ3zQH+UD2f8T/3zCxSfdVKNPIusU
	l/05HJ6/2vrnDO65MxotdnAPxdkoT6TuMkQ4roEW13kbnOOZrJISgGcUVkpmgzkEbxnaX1STDET
	hYCwGbMddT8kBr1Y2PGh2fB+I8XKC02z+oKauBfBb7vxpAc7fSjBR+M9VzOV2oD6pGiKv6xTYrb
	lNmgHa8VKdhv6tLBvb82WM3gHnclMEouehHBujqyQziyrvj0tV9IkjqXB8AmTx7KE84BfoW7Dcj
	Ne7xviuUOX9RBiVqXLsOgOrPUirRCYE/p0/LHrDcl/e1nXUbJyBaBLdnVEZdkgQJR9Jt0ph0VPW
	7CkdzUE574/lmN3PK13N6NK0pwWWsJaMVoJAQ1ZJLyREMeYZx+KJy7dUc2i18/CKMx/b6EzQE4b
	enZ3P8M4oyxUKiU6QqAEIyXa6AEDH3Sl7YujWd3XzwLqR5NiZ4h1jGjPMuVyBg2Fxl8XcvT8mvP
	dky9Yg==
X-Received: by 2002:a05:620a:a41a:20b0:949:5872:be1b with SMTP id af79cd13be357-9495872d3c0mr1015844485a.39.1794840357475;
        Mon, 16 Nov 2026 06:45:57 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836079sm858473985a.18.2026.11.16.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:45:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSxxz-00000009V73-1sJy;
	Mon, 16 Nov 2026 10:45:55 -0400
Date: Mon, 16 Nov 2026 10:45:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <20261116144555.GM2532299@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <20261116144103.GU11319@unreal>
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
In-Reply-To: <20261116144103.GU11319@unreal>

On Mon, Nov 16, 2026 at 04:41:03PM +0200, Leon Romanovsky wrote:
> > I think it should only be for the duration of a bound driver?
> 
> For now, I decided to disallow state changes because the IOMMU may outlive the
> bound device. Unbinding does not fully reset the device, so we must quiesce it
> to ensure complete security.

When we refine the lifecycle for the iommu this issue should go away
too

Jason
