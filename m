Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050953ECED
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871367; cv=none; b=I/4TEqC/Lx30U1If0bwY/P/4vqpm4i/RjGtRJ4FqKutlqrik72He/LGSzkGMv/YWTzv/u4aA5WEvlNGQXb9bCM2qPqu0+TJdDLvt8Oc2A6i/fQUlnBL4vFpwISi3FeiUwWOGEWFR+BLm3Ia/46dJTPFF1qBBH7Z5VQhDxgATBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871367; c=relaxed/simple;
	bh=js9UEC/Am5qL7fXzeGsFiojuhESRYv+hLExCRcXvxRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NINxU+LqA/eEb5BPXMEdUfvh5X6hUSQdBtNiN1Nd33Wcx1qzWpYNolrswuf8OYzoFx2i04zb98kshWIdzKW/uj8GLRZk+R0gie7Lb0pO3zoDf8VAPZ/H4LRNTjt245Je6p3n+eLVRfef+ALuW5FFzzBJwae/51EFPi10YOrLkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iVPPW+gc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iVPPW+gc"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9399e925dcaso210846485a.3
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 05:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788871365; x=1789476165; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KO3kIc1VAMjPhAEaclJXkC8aa4/+237lrdumobzVsjA=;
        b=iVPPW+gcq9rJxqjNXPq0OpolmVc5KHlQ1dXH1JS3xpkZOB/pdZTFbauIc+9wfjfwuv
         41l7AnSOad2m39k7bNBbrCG6S4s8Tv1f5lTchXE9JYO2OnJ7XkENQCVTfAqZui/Ln66O
         /waBgnP6aSu+18xpUgDtn8ZlL10Prv4tfD2WuNr8pBnBo2OeNRcuL8zVsTUOGs/eqdoM
         zXyT7djlz/+TRpDvDKRrOUOqfF1dPeob3VzkxK0J8dofU66cyYnBbB7vZEmdZcNknLG0
         lRFnIJv6zKaO6r7JMSwEgDUPWpKGWjLkPg2PJ6dGIAvxvKpGBX7RMKE5HOzagp6baPIH
         O8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871365; x=1789476165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KO3kIc1VAMjPhAEaclJXkC8aa4/+237lrdumobzVsjA=;
        b=tREB/2JViv3owAeQoABOfV8k1LsaOJfieX3Xw+Sx2cqJs6cZ4v5Pr6UpoDuAaw0Z3z
         TE5WQHAlBbiZFShYwOsdcIS573vxFWYTA/czskxvo592PcKVm1YZRAMGHqjK4qERUprz
         Gvp0JwPsIx661UBVGNedhR/zrgmvSa9ZFj90BHpfXAnRFmfUFrsGlCT52lEbzSXWG3P3
         mobpQAM7/q0tPF6MntnariVqTMddMRICpGOPdQ7QuX4B8JUVPHBd6cupK3eZAxUqiMdo
         +rOjZ9fUnobM0hcPDU5Evm0a+TPSOPkCbhIW3mDXDLiQRh45RrIMIQ0vwyPL2pxN1VTg
         wymw==
X-Forwarded-Encrypted: i=1; AKwUvBzvzlzMHDTXYVTla272sLMZl2dC9x/mlyjxhB8pPhxpqkpIeuKmP26goUlJfPWaI9wGMLKp6Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mI9sSOezfz9BPJtdBE4ySP6o4IJiJA1ReSJI4qJ+PeQ5czYyKw
	6SkESAuMpMyIz+YtqVntrG23rMwedXwbePWJ0KJkK++rUBMf43oF5sauU/B69T3xi2M=
X-Gm-Gg: AYBFou2Ta3Lq33M+RNBWjcWK+rVDC6Y0HXX9AyDI24fjS2PtOlnUTd3MFsuH7KTBRLq
	Byme71j7YwcBSBNj+yY6NIm3WwoG0GH8OCXYoZDAU353tdJDROMABKbgGsm9HW45n3H+OpwJJ9e
	Qu4KB9QGDv/PbK+IZx61hcypA3u6EtXKGRaCUTtoZY4T1pOW9HUF2yRZG76/M5BtkFMG4zkSov4
	6HTeodKyqeh2byx65JcZFuP9HrTbaBfO3hoJSg3uwjbuS9Ewf/4I0IFCtfGU9tkFUzzKcKN4hv4
	28ogRpZNFwhxuSC/9XGFK3lf3hgxB94TKg9Oy+swW8OpjUKySq54cg2dQbb94GfiInjS341ksD8
	D8Lm2jGLUgvQN9clzQuo+ocHddwXYI+1dOCIJynBRqeoJ2vgjrERbm9Vt4AVXh7cSjFwg1PDUm/
	ZStaG0xGeDzLboS8UI+7hu7lsxYB2VqBARh0zfKxVzKqfmIG+dw3ATcXr9qQ3F0z70HE9drywib
	3uXCsTR7TXXAaVkzkh6Ql1Nri7AwvvHYfVtQk61vFZTog==
X-Received: by 2002:a05:620a:a108:b0:91c:c20b:a135 with SMTP id af79cd13be357-939804af44amr2957913285a.40.1788871364777;
        Tue, 08 Sep 2026 05:42:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406b0f51sm115856516d6.42.2026.09.08.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:42:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x3v9v-0000000Dgue-1sWF;
	Tue, 08 Sep 2026 09:42:43 -0300
Date: Tue, 8 Sep 2026 09:42:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jpb@kernel.org,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, praan@google.com
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Relax ASID requirements
Message-ID: <20260908124243.GB2543240@ziepe.ca>
References: <20260907154928.4012151-1-smostafa@google.com>
 <20260907184513.GA2543240@ziepe.ca>
 <ap_JokRTsUHtF4dN@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ap_JokRTsUHtF4dN@google.com>

On Tue, Sep 08, 2026 at 08:38:58AM +0000, Mostafa Saleh wrote:
> On Mon, Sep 07, 2026 at 03:45:13PM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 07, 2026 at 03:49:28PM +0000, Mostafa Saleh wrote:
> > > arm_smmu_sva_supported() have some residual checks for ASID from the
> > > original commit d744f9e6c222 ("iommu/arm-smmu-v3: Check for SVA features")
> > > 
> > > As DVM was used for TLB invalidation and the ASID of the domain was shared
> > > with the CPU process.
> > > 
> > > However, the commit
> > > d38c28dbefee ("iommu/arm-smmu-v3: Put the SVA mmu notifier in the smmu_domain")
> > > removed that support.
> > > 
> > > So matching the SMMU ASID space to the CPU is unnecessary and can be
> > > relaxed.
> > > 
> > > Remove the CPU ASID related code, and update the print for the SMMUv3.
> > 
> > It is OK, but maybe this could also be but under an if
> > ARM_SMMU_FEAT_BTM?  That is never enabled and is a placeholder to for
> > eventual BTM support.
> 
> Yes, otherwise SMMUs with BTM would regress in the future.
> But I’d assume non-BTM SMMUs will still be supported; falling back
> to SW invalidation?

Yeah, there is no idea to make BTM mandatory, just some people who
built BTM into their HW would like to use it because it maybe performs
better.

So the thought was if the HW supports it then Linux would turn it on
automatically for SVA.

I think we can land "vBTM" support upstream which does not require
solving the ASID problem since in a VM there would be no S2 at all.

The main issue was renumbering the ASIDs of already active
domains. Prior to the invs list this could not be done correctly
without races. Now that we can invalidate the same domain multiple
times in the invs list it can be done race free.

But, I don't have any BTM HW.

Jason
