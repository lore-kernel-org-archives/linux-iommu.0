Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9C28F4
	for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A9tHcoFg"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-66cfd35f595so2183686d6.2
        for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696948711; x=1697553511; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8iOZjw5e08IcplVas5Qh80MTnCsr38lB0b8mKCyKBo=;
        b=A9tHcoFgPT8jgYRFjwjuztVb8OkYOcOoESu8lDkakou+2wvRSVXofYTbNl3vMownfl
         gL5pJEgYQZFQrF9hIEuNVtaI2E5hk9BSJauaHxbZy0eNCVV920JT4ndjTuYHaIH2YrQ+
         oq+yvtljJsfWcQ6xcS2vClmh9WKweFZqayZF5opz2Z0sOLyVP0QZkRoNjZtdqi0J5Jg7
         J4YqqaxXoTtj4AsOf9UGAvdnWsC0rykUSW4BfmqXCQookWzHn8hzM3OlPNr3aqNqxXy0
         uqf6dqZgh+vobxhiz7lfza/wuWT8Gaje7SqindA6+HH87UV9r85TUbVJ7k9/WH2mdBkP
         Dr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948711; x=1697553511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8iOZjw5e08IcplVas5Qh80MTnCsr38lB0b8mKCyKBo=;
        b=b/1en3FMAA7rRTczYwtrUuXWeB+JDRdfz/gyfeTcYSJ2rAsz7WEbsCSlvx8UmwCGic
         nbv7dNHakNAleKNNGpsZw2xs5TbTrfLr9atpdY2kfDADUBLkpUP7sl7uM2/B9VXfyWBL
         IRyP7tYanekTPjDHw0p6w/b9Ob/G7AST05exqSRVLaP1XYLKxhnNeLrigBAvQJ8uk3iq
         cdO/WB+nJfagMx/sp0IqzeW2rM4ueYgDFE1inLk8AF9N7He/yJEe6xr1COOW8CZob0mP
         BORLuB3ivy9+prHOjlOBZqcJbtetiukS9A3tHdr541ulH7k1MEINsidyus1VBxJBxajn
         TeDg==
X-Gm-Message-State: AOJu0YwlVGHmNTzdXtfDOcduowVVNklip26ocsz/Z5GNYMM/Y3vLfnoa
	xkx4MlcxMTDET5OldU+OPCDyQw==
X-Google-Smtp-Source: AGHT+IH18dVfztdH94C2qaM2vXW79ly4yS2Zvc4rRCTKgo5AwjVoN/u5uL9d+xExNDBEVC05Dia1YQ==
X-Received: by 2002:a0c:b45e:0:b0:656:3c00:dc92 with SMTP id e30-20020a0cb45e000000b006563c00dc92mr15842097qvf.31.1696948711390;
        Tue, 10 Oct 2023 07:38:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a031100b00767177a5bebsm4341748qkm.56.2023.10.10.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:38:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qqDsT-000Ebm-CO;
	Tue, 10 Oct 2023 11:38:29 -0300
Date: Tue, 10 Oct 2023 11:38:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 06/10] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Message-ID: <20231010143829.GA55194@ziepe.ca>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-7-vasant.hegde@amd.com>
 <ZQHRTwYN4doUte5E@ziepe.ca>
 <0d47919e-cc2c-d151-f020-e2090fd1c287@amd.com>
 <20230927164523.GO13795@ziepe.ca>
 <497df4d9-2203-ad36-a5d1-97570b327a49@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <497df4d9-2203-ad36-a5d1-97570b327a49@amd.com>

On Tue, Oct 10, 2023 at 11:32:53AM +0530, Vasant Hegde wrote:

> __amd_iommu_flush_tlb() flushes both domain ID and all devices within the domain
> for the given PASID. So it works fine. All these functions are reworked as part
> of invalidation series. Hence this function is not relevant anymore.

But the replacement has the same issue:

static int domain_flush_tlb_range(struct protection_domain *pdom,
                                  ioasid_t pasid, u64 address, size_t size)
{
        struct iommu_cmd cmd;
        int i, ret = 0;
        bool gn = is_pasid_valid(pasid);

        build_inv_iommu_pages(&cmd, address, size, pdom->id, pasid, gn);
                                              ^^^^^^^^^^^^^^^

(btw I have no issue/comments with the invalidate series, it just
doesn't go far enough to correctly support the iommu core's PASID ops)

> > Nothing guarantees that domain->id is per-device. It is emphatically
> > not, it is per-domain. It happens to act like it is per-device when
> > using the DMA API, as DMA API does not share domains across
> > groups. However iommufd does share domains and so this is not a
> > correct assumption.
> 
> That's exactly why I have been saying for SVA I don't need
> per-device-domain ID.  Current code works fine. Anyway, I will add
> this support in v3.

The threshold for upstream is more than "works fine" in some limited
testing.

It needs to correctly implement the driver op APIs we have defined in
the core code. In this regard it does not "work fine", you can see it
by code inspection that it is not producing a correct cache tag in the
IOTLB for domains attached via op->set_dev_pasid()

So, lets see v3.

Jason
