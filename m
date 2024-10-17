Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3A1DE2C9
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172006; cv=none; b=JQLIpRc1hwcks6lMWqv/4crFoBw3ag9ZieDggNGmqq4Pw23KRrf+C2HLfcw0yKyPtcJTN9C54OsX/7WJsK9lc+dZ33SqZAiVfRbNJ/2xLg7oP9M3ymcwweZPgSV8vNhALrbF6ls+IcshUngN2T8QCwhJUXfstcqQjgzycenvnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172006; c=relaxed/simple;
	bh=jDV5neFLfZMqtWwQSqzHYMlELjrm5+5aXL64WwQfQ1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3Q+Wr5xU/UowiQApavCJ3nMzhcfEuolpSMEf59lvEkJ0q2SQhSFlu58f8BN2oOabR5pOSci+W6awI7aAPfhA3Nm4sVglOVMAiV0hJpNb7GuqE37GcF7Hpgb8jZIduut8h1DSZC8IMa5ydjpCjFynCRpoyaB4jh6H0L/NQ1pw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YDeZf1nV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YDeZf1nV"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4608d10be89so6425411cf.2
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729172001; x=1729776801; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAL7qTsVf2nMKSQOEzen2BtaBMKUfR1NVWb1g16ArZY=;
        b=YDeZf1nVx9vlBW9iCBAkwiXrMyCR+9fSUTrJTYCyTjBmHvcmAoJ0toNFLTCe/lfO7N
         /05zoANSVjQAPZpmuN6jCaG/vpVQwpuwULd55PNmnRFOj2cuGPT76sWGQWo8QdpSB8T4
         hRM531LjxCTf8HQBy4sbjW64HkfNfugt0bZ1aM+n3E0z4zHpLFRGB4fTLgh38zTZ3rzZ
         3+XBWeNRhaWfXh2hiC6zYSdHomMRqKNm/MRge+8an8DOMcmr216Gcw9yeN69QU2xyZho
         RW7GkWjv7hh+IpkZS3o18o6Pdgq2ayv0iGoRZqFNMbimIEemiBcTnDnrzBSiy6CjUhI9
         geBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172001; x=1729776801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAL7qTsVf2nMKSQOEzen2BtaBMKUfR1NVWb1g16ArZY=;
        b=PR77BpX/z4QmeMdTV9qZDtc4ZSIe85cOAuhpPF51jOnJou0/4+zBAFbyTqN4IwVPAe
         EraIJ7E4l9jDPTV8VPKBSMW/VRvn4kp48dcc4VQCqLvQQw+17TtQCOSzU7lGAAQ4Qj/y
         S3yAHgnRi2M6hCPaUATfHMZzBXO8LqRHfbfng+JaHB4yCPBgNS2M4xAeS4inT7a+XSok
         KR+A0La4xQ0kd64xYWAQoc5ZybIqOTPsDHjrgzJ4seIICG5CxlO8Xt18zE1h+Qdv+z7H
         JneN9qQ9jOpclNhChMdwJzYR96f+NV4Ocp9fjvitB9yHFnuJxIWEwkZ+LTO7r1VD93cW
         FMPA==
X-Gm-Message-State: AOJu0Yyy+0u7wBxN5RrzSeOZWkxW5q7Oc5+7rJ93kF6aji0SSEoNndy/
	eBed+JMMsJopq0OiF9yxuVSsO9TPNdJXAu4VGD6nhJ2iqFx3gx+KclXg90EYpis=
X-Google-Smtp-Source: AGHT+IFzfVx6Q/raDEJ7JC69lLaqxjfeDaG7J+9yMC5/nh9f9htae9f57xEI6TkwOf3/iCh8zk2UmA==
X-Received: by 2002:ac8:6f09:0:b0:45d:9357:1cca with SMTP id d75a77b69052e-4608a494f83mr114966881cf.14.1729172001138;
        Thu, 17 Oct 2024 06:33:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b150b15b0esm56044585a.136.2024.10.17.06.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:33:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1Qcy-003xq3-7f;
	Thu, 17 Oct 2024 10:33:20 -0300
Date: Thu, 17 Oct 2024 10:33:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 07/10] iommu/amd: Rearrange attach device code
Message-ID: <20241017133320.GQ4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-8-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:34:58AM +0000, Vasant Hegde wrote:
> attach_device() is just holding lock and calling do_attach(). There is
> not need to have another function. Just move do_attach() code to
> attach_device(). Similary move do_detach() code to detach_device().
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/iommu.c | 85 +++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 52 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
