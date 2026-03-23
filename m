Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386453B2FF1
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274622; cv=none; b=L/hMQXfdhFeWpOCQlTPg2Tk0eo33rAMyG82hI2FaoeoJ/aKZ4k3qX0oNPNqJAHeREXmO61gD0yxRPkIPSUd4+XnJhi0HzElvp3zm1/tQY9JZAR/ujlgQ5Gs8fEFE0+pTo2zQSDpOmHZOjSCqElv0X49gcYma1VVvabu9N65rT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274622; c=relaxed/simple;
	bh=+8e7Mg0HqnH60zkD62yuOYrS4xcoRBXsctMqa484QyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGMAeOJvsM+p7kkPkC4Ta9Y6Gamm/sFyOlzVuUq0cg3TYiJZ/6qgaoaseihx/kgxNupI6XA5yGSW7wVTKIYHh9Ez6Toqd/Ui+kAd3fyb8VQNghRFQlcmcF+oXXYw44U0PVVg5GWLG6tOnlOUNur2YvEbKGur7oS2oeUbFqJp10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNuPcMcn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNuPcMcn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774274620;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmvoSlI6zhEDXgvnhN85AXx/F1wuELhxcozcM5H9OTc=;
	b=gNuPcMcn6B+awu2yUConfjfyprRynsz99muhxqPLDQ/icwqY0zIGWpaXSitsO7jCEr8o+X
	6MV1JB+vzcI1pQfszGxp51uKlxyy5mRp7fgJ+dvRzvpeO0g21m7SAIrBJbrltTGbsuPIzB
	fO0oUEoM+ElZ5i/S4zzwzB7nPxTvoJE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-UcA7K9NCP1Ch22uv04LU6g-1; Mon, 23 Mar 2026 10:03:36 -0400
X-MC-Unique: UcA7K9NCP1Ch22uv04LU6g-1
X-Mimecast-MFC-AGG-ID: UcA7K9NCP1Ch22uv04LU6g_1774274615
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b3a675316so159199f8f.0
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 07:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774274615; x=1774879415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmvoSlI6zhEDXgvnhN85AXx/F1wuELhxcozcM5H9OTc=;
        b=e4uWV2nnvn6OOpJUnwWwLqnI6bQP4YN0XlcZkBGBgohS1PH96zr3HnXaOj3o9CsbxH
         Sf/q3itJLRCgYxZT/F1mO4PcuT/tb3EvNgBtZIJAVWZBu1iKUOyC2ZrY7LbPEasECLjx
         hkfsDYTKoEs+RjhidTnT91dI5udxAjywTbf7WBiY87IPy9SoXoeg/oGHJ80iFy5V5DmK
         WlOipCTITWNbSeFPLG5j0ROsb2AJ6WMxeL/fC9PCRJM/ACgpmQsb5tPpYO5eV34dhU65
         i+O5gxDpK56Avd3dWzCrim0t2UJiXja2azy6hIeCVVyjcoYuapuvI+tR1Ar22KSdY1V3
         ZPCA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ylXg2TsCGHmRhiBdvb/kUbFdUOQWJsyJII+R6WQGVXuMesFVcB1ELrLsBHFKnqxBy7omRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRHexuVn/GmHoylKe5PnTgxbykJU9mc/FHf4QTapOZqKlbjcXC
	ZoSK11PwB1NxzHeGFG2muEmQwdIBrpcGhaMirQvs8WnOm1uT46nnjar5dVXGAObAkoOzoCgqxel
	/jKJxtayG9kJkzgiPmT2flbcb5AYGNGVbOJulmqi/jpz6KwBYY+eB6e2D
X-Gm-Gg: ATEYQzxJ/eCrXWrVzBef6DjTHeNmmc3zaUcHr9FYMIouy5F61Eb45DWxULOYFBqcrkK
	l5K9ooEI8D5E2hHPjLiDZXWDgf27VaS5O8UZvRcxGa+s7p9vVcyEh2Gfpx6aRAAthgFlFpnKi/e
	1LSNeULrifJo3VaHSpYrLfcw9kI+3rD+8fcavb1lqqPJ5vYFq8mrd8+2NvDIatNMizMmaWWPsmn
	jZragdnCpwxD3Gg7Io59OFXwv9wdzPT1JwMB014Ta4itoF7jSQYkULKl3TKRGy0pjK5VxXw0tGJ
	f+P7DgCrGPjTHsVCFVFpQkfqBYp7rTWonUuLqThm5rhRt0ZQlQwsMB7ACdoUQ/S/YiOOESKZZ7L
	j6I9wOEzIMX4fdYObAgmSSiB/B84+UL2KAxAo39V8KCYa65gaIwpmWTUj3ItGz3d7sgp9yQ==
X-Received: by 2002:a05:6000:26c4:b0:43b:4aba:8f35 with SMTP id ffacd0b85a97d-43b6424e48bmr18732371f8f.12.1774274614972;
        Mon, 23 Mar 2026 07:03:34 -0700 (PDT)
X-Received: by 2002:a05:6000:26c4:b0:43b:4aba:8f35 with SMTP id ffacd0b85a97d-43b6424e48bmr18732291f8f.12.1774274614356;
        Mon, 23 Mar 2026 07:03:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c27sm29923424f8f.18.2026.03.23.07.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:03:33 -0700 (PDT)
Message-ID: <a3e212d4-78c6-49d0-982a-2baf9b0ddfd7@redhat.com>
Date: Mon, 23 Mar 2026 15:03:32 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 2/2] iommu/tegra241-cmdqv: Update uAPI to clarify HYP_OWN
 requirement
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, jgg@nvidia.com, kevin.tian@intel.com
Cc: joro@8bytes.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, skolothumtho@nvidia.com
References: <cover.1773361875.git.nicolinc@nvidia.com>
 <9ef47d0db2d7b8207fef1ef4437de6efa08565b6.1773361875.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9ef47d0db2d7b8207fef1ef4437de6efa08565b6.1773361875.git.nicolinc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uuXszixwlaTXsJAeOaaIRVqVBaayFTVYvZodBs-rBnI_1774274615
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/26 1:36 AM, Nicolin Chen wrote:
> From hardware implementation perspective, a guest tegra241-cmdqv hardware
> is different than the host hardware:
>  - Host HW is backed by a VINTF (HYP_OWN=1)
>  - Guest HW is backed by a VINTF (HYP_OWN=0)
>
> The kernel driver has an implementation requirement of the HYP_OWN bit in
> the VM. So, VMM must follow that to allow the same copy of Linux to work.
>
> Add this requirement to the uAPI, which is currently missing.
>
> Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/uapi/linux/iommufd.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 1dafbc552d37d..f63edbe71d542 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -1052,6 +1052,11 @@ struct iommu_fault_alloc {
>  enum iommu_viommu_type {
>  	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
>  	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
> +	/*
> +	 * TEGRA241_CMDQV requirements (otherwise, VCMDQs will not work)
> +	 * - Kernel will allocate a VINTF (HYP_OWN=0) to back this VIOMMU. So,
> +	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
> +	 */
>  	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
>  };
>  

