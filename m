Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EB3DD536
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072577; cv=none; b=QY8X5573cf6Fg8PScT47CX6GrY7KVK90fsimZSgsmTAylwSW/3SvFJdBPSHIxCcjcGpQfvZR9nVOGbpVQ9dOg5detcpl4xQnWahLwRuA+TtVm5DnoVSutcJwXzuFuRCNrWpvwZ1Mgt3w5RuouGMFqLU+znX94pIDa6N2PES6dYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072577; c=relaxed/simple;
	bh=1s4jCvq8oe7L8zTPt/8najNSgGP1x7KJi9la/FnhfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajhvZB7Rr1CZj+9UtvKOYCi7ilfodeJAOb69XsUWNVU9ylwlSTgD9M+h3OCbrw9OluZDbTZCLpXkgejgp9MNare9SY8C2Vmsa6IdbJgrgx46C4jG6rnw9cv9K4EtFX51l301jZqHMhGIKoWCxoI9Jt49IYZuVmzgGYG6bFOQ80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNTRrKCH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNTRrKCH"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1265ad.0
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780072575; x=1780677375; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hkl9oyaLQGMd1OIG8CqahDq2VdYTq3MPtBcULn0MWsI=;
        b=sNTRrKCHxMaqainzfbzn7OZveFQYaDtHEErwLhCVRBsW0BGzWIqscKQLNhXh/Lg9nB
         4s/nIWWx70k1BNZC88i1rB/NuyKjjjOaCo5nu4oJeiqp5pu6vibbGs+gkSjdSz+9f9EI
         pa58B8WFzPcY0r3p+Elb31/0eowfY1TH/Z6nZq9IYzyS9mpF8lcJqtxyWpaXyLFW4bxf
         p5VdU1dDSgNBSCfQAW7i5YwM6Ra0KUMH2/wTT5kF59yIVDUoBlC4+KVTgPe3WcSM/8rg
         xvKS7TEvdMq1IIMDTxbOwN58jPQwScfdhQIbmQSwhb7JzTly6g76mlgTSwes5lp1bHIB
         aKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780072575; x=1780677375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkl9oyaLQGMd1OIG8CqahDq2VdYTq3MPtBcULn0MWsI=;
        b=Qsl97qs9up0rEZ39/vqsLh4uuuPpnD+3R+1pwThxJmSMS6O1fAvCIbv9I/k2epsX2t
         TVKEU5SRM+bLFTKBveQY0sCOZXG8+zS5FXcRa1Aqv94P5WS6RepciPpKElJ3aCQHusJO
         o/Bde+uBrOgjxuQVywnkvvD7pteTPO43r2R1xRs3rESsuekbpaTlKstCMXAMsIwf73fy
         IW+5lwk5MUMUqTm94u/FCKmHJ5v0sFlKQEpAnM/EBw0HCfjO2Mr5ArGAeUW36kuz+7Qm
         XaGNxoSnr2ORzBpno3kLSSvyGbcfn0LyXEQnOo6D2pTNlCu8gwMd/S47CqXzYA6XqjUR
         mX8w==
X-Forwarded-Encrypted: i=1; AFNElJ+kkD5IlX4wOl4m3CW2tbSq0pYc6eXAtXniOgyCxfUjUjaeMpf9VZXYgUl+KpMyEE62jJgplQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyW8sikmWnwQBgoWz9E54nSvl1wxDEcCjyGAECTVFm5cnPIntHO
	GoFuZBvMsNWrL5LvnQA/pVKR8+flxvB0SVlvtHFjrFvX1nj3OhecouhtSCbBaOCQUA==
X-Gm-Gg: Acq92OEOkvNITEGvNx0mjRDccIWpxWZgfYGojEbzYGjUAU10kUZMlu9o+Cv2CEwH+Xz
	Uc7isKXD3zsnbovSZjRnSBeJsUoVoT2icj2j4QZ3dfcni+lzp43vPmUt+SSspqLTlVU8/hgEHGI
	DXxFsH5+Ilon2C7mzfmO76OPMmxONkqfGoCHEDxaKocnttakX89BWefhAwDjXLahbNzFHAhDNzv
	I+dK9pmVusk30FtBEy/1mYCN9RkzAfEBBciA8+Wvwjg4nw5T4Y1zd4Un4RDbDD+OA1CfWBODnSX
	/jzXPyMJbg5cJWFJLX9dHjcPZ03Au/gzWSlW2uR7vl3jZasZCTBd7zsYEiaBZB4wPMan1hrG+Yw
	TJ+cjwgBk0l7zgqzPuINQHV9BiK3qPi9RnYrNxtlnEF3vDn/lfqx7CFRIPSVkhjTRH2DBJ5PVOk
	Ho+H3dxw67vKEhQJomQGS/dxkccd8DgkMgurKHILFw1iShVsL2wIeSrkVVrGbTexcNookOSQ==
X-Received: by 2002:a17:902:ce92:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2bf22eb614amr2015775ad.11.1780072574937;
        Fri, 29 May 2026 09:36:14 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e5d83sm26696345ad.8.2026.05.29.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:36:14 -0700 (PDT)
Date: Fri, 29 May 2026 16:36:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Pranjal Shrivastava <praan@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 01/16] liveupdate: luo_file: Add internal APIs for
 file preservation
Message-ID: <ahm_DQDCEMAIhSDu@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-2-skhawaja@google.com>
 <agr6yoyYYq2QFxjL@google.com>
 <agth8vZh96TfEYl_@google.com>
 <qlvj2ljrlj6vlbto6dyqkdofrklhb7erjex7xg7ei5jils5mx5@7hqisoqevqfi>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qlvj2ljrlj6vlbto6dyqkdofrklhb7erjex7xg7ei5jils5mx5@7hqisoqevqfi>

On Fri, May 29, 2026 at 04:12:20PM +0000, Ankit Soni wrote:
>On Mon, May 18, 2026 at 07:08:01PM +0000, Samiullah Khawaja wrote:
>> On Mon, May 18, 2026 at 11:40:58AM +0000, Pranjal Shrivastava wrote:
>> > On Mon, Apr 27, 2026 at 05:56:18PM +0000, Samiullah Khawaja wrote:
>> > > From: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > >
>> > > The core liveupdate mechanism allows userspace to preserve file
>> > > descriptors. However, kernel subsystems often manage struct file
>> > > objects directly and need to participate in the preservation process
>> > > programmatically without relying solely on userspace interaction.
>> > >
>> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> >
>
>[..]
>
>> > > + *
>> > > + * Context: It must be called with session mutex acquired of a restored session.
>> > > + * Return: 0 on success. Returns -ENOENT if no file with the matching token is
>> > > + *         found, or any other negative errno on failure.
>> > > + */
>> > > +int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
>> > > +				 struct file **filep)
>> > > +{
>> > > +	return luo_retrieve_file(luo_file_set_from_session_locked(s),
>> > > +				 token, filep);
>> > > +}
>> >
>> > Nit: Shouldn't we export both of these functions via EXPORT_SYMBOL_GPL?
>> > Since, these new APIs are intended for kernel subsystems to participate
>> > programmatically, there could be IOMMU drivers (or others) that can be
>> > compiled as loadable modules. Thus we should export these APIs via
>> > EXPORT_SYMBOL_GPL(). If they aren't exported, any loadable module
>> > attempting to use them will compile successfully (due to the header), but
>> > will fail to load at runtime with an Unknown symbol error.
>> >
>> > IIUC, if a function isn't exported with EXPORT_SYMBOL, it remains hidden
>> > inside vmlinux, (i.e. it isn't in the kernel's global symbol table used
>> > during modprobe).
>>
>> Agreed. Will Update this.
>>
>> I think there are other LUO APIs that are not exported and can be used
>> by modules. Let me check those also.
>
>Hi,
>+1 to Pranjal's EXPORT_SYMBOL_GPL nit, and I'd like to extend it.
>With CONFIG_IOMMUFD=m && CONFIG_IOMMU_LIVEUPDATE=y
>the series fails at modpost, not at modprobe — kernel won't even build:
>
>  ERROR: modpost: "memfd_get_seals" [iommufd.ko] undefined!
>  ERROR: modpost: "iommu_preserve_device" [iommufd.ko] undefined!
>  ERROR: modpost: "iommu_unpreserve_device" [iommufd.ko] undefined!
>  ERROR: modpost: "liveupdate_register_file_handler" [iommufd.ko] undefined!
>  ERROR: modpost: "liveupdate_get_token_outgoing" [iommufd.ko] undefined!
>  ERROR: modpost: "iommufd_liveupdate_register" [iommufd.ko] undefined!
>  ERROR: modpost: "iommufd_liveupdate_unregister" [iommufd.ko] undefined!
>  ERROR: modpost: "iommufd_hwpt_liveupdate_mark_preserve" [iommufd.ko] undefined!
>
>Two issues:
>1) drivers/iommu/iommufd/Makefile (patch 12) builds liveupdate.o into vmlinux
>   instead of iommufd.ko — needs to be a composite member, not a top-level obj:
>     -obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>     +iommufd-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o

Thanks for this, I will update and test this.
>
>   This fixes the iommufd_liveupdate_{register,unregister} and
>   iommufd_hwpt_liveupdate_mark_preserve errors above.
>
>
>2) Beyond the two LUO functions Pranjal mentioned, four more vmlinux symbols
>   need EXPORT_SYMBOL_GPL.

Yes, we will have a commit for those in the VFIO series as it also uses
those LUO symbols, and this series has a dependency on VFIO series.
Please see the following commit from David:

https://lore.kernel.org/kvm/20260323235817.1960573-2-dmatlack@google.com/
>
>Thanks,
>Ankit
>
>> >
>> > Thanks,
>> > Praan
>> >
>> > [1] https://elixir.bootlin.com/linux/v7.0-rc3/source/kernel/liveupdate/luo_file.c#L560
>> >
