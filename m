Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0B3806DC
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021491; cv=none; b=PeVHcvWsx7kPYE4onxhODftyRydc6GpQRQWTqsE7iFTB3xtJUSnGVKWuSFDx/N/GhxJY6z6QgKKIYWqDAzReiWvH9GqPS82FUJVfSY8BJxUYYk/+CNeyzR0w/kRCc7bbuH7Pqiq3nXXYXztv5PtSKQnlhsxVHAcZ6VaI/56+buk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021491; c=relaxed/simple;
	bh=PavTPaSl7E4nl9f4cmxZDgR2MPv8hxGhKaAc6xi59I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwUvz67KRioHcM/x48fZwwTT01WVHxNVYPepQQsHLa1RRWE2kWj6XazNfDdErexZOmEzd8fxrayl+x82v2Bt4wQzjV+JHIMGZ9EJASbXc0fo0p7D3UyWlh1guqj0KRZMzfbY55dUzlw69cr7xetTTeCy6qptZ0G72857tFD66u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEFLEu4A; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEFLEu4A"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-485888b3c3dso6698515f8f.2
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789021488; x=1789626288; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GwOPl6TUJvjurtx0SFT9PFDoGeN1jMxDAChV6NjVqrM=;
        b=FEFLEu4Aorc4489zMoFInxdyNlEaFFpWPiU6uzUCd7qB38rhREft3I+KEboTE24ywV
         V3m7ugDdFUN1tsSQ3EO+xFBg1gk/qmA+4Y6jbk9pfslC0MRcKZ25EXbagNhE2b10oIb5
         p4IhJ0JwG68BgT2sa4clG1sBqCLQwLmYbFqTIbxilt6rgjgsWH2Os6JQPtfU8ssP4MI/
         QzGL8y79WxPIjFgpgbx8DcuOTZC/FzTT33334xm1lOBsnbO16nx2pDu0Z2374VNmEN7R
         bnfoP+9VFgKXXZAALitQVXh+JrBsihG9U8c4JG3BzTHctLvL0YlNi1v6cxPRVq+UcDVm
         zWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021488; x=1789626288;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwOPl6TUJvjurtx0SFT9PFDoGeN1jMxDAChV6NjVqrM=;
        b=Uedni+n+ElLlcbY6qtnE4ckfGmov/SEoqeIzPrdqBVVvwuF2ARqt4RwhIQJqFdnlel
         NVFkl6kui7HFDciSuBbEc5veI/fqhGb1ntgKtOvXt6TZEO1P883gKL2oPQ7w5p9KoPrk
         hwZglYrQVyAmEPQnLz7ymeAEaQiDQuMh6Wnz3i4dq9M8Cy00L4ZpE7DJOC6DFmShesaN
         0857mq6ys1+Vu9z2uw9le2QBRwMjjt98okyhDkAKoir4BDhnyblKBvQDNrJU29aVgt9H
         zEhgwAuFkIzAHUucoYKx+97PJ27xVSGsUnuo/B6xE49RV/ob+0POHUhiQZyQcfF7dghs
         FVYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzas1CJUNCdAK2KvF2q41hh5IGKVin5CxFflBQgpBsvjqFh1S8E35jfnqqx2bcn7qhmcjwsaQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lvB6CG/E3TrbeqjcXTCk7bhNnicmfBHd5Eh6KzqcUwXeFBSfty
	fZwnrZk1o7SOVvYaYR7d2pBBA9hHhDGu0bQqP9hbTMy2OUX1pv0e3PAG
X-Gm-Gg: AYBFou3mbA/qFEzhPu7sQ5AeM9n8IqWaUGYQSSJMNSXKNXBpAC9xxn1uwbMUX7l3rGf
	6WKf+ix6JBCTJQ67T8jZhPE4UK6OQcLfHJyQX4F2Eu74p59fOBVGLBQAsizc4AQO7Hbs1n3pqhD
	rvprVluTO3ZhoKR5y8T8pQqhJADOle4ownMY8AsI6IBUWnHwkyKyClMpkDebklzH3E4FgJp+lIf
	3nzXJa7OU/8+6vZxtFuilu34m0Lo9wvzpgmEWvIMguaRJA+HliZdZ9hr9oX8XFU81VWrlkJaumA
	3DfMIWo5S7MeewHZ9f6fcztFhMW+t3oTXSXCfMeJVekIbkf530/8znbapttoxkYhXPBs4j8DqDe
	PhILcTETIZdsN/lmtO9URxNC/mEMYrg6/3dpZtFJdbvII2Lr5uJo8Dq0G0EeCjvCpUSBH5xN0ax
	VpMM6QUdVv251UBQnvjF8WGPuQeh5ztgkhY6j071jfTfI6q94yEhbw773nl4gs7GqvCefEb0yKt
	71S+iebFz8WEO4PL8XfsVPNtzW1cHQY+ZFqYDXa/VolAR04MXa6wLK9vGmOAmoRvwYSPHulWV4e
	zlLrdTJAC2dO+Z0RziD0eF5gjpi4ryxiXxOLUR51WnWoVAkcB01vyzMmoYh5arNfofMiS1I5g/X
	9UfEJjpAJiIYa
X-Received: by 2002:a05:6000:310d:b0:486:e24f:335a with SMTP id ffacd0b85a97d-486e24f39e9mr2649724f8f.21.1789021488301;
        Wed, 09 Sep 2026 23:24:48 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b3d9-b901-0402-5aad-0ef4-88ac.310.pool.telefonica.de. [2a02:3100:b3d9:b901:402:5aad:ef4:88ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm53896552f8f.25.2026.09.09.23.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:24:47 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:24:45 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, 
	Nicolas Pitre <npitre@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dma-mapping: split cache maintenance at highmem
 boundary
Message-ID: <aqJJ5fQ60Nm6xf5G@gmail.com>
References: <20260909064443.90544-1-kmehltretter@gmail.com>
 <ff220a24-edae-4b75-9873-1a58f5948a01@app.fastmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff220a24-edae-4b75-9873-1a58f5948a01@app.fastmail.com>

On Wed, Sep 09, 2026 at 09:24:23AM +0100, Arnd Bergmann wrote:
> I can see how the fix addresses the problem, but I don't yet see
> how you can arrive in this situation. What type of memory allocation
> can produce a physically contiguous page range from multiple
> zones?
> 

Hi Arnd,

You're right that a buddy allocation cannot span zones. I found this issue
during code review while investigating another ARM DMA issue. I plan to
post a patch for that soon.

My Pi test deliberately reserved the last lowmem and first highmem pages
in DT. It confirms the crash with a crossing SG entry, but I have not
found an ordinary workload that creates one. I should have made that
clear in the changelog.

In a follow-up QEMU test, sg_alloc_table_from_pages() merged the reserved
pair into one 8192-byte entry. It checks that the pages are physically
adjacent but does not check page_zone().

I also searched a bit for a real-world example. Rockchip's vendor 4.4
boot-logo code looks like a possible case: it builds an SG table from
firmware-reserved pages and calls dma_map_sg() when no display IOMMU is
used. Product logs show the boot-logo feature in use, but I found no
record of its reserved memory crossing the lowmem/highmem boundary.
Such a crossing seems unlikely.

I still think the change is worthwhile. For v2, I will update the
changelog to make the test setup and its limits clear. I may also drop the
Cc: stable tag.

Thanks,
Karl
