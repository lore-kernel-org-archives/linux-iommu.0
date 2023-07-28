Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE911CA0
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:47:27 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-76aeab08625so180015585a.2
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690555646; x=1691160446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=agwQ6JQlJcORnprM10A02PlJHkUdKv35qa129lEnBu4=;
        b=k/kkyS+Al/vCv5BeQqQPkc5JfqaM3hAvRA4Hn3nUriD3m2M1zW56RUeGuNB/B+j/y5
         KVv+TfWeOPwmYyjGLr0V6vFGcIv/kSolNXRPGuXPaOW3SIUb9dtMZPQUqiIrzIeF40hW
         m68d47bq8xKWN64jRICtOQ5VFO/9CqA2v6glMrey3mXTJux3ZTfbHg7uLi+oOCorpUf0
         4iknwDkxeHzvX9G8FWpf3GdGppSKpuBS665gt55ATRBp9LJ1j0zHZ76OYD4NPn7m08dy
         qxftJ0aDNt6GouZ4LnL6rqR38PkO4FjcX2gYxaUxCKrAJ0ZNe0qYb21s7LJZh8eziz/F
         r+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690555646; x=1691160446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agwQ6JQlJcORnprM10A02PlJHkUdKv35qa129lEnBu4=;
        b=I8k02tN5cy352iJF+bFlJ/DaIoBeAYxD1hqIQrYTW28/QXoeu54rVbHHl2Zjo+Zr9i
         l0qoR8VKEvpWBNqBf9+TMnBW3pigcFirEtZbygDpxidkcpddQAfZa/yk0R9qBBd32YRb
         Y8ScrA5yvZgCssL+ckGf80+rY3hGAnZMlGziI8uLpStSav0MpH2mNpmvoM/xySBWWU7D
         6HA6NEiL2qqP2AX3OQu89fH/hmaUeg4y652EE60OP3SISGQide6odkFzavA1MjKASM4R
         guHLUPBZO0wN15ff8aGa+7cxxKIlQc9zdDzWsIDc4HY7zjKxC0QB6DktVrOtRwtNDjaY
         pJ5Q==
X-Gm-Message-State: ABy/qLbNl4PlFpFcNJ8ak67KWoEpGsspcLwJGwiJpLNcynmJhf+VxxJe
	cTU85UVGaBPXbjVQoyeqWUOal3phy5rkGukj4qk=
X-Google-Smtp-Source: APBJJlG/Qth8x0kAHgd2PoWGh6CDlnhONda5DgncOQDhYtY9EX5hbSKqnDSUujrnZ+9c6ZYj27NB4Q==
X-Received: by 2002:a05:622a:211:b0:403:ed26:3f5c with SMTP id b17-20020a05622a021100b00403ed263f5cmr3433520qtx.52.1690555646698;
        Fri, 28 Jul 2023 07:47:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id s11-20020ae9f70b000000b00767b0c35c15sm1166229qkg.91.2023.07.28.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:47:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOkX-001c1H-Kk;
	Fri, 28 Jul 2023 11:47:25 -0300
Date: Fri, 28 Jul 2023 11:47:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 16/16] iommu/amd: Simplify amd_iommu_device_info()
Message-ID: <ZMPU/QOjg3HMArP6@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-17-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-17-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:09AM +0000, Vasant Hegde wrote:
> Let 'iommu_dev_data.flags' track device exec and priv support as well.
> So that in amd_iommu_device_info() we don't need to check device
> capabilities again.
> 
> Also in probe path __iommu_probe_device() updates dev->iommu->max_pasids.
> Just use that instead of calculating max PASIDs again

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
