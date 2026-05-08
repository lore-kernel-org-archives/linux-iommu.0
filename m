Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAF3D7D70
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270985; cv=none; b=d6n4Hk4eP8NLZIaohORhuVmQLnvVhx8K+ORy9QHOiw0W+VYh33jmHEG6C+OZfHfItVykEJDI+uPiQoYpn14/UAJz7n+0NzYbjJ8y17PlFw2KvXGx4wrl3o4p7ZYdR5BYSuVXcIul6UoWGOoNdjbmDW+wf8e/MW0AKwlA1ZPY39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270985; c=relaxed/simple;
	bh=kOkgadq14suwO8KmR+859hipwhbCqWCtsBjZKpFyOnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeBEdbkwOBAUsDkme6hkq9uTengzITSvWE4/xQerYkKK8wCx5zMANIbkR12SUBJ1cRyqh3QMCfuFzoBTg0Ikgk6m0rE7XAn36o95cO4fCyaL4U0Vx8MviXXNxDY2dnAM9Go2T+11LZm1ltTHfPXFjuNySqs8uiOSwmCz6YzvPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6H4BN3/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6H4BN3/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso1055ad.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778270984; x=1778875784; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zu32dzAdarKxbcjgwX2AWV9AveqcvXYvabaFeB6Rgag=;
        b=L6H4BN3/KR3g0yLczJoz5U1wKo6XEhDw+Uqri4soXv+sIrZWL3jf/b4kGlMmJJ/QUg
         YD3AOYQdpPt3OTmoiSPpAAHk0603+hDFpvixXuItkz9tPrNpihdy7tqn6/xJCzfjeyXZ
         CON8+u+GHwSyrbKVgip7x0pml9HXT4AzrriChu8h/v9E+JI0FTRDMfzZTUXfOd3pVGX8
         /4Mn5ae5xYqDUoYmXUBCCLyYwns6DMkJjl32UKmDuKoaHP1KjkaRE8Dtgk2oocpPHeIN
         X/teeOoMt5xpH1QqyIpHuA91m41db1R97GA3WNCDpDJb1ErdZ+q3yDOq7Uomw/NpK7jq
         jK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778270984; x=1778875784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu32dzAdarKxbcjgwX2AWV9AveqcvXYvabaFeB6Rgag=;
        b=jB79hOztJxh/hkCxfB3iDQSgRDn64F5/wxVhEh+tlbCA4E6EKgsveBhEsN3TnNqzI/
         BqqanHqwhGOQ030oGhhoV0xVElUtXJQRu2v7j9NrLlGbBxoXQWW+e2cfssdZbisUs4e7
         N8PIzl98ZQOiV0uDsdQjn8K5sJiUoH9hazr7BHjDZgTfQGAvhvmlj0jAq1RW5sfKD7XW
         oYRI5PIznslhSMi2JUzdENS6PqeIcLkA79vchQtavGOydf1pl9CDruqTVldyTGXAN6JE
         3dbsq+4H7ggV4iqQprUmKFbwjiOPrUnYv96CK6ZUZ2VsgsmhSnENwaVUm9BvWQ3pzmH5
         iFOg==
X-Gm-Message-State: AOJu0YyegYLHRwfTtdIhDWbEV+EwYAYGmcvopn14vk+htVkJlZbKLPdT
	UmdoG1yswZsgsPnhZwld6cCezHkARa77m39hwS+bIDTrlP5U1LQN6PP4iop3mBrM6A==
X-Gm-Gg: Acq92OF1705UqnrdOL+5uXT5N8QRc5UAYGwLD4duBJwAh3ekVmrm/mwdrbEv9AIzIZd
	cYi6u0PAiQQmNSYWd2fGZqeL+HzV2NmbLih6V+5MIBIF8/ZCBIPS9M5rM2ZFQh4ka4rIzPuYx4I
	n8l9/LsEaERoY1czU7c/hURZ9WfNSzntsVRuvH5WAOEDrqllejdMZrxV68DciKrshRDzULNpOX+
	bscw1bHPeWVIIYDnYgN5c4Rx9Ojr5aRr9hnRwGNJ/hCuFyd/DaS44kpa/fRnqf/FnE0/95qgR6o
	4xg/lsi1j09VDXlVIdPcCO9ZGiso250MV9j4dYLTqQfc8ESAJ1+K+bTmgsQHPNpxmxPH2r2ZNBK
	Dgy/Go+HRJFiRCUVIVub0kf3ijO7ohknjFLBmerE0gcJEMjRVMeSu4juiabmY76l11c8MV5c6ga
	Ks0JC2g0H5tfPffEC7NE7c3rmlmx8QOz4IJEHgQkwcN6wSEJKBE/WItdTNLGnk6QPThG7U
X-Received: by 2002:a17:902:cecd:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2bc74753517mr653625ad.6.1778270980413;
        Fri, 08 May 2026 13:09:40 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ba2sm33602775ad.50.2026.05.08.13.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:09:40 -0700 (PDT)
Date: Fri, 8 May 2026 20:09:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 6/9] iommu/arm-smmu-v3: Directly encode simple commands
Message-ID: <af5C_ax1a3LbtL1Q@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <6-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <af3KDBt8vhClSKEF@google.com>
 <20260508173736.GH9254@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508173736.GH9254@nvidia.com>

On Fri, May 08, 2026 at 02:37:36PM -0300, Jason Gunthorpe wrote:
> On Fri, May 08, 2026 at 11:33:32AM +0000, Pranjal Shrivastava wrote:
> 
> > > -static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> > > -				     struct arm_smmu_cmd *cmd,
> > > -				     bool sync)
> > > +static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
> > > +				     struct arm_smmu_cmd *cmd, bool sync)
> > 
> > Nit: I'm not sure why we need to rename this? We can still define the 
> > rest of the helpers like:
> 
> I made it have the same naming system as this:
> 

I know lol, I just meant why are we prefering  "_p" names. No strong 
feelings here though.

> > > +static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
> > > +					  struct arm_smmu_cmdq_batch *cmds,
> > > +					  struct arm_smmu_cmd *cmd)
> > 
> > Nit: Same here, why not  __arm_smmu_cmdq_batch_add_cmd? I understand
> > that _p just means we'll aceept ptr.. but the name's kinda wonky.
> 
> Which becomes a fairly widly used public entry point, so I didn't want
> to have the __
> 
> Though there is no external user of arm_smmu_cmdq_issue_cmd_p()
> 

It's just that we're calling "arm_smmu_cmdq_batch_add_cmd_p" at one
place and using `arm_smmu_make_cmd_<cmd_name>` at the other. It makes
one think what's "_p" in issue_cmd, only to realize "_p: pointer variant

I guess I didn't like the new _p ones but I guess it's fine. Happy to
leave it at your discretion.

> > >  static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
> > > @@ -3464,7 +3405,7 @@ static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
> > >  
> > >  	cmd.opcode = inv->nsize_opcode;
> > >  	arm_smmu_cmdq_build_cmd(&hw_cmd, &cmd);
> > > -	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &hw_cmd);
> > > +	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, hw_cmd);
> > 
> > Nit: are we passing it by value here? This would be a 16-byte stack
> > copy? As with the macro expansion this looks like:
> > 
> > {
> > 	struct arm_smmu_cmd __cmd = hw_cmd; // <-- Redundant 16-byte copy
> > 	arm_smmu_cmdq_issue_cmd_p(inv->smmu, &__cmd, true);
> > }
> > 
> > Why not use arm_smmu_cmdq_issue_cmd_p(inv->smmu, &hw_cmd, true) ?
> > Although, I see this is eventually cleaned up in Patch 9.
> 
> Because it is eventually cleaned up in patch 9 :) The point was not to
> change this logic in this patch.

Yea, just trying to call it out for a situation if this series gets
merged in 2 parts. Not suggesting this would happen but helps to know
for bisection etc too..

But I understand the point on keeping the intermediate diff clean.
Always learning :)

> 
> > > +static inline struct arm_smmu_cmd arm_smmu_make_cmd_cfgi_all(void)
> > > +{
> > > +	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_op(CMDQ_OP_CFGI_ALL);
> > > +
> > > +	cmd.data[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
> > 
> > Maybe this is a good opportunity to define "31"? We already have a 
> > similar definition for TLBI: #define CMDQ_TLBI_RANGE_NUM_MAX 31
> 
> I went with how the spec was written. The CMD_CFGI_ALL has its own section
> with a direct encoding of 31 in that position, no field name.
> 
> While CMD_CFGI_STE_RANGE has the same op code and names that spot
> "range" and it would be a NUM_MAX, we don't use STE_RANGE..
> 
> I'm inclined to leave it for someone who adds STE_RANGE..
> 

Alright. We'll wait for someone to add it with STE_RANGE.

Praan
