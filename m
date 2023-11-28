Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705DA5E0C7
	for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTV3PNmZ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67a38b1437dso16027936d6.3
        for <iommu@lists.linux.dev>; Tue, 28 Nov 2023 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701189315; x=1701794115; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNmZZAJm2YxwR7DMqdumV8vSovbtuf3uRewFcn2TeXM=;
        b=JTV3PNmZH2zzegGPobfdPhj3dCdfTdCqNRsOaWFopgGKhjSgNyeRAW2oUfq1e1faMc
         NbWkvOdM2aB0cnDvU0e3zZQTygZgZ+PwS55eEZ5thwdFWyJuaAT7NT0uifQIlvO9Emmo
         GMXD+B1WB2Ljar812EY2RdBHpIoLB+39m7eAUk3UpXC8KGxLSVj9LMt7SbLkhPoIoyBl
         n8FWrk++BSY4KYMA71UydMdmchdpD8Nj5OBPUApAthuvqKZBBYiwRZEA4jRoU+RQuthE
         SJNmrCzq5vX6Xtr+UW+OQZS2gpAIq1h2SXVJH5pKlxQCoMsQ/33ay3tMm0yejJnMFf9Z
         RYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189315; x=1701794115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNmZZAJm2YxwR7DMqdumV8vSovbtuf3uRewFcn2TeXM=;
        b=fzzNIwO3gwFvRcC1nlKPojILII5bkPuV6JtPM67nibw72F90PBLbiIejLq2lgQRJDn
         Y5t0KpMPHV6+mKMxszyhC0loAmbO0f0fnFsT6ZA9pE+Nwa5/0QXJrrEg7RLA3bFIScwd
         lGISLqXdKgNLu2Bg1Wmq1QV50AZxSkzgoXW0DC8alqoApIiJfLqJ8puZKSkunnO+hblt
         WiymCNW8x0JXDCklVreb/M0oSTlWUOrXc+me9Jzx0VnoGR7qrBapZysncvUjiVk/N1i6
         p6ss/+AXMm4NmKdQHJBA8x6qJ1M3ZgEZgVZ1nBac0WveTgTpyvlCYjnMjHkralEXFqXn
         yZuQ==
X-Gm-Message-State: AOJu0Yz0UA5bNbnhQKajzRRzPFLe1UfT5T+dhSpPeTd7JUEEbGbfI1p7
	dzLxK3t/iWj4suELZ5PYIokCYi3NUU85uqOCp0I=
X-Google-Smtp-Source: AGHT+IF4u8tnCbc5ns4vATp/l2oSaX8XAhbxKbRsjtsRxvdX88kLcQYNs4C5F3VMiy5REfQ93WvV4m2Dl7gAHWdwtFE=
X-Received: by 2002:ad4:5ca2:0:b0:67a:2ae3:a973 with SMTP id
 q2-20020ad45ca2000000b0067a2ae3a973mr13976373qvh.4.1701189315061; Tue, 28 Nov
 2023 08:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
 <20231127160759.GA1668@lst.de> <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de> <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
 <a91938e3-a7cb-4f74-aeaa-7cb56c0b43a4@arm.com>
In-Reply-To: <a91938e3-a7cb-4f74-aeaa-7cb56c0b43a4@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 28 Nov 2023 18:34:39 +0200
Message-ID: <CAHp75VeQoOFQ7V7gbVfR3-ANNMRT=-UniOCbnUtszo-1F3NMDA@mail.gmail.com>
Subject: Re: Bug in add_dma_entry()'s debugging code
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Christoph Hellwig <hch@lst.de>, 
	Hamza Mahfooz <someguy@effective-light.com>, Dan Williams <dan.j.williams@intel.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew <travneff@gmail.com>, 
	Ferry Toth <ferry.toth@elsinga.info>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	iommu@lists.linux.dev, Kernel development list <linux-kernel@vger.kernel.org>, 
	USB mailing list <linux-usb@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 6:31=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
> On 28/11/2023 3:18 pm, Alan Stern wrote:
> > On Tue, Nov 28, 2023 at 02:37:02PM +0100, Christoph Hellwig wrote:

...

> >> The logical confcusion from that would be that IFF dma-debug is enable=
d on
> >> any platform we need to set ARCH_DMA_MINALIGN to the cache line size.
> >
> > (IF, not IFF.)  And tell distributions that CONFIG_DMA_API_DEBUG is not
> > meant for production systems but rather for kernel testing, right?
>
> Yikes, I'd hope that distros are heeding the warning that the Kconfig
> calls out already. It's perhaps somewhat understated, as I'd describe
> the performance impact to large modern systems with high-bandwidth I/O
> as somewhere between "severe" and "crippling".

Independently on the distros configurations the (false positive)
message(s) will make difficult to debug the actual things, shouldn't
we have our code robust in any case?

--=20
With Best Regards,
Andy Shevchenko
