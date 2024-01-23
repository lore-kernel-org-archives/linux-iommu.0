Received: from smtp2.tecnico.ulisboa.pt (smtp2.tecnico.ulisboa.pt [193.136.128.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8E7FBB5;
	Tue, 23 Jan 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035492; cv=none; b=AXfwBfCT+MmEko6kaJ0iJsgqlNYYrMlg8ui9xHf/MM1lTFVJ3LE9XLm0YfeLgX5EzK9T+/izsrOv60I9OGpz9DczXJXfefjCNmNg/Te9LPCnMQlQIOwW5iouiM8zftCIZeEHItrCeSFajnGNoleYXUg/AVXxWnaJGHLfVuosxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035492; c=relaxed/simple;
	bh=1GQUsvqnD7ki3+q+Mte4ST6dHAMYoyOeCXJ4KSZA/IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2UQcQL+dHgEo779NDzYdlNafGTZ/eQ6fCU7YdhNJxGZNz18xWsEWN5schzgYzD5HL9Qdf50/f8yj3JYQQmXxGBd15s+1UWgkAc8XoOuUVIenmqSkN2KzJp2ro+CMUa0CytR6PB/LUoETuN9MRhE0OQsyC+e58F/W/ZbMeUtF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=IcvNrLTf; arc=none smtp.client-ip=193.136.128.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="IcvNrLTf"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTP id 27B5B2454AD;
	Tue, 23 Jan 2024 18:44:47 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp2.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp2.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id KaZPH6XeHymn; Tue, 23 Jan 2024 18:44:44 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp2.tecnico.ulisboa.pt (Postfix) with ESMTPS id 44DC024546D;
	Tue, 23 Jan 2024 18:44:44 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1706035484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=av4xgo/FzhL82OIN/3Jo0uMARulxHMhiAFEqBnLnyD8=;
	b=IcvNrLTfYzTStmDeWDPj6nrwFeNkBKfqyqOR/fZH9PL97AB62mImdHGw/f6WKSSxThN7tf
	WghnsRbOvMcfy+vN24BSBspHo99k3OuTdijaK6TXlMEAfQrio2fjcQBAN6KuDJ7rphRpUq
	/XvxDxpzZG1KtFQqTmnb3eRcmb5pZ7M=
Received: from [IPV6:2001:8a0:7ae3:e700:a921:1147:531c:b1e7] (unknown [IPv6:2001:8a0:7ae3:e700:a921:1147:531c:b1e7])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id D917136007B;
	Tue, 23 Jan 2024 18:44:42 +0000 (WET)
Message-ID: <1754c86c-704e-4c80-93c3-1b75a9a247df@tecnico.ulisboa.pt>
Date: Tue, 23 Jan 2024 18:44:42 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com,
 baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
 linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
 regressions@lists.linux.dev
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <20240123151508.GR50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/23/24 15:15, Jason Gunthorpe wrote:
> On Tue, Jan 23, 2024 at 02:33:15PM +0000, diogo.ivo@tecnico.ulisboa.pt wrote:
>> Commit c8cc2655cc6c in the recent IOMMU changes breaks Tegra fbdev
>> at least on the Pixel C with the following error message reporting
>> a failed buffer allocation:
>>
>> [    1.857660] drm drm: failed to allocate buffer of size 18432000
>>
>> This error message is printed from tegra_bo_alloc() which is called by
>> tegra_bo_create() in tegra_fbdev_probe(), which may indicate that other
>> allocations would fail as well, not just the framebuffer.
> Presumably this is because iommu_map_sgtable() under
> tegra_bo_iommu_map() fails?
>
> Which I suspect is because of the logic in
> host1x_client_iommu_attach().
>
> After c8cc2655cc6c iommu_get_domain_for_dev() will never return NULL.
>
> So this:
>
> 	if (domain && domain != tegra->domain)
> 		return 0;
>
> Will happen and the domain will be left at IDENTITY, while I suppose
> the tegra_bo_iommu_map() assumes the domain was switched to tegra->domain.
>
> Does this solve your issue?
>
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index ff36171c8fb700..15c7910b2e1c76 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -960,7 +960,7 @@ int host1x_client_iommu_attach(struct host1x_client *client)
>           * not the shared IOMMU domain, don't try to attach it to a different
>           * domain. This allows using the IOMMU-backed DMA API.
>           */
> -       if (domain && domain != tegra->domain)
> +       if (domain && domain->type != IOMMU_DOMAIN_IDENTITY && domain != tegra->domain)
>                  return 0;
>   
>          if (tegra->domain) {
>
>> This may be connected with an error in of_iommu_configure() that
>> became visible after commit 6ff6e184f1f4d:
>>
>> [    1.200004] host1x drm: iommu configuration for device failed with -ENOENT
> Hmmm
>
> This is a new logging, so it doesn't necessarily mean something has
> changed in the code flow.
>
> It seems the issue is something in there is returning ENOENT when it
> probably should be ENODEV, but I haven't been able to guess where it
> comes from.
>
> Can you do some tracing and figure out where under
> of_iommu_configure() this ENOENT return code is from?
>
> Jason

Yes, this does fix the issue!

As for the -ENOENT I will do the tracing and get back with the results.


Thank you for your time,

Diogo

