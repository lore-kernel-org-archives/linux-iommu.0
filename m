Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F324C82
	for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N00+PcD/"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-41808baf6abso36541921cf.3
        for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696950253; x=1697555053; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1t8zUZcnV1ZrS6tYrAk5PmLTIeMwf9hVcdmf8EONNQ=;
        b=N00+PcD/OrSaIiUYfGdBDWGwAhGxWMSSAF4OTAxcToT/r0fTxhA5zE+AcEPQovfvkQ
         4IvVw/ybeQ2Nwux53hsSJVivxVI9jJA4673hzw6ahLicZ4vvITxY6SyrvDd1+pzNrC1Q
         9a4DGwSW6Dh9fShbNj7MI1EQ74yAZETE0fb3U+F4mDNRJrYEuLNVMd6jmVrcNxD+ozly
         JFHpklsowOxsgopsYviI4OcluMhNVrEv+WrTpmr2hLMdotHVA1nIfjbe3TTw8BDrdL1b
         beKzsPWfhabrgHhJ+KXbuZsY1bG01fXZnK4iUA7xzj+b+k4Zsv9ESdiIDiXnv7SoY+lq
         bGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950253; x=1697555053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1t8zUZcnV1ZrS6tYrAk5PmLTIeMwf9hVcdmf8EONNQ=;
        b=vuPGuBKF1LNMIyRvIGi6pxdlcCnbPBtrlSbGCg8Il3EJdOSFshUsSs/B0j8HANfLps
         c4AnRzdT6IqyYEgu9E94+kqpGcKSpmK8QXtPkys/bubStZutak04G/unVGhF6QijJihi
         cdCuBymfrtR8FHYK5BYzcY+ar5TUuOaaVbg+Bxy20fdclp2MF+kTHk0Im8v3K9FwCoqx
         ffV1tk1ebV750QB/6BxAfbty1HQrBCSQ1cMRWj6Gxi6lnJcIyi9lA5+GCUDbF6+Uauw2
         GWrwma7STTGhMQPFyIxTEJ5a+tw41HReXbBxjU9EX04t0XllRI8rxXzKXVoHovfVLMPS
         kU8A==
X-Gm-Message-State: AOJu0Yyn4g4PuQ8j43mK/U/nW7+W3avQbGmjrqq8yq/VE2aNxUzfZYRa
	FSHGnsebcU7GA6WwFdpzxjxsTQ==
X-Google-Smtp-Source: AGHT+IGGe3x2d+94ZE9JNpabMwSYxqUb54VqDYtyTTGRezMvzDd9hvuzcNcsq0Z+Uzukm31BqianAQ==
X-Received: by 2002:ac8:7f0c:0:b0:419:544d:1c0 with SMTP id f12-20020ac87f0c000000b00419544d01c0mr24740819qtk.3.1696950253124;
        Tue, 10 Oct 2023 08:04:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id x15-20020ac86b4f000000b0041b381b9833sm252211qts.75.2023.10.10.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 08:04:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qqEHL-000Elx-M0;
	Tue, 10 Oct 2023 12:04:11 -0300
Date: Tue, 10 Oct 2023 12:04:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 11/11] iommu/amd: Introduce logic to enable/disable
 IOPF
Message-ID: <20231010150411.GB55194@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-12-vasant.hegde@amd.com>
 <ZQCSi6ROWVrIZEux@ziepe.ca>
 <57dfeefb-5a21-3e18-46f1-851de56a3037@amd.com>
 <20230918124505.GC13795@ziepe.ca>
 <eee6f770-248a-033d-675e-f4c875212368@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eee6f770-248a-033d-675e-f4c875212368@amd.com>

On Tue, Oct 10, 2023 at 08:23:04PM +0530, Vasant Hegde wrote:

> >>> iopf_queue_add_device() should be done when a PRI enabled domain is
> >>> attached to a device, not in feature things. I also want to remove
> >>> these too once ARM is fixed..
> >>
> >> You mean we should do this during first device/pasid bind time?
> > 
> > Yes, when a PRI capable domain is first attached the PRI stuff should
> > be setup. SVA is a PRI capable domain type, but we will have more..
> > 
> 
> I have done this for now. But can you explain why you want to control device
> feature? With current code, if something is broken then device driver knows it
> and it can decide what to enable/disable. With new approach IOMMU layer will
> endup applying all device specific workarounds right?

At this point the device feature enable/disable is not useful.

If we need a query from the device driver to check if certain things
work eg 'does device support PRI', 'does device support PASID' then
those things can be a capability check, not an enable/disable.

I'm not sure what you mean by workaround?

> >>> amd_iommu_get_pdomain() has improper locking, it needs to hold some
> >>> kind of dev_data lock to access dev_data->domain. (and really this
> >>> would all be clearer if it was just written dev_data->domain instead
> >>> of the redundant function)
> >>
> >> It helps to get iommu from device structure. Its useful and we want to use it
> >> other places as well.
> > 
> > As I said, it seems obfuscating as to how the locking needs to work as
> > you must hold a lock while using dev_data->domain. In some cases that
> > can be the core code's group mutex, but that doesn't always work..
> 
> I don't think driver should rely on core layer locking mechanism. I have cleaned
> up this code.

Many drivers do, it is well defined. I've been thinking about exposing
a lockdep assertion that drivers can call to document this assumption..

Jason
