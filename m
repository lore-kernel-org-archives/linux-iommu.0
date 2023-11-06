Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45F29439
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XW4qFImo"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b2ea7cc821so3044013b6e.1
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 08:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699289482; x=1699894282; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34naG3oOhFipg6p0SId1WyC2GMj97M8nPwdZUr8gkUs=;
        b=XW4qFImo8Nt+FmTYp423ESadmXwWhLQ9rawNItfgIcZWFOOuDAPkMVCll+B5CAgvMA
         rydOfT3pj/k7sxLi/PRHrpfSZAUvMg5apxBgFNYTZ001xbKoxCwfQcC+n9I3O/d9135u
         /cTMFaFPP7idUDCWGkbRgH6u+3PznSe++/UEtqZo/nK5qqP7DHe2U97pqRlWuiP4e2sM
         JDH19rGmOoQ2FJ/PgIp5kv9XeftI3/M8igClLf/lCIF33xBhGR5m5xLnpo6hZZ/KVVZw
         f8HfNt8sshKV4HBRG8l6nvrbGLjIDavzp6Teq4Iq3HL+4hw5zC08FgZPXxLWBIZlbt8X
         li1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289482; x=1699894282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34naG3oOhFipg6p0SId1WyC2GMj97M8nPwdZUr8gkUs=;
        b=ncN/M1DgPsbsCmaxGYY/MMmwnITgwa8SZ1/Sb/EtHlv0mR9sYHxj/1o15QzeZ1PNKK
         M7pYgVZeNp2peRAr0RbJ+tl+FsdTNL9IHUqLatYOxASCU8W+8cNV0sxYypIbP0/jadOf
         s0XvHWd2z77VGlKoYwPO/nXSC9NHroOZwaKDGPzj4YDQU2ro8XaJY7/ghakMcytuuImz
         6yiPRj+6qcmwShEfe+lBqdWHbb8LxmEe8Hkn2z/I+9321X+an8k3egQjngZP/E9eCxk+
         Y/8riHGjzoHZPYdd3vmPNMQDqxW9kO+Fbzuxql+GVxeFJDqUI1kASE3GnFaDDr4MLYhE
         SE/Q==
X-Gm-Message-State: AOJu0YwZ8WZ2pV4EkraDpSqD/mGtBth6Sj/ERreqIPTJqCLZAa83DjcK
	YglJHyTain9Mi7ryIvgP9KBM/yq8+wAKwpbySFQ=
X-Google-Smtp-Source: AGHT+IGnKK/Z2gFvTaACKZsUmioZvZDykV/v302UY+b3S9/GnRSl/0lusqbRWw8NL6lurTmdHp0OUg==
X-Received: by 2002:a05:6808:2394:b0:3ae:144f:f99b with SMTP id bp20-20020a056808239400b003ae144ff99bmr38328592oib.4.1699289482057;
        Mon, 06 Nov 2023 08:51:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id e15-20020a05620a12cf00b0076eee688a95sm3472111qkl.0.2023.11.06.08.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:51:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r02or-001Oz1-1z;
	Mon, 06 Nov 2023 12:51:21 -0400
Date: Mon, 6 Nov 2023 12:51:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 09/13] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Message-ID: <20231106165121.GL4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-10-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:48PM +0000, Vasant Hegde wrote:
> +static int __set_gcr3(struct iommu_dev_data *dev_data,
> +		      ioasid_t pasid, unsigned long gcr3)
> +{
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	u64 *pte;
> +
> +	lockdep_assert_held(&dev_data->lock);
> +
> +	pte = __get_gcr3_pte(gcr3_info, pasid, true);
> +	if (pte == NULL)
> +		return -ENOMEM;
> +
> +	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
> +	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
> +
> +	return 0;
> +}
> +
> +int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid,
> +		       unsigned long gcr3)
> +{
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	int ret;
> +
> +	spin_lock(&dev_data->lock);
> +
> +	ret = __set_gcr3(dev_data, pasid, gcr3);
> +	if (!ret)
> +		gcr3_info->pasid_cnt++;
> +
> +	spin_unlock(&dev_data->lock);

I didn't check carefully but most likely this lock is not needed.

All the attach/detach ops which are the only thing that should alter
the GCR3 table are already called under the group->mutex.

I've been thinking about exporting a lockdep assertion for this, but
drivers already rely on this propery.

Previously when the domain was holding the gcr3 it did need a
dedicated lock.

Jason
