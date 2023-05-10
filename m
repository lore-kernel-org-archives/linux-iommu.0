Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCADE125B8
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683733050;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIZ5R0R1UQfkowNLwICZ300tn7bItysSdexUg4jQHeA=;
	b=DP6rbK7aOECtosPh4GCcve0LDT3QwmNxBUke7CMRMGNK1BY2cHWkOMEhAvtKobT48JL8JG
	VUDJKOm2rJVtUIDzXKVbyM6F6k2sA+mBz7k8K5LmCGs2lzX3jW9XjxTT/f3ZUVLOr2vngB
	YXwtrzZ3TsofT+lKKrA4Bz6Lr0Frg1U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-iMDYbfgmOZGj9tzOas2QsQ-1; Wed, 10 May 2023 11:37:29 -0400
X-MC-Unique: iMDYbfgmOZGj9tzOas2QsQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3ef44f554b1so44943381cf.1
        for <iommu@lists.linux.dev>; Wed, 10 May 2023 08:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683733049; x=1686325049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIZ5R0R1UQfkowNLwICZ300tn7bItysSdexUg4jQHeA=;
        b=iLfxJT7Dvoh04EuDeSU+rJ00TXH2uSiD4XHnvTs8OyPZLY35NffLAkEFJGI0klYRqc
         tZsIo4bqk+w4JeCec9uWp/f1DIouQBOfj9FMzy92AE7NxRS/uNp/ygrdG1jJPBncwbKw
         Gh9OmY2V6dHZ4UkSP42Prn+53HPH4LNAvbx0VjBfdfeIevPSFPVxXEJZYL2uH13Uo0eX
         VFJN3S7HNdvop1I3y9D7CLxpDFVTLrU2BTSX0n7OhrZrwknMRIKstO5uaL9hqBdYOHEX
         Od2QvNNsaH/U4aasi6RLfXpqfPzzJ5OFukfmOUEC7+vhSd32Ur+JJ7TNofIhLlx4jDUj
         sr5w==
X-Gm-Message-State: AC+VfDxFGrgRXdFY7iyZph0Hg2lc7fQwByk1sweIkVjOdlQICqTT+x4R
	9lbp1AwXvpMBXgzjlQJKZ8mvJnbKy4c5TpEyKsJLwLbVIjwsSLnQ/U8ZQC11HWzcLwUnl/icjYC
	F4zIyLueWdpcIxMo=
X-Received: by 2002:ac8:57c5:0:b0:3ef:54c9:170c with SMTP id w5-20020ac857c5000000b003ef54c9170cmr26382878qta.65.1683733049228;
        Wed, 10 May 2023 08:37:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7x4Nh/Th0I2IjTD1CuHQU/tchDx2COUk/jt7qdEJSagD5mjsOl3ihA6veijLUrqWhgtGmMzg==
X-Received: by 2002:ac8:57c5:0:b0:3ef:54c9:170c with SMTP id w5-20020ac857c5000000b003ef54c9170cmr26382836qta.65.1683733048911;
        Wed, 10 May 2023 08:37:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id c23-20020ac81e97000000b003f38b4167e5sm1487432qtm.2.2023.05.10.08.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 08:37:28 -0700 (PDT)
Message-ID: <e58c48e0-6339-41ec-e65b-e3104c65bb81@redhat.com>
Date: Wed, 10 May 2023 17:37:22 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, akihiko.odaki@daynix.com
References: <20230414150744.562456-1-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230414150744.562456-1-jean-philippe@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jean,

On 4/14/23 17:07, Jean-Philippe Brucker wrote:
> When an endpoint is released, for example a PCIe VF is disabled or a
> function hot-unplugged, it should be detached from its domain. Send a
> DETACH request.
>
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 5b8fe9bfa9a5..3d3d4462359e 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	return 0;
>  }
>  
> +static void viommu_detach_dev(struct viommu_endpoint *vdev)
> +{
> +	int i;
> +	struct virtio_iommu_req_detach req;
> +	struct viommu_domain *vdomain = vdev->vdomain;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
> +
> +	if (!vdomain)
> +		return;
> +
> +	req = (struct virtio_iommu_req_detach) {
> +		.head.type	= VIRTIO_IOMMU_T_DETACH,
> +		.domain		= cpu_to_le32(vdomain->id),
> +	};
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> +		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
> +	}
just a late question: don't you need to decrement vdomain's nr_endpoints?

Thanks

Eric
> +	vdev->vdomain = NULL;
> +}
> +
>  static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
>  			    int prot, gfp_t gfp, size_t *mapped)
> @@ -990,6 +1012,7 @@ static void viommu_release_device(struct device *dev)
>  {
>  	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  
> +	viommu_detach_dev(vdev);
>  	iommu_put_resv_regions(dev, &vdev->resv_regions);
>  	kfree(vdev);
>  }

