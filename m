Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5ACA41
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 12:17:28 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b9ede6195cso5614539a34.3
        for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690373848; x=1690978648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/0PSB6Q4tQ0VbeXGuwPR8oxpl0KqMEC65BPmeAh9GDM=;
        b=G05f6CZe5H/9IGsFUzRc8wADFR0C472XZD5MzGbH2v3Z9Z0EiZdKBGI5zqU3T3dQCA
         AvCK9JYcta0Jzsvlmo7hAbvSjG0FCtCG9XhV+XFKEdZySfo+1Tk+7Ja+G2eig3OqNtCy
         MdWWpPFPDJI4rm2w5wxnP6qS59yUxxo9v9sIoAxEYeWkR+LTpC8cic+YxfENN0BtJXmE
         rnUCjNbgVhpgF+qYxtHe9DXvPTY9EC93G9QoEF3zJlzgxSLh0Pp7uO//A3gCkIeiLNav
         C+f1t29bNFYt7fPydYq+G50UxWkDGM5m+D0p7DFMD9wr8SlitZ3sHdA7fYyrYe6YS/yy
         7kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373848; x=1690978648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0PSB6Q4tQ0VbeXGuwPR8oxpl0KqMEC65BPmeAh9GDM=;
        b=de1QS2PXItF6RD1hcbD2fNFhSstaPQ+Sa0rnuKXAZK5NXGArfIFWooZUtfxTeanhY4
         JlcIaVecugBUp35DqmfxHGwjO7hUftHQWLqth0+m3O9eGktRO41XfHeaUEeHfXMvmn0b
         4wxWtjqtEj8j74o9nNXHhIJGjOtod1/lTB+TrMUoTLOfHZl2nmhVtJnIID7TKytboaqD
         oQ8WcTC71PalJ4vYnEclmeWSLJEjiQ36LAxwDQudEzad0Z4//oihff1BeIAKC5IJda1W
         I4g7ccACvqJb9Owkk1KDdHTpKHbzt+ShetuC+eTdrBAMhUkFEoW/r5QzDm3mCsCgfDzP
         gffw==
X-Gm-Message-State: ABy/qLZczwN5yphNWyGF6CIIEQ+IpM/3xeGoMYAK+MtUD0eQPDHkgPEN
	p1hbtizaYFR+HKljUGLGpm0XwQ==
X-Google-Smtp-Source: APBJJlER/vAICvmtsZSZspI3r1Rtl4DeBU/8Xh5ht8tNl2f1NYU+kdczAWKMT7jUT8bkQnv76vuP2g==
X-Received: by 2002:a05:6870:1fc3:b0:1bb:5756:3c06 with SMTP id gp3-20020a0568701fc300b001bb57563c06mr2013185oac.53.1690373847896;
        Wed, 26 Jul 2023 05:17:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w10-20020ac86b0a000000b003f9c6a311e1sm4731716qts.47.2023.07.26.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:17:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qOdSI-000uxy-Jm;
	Wed, 26 Jul 2023 09:17:26 -0300
Date: Wed, 26 Jul 2023 09:17:26 -0300
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
Message-ID: <ZMEO1kNGfGjN6kZM@ziepe.ca>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
 <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>

On Wed, Jul 26, 2023 at 12:26:14PM +0800, Zong Li wrote:
> On Wed, Jul 26, 2023 at 11:21 AM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > On 2023/7/24 21:23, Zong Li wrote:
> > >>>>> In RISC-V IOMMU, certain devices can be set to bypass mode when the
> > >>>>> IOMMU is in translation mode. To identify the devices that require
> > >>>>> bypass mode by default, does it be sensible to add a property to
> > >>>>> indicate this behavior?
> > >>>> Bypass mode for a device is a property of that device (similar to dma-coherent)
> > >>>> and not of the IOMMU. Other architectures (ARM and x86) never added such
> > >>>> a device property for bypass mode so I guess it is NOT ADVISABLE to do it.
> > >>>>
> > >>>> If this is REALLY required then we can do something similar to the QCOM
> > >>>> SMMU driver where they have a whitelist of devices which are allowed to
> > >>>> be in bypass mode (i.e. IOMMU_DOMAIN_IDENTITY) based their device
> > >>>> compatible string and any device outside this whitelist is
> > >>>> blocked by default.

I have a draft patch someplace that consolidated all this quirk
checking into the core code. Generally the expectation is that any
device behind an iommu is fully functional in all modes. The existing
quirks are for HW defects that make some devices not work properly. In
this case the right outcome seems to be effectively blocking them from
using the iommu.

So, you should explain a lot more what "require bypass mode" means in
the RISCV world and why any device would need it.

Jason
