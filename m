Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F635EED
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IvH+/kI9"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78117e97becso101905085a.3
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704479308; x=1705084108; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip6HxRCV4YcdzPoiwh7Fl/STQmbQyNEq13kYcUhyue4=;
        b=IvH+/kI9gIBYSt6iQ1KX8v3a4Z48Jw4ZET02qWrSsjH4LYitqxqbTaPKNClNi7VpMv
         hs6OcpdHVYFVB8nD1WGKD5NSiKvY8OxOLs78XgJ0XfPLoezFw3duiCbuXwAxqH5i7Uss
         1GWHY4Jlska66LSeK3nsRwN8rOnet9uzmbokmtI+Nky9HiqZdNRgqohXTMJwelX/ziT+
         xsvHqI3z/e1WTVYtk19dMgSBUgSuH9FH1gWDWiep1gKwJRUBscdUwe0GFQMU+aLYM2rb
         udtARi0nxpKOeW0iSuxPqiN8Eg1+k9c5oDYvQHjLRByGvgsyV98ZvTUMTNv2DC3DncWM
         +QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479308; x=1705084108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip6HxRCV4YcdzPoiwh7Fl/STQmbQyNEq13kYcUhyue4=;
        b=XZKtfb9lnByNXdl9FEq+4CdabNhQmHIW2pThJRe/rLdflmtuna/pCifWmk/RyDZPsO
         mYjyoAg3hxnssOytfnj0CR5yPZ6UNWCVhZPj7QzNQX3v3+O8xnsNlCltVcnip+dhCmFi
         6u9/MkvOw2LWNfJw/2Usv6c8KWuKCBoImJeWgAYaNSk9m5+9TlBJ0IjKIvcuKsBl5LQq
         IqpUnp9d5GRD2CxDV5iE5amoe6m8OoYcuN+rWdBFnHwbda9D7t3FRI1a6mBvaRTyRaQJ
         JwWDZd4HtbfxSn4+d7Vbtt/9z9ZeGVYjItbw1Li7KfI8+sffJZ6FHcWHgfJVCJGD7gbI
         mqag==
X-Gm-Message-State: AOJu0YyVLnbh3Hd8Y+Y+UpOYcVwfdcw8m+KUdHYGITzDvi1l/HMq9sIi
	W8T7mZK9xg1gf7ETavCxCO3iTdH2MZDbig==
X-Google-Smtp-Source: AGHT+IEoNDbjMZlqLnXidr83//8dP67rHpCexEwt0A8gj7bzB+Cw3cjAf/6ixFaRYw4HhHiHCbBHiQ==
X-Received: by 2002:a37:c205:0:b0:77d:9c23:46c5 with SMTP id i5-20020a37c205000000b0077d9c2346c5mr2498043qkm.22.1704479307929;
        Fri, 05 Jan 2024 10:28:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id u11-20020ae9c00b000000b007830d394563sm330691qkk.0.2024.01.05.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:28:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLovj-001V8o-1H;
	Fri, 05 Jan 2024 14:28:27 -0400
Date: Fri, 5 Jan 2024 14:28:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 06/16] iommu/amd: Use protection_domain.flags to check
 page table mode
Message-ID: <20240105182827.GL50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-7-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:14AM +0000, Vasant Hegde wrote:
> Page table mode (v1, v2 or pt) is per domain property. Recently we have
> enhanced protection_domain.pd_mode to track per domain page table mode.
> Use that variable to check the page table mode instead of global
> 'amd_iommu_pgtable' in {map/unmap}_pages path.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
