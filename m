Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B82C0F96
	for <iommu@lists.linux.dev>; Fri,  3 Oct 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493381; cv=none; b=t8K9jgQJam6q8LpdVfiYQvdxo5MOYyXgn7iifZz1mEKsCCndFM/rTW3gzHzF1ZQWsm5df+rl0P2PyXGhFGhYaswAT5hXkrG0IJbWJHmRU1+RKsJIOzK/d4g7gonqi5V+Ip1mwtt/GDlyDWVVBHmPAnsD0k5u84Pmfdam/PMuIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493381; c=relaxed/simple;
	bh=IGPBqNUyobL1TuTPpcRMGIWaY8QqCGlZoxv7ahbDfro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKXo52zuGf0jJt0A8tU7y3hZ3+aJhJKR4yG3C2JueHFvXyDeGLIe9iL9TSjCGSvtaUP0wpMnYiZLQ6vGJe9mWHqquPDQ30E5aU0IEADYlhOiDj5XUAuOzW/zeReAz2xHX6kYaW/eedF8nBZqDfgN1q8r4XEMsGnA+hIZOIKhZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MISQLFsD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MISQLFsD"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e06163d9e9so21399201cf.3
        for <iommu@lists.linux.dev>; Fri, 03 Oct 2025 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759493378; x=1760098178; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhGKQmLihhqwED1FmckHDQNVWwmhyauTuFXOfWk0260=;
        b=MISQLFsDJuqznAj9oIYOXp8JA87wYwJLv8XWsfQsFR9vrW5KJGrqp1MkaWL9J5liwq
         Q2h80TPQoC6T+iMYKxz6GhdNrsUAbkM1uE9RtN+drQ9vdFKwhbi4PYBU6qnNeNjnasew
         u7u1pHNgt19l0obs7DFQ4eev9XyV7ggHEz75OPfa0AC/bm2FwNbvKjRiuFC6xENiJjok
         ZqiZ7e3q+zDatRqb2dWW0PEw4w0EF2+vU3QSWeeN4hXdCPE+mD33DW3FKaAwRhkpP14S
         xt7+R5Kp6UZUaYh5RDc24cbm0bWcAovUWUcjNqa8i7hQlpEYS7957jnPjnDZ6VBDhwt1
         WsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493378; x=1760098178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhGKQmLihhqwED1FmckHDQNVWwmhyauTuFXOfWk0260=;
        b=B8JCKD1ovOLnANiz8D/4/5aM77NTOt1fOyD1NT+BROVrS0AJKjU7hEbcZP948n2Voe
         sSctrVa5HymtlRIFK8RwEnLPkwX/hVcgHMd2dkx76JY74EcM+S5EyPwWLY+BzkHz2rzO
         o9Q3b/GgJQfMIGiz7BedcXZcDMZ0UyEr/UfO6yYZSDM5tA8j885gdfpzeYuTusvGeAdN
         BV7mlF9kzIfuKBVJXJFR+oZa2L582OZbcepkzAXvZ8IOQFz5eWoc79++mQs2/6VRbPmK
         zwzEVtcR+yhTcYZD3wkgx+SEb+lyVtXPkFbyodqsc9bU2/YghyT4u+gKRdBzrT6j+fpd
         PdHg==
X-Forwarded-Encrypted: i=1; AJvYcCWCyt9qX+B8xfBvHkE7c/FG1C8QKoLWhUbe8CZ0JBLFLCo2HHAARVmKLju5ZuVkoLalj2oZrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrpDCsVvjP8It9L2QYZ4kfmZY9xDS+klYzauBTUkElw4riLSPr
	eOPFA06xpphCwB4ETkecx+XGWxdKHRMBGkYxyjzCS53mX0jYSzrW3cqFAljMuVHhiNw=
X-Gm-Gg: ASbGnctLchyRc2/+1JQSJAtYULh00QBvElMH/+qMZ33JwKOBm6yFxm6xXgXq0CmSg4q
	c9cof01E94acIIzbo3WZdAKp3DCy3j9kKE5invKKejQLsma4igxaSuwKmuJ5394gPWmCjzcelk5
	CZcqyXe6GG6NLFEYYqcWIc0Rsg5tlDVESzMIxAfCePeOv4/IL7bUzyeABu+ZuUmhVDY7RNytabt
	86m5hoDSWtK/x2Bi2YDpEM3+gIU+ls7L8zrI28oJWO8+a+o6HGSFrKgo3aQVIdWCfdZR72yYWbH
	61O6yYuI+d3+tSoJ/HP0zH8jThsOiOChwfLKUSgtHLjKR5T8mhjQ29LBtma5yi7CV4R/aGPyfBv
	cVXTR974PxKeKIytvKfLEktqstuG3edYrUJaat+Lalg35F3sxKvA+uriMiOAvMuaCD8dO4LuArV
	nGGT/x0ilctlj0eJO7
X-Google-Smtp-Source: AGHT+IFLcg1ywpHVdK051SrZ5/A9Wb7YpArYuwRz7ad7HjSe533gqbs0gQO57Kylg3jXc3KFtz9WxQ==
X-Received: by 2002:ac8:6f14:0:b0:4dc:82dd:5611 with SMTP id d75a77b69052e-4e576ab8ec9mr34330421cf.48.1759493378126;
        Fri, 03 Oct 2025 05:09:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129f4csm410395085a.12.2025.10.03.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:09:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4ebQ-0000000E4oz-18oI;
	Fri, 03 Oct 2025 09:09:36 -0300
Date: Fri, 3 Oct 2025 09:09:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251003120936.GN3195829@ziepe.ca>
References: <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
 <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca>
 <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
 <20251002211217.GI3195829@ziepe.ca>
 <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>
 <20251002225834.GJ3195829@ziepe.ca>
 <CAAywjhS77-Kw7GVgksimZ8-Oy+kSvCPpL8xQfJt0eQHwf=WH_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhS77-Kw7GVgksimZ8-Oy+kSvCPpL8xQfJt0eQHwf=WH_g@mail.gmail.com>

On Thu, Oct 02, 2025 at 04:56:57PM -0700, Samiullah Khawaja wrote:
> > So if you have a notion that finish is disallowed and when it is
> > actually finished maybe the order doesn't matter?
> 
> I think FINISH for FDs in a SESSION is not atomic. If a dependency
> memfd gets its FINISH call first, it might make itself mutable before
> the iommufd FINISH callback fails because old HWPT is not replaced
> yet. By then, it would be too late; the memfd has already become
> mutable. That is why order would be needed.

I'm thinking of having an counter in the session and the iommu_domain
holds it elevated until it is destroyed. Finish can't even start until
the counter is 0.

If the counter is 0 then it is fine to unfreeze all the remaning
objects in any order.

Jason
