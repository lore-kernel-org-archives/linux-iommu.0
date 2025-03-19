Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E12139C8
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413950; cv=none; b=UbNFfCjYwYW0w9WADnabOMa8G0l87tTR5kyXZtFxGuSOKBlSnuPBme3H6eTvIsKjnWSwZrhRQLH94Fq0jjNf8/LJKDetLVGrvT1e5GXV1SS7Rg8vmcymWkRiBVu1gooVNl4TaaJ9TdzDAFtB0xKKcwpScmJ4Vsa8JqsbD3lS380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413950; c=relaxed/simple;
	bh=7FnjFkPUIccEVMyi5cmIGoZC4H7rg5ACYHqGd9GRBt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GanKG1xLhWsra9+nRSF41c8gQu0OhI3N02CttjLaf2lScCYEzGa0WNcQQpGECO+31TPsZYFbDGrFi080CySzkdHz7LT861g0QS8a+s3E+M4FSwgzycEeOFO9FkbdoXaD2GlkIn7RrmCKXkZ5vjES0+Dr3WF1JjVTIlDUWrPFAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SvQ5hnhE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SvQ5hnhE"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c07cd527e4so6051485a.3
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742413947; x=1743018747; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F17wLshPjnnifFZYD0ngTCTFhiy5aRtVmUyT8Qlns/o=;
        b=SvQ5hnhEv5VUfeRPpoALvqPhJkvXEh0xJAnvr8TrsT5nkJawmkYYJa1V30PPFDoee+
         xQ0cNdpv/EtWi+VPLbW1xdnN2UU4Ip6z1+87C2jF6kGK6smt39VwhxmhZvjE3y54ijUM
         /+Z4KS1sy3Jxm6tiEPGSPQjMzW7XdPQ8/laH3s2CN+l2kkeJbq8Vr4LPmZjneH1++NXu
         kFVLBkDYpB08B5s+U+VIJdiYA2NXgTHSw9EBOMGYv4E9hELG8b6MYvSX0nfP2TukF7N2
         6pHc/ZU245w87hW/ielrdfM8HPs6tNgOTPtRzqyMsvU47YHjE++2CLy3UyGKBQTNL328
         TF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413947; x=1743018747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F17wLshPjnnifFZYD0ngTCTFhiy5aRtVmUyT8Qlns/o=;
        b=HSYx9AQbRDw9NBblPR83NcaCmVuCy33680Cq57+lGNXi4iTJemG/3N7kTxQi4x6q3/
         fNCs3TAEnppaU1R7W80yQwDy52ljezYp4t9TCwerm6tPUoyyHulutVI42NoFB34JJHgp
         DV6PL7Oa57urWFlBJjuMm/w7PzcL1OvMFBnKVFRyY1IpWZnjMlU/HR21ASfpEfctrfCA
         8GHg+Z7YoX/YzwOz6ZJf/m5m+rS3TL8iM9/MoqkFv6UeEjPZ8zdUNcKt7CC25M5OEPta
         cGrVcFTa2DvrrY1a4aUTpm/eje8VhbdHegr9gQFJ857kyY4j4Zj+wcSQ82yvX6QDJhi2
         e9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsQOL3cWnh50SueCYuY3zBeGO7acBsONXYwNBZGz06KlNLKv5MHeHQMJPvuPfwdiGHUx73uA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMOJ5KBZk0KDdC0tKvdWY1i+yO0VZH94XpSezuNbeaMSo3eUzY
	XUveKf4n0rLl6XuubnN2dx7q+PAtoLl1cXgUiLGQHe8cHv/yjiuCslQWsCIrcZY=
X-Gm-Gg: ASbGncuOSsBtGupo/yW+azpzMugbpKuUXja7Yr1Sg5agcZvDJPmo7oguoT2S5gV3pom
	DvQ/k9YW/038awZt+Vg9uylBvMZpPqmFUhw70ODsYrHGLVB+4zt9dfqUuFyIuEpnekimWHgQ08F
	3IQXHsI8CEtftvbJfJ/hqYZkHbIDhuVdlokxIREl0MBhbgngRztkVbEr3axSHkTqUokPIm3B07e
	E9UI/VENmRTpfz/QfuodwDavqRLkc1z4BJR8PGVw1VN/roN6d280oOC+0ip2jap4wtjhYpUcFlt
	0UD6fMd6BQa1O39zQxXgSDY8+wghYWIWsYBOOJneHF5o4u8hvzqw71vhoQ6Aeb3hKU1QlPlShjf
	9c4JGaf2BZpIjXHQL+A==
X-Google-Smtp-Source: AGHT+IE3Y7Zlqr4FeBw+RtkEQErOS9tGpo67QOUEx9Hee5hT8+n+DIYAQbEQVBha6DTijXYSylWTgg==
X-Received: by 2002:a05:620a:278a:b0:7c0:c332:1cdb with SMTP id af79cd13be357-7c5a8461bd7mr507328285a.38.1742413947312;
        Wed, 19 Mar 2025 12:52:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d6fbbasm903317685a.78.2025.03.19.12.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:52:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuzSk-00000000XZP-0tnr;
	Wed, 19 Mar 2025 16:52:26 -0300
Date: Wed, 19 Mar 2025 16:52:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250319195226.GB126678@ziepe.ca>
References: <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <391a2333-0373-4cd3-a858-349230bc7c90@amd.com>
 <20250304142402.GB5011@ziepe.ca>
 <791efd0e-4e43-446e-b637-1f9ed49d0c32@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791efd0e-4e43-446e-b637-1f9ed49d0c32@intel.com>

On Fri, Mar 14, 2025 at 08:09:37PM +0800, Yi Liu wrote:
> " 4) TA is an full physical address and the IOMMU validates the full
>     physical using some kind of permission structure (ARM calls this
>     Device Permission Table)
> "

I think selecting the two kinds of secure ATS would be done with
various flags and the DPT verions of it would only be selectable at
allocation time..

> > That would be convenient for how SMMUv3 is structued now as it can just
> > switch modes hitlessly with its existing logic. I think all drivers
> > should have a similar design.
> 
> I think this is more like we have done for the set_dev_pasid op. Now it
> supports replacing domain. But as I replied in above, add a flag in the
> attach op might not be a good idea.

Yes, you can't switch between DPT and non DPT modes hitlessly like
this as those would need new domain allocations.

But it could hitlessly switch between secure mode enabled/disabled or
ATS enabled/disabled without changing the active
struct iommu_domain *.

Jason
