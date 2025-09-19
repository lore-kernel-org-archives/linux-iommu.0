Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BB306B3D
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283014; cv=none; b=kRWnEYued2OGFZdKGaHRhEmLewJ/Lj+GtPUxOMSeaa1CTyfxjx9cw4bMnj7XW79ct1MdgpOK1usVaYUcKn8CpQTMSJq3MgYpPz3hZxm+0arAtlgg93t79ADvi7XS/BrFVtUFX7BGrvTBibcXb2VakOJMuHt3/utawXnSZyLMdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283014; c=relaxed/simple;
	bh=nVhwZwqjhePDpn3hIqHifRon6Z2bn7ZMu+Qm0ssc/jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhrsjWPRWnioH3tojGq0fo3MbTsbcEVNTM9ioBxZtpzgohaVo6Dks3t8F9JPQMND6E+KN1h+MhyRMh3iSlIbD3uO40FIac8UPTxHmnGwrGWzWw98SaWXvARFpRTlYz0tH24RnVrpiyHG/QMx8VupAVX9C+7Lz8YGJvdq6tu2+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o9XXAVIp; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o9XXAVIp"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-79599d65f75so13624396d6.2
        for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758283012; x=1758887812; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VuUmQ3adky/B0QCA1sMQ2Ao6Tuz3Fbnr+xuaWjpQ1Bo=;
        b=o9XXAVIppSSnci6PN2JIJiok7fKf0fedCUu/xsvMsW/MyHBDjl5WGbl18cKLi5BCKZ
         Y6aBKiwTHomutnyNHga3epqj0gV8c3dZF3Nnsvbb1SxurE6x+emwSfDSXYqIhNAK28M5
         qJImKCqdIo6oGzt7cZxXlzKAip8BRb58X4KC7Vjo/NDEK1QnyGR5Iq/Y6MAn447w5Ouk
         eDQ7w4iNRqA9WySHywbjLBj3uco7U885qJ5lFsuguqg1xezcd1G6pci9RbsxSTHWzfUx
         F/yP7cIbBmB4p43h8rXj/Z4+fz4gMsTdHq9P43KhhkULBsfyStfzNiRmgLKMgbN4mc/x
         ckpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758283012; x=1758887812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuUmQ3adky/B0QCA1sMQ2Ao6Tuz3Fbnr+xuaWjpQ1Bo=;
        b=aBSGQ24sLRgg7JX0FHkYC4pKq7UCKOlWtdLDrYpBle5FADo/p/kvEad7A48xP2/zeX
         mkT0VnBlthwut7mtPmfCzMHYF7pAkV+RNTLLNjq2CWwDuzyKe+CYOvHLZ558/nnWnZv6
         Vxkqe2W9eV/qQFrYRbbCwE6I+U3Ellfi8TxX3GaCl1dBf1o5lFzobTY9DYLksXPWrPfG
         NYRdBm63KCb2vvtN1wbkH6485WHjlN05G2fLVEPG2DpiIjglDnAEFctUa4c1XEsyoIzL
         5R174feQs/soaCkg90VJ13jxNMjUBIVEPE/LWZFcImxs/cM35pg4sFmwwRuOuRekuGvV
         yprA==
X-Forwarded-Encrypted: i=1; AJvYcCVku7O28g84cEKYNmgoLCE7CVU/1F96+J7YThDG+QsuKCt0T9MzlpthoJFXEoPMxgdIldvKng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr5FqOgYGXZpEp2UukD2Niu2H8WM34MHU9z+pO7H48Fdet2Jex
	k9nM9K5n4zsakTcxUk8bu8a5jJSSbHu/uaGILP82R0FyBX9EVoQJ7EWacN5g3lfYqbQ=
X-Gm-Gg: ASbGnct5jnElHJ9uRlfVyjEKReueGfpJPEa2fjCx/h4nX5StnXQwI4YsPq8V2ggscF3
	AGMuMWLEZbjpoPQ6oohS2RkpWT3uDpbxVwGMfVJZ5LpvYF3YF6hK6HDeqWwsmijbnTKSLLhiUc3
	Z8W6WbYbme/Wwv0bZpPYa2kX9YWb5wrFHpeim2bK5yoXbfe3x+i/I6qcbsEIShXCz/4rJmlvBhe
	UAunVgZBhHtt8F1XyTLHLZvP5MHFoWbWoIblKufIWoeUl+3LYEwv2K8+Uu9QltrCrxtDAtuCXNN
	xFddsW5E4YIGi73cMUxdtawXGHZr+eRiZ//mdVlFuyj8BK+vGWsawsLc7avtRPeOTZ07qVCC
X-Google-Smtp-Source: AGHT+IEoljyrBkccAFYLb8MBbUlKdAn3Qg4zbFh0M7v+yWUepkG0OFhXgg8yQQRY7r/ed8cRG3kFFg==
X-Received: by 2002:a05:6214:dac:b0:719:50da:4a08 with SMTP id 6a1803df08f44-7991cbb2d82mr33802106d6.45.1758283011689;
        Fri, 19 Sep 2025 04:56:51 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793516d729csm28635246d6.43.2025.09.19.04.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:56:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzZjO-000000097bU-19eX;
	Fri, 19 Sep 2025 08:56:50 -0300
Date: Fri, 19 Sep 2025 08:56:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	Li Zhe <lizhe.67@bytedance.com>, Mahmoud Adam <mngyadam@amazon.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <20250919115650.GT1326709@ziepe.ca>
References: <20250918214425.2677057-1-amastro@fb.com>
 <20250918225739.GS1326709@ziepe.ca>
 <aMyUxqSEBHeHAPIn@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMyUxqSEBHeHAPIn@kbusch-mbp>

On Thu, Sep 18, 2025 at 05:24:54PM -0600, Keith Busch wrote:
> I read this as more about having the granularity to automatically
> release resources associated with a client process when it dies (as
> mentioned below) rather than relying on the bootstrapping process to
> manage it all. Not really about hostile ioctls, but that an ungraceful
> ending of some client workload doesn't even send them.

You could achieve this between co-operating processes by monitoring
the child with a pidfd, or handing it a pipe and watching for the pipe
to close..

> > > - It would be nice if mappings created with the restricted IOMMU fd were
> > >   automatically freed when the underlying kernel object was freed (if the client
> > >   process were to exit ungracefully without explicitly performing unmap cleanup
> > >   after itself).
> > 
> > Maybe the BPF could trigger an eventfd or something when the FD closes?
> 
> I wouldn't have considered a BPF dependency for this. I'll need to think
> about that one for a moment.

Well, if you are going to be using BPF for policy then may as well use
it for all policy. It would not be hard to also invoke the BPF duing
the file descriptor close and presumably it can somehow to signal the
vendor process in some easy BPF way?

Jason
