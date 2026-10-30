Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368463;
	b=YDpLdosLx90mKkIcpPFOuRwtT9iEFkkAYcAiuHerQMMtIhaOoCFS4LsK/hYlYsfYq2lI
	 RPolZXk1LjYFf8htdbkv9YLMeJYgtCthuOoTwc+0VXfTBTX6VaRCR1bTgnSTo77Lomm6M
	 IptbuKUeDiPQL1nNBnVD9eK6vb2IcBv8RJkve+k/qdDO/B7ThjXbwO/TARD+HY2hMsc3V
	 RCc9WUbWKlF6nC7HPe4nmZDK6bVsYo3W47hmVQhtYCJ12sPwGm0km1c2pSzQfpwyha+yt
	 Bu2KQQlacyZ2h8hVPgsDPQ4vTD3f4nTeBFSwlE3sW2jKr3Jn4axKpHyhqvplMinEokQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/hIuaSXC/8qKVAwXvaUJ1vLVQZIbwa7mDnRwYchKUok=;
	b=vcuYCYLcoSrCzSMZd66YxeUPT1YUP/cvTNs1fIG/RSbhDHJGBs2ucWyVuvkkOz82y7ha
	 jVX0I2Fu+WnaG9ceVhHIK7pVBDYdmIiTcOyUmrbTchDhbcTA2JP+aNqBi7/3lKb6/g3H0
	 MHq8tIaJxOExo6Famgnb7N3aKDrtY4gjwDPvLVaubhRr1I9bF2C6qJ6EwC9Dn8qEXeCea
	 8ti0Qnb9TX1NPlZEuYOK5l/q09+ikjM0XechsxZDb42si4/hsP2kriSH7+SM4w5QftsEt
	 rkAK+yq2UyJ57GnRd1xD/AKOcyglibGGUBGHJgAwWlIJvgHF5iRuSz8DtwodKo5TBYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ew5OXGO7;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA366606A321
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 13:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA366606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ew5OXGO7
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so6152485e9.2
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368461; x=1793973261; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/hIuaSXC/8qKVAwXvaUJ1vLVQZIbwa7mDnRwYchKUok=;
        b=ew5OXGO7qsLHwNO7roJRSJXgl5WL5Pnrwrv7mnCuu+N7FNp/x8FOCSX6PKDoEC5Ii6
         6Q1aUeuD3ZSLohnNkKT2B5XLfdVxBO0VpRPz7UGQ1qyrWBBT3dg1BGLeEu+pmg88pjDG
         8IsCg5cNFh/qMOWTRx9VENKz0ZTchUvDkmNkSOdrYL4NRqgXPrOtVvL6i2yrZcM/EUi7
         Qya8VQczJ0QG6VIra+I2ucyqxo7Cfiq36g6gjjKzzLlSJUz+WKKB+It2CwoPJHcxnFQV
         fZ+WcjpurI1znEz8a1U5yVsV34anEhWyj++3yA3HIahWpkRuZBoPnGTEyKns1T+9Hq8+
         QuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368461; x=1793973261;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/hIuaSXC/8qKVAwXvaUJ1vLVQZIbwa7mDnRwYchKUok=;
        b=GF0Spm5+UcYcMVlvwDqWE5EywdCIG5sKxvP9Bw+30TOD86e1n9H9ijTmw6Kp6Wync3
         ZVRJ8tL6T9k4U0CDCRahP+EtLgaRRqucumJgVV2zAv4eEQMiyWCZ3gOU+oCEjw/k7sKH
         sYAdwbEzmtKKmCp9SrLJHT8MllBxwqLWXWuz4PTUpA+QBE+TBAhGimZ0k4LKts404bmw
         nm/CgKrw5w7nalpI6f6g9UHlOikLw5XxYKhEJ66eQ+QAEg63Xuz+7QRJ98LC7fL+NrPv
         +++DSpv/PrD/RGQlF+WyFG1pLY/VLbcg0K+0r+WL4rJbmaumOL15SPYRkAMVaBd5+hWn
         WhyA==
X-Forwarded-Encrypted: i=1; AKwUvBwz0SKk+n8Di0OfJNDU9e9C9Yos5m/QprbxlHXsr89MJoQZNP+3GnVB+Rk9FjJTanxfi4ALJA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJFCODoGeQCv1Wn/zVpT9olApv2xGSmlxHAw7gaJt4i0gm43QXW
	FXTguigtkNG0dKFbkfCFaRgF+ctMkcSjbJUu5+OxRacBTGq2ARn1SEUT
X-Gm-Gg: AYBFou1ZMQ7SYBUvfBOoED7zjdqzB0cZiEDDKlsr5iWbKkt72iOwij5m/8gR65O5jkz
	+r/3uX3nYLElf7XPYB9qDBVAvAxI1bIw0ZHGGZLMY5t4Rza73VzfzwjBsHWNsZK99/xRCmI/JlN
	W8/BxMfBy3O3MFzkI+cOBi1UECkPiBY5hCh/aFKga3eWT3MhtVhmxzQpwluTa9r4CMWRXpBOh0s
	g79XaCF7HkgVWLPlXYbfxBjfqi9YrGIdx49l4qlE8BFYci5pNMozuFshLQN+eUSM6P1D5sKVSKf
	VCrbG3d0L9Mqu0LYYpMzZoTNMAVTTYRKIlM06mvjGy7pclyf7yI7PEzkTb1/5FMdp/mPhA/6K9u
	B+yx/qCx9LMJlexqRJHe8Rt/NOi3Pw/Rry7ZPF5kyAWja/pTxvCMjmEuT4VBD+e2QNv2m1fFQ43
	v53Itq357wHPDg4OGIIODjdkl1//cQ6XDtiSUcgRAT9b9QZzGhgLoSvnOkdZ1yvRs4Ula6cDvKe
	DXfxvdNiah1A34rKhKf9DfyDsFdBah7e2Pe+K26805oasKX8vqv0dPU9E7JL/frOlvPEytvFZLA
	0atLXIHV0Eqw4Ex77vwkp5Sft50zIC9wfSVTE3NMylf6s/JTo0VH8ngP83x+tLZegOiY0gxC2Zz
	tWLkqiQAu2C7ZYVrn7ON+cMOPNx0dxVEqji1K8Bxrh3HJlvJsYCQRa8LrLjiI7TFtEDA=
X-Received: by 2002:a05:600c:608c:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4ac190497bamr46672575e9.28.1793368460933;
        Fri, 30 Oct 2026 06:54:20 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0950d533sm34613455e9.3.2026.10.30.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:54:20 -0700 (PDT)
Date: Fri, 30 Oct 2026 16:54:16 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alex Elder <elder@ieee.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Frank.Li@oss.nxp.com,
	Frank Li <Frank.Li@nxp.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guan-Yu Lin <guanyulin@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, netdev@vger.kernel.org,
	imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
Message-ID: <auShiOI6Hmla6XxR@stanley.mountain>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
 <auRb_r8ZSSU-eHZA@kekkonen.localdomain>
 <9207a52e-2d42-4e10-b777-2988e84d7dbe@ieee.org>
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
In-Reply-To: <9207a52e-2d42-4e10-b777-2988e84d7dbe@ieee.org>

On Fri, Oct 30, 2026 at 08:46:07AM -0500, Alex Elder wrote:
> On 10/30/26 3:57 AM, Sakari Ailus wrote:
> > Hi Frank,
> > 
> > Thanks for the patch.
> > 
> > On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > > 
> > > When CONFIG_PM is not enabled, all devices runtime PM state should be
> > > treated as active.
> > > 
> > > __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> > > pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
> > > stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> > > should return the same value as the stub pm_runtime_get(), which is 1.
> > 
> > Shouldn't the same change be done to pm_runtime_get_if_in_use()? It's
> > otherwise the same, except that it requires also the use count to be
> > non-zero.
> I think "yes."
> 
> I think the logic for !CONFIG_PM should basically pretend runtime
> PM is enabled for all devices, and they're all ACTIVE and effectively
> in use.
> 
> That implies:
> - disable_depth == 0, so usage accounting would (if enabled) be done
> - runtime_status == RPM_ACTIVE (power is on, no delay)
> - usage_count > 0
> - runtime_error == 0
> - Maybe ignore_children is false?
> 
> This might not be complete (and could be wrong!).
> 

We could add this kind of information as a comment somewhere?

regards,
dan carpenter

