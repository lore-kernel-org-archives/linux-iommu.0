Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF434C123
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427587; cv=none; b=KaRX0965vbPsabzkhtuM0RmwITxNEfrVrShEY/XUbK7IBZN3Vl0Vfv0u9hQuf5DHsD1ZTze+JRuIVBDMUgWZSZubOt1JvQMBoXynjvL0EmaYu9/bYoTU8vXr/DYe4+WpgAB+F8YzvLjRtkjt8JG1ntrszuzBFYw9K2egrHNncms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427587; c=relaxed/simple;
	bh=igi61PaIIZaH3Qas+vZAstXrvDO675CFw3Ylscc89LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUTmnlHgr1QViHadPz+GvC8fFTtmT/GAoHJP4lJxDv/BgETDqTToJIBfq1RLR7NEnTOGClXysyPsGXhCMjTTk5V6TIn5FNSlEsccvv5K+nK0Ti4fsmwwvqqOhp4OLg4gpAn7Pi+IWQ0OtRxybBLFNO4eRlRE8nhbfuX4ct/J5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fD7xyly6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fD7xyly6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd785a8783so268162485a.0
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773427585; x=1774032385; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy0pIPV9+PAUwjJhdgFY70jKRdcmmf+kMol++AzSeUw=;
        b=fD7xyly6FDXud86eA8+dqpvQ9b12U9wAtA/mKxuM0aX0Fv8sRzbsnzD7plX3U82m9K
         4amAn6lVtp6pjBlSys2fA5Jq0McQ9u1aNr+284bbTzK9Gq2ffzOehg7gcvJQVQsLdULx
         9j5hXv7ocMlpFQyDJPXLD+FdWG+lyqW7J2yU584Y3ITKqip3L7qkRv0o5J4tOvsMe1ch
         PTdPoou5nTmtG7vBPXsSnKRpRacO7YV//rrFN8nWgXFeHwg711Oxs1ll07yPSQTiA+zt
         k0D7wC+q2GVsQNCExZdzq3mindn5e+l+CwTn1MqOzCGgBSI0T6reC/3z0r54xnpU8aLa
         dPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773427585; x=1774032385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy0pIPV9+PAUwjJhdgFY70jKRdcmmf+kMol++AzSeUw=;
        b=jpHjcQ++BnBuEaohkMOFY4ZblxDMyFD9foCx/gCp3oZENDmVbX4U1+i8+AYTWSxgNW
         1QqbaSytuH6RnRP7Fo1Cn4ZpOM1bnTmpE1HN3ijqlu9FP4JWHSxDvLwDeDUKT8VY0la7
         iwak/O7iR2NdiZeasONXU5OyDu9d5LEhvhXUMBZiinH8/I1ty9B9GmRcvJXqeP0KUWuW
         gUN/AsJ8q6YVuhjHWaRq9erSATkgWn4wmx00V3OLAa4YIF96KrPZgaIRvCkqJ+T1dG+m
         jTN0Y+TXT9fBtbs0Vr1Zf5WHgL/aoOoxFL+7WcsVRig3zpFfyz/eHsWe+C6vcMN4v50f
         yWsw==
X-Forwarded-Encrypted: i=1; AJvYcCU6WY/w3oIJ7vAOYKocsq0V+/9RvyPqFv0nAFSexbvgXha2YCBr6ygGTLb3adbJUDjxopEUbA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyby0XKFaxjZMp6xRAMtkZdfxijuFWI9NL0D2t2lL5jL7vKy23B
	29xINo+4IMF21lJ9OXC7M1ZMeacCjzWExxIgHlyctU96+Qm86LQVFplP+7YyqMs8v1Y=
X-Gm-Gg: ATEYQzxrThv6LZF1QqyXr1E0GxbRf9cXs2u1vzDFP2vmNL2CTupcoYUbDcI0MiNWB0m
	tFUHqv6jdgGSpoR76AkQ3rVgg3WQm/3jXnAmbsUu26aYEMAbiEG/+1qRWvjw36Y/1g+wqu0/a6i
	54hIn2YGJyZbHEeF5Ds/8LoCUz3CXvDF+Utltk6x7vwZxIHICTPAGJGMZbzHD1kxUPLn6ZrgJee
	IVS9rWGfv263nHPFpUxeYaCSEz8L2hpsbk7la1sKPQvr+plq5M7vPiMeMhxPeEZ1UxyUS49F2aw
	rIaurKtJqnBKdI+z9jZ8v5LFLsFJZpNa34mCJssn1i4s8rE750joJHEK/gUbV3K+oUkaNI7cXCW
	M2ybBB2kw/EcvS2tRD7r9yENCdqYaH0iHtTXi9UT9yjF4RgVlyM28uTofOMirQrnJbgzAAu2DVU
	Gm455Y4O/9F/26OywBwMlqfcd+NjKXBizN58+2B46m2kpYdRLi5Dq9OBCgD7hxwrg/mTIN58s2N
	WKwbxqgX206fdwy/Bw=
X-Received: by 2002:a05:620a:4625:b0:8cd:6175:9b17 with SMTP id af79cd13be357-8cdb5a3f7c2mr586273385a.3.1773427584802;
        Fri, 13 Mar 2026 11:46:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fbcd23sm701747085a.1.2026.03.13.11.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:46:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17Wh-00000007M3T-2Qkk;
	Fri, 13 Mar 2026 15:46:23 -0300
Date: Fri, 13 Mar 2026 15:46:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Message-ID: <20260313184623.GN1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-4-aneesh.kumar@kernel.org>
 <20260311214343.00004641@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311214343.00004641@huawei.com>

On Wed, Mar 11, 2026 at 09:43:43PM +0000, Jonathan Cameron wrote:
> > +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > +					       IOMMUFD_OBJ_VDEVICE),
> 
> As in previous, can the object be PTR_ERR()?  Maybe not, but I'd
> be surprised if the static analysis tools are convinced.
> This might work for now if obj is first element but that's not
> elegant or matainable.

The compiler enforces first element:

#define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
        container_of(_iommufd_object_alloc(                                    \
                             ictx,                                             \
                             sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
                                                      offsetof(typeof(*(ptr)), \
                                                               obj) != 0),     \
                             type),                                            \
                     typeof(*(ptr)), obj)

I have a lovely little series 

https://github.com/jgunthorpe/linux/commits/container_of/

For this that I keep meaning to send but then never do

Jason
