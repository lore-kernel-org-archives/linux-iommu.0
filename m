Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CA4F3EA3
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737898; cv=none; b=W2W5vi50YyizjODwxKBkEQx2Rzez81C2pOpRPhJxdyvz2z9fs7hrhTPh/ZeBxr3k2TuQ9xF071JQVjgXDeTRfHl2TyYomxXT2DvR/F6x5ry9098UdbnrBivUyoEPOGCFw5NeeLh1MDG7kJuMYDMzV4r00fP/VnLqTFUSCY0ttZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737898; c=relaxed/simple;
	bh=v9UdPVY3a3m1N1cQS4DrnsIxV/L+mPyRwqE2xihCRdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgioYya785YNB+5FMkYnzsjenQWxWAftmG7QIVJ4GoVP+ripIxZI1fiB2DKjdllupxr4LOjOi79s7AnkV8/8OLmWYgZdQlaFcGw+XxoH4hfJRXLoczBjfcs+wmo++VZClAZiuwl9DeCOoYe2bisQzjJzGc677hzzRwzqPTFL9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m/Ur5eW3; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m/Ur5eW3"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb4so80336885a.1
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789737895; x=1790342695; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mn3aKmmmFmyEWeqRjbvgjKGN1x4p/IU34Fpl/53vDbE=;
        b=m/Ur5eW3H7nWXSFsPNf69e58rOfS1+kVuCL/v5iJvWCwZNEBwTZ9BioltpVwGtNJ57
         9IuShKDkO/JFreTYb0GDLcKHSM5a0AKjDhSE0uti42rtn85WBwzauz6HJzL6H018tiAV
         KJVFx+gSwUNnxhiOpoELLddg48OCYQvtEnGTexTapgZluqCWUSb2SoO+uBT7NJ0dfDz+
         YmComxRPfSVv6ft5nfaJtrpuht5u31wVGHM+nq/cTevoqvo6/YV2Iy1/Bhb9anVy9Inh
         xXV/U68rGoUXWi0+lIqJAWtLsKFSeEpyBvj/oev8SkCc1hoH5msuJNe3cEsQNqR4oQ17
         HMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737895; x=1790342695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mn3aKmmmFmyEWeqRjbvgjKGN1x4p/IU34Fpl/53vDbE=;
        b=UE7ZtemW41S7VZUlKNK6IzS6uncZAv81Qb3pXT/Z4WxUPq+dtRDd5Dfb0hIFWFWFZV
         pv/Hyeie2eKk+Ixg2QSNTbRwcldJw26INsDZHTbl38BmEldjren2CCSs6AM4xGKxNIP9
         ts/6IFqk1H5p3/RY1pvYYtEt4uJgDMzoxLk64JyegzqeFI9kvVLFvllXt9aGwPCWRumK
         AsiwlWO9WlWDDIBOjI1acdzJv0pLxzPIC7n7pCwC2WpbQT9mJDwos3Y9dcrJhIt+lx6i
         WH7pS8vfmHp/asX1lCgm65xVBM0T7PwLwuFx+z0h3Y2wKQR8hP9WfsjdBAfyTDn8h6Tb
         bQrg==
X-Forwarded-Encrypted: i=1; AKwUvByf4FTANmC5BNXI8cnjuVor9ztKOct0WoassPeoeyw1tHZU1HU4FdYm486wGlcoucUQiYYHEw==@lists.linux.dev
X-Gm-Message-State: AFuF++nLsip0tbumKfSAkVQRswAndeE24ZRu8Udnp563eamviaq58t24
	6W4/0yXG2sZeKTgg17Nf5VQqBtwQ5IQ5bVB9UuYm1tM4seN8Q2ASWtCHL8NOQjOLpTQ=
X-Gm-Gg: AYBFou2M5xmHjxJiLzgYnqC2U3k8HlQEbZclIARkgG1B05V55nOnOxv2XYKnMgLFvMb
	kda3HEg+45J4wnZ2Z7AKA+2PSTMU34LdtIRsKR/aRWL1ljla8w52fTRoJRJHovI9hPsa0cnHTqo
	BeIsbG7qVrABPO17PWivD5Bk+aOBzqyLxzON1B3t2k/ORiMlnStP9yJ2mCfJR3QjrDP/qVvj4rM
	iZPMgzCj8Tl4yUYVCE9L+CK3L3nUCx6kqyzI2lMK8nXO6F6jZe25bPJUDwzyhtD2kRkruuHJhap
	rYDkHvpiE15tSA40Ohd5Th0DBqUXZo0Pnseg2nU8S8B0EP+DewWufglMyCYFoYm/nrZDD/vZLd0
	mLPOFf6FUADDH6jLnSnFyrb9BgrINNAtMzzvBOZ8xuuOdq8puzENqOwLFd8b69ZKRcNrbI2OUAu
	qAwtRioDoelpD+QKNR53t5xSNXbS7Cektoa5Mha7lGOhu/Gch99z7SjqWUcIprpiqS0DMgrjyZD
	83Axe1jG8hC9arqI1rwkArjHkwsDcmayaJqZ+xIIkTx/Bf9sf4PK2IT
X-Received: by 2002:a05:620a:6186:b0:930:9091:f0ce with SMTP id af79cd13be357-93bdc70b7c5mr343538785a.22.1789737895140;
        Fri, 18 Sep 2026 06:24:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0ed258esm134537385a.30.2026.09.18.06.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:24:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7YaD-00000001Cw0-3NeV;
	Fri, 18 Sep 2026 10:24:53 -0300
Date: Fri, 18 Sep 2026 10:24:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <20260918132453.GC11599@ziepe.ca>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
 <apBso6So7UqwR3AX@google.com>
 <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>
 <20260828143546.GC3769797@ziepe.ca>
 <apGpHv8vy4SWIEaV@google.com>
 <aqyW3RzBGQyZebsG@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqyW3RzBGQyZebsG@google.com>

On Fri, Sep 18, 2026 at 02:59:43AM +0000, Samiullah Khawaja wrote:
> On Fri, Aug 28, 2026 at 04:15:56PM +0000, Samiullah Khawaja wrote:
> > On Fri, Aug 28, 2026 at 11:35:46AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 28, 2026 at 09:55:18AM +0800, Baolu Lu wrote:
> > > > That looks reasonable to me. I have no concerns about keeping ATS
> > > > enabled on preserved devices across kexec reboot, as long as the
> > > > software state is synchronized in the new kernel.
> > > 
> > > The new kernel should issue an ATC flush when it changes away from the
> > > inherented domain.
> > 
> > Yes, I will make sure this happens when we do the retrieval side. It
> > should mostly work well with the existing replace machinery.
> > > 
> > > > By the way, is disabling ATS an option?
> > > 
> > > No, many devices require ATS.
> > 
> > Agreed on the ATS requirement. I had Nicolin's patch series for CXL
> > devices in mind here.
> 
> Having implemented this now, I am thinking about this again with respect
> to the scope of this series. To limit the scope of this series I am
> going to refuse preservation of devices that have ATS enabled. Once the
> base preservation logic goes in, I can add a separate series on top of
> it to add that support.

That seems reasonable

Jason
