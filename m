Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094684A2B
	for <iommu@lists.linux.dev>; Fri,  2 May 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198939; cv=none; b=Q40fpn9uxSF+k8SgbZfFBRIFURDSZQQ2LQysD7tx9Kya8JzD4FI9ce/1MVbCTkqavZwd1u+UJNmsx/i3jMpAMNXhDdwIEZswThxrxtJvgFYFzX8RdKtuXaj6ydaLWGfy6JqLbeHdMtM0QqILzHRmI5NM7CwtsOANlgllx+ukc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198939; c=relaxed/simple;
	bh=mFj7rvx9G8v9+EiYk7/06RcBARNZQP3y2G/mp7J7IAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZHX4gFRG2VL9vLe1oz+8bbUe0iV2dO+sJJuvTDD5fVxXj4Ql+AosgSpeWzHX+Wogp59ZXizugM2aR23WWvFIqYQLnVTBlxLT5giFnCm8MQgXjwayhMsYGMjDvcUNPe6wJSYml5e+Tk2y9JTw6qoI14wMwaMnx0rCDOfB5Wa5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rPEnPnC1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPEnPnC1"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a07a7b517dso1272681f8f.3
        for <iommu@lists.linux.dev>; Fri, 02 May 2025 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746198935; x=1746803735; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujk1BtnXfFfRVWSou7qNXAW7jGu5GKXlOG/QH1lknbc=;
        b=rPEnPnC15GgHa+dIMKJWp1RxyDBJP2Mre9i9nCpMyPCQ7nUSMcUytR9MLEYWsrCoq9
         /QghEG5fWkByBWWOac25ESTKyNW0lfvW7wIiYBbHB7GknrkTV31uh2yWhMkeAve7fD4p
         ejIT/vLOwp1yfipVnNamajskH+Awc4yK6OKxsyrlaV62qANfw1zLpDgK0tF8ape6xDNW
         ZU3B4MEcz788Y/ovVIRayO8+E5awbVkBC/uvMreTc6UUTOFuNkjdeSJC9+9K0lr2m1cd
         5EYgrmQNfJMHhbf17Q9TrSEDPpqOrE3s5IqU5HmJNavG1m84l6HWiZsVOebQyGcaVPiP
         nf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198935; x=1746803735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujk1BtnXfFfRVWSou7qNXAW7jGu5GKXlOG/QH1lknbc=;
        b=ANxS2JcMYmK4sRBGs5eMYu8Mu7uGAt3lqY0dhcp1Ie9dYBtgw/BMvec/qBibwEaiQM
         DzcPtdJzxYzWyOCB+XsnDEb7scWZuH9gjdiHQEHLr2I/4fQXD2ugmR2236G/KgzrlKon
         6QrXPP7Hwadiy6U4FBUA5p42iLg3o1e1x7wnN0lKRfxrraJi8HrnchEayoZ4Ue6JFnuG
         OlUtqxqvvA1XPxFyXetKt3Lmr6FNW74Cj0V1asfzVj9WpF7k0BVmkInaXdUHhL0AcRIf
         312I7VrNSeC4JkH2NNeTwo/b5ukbDcAnuF3Game8EZkWdRP/6VXuYcvLbzeQT4ddiy7c
         +nLA==
X-Forwarded-Encrypted: i=1; AJvYcCWGzGH9LdPKcyuiYbqRoRuP9Q6S2/KO5t42XiStapJ+w6pDBuFoqAeE9f34U6p9Ha6qlik0LQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSihZlPk2EHqtZHGX3g8VQhBegSbWsZZ8HNsmPol4Es/mpFNfo
	/GVnP0p4gY+yYhURjlVLfJREvnDzAnDY+i3gk6jyfXX5mvIxE/GtxcJTV9h4Hu0=
X-Gm-Gg: ASbGnctIH3WnDFQEXZsjvSDWkvdyKsqv2tiIJF49T4+oh42ugdExosSl7CNZr72VGcj
	L4im0t4878nHXj9v9qztG1jBPbL8gQvwkQjjf7LQaeO6lg1hRI6iib4foy7WIsZy7H5O5vcJaCJ
	1s/BNGhV5EuvpKOeDxLv/q386j4kU2yf/uWWSK5qtdsEBCc+6rmUMC2kbNt+UpfLKw8Fz+lBQnC
	Y94i45BITch3Xkv2Tj7SqIQvYwoYk61ywUC4HP7ceog8Nq4V2DKddvnar6p2YukpBe2iG5MYGHC
	VcOrilj+wYq0z3LL1OzHk+tgVXmQXuJV3xxRkCE=
X-Google-Smtp-Source: AGHT+IFldPkZpv2kJ63m7xgTDZKmiC0tyADxjEV7SCj8JMUwdDjNdLorP+ADGNPiJpOiUHA/i9w22A==
X-Received: by 2002:a5d:5887:0:b0:3a0:870d:3152 with SMTP id ffacd0b85a97d-3a099add459mr2742549f8f.33.1746198935589;
        Fri, 02 May 2025 08:15:35 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0d15sm2456737f8f.13.2025.05.02.08.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:15:35 -0700 (PDT)
Date: Fri, 2 May 2025 16:15:37 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: VIOT: Remove (explicitly) unused header
Message-ID: <20250502151537.GA2724505@myrica>
References: <20250331072311.3987967-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331072311.3987967-1-andriy.shevchenko@linux.intel.com>

On Mon, Mar 31, 2025 at 10:23:11AM +0300, Andy Shevchenko wrote:
> The fwnode.h is not supposed to be used by the drivers as it
> has the definitions for the core parts for different device
> property provider implementations. Drop it.
> 
> Note, that fwnode API for drivers is provided in property.h
> which is included here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/acpi/viot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index 2aa69a2fba73..c13a20365c2c 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -19,11 +19,11 @@
>  #define pr_fmt(fmt) "ACPI: VIOT: " fmt
>  
>  #include <linux/acpi_viot.h>
> -#include <linux/fwnode.h>
>  #include <linux/iommu.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  
>  struct viot_iommu {
>  	/* Node offset within the table */
> -- 
> 2.47.2
> 
