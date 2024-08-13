Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B319B3E3
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566658; cv=none; b=EHuHRc8KWF+NyqFan7kMtay1ot53v++dzsuyCA1j+piv+F7tnk0v4UyWW1yzXm+iLDZQhLMUM0N/0ev7cg4jgZoWOMELfGGurx2Xvt/cKcE57nUJ1U5k9/4dlNvFqaXDMy2z0ew05l0ecHy1KsOwxNQCyX0bm2LxCXsW4GsY0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566658; c=relaxed/simple;
	bh=jyBfJvAdoA8JEsDnsbRpPAxmQXgY/t1XQm7toOCkJFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVO05778CE7tvOu//W7OMZdWajorgdWfT3OrZgP7Y64F2kJcva9rwWs+O/igZ57QQcepzZy/J28QO3WydkehCMwCIk9P01etAFafhFCDbo06j0NE2gLwvddwJLcxiliJQUJBH4hdfnBvO3ZINWSo8jSZeqDViSanUiVHPXVFpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nNGQoFja; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nNGQoFja"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so31332406d6.2
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723566655; x=1724171455; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMSdQnQ3FhCUpwpbbmmBUO0/ktrEqcKJdvt6utUH29g=;
        b=nNGQoFjaqd1VFs65X/+Hxl1EQ+c0/UOu2JSFtb8x7ddCuWl94wiz+CCPnw/qmEAJzG
         2m7ztKuPi/vYqJjC080wcOz0f2FznyUH4GSK5OH2MxyOoa4pE+x9C8NXLhKGAUR9nKZp
         DYA0QxNJJ+FB5pmhG4nH5afW/mgcfVV9I9EghkutHhUwbS8ND/w839bHSYbic63rPa92
         NMA6coBkEW8dQSq7Q1LGqQS/FkIijeCxfKMEdritdH+IPSNWJ+xqSMfGeYwBMN0+rLAt
         601lcio1gpjPNJ9rnPphb4XPK/+Gup/qJB0lfGv+a+W5ZhbzstqawWyJXfj6t/HDu4dS
         pEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566655; x=1724171455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMSdQnQ3FhCUpwpbbmmBUO0/ktrEqcKJdvt6utUH29g=;
        b=Gh1hO8OiJGConehM4qSQtWqTRhgDvdTNt2T+0MQxtb4z1aHnMEpPzIandbUmtIPWuG
         SVGnhz5UDwPt08ArmrRyP1dr1VCL8YX7TwzckU4lIFw/FZiI1R5Acu4dCNHyXs35W2ab
         tP9ku7vlqAE9fGrYsOw/+UuRt0Stcqs2V1WOtOkwh0mN9hFfJ/6fM864voIxKJrSp7W8
         2esaV4T6l9xdQ7dmIdGEZ+lgsipFmDU5dVMhnrNZxTH0oi1HG72rQqu877WjbVy/46tt
         ayzhVxip9Qcgy/I6ttf01WKM5Qxs/rIb4Et+YfdTHPINB+53FX/v8ldgaEtPf1ql02Jy
         kQOw==
X-Forwarded-Encrypted: i=1; AJvYcCXSR4Gg6QI/isPynZ2CWb6bGRF+mbnyqHMX9c+GoLJcm3gVatmryiEMEJK3qhIC4VfbrHc6BBc3uhOQGZSNM07VQTWCz54=
X-Gm-Message-State: AOJu0YwGw0tXAPwTPRm1GVICta+sBYB8eUshVXzYxwgIFLB0ZzT8l5eF
	oWefB6mtS2m95590q+dxkYaV5sOFD8Srmgq0cptXiGBSFGnE8/HSZ4tXCOpHFBk=
X-Google-Smtp-Source: AGHT+IEUMd+MI71+yLFL74PJx8nGR3hiS2e4En+zj4fQF+nZvpu8tgHoyU3czsWLPNshCo8zsk0ICA==
X-Received: by 2002:a05:6214:4601:b0:6b5:dfd8:ece2 with SMTP id 6a1803df08f44-6bf5d1e2142mr320686d6.30.1723566655248;
        Tue, 13 Aug 2024 09:30:55 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c80132sm35284326d6.42.2024.08.13.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:30:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sduQ9-008QZt-Jo;
	Tue, 13 Aug 2024 13:30:53 -0300
Date: Tue, 13 Aug 2024 13:30:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org, quic_bqiang@quicinc.com, kvalo@kernel.org,
	prestwoj@gmail.com, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, dwmw2@infradead.org,
	iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240813163053.GK1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812170014.1583783-1-alex.williamson@redhat.com>

On Mon, Aug 12, 2024 at 10:59:12AM -0600, Alex Williamson wrote:
> vfio-pci has always virtualized the MSI address and data registers as
> MSI programming is performed through the SET_IRQS ioctl.  Often this
> virtualization is not used, and in specific cases can be unhelpful.
> 
> One such case where the virtualization is a hinderance is when the
> device contains an onboard interrupt controller programmed by the guest
> driver.  Userspace VMMs have a chance to quirk this programming,
> injecting the host physical MSI information, but only if the userspace
> driver can get access to the host physical address and data registers.
> 
> This introduces a device feature which allows the userspace driver to
> disable virtualization of the MSI capability address and data registers
> in order to provide read-only access the the physical values.

Personally, I very much dislike this. Encouraging such hacky driver
use of the interrupt subsystem is not a good direction. Enabling this
in VMs will further complicate fixing the IRQ usages in these drivers
over the long run.

If the device has it's own interrupt sources then the device needs to
create an irq_chip and related and hook them up properly. Not hackily
read the MSI-X registers and write them someplace else.

Thomas Gleixner has done alot of great work recently to clean this up.

So if you imagine the driver is fixed, then this is not necessary.

Howver, it will still not work in a VM. Making IMS and non-MSI
interrupt controlers work within VMs is still something that needs to
be done.

Jason
