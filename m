Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4373233E3
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644504; cv=none; b=FNAyogNrMWsD/OEFAHaHulqGXMGXNoLjTNEJIzzHxN1T1SjDQNhRuq1A40TmjirLSBUpgycegVJh58I41EDh3s/Y2ACc0otAeO5iamLz44fyrGZUoutmVfPyRJD0W12MlutBAlBqcw3dvTBTpGS+VtZhaFCCtg/uO/zIT3sLaoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644504; c=relaxed/simple;
	bh=IYKsjA2lVzqlmST6yIaoy5ZiKBNubcdQiY7wDAQazvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA8VEGc46ErdYF9T/o4IT+tc3UOzBjAk4SDe/mYSVI4BsFiAZYU1/pKD/g6J1yLq3f3qFe4UGx1aNEaDOjj8t9e1VdYCoo0zpVBWV0z2FrRx5UWCO3DcavPNt/qBQ0pCmvMG3qSitaYRBVU4z5kR9boMLwQ92w6jpF7fh3bALss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Cyt9PeIm; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cyt9PeIm"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-84a91cfc7f0so4857385a.1
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758644501; x=1759249301; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAF1ZqvUCq+DYRKtNmDJLT3lAtr/qrJIjSppUMh/0OY=;
        b=Cyt9PeImrpWV9TUJhWnaCiFdca/7EOsbkT71Q4uZhT4g+QdoTpahgUDZdmABxglDmk
         j3KFuOtBBctbbAtgJBYQxsoA8PuanZgSPf09Hyb8YRz4GyLeR6IUkYTAwEIyIt5ZIvaj
         r/5jSlIQvx8dknu631qB0MIp+UMuDxmC/szFgh1mcDvkeaWevZKuSyXOoHuGkHxcDDbe
         qerYra7t8MxI6QpBWfrJM6HQdn43m6R8UFcxy/C7JVD9ilF9CUz/1mOi3GDC44xtJMt8
         0mwkHFKqBU6GnzzDiZmce+7oGOdkuSY4vVxHE5ry8La2wzJkMZ5tMEgNVu3KEFMGLkmA
         TpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644501; x=1759249301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAF1ZqvUCq+DYRKtNmDJLT3lAtr/qrJIjSppUMh/0OY=;
        b=PdqiTvBsAtqecV78yHxhkXDjLMnednRYkQ8hwHA8XfHK/9uYZniJEFegFm1RCbHZdx
         oi5f5420HdSdhkr3J4uJE/As5eR7JRMtlLEn7ntqH/Wa95BjbpbBsa1YPaE4r0Q0hRkf
         pjDrAgAbkB3qr4J0EEuUWk1K2bQBsrMtwDq7BSnjsurF4bFvibYI0j4jRvRH2fkO2FOo
         JyiVPByxdHIJPrX4+qvkm98AKibzFNtc6F4+0tQ9GR43tPDpDQtj22RrwuJtGZcqom8v
         UBhxK4Nvb7MOPXk4lVkvJX92OHWfxLKLsvzKoI9nJsctQwLdgqmZrDL7kp6B4gzNR1BH
         28zw==
X-Forwarded-Encrypted: i=1; AJvYcCVm2oO2tZIMwEH/+v/3sFPaPnhwh/hn83tmxA2RAD1ym+uGsXTVOamVkT10ZpnQpoOdotS6ZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTXPnvxXl2V1ki9hRZ7o+uUVoLQdvoufXRv5OB7BnybaYPSIXm
	DIGmb+m61ihGJTB7HPaSFTcKx4VM19TIpEJHiqHeufpCX6C3BrG1/ro8eA8LHDJqO4E=
X-Gm-Gg: ASbGncu89VTgvc8+jVKIHysVTo4XBJm7TpDOy3oznK2Yi/rh6EZO41jFAZYdhdC1nZ6
	PNgn3MXr6ZBy528WiRwkJOSvMqfk3Sl6gq8IRy+fN6+h0QVfap33MFUsZ2Nw7BfGY+1H/V/xJ/3
	ovtH8/ANe8nEm/LBjHsuNnqhLCdktfa3j+DmvEH7Dj2px4zo1vXtlWixlGopReI6XTf4dQluUwx
	iJGOSHMP5eUthtZ4veIdpnznFPl1/vavVXs081QAG3yM86ZDh0ycmJDgS3grGiejkAvRpYdbC1/
	L1orgiRWw3mxVjcPj0ZXn34sAHcb8jvKZqiuWQRwfqt/4c0p2IcdVBQ8maN/vHhGJkJgHXeh
X-Google-Smtp-Source: AGHT+IFYjLvlYVWkvRmfrd4O74XRQ2yOeConI9WiorD7CA02H/AscVNhWnASnvsfS0ugaprQj9f5qQ==
X-Received: by 2002:a05:620a:7088:b0:84f:e093:3949 with SMTP id af79cd13be357-851b8ba216bmr341372285a.36.1758644500700;
        Tue, 23 Sep 2025 09:21:40 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84cb88e6969sm318223985a.2.2025.09.23.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:21:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v15lr-0000000AxbL-2Bdg;
	Tue, 23 Sep 2025 13:21:39 -0300
Date: Tue, 23 Sep 2025 13:21:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <20250923162139.GC2547959@ziepe.ca>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
 <20250918141102.GO1326709@ziepe.ca>
 <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>

On Tue, Sep 23, 2025 at 09:07:49PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Sep 18, 2025 at 11:11:02AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 10, 2025 at 11:09:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > This issue was already found and addressed with a quirk for a different device
> > > from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> > > Source Validation erratum")'. Apparently, this issue seems to be documented in
> > > the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.
> > 
> > This is a pretty broken device! I'm not sure this fix is good enough
> > though.
> > 
> > For instance if you reset a downstream device it should loose its RID
> > and then the config cycles waiting for reset to complete will trigger SV
> > and reset will fail?
> > 
> 
> No. Resetting the Ethernet controller connected to the switch downstream port
> doesn't fail and we could see that the reset succeeds.

Reset it by up/down the PCI link?

> Maybe the bus number was still captured by the device.

Maybe, but I don't think that is spec conformat behavior.

Jason
