Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E67F
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598743; cv=none; b=diEePne7qo8Ay9M/qRVkcHeWLmrisg7XNm8drg/bjf1Li0erUeAci0TmxlAD4M2OiivicUxgP8lpxLLGxchrfUqs2DElQP+ESZmRotlsqaztviQxumYBRbDMeWW4rpDC6uyxWstbYsmHoSwwF7uWQgw7WCqtd/jGK3rhYaHMGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598743; c=relaxed/simple;
	bh=+94LTiAPGc9fBp1YA5C9lrB1f7ewEMBqtF7E80EgKr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk6a9qxqtmBjRdj11C6sH8AGR8gBYun1wZ87x6xy+e8A4HGgAzRPB5E+QqpvyiFqh+sb6HV/66JaOC6QpKL05ay7kWGarxPzyCmOBwEuaMBZ30/8vA54pO9qoJ1rPpqWyQXBGlM7PkviBwRhVgNKvP1z4TlsM1IBPgi0eZFDFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hiuFauN3; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hiuFauN3"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68f9e399c91so44136766d6.2
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 16:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709598740; x=1710203540; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIYfRgSHSD5tk0Mf1cpKiGzAA/kYCSFc3KURN2yfm7g=;
        b=hiuFauN3QpLHEZmTurAGBrs8FIHm6HKWFD2I6XSf733/Yi0/1c0hEdF7NM9PcysaV/
         rOvkvuEZ0IKG+b2v0y2utVh4DSbuu0fJ5Ylc+OFK+90373mQ26F4Aa16WhVD9mSKP51B
         eGyAZT9LrfHf3kwZp2oIyd/k0lluV6k5WWnB2rT6/x4vfsnV4DF8ZsdG4v7UD0gNB+ko
         yGj8UiVVc1I/aYvfBoXr/QEI7jX5IKpmWNHcVJQZzS/qQsJvN22naZtz4rBt9RPM3g48
         s7+RTeyqiziOReMNNtpkzfneVsOb1A0rPPEBbL+ayc5GIIMe13zBbiky2jtgBXLgZiXp
         +6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709598740; x=1710203540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIYfRgSHSD5tk0Mf1cpKiGzAA/kYCSFc3KURN2yfm7g=;
        b=sBJozagDBYhOQZGQKjshj+xv1iaQ1rt/Vt/5/jfCpK/k/PSryDcEVOAvunPtvGAZni
         O1H6A3wzpt6ANW8QLRSpc/ZXXAWNMml4cPL07PnMfwt/Ubcesytnpy1hdwKEBJ8DqSlJ
         tbR6QBF6KJgqngX1ZILsb81N/OG2WmUE8x9LovcagWgk+lOtumbwjGumag39nKTvK7if
         owK2AmiRk8Fw7B6yMRONOz6cCBoB03hEbVKfrdLYFZu0nmAyNonpi1ZbAo9bFdgOCGkM
         k4zvu+gwaBqrNejIVBDPdjp67MJf18e5AtKZ8RpCTWO9HJgyMzII6K3OAki2greO50Cv
         M+cQ==
X-Gm-Message-State: AOJu0YwPUY8/wRv3VbCv6iaghOra/jf94yACbdvD+112913zcZTDHhih
	yMJS/fPPDd1WUO6Qg2LVbUC9QoBsevbOznMJ4OCUo09ILl9APWhHHvhxEh8hu2libAUA1YuV4x4
	/+hU=
X-Google-Smtp-Source: AGHT+IFzuWNudJPf302ggPG1/LbkkDNRAwLzTEoKey0nS1eSJ4+Qij+WjoPz9XCxAS+QzlSGW0rIIA==
X-Received: by 2002:ad4:5690:0:b0:690:79e:78f9 with SMTP id bd16-20020ad45690000000b00690079e78f9mr474776qvb.18.1709598740197;
        Mon, 04 Mar 2024 16:32:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id pj4-20020a0562144b0400b006904a076f01sm5397093qvb.114.2024.03.04.16.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:32:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhIjD-00DY0a-5V;
	Mon, 04 Mar 2024 20:32:19 -0400
Date: Mon, 4 Mar 2024 20:32:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 08/15] iommu/amd: Enable PCI features based on
 attached domain capability
Message-ID: <20240305003219.GC9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112930.63663-9-vasant.hegde@amd.com>

On Fri, Feb 09, 2024 at 11:29:23AM +0000, Vasant Hegde wrote:
> Commit eda8c2860ab ("iommu/amd: Enable device ATS/PASID/PRI capabilities
> independently") changed the way it enables device capability while
> attaching devices. I missed to account the attached domain capability.
> Meaning if domain is not capable of handling PASID/PRI (ex: paging
> domain with v1 page table) then enabling device feature is not required.
> 
> This patch enables PASID/PRI only if domain is capable of handling SVA.
> Also move pci feature enablement to do_attach() function so that we make
> SVA capability in one place. Finally make PRI enable/disable functions as
> static functions.

> @@ -2036,6 +2038,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
>  		     struct protection_domain *domain)
>  {
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> +	struct pci_dev *pdev;
>  	int ret = 0;
>  
>  	/* Update data structures */
> @@ -2050,10 +2053,16 @@ static int do_attach(struct iommu_dev_data *dev_data,
>  	domain->dev_iommu[iommu->index] += 1;
>  	domain->dev_cnt                 += 1;
>  
> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
>  	if (pdom_is_sva_capable(domain)) {
>  		ret = init_gcr3_table(dev_data, domain);
>  		if (ret)
>  			return ret;
> +
> +		if (pdev)
> +			pdev_enable_caps(pdev);

But here we are turning PRI on for an IDENTITY domain and for a v2
domain that doesn't have a PRI handler. This is not technically what
we want to see, the PRI capability at the device should only be turned
on when a PRI handler is available in the SW side. Otherwise PRI
should be off and non-present ATS responses should fail in the device.

ATS is not like that, ATS should be enabled whenever the system iommu
can support it. For AMD I guess that is always?

Also, PASID enablement looks like the wrong spot too, it should be
done in the probe_device() callback and stay enabled. The bit is set
if the IOMMU HW can decode the PASID TLP. Ie don't enable it on old
IOMMU HW that can't understand PASID.

However all of this is basically pre-existing problems at this point
and this patch is improving things as they are so

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
