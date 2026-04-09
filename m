Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002D3DCD81
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747763; cv=none; b=gz6k5jZXx7vTsNUlFCdIEoRM+hhzCcBiI40pjKMcbq5tGdMbFbyhp0R81n0A6plPrfeBH2LXqaCuv78ddJ2oTfzwfq8hE/KfAjQlCX8V1FG91aYNkc9wtoCssZLBnjjFIDl9w0x+H1YjvX74SEuHlJ7SGK7FxrAF5loqN+LQ+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747763; c=relaxed/simple;
	bh=lPGV8AFmLuXxJZ6gD+bLN7/Il/AxPMIpR2Jc3CtNGME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdyQ95GadW8TIzLap0j60A3a/6Y454bqs5tYA4BphYgGwClJwLB/DQL4OgZjAVXe3V6Ub4/UE0FToLVTp2LaVuJ66eykQL53eEIOS8CO+ioXkzaxExa8qoyM0gUPv0KofqvTVwVzi4sAwYi2Za4Qs30TEBUmoPYVa52/BJydElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I2kPSELv; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I2kPSELv"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6501d242e2fso1079811d50.3
        for <iommu@lists.linux.dev>; Thu, 09 Apr 2026 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775747761; x=1776352561; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hPQPBOBgtkvcgYqzt6x5wusYckTuQGEX69sblOJCEYc=;
        b=I2kPSELvoeKDThHetUs0RggmNn9sEwy0LonOmTETamBk620amGjzV8PcmMqG4PQnBm
         do8vpf7+wUBFt0lLCX3NpBu/UAwNVwY/zqakffq93hCc53uva50SdEB+ld7tgxaEcZ9M
         iyEaEM//ICAvcAb5bubeO1cHiG+Hi578Zc4ZtklRv4HnPgkXPxDeFlqbbL9Pv6fcZ7SP
         EFPMbwiAIPKWDCKSmTthAy9JB9eHF2dw8CiHSRpUCugwoJDR0N5XKNJ8RBXiep9UToWm
         Ctq7E5VYYKklXMqYZp4puxqjTPFzBv8SHYD9TMKAmdntqmPsWvFenqKCOr4ednHv5Yrf
         1wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747761; x=1776352561;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPQPBOBgtkvcgYqzt6x5wusYckTuQGEX69sblOJCEYc=;
        b=XeYmaKT5yZCEItoUUNMcA6vor5NZeE+MEwAJEIFULaUUhZxcmpiAqEpND1vuUEZj7c
         dTmhbVUc2/slmDNXRiG9d+wDTPblIVrW4iZIotAcWBFHIidq4Tk5OKVpB7vJoIjpmRnJ
         iFS1WEB71hXBAHoeJEBS6Z8B5GbvUJz5CLN1eHz4VqS4rYCfWP6hMziFTH34A5JjZYy3
         9zsfQxxwVcPoe+3zly5X7lUvj2Q68wZ7iiRZX26dzIPrRLGMo9To3LK+riwliG8x5g7z
         nP8q/pv+679a1R3Qc5ov+2qz1u44cqSGToB3JAB+yMBp0dCM/wdHFb+mJ4vjsSqEQBAf
         ulYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV7otl40PWB0Dysr3DMNBnHMIh2nzlT+Clp2bacgKMVfyRECPa2IhOXqclDNrcihz7166+Uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSm4o/0ftNmaS2GmdNdCFpU+JQ6hIPWf0JF6mHuJSnVmSYqxH5
	S8QGF3BYujI1fqWP1tAGUbz3ZvaTq7txpgMtBGlI0JDkq/peBk+K/3mikIwKzc0NC8E=
X-Gm-Gg: AeBDievDNyGQ9kZN55d72hY1PCHcwFCK5JAP20Axu37BGiLtLxpH/1baW8+CfKW4CWv
	gP/zzx5o6latNK7AcD0uSI7fqsKDmqid3dabUc7U6UHKhyZOrOQBl5hgkLtHpthDZ4k0mu0eLD+
	nUdcHN7HfMLITZQdA2m3tJ+8HNp92tZwo6fcZ5Ee2vofM9fNNKiCnM6kqy7h7InH8Mv6VwyzDfF
	poI7vkUo7Ed2V0+SuMLgY+MCAYXB8aMlag3I6O8TBvrTo+cBJ0DvQ90F1KFFOz9svNoOgdNNdP8
	3VfuP2KZ+XxF9thPy239OJZd754sYraFkOmAMoJQpxe5UbX/yxyzvvCuvQIC6kdrTPu1zs4xjAj
	C81akaNL89TqjEeyzfvbHnH0a0pu0RPR8lFZxGXEzNvzVxilKeYtKVlGJPJtoy5Vak6mBiCaWf1
	T+oyPhw00yy2k2KpMxp0stUWTbbUIbvZNllEtLpntID9w/xyK1g0xDH/exIXzTwz0tpFMTiQ==
X-Received: by 2002:a05:690e:43d1:b0:650:8c3:8df2 with SMTP id 956f58d0204a3-650488afacemr17793279d50.62.1775747760893;
        Thu, 09 Apr 2026 08:16:00 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8067c73sm1700572085a.24.2026.04.09.08.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:16:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wAr6t-00000008Ihi-0wvj;
	Thu, 09 Apr 2026 12:15:59 -0300
Date: Thu, 9 Apr 2026 12:15:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260409151559.GR2551565@ziepe.ca>
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca>
 <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
 <20260407012726.GN2551565@ziepe.ca>
 <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>

On Mon, Apr 06, 2026 at 06:40:05PM -0700, Sina Hassani wrote:
> On Mon, Apr 6, 2026 at 6:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> > > On Mon, Apr 6, 2026 at 6:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> > > >
> > > > > io_pagetable *iopt, unsigned long start,
> > > > >                 unmapped_bytes += area_last - area_first + 1;
> > > > >
> > > > >                 down_write(&iopt->iova_rwsem);
> > > > > +
> > > > > +               /* Do not reconsider things already unmapped in case of
> > > > > +                * concurrent allocation */
> > > > > +               start = area_last + 1;
> > > >
> > > > area_last can be ULONG_MAX so this literally overflows to 0. It is why
> > > > I formed the suggestion I gave as I did
> > > >
> > > Yes, in which case the  if (start < area_last) that follows will catch
> > > it. Are you suggesting I compare against ULONG_MAX instead?
> >
> > iommufd does not have any overflows to 0 and rely on it tricks like
> > this. You should just compare to the existing iteration last
> >
> Just to confirm that I understand correctly, like this?
> 
> +               if (area_last >= last) {
> +                       break;
> +.              } else {
> +.                      start = area_last + 1;
> +               }

Yeah that looks Ok

Jason
