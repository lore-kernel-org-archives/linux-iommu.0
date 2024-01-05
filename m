Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BB36093
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TC3d5eUd"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67ff241c2bcso9518536d6.1
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 11:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704482502; x=1705087302; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=908bRU8WdnztuUmEOlCB0Mehjk8ltV2GVMp5hiP6hzg=;
        b=TC3d5eUdbBXHY3w0v+/PUqSiUpDGIYB3F8ccNEVA55B/dvNG2q10uUAJoSfsSdUmDN
         ftg1ZE00uFC0RelqmrwzJezkGBxwZCvoOOWzaAfHlJfvwj/jUtT895qW01xZ6vc/H0jF
         ExeY63qKWnlrzXFrz5qooUsmRwuhFyEZJRhykMooAukZVnPpU+uXNMzlDJzSFs4Iaw6+
         9Q08NZil5AStj2vM7p5rDx0ddHpr5jLantbiOObnkVxeBkdHk1i7tkCysqUZVlEWWT2K
         6/9hosHEhPebYOPH1zBOVcQQqze7E49IdlpbdtqtncixDoEpmo3UEzvl5ZPSWfgFN09Z
         tNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704482502; x=1705087302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=908bRU8WdnztuUmEOlCB0Mehjk8ltV2GVMp5hiP6hzg=;
        b=dAXMxlzvYUSMs7ICOLbxbooH9mfNoehcDJxHUblT1ft/iaxUkE+FyxBbndZHjlZiJy
         NUKbqk9Nb1nhntNNfospXnuNaD+9tVstn2LaePrnmamduXir9d3DgvMPBtc+MNIKZUJl
         Xm16aBkI3nE0zxuK3yn58poaLvkK5urxFRzrbsCOYSUyQKBRulX3xqFoK3gYUfRYQc0F
         DmxfXcEognfsQVarrhaQjV3Gw9IRXuyrfQo7+v53YUOZGF7hd3d8fzBOZV8TPl2Yflg/
         SE6ILcfQKwdadnCNVpro2Oh5uclzQpl8BLKgP5p5kIh5YQdN2zZx7qvTAFLswMqy7jt4
         k7EA==
X-Gm-Message-State: AOJu0YzSIacKIJeoqnntc8Qd5mpyetjN8vaSXby0bYvgfgV+HLD+0Gex
	OsqW44Ya08Fldi+KjxF9QLSMHBmcF2/Hrw==
X-Google-Smtp-Source: AGHT+IHQHqOAc70MuHNMVYrnbLv2IX/R3/iB+m8QHkqJiJE78td50rOQMUSxMnfbx0jIGPG8kqc9XA==
X-Received: by 2002:ad4:5761:0:b0:67e:ea2b:1c4b with SMTP id r1-20020ad45761000000b0067eea2b1c4bmr2825488qvx.96.1704482502238;
        Fri, 05 Jan 2024 11:21:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id t8-20020a0cf988000000b0067f0a06c1e3sm823986qvn.132.2024.01.05.11.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 11:21:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLplF-001VdD-Ae;
	Fri, 05 Jan 2024 15:21:41 -0400
Date: Fri, 5 Jan 2024 15:21:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 13/16] iommu/amd: Refactor GCR3 table helper functions
Message-ID: <20240105192141.GR50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-14-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-14-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:21AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> To use the new per-device struct gcr3_tbl_info. Use GFP_KERNEL flag
> instead of GFP_ATOMIC for GCR3 table allocation. Also modify
> set_dte_entry() to use new per device GCR3 table.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 55 +++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 584608b98f26..7e5f32817931 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -79,6 +79,9 @@ struct kmem_cache *amd_iommu_irq_cache;
>  
>  static void detach_device(struct device *dev);
>  
> +static void set_dte_entry(struct amd_iommu *iommu,
> +			  struct iommu_dev_data *dev_data);
> +
>  /****************************************************************************
>   *
>   * Helper functions
> @@ -1716,16 +1719,21 @@ static void free_gcr3_tbl_level2(u64 *tbl)
>  	}
>  }
>  
> -static void free_gcr3_table(struct protection_domain *domain)
> +static void free_gcr3_table(struct iommu_dev_data *dev_data)
>  {

Pass in struct gcr3_tbl_info not dev_data

> -/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
> -static int setup_gcr3_table(struct protection_domain *domain, int pasids)
> +static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
>  {
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>  	int levels = get_gcr3_levels(pasids);

Pass in struct gcr3_tbl_info not dev_data

I don't think it is worth re-doing at this point - but I probably
would have tried to structure this series as creating the struct
gcr3_tbl_info and migrating the protection_domain to use it, then
streamlined the APIs to have a clean gcr3_tbl_info layer, finally
adding a gcr3_tbl_info to the iommu_dev_data and using it when
appropriate.

Jason
