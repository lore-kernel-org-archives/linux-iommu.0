Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD4168DC
	for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 13:55:07 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-763ca800ca9so168965485a.2
        for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687442106; x=1690034106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVZalyO3VvQ4Y6z2KOMcAowhfJuzatXntfQ51wQHlEI=;
        b=QxybyvCx/eRWMYx9rILbcQc2hAApT80Q47N+ngkVujzFdwD/3X1ftyGke41uAFeXkm
         MICpA35ZvIFTFa7Qf839aVuhofW1SbCJb3qlBeQZnOAJwp4+On7mClo9iwY9kwL/j1ue
         KVtB8I+JMWNYtQvfmTYDi7CMsfSy8sUuz0zgn4LhRepjGkvQYstGiJaE0VUkmryp2A0j
         lUXFk2pCH7/0T+ywkFs7xEWiRTKd1Q/2zmQvsL6P5id8AHHkCc4cglPGuxgrvAd5GPiY
         stBdxGwYWwckmu6zN3iwujpKTbOxguQpb/7YqiSu3HlY37gTTZRrThK1hlVUPGF6Y1jg
         eQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442106; x=1690034106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVZalyO3VvQ4Y6z2KOMcAowhfJuzatXntfQ51wQHlEI=;
        b=AZN9CXfHpT4vQ8Ymy83idBL6agLziY+283MS1infw8N+OgXoMIlDBGMEUDH0WGexGn
         vNFGPVLFKZQKD+0ATYbETpA0ZQkC0EvrBYOeTt+ZOi2hZkba7sVXeVNbpm2M7zKIPl7Q
         PU/QNdj2/SigB0l2qHtEQO1MwJSjthzTvGMmqg77/5nu6MWq9dyobLXtIu0cGijF+YgZ
         JEmNGaR7HzSM1ekfhxrh6bc2oxyzC7IdqjLDurQMpI+N59lW/ifb6pWeSnEQVcAedYxt
         olFpJAPcRqcZzMfLA6ZVmYbFieX04AjKIpRKY2MQStRmnDNtZVtingW4TF3fJwaTPSti
         LE9A==
X-Gm-Message-State: AC+VfDwpQSZcsOpv5E9i8RVwHSal6cigr+h8qEETzkIxG/S7A6bpK1h8
	zfKmqGA/GO8ha0PwE+N4FcZz0Q==
X-Google-Smtp-Source: ACHHUZ7HmoY/5c5oj5HR+NVMJVJnrFtnqhYZrKj9e1u5xRM0aKawrXhQ/X/3Xeem/FIX1dTnjp2oag==
X-Received: by 2002:a05:620a:2a68:b0:765:404b:b915 with SMTP id q40-20020a05620a2a6800b00765404bb915mr464289qkp.53.1687442106146;
        Thu, 22 Jun 2023 06:55:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a11b800b0074d60b697a6sm3446882qkk.12.2023.06.22.06.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:55:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qCKm8-007nPF-QF;
	Thu, 22 Jun 2023 10:55:04 -0300
Date: Thu, 22 Jun 2023 10:55:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH v2 iommu/next] iommu: Fix default domain setup
Message-ID: <ZJRSuBsVBVSi8Swn@ziepe.ca>
References: <20230619084945.6427-1-vasant.hegde@amd.com>
 <13d072e5-df86-d3c8-6742-e52b66fd96a4@linux.intel.com>
 <ZJGQsWXkgTuj7xC1@ziepe.ca>
 <13b8b3a8-4dc5-7e61-4e0b-f545a3679a8a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b8b3a8-4dc5-7e61-4e0b-f545a3679a8a@amd.com>

On Thu, Jun 22, 2023 at 10:29:58AM +0530, Vasant Hegde wrote:
> Hi Baolu, Jason,
> 
> 
> On 6/20/2023 5:12 PM, Jason Gunthorpe wrote:
> > On Tue, Jun 20, 2023 at 02:31:43PM +0800, Baolu Lu wrote:
> >>>   err_restore:
> >>>   	if (old_dom) {
> >>>   		__iommu_group_set_domain_internal(
> >>>   			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> >>> +		group->default_domain = old_dom;
> >>>   		iommu_domain_free(dom);
> >>>   		old_dom = NULL;
> >>>   	}
> >>
> >> The err_restore branch doesn't work if old_dom is NULL. We have no means
> >> to restore a group from a successful first-time attaching to NULL
> >> attaching.
> > 
> > Yes, this is what I fixed in my alternative version
> 
> Not really. Even your version has

I though what Baolu means is that it crashes in some of the cases.

> +err_restore_domain:
> +	if (old_dom)
> 
> 
> Only first time we will have old_dom is NULL and this functions returns error
> code. iommu_probe_device()/bus_iommu_probe() handler error path properly and
> frees resources. So I think this is fine.

Yes, the design is to leave it as-is and know that the error unwind
will fail to attach the device and free the domain after
release. There is a comment explaining this.

> @Jason,
>   I'm fine with your version of patch as well. Are you going to send proper
> patch -OR- do you want me to respin?

I was hoping you'd test it and can you share the oops message?

Thanks,
Jason
