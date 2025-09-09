Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0923F405
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 04:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391428; cv=none; b=P+piIPGj7jUFJwNLN3Hq1w8AlSyMmAoes7ZJwCyhos5jfwEF7jhdIhVsoN0xoGXa5y5+x8y4hH8K07Rvz+XijKbanAJH6EyzMMA/Z7oMsCxRdF2Cdf4yi2EuhEZXptPVpEDks/kFSgY35D2284A4RjMv+BRkxMuMg3KfmZ3oXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391428; c=relaxed/simple;
	bh=Vrtl+xs7K4zXcPnLFH1TuZOu/V+27YNQSOap/9QG3ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDtx59q3HJZE8v82WWgAG0AMSW7IUfQW5SMnQU3nzX1z2rfcNZzTR5cmTFdg5KuTyEyQUQd3bXvIgZMAj5GQ8JOGgug5NMUXKBQvzXVpvt1p3kWwy0a+2g02ixWfjnUe7hGQ+rP5sU1qEBEZEq/d68drHY/QJn+iF2JULERh4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEc5uPgg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEc5uPgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757391426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXc4wYDZmZ/L8uZekYzqBJVvEmMbocn1KotryOo59zE=;
	b=eEc5uPggOD6/59DmF2ZsHdnbRwQ5IPgvHR1IXLd7ueXxKoYrFYy58BA9PaNqxfSWBvrMOG
	NnHov812/ai2aJ1ufgUx7DXmKETENVrZqqDDxYSaA/tp+Z2+a1YCXsiTGGhPJgcJUqqJ8R
	JOsvdx/KFfautmWJc97PVn+/FPTMzCc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-oqC5GSvkNHiEkRGNFtRCZA-1; Tue, 09 Sep 2025 00:17:02 -0400
X-MC-Unique: oqC5GSvkNHiEkRGNFtRCZA-1
X-Mimecast-MFC-AGG-ID: oqC5GSvkNHiEkRGNFtRCZA_1757391422
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f91cdf14so131994781cf.0
        for <iommu@lists.linux.dev>; Mon, 08 Sep 2025 21:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391422; x=1757996222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXc4wYDZmZ/L8uZekYzqBJVvEmMbocn1KotryOo59zE=;
        b=mH8GZwpOVh4pF2JphWUUt0saIAgxDssDTL5yYPn06gYHyn+lPxTsvrYouIzx/RaZOb
         Zf9lazZ8P/VCjasK/0OWTqftN8kcmlinfZO9TRmC597MxaXgueFgS0iKVvHN0EibPybN
         9lpmxKW+/dL9yPSYZu3g2PBdY6jCLUJORI2fHSZYNbf5XWYorZWO+OBangY1tMlV92+T
         oulVa2QlKsU7FfkyBirdvq0btGLppHqTQWUfiDqc1mG+36suE5d+ZlORq73zLjMv1yJU
         fxGOACtsy95+Tac7YN8v6/IdfsLBgf0OcQUMjpBEBmEt7PLF4dUXbdiMtkYKZNS+ctvX
         SAow==
X-Forwarded-Encrypted: i=1; AJvYcCVv7re9nTkawkwRpNEIHXbZm6tvnvrcFZzB/92+H3M7yDf0+TBb/87D2KGkM2jpK4VuntZs6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnN8sh50X1BYnf6f+eIR4Rmt25bmy7pQbNikbMo7pH1Rfgg6IX
	GZ7fizIXgddFE+Ymn2+yL0CthdJbKGm8w6SaKLfDUj59stN1u5fsc79t5EbDVPKJzPQIjpn+9xy
	TMlKnyeCSKBSk4vAhVmFc2FWiTIw2A3/crpGKDIxsjfr2mNcIyt1EkFod
X-Gm-Gg: ASbGncv63gCxoYQi9dBRODhUx/rIRFRDMrGFOoE4opDpAlfkg79omjymc1jjKZRDGBA
	p7zMIKbAzrouFWUOAdaTbMBFdEBKwBI/0ftdDUAJmneK2VtZrMBH7w1z8Beyk74v1xFD+xfNolX
	1CWlWVOERRYF9OI6oy3Ock4LJDn51OZ4NkDcC0TraUOdIv8oN9rALSUES6hEx6cNP27x8eot73Z
	LceO3UQdsuGNhqf4sNNritE5Ov1xNrCd3WUeCL56+3LC7jjS2d1OQAJfspv6M8ubzM7YfYZDkYs
	VNzSu6wwfQU3tJGjw/iRMvqR3NjGylF85wcZ9ym1
X-Received: by 2002:ac8:7f56:0:b0:4b2:fcf4:44c9 with SMTP id d75a77b69052e-4b5f846701amr118252431cf.60.1757391422217;
        Mon, 08 Sep 2025 21:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlZTe8MK04WhNv9/TediecLNUlQjS4uZJ6D+gPH8b1KU0M6GQFQ+qYugLVX8lKpMw4F3h/7g==
X-Received: by 2002:ac8:7f56:0:b0:4b2:fcf4:44c9 with SMTP id d75a77b69052e-4b5f846701amr118252291cf.60.1757391421878;
        Mon, 08 Sep 2025 21:17:01 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-728a860bdebsm100439826d6.69.2025.09.08.21.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 21:17:01 -0700 (PDT)
Message-ID: <d89d3606-a464-443a-891c-637f304127d5@redhat.com>
Date: Tue, 9 Sep 2025 00:16:59 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] iommu: Organize iommu_group by member size
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <4-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <4-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hAyTvKLjX7i3-4RjV06J91J6bouZftcujrL8Sb45yp8_1757391422
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
> To avoid some internal padding.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1874bbdc73b75e..543d6347c0e5e3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -58,13 +58,13 @@ struct iommu_group {
>   	void *iommu_data;
>   	void (*iommu_data_release)(void *iommu_data);
>   	char *name;
> -	int id;
>   	struct iommu_domain *default_domain;
>   	struct iommu_domain *blocking_domain;
>   	struct iommu_domain *domain;
>   	struct list_head entry;
> -	unsigned int owner_cnt;
>   	void *owner;
> +	unsigned int owner_cnt;
> +	int id;
>   
>   	/* Used by the device_group() callbacks */
>   	u32 bus_data;

ok, but still leaves a 32-bit hole at the end, which would occur in the struct if bus_data was put after id or owner_cnt.

Reviewed-by: Donald Dutile <ddutile@redhat.com>

