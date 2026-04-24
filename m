Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF723ABA7
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043803; cv=none; b=kjJOBy8nNEAaZH+fokBcEGwat0QWH+Y3KzIGAeqqnJ0hFSyRq9iHSpDivA27IbmfUuHk9wgAOZrrPPgB5470hAS0PXWIcCVwERnnhr0gRh9iDVj+el2+OABcEKANETX+U2r0oaZTAg6OIiO8DeJL/Uz7CIHYf0BV+rpjhQe1a5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043803; c=relaxed/simple;
	bh=tEKsRIMbVVImthEe0Ig9QHxM7y+PfDnbHxuik7nVS90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/Vk3IsqbfVOztTAO3bRljv2Nlr3TZ7cd73s2OlFLQdfF/4Tf8xJUjjzdBlatLzkniwJRnIOyUaproMPGLJ4LeZGy/DRBF+6h+PH6lqZJuZ7wJCuuehfhus1mkUGxcgVl38XL+vHLngnnE/qEDcUb5p+m2CclzfSjuYk3Z404+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B2JP9+cX; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B2JP9+cX"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56f8b51db2cso2489071e0c.1
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777043800; x=1777648600; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PzgLQxohs/il7NHvgFr010I6KflEnf0n78ToT8yVBKs=;
        b=B2JP9+cXltSmtx0NCYSvUfJjA4MUvLl0xWZCOnkFUX10wwbS74dtVw89N+IyzumogK
         yyGkb1F0JykcTGe8p/8iBw+FssIOypEL0VoSQCO+ltAvxJA1+iyZOoOe+WN4K6+5gH6i
         FwDMwuKt9HFhErll4nJolUIkwFqQbxN82/aNDf6t3tLmYGS8dUO+tilW5ULj4zulQUgW
         QBoZBQAZLdk0y8du287Cl6VWRSEVRbkYq9EoLNPUWb4LcJ2s1ZUqPaoI/o4l6Qbs/P0k
         DYtU6hSD71+IgecK2SsKB3v8hALVhWodirr6WaCBekyuVwcMYJxHp8Q56dM1vCULZXoT
         lKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043800; x=1777648600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzgLQxohs/il7NHvgFr010I6KflEnf0n78ToT8yVBKs=;
        b=CBkVjGwr1c/dhdr/X9FzMlffNxpJxcoYXh2ttj/VTKwIsBBEZu6kKWgfVwQ+svpFNh
         7vDd95ll1ffb9gQxtnNBM1xKk8zBoHfmWwdYp+nu4XuvABSxm1fBSKn4jgI/1vLEp6Ow
         uo6MAq6F1ZZl2FRMNIIk9vsRwh7a4DA5Vhp2fYOpOx4WgzLxjOrOpM0+DwQQcTIjiMzE
         vai9JlymsZFWB3R2FMOZXaTvEDYLydyOky5UenTJMeJf24qCsNGsvYKu40d6vVN+RjEr
         sCSVw/7BB1H8hM8MZOcu7PYBcMYzcqntbz6sxBOOg0JI+DhCZG0UwP22ZA7j6pn+k8Ng
         leJA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZTZoz+zslag442Pu6apTQ2XSbp2cYieFPXC8RRjzxes1NbL6ahEYn2cSobPvF0ci314rK5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm728eVm4FF5JfVz01TUUaKgfWkVxgpUxsTtuKE7ZbTnngNgSb
	Myh8DMsLWmnMlCPFsayaM2JjKqU9lHw+BUGN7St83N/Nb15VGbcYouHZ8chd4/JK+u4=
X-Gm-Gg: AeBDievhLLPgu3pyCDMj18VCGWxV+mORTyaK9gPfHCTvrq/s6ahbMLNZn8s7rbaPbhk
	mdMMfwYrj19tMyznEYXRYjwpXHD73Vd0gdfhsgVhbrdzU6UjX49+7AvhVXNnnzU+Scridd8vsNb
	P9dyIGX1i9zYhXPHTTHJTJVqw8i48X/xTazZLKVBmBhGCTo+KeGYyV8OJyywLSJdJrbPD6ReXiq
	ftGujytaBiELoa+0MdQPmP0I0JJ8dJMFjL/GCoakVFLXsSPPx9o10LNGWEPWmXnWSZdvUr8iAVV
	Gzj4TjpxjLvHFJeARKmWpk4ey26JoeHbilrYRFzAE6JKmT8ChX2GesX+xKZrAHtSEjQoPWZv275
	r1g3DBfrYP68lsPp1ejxlidwtp8U97H2FuMBfYY2j2fjq31SK9JVzHeyHVizlUpdE4Lyynhg+pc
	M1jS7yGqZIIpGD/o7Jz8kQYqJ5RAqBusKXn+csd1h1aTmHUfCTAprf7s4RMTCLMBGaXgwpXQHPe
	CgQ0NrpF3lmFy8O
X-Received: by 2002:a05:6122:289a:b0:56f:61d8:86d7 with SMTP id 71dfb90a1353d-56fa58bf83cmr16721886e0c.7.1777043800600;
        Fri, 24 Apr 2026 08:16:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b031f65a27sm181558956d6.16.2026.04.24.08.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:16:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGIGl-00000002yvf-2Ggp;
	Fri, 24 Apr 2026 12:16:39 -0300
Date: Fri, 24 Apr 2026 12:16:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Mentz <danielmentz@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <20260424151639.GE3611611@ziepe.ca>
References: <20260414194702.1229094-1-praan@google.com>
 <20260414194702.1229094-8-praan@google.com>
 <CAE2F3rCaBWtRruBbZcedrsLnkkETSniTWoxxYn+Lkac9ttsshQ@mail.gmail.com>
 <aejP5Yk72_FtZnIo@google.com>
 <CAE2F3rBeqrTkgqwYcY7SPiUaPap6y8Hj95T0KqWCnaG59VB_hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rBeqrTkgqwYcY7SPiUaPap6y8Hj95T0KqWCnaG59VB_hw@mail.gmail.com>

On Thu, Apr 23, 2026 at 10:24:30PM -0700, Daniel Mentz wrote:
> On Wed, Apr 22, 2026 at 6:41 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > > +       /* Clear the STOP FLAG to allow CMDQ Submissions */
> > >
> > > Clearing the STOP flag here seems premature. I propose the following sequence:
> > >
> > > * Set up command queue (SMMU_CR1, SMMU_CMDQ_BASE etc.)
> > > * Enable command queue
> > > * Clear STOP flag
> > > * Enable SMMU
> > >
> > > By clearing the STOP flag, you allow arm_smmu_cmdq_issue_cmdlist() to
> > > write to SMMU_CMDQ_PROD which then races against
> > > arm_smmu_device_reset() which also writes to SMMU_CMDQ_PROD.
> > >
> >
> > I agree, IIUC you're suggesting to clear the stop flag before the
> > TLBI_ALL and CFGI_ALL commands are issued by device_reset? We'll need
> > to clear the flag before device_reset issues the  TLBI_ALL AND CFGI_ALL.
> > Thus the sequence should be:
> >
> > * Set up CMDQ
> > * Enable CMDQ
> > * Clear STOP flag
> > * Issue TLBI_ALL + CFGI_ALL
> > * Enable SMMU
> >
> > Right?
> 
> Yes

This is making a very similar fencing argument to how Nicolin's series
works.

After clearing stop but before enablie SMMU you have to acquire all
concurrent threads updated data structure memory into this thread
because as soon as enable SMMU happens it will start reading that
memory and it must be 'either we see the latest copy' or 'we see an
old copy and guarenteed to see the invalidation'

Exactly the same as the reasoning used for attach with the
invalidation list. So I think you should look at the barrier design
there and ensure it exists here too.

Jason
