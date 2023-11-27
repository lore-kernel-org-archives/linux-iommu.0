Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F0182A7
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqDBOHrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701099692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trlRZGaWwOa4OdLh+VqMKyI2A0CG6rsUX5Pgp/NJz1A=;
	b=BqDBOHrWc0h5FqjJ3Q70rmsaOFo/B7bJZVRXHFtbxgu/IB59+4Wnd5Mbf/o9/uDKqonNdh
	guHDaWgRh34qq8EZSl555891AyPBWruvF7cmavoMt1nNuNxFs9Qi/NxgTnh9t5SbwlxPjB
	VuaOAIpU6557upXU84/sieIl+uaEjj4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-zn-7SWmCMZmUhnGFPQolGg-1; Mon, 27 Nov 2023 10:41:31 -0500
X-MC-Unique: zn-7SWmCMZmUhnGFPQolGg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a3773e271so18617106d6.3
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 07:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099691; x=1701704491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trlRZGaWwOa4OdLh+VqMKyI2A0CG6rsUX5Pgp/NJz1A=;
        b=bjrpne2JaQe9kOYO/8AJeSOsjhPzXiJjF4xChZ5gux/Tu1wLMCJ8kDGgkgThw/4e9N
         NJRP8JGO6mkV1hesDlp/8dTlWiuZql3IPYLzaQnr7cpyploFwgkR6od7oJQqiHBUNhBp
         4RFjGVpLHz8P7OS03phFqUvw+cyPHhUdokiJSC6lbkZyt8C9Rr5xe99o6E+BO0+s18TF
         3invHVjgv95aROS/N61En/+ah5RZI321qJoabEY7YtzZAcPijRcVIjRPjSxfmL5pSpng
         kFN7FduNDB/Ngxt7YVFE4gySDsJRxha0FC1c8vvkheZqlPS7Ot62PFtsRnC0HIwBuKmb
         Vt7Q==
X-Gm-Message-State: AOJu0Yze0C+n61hPIYK0fotyUp1Mw/xTT74OdZw3t68NsjTkl/eLOE/m
	kgsf0OkFSXx+LKDeJ57OCSEeCtxIHRjOOfex25rtNfIMqB73Djzap5kWgRWsOo6lxQPOGAmG2Wr
	xG0RuZXJOLHdHvBQ=
X-Received: by 2002:a05:6214:cce:b0:67a:1580:d7c3 with SMTP id 14-20020a0562140cce00b0067a1580d7c3mr18665581qvx.58.1701099690823;
        Mon, 27 Nov 2023 07:41:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwdYeuSCwaZFkmXA2r4JClIbyW6DLiolODtDtamQUhQE+K2DuC5boIrMydIesr7kyDs0Msnw==
X-Received: by 2002:a05:6214:cce:b0:67a:1580:d7c3 with SMTP id 14-20020a0562140cce00b0067a1580d7c3mr18665560qvx.58.1701099690604;
        Mon, 27 Nov 2023 07:41:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id oo28-20020a056214451c00b0067a18167533sm3323974qvb.83.2023.11.27.07.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:41:30 -0800 (PST)
Message-ID: <39f2ba60-a627-4df7-9a1a-f5c1ec12b16a@redhat.com>
Date: Mon, 27 Nov 2023 16:41:26 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] iommu/arm-smmu-v3: Master cannot be NULL in
 arm_smmu_write_strtab_ent()
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <2-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <2-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,
On 11/13/23 18:53, Jason Gunthorpe wrote:
> The only caller is arm_smmu_install_ste_for_dev() which never has a NULL
> master. Remove the confusing if.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 519749d15fbda0..9117e769a965e1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1269,10 +1269,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  	 */
>  	u64 val = le64_to_cpu(dst->data[0]);
>  	bool ste_live = false;
> -	struct arm_smmu_device *smmu = NULL;
> +	struct arm_smmu_device *smmu = master->smmu;
>  	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
>  	struct arm_smmu_s2_cfg *s2_cfg = NULL;
> -	struct arm_smmu_domain *smmu_domain = NULL;
> +	struct arm_smmu_domain *smmu_domain = master->domain;
>  	struct arm_smmu_cmdq_ent prefetch_cmd = {
>  		.opcode		= CMDQ_OP_PREFETCH_CFG,
>  		.prefetch	= {
> @@ -1280,11 +1280,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  		},
>  	};
>  
> -	if (master) {
> -		smmu_domain = master->domain;
> -		smmu = master->smmu;
> -	}
> -
>  	if (smmu_domain) {
>  		switch (smmu_domain->stage) {
>  		case ARM_SMMU_DOMAIN_S1:

