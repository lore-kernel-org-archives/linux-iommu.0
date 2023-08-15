Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28914276
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 18:38:26 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bc7e65ea44so38834835ad.1
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692124706; x=1692729506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sF+cwDNQT+uZaPiDDTMoz6OzsKpTvp3erzo3Rj0grKs=;
        b=dv7XIkl+hk3kQfxv13TRju7OfbWc6xtCFh3vJAocizGBFya10lRk+XpWtRfdN+DyI1
         44H0sEMPGXExXkU6incGJ7STzLczFbH5I1sZKjk7rxi+Q1dK4mhmfQU69wTgzXkEI1dP
         qPoT3nsDQP05EqETsqVoVjdNO6N1yg7BjaIlH3tTT+rqTTQ4Zf4Ax5GD0smTlvHNxDps
         W+Pb+lcTnXYWIZuCv4eqaIh05DOh+c2iajzX+TPpZ/BZY1eOygOkJnxKf5JcpQCQD7zs
         3U7myd1FR4JCVPG3Dn8RWGRAB43csZKlbZs053c90bUHTOjWarMGlg5iqBy3jwVrAGEQ
         0QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124706; x=1692729506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sF+cwDNQT+uZaPiDDTMoz6OzsKpTvp3erzo3Rj0grKs=;
        b=Uz+F170H3R8STKzcPnHiOWitSQr7Z/yQghmDq9CzvlAOqwdruJHwEBRIibFzqoc1IJ
         UIaGE3mZUloRp7E9vMtJjM4SwFhRDVT515wWNTC72QHHYhMtjkywOIAy20lY0xZt9Twj
         FwOnIK2enuPGJgkOYyFLtyh55o116jCSGRzxsokICvTR7YtEkoNYFK5sP3f1RRVgkJP8
         gWOI5SBQG1/GJ5pCLUPQPrWYEkOOBRgjzUBXlc16lP2G/lIfH6w8oXzO4RXDVmZ9cEuI
         BexPo41P7/LxRCt7L2CXZVizQDZkwoBxG1heQfS30F+OTl4fRlIcSd4DFBGQwfRNBz9d
         MY1A==
X-Gm-Message-State: AOJu0YyWZAit+K7aNt9fvyEHeQLgN1A8yLQSpegyuMtX4mOv276Nuogs
	R5Z/dwdT1aMqFEpohhowPVR80g==
X-Google-Smtp-Source: AGHT+IEoy/q9mUWwPMqxGsuzGevjSDRWvRXsimZkzJcdD4KCN2k3JJ/Zgp1nYbrk8s7GE8PQcYr0yQ==
X-Received: by 2002:a17:902:dac4:b0:1ba:fe6a:3845 with SMTP id q4-20020a170902dac400b001bafe6a3845mr3590310plx.11.1692124705743;
        Tue, 15 Aug 2023 11:38:25 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902768b00b001bb750189desm11380667pll.255.2023.08.15.11.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:38:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVyvv-007hpI-NM;
	Tue, 15 Aug 2023 15:38:23 -0300
Date: Tue, 15 Aug 2023 15:38:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
	linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
	iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
Message-ID: <ZNvGH91EmlOAaxBK@ziepe.ca>
References: <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
 <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
 <ZMEO1kNGfGjN6kZM@ziepe.ca>
 <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
 <ZNOpbac4i5zfmHj4@ziepe.ca>
 <CANXhq0rzz1Sn8dKvNt7acvKN_g5yXFN9u6XPiRHr9ay7q2VbzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0rzz1Sn8dKvNt7acvKN_g5yXFN9u6XPiRHr9ay7q2VbzA@mail.gmail.com>

On Tue, Aug 15, 2023 at 09:28:54AM +0800, Zong Li wrote:
> On Wed, Aug 9, 2023 at 10:57 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Jul 27, 2023 at 10:42:47AM +0800, Zong Li wrote:
> >
> > > Perhaps this question could be related to the scenarios in which
> > > devices wish to be in bypass mode when the IOMMU is in translation
> > > mode, and why IOMMU defines/supports this case. Currently, I could
> > > envision a scenario where a device is already connected to the IOMMU
> > > in hardware, but it is not functioning correctly, or there are
> > > performance impacts. If modifying the hardware is not feasible, a
> > > default configuration that allows bypass mode could be provided as a
> > > solution. There might be other scenarios that I might have overlooked.
> > > It seems to me since IOMMU supports this configuration, it would be
> > > advantageous to have an approach to achieve it, and DT might be a
> > > flexible way.
> >
> > So far we've taken the approach that broken hardware is quirked in the
> > kernel by matching OF compatible string pattners. This is HW that is
> > completely broken and the IOMMU doesn't work at all for it.
> >
> > HW that is slow or whatever is not quirked and this is an admin policy
> > choice where the system should land on the security/performance
> > spectrum.
> >
> > So I'm not sure adding DT makes sense here.
> >
> 
> Hi Jason,
> Sorry for being late here, I hadn't noticed this reply earlier. The
> approach seems to address the situation. Could you kindly provide
> information about the location of the patches? I was wondering about
> further details regarding this particular implementation. Thanks

There are a couple versions, eg  
 arm_smmu_def_domain_type()
 qcom_smmu_def_domain_type()

Jason
