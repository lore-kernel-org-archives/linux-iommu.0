Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B453E5ED5
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505693; cv=none; b=dZBoFceE3DVCYuyBGypekR2FnWIEprnz4Jwpg8jOovenYofnsCjBqyhEICagwk2tfvPYAS8inEJpi46ECcPIBiSYNiRaFND+LBO7AWsZjgcX6e0qgEUXyQJhG+JIxcdJigIca2MBhyqJaGUjwTsm4CZoSMxoJ9Q83OzCygL1lYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505693; c=relaxed/simple;
	bh=l3tLAV/qbXxDAiEjZBHqF/EXhczrSOv3/Pf5ORcdo0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5f+Oa5su9X095bX751nvFiTdYGE8sHEL71Zw+MoZpq0lipedT84U2lSZOQo4W/oHoznBHE+AuqKmUjxj4wj3RO9do0L9/scMNoQT0MTs6/Wl9fI6qpyNwTjHfId775O/xEQ9iLu61NMlAdOm9Suo6kRD/rCaPpEaB8wl1tKYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NInjs4Uj; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NInjs4Uj"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90b2fcf90a0so120367585a.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778505690; x=1779110490; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=caLXAvpdnitODcaZa23G/qyjfJ3yi/42EdivUQYgIvU=;
        b=NInjs4UjMUSD8LZDB9vTBsm8J5GF4KPhMTM46cw//qFjlAulWwBOnKwFN8F1c79XsW
         3EbJVVYmOzZqgw5vYgvlL3BzkfypST3njiErr1/kg1O+33hu8t9HK/QeIzWTUICO55oJ
         CrN7ybFohS4TUZ8Fwxoe4js6PTNmXfOd7mJ9kNH8lbJyVRaGZTSmLuL8dtxPf5t4Hj8i
         58N7Lfcsa/nLxSmwt3Hn6dsuCSUw6TpSfNEBhOlz8RRdIKA04CCLzcZJlSJ23rFD02c+
         ys3GNXaRGQKWR59EdxemsDHmU63TFZLYbfsytwvnK7Td6NZX4/WfWmh7Ggu6M+GRA1xO
         eV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505690; x=1779110490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caLXAvpdnitODcaZa23G/qyjfJ3yi/42EdivUQYgIvU=;
        b=hFKWKLD0uXVClXnt2fE7yOIQzJzyDf1DlF2/+6KUd39dMIlqNBaiK7zxbDFRWJmi+/
         AW2Z8wIFeGVFxAkp6Mr1cEQMy0DPwvMsPHJmqcr8dn1qqJS/I+dWjqJsp1CC3lkdTY/h
         B7Nny7N+/q9/l47zTs8M7nEkuFZ2QkqQNDfDHhQS9Qb4LkQHeV+fv0C5v3h7cJ6gxJSn
         S6sUcw/7lxYMjC/PVfNf2N/nNn/MBL3gmpVmgSzWXQE+qCHmtOdoNsBMkHrnb3gr60Jp
         CrZ0lNbFHLUQikeC4V6qhACdXEU3HzTbbQ5slKhyMQMRjuSi5de1WDtiDZ3QhH+lyhCy
         DsoA==
X-Forwarded-Encrypted: i=1; AFNElJ/ULpiTU/yScxsPMIUlApcXWrFi6Am4absTMvHEHINS0t9oeFbftuJMgz3JtlWoJsBFP41iFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybBK4/8mbBl8HtmDnjWNRw/1JZIYMpig31/VrgG3zTyC2viEXt
	gT3eKhHf9T1Vmacz711zWvPgsw73yzEfcusD4EGSn4bZCR/w8QQfpVKgTy84YuDRjQU=
X-Gm-Gg: Acq92OFpRrkYhX1K1F2iKF2sMr0+Bis0YVMWZp5dYqI2uSNQvqLGUZXTgDMJv13Noa7
	03kbz+86T+9tC2k6WkoJJGGqcd9civcqmYLeDqfmzMbJdeuEQjhHHU/BIWIR9wfUXqIvpUqveUY
	ldXcJBGrCTVTAO9/HfFtaORyuRLuGqDf7ghX9AZNR1QBpJ83ZlRkgpxrvvr24/fj2Gpl2UGO1gQ
	Axv99rsYpf3L3skZFUbI5VYJcqEgU+VX+42Gbvs8OUBFABSxqhKmLUTxX+mI/yMz2ASDnGHNFSL
	ZeCS2Xj/zgF27OAeC1yWA2yu7izU9N9Lx1oaz8ifozc8Wta7bUneC/tpWJF6mREbyLnL9nfFc2U
	TM48B6xZlw5CyZeoVEfgOsXc44KpoBqiKpZAyRA/lLcaLhxBCPaSTKsZzEe/SYC6zHu8p74MbKO
	GFERbW4U1joJUn78aRMpo15vj8iNG5I9kAPI4z36cdaTpMcB/u5e5lkThn5f7yP4YQlQtWy3TXr
	ogLeg==
X-Received: by 2002:a05:620a:4494:b0:8d8:ed00:5a91 with SMTP id af79cd13be357-90653151c6emr2455764285a.22.1778505689836;
        Mon, 11 May 2026 06:21:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8e9b24asm1066226385a.18.2026.05.11.06.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:21:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMQZc-00000004njt-1WnC;
	Mon, 11 May 2026 10:21:28 -0300
Date: Mon, 11 May 2026 10:21:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joonwon Kang <joonwonkang@google.com>, Alexander.Grest@microsoft.com,
	amhetre@nvidia.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	joro@8bytes.org, jpb@kernel.org, kees@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nicolinc@nvidia.com, praan@google.com, smostafa@google.com,
	will@kernel.org, jacob.jun.pan@linux.intel.com,
	easwar.hariharan@linux.microsoft.com, kevin.tian@intel.com
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Message-ID: <20260511132128.GM9285@ziepe.ca>
References: <20260424133953.GY3611611@ziepe.ca>
 <20260507095851.3220765-1-joonwonkang@google.com>
 <20260509171013.GF9285@ziepe.ca>
 <30eefd04-1d0f-45d8-b55d-e3e8d41a57ef@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30eefd04-1d0f-45d8-b55d-e3e8d41a57ef@arm.com>

On Mon, May 11, 2026 at 01:39:06PM +0100, Robin Murphy wrote:
> On 2026-05-09 6:10 pm, Jason Gunthorpe wrote:
> > On Thu, May 07, 2026 at 09:58:51AM +0000, Joonwon Kang wrote:
> > 
> > > By "similar instruction" on ARM, I guess you mean ST64BV0, which fetches
> > > the bottom 32 bits data from ACCDATA_EL1. Please let me know if you meant
> > > others as it will matter. If ST64BV0 is supported on ARM, however, it
> > > would mean that ST64B and ST64BV are also supported already according to
> > > the ID_AA64ISAR1_EL1's LS64 field. The latter 2 instructions are just to
> > > atomically store whatever user wants to a memory location without
> > > referring to ACCDATA_EL1 and all the 3 instructions can be run at EL0. So,
> > > the userspace driver would have enough capability to designate arbitrary
> > > PASID as it wants via the latter 2 instructions when communicating with
> > > multiple devices.
> > 
> > IDK exactly what ARM did. IIRC on Intel ENQCMD forms a special
> > non-posted write TLP and the device can tell the TLP came from ENQCMD
> > and so it trusts the encoded PASID. ARM has to have done the same
> > thing - allowing anyone to forge the PASID by using a different
> > instruction misses the point of the Intel design.
> 
> Yes, ACCDATA_EL1 is a privileged register neither writeable nor readable by
> userspace[1], so it should be functionally equivalent from an SVA point of
> view.

There is a bit more going on though, I think that is what Joonwon is
mentioning by asking about ST64B and ST64BV. I *think* the answer is:

- ST64B uses a posted write
- ST64BV can be restricted so EL0 cannot execute it, it uses a
  non-posted write (AI tells me via EnASR)
- ST64BV0 can be used by EL0, always uses a non-posted write, and always
  uses ACCDATA_EL1

Which is similar to Intel. The device only processes the PASID from a
non-posted write, and the CPU prevents userspace from forming
non-posted writes except through ST64BV0

> > Honestly, I'm not sure why they even implemented it. SMMUv3 can't do
> > the translation scheme required to use ENQCMD from a VM anyhow, so it
> > is pretty useless.
> 
> Not sure what you mean there - indeed you can't do the SIOV thing of
> assigning individual ADIs to _different_ VMs, but there's still no reason
> you couldn't give the whole accelerator device to one VM, and run the "full"
> kernel driver in that VM to hand out ADIs to processes, same as for
> non-virtualised ST64BV0/ENQCMD usage. It's entirely usable, just not so
> "scalable".

Well yes, technically, but I'm not sure this is attractive in
practice.

The value of ENQCMD on Intel was it can eliminate any HW side
per-context state for simple HW like DMA engines, including for
virtualization.

You pay for that value with some performance loss, but it can be
attractive because of the universal scalability.

However complex devices don't seem to want to use it, once you have to
have per-context state for any other reason the performance downsides
of ENQCMD make it unappealing.

So, IDK, maybe some embedded on-chip device will find a way to make
good use of it, but also I'm not aware of any adoption on x86..

Jason
