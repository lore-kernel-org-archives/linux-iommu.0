Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC236199B9
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915504; cv=none; b=XkoFlf7LD5yYqVKcaFr5XwDpRA0sCBK5WjlhyVkXGT3XczVBl+mz+MaT62N9URqFvkyc86tsXB324kXohS+YFS1CHTBZgizcVGhQok7twBdUDFrELtG3zd1b/F6AlPdtEPj5La2NEpIBmNuq2ZWkl/m2WQhkMXLyq5QwYvj42Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915504; c=relaxed/simple;
	bh=APx2E3fvp48dROhXirvbfoT7BMcdWI18I17pXx4JJhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMy73HfAeibsqmzMT0LRDsiBz9QK8ADl8xxmR7BiTaqJNi5tZcnMTM9Q/kVgPizfTIMaBvDk73CTbtIPk016DuPdeiMSFkcPrkp3qlRQscotSne+kKvsEkbuHep16TVHJh/1h5TiEs75QuITT/SzE09kFY2zVx+996EmycdBzqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iQd4RxTY; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iQd4RxTY"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c031c24fbeso2344137b6e.3
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 04:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707915501; x=1708520301; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BshCFmZRTopNtWYiAcH887NjvRSn30bZAm3GwAPRNi4=;
        b=iQd4RxTYCNiq/TVHPInhaZkWSarcsBxTPiBvtlg+Jr0/j6U7L6zIYlCZ+NbgUMhJJo
         67LgzND2jIED+6a4DtieDV4ytYIQSv5jnhIGheoWqSfNCFwSxqQ4Ad9QD33EPG08Z9A+
         zMqiUcEcayTtyBQ6+M1X8wUMNDHpsuCJ210bB7wnayqo3HGnghXBb/GBKG0jQfzybyzA
         0XRJE7wBD6MPlO7KMkOyPkhypR8ZZckYz044QjxONpjIaXQtwyIu1xCLOWP4TRGjLFx3
         wrpY8OUX+lKvaWL3TpRhZIntd8pK4frua8LQjlBmJRhfMY3Xnj4b6Reg07QORm2Z6sKR
         so5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707915501; x=1708520301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BshCFmZRTopNtWYiAcH887NjvRSn30bZAm3GwAPRNi4=;
        b=hqk7kRs4SDGZVIlJ2Vobd9xiN6zvpVR1u030RQ3gb7J2MjmFnnnNWMsGhdthAOXbQo
         E66xzefkyiHcOVnoFMCO1R+ytNmoWtU2ClMFNfEyFwaTIkwPXy9sVbUmT/cxqOTZhCmg
         w83AV5pyq2BeQYOQ5NXbFUoxFWKAlz71DGHwMT2EskSdzQOEnmYeFektDUGyX2ktdCEB
         +lev6V8eeSgV0e73OiS8RLUDMmG0F5NPUV7EymI82FAg7lOefpBbYBNHPfWxgRyYjRU1
         HjDiB01vdcFkemUmASaZ3MofvvIyg10tWwQQSvJAumA7gk+n5kzaLcMvQcrFsQi3OAvQ
         fezw==
X-Forwarded-Encrypted: i=1; AJvYcCU+08fZUQINFX8KPtV5LoV6oU7SRzjgZUJDU92g0zV7ElSxAaO+NX7jH7BtxSA1Menwsxj7498OnLZXcNwb6GFyQ0zV+24=
X-Gm-Message-State: AOJu0YwGfoXFEHzvzVhS+VUqcSYMsrQAIBHcYrCxqYPjYelxnirJmVgf
	3x3KL39nv4PfmRVYzmdJK0TL90/OFKNnQxLkJyhSPHA5DTeoeIOzer2nx7Ik3yo=
X-Google-Smtp-Source: AGHT+IESNQrgHfg5JgyaHpHE+qWwetm/jueQiitOJitnpPoqM/W2YOs3iN/UgpbRKLLVU/CAztYjgw==
X-Received: by 2002:a05:6808:3987:b0:3c0:40f0:7985 with SMTP id gq7-20020a056808398700b003c040f07985mr3316077oib.55.1707915500870;
        Wed, 14 Feb 2024 04:58:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaM4shHxQPZNY2W7OsOMIR0XxdEA1Z6eic/XG0Pn660Nqds49rj4683zF/wT0Y5mn7KrPql2LcGLFYOhDDnqtnm0Nhdzh846p/obNRHtUueM0j/v8HpRyRL6fVBsYSxC1UDm95m2DC6e1PHgh1FFGvBWk6p69FCTONJbdqHokwgOJcOC0j70P8JtoYqJK7xKP55TZXMEuU+iHSauhgojL/vs1XozbQyCoiPBC2v5Bi79kmSR3k1AR6q7R3xXmDgpceDF1ajy/sK7Xpt98GNpUe0Laar02lZ+UrEbF5eZZibLrleK7ilgX8tuMuSwx5IoRqCio49mnwJGFtErgu478iMwhEJPxtUL33HGVPACVZilMRLBdWElcG5wbZaCtvwgfcEn1ApwKksQGEy8fxHEDVdW3+FLMMo5dV5cZ6ArimIBUpAwM7hQPBmE7ahj86IfajfCZk7VPGD5j3aXhKzSi2IdWR82LcFJwfM3OBD/3y92S3Z2zzN6Go7QpaTDKdHeaZgTxb016H6bwSVerGegkg7Ez2G6wg4NPutwP86Q==
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ok5-20020a0562143c8500b0068f057ec7b9sm334991qvb.131.2024.02.14.04.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:58:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1raEqB-00AhZD-Qh;
	Wed, 14 Feb 2024 08:58:19 -0400
Date: Wed, 14 Feb 2024 08:58:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>, iommu@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	jroedel@suse.de, tpearson@raptorengineering.com, aik@amd.com,
	bgray@linux.ibm.com, gregkh@linuxfoundation.org,
	gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com
Subject: Re: [PATCH] powerpc/iommu: Fix the missing iommu_group_put() during
 platform domain attach
Message-ID: <20240214125819.GA1299735@ziepe.ca>
References: <170784021983.6249.10039296655906636112.stgit@linux.ibm.com>
 <20240213172128.GM765010@ziepe.ca>
 <4f5e638d-30a2-4207-b515-d07c20b0fb47@linux.vnet.ibm.com>
 <87le7n6wcf.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le7n6wcf.fsf@mail.lhotse>

On Wed, Feb 14, 2024 at 11:53:20PM +1100, Michael Ellerman wrote:
> Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com> writes:
> > Thanks for the patch. Applied this patch and verified and issue is fixed.
> >
> > This issue way originally reported in the below mail.
> >
> > https://marc.info/?l=linux-kernel&m=170737160630106&w=2
> 
> Please use lore for links, in this case:
> 
> https://lore.kernel.org/all/274e0d2b-b5cc-475e-94e6-8427e88e271d@linux.vnet.ibm.com/

Also if you are respinning you may prefer this

@@ -1285,14 +1285,15 @@ spapr_tce_platform_iommu_attach_dev(struct iommu_domain *platform_domain,
                                    struct device *dev)
 {
        struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-       struct iommu_group *grp = iommu_group_get(dev);
        struct iommu_table_group *table_group;
+       struct iommu_group *grp;
        int ret = -EINVAL;
 
        /* At first attach the ownership is already set */
        if (!domain)
                return 0;
 
+       grp = iommu_group_get(dev);
        if (!grp)
                return -ENODEV;

Which is sort of why this happened in the first place :)

Jason
