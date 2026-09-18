Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841A3CDBD3
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700395; cv=none; b=coh48v0f1QlHnKNCXQYlwuD8fF+XZoZJ+vsP7R5wjNFxnyVP00sZXSLjfss3XsKMMWp4KQbCJhY1M/OXUZ/UwU+hHoeqGip8sE2E0wykiUH1riWj1y6CqjsFBlPud3BczQdm5CDs+Eu2r95Yqs8ywJhpUGi7BPCw7JKeFsczfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700395; c=relaxed/simple;
	bh=IA0A2RgVsub/BbYG7H2jzk5weAVNHePmc5M43c0YUF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc0F5qgdftZfag4Wp/GjeopJx19HAMDaXGnR7GwvbJEDwvg85v+N2s4jLkeewt/Bz/UgDcoGQHznt/RN9a4V+9FomKiEVj2GiC2qsnEowQCbCsnrM5rLM9iLr/osQP6vSm/+xyTQFfbSBUwVKo1yyzKBjTRaI0V1E/UsbiK0S2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChRG4sJg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChRG4sJg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so35155ad.1
        for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 19:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789700389; x=1790305189; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IA0A2RgVsub/BbYG7H2jzk5weAVNHePmc5M43c0YUF0=;
        b=ChRG4sJgOxcBVydtC0tY8LtP7y9017ONOjOx7TuzJ0YCqHxU8BecG/wiGP0nP6PD4P
         C8Gj3dMA0Yfg3wbZtkUR9mZkA2XP4PBn+q3aaScI/6CdMNKKrjb/qJAEBSGaDL72mH/X
         5BdXjsya9VVx/MlsgX60UxF6uZISbhwaWmwiKCBziidrbSKl8yH0kD9GjKrTl/9VPmm4
         q0xyWIC30YI2YUA8ubgfVAu7nWVS8WdS0UR26iqwl7byWnKQPfiD454A/imanGsmyiCd
         LPkPNsSzd6/Sq2g/WyO/s4tZ0IEAmVL99suzEKvj9yYIQ7lZmJ6emqZqTE3IC06ucS1/
         mTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700389; x=1790305189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IA0A2RgVsub/BbYG7H2jzk5weAVNHePmc5M43c0YUF0=;
        b=O550w9Q2PstbTjf/HoGBR0xHV1MMEIHvCeh51FQ+QGRXHzJrKewa6zUq1UYpnQzmvT
         VaQatmytJc1Zel0C7E57E74n2FoC/AoxUpWR7fhJJt3ituAdGRA4A5IcfkjBjf3qbbag
         u1pV0LUh4vJ4ssSMRgqh3tjiY09uKRSQwo9T+gVAG9CzZtPxyHADN2cMuEwFDugCqOVq
         EeOJ2YeJ6yoviZB385owtyoFGI6b1CHLURkVxuWgHX5AHMbA5kgqW7vJUUXki3dLtQcL
         V/0E3UT67XYCIkdJUDFQ/6RJSMDGXI1BE4pfSzikYHwjVCEo01c/w53qL+e3pajBeVUe
         agKA==
X-Forwarded-Encrypted: i=1; AKwUvBx+vIMcZUpwzycPJUi2fcZbA7MITUkr4dkw80H/jKjXXtg2IFMUXnGsIkD5vhnL5J80WMvM5A==@lists.linux.dev
X-Gm-Message-State: AFuF++mniMlBax1zGc7FAL4p+X9zfdvwZkIQLf9AY/D0w3JbP5DjERCL
	Cmnl53hWYNDfgtlgYyTmx9cbNPczozmg/d2zQH9SuCzSUDUQD0T9hH3EuLMQG20d/A==
X-Gm-Gg: AYBFou3Ce3DPnVDQ7cswpWW7712aALDCujSM3VXuALIAJLVAxfZJrDWIKrhQz+VkS8S
	XG7drYjkEk22UnP+uczJfyW1z9gpUNqfuVHh7DEXW+F6TzD64HUlYzWxJPVW3/MXSgXWFkfA8Xo
	SozeMSLMFG6StvU1KiI0GsvNiIOtlVx0vc4AhBrLA+CDWAQHWTVmGUHjm/uShA4DyaWznR6/z96
	DbvQK8dSDAxi/ThpYKNhmF+XBYxutWKSEc23YRkRqeNyxWJ6b8C6S8WP7tdVjLJwHaeKl9+twfK
	nADxpa5fzZRilwfnYtD8PRvK6uPOPVoHPdBCWd83OASaaNuIJmfsSHvXMen2VNaRny/yLIVF6VW
	O0p3u2iy/rU4bwGY91PlApVokrRsJF6+hxQYMpAdFJllMoRV4wCKKZRK5YR7y1FIxD3Jo5yy/tQ
	qgiy8pEJagAQAesOlwwfOX5P04METRyXgj6Dv95SdMr8d2Gou7KnNBWZegH5zYuKuW6ubtQjndq
	gDnKTLAyFVJqff872ZjTOwcIdMaQ0tCvJPBNY37Qi5h+n2PmYzmg8HmLyHAc+ZPDZNQDNrlKH3V
	ytna
X-Received: by 2002:a17:903:4b08:b0:2ca:6bf:5bac with SMTP id d9443c01a7336-2ddb13465cfmr4177465ad.8.1789700388427;
        Thu, 17 Sep 2026 19:59:48 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55412d51sm555950a91.2.2026.09.17.19.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:59:47 -0700 (PDT)
Date: Fri, 18 Sep 2026 02:59:43 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <aqyW3RzBGQyZebsG@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
 <apBso6So7UqwR3AX@google.com>
 <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>
 <20260828143546.GC3769797@ziepe.ca>
 <apGpHv8vy4SWIEaV@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <apGpHv8vy4SWIEaV@google.com>

On Fri, Aug 28, 2026 at 04:15:56PM +0000, Samiullah Khawaja wrote:
>On Fri, Aug 28, 2026 at 11:35:46AM -0300, Jason Gunthorpe wrote:
>>On Fri, Aug 28, 2026 at 09:55:18AM +0800, Baolu Lu wrote:
>>>That looks reasonable to me. I have no concerns about keeping ATS
>>>enabled on preserved devices across kexec reboot, as long as the
>>>software state is synchronized in the new kernel.
>>
>>The new kernel should issue an ATC flush when it changes away from the
>>inherented domain.
>
>Yes, I will make sure this happens when we do the retrieval side. It
>should mostly work well with the existing replace machinery.
>>
>>>By the way, is disabling ATS an option?
>>
>>No, many devices require ATS.
>
>Agreed on the ATS requirement. I had Nicolin's patch series for CXL
>devices in mind here.

Having implemented this now, I am thinking about this again with respect
to the scope of this series. To limit the scope of this series I am
going to refuse preservation of devices that have ATS enabled. Once the
base preservation logic goes in, I can add a separate series on top of
it to add that support.

The ATS adoption would need new helpers in the PCI core, handling of the
ATS state in the context entries, and the disable-to-enable,
enable-to-disable and STU mismatch for a live device. That is worth its
own review rather than part of an already large series.

This essentially means that preservation is supported if pci=noats is
used, since by default ATS is enabled if the device supports it.

Thanks,
Sami

