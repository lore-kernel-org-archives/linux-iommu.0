Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07B7F
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598832; cv=none; b=ONbj0MakJSGL8kyM2E3yooWPIEgRWuWHJ8kOLZzfvSS0IQyEcemrMsUa9liqaTPMmnl5hk2cMa/9y/Caj+dq4xK4sc3eo0lS0DvlWk63f/NMlh0m7WhVDId5skHpO2h6V4LLu8YXeWYJTSsbacHaDhkkZ2x4Y50FosaaFYsXeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598832; c=relaxed/simple;
	bh=tx+Bc3WSxqwusBEh1lTcHGX4lK9ZljsFGMzrqdkWiZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlnhCBvJ7tAyTCK6gKPDXmHHzbiQiep3OE56lRpEoASyXk2iHn5VlgDVS4JLqqBqTUDgIdf5Feop5IZnz/sbHSBDKB+nVg7zr3uY+ZsJmWEFuzwh9b+qWvSv1DbDsmjM0WBBPetty2P7NBEYgcXn5k8Lx0qE5rPZbav1uBvdDb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eikeZTm0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eikeZTm0"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42ee984152cso12951371cf.1
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 16:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709598830; x=1710203630; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zeVzDAorPNMKIHNTgnemv+UDJb5BU4Y5dstVAYA8hW4=;
        b=eikeZTm067A/DYUI1GcmRmIEtypYAJasoe3EfTmOwRUQuUzz1qmYn+cOZiy41syurU
         giX99mvUg51qPJ+ck34dunxL4JVAqA6IVaa5w3zWQOG2LpIIRo97MUGh7zrm7cK5lERk
         r4vZfJRIiEF4waag/oxjrja5yoRSia6frcLOB+o99L5Dhz4wMAo0s77MPFVDk2eoqitG
         CPqa57i+7GPHCbTLfbmcLqwxTXvQDpFkRwK65CwOGnc6+Hv8FHub1C8Gi525W+qGN0JA
         i6Vyw0ytcltVX+NMY81h4cSzsC+opeof14WPiMoDCUTOA4XThyBQeu9xHzsGMNk6N1cx
         Idvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709598830; x=1710203630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeVzDAorPNMKIHNTgnemv+UDJb5BU4Y5dstVAYA8hW4=;
        b=E6cUJZOJLKO5exwtFfHY+G4UBs2zJR0cHak8jJyeD8zKB5E7/4rodC5PdXA0vLQLqV
         HjT1NHWvQwM5qyWxXdY9qyTMkzFBQDv2M4bs2lUDcOVl1tTCKepBsnYiMb4ZW5NOwy8G
         j0HLvu4nsTFFI3dehUA0uxiOqipYSlXONwnRoVC8HpgmB5j7zgZ/KauBh1TleBQDJ10e
         alp3YB/fgTF+vez6DsmykaQVAPovaIlyaBNBCs8oWcgkeJ1N/m6t86LCnq1yVlss9oOR
         ltBRtTMHFJ8bxGJI37+ipyWTv6em6etbP8UBoKq6E0RSeknKngvmJgD1GotwUZhcX2Dy
         pPjg==
X-Gm-Message-State: AOJu0Yx9Sut93w8ASZWNldPoWUm77o7lzFcTDXZCEl3G5g+Gvqrg4uAX
	m3Vzl/XyWzssHth9TlKYc7PYbbCdsS/5/6Nw/tV8ueNAeXl0INsPcmnQgOm1i70=
X-Google-Smtp-Source: AGHT+IHNYKtTEW7trhbC5O8qR4pF1Z7P7C3IBbncyN4d4V35f76VNHwhkSNpFv0wEAs43InOIVkWOQ==
X-Received: by 2002:a05:622a:199c:b0:42e:f863:a407 with SMTP id u28-20020a05622a199c00b0042ef863a407mr433223qtc.51.1709598830233;
        Mon, 04 Mar 2024 16:33:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id c17-20020a05622a025100b0042ef1fbd052sm1445389qtx.49.2024.03.04.16.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:33:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhIkf-00DYL3-9V;
	Mon, 04 Mar 2024 20:33:49 -0400
Date: Mon, 4 Mar 2024 20:33:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 09/15] iommu/amd: Define per-IOMMU iopf_queue
Message-ID: <20240305003349.GD9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112930.63663-10-vasant.hegde@amd.com>

On Fri, Feb 09, 2024 at 11:29:24AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> AMD IOMMU hardware supports PCI Peripheral Paging Request (PPR) using
> a PPR log, which is a circular buffer containing requests from downstream
> end-point devices.
> 
> There is one PPR log per IOMMU instance. Therefore, allocate an iopf_queue
> per IOMMU instance during driver initialization, and free the queue during
> driver deinitialization.
> 
> Also rename enable_iommus_v2() -> enable_iommus_ppr() to reflect its
> usage. And add amd_iommu_gt_ppr_supported() check before enabling PPR
> log.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  5 +++++
>  drivers/iommu/amd/amd_iommu_types.h |  4 ++++
>  drivers/iommu/amd/init.c            | 18 +++++++++++++++--
>  drivers/iommu/amd/ppr.c             | 31 +++++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
