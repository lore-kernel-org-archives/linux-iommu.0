Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57F20B814
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602382; cv=none; b=BQd8xr2VfC8xsyy+IljZCIJ+XXg+4rhKfqnVWcRvOe485Jhd1vwfG26x/iKb6kRJhGKbIr4FL6N6vDi+M4AXQSXPo/KyL+s4iQeyH8Kd/3/i7SwB7PxlLCJA65HJ9+ZnX0opkhCY8eugUs3/eGSeAF6L+cfb/IBG7cQt7e8T9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602382; c=relaxed/simple;
	bh=OoY0Jqmx53z2/JPowGHa76X7V+6+EmclWVr7Gf83+ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdRIa7SOjy0zR3DCjfEC0BjwvHx58YPb6gkhnSaB7p3hkKZmIM0K/BwE7+OzNQqwVaYwaSSVJ4LZfkwPKk7fmldUFbqn3wBUuS0TOEU0sF88JortN1J7CHnwE1I6wYC3SU/7GMl6EV49Eqj2trvIDDWjh9H0pADX/L6qEsnBEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l3yBKBne; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l3yBKBne"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6e8814842so473838585a.0
        for <iommu@lists.linux.dev>; Mon, 03 Feb 2025 09:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738602379; x=1739207179; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vuZWIvTMSblyfqLMdc5xTbKGrB3oNMPelT8jaZlHlBk=;
        b=l3yBKBne0cogpGQYudy/V8/M1vpVWA/wUlQruLtWHzZDjf+0aL0+9kj42jtosxoEE3
         se+BY9H7Tkn9UtFevNx5UYk4xT5DeHiE4zrRoh5f9OyiToM8Vs14CJpF2gkMzfHIiDCl
         Y/S4q2GB/Rt6lZp05VVF+ozcnMq1B4kWCXPhKq8lS3/eWyrhgqOlmPf4vkfNnxvEagAi
         eQj4/4JsqnKkkjhm8GQHiNPB5AITlmvjZgG7TOfcdYf5n7Ca2wVsG+Yd10gEmtFUcOMA
         S3wqfWqdTo33dxWqPvKKo+F4hOTaNSM3xqTiz2743xEYJ/BcE7XROPfn0/pmGIYVoj1K
         MUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602379; x=1739207179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuZWIvTMSblyfqLMdc5xTbKGrB3oNMPelT8jaZlHlBk=;
        b=IVG34A2l64kCGkW64nmUsnGgcanfiI4YcU5mq4hUtkKn0emyFKOvmkuiBQkN/A318u
         EzOhXvPLnq++50npugT8lStmUqiADBSj5koQrzH0L1+BfKcFt8SvFScYYiMLV5xoUzcj
         fJOUn7OCTk41P36MPcD5BPqoYfFSETavO3UOmiAVlzgiaZjXQ//TSMR2f9c1PdxUUkXT
         eeFZUnsY5H3FFZwKspaoIBFukkQrJccZJ2LDXeSU112La2XT8o5ALzf0HgGszyj/gcZV
         Ueu692Tha28irF3yQ5iNFiqy+dGAtclttGyvcYPhl0EWwIxaYJ3cijQjAcCAPresbGNs
         YU0g==
X-Forwarded-Encrypted: i=1; AJvYcCWwakSoCMhjtcxQpMPmCj/zea7P9VnVOcCZNWprELbHpJcFUYkWC6hhA4r1ch2uDY1hmijEAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxt8Z8YMUKVpmVNicr8BTGGNoH8QN1DvUtcTG4gC9mCsdf8BQJF
	TAhhrj3DMCBkCQas21wtsJN8xAi92y/wEPmss/gv2yjhctVEQMWOUGjHYXZ5JEk=
X-Gm-Gg: ASbGnctuIe7f2D9Q1t/KPsZc39EJKmMzsOIEGi8+39T0D2cDmGitktENjHaCnXjc/Hs
	ZpM0HcuwayXuDOz4K8gpVpxrcRGAkuMgjADQuzuU7aMMmXJ2oeFBanwxPbJjhxsQJfVu2Muzd6u
	gLyI20mRNfQK+FrAE0uJqrq48ZDa2iHBR4tVqWdaNZuyTBb9Pq8hkv1xGrfdrlyngVTx/al7spi
	8DnkDS8nF+pmWJ6M1SQHuxrqU9JGR0XIGC+6L2RHXrpNIe1AQKci6O32qn135wNckvXk/Y0nM5P
	4jRWrARee2vUxg4Zx8K1Mjm5hPVwwGBIWvJszngOKsu7oRgGDMRkDsi/Cs26471c
X-Google-Smtp-Source: AGHT+IHtkWAUnkfVOKNEiqf19ccBm1Q+QVdFtpLSmy/QlTYdKKUNZLguQC7dP7RffulvHSXZ4Pw1WA==
X-Received: by 2002:a05:620a:190f:b0:7b6:de8e:da27 with SMTP id af79cd13be357-7bffcd73612mr2894890985a.44.1738602378723;
        Mon, 03 Feb 2025 09:06:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bba69sm549451085a.8.2025.02.03.09.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:06:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1teztp-0000000BDBO-2UbK;
	Mon, 03 Feb 2025 13:06:17 -0400
Date: Mon, 3 Feb 2025 13:06:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com,
	baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
	regressions@lists.linux.dev, linux-tegra@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [REGRESSION] Invalid gather when using Tegra210 media engines
Message-ID: <20250203170617.GE2296753@ziepe.ca>
References: <c6a6f114-3acd-4d56-a13b-b88978e927dc@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a6f114-3acd-4d56-a13b-b88978e927dc@tecnico.ulisboa.pt>

On Mon, Feb 03, 2025 at 02:55:12PM +0000, Diogo Ivo wrote:
> Hello,
> 
> Commit c8cc2655cc6c introduced a regression when trying to use the media
> accelerators present on the Tegra X1 SoC.
> 
> I came across this regression when testing the branch [1] that leverages
> the NVJPG engine in the Tegra X1 for decoding a JPEG file. After commit
> c8cc2655cc6c we see the following error messages after submitting a job
> through the TEGRA_CHANNEL_SUBMIT IOCTL:
> 
> [   46.879757] tegra-nvjpg 54380000.nvjpg: invalid gather for push buffer
> 0x0000000108f08000

What driver is this? The message comes from 
   drivers/gpu/host1x/hw/channel_hw.c

But what driver is 'tegra-nvjpg' that is bound to 54380000.nvjpg ?

Is it the stuff in 
 drivers/gpu/drm/nouveau/nvkm/engine/nvjpg/

I don't see "tegra-nvjpg" in the kernel?

Can you share where the failing command was sent to the device?

> Please let me know if you need more information on my side and I'll be
> happy to provide it.

It is still ARM64 & CONFIG_ARM_DMA_USE_IOMMU=n

?

I'm guessing it is the same basic issue as fae6e669cdc5 ("drm/tegra:
Do not assume that a NULL domain means no DMA IOMMU"), except in the
host1x not DRM code. It looks to me like the same pattern was copied
there.

How about this:

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index be2ad7203d7b96..090b1fc97a7309 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -361,6 +361,10 @@ static bool host1x_wants_iommu(struct host1x *host1x)
 	return true;
 }
 
+/*
+ * Returns ERR_PTR on failure, NULL if the translation is IDENTITY, otherwise a
+ * valid paging domain.
+ */
 static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(host->dev);
@@ -385,6 +389,8 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 	 * Similarly, if host1x is already attached to an IOMMU (via the DMA
 	 * API), don't try to attach again.
 	 */
+	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
+		domain = NULL;
 	if (!host1x_wants_iommu(host) || domain)
 		return domain;
 

(if not can you investigate this function's flow compared to a good
kernel?)

Jason
