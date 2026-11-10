Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316946;
	b=h6AOTJJIixGh7g3lHeLO9Y3xY2MxzGQuxrwgzRZIsx3vL5du2Q5oQ5lN9SXcDJfvB5ZV
	 sHvn+H1hTK71qsfl2yiAug/qHoUsyuzrBnTpYYcsH4GCxRZZx1ixAORM1/XZny4KcpR7c
	 ZR3TJr2eqUMQvyfESPUB3+6t/iELdur/bVaNI1pstJxkys2w3hyb2P5OlVVtXQKYvFxz8
	 LcRX5jbx3MV4T53YvL20o51jGVV5bDY2yu8277RGfMMUkPvmKk6YBRXUuNSrxR9Xf5vnS
	 JauuLg3i16etU6oev8/bccE/K+/62ftha6HZOzzPsNxVJUIKVVeQyKiZm3qBgBML8Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=g75W/bT+6sBq3ZuteoFUFS+Co7pEE7nkrsl0KkNU8Gs=;
	b=nUQZb/soriqSwVfQS5eHdCUxK9ej6mWhMtzeHhBroaF1SIZUyiman4H8MebZwYMuoh8m
	 hfOumlvhZ4k0jiV431mu/ZKIamKf7xkqoCE9GA7sE53d40PIwDChYoNMFln7iCyHwEkMq
	 fkAiD7zs8f3OVYmIODrhhuUvPFbjLLwinO7rhUeg2pc6TLdUs6q9dlYIxWCILgmmYUxvc
	 qbIGu8UqKqeteaF9vSP3jjlFhrcUxreVshhzGdDcygxgN1GyXk6YqGWoPv4VbE3X+3Wk6
	 MnLqEjXdr5DUNHYSgZEJAQfCjpuNgj4wRTErGsBxZDFUG2SONLEyI/Phn4lA7beGc7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aSzvyDVl;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD869606A7C8
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 13:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD869606A7C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aSzvyDVl
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-930c0f9c1b1so203440085a.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 05:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794316945; x=1794921745; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g75W/bT+6sBq3ZuteoFUFS+Co7pEE7nkrsl0KkNU8Gs=;
        b=aSzvyDVlbIk6YqIhXCyDjPYOK45CdHNw/AZGOLGuwOPL4UKL28O3bB3hKrnchNSpiC
         MewdaOvvlLuGkHXp2DyXhHMwZ3mSCZ9QivneNRToave44CSctiV04xw+mnV+VMBRPE+8
         PxRgut3fgQR+3PtlxXOcxqsvpPGVRqQvQaTUiWGiutHdwBFHu81V/mWxYaoeG6f6ZaZh
         gOTRxXrHJbXAB+T75xNftYnxwOMM7qeBq0nQAjsdHGlYDaG69zVZ/jkI32kaF1vpo4aT
         9JMZqUvRn/o9jmEPQ0gcZDzfI8W9ZEaP4t3+RmobWbj0/Qd0MddbdCez6XLJR7SeU/2i
         Ig+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316945; x=1794921745;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g75W/bT+6sBq3ZuteoFUFS+Co7pEE7nkrsl0KkNU8Gs=;
        b=0B1t94dOb+pjyzwNWR3tP9KwBD/B2EXhYa6E4STT/xCwPdVggNsFdnIM/RhCqzqj93
         jDkJpqJIDwAtP4Hi0KJ/w/ph8Vav77M1d0FHxpDcoIBc0KtHJvIGeB8cOcth1vsmUJ6P
         tLru3quR+dbnorKTNq91TPckYnkIHJNEPYWbTv1i0AbEYI1dp1kbP+uaS2c46RFgjNiE
         KyNPrfAO7n5A6I1fXNbVTavgVEQd/5TDyOjzRkV+fGEkMuT1pWI7P4CuoqvkCIU7SIUf
         BtXq1cb4Wb6qENOu7fhEGZyOqdZ9iJqdAfSGUhy20ss2rk3ihEBQc3fg9Bj2c4tQB2Db
         gmFA==
X-Forwarded-Encrypted: i=1; AL+hErFvvxDJ/lNC00LThnBM9khptnUb1m5wjynoLJHNjakIprM5CTIY+wGb/sKrZsR7ZojuVirzPQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9B7COIMoh5FXamR7EGHR6loUbHuAJu/li/WSr+b+7k63So8NRx
	75OYWeY97IpFIhDtnf856Le5zE4gXuegFjFLjRqla56Xf3pf/0acID8svRaE6kKGpL8=
X-Gm-Gg: AYBFou0nBVrkST9bofNJcxDuIesN7N/r8GrR6LaccURKltm5/iNEIcq4unRj0+g7jww
	9cHfETJUappiqaeMUEazBq5rRUYe8Pipd2DvCT+qFUneeMB0uQH3d/hNkcXui2Lu51an1G9Qldy
	5TAK5XYamoZtGw8HX/6ocRJAkByOBsBJukjQ7q3nC5aw2n58p4ocYJ8TMJa/DT2X6xGugnNp+vN
	rm053bQ/VBOoLCKQL4L0+3L5HjIFrZYtShyGBvOuv5kTYgsFO9CDF5HD0nw35w+vdlwPbiHzLN6
	xRtRzSYG0+aLeSu1GZawdfu9pkeCTRPBnPvYxYxLbun7uKEd8sgPZ4zWSppeDpGBFRxs3aoPSAN
	jPbmxXwx9+w/rdSWRk/O5tzmxuvYKfCo63McWxmlCaFraBCdBrY7T26QX4cQuk3L2mEWwOQ7+8d
	XGAH4KDK0vOxjWEWk0A9tuDIoFAZc0MQZAin+vyIpY0Ga5Nq2wogfc3a6TE/X3esDUJcW2r4Oyv
	5yBJmFX+SGlpWIrT9y5zBScp1/6FZqp4NtWD6eEYXd7S/U46cdu6iIOKwRjrTJ/V60mF8FHvZPC
	gHt5HpGHa8tkz44LeuairerZsr2KSNDpHKtFN67F2o6uwxtQoqUSotAMJZ09NflFfIPW6bLyeY8
	IXIdhagomMTI=
X-Received: by 2002:a05:620a:1a21:b0:93e:c12c:43fd with SMTP id af79cd13be357-9479f373debmr404603885a.74.1794316944696;
        Tue, 10 Nov 2026 05:22:24 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7915e2sm220546385a.23.2026.11.10.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:22:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQlnr-00000005hfb-1yLA;
	Tue, 10 Nov 2026 09:22:23 -0400
Date: Tue, 10 Nov 2026 09:22:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <20261110132223.GX663069@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
 <ausIn5Txiy1uRjkY@google.com>
 <20261104170816.GS3889730@ziepe.ca>
 <20261106130352.0000638d@linux.microsoft.com>
 <20261110005259.GU663069@ziepe.ca>
 <20261109224200.000033c6@linux.microsoft.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109224200.000033c6@linux.microsoft.com>

On Mon, Nov 09, 2026 at 10:42:00PM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon, 9 Nov 2026 20:52:59 -0400
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Fri, Nov 06, 2026 at 01:03:52PM -0800, Jacob Pan wrote:
> > > I am not stating that it will break UAPI because of blocking domain
> > > is used. What I am trying to say is that with the blocking domain ->
> > > external transition, we do not need a new UAPI for external attach
> > > for non-CC. It will just reuse the existing UAPI.
> > > VMM:
> > > 	do_ioctl(vfio_cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT,
> > > &attach, "VFIO_DEVICE_ATTACH_IOMMUFD_PT");
> > > hv-iommu-root: external_domain.attach_dev() will do the hypercall.  
> > 
> > You've basically described a wonky NESTING domain.
> > 
> > I think you should just use nested domains for this. Even though there
> > is no S2 make it possible to create a nested domain through the
> > viommu..
> I didn't use nested domain since the current parent hwpt is a paging
> domain which cannot be used to express the external attach semantics.
> 
> Are you saying that we create a parent-less VIOMMU (in Aneesh's patchset
> and my RFC), and modify the iommufd core code to allow nested domains
> to be formed with an externally managed parent? or we expose a
> opague parent S2 that is not paging domain?

Just use a null S2 for this. If the viommu was created without a S2
then the nesting domains should be created that way too.

Once you do that you have a normal HWPT representing the S1
translation in the guest (identity to start) and everything works the
normal way.

The only wrinkle in your setup is you don't have a S2 at all. Not even
a placeholder.

> But if we go with the nested domain route and let hyperv iommu driver
> handle the nested domain attach, it still would not work for pKVM.
> pKVM's root SMMU is emulated, so it cannot do the external attach
> hypercall in the unmodified SMMU driver.

Yeah, I think it is fine that the hypercall is not part of the smmu
driver..

> So I am willing to entertain Mostafa's approach to park the device in
> blocking domain, then use hypervisor provided viommu/vdevice ops to
> invoke device external attach hypercall. Basically, move the
> attach_device to external S2 operation out of iommu driver to the
> hypervisor code. It does not need domain ID or anything IOMMU specific.

Right, though in your case some co-ordination is probably helpful
since things might go strange if the hypervisor side and iommu driver
side disagree on what the translation is

Jason
