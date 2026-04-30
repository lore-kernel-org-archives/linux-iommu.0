Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD813A6B6B
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583770; cv=none; b=RVqhCODZ0gWcMfKiPxW9CWxoGCOV/Mzgk2ORlLGhsRkycNxqj31CLoZicoMq5j9sQ/KF5R67WCCTaSaiZc0glwd1BoeAkwIcjQf2G+ZJhGtMkSDK9AQp+jceWCUSNie82vfFJtlFU8QBD5/JRyf8n5TAVz9S7DKOCVVjgAjkOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583770; c=relaxed/simple;
	bh=p74IfHhIob98pzABSKbeddeDIJ3TxaKYlP05kGBMvAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5z0ltQJ50DEdFC5UPbpBNxNVuaNbK7fFFDlVBWQZDtzAUS4ppXhcI3s7QgB8rCiecs92jjclsaHoO5EtBJDg4hFbg5yBm4iTKF0sJFu6vT5+fNxLmakU7yumol7x75FraXyFm4GIMPgPT9g9CSqUDnulxG9iGsvGxINMdv9t9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEnw60aa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEnw60aa"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b4650d5f5cso5679385ad.0
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777583768; x=1778188568; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKjNRn2md89MeJaRqxCLA5wY9NhKNsbLMVT1tb1aOVs=;
        b=GEnw60aaZ+XgVv7J1tCbGUNVRb0zEU3d5IQjq5Q3qAyEeCVs/59Q3TMgedbtg8SxaC
         zl8N7O+FxTW8Ge+R5LLyhxLr+DpDy/Jd4KDTrfZgKJCnQ8/5wJmJ++kc3gPnwoDyETIY
         GYggq+bNG3NRdBoh9oyACZgbHyHWb8xsoGWkkqMuxO4o6tnN6Yr+WSb0tS0qxkOX4ujd
         q7JPU0u72TUsrZxyACK7teyCutyjEWKDPGQPxmDaj3Qzmcger0Mk7w+qUI9ETB1FkE7L
         X4G9HFKUAIGLQyvGYT9D1wflAGfYRCDNTE3CwakXtz45W4GHmM91XjeTW/sBc63VnZLi
         vpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583768; x=1778188568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKjNRn2md89MeJaRqxCLA5wY9NhKNsbLMVT1tb1aOVs=;
        b=dXue36MbTa6y/ZW0ysJFTsVqSD7uoF0pKZ8TXS/thLLTuhfUwVhttVobj53KufXaeS
         WyNEpH4HByffw20ncj6Zu3gzl/naiLGNTCOUMe7kt++01FyoL0dKstc7YB36/33/1FNh
         5YSeXgwI+J+Of851vM4cVtPpTiWBxIrZcNhE83KADemk4i5T68M7fqP/De+p9IZ12kNr
         Sln71pSeacUUfVacV4Ncj039T9GmKnOQn3IzfwkIDztVU0rYChU5lEakv3nq1Z4WtkTU
         pKq9se9KgqshnXd01MnAVJp2akP2MirWb+k8dz7pdEB2bP3/bJd3UzklsdtNIwxEITTH
         xAQg==
X-Gm-Message-State: AOJu0Yz+XauICVKxxz9f5iKjIiNDoecrn8fQSZP70HoLG8FfaQXmz/bh
	k7s9eIqM8KApffEwzvtbwlCEz7HGr99ORt6aT8dWcKXYXw+6S2RakyZSi1yYo0GpkA==
X-Gm-Gg: AeBDieutUNx0F9aN/D0WqUwbCkqPlEIXwttbByucvOAiO18Uj0aYACUq6lahP4hjCPk
	e27QBFA2r9kwp9KU+KIhatZ6tn6+oG5du3cr/n3cNoF6xPDH/HGET/vMeEjC6J67v1T4m7eqlIW
	J3HcjeL2ebr21vQadvTCB5zLetPGIxa+gmWwvbABQ1xNUKwoBqnPslnj7q/qAiXDzOCBdWugxsK
	M/tnAiOHQC+/H95MK2Cj8IPUBTOcbMitMwDCKl/nAjBpqB4kbIbxefn9Dj92RTpJkKsImLJL/Pn
	NALXNTmsULuGCc/gUWz0Du3Ws9jfIBy5rJOFZ8/odsj+lWQHYfUdYXxR+SzwL8TcyvPMeEuVzCq
	/T/IgC8cDaQ7cDKkSlWpSvd1/n8U7FokQHuRlJ9rZIUxO+x5DN1gCg9vGIVDGTqOpBMXctBIskm
	ndM/8U6otBNmMXttAj5qEI6mHCzAOM+kW7Da6+15c4i3/9Ic/ub0BfUvlvqvJiUDMVlOj/By1IY
	LTj0g==
X-Received: by 2002:a17:903:22c8:b0:2b9:9086:da9c with SMTP id d9443c01a7336-2b9a234e736mr49645755ad.17.1777583767972;
        Thu, 30 Apr 2026 14:16:07 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae67196sm5018815ad.79.2026.04.30.14.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:16:07 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:16:03 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afPGkxjCdPCL8MLG@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
 <afDvVhkp8tQpsVlt@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afDvVhkp8tQpsVlt@google.com>

On 2026-04-28 05:35 PM, Samiullah Khawaja wrote:
> On Tue, Apr 28, 2026 at 05:24:53PM +0000, Samiullah Khawaja wrote:
> > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > Add APIs to allow drivers to notify the PCI core of which devices are
> > > being preserved across a Live Update for the next kernel, i.e.
> > > "outgoing" devices.
> > > 
> > > Drivers must notify the PCI core when devices are preserved so that the
> > > PCI core can update its FLB data (struct pci_ser) and track the list of
> > > outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> > > device must be preserved across Live Update. pci_liveupdate_unpreserve()
> > > reverses this (cancels the preservation of the device).
> > > 
> > > This tracking ensures the PCI core is fully aware of which devices may
> > > need special handling during shutdown and kexec, and so that it can be
> > > handed off to the next kernel.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > > drivers/pci/liveupdate.c    | 101 ++++++++++++++++++++++++++++++++++++
> > > include/linux/kho/abi/pci.h |   7 +--
> > > include/linux/pci.h         |  26 ++++++++++
> > > 3 files changed, 131 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > > index 5c0e92588c00..5b4c8d9e462c 100644
> > > --- a/include/linux/kho/abi/pci.h
> > > +++ b/include/linux/kho/abi/pci.h
> > > @@ -23,19 +23,20 @@
> > > * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
> > > */
> > > 
> > > -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> > > +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
> > > 
> > > /**
> > > * struct pci_dev_ser - Serialized state about a single PCI device.
> > > *
> > > * @domain: The device's PCI domain number (segment).
> > > * @bdf: The device's PCI bus, device, and function number.
> > > - * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > > + * @refcount: Reference count used by the PCI core to keep track of whether it
> > > + *            is done using a device's struct pci_dev_ser.
> 
> nit: I was wondering why is this named refcount and why it is needed. It
> seems you are using it to track the preservation dependency between
> parent devices and leaf. Maybe add a comment to clarify that.

Ack, I will clarify that more in the kerneldoc in v5, thanks.
