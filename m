Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16A8483
	for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 19:23:39 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id u10so4544913wmj.3
        for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 11:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKfwFWPx0mrSaDUSu+IwD5rq4TMnBt0i+kbnmd2g5/o=;
        b=fKOFy+nxE2mxy+0q4b3+SYDPuE4uFMODmK1JmAKI2/Nk498QHkmjMLG1xKbT7lDMxU
         WxcT2uc8nwtbsNxkhcXQVlLpZp0tcmKK5G/FTqSxr2bvnq5hQ4xMDcqr+5DbHOJgw0ZC
         pCtBxHz1JGtDBnaEJ0GBulsNhJnI7n1DeEBu0LNBbum2CAZofI7qLbdfQj5LbJaw+zdo
         HQcsF8FWmO7quEzsA9FWhKm9A7Bci4VWehUxYVx4zwBebKmZusFljhmFD+Xj1YE+wpnQ
         W+SaLU+E8mh9Tg98ERLKvg9bOS974FB7MNZtL/IYLRoPbv5uM2K2qAKApcQq6An4KCa6
         wAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKfwFWPx0mrSaDUSu+IwD5rq4TMnBt0i+kbnmd2g5/o=;
        b=gaFy0tv4eRuJdO4AdwID4DPuuvv3oX/568di37awlpaVKB4VytWjjR6InyqmdyHy6P
         0PpqMKgp0b5DU9f708YrmhbWGCiGZ5ejiR2bFKUEiLdt3a+NVjAdoDOr4C5or+sJfY8t
         hpwxKum9n6KJGH+E/v+NeKJr3znYJ56HJn3vZzHO599ZDgIOOFRffr/I4Y1Rz9SZsJjS
         +L3TITF0lbEbbNIcPufm5t4HHE/JERlEaLrAXYT1lZBLXM0+zEJbSX2nJQZ4Kgbv8c2K
         Qc2tus0p9Oas3AJPfKt4s9kURb990/OPfQQqL6Uy2v5nQpcNrHDKhdwnF1abUDGv0C4E
         7IDQ==
X-Gm-Message-State: AO0yUKV2YAbpkC8I/brWYGHVRsdSH45Nd50kj6XcRZVVs4j4V5sc99yn
	nShtZy8n86Lt85SKaIoRCWpjSg==
X-Google-Smtp-Source: AK7set/tV2rdWgmvhNxuUBbH5Kp+VjGk9gubEi8GFZRRtNk7BxFlPuMUDMhx4sndvqkKHAXXt1J4sw==
X-Received: by 2002:a05:600c:b58:b0:3df:e752:35ca with SMTP id k24-20020a05600c0b5800b003dfe75235camr17613840wmr.32.1676057017763;
        Fri, 10 Feb 2023 11:23:37 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b003ddc781b1d4sm6466877wmq.33.2023.02.10.11.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:23:37 -0800 (PST)
Date: Fri, 10 Feb 2023 19:23:29 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, james.morse@arm.com,
	suzuki.poulose@arm.com, oliver.upton@linux.dev,
	yuzenghui@huawei.com, dbrazdil@google.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 42/45] KVM: arm64: pkvm: Support SCMI power domain
Message-ID: <Y+aZsYDYUGuhTVrh@myrica>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-43-jean-philippe@linaro.org>
 <Y+JRl3WRwzDJOe2J@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+JRl3WRwzDJOe2J@google.com>

On Tue, Feb 07, 2023 at 01:27:17PM +0000, Mostafa Saleh wrote:
> Hi Jean,
> 
> > +bool kvm_host_scmi_handler(struct kvm_cpu_context *host_ctxt)
> > +{
> > +	DECLARE_REG(u64, func_id, host_ctxt, 0);
> > +
> > +	if (!scmi_channel.shmem || func_id != scmi_channel.smc_id)
> > +		return false; /* Unhandled */
> > +
> > +	/*
> > +	 * Prevent the host from modifying the request while it is in flight.
> > +	 * One page is enough, SCMI messages are smaller than that.
> > +	 *
> > +	 * FIXME: the host is allowed to poll the shmem while the request is in
> > +	 * flight, or read shmem when receiving the SCMI interrupt. Although
> > +	 * it's unlikely with the SMC-based transport, this too requires some
> > +	 * tightening in the spec.
> > +	 */
> > +	if (WARN_ON(__pkvm_host_add_remove_page(scmi_channel.shmem_pfn, true)))
> > +		return true;
> > +
> > +	__kvm_host_scmi_handler(host_ctxt);
> > +
> > +	WARN_ON(__pkvm_host_add_remove_page(scmi_channel.shmem_pfn, false));
> > +	return true; /* Handled */
> > +}
> 
> I am not sure what a typical SCMI channel shmem_size would be.

shmem_size is large but a SCMI message isn't bigger than 128 bytes at the
moment, so copying would certainly be more performant.

> But would map/unmap be more performant than
> memcpy(hyp_local_copy,scmi_channel.pfn,scmi_channel.shmem_size ); ?

The problem is that we're forwarding this to the SCMI server, which
expects to find the command in the shmem.

I took the easy route here, but a more efficient way to support SCMI would
be for the hypervisor to own the channel permanently, and the host<->hyp
communication would use a separate shared page. The hypervisor could then
copy from one channel to the other. It requires more support in the host
driver so I'd like to see if there is any interest in supporting SCMI
before working on this.

Thanks,
Jean
