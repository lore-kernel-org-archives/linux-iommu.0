Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA13AB466
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944058; cv=none; b=Rp3g/7ejSNC3FGGZ1bNXJldhhdAQ/3Zcs4Jdn+gxYD8DR7N7FQcUxvdDlsbMmmp3ntMvmOzlD2VT2cQZKv0B138Z3q3UUYbxd5KNxY69IcbYhwU0kBfK7cM14WxmSeHhsXvZfVX6vz6MbfAvWkfsS58xbyAHtLUc6SJ5Af8GA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944058; c=relaxed/simple;
	bh=cw4aY6+xvzrYm0iCO2mGlo5F7FyS7T8m2XSxQSLnD5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R44eIi+qOfcXO0b1ZWJ7tHIZXAZU8jAU/veA18wh4JhdlRn44FO2qUZbpEMwFStdzUcqY1x7wgF5vJ6nvPKs0337N/bo2zsNvtK+1+D0k1FHBEkD3R1cgek8WnG3Onp9FukXNBMwDeby6KkHJBGdeLaJVOctGLf5kjGAtAviOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QnUNYp59; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QnUNYp59"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e855da580so242450885a.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783944055; x=1784548855; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5HCZAcclosWUynw+gIE6OLmOTVWR8tes+S5wt04CaM8=;
        b=QnUNYp59iEqsjLqp9g34zLI/dm2mokl92MXzQOudKq60YSqM/KifVJzsUk/OL/gTIS
         8MA9f4YC5qHGuxL+XRtJ1qA8rsELZmSlsZ95bgrIJqybhHtGBAe87ktRgfu4aO9yAopt
         YSSozUi+mfoMeLnmiCJmrjH2cxMrKVC8FacHuamQlkE6Rb4txWJyVA8khDPGHm2xFmMO
         H0oPj3UazXfkcoNd3ZndkDM2Lw9cdjQAe8DtaVByf2JLqIh1WdgKEkzEz1/edw07hwjM
         TkqfDp6L4odq7a8B8oeAA0hVwuIqs6v0Pl3lbmRtElpdDgw8gvuMr93a/kTpHuTvtCjq
         NOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944055; x=1784548855;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5HCZAcclosWUynw+gIE6OLmOTVWR8tes+S5wt04CaM8=;
        b=kPXLe8fBiae//iBLEu+WWkdVbRhHHx+/K5ceKK1E8PCa+UExShaV7P8fqE3TQos1o2
         0wxJRrHzl/98lgqXTzm/j43sNfJ68l+VoSmyKVx4hdL5qX8WW3soeDjLsCfkzuOIjOYJ
         8UbWGgCWG7Ha7XRFtGPcdGkiDAoCWoP+rdEUw3PBEutX1wIRt+9otBxP4xv07AIL0VgV
         E/vkGomDhxZcgnANnzCIRXRO2ZVpFVzdysT8eTSE904Q+11GN13BA3Yc0W1X2FU7Z1YS
         BfrIl5WCz9voIorqS6Jl63jL1Z1u2zjTmOH54fESzHAL3zOzLlM0RBTASsL2crJTwzlZ
         RuNw==
X-Forwarded-Encrypted: i=1; AHgh+RpJpV8ELarGyjliIxb3VUzPGQEz2pp5BzwYIF57+TfELG6d3LJghVCDZzmTacYC8FOaYMyLug==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXsAKJ5oAFFb5GqsEvsZoMjlhz+m3T8pDGaiKM6iSgdY4MwXXp
	ktXU4EPMujDscpFKaIw9bnCfVeWzdtVWjnuCVogHEC2YR36chdD5pAls81Fih+Ga6E4=
X-Gm-Gg: AfdE7ckgOVzVMvk2OLlbJdqIscsNvHUcr2rqC1O3wMAOgSvP5P0yE2uMLszmuNry36l
	wsAEViJNsuzRazowVWi7GhVOD8sR5GfhIYglNGSigd/sHi6s1wvhMaRbCPj8cPkpwh1fdUbmItd
	jn1Ahmhnl0/gDRECKdiYQ1i2mcTW9yX/9IXA0ItsaqQygBOgXhgSmN/2sw4I1ty+hMJStq+OXIn
	wLwWheGhd6JRo9hJfxwCos4dGyiFfdudoSBAkrpB0Lgzsf8i140iUBFJtrHlcjB9MB0zgSefxqC
	gI6YrG0ya2fKyczCUk8XCfmlY53sIWXquhW57hkYCXAduSps88Vzzy/Ue1xxs3eRLt2nwjzcTQq
	1UeuU3m2TOe+vaCAV9ZOn13sX8HVzjrmvLBLuHXShUqZPaITbA2VIQRnsQdjXVseO01+iPGA=
X-Received: by 2002:a05:620a:1712:b0:92e:5612:ba39 with SMTP id af79cd13be357-92ef2cb1651mr868484785a.44.1783944055161;
        Mon, 13 Jul 2026 05:00:55 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9b7dsm1066306685a.23.2026.07.13.05.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:00:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjFLB-0000000Cu4e-38Ps;
	Mon, 13 Jul 2026 09:00:53 -0300
Date: Mon, 13 Jul 2026 09:00:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nick Hollinghurst <nick.hollinghurst@raspberrypi.com>
Cc: Daniel Drake <dan@reactivated.net>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] iommu/generic_pt: Add Broadcom BCM2712 page table
 format
Message-ID: <20260713120053.GE1835788@ziepe.ca>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
 <20260712-bcm2712-iommu-submit-v1-4-80e10cdde2ea@reactivated.net>
 <CAPhyPA5CqCzsDZg1_Sfr=EP5G6uLnnvDmdd_REZPX_VpwS=VJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhyPA5CqCzsDZg1_Sfr=EP5G6uLnnvDmdd_REZPX_VpwS=VJA@mail.gmail.com>

On Mon, Jul 13, 2026 at 11:02:15AM +0100, Nick Hollinghurst wrote:
> Hi Daniel,
> 
> On Sun, 12 Jul 2026 at 22:19, Daniel Drake <dan@reactivated.net> wrote:
> >
> > The BCM2712 IOMMU implements a 2-level page table format. It is relatively
> > simple, with one unusual aspect: leaf entries can only be installed at
> > Level 0.
> 
> I should admit that a single-level huge page mapping is possible, but
> I was too lazy to implement it (and haven't much tested it).
> 
> It can be done by setting bits 31, 30 and 28 of the top-level entry
> (all other combinations of bits 31, 30 will point to a  next-level
> table). The page number is in 4K units but must be 4MB aligned.

Let's do that instead of the weird full level contiguation page thing
please

Jason
