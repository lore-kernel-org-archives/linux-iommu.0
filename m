Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202E19CCF5
	for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210231; cv=none; b=CQQ0pz8XHKrSS8mWL7zeT71SUZ36aBxtBCX6qiXG6M3c2eZ0Be4cfS6dYKFlTtDgdZFvZL/lvngWlkZRE7bFarJFcpbQ4a/PgrueD1JnDJh/4pRc670X+6JBC/tJ10S6iuAYAQUn/Ah1kt1rk1kjw+l+EjM2HgToRu2WR78k72I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210231; c=relaxed/simple;
	bh=WjDzpbIBR3ZhSTR1LHNfWgthm8tzVuTmUuZKaNFMUWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9iEPML/I7LSfA3NAJeHYVVu3rf0BZk7KdFqwFLPW/sZ1Re9xleLrXuSx/fUf5UdGitxdYfVrytbLZQbRA+/tjNYOBuxYLm6QvQvjTMGgQtVLo+/YL453w+hVcQLkqoZ7Rmxx8j5WrslgwO4vG60jPa3ryUXLwUHVCDfBoKLv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RIxSoFDN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RIxSoFDN"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d87610513so102256761cf.3
        for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777210229; x=1777815029; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yt3A8pADO9ZJrlnKUWoV4EH8uD2s2dkOvSuk8HhB068=;
        b=RIxSoFDN0+6RsYtHDBqs0u5pBAYPkaJPJrRNHYlBWoo1OOhT4fV/+WODzZV02GhQIN
         h9bwOadPESz2QDg3taNkoFJMP7bgDMpfUWrv4pPKCr/JpExdr9i0lvBCjRtMuV+rLBJ9
         /X/lmwQMXyQMpe7LRERHYhuku4KUK03+s7/3z1PbVl5oBqffNe4G4zDw0JlkURr6Y7qV
         6XM9IgvRJdg8oCPwGECiwRblRM8mY3v+uW/W5TBtBG5UiVlYVBb6B02celWrrx+h6rlC
         qbihiWJEDSilSaLtoXP355Vuazeeu+A5Qe1jp7WS237rN7gtQeGiNEplVfXVSaF+td0e
         gxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777210229; x=1777815029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt3A8pADO9ZJrlnKUWoV4EH8uD2s2dkOvSuk8HhB068=;
        b=rJf2X7B84IQdRGYywFniPtV9AaCobDcpjXsl0SQHexJh43YDZ+7RozI8ihYBxkmZbY
         AMUxSamky85iwpX87+E3CJm8eBy5c98zaDkKkd3hUJWORdY5d3Xq/DPv8/AuqXuyKB3v
         ftcaY93tw4hrY6s5ENyxVSUfh0tsCnGRTqrpEjwJk1qzKBH6lyCW7JGK+Jbnhw6IgCkE
         57u8HX4W9qvlOgfgKwmEQHNVyVGxEM0LqZNO0kpqOoHzimyympj+BfYJ1wyffjI6JByF
         n4+No6rTbGRrrbhX6BNbIER+RHroFkluZ/xticLyxENRba2oFzo+SPuIja+7vfJTtU/q
         sf7Q==
X-Forwarded-Encrypted: i=1; AFNElJ85iihIM1m2bRHngHFIO5r1KAd1LOODJMZmbckfP39bW7Bt8yTN67wwXwZBZt15kxbI8D+vjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxVFGewmi0Qauc4JnAtzIg9xi3YotgqTlB9beDgcn3j4MkCAiK
	1md3tPS95svsFOyV7+fo8qJcHyNxLpjhho9NqJ+ukv+1TpIsl8R8AkElTwucwHV8n7U=
X-Gm-Gg: AeBDievZFp+frU9eZydNEZbJCnaIkQcpFDwhzFqM5Kjcnu1yzhWzDyA2TXYtPS/pZad
	bdDi4XdLMjZn0tcZc30OUDKTFACeWnJQ9IMHf/U+Mt83NMTeL3dx0pf6bSw48TizEu2hvcyKmIn
	TLraCWylws/IVelACJxEgqE8XWmpJwLR63J0pAgYMUr3hpp4kPsIW6d3Jp6kKPif6hYIAvw0WfM
	4NF+OIaLh9LjQZhQquVzmb0Wty1R9Z/N7Hgp3xpNkIA5bxWIWOezYhuQ0VTyj+XI7YoK0gT7tue
	fEEogH1xfItlsM7mgDKqN7+iqExLy/IuqnWT59En3zm+aujIKMFFj7+KNx+4Ek00CFbdRWoGB3k
	aeBKr4C5V//XtHOPcGLhEp0NRU8BHU7BOjG/G+SugBaargXGT+/S4/SdPrcsyIuDm9e8nsBGmkY
	p/fbcMRcsCHK9Ypr8QSc0F8JODEfoTThBNmmV2hxGTRt7c3V9Y3j0j0oxOcXRHqPRUAOGOxJrRs
	JQI9eJaES5m8JQq
X-Received: by 2002:a05:622a:98e:b0:50d:7fe9:aa8a with SMTP id d75a77b69052e-50e36e9c3c8mr604759671cf.31.1777210228752;
        Sun, 26 Apr 2026 06:30:28 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e394c1fddsm246449421cf.30.2026.04.26.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 06:30:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGzZ5-0000000EnQT-0zsZ;
	Sun, 26 Apr 2026 10:30:27 -0300
Date: Sun, 26 Apr 2026 10:30:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Teddy Astie <teddy.astie@vates.tech>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: How to express "externally managed" IOMMU domains for
 VFIO/IOMMUFD ?
Message-ID: <20260426133027.GB3501894@ziepe.ca>
References: <1776873531.8631fc262581453bbf619ec5b2062170.19db5ea67ab000f373@vates.tech>
 <BN9PR11MB5276B3A829AD624A7E1AB4408C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B3A829AD624A7E1AB4408C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Apr 23, 2026 at 08:01:50AM +0000, Tian, Kevin wrote:
> > On Xen, we have a dedicated hypercalls for moving a device into another
> > guest (so it no longer belongs in Dom0, at far as DMA is concerned).
> > 
> > But it looks like there are no way to describe that idea of "attach that
> > device to this VM" nor "the device is in a VM"; which makes that
> > impracticable.
> > 
> > There may be things that could be done with the vIOMMU objects, but
> > there would be no "parent domain" in such case, as said earlier it
> > doesn't exist in the IOMMU subsystem.
> > 
> > What is expected to be done instead ?
> > 
> > Teddy
> > 
> > [1] https://www.youtube.com/watch?v=pLMGRgEJ-Eg
> > 
> 
> It'd be much easier to collect comments if you can put plain words
> to explain the problem rather than expecting other folks to watch
> the video first...

It sounds like CC and pkvm to me so I think it should re-use those
mechanisms..

Jason
