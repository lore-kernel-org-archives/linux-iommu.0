Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05912B9B7
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823987; cv=none; b=Bayj1YXQDlYXwJFGqZXqnlu+9Gnct/QY0zwvfwKYQbC05q7T/bC53NJdlbzu7FF/KpGCwyY86NJEUaAVI/js1kUaVsKcN1uEUlm4OYLevhCXntEyUgTrXtKyI+jEKRkSa462KBrlOZ2zhsEN+z2Xs5rwFUj8D2L04ucI/1qbCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823987; c=relaxed/simple;
	bh=+1m2ongThExBW6chW6hqirwbsRItFrfpy9PygBmrcqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJs7Pzu411jppwoa3lPe3qj7oSVnalkdeDlPROEBR/liDCQt6HkmkIT6bI4SYcss2EqLoChAiUtwVPpyT94rUahWJTIAzrgAxvX6ZZYbQaQyBGbujhH7pctnxj7wU5NyV8sY5J1leMt26IM50gPtFNYWkJQgfAxFjolDsG+E3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JL/kV+Fv; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JL/kV+Fv"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso1275601276.3
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 13:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706823984; x=1707428784; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wa+4/tUPwChckEewEY9UOhV9U17Ptq1+QIQi0LNOBg=;
        b=JL/kV+Fvy0cEJyGWHO23Opg1Qf8tNl8PD5ULtQmHWA5E8kZmqh+4/3po8yY3o7zkAM
         UeYxgqeHlAOo7k5mE+GCNIQTu2s+BqS+VfUKiYaJ5Y6C4ECO95ky3eruqkp84ndQrzQ3
         INnphRDnHvjxACwuD+RGX1DwZzcAV1TrFjcC/JoCeEJaiT1hSuFUTfgVcAY3spCZv37+
         a3wC5FmA0pfsE79miWbG8znab5x+rd7tXcWYVE1+V9wQwvBdt06PCrv+6Vt73WyWuU7c
         JBpuZaiGeflKK/kRJUG3sIW1w3xm48Zuj6/Nvrhw8XeTJ6oBtpWLj7lknhy8THKjNfXK
         Codg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706823984; x=1707428784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wa+4/tUPwChckEewEY9UOhV9U17Ptq1+QIQi0LNOBg=;
        b=pTQr8k1nw+w2M3bfzHKI2DKnt3LExUZUPAo4wg/LphFsu45bzR6qboMEqRl/tAAo75
         1BVZqlzh1KNeddfwcjKJVB2zC9Hww6YKLr5qtM8ykxV6wztvpjWimq8EHdw1xL+M60tE
         dKBDuhJWZhyiR5B8GMV94FxGlIlyWIkgUhkmsfgQriE0fTFEGh1iPPVLrvOU71vMww5x
         7LiFugWjyMFcIDm+zKCuajAZuKhqxzUGnafUOwln/eQQkyN/dfLEDW2ZyHf1+Ns4DDrT
         t1Nc3VD6jhCeqP849jOL5d6dasXz2CtTnPzthDAWT9hiwDj5FhDD0zWEvqLdWwMyDuFw
         11jw==
X-Gm-Message-State: AOJu0Yxqxwr8oV6mFZNzQ1O2jVgsBJsykyNIsciJPAP3ruLmcX4kSdcj
	zeoQDbpIQvCdVlP4gas9Ir8g8nPkroTLcEjBcR1Lvllula+X2JySYP3PsIBf92o=
X-Google-Smtp-Source: AGHT+IEwJjQJQi3Xdu746AkX/siR1AL08z8U89g8SyrtVJZrwSoernlTSftFOQ3f1eS8XtbmRI+Uzw==
X-Received: by 2002:a25:3ac3:0:b0:dc6:ba11:6edd with SMTP id h186-20020a253ac3000000b00dc6ba116eddmr6857928yba.8.1706823983782;
        Thu, 01 Feb 2024 13:46:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXMx5pVB/D1kXuWoAWP7RHPZNRUy2kaF05Ogj+v1cW2YcHLPTtI+ZxKM3vgwm6lLqHTnM1Gotq8gRIWDJkYbaZJiwe2osj+q9RNQIqQFmtrfp+oDdjMogTDNlGV3tgKM7BZrXx/E0QpWNYEZZZ5dF1Zv3yDLV0kGuKejQ6xFBmtxjxAd+vUwPg=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id pd3-20020a056214490300b006817d42eac6sm160452qvb.53.2024.02.01.13.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:46:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVet4-00ApME-Md;
	Thu, 01 Feb 2024 17:46:22 -0400
Date: Thu, 1 Feb 2024 17:46:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 08/14] iommu/amd: Add support for add/remove device
 for IOPF
Message-ID: <20240201214622.GS50608@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-9-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:33AM +0000, Vasant Hegde wrote:
> From: Wei Huang <wei.huang2@amd.com>
> 
> Which adds/removes the device to the corresponding per-IOMMU iopf_queue.
> It also registers device fault handler. These interfaces are called
> from IOPF feature enable/disable path.

"fault handler"? Not anymore right?

They should not be called from the iopf feature path :(
 
> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
> index b1751eb495fd..6b1fdda95514 100644
> --- a/drivers/iommu/amd/ppr.c
> +++ b/drivers/iommu/amd/ppr.c
> @@ -163,3 +163,38 @@ int amd_iommu_page_response(struct device *dev,
>  	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
>  				      resp->grpid);
>  }
> +
> +int amd_iommu_iopf_add_device(struct amd_iommu *iommu, struct device *dev)
> +{
> +	unsigned long flags;
> +	int ret = -EINVAL;
> +
> +	raw_spin_lock_irqsave(&iommu->lock, flags);
> +
> +	if (!iommu->iopf_queue) {
> +		raw_spin_unlock_irqrestore(&iommu->lock, flags);
> +		return ret;

goto out_unlock if you are going to write it like that

Jason
