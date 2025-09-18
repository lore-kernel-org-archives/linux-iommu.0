Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525F24887E
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204667; cv=none; b=Hc8YW1jDB0i/3Tm+8kWwFfgU8igm1KJTbRKkcFMKOCtPLfZ41cY5tGm6be+7KKrDxKsKzd5GnGfOjxEQ1CqtB/wVOmlZjfCVRre9GUX9kW3ujV+EVVnJSTEn8Qw/FzsSs2jx4NhIodKsqQz87Xc7o1diJPajc8jtf5kcioVDVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204667; c=relaxed/simple;
	bh=x7jb8JfGQsSR4XtTJ8eBWd6uBi74hSXtB25C9NcBMXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlVMdqPJ4XyOf53bXCdwY3zQuzatMw01x8NlGFatrdhmkRAF2QBhAB+wYY1klFayQDm66FZvv46O+RaK83aEOq/vB21Zq//lv6YmTyioCuJBuwDHO+hJHooHg8BfUKDoBxY5Vr3jZgdD/Qic3Cde6VnTHkR+VhHnJcX8HMtgsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pMZOuBJ4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pMZOuBJ4"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-829243c1164so107648985a.1
        for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758204664; x=1758809464; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7jb8JfGQsSR4XtTJ8eBWd6uBi74hSXtB25C9NcBMXU=;
        b=pMZOuBJ4e/Uw/A45bWTuOUSFSL1uq0qauPvDUC89QD8+rai6klFoFlg7R13l2E82zp
         ctLmGETFcEFappfQgQF+nTYSwTSpu1G7rP2LM7dIYxTZ/Vp1WqF8H45doBzk3ZQRtjAO
         BFjYGKk7w4BhwxjhWuBxzvBBSF8WX5aC7uH2dnFkehwmmWI+lhgX9iUcG8FRE1KNB1wC
         BkXIjMn9jsBQi6bT44nt6TW6zoQvg1rKmsMDg7gX3eeUXXncLlYdOC9/nuBctqqdzXcA
         kymMwgvlLfFvlUraQBc7bq8O0AC+WYP4Xq9JK6y3YZ8oEbp2bWcCZu/+G3mpni7buBAo
         FWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204664; x=1758809464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7jb8JfGQsSR4XtTJ8eBWd6uBi74hSXtB25C9NcBMXU=;
        b=NVkL/Tcjh9Q82UX+40jBOyKUqOgiPF0LYISh0JUY0uL3vb9NfRP3lmg37fBoGkPtIV
         QGkyo3WiTYsRuNzxQdMxFN+JTz24HKq//DYJt0EXyHwKYQHULoignqu6DJJDPkijrLlB
         4YgXNYp9zaAj6H9oTEnMA4sEf4gHNq+L0wvKWNTc8qOLjmZkXHHRBW65qACXv6V5+Inl
         VVnGtDKo/4Uqq8SCgU7EG5+lrupPzIoEeY7aKNWJptJSHXhqKEppZY/lN/v/zENdml0l
         2MwnEe8QUJOh3QGjd80Lx6nUiD7jbEVM05MFVvFEA+4VDrdtiXK8BtnGpmQJzIJB3rMI
         8/HA==
X-Forwarded-Encrypted: i=1; AJvYcCUpo/3Jrw6pdXOmFzHpUYy4ujc3c2qnAt8h2rjEfNI4zqJ4RWXn+mp1zImpLegWVtiO5W5VbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZDC7rqxQmdLEgTU9YIOeQG2J4SWTOIXae4yMjsbbcSWzPzSw2
	ErPtnmHtg7Wxt8FktvQJ6RZV6vAd2fstnhoyymv6WWq/UpBohmhYferwZA0cnybdyko=
X-Gm-Gg: ASbGncsuYG4FqP+0gr1smZt6OCk66sR0PFktVLODIgCzmLo9HvgdZOkF8rcslYmh45l
	y2NZpw31nrb6f4jac4S5edh/pspJNLSygzApuMQ4D6v+KPNbMgDks0gZsV4sYNdzfRT9+/Wo1bg
	dNUfawTMLMNq86GjneVy9jv5TvPuPqlDeHdc4DwLMBxHcsaU9AR7vIzFvSXUhCEaiGySsshU0Kv
	mpCG4psVIAJxx98D0zBOI+xD5QuLtytYtB1F/Vshj13Xy5OtCglDTeF//FbVoBYDZlX7tnHjCrH
	BezM4d7IAMN3uiaHkk7b7Zge8MNFuU5XT02l+xb4v7CMWGeDwqxVuICWzjK+tsuvAKE3SHFXPAF
	4izcUupsf0hZZ1tj/BbUmewlfJ6TOo7e9oMjeQVsJc9IWnrqvVnVRO3HSgaROKOt3CiFZOPeA0G
	eR+NJ/7mfSKMY=
X-Google-Smtp-Source: AGHT+IFcG0Z3ZK5/PQ6vJav0eqkeBfwJrYJnuhkwdniJkW36no16Dw8WiAtdmBAplhwPvdJpSRD8qA==
X-Received: by 2002:a05:620a:462c:b0:812:be4:670e with SMTP id af79cd13be357-831109114e7mr656127185a.43.1758204663628;
        Thu, 18 Sep 2025 07:11:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83627d7dd01sm169419185a.27.2025.09.18.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:11:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzFLi-00000008vyr-1Vsu;
	Thu, 18 Sep 2025 11:11:02 -0300
Date: Thu, 18 Sep 2025 11:11:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: manivannan.sadhasivam@oss.qualcomm.com
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
Message-ID: <20250918141102.GO1326709@ziepe.ca>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>

On Wed, Sep 10, 2025 at 11:09:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> This issue was already found and addressed with a quirk for a different device
> from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> Source Validation erratum")'. Apparently, this issue seems to be documented in
> the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.

This is a pretty broken device! I'm not sure this fix is good enough
though.

For instance if you reset a downstream device it should loose its RID
and then the config cycles waiting for reset to complete will trigger SV
and reset will fail?

Maybe a better answer is to say these switches don't support SV and
prevent the kernel from enabling it in the first place?

Jason
