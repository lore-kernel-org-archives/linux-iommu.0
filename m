Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27840285C9F
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080035; cv=none; b=ruRHclNYS3VDCheH8HUB/asbwgwAmzhWgHRJX9meM+M/IJTVdWrm3JaO5530uig7wC+rjYNMohuoEMvRQX0+8RIXCjJBPmrYxq8EC/wk4l+zOStcPGK8mMwKaR4DPJ7+MxuWl1D8mdNJzntx1NsuJ596e7ackBB7ATkK/gP6OM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080035; c=relaxed/simple;
	bh=KsZELZeWpT03UnkqhlfBW9r1APWyBQkH9RXynD91+cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnACLZ1UR8/+0vQf7R1NJE1cfFXd2TqJaX2HEB0T4oWZDjINqVz08eZPBCY3f1EhEmBmR1US8FiJs33ujVNtj3A8JQ2M7sGUbAvQo2zQsRtivjfklv54Ba+COhoIGlCScqfCpdKluFKoXR7/54xTCveo1elwCf93Dg2C4J293XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XCsTH8Vb; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XCsTH8Vb"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fae04a3795so47947706d6.3
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750080033; x=1750684833; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsZELZeWpT03UnkqhlfBW9r1APWyBQkH9RXynD91+cs=;
        b=XCsTH8Vbats0KJVFUSQc0pik/RaLoOYVb09XtWQosb+p98oE6cVJ8tsL2g7n/rwHQx
         4BxZcOOl2sRcRFHDjo1PEV9XyLf/5NdMjPn4uzDx81RUGVaX0TO3opPuzyjQNgLa2jjw
         FZ7hkYXc2i/DlTS/oUxi9PQTI7yWeCrDCYdFM3wHmOtsLJdGMnd/kS8s93PwJJhpU67H
         WKNvQYqsBfbS7QTK5hZ+7I+IMCDumuvGgxOAldzATxegdSSaWefELIpQ/4bGhClxaWLe
         hBdZF4Cen+glypTZ+MjNtfdL8mUoEcg4XI3bn7SYYX61EzVH5tdBsa9DBp9sVIWljvyE
         Yvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080033; x=1750684833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsZELZeWpT03UnkqhlfBW9r1APWyBQkH9RXynD91+cs=;
        b=o96h0yn1ZrAsTF5VDl2F+UVIO8iRaj/Is1RWK3ZiT5diQ2t4QPz4zJJCLFBhOtF5BZ
         yn5BSgyoXbaF0eY0ualU6KFWpCfWxfhmc8O5WEEhroOgPH4WGurnZNFrhNvYTDltT8cB
         hriY6tDBmXiGYTG0x+qTz6L19Sciuo8kRKUatP8WKee9bStM7+nBFPTemDwt1vatPcQm
         KinxGaFQV0nuuSrglW3R5m55uKeqzcAM/AmvZ3IZQN83TOkmNBf6S3SA4RxkA1MYDRWM
         yYjRQq3EjYfLrILDD8DZ59v+a23LGbDwop2C6tPZ3F8aE0wz5Agd62ne7S5WJ2M/nnMm
         2TyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmMkwM8fc2VUneQ6RmWJd+Mwl7fVjbn1j9du5yBOAa5pMpcMnkUUj5Ru4CyU6Aw7Juc5qJtA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/o60gqrP8deLtscH2d0f0KUNpvu1xJJmxluRwtigdOXgbhQZ2
	lfyD503TFRSgHqUOWoD2BxpMv13dtYSqrQ+DpK/VYzWnLcmSkDbZiB2RWIO7WcWrdX4=
X-Gm-Gg: ASbGncsht7Rj/rKFHMpfqXgU5TCB5Q6V/Ae4+Onm1bQBSWbdI6hsHvwziXEIXxBzQvc
	/Ma8gVHIL5JMhoQWTf1yT19Q97DA8Flv7YGvUTeZE4UFCIy6y2Bni52167KI9aNHNoQeqRwSPD7
	F5lhzVGTLLSAZkopJMEFYUFXuBerbFJnhoMCGM4oeN75ouu+JR5h1zxRD+DjcA6l/NqYu7BMslO
	OGGXKXfkKVIDyaPEt6Vv6S3TAmm813YR94PLi8EVqlUIZAAQqrOi/ASSkvsfDZObCqo5xTf5ZIt
	V9nObPAnY/0OT6SRJSDYoMHm4fUdRWcJHMwTbvCHoeyqT4giAGXXTBnO/NQ5RpvegARlzZ/tg39
	CYotqKaZCSOZ/W7wvK/9saukeoe667F32qfO79w==
X-Google-Smtp-Source: AGHT+IE1qGI9XHVDxJuyvFi/df2zVObBdJYoDm6YGOjnmbu+H4OWYnM+uHkjohkUfAcq9uWzh1e/Fw==
X-Received: by 2002:ad4:5c6b:0:b0:6fa:c99a:b5e1 with SMTP id 6a1803df08f44-6fb47725fb8mr166833186d6.17.1750080032894;
        Mon, 16 Jun 2025 06:20:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c84148sm50822446d6.109.2025.06.16.06.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:20:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uR9lH-00000005gVt-3sIA;
	Mon, 16 Jun 2025 10:20:31 -0300
Date: Mon, 16 Jun 2025 10:20:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alyssa Ross <hi@alyssa.is>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, x86@kernel.org,
	Spectrum OS Development <devel@spectrum-os.org>
Subject: Re: Virtio-IOMMU interrupt remapping design
Message-ID: <20250616132031.GB1354058@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>

On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:

> Is a paravirtualized IOMMU with interrupt remapping something that makes
> sense?

IMHO linking interrupt remapping to the iommu is a poor design,
interrupt routing belongs in the irq subsystem, not in the iommu.

The fact AMD and Intel both coupled their interrupt routing to their
iommu hardware is just a weird design decision. ARM didn't do this,
for instance.

So I would not try to do this at all, you should have a
para-virtualized IRQ interface, not an extension to virtio-iommu
adding interrupt handling. :\

AFAIK hyperv shows how to build something like this.

Jason
