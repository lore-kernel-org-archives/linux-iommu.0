Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88127706
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 21:06:27 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id z18so1831515pgj.13
        for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679691987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3jMFsLqE2caCT6wyf0tOHuQrRREBiql26buc6N3dwU=;
        b=NaOd/bOhXevXn7BU0AUSWcGzTiaQEgTZiLBckE8aRILv8H0EEgFK88JTMY9uSsryCz
         YwhV3WKJhRFOek1S17jHA+xGLCLf9Fjd8c8Zs1VZtHhMzG0fONO1LtFEkk6OP/NAhtUU
         s6c9D329VX15XjdmvPqDK/MdQciz2KiLP/ys/YFbYl1uy6y9wkZLSdq7dgzEibGFTVLW
         zzc9Yj52EFXno+ZaB30Qw2+2/devPSSf05rQR42LhFX1yB5EN3L0ABuGevGsIanj2FD7
         hqKhjyndjFQ+0xO+5TT/i4xJ3e0LMNR8vWOIbxQmlA+D3M78smUdfaRw0FemVN7G8wgt
         jR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3jMFsLqE2caCT6wyf0tOHuQrRREBiql26buc6N3dwU=;
        b=VVhlzs2kKOKAqPhdZ+sLV7qhZd769RtScK0jacMV6iukimqwTqaFbYH+Jza+YTdV90
         N5EHo86KFs3TWgY2HI5tlN4ux5ubXNtksh1XDxJ9OdQTQilm3sZRTdTuZ/Y7Ou2of5Pd
         KD1H1xEppvFlsw4YqM1i2GVCWKE4QWsALhyqEIf+Qjr+JM31VC0WjL9CMDXhwKePDNTy
         Fl1wSJsgeLKdcBWcCI1EtnLGc3uB9m/OsHMK7PDj0pOWuOCdsdNgc/1qL89ZyEod5rlD
         IHUfCYL8XzLEFYEkD54vkpqeVDWLUMSbFLwFd/nK9d10C93HvfbM1hkYR0ZTTlk72tDJ
         Kd9Q==
X-Gm-Message-State: AAQBX9dJZ91s6VBZBuyiR8fLCxv+43/gk3MnBUU91bupY1MMHComWJVi
	MqUEZLO2i5kEavZLJcX76PC5yw==
X-Google-Smtp-Source: AKy350a6Q05PHHwil+uUiCQcOPxMiVdbh3fzjkp59m9vWFn4bqqjx/c81Ya9jcJ0FKSHJxi/R49bOQ==
X-Received: by 2002:a62:1dd6:0:b0:625:efa4:4c01 with SMTP id d205-20020a621dd6000000b00625efa44c01mr4631218pfd.3.1679691986997;
        Fri, 24 Mar 2023 14:06:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79208000000b0062a3fb2a75csm4769735pfo.65.2023.03.24.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 14:06:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pfocC-002SD2-PC;
	Fri, 24 Mar 2023 18:06:24 -0300
Date: Fri, 24 Mar 2023 18:06:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2] iommu/exynos: Fix set_platform_dma_ops() callback
Message-ID: <ZB4Q0BFzNfz5du04@ziepe.ca>
References: <CGME20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32@eucas1p2.samsung.com>
 <20230315232514.1046589-1-m.szyprowski@samsung.com>
 <ZBnCD7Xc9WCM55ub@ziepe.ca>
 <da174ce4-b922-21d0-62da-b69798a51371@samsung.com>
 <ZBnef7g7GCxogPNz@ziepe.ca>
 <3ca0c680-d651-a2af-978e-fcb4a2057dd0@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca0c680-d651-a2af-978e-fcb4a2057dd0@samsung.com>

On Fri, Mar 24, 2023 at 09:59:27PM +0100, Marek Szyprowski wrote:
> Hi Jason,
> 
> On 21.03.2023 17:42, Jason Gunthorpe wrote:
> > On Tue, Mar 21, 2023 at 04:43:42PM +0100, Marek Szyprowski wrote:
> >> On 21.03.2023 15:41, Jason Gunthorpe wrote:
> >>> On Thu, Mar 16, 2023 at 12:25:14AM +0100, Marek Szyprowski wrote:
> >>>> There are some subtle differences between release_device() and
> >>>> set_platform_dma_ops() callbacks, so separate those two callbacks. Device
> >>>> links should be removed only in release_device(), because they were
> >>>> created in probe_device() on purpose and they are needed for proper
> >>>> Exynos IOMMU driver operation. While fixing this, remove the conditional
> >>>> code as it is not really needed.
> >>>>
> >>>> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> >>>> Fixes: 189d496b48b1 ("iommu/exynos: Add missing set_platform_dma_ops callback")
> >>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>> ---
> >>>> v2:
> >>>> - keep set_platform_dma_ops only on ARM 32bit
> >>>>
> >>>> Some more background why set_platform_dma_ops is needed on ARM 32bit is
> >>>> available here:
> >>>> https://lore.kernel.org/all/9a12fcac-c347-5d81-acef-1124c50d0c37@arm.com/
> >>>> ---
> >>>>    drivers/iommu/exynos-iommu.c | 17 ++++++++++-------
> >>>>    1 file changed, 10 insertions(+), 7 deletions(-)
> >>> It seems OK, but do you know what state the device is left in after
> >>> exynos_iommu_detach_device ? Ie is it blocking or identity?
> >> identity
> > Can you do this cleanup like this instead?
> 
> Frankly speaking I would like to have a minimal fix (like my $subject 
> patch) applied to v6.3-rcX ASAP and then apply this identity domain 
> support on top of than for -next (6.4). I've checked and your proposed 
> patch works fine in my case, so You can send it as formal patch.

I thought this was a cosmetic fix, do you have an actual bug here? If
so we should split it as you say, but you should describe the actual
bug in the commit message.

Jason
