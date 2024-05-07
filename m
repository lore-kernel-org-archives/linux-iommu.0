Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6A16190C
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099146; cv=none; b=p32P8jy7BtH8Jjepu9LUqBTNeywZK58CJLJqxN6ZfYxmOGwaXkI2uA8Uj5aC07De3DvoIeIfP+KnUvbbhiEHBRhDN+u2bwoZz1oGF+JX57V4xmxEKtFT2N5BBRL7na8cshdliz3dmjasVVFgXMTXcZyYXsoIeygx+U9DJ2PYTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099146; c=relaxed/simple;
	bh=O4KOfR7xsWkA69yvh0fmrqzX+jfoibH/wxjze2sjgyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFD8tTEbBS1dqmkhL+2t7KQZmY3/5sY7I5JKArTfWNBE7Kz3HRdIoRrGYW8NsHWw8wBXRMivbX8oaVZFGf+wsu7JuQGzM3OzIPQaavzcu3e9ZTdjY5m+j1RDpNUgCjO9nQZRh7boSqaViuI19J03RGcArIuyN7UY+g/a8P6k5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GrnK/o5g; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GrnK/o5g"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-792940cc66eso220110385a.0
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715099144; x=1715703944; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4A1sFCToC52p1ydCgtQ7NIaPSTbzbS+T5dDjpm7wNJk=;
        b=GrnK/o5gnqEFA0oWKZNlS3cvNB+DKD0TVlYuU9JcmgtCiW3dvayvHzFw/GvntPV5N7
         8qLuAqGErzTTu/acF8JIKN28dcS1Wpx2WcymA+u+cD9j8G7AQ1O1tJQ1/260d2heD751
         mGxQIixkwJEn7O+FtVp98UHUBDRAqy4TP5Tzy2lFoBqlaWSA8mWKbqNtRHfgK+sDeLHs
         tRRBH1vJyo9Ja+1gQ8FLNtQHDBtnm7rmLZaPiUj+nqqJuOvnJL5BPufX5TJQ/Amx9TC4
         ZLT5WtWFOLFWZo1lLRE79SSWR/RTCjNk+ty7NXGIBy5iN1nXXM61Y6wb1YwGTd9Pc4KO
         yWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099144; x=1715703944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4A1sFCToC52p1ydCgtQ7NIaPSTbzbS+T5dDjpm7wNJk=;
        b=QJ8HHSNVzT4sIlhX0awhFZG3R41W+zfxLXHBLpwWKuyp2Lv6xPpyh6Sp8JWmoWiD8C
         LRpf5Z8QJWf0WAs77AE5KBPAyFG53/zdFS8in2DAQLiaGmD0AOVuaMe781INAInDK/7z
         muuL/Xz+6XnrnfEBTnRbuxJbazrDcuniyRYhGw6/C/WH1663k/NjI1hmXicJfD7Iw7p5
         HppOnXstVNXUsXrnuhJDuisvyAcnS+hBGC+WyB+KvnM4BCYkqFESp2VTx6otahCpki8C
         nZ9fCGQVtDAeZ/tXhDTbDWz2EYt2jbTSckXpDFW7CQj4ojklfgAP1tx99tBldk6E4Tfq
         BfwA==
X-Forwarded-Encrypted: i=1; AJvYcCVuUO3JDv+zx3vFQrvZfGQoN8RwZVRZLBq2dGOVMLgE9OsWoAtmDP7kCSC6s6Ip9aHuDtcE5zr4pqf+ji+eXUqnOBSVO18=
X-Gm-Message-State: AOJu0YxUgsnh7+87yZa+K/AxHkyoMjPXjxYVmS22Sd84rMbPn7cUB3rM
	3RcPwCINxj+L1O85jj7XbgXnVzzKWJ1RzzwLJlHNLrkNWkykVQJlb8X3BfOqYos=
X-Google-Smtp-Source: AGHT+IHR3MbTAXPGdjRNf/QL+MFD2IJBEm9Y6V3orFfaoZDzq3rR0+g0I0blT1MsQ9Ixtyj6g+KxiA==
X-Received: by 2002:a05:620a:e85:b0:790:9e84:9b75 with SMTP id af79cd13be357-792b247fbdcmr40342785a.12.1715099143771;
        Tue, 07 May 2024 09:25:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0079291bf9505sm2963899qkn.41.2024.05.07.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:25:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4NdO-0001Rh-8Y;
	Tue, 07 May 2024 13:25:42 -0300
Date: Tue, 7 May 2024 13:25:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 3/6] iommu/riscv: support GSCID
Message-ID: <20240507162542.GB4718@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-4-zong.li@sifive.com>
 <20240507151516.GK901876@ziepe.ca>
 <CANXhq0qLbC2RgW04C5DcuzR-kSmT3hA9rWW=w3e3PKHr+QsyzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0qLbC2RgW04C5DcuzR-kSmT3hA9rWW=w3e3PKHr+QsyzQ@mail.gmail.com>

On Tue, May 07, 2024 at 11:52:15PM +0800, Zong Li wrote:
> On Tue, May 7, 2024 at 11:15 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, May 07, 2024 at 10:25:57PM +0800, Zong Li wrote:
> > > @@ -919,29 +924,43 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> > >       rcu_read_lock();
> > >
> > >       prev = NULL;
> > > -     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > > -             iommu = dev_to_iommu(bond->dev);
> > >
> > > -             /*
> > > -              * IOTLB invalidation request can be safely omitted if already sent
> > > -              * to the IOMMU for the same PSCID, and with domain->bonds list
> > > -              * arranged based on the device's IOMMU, it's sufficient to check
> > > -              * last device the invalidation was sent to.
> > > -              */
> > > -             if (iommu == prev)
> > > -                     continue;
> > > -
> > > -             riscv_iommu_cmd_inval_vma(&cmd);
> > > -             riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > > -             if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > > -                     for (iova = start; iova < end; iova += PAGE_SIZE) {
> > > -                             riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> > > +     /*
> > > +      * Host domain needs to flush entries in stage-2 for MSI mapping.
> > > +      * However, device is bound to s1 domain instead of s2 domain.
> > > +      * We need to flush mapping without looping devices of s2 domain
> > > +      */
> > > +     if (domain->gscid) {
> > > +             riscv_iommu_cmd_inval_gvma(&cmd);
> > > +             riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
> > > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > > +             riscv_iommu_cmd_iofence(&cmd);
> > > +             riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
> >
> > Is iommu null here? Where did it come from?
> >
> > This looks wrong too. The "bonds" list is sort of misnamed, it is
> > really a list of invalidation instructions. If you need a special
> > invalidation instruction for this case then you should allocate a
> > memory and add it to the bond list when the attach is done.
> >
> > Invalidation should simply iterate over the bond list and do the
> > instructions it contains, always.
> 
> I messed up this piece of code while cleaning it. I will fix it in the
> next version. However, after your tips, it seems to me that we should
> allocate a new bond entry in the s2 domain's list. 

Yes, when the nest is attached the S2's bond should get a GSCID
invalidation instruction and the S1's bond should get no invalidation
instruction. Bond is better understood as "paging domain invalidation
instructions".

(also if you follow this advice, then again, I don't see why the idr
allocators are global)

You have to make a decision on the user invalidation flow, and some of
that depends on what you plan to do for ATS invalidation.

It is OK to make the nested domain locked to a single iommu, enforced
at attach time, but don't use the bond list to do it.

For single iommu you'd just de-virtualize the PSCID and the ATS vRID
and stuff the commands into the single iommu. But this shouldn't
interact with the bond. The bond list is about invalidation
instructions for the paging domain. Just loosely store the owning
instace in the nesting domain struct.

Also please be careful that you don't advertise ATS support to the
guest before the kernel driver understands how to support it. You
should probably put a note to that effect in the uapi struct for the
get info patch.

Jason
