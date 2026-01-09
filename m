Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8700296BBD
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938713; cv=none; b=tqpKEfXhW3iL7DC8mGkWBfY0mOJiPM3Fw0o6dXNNRwgwuR41Kk0Q/SJzQ7Jdbzml1KZlCxspHFLUszj9MRdVfwzOXlegzAdwrEb/X+xg4nb/6iQndkAh+hGHj0vL57l3GGJvLVKtFCBl/ui2giLhGNrNc/3TAeE7CZbheFr3d/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938713; c=relaxed/simple;
	bh=5jmRjEH5N9K+TIrarSzQwamG6eEZwg5nkhCLwf4iIQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcHz+D5pf2JgaPY8ZymeYd9POI+A1eCyuHlJjUAlMy/2MNISM0g9gZKPDLSQbiMICkYJXbedbNHT/wU1aD87pv5NyVuoJ5yhV0xLpseiUwwLz47/NgB+DV9YCcg0lL5lkz8rNjFMtn+2Jt05hMmtsUm9fE2XdCR/wx8RbEQodCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OjO3lRdt; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjO3lRdt"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so25767045e9.3
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 22:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767938710; x=1768543510; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooM/uKuoWiEKylwC/sKJICq7ujylAuG7XtKbwAgBTOw=;
        b=OjO3lRdtb7a+uE0fHyDWfPP9L/bmDsbWoL2pkQ5G2aJxpIwv/zcIFswicBnUHPs7Tt
         rC+sOTEDsBWk/KMSjD1HSEX35Mq3ofbQKq3JmnRm93Kz7uXsDQUt54y2FhjWKkCUuG+R
         fV+LNwOfRhT2dgaEPC3F7NcR8LESAGMn1mlp/iaGwoCpFNw0dKKBwXH+ykne9wwWYYyC
         JOjNv1itJr75Q6IIllO7NfpMk1oDD1NAFtX7kHzRFtj9XJrOsR3KTKtOvfnmSDiPfmyi
         KKfEbINzqeEv7nRb0+1FkkDBL+qge66iZIQjCxEXBd0SRrgS3Xfkn4M5LsAa5gU3z+e5
         T9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767938710; x=1768543510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooM/uKuoWiEKylwC/sKJICq7ujylAuG7XtKbwAgBTOw=;
        b=mByypU1QJpbHSuMc47w1tYHxfXMSvtQ/gqE5P6P8mLzIQJjdoWn1crJNGG8LdKim/E
         l0kGm30aMllhfj/q+HadfRzG0PiUeliY+iyQfnPVlMNLbrA8EsXGRCl9TcBH2dgjoq1T
         7cWCEhah+b4MKbFx4Ubk/wUrdOr+7lllqRo7E95xTHYYO8HcWp0yPT34+E2tI5K3nbXX
         nUfFX4uVSwM+rOv1JifNjoSEb1ZqVeV7z3Fog3CJmQtmA8gzQ52dgn0SrYTC+xCHUaYr
         If+TCOWk8KNfZpIslgmljIy0FepzoahpZtCvb7nG3UBbYj3NLI9/qx5pHwK/HIueC+Sb
         ow7A==
X-Forwarded-Encrypted: i=1; AJvYcCVCDIIUSH3LlR5vvNh9l8uToGAg784ksfzFtS3bqKZIiESy4qXb+hLpiA8BOo+g30NX+SzHMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqUuDXuACoWJ7Q5b5IR9podscIlS4tQTZec7+DoQwufZkFLqiE
	kiJQBaZlzGMfCMYG9wr+EN6IhZyql7Q6IZLHxlw02ekBJs/opZGARBABn6AaDF/gcok=
X-Gm-Gg: AY/fxX4tv0Tkfm4OASEbI6zIayZGqDEHl8b9WUYmP/oU4V3ZGQr1MXl+huyo8uKx/jy
	n6ptVhSACEmN5FITxjOSwKtFymxaFgtEAsBVJhbMbbgbU9fiVPFD4bPXxijziczTRPrnyIclscl
	9w0WXxAMB/3364KuJLiIwFfjKyrS0dqwDvzFyoRf+K9N9HGqE6VMgRAr66YHOnVpQTq21p7hqJf
	qvfjF27pQER7kH4nvIb09vicyrEpeQl8R5P+Bg++XMO3/Te0BtLI8oY4vlB5FyOqRbRLnv/vitK
	xqAToAdcPQVWemhoE0ZYUNOK/XVMoj0ubqnqNxWxKWnnZ4+tQ2+qCKEfOQJjc+VuVWJGagOOstV
	IMKBEdoJayfbsnxDIlZ9dGg3X7O10tdOuTar/UrymWqAMUo2GTH5862oR3b1m91RrZ30X5SGCzi
	ursbdKlOVDGGCCLth/
X-Google-Smtp-Source: AGHT+IEw+1D/KV35h1xmcYg8u9aLCmfWv//Elr/Sqt7gE9ixomZwQZirSOOCipRMnwEtDetKsHdjHw==
X-Received: by 2002:a05:600c:8b52:b0:477:abea:9028 with SMTP id 5b1f17b1804b1-47d84b1a348mr88128745e9.6.1767938710132;
        Thu, 08 Jan 2026 22:05:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm195146375e9.6.2026.01.08.22.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 22:05:09 -0800 (PST)
Date: Fri, 9 Jan 2026 09:05:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vasant.Hegde@amd.com,
	Sairaj Kodilkar <Sairaj.ArunKodilkar@amd.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iommu/amd: Use array_index_nospec() for rlookup_table
 index
Message-ID: <aWCakni4dwgJpuE_@stanley.mountain>
References: <20260109052040.938-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109052040.938-1-dheerajkumar.srivastava@amd.com>

On Fri, Jan 09, 2026 at 10:50:40AM +0530, Dheeraj Kumar Srivastava wrote:
> Use array_index_nospec() to prevent speculative out-of-bounds
> access when indexing pci_seg->rlookup_table with a user provided
> device id.
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Reviewed-by: Sairaj Kodilkar <Sairaj.ArunKodilkar@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202510281233.q4cBnp3z-lkp@intel.com/

This is interesting because more and more people are using lei to
recieve email and now they get unfiltered Smatch warnings from zero day
bot.

Normally, I just ignore these warnings because they're hard to review
and I recently modified Smatch to stop the zero day bot from warning
about them.

The problem is that I've tried to contact people from Intel to help
review some of the warnings but I've never recieved a response.  I've
heard that Intel has a handful of people that deal with Spectre v1 bugs
but I've never seen any evidence of that...  I've never tried reaching
out to AMD.

> ---
>  drivers/iommu/amd/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index 10fa217a7119..4990f6db99ef 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -174,6 +174,7 @@ static ssize_t devid_write(struct file *filp, const char __user *ubuf,
>  			kfree(srcid_ptr);
>  			return -EINVAL;
>  		}
> +		devid = array_index_nospec(devid, (u32)pci_seg->last_bdf + 1);

This is debugfs so it's already root only.  The cast to (u32) is
unnecessary.

regards,
dan carpenter

>  		iommu = pci_seg->rlookup_table[devid];
>  		if (!iommu) {
>  			kfree(srcid_ptr);
> -- 
> 2.25.1
