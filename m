Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597613AC7
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:49:12 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-409ae93bbd0so45218341cf.0
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691509752; x=1692114552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zmJhODYM55C1GF8fxBi666CIjzAmp+0CfxlCkcGvB8=;
        b=HHQGldvJPPWlfnSlicrGNpJICwepnH7KAN7k4+/yKmfquRdvRysTR9KjqVzArNxX6y
         KChRvlOkDII2txW9gEh5QJngp1rQTbhNcB8ng/v5a+QtGUQvi/bX2QLRYShmhca87QBH
         +eIfRSDquYlbLut7IFMjWoI1atvCOuVzZtONhvjREuNKeFt54/vquQCPpWP+bCksJfXa
         FwofqJlisLcBsynZecz9ACJ3blEOgxnNhbYOoKK+FaeD88TuECKOpuZyc+bduf0z4BA5
         MM/3XGbqST8fQ9jFdv3/2d23F+FYGHqOO4KftFxzW33Wrb+viRcQIX6VoMsBfnC9eK2I
         pPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509752; x=1692114552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zmJhODYM55C1GF8fxBi666CIjzAmp+0CfxlCkcGvB8=;
        b=S805shqF+DT7N6UBEQuyUeePXAjFNz1bvZDbbSOErGgj2nvE3MEdw0faTaCpToMPkY
         bDjOg1pBOGjODPX8iO6x5M2me2zm/Y5tls0wUoiCt30QN/wtnqLKmaPpw9YQU3YRx8nr
         6/scS2ipOMIMV8aeydk5fcYu8TIzbWkNRau3mBzOwtP0U8vG03omgJ8TWSk+Y3HIKB1v
         o36kKWsFY+13AmYQd3gyaRg23FZAgDXoNPcIhghbSuZd9mR5wl1Ej40BjVMh8s1cMVTb
         7WoEw4/ArcE3JH7x+ifXr6C4Hg1Aca1oOpo5gE7twaZtEoUCX1ScMSbJ51FoH6v9eDqC
         87jQ==
X-Gm-Message-State: AOJu0YxMjCQH0Cpwe3MqilDXvtFzC1vMwoUYRb+eiQqBQi9yb2jfMGKn
	Czy+Y7i6YvFblUXu3u/ey9D9gQ==
X-Google-Smtp-Source: AGHT+IG2I4h+3WawfhL7YWjZ2IOykzDAUQEGG+JRa/6Hf3pEDP2cXCYhjw3an8vokq0jbpRXpKcZOA==
X-Received: by 2002:ac8:5c89:0:b0:40f:c669:a130 with SMTP id r9-20020ac85c89000000b0040fc669a130mr122466qta.36.1691509751969;
        Tue, 08 Aug 2023 08:49:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a5-20020aed2785000000b00407ffb2c24dsm3457883qtd.63.2023.08.08.08.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:49:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTOxK-004dTJ-Uj;
	Tue, 08 Aug 2023 12:49:10 -0300
Date: Tue, 8 Aug 2023 12:49:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 09/11] iommu/amd: Introduce helper functions for AMD
 IOMMU v2 driver
Message-ID: <ZNJj9ljbIM842lEh@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808100232.5977-10-vasant.hegde@amd.com>

On Tue, Aug 08, 2023 at 10:02:30AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Introducing new functions to init and uninit v2 domain. Also setup /
> clear GCR3 table. These functions will make necessary changes to
> existing domain to switch to SVA mode. 

Huh? "necessary changes to existing domains" ? That shouldn't be
something a driver ever does.

> +/*******************************
> + * V2API-related helper functions
> + * Note: Separate these out for now. It will be removed when
> + *       deprecate the AMD IOMMU v2 API support.
> + */
> +int amd_iommu_v2api_domain_init(struct protection_domain *pdom)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&pdom->lock, flags);
> +
> +	/* Only allow v2API support on pass-through domain. */
> +	if (pdom->pd_mode != PD_MODE_PT) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	pdom->pd_mode = PD_MODE_V2;

Wah?? You change a PT domain to a V2 domain? That seems totally
nonsensical.

This is continuing the wrong direction of the old code.

When you first create the GCR3 table you have to inspect which domain
is attached to the RID and setup the DTE/GCR3 accordingly.

You don't *change* the domain that is attached to the RID (other
things might be using it!) You just note that it is IDENTITY and do
the right things.

This should all be part of generic code that is working with the GCR3
object, not here in the v2api section.

Keep in mind that the API flow is to get a 'ref' on the GCR3 (eg
because the caller wants to put a domain in it) and a pairing 'unref'.

eg if it was already a v2 PT when you want to attach a PASID then
great, the device already has a gcr3 and so it just keeps
going. Having a PASID will block the GCR3 from being freed and it will
block V1 domains from being attached to the RID.

When the GCR3 becomes fully unrefed then all the PASIDs must be
removed, the RID must be an IDENTIY and then the driver can free the
GCR3 and reconfigure the DTE back to IDENTITY. Otherwise the DTE
points to the kernel owned GCR3.

Jason
