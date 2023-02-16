Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65828E2
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 10:47:32 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso3836659wms.2
        for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 02:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L6cGhYejmXP7gqB3bw2vF3QoztsjWluwjTHj/jf8Uws=;
        b=PBc6KKJKbZ3iyuRUtK8YCSuz2fE2U0nOOKv4gwc5JAzo9KnzG6+tEIuW22y+Z2h7wp
         O2E9TmpoatjIsTIlnJq61rp4zXDmvAcTsgK40YWkbtzumnoCEzzAzc6/85UxzuTb9x/9
         /BfBOKANovWTBtZXk9OilYAVJ5aGUpoiBn4GM7jtLATZkeOSKi8q37Afn+W2Gyr+rhDf
         y++AW6LIt+arLfjfljiaK00eotTkGNULJn8dHQ7I6HLU/oIntHYrJdn0FRiaIWrofx2E
         7PQ627vGNKgpxZMxvVqNSn6IqfSqo/aKk65aLUZQvNmXTyeKELrBoN/tGX913VtXIGwC
         mD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6cGhYejmXP7gqB3bw2vF3QoztsjWluwjTHj/jf8Uws=;
        b=3oQHjHYVF6ybZ9udLUdxtOq9NcNgh9DlOrjwZ9m/BnfFdinZwbKFk1x0PyAMO76zo9
         wSVOliNIyFj1AaYv/7bxXoMZh1ddVIb8m2o+ArPmG4wZQy/XDg1xCIl1w+y1CN38YyhU
         wSsichJmMOyXN+EjQMnqUuaTVKcQpQAwPhZYvU7YMUbhn4OmOCWBjYBlBSMahjBp7Qy6
         VuoX0TBV1X5pE2kYSm5FsQLpVvwcsC94pOQGYodcyy2Tavy4yEMIaMRsMQc53Hc9Pn9H
         AM2sYylyl6PxGs0Crg4sHLsrdBX3sBuBYfKMw4fQLAOm0+e7+TD4GBIdA1PZVyDnu/MY
         B60w==
X-Gm-Message-State: AO0yUKVO+ErfExamGwQkzDG74auoeigi+1zdnFJCiSGA+oS4JlhtGJAF
	PnsoD1UALmPg+NHf7M2GLXI8iw==
X-Google-Smtp-Source: AK7set9j+Y/T2zdL7L9ZbqX0E7DPcvdQDA5CDDfLv72oFuHrrUchsK7J4Kv1ONGwlSnoCQ0pPMI9nQ==
X-Received: by 2002:a05:600c:1819:b0:3e0:10d:f1c with SMTP id n25-20020a05600c181900b003e0010d0f1cmr4459563wmp.37.1676544450857;
        Thu, 16 Feb 2023 02:47:30 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c290b00b003e215973a96sm977173wmd.16.2023.02.16.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:47:30 -0800 (PST)
Date: Thu, 16 Feb 2023 10:47:29 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, darren@os.amperecomputing.com,
	scott@os.amperecomputing.com, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y+4JwV843tZWGxih@myrica>
References: <Y+ksmNWJdWNkGAU9@unreal>
 <20230215205726.GA3213227@bhelgaas>
 <Y+3al/a3HPrvfNgh@unreal>
 <Y+3fa/3HC1vsLRXa@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3fa/3HC1vsLRXa@unreal>

On Thu, Feb 16, 2023 at 09:46:51AM +0200, Leon Romanovsky wrote:
> On Thu, Feb 16, 2023 at 09:26:15AM +0200, Leon Romanovsky wrote:
> > On Wed, Feb 15, 2023 at 02:57:26PM -0600, Bjorn Helgaas wrote:
> > > [+cc Will, Robin, Joerg for arm-smmu-v3 page size question]
> > > 
> > > On Sun, Feb 12, 2023 at 08:14:48PM +0200, Leon Romanovsky wrote:
> > > > On Wed, Feb 08, 2023 at 10:43:21AM -0800, Ganapatrao Kulkarni wrote:
> > > > > As per PCIe specification(section 10.5), If a VF implements an
> > > > > ATS capability, its associated PF must implement an ATS capability.
> > > > > The ATS Capabilities in VFs and their associated PFs are permitted to
> > > > > be enabled independently.
> > > > > Also, it states that the Smallest Translation Unit (STU) for VFs must be
> > > > > hardwired to Zero and the associated PF's value applies to VFs STU.
> > > > > 
> > > > > The current code allows to enable ATS on VFs only if it is already
> > > > > enabled on associated PF, which is not necessary as per the specification.
> > > > > 
> > > > > It is only required to have valid STU programmed on PF to enable
> > > > > ATS on VFs. Adding code to write the first VFs STU to a PF's STU
> > > > > when PFs ATS is not enabled.
> > > >
> > > > Can you please add here quotes from the spec and its version? I don't see
> > > > anything like this in my version of PCIe specification.

In PCIe r6.0, 10.5.1 ATS Extended Capability:

"The ATS Capabilities in VFs and their associated PFs are permitted to be
enabled independently."

> For VFs, this field must be hardwired to Zero. The associated PF's value applies.
> Default value is 0 0000b"

And this sentence indicates that the PF's STU should be configured
appropriately in order to use ATS in the VF.

So a driver is permitted to enable the VF ATS capability without enabling
the PF ATS cap, though the STU value of the PF cap still applies. But the
first sentence is weak ("permitted" instead of "required"), so as Joerg
said, some device implementations may still require to enable the PF cap
in order to enable the VF cap.

Maybe we could have a list of vendor:device IDs which allow enabling the
VF cap independently?

Thanks,
Jean
