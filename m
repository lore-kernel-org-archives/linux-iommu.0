Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8D7E
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692917158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYqy0i5TeF+h14NqKCzRo0lQZdP8znfUE6SCunJ5g8c=;
	b=OnyFSBNc0qrDGWAp4NC28TbkLluPRXWB925tWa7yAtgDuCQgJi4XkOIP+n2qM8ecN9CQwu
	eaRRqpeprxWIQCZXAn0iXtLvN3RGJCbyUp5hmha5DoFfZYbld4FhfBCG0AiaBzXoZyydTz
	2tT0/caO4NTKjshNBbtmO84dfOuGh6A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-sbEzZMV1P8ObSQ-6y6G-wA-1; Thu, 24 Aug 2023 18:45:56 -0400
X-MC-Unique: sbEzZMV1P8ObSQ-6y6G-wA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-64d09183380so3954596d6.0
        for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 15:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917156; x=1693521956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYqy0i5TeF+h14NqKCzRo0lQZdP8znfUE6SCunJ5g8c=;
        b=aUvWuRHSODtJ7nVDLLQI2w3PO9xoeQFNJHiaD0JOK/uZWXpJYigS+AF3I8mVCLbcOs
         o4Pd7XMjSpC4rLKD8B0p5EMv1yJrrAXnoHnsPSeMQaUhaIO1lgiqG8OH9RQ52jPCDrC3
         EfaSeGry5sSxE9l6NHtdJeO5KObkGDB5fYVSEJZN3Ck4oJNvNrCu0CDTEMxwSQn/xawy
         9YudoHKGND30xzMfuM3ysAyuJb8+K+9c0jj4NJBIchcreXh5oK2dVYiBfajNr463eIRH
         1/7UCx6Q3sRqbR6e0eRfHitsSPQE49omn0AYpx8YJ2QeOOJJ+9SXmSkBkEa2/pBK/4pW
         yZsQ==
X-Gm-Message-State: AOJu0YyWsJG5AwafSIzj91ioBmyaOOAokjeEnSuC6f+TdWxHhOKj60bB
	QVQACQl8GNWXqx7kET6Zor/UOICTcqudG6gLw/ZUxkWLktrhYsJuefEeU+oV71/iypZ6f9LV14g
	0aQB2hSzH9Gi7hPc=
X-Received: by 2002:a0c:b393:0:b0:64f:69a3:af3f with SMTP id t19-20020a0cb393000000b0064f69a3af3fmr4147538qve.39.1692917156068;
        Thu, 24 Aug 2023 15:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDipOo/CIz8qHpm/CDBD32+84HdxDsjbgl3SHSyWk2220WrURlTLd2yWKpOfgAfF1ihVE+0Q==
X-Received: by 2002:a0c:b393:0:b0:64f:69a3:af3f with SMTP id t19-20020a0cb393000000b0064f69a3af3fmr4147533qve.39.1692917155874;
        Thu, 24 Aug 2023 15:45:55 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z4-20020a0cda84000000b0064f77d37798sm117561qvj.5.2023.08.24.15.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:45:55 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:45:54 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 3/5] iommu/amd: Remove amd_iommu_device_info()
Message-ID: <fs6fyv3djxgswjcll5clsddtels26neuj5t7tbulro62lciyg4@r7ohfk6o2s7v>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
 <20230821104956.707235-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104956.707235-4-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:49:54AM +0000, Vasant Hegde wrote:
> No one is using this function. Hence remove it. Also move PCI device
> feature detection flags to amd_iommu_types.h as its only used inside
> AMD IOMMU driver.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

