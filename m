Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D937DA63
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726764; cv=none; b=lzk+3XH4lBcIEhKcN+uOlWF/vzGWNB675lmBEmq4Yrp9ER+UXDJG74ZaqkwH8HIIuw2QyyCzIAFro6+H7Y918+Z/B61SCkCvq86CIFD8fqeAeALNPham6jthgV6vn6Ht55tcgN9YNO/rWRJQZOi0gN8z2bezJ9EawzPpomLCi94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726764; c=relaxed/simple;
	bh=jd9sCNQib91dSRC4WlUXNbPpZEpFXamw5HwqjFD74w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjdZUeSAuWyk+uOIs7yarpY1tfWqxjlrv4RwTxBYbqUAFcs+eN07RvTaYHtT6zKmgdFdem/CP9cN5wR79zQ7LbDXTOPABKzTH26LtFjKPHDoBjeGYrTe/Mo7XZP7dLiQyNZuaU9clnH7uMxH8TSwI7pFdpw55NfPtYKYrHVXToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MApMmN6C; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MApMmN6C"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d6f4714bso83611685a.1
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723726761; x=1724331561; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1BcZ11tYjfQmoKlsqbLIVN6wjqaSiTQ9rCV5yk/N8Bo=;
        b=MApMmN6CvBQvn8jtQquLFM5isig4m3Ae5KmeAv9HifoUSZ58hwlAB6H9kUpx8qGk0J
         zK9f5ydTbZr8S2QxG8ayMAF4w/YBNjoflsjDBzjGsvz17aINUZoSylhZszLAJNak08YZ
         Ohj/Kz2DQ49qSXmdGpK7RJpIfuvL7eb823kw9JOChwRMMGPyqq3WGZZ9rU4cOhZZyPZa
         yKoQ9eEXdsCaXa4Kx6z+hi6P7z2yM2ZPjcBZngGtyJz9IoFjAA75PADDnxCBhtf9sw14
         xk0OwMGnHPOZteIfmfs80kOTVCWEYC4AbmLYFCvuRl4rOIkPWG7JPE4yY5sCAmBVvQdb
         0gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723726761; x=1724331561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BcZ11tYjfQmoKlsqbLIVN6wjqaSiTQ9rCV5yk/N8Bo=;
        b=CDiyEtDs7HOHoRd0waN7efe25GNa6vHDq2FdD83xF59aNKq5WWT2NU2TJUf7Qh0a56
         ASz4HN7V6YIW8RS/ax1ZnVa0FCwbZB2kgNJi/hl3HoqXNAofMHMawiu5RdwkMHlv+N7x
         c/R58q9twrGju68ThJfvddDedFkZJ9Fn7TciiDV61JWdlH7Ew50vmCYL2ed01TUdGj+f
         Opw4U/3Ow/dVwd3ySboh+X5qiRuWtxDH5/1xtUFuotC9P2bk5kHCg6M0S+tvd430LULI
         CS0yfgI2ShOcHi3/V9LwY4MIP52ZRLphzYVuVAuPwTuKwuSwSBL89/jCMleAoEUbFzmX
         LdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAAn05pAmO2zAB+m12MEOHUU1kL7nzKNXNNwiYFJy2ETAX1LU/JupUZhXPsqYzDB2T85psLj8KUCQmWFXUs82kGgwuFdg=
X-Gm-Message-State: AOJu0Yz691GGWrtrJDEjDFEXYtr0QbXFslO8sUumL/IsGjd+53u87hGz
	PYu26npdLDLqwK9xLNy+Ifmam6rKN9xNAPrq0bpw6SFLc1o7pW4wN8S1YU0iN1w=
X-Google-Smtp-Source: AGHT+IFq3SZzxYqjGi+1pTyM3Ksa1yF5302/pJFBXQ96rfVuXA1I3evPnIcdEzygTMhqTm99USXIVg==
X-Received: by 2002:a05:620a:460d:b0:7a1:62d3:b9a3 with SMTP id af79cd13be357-7a4fd1685c9mr505578985a.17.1723726761271;
        Thu, 15 Aug 2024 05:59:21 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e04f6sm60863785a.82.2024.08.15.05.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:59:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sea4V-0030xg-LQ;
	Thu, 15 Aug 2024 09:59:19 -0300
Date: Thu, 15 Aug 2024 09:59:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240815125919.GH3468552@ziepe.ca>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
 <Zr3m4YCY7Ape3R6y@google.com>
 <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>
 <Zr30BjAcVDKJPv3B@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr30BjAcVDKJPv3B@google.com>

On Thu, Aug 15, 2024 at 12:26:46PM +0000, Mostafa Saleh wrote:
> Hi Robin,
> 
> On Thu, Aug 15, 2024 at 01:16:19PM +0100, Robin Murphy wrote:
> > On 15/08/2024 12:30 pm, Mostafa Saleh wrote:
> > > Hi Jason,
> > > 
> > > On Wed, Aug 14, 2024 at 12:51:51PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:
> > > > 
> > > > > Also described in the pseudocode “SteIllegal()”
> > > > >      if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> > > > >          // stall_model forcing stall, but S2S == 0
> > > > >          return TRUE;
> > > > 
> > > > This clips out an important bit:
> > > > 
> > > > if STE.Config == '11x' then
> > > >    [..]
> > > >    if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> > > >        // stall_model forcing stall, but S2S == 0
> > > >        return TRUE;
> > > > 
> > > > And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
> > > > match the STE.Config qualification.
> > > > 
> > > > The plain text language said the S2S is only required if the S2 is
> > > > translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.
> > > 
> > > Yes, my bad, this should be for stage-2 only which is populated in
> > > arm_smmu_make_s2_domain_ste()
> > > 
> > > > 
> > > > > +	/*
> > > > > +	 * S2S is ignored if stage-2 exists but not enabled.
> > > > > +	 * S2S is not compatible with ATS.
> > > > > +	 */
> > > > > +	if (master->stall_enabled && !ats_enabled &&
> > > > > +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> > > > > +		target->data[2] |= STRTAB_STE_2_S2S;
> > > > 
> > > > We can't ignore ATS if it was requested here.
> > 
> > I don't see much value in adding effectively-dead checks for something which
> > is already forbidden by the architecture. The definition of STALL_MODEL
> > explicitly states:
> > 
> > "An SMMU associated with a PCI system must not have STALL_MODEL == 0b10".
> > 
> 
> Ah, I was expecting that as otherwise it's contradiction, but couldn't
> find it while searching. Thanks for pointing it out, I will drop all
> references to ATS then.

I was thinking this was also protecting against buggy FW since
stall_enable can be set by:
    device_property_read_bool(dev, "dma-can-stall"))

Alternatively we could directly prevent the clash even earlier:

@@ -3292,8 +3292,13 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
        if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
             device_property_read_bool(dev, "dma-can-stall")) ||
-           smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
-               master->stall_enabled = true;
+           smmu->features & ARM_SMMU_FEAT_STALL_FORCE) {
+               if (!dev_is_pci(dev))
+                       master->stall_enabled = true;
+               else
+                       dev_err(dev, FW_BUG
+                               "A SMMUv3 is required to run in stall mode for a PCI device\n");
+           }
 
        if (dev_is_pci(dev)) {

Though I have no idea how the GPU driver that wants to use this
works - it doesn't seem to be intree :\

Jason
