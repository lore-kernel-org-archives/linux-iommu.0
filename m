Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B7195FE8
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189582; cv=none; b=pltfMhemgxm51orrjYAyWqraOK4PZ0Hj0815GdqNWRvrtJIle8N/o/em2Utu+vzqPtL1HLWJggcBkqve0CJLzr2mSARnsQyiAyhxYak0jLiONy/BT2lT2GGAASPRHtuNekVg32Bqre35YJ820GLPSWaUQJkFqp9Jt4jnVO3ymrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189582; c=relaxed/simple;
	bh=6SdbPPe9pmSE8+0ZJM1umJlBQZ1wA58S28tOdEyrjyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DoLchCqTgQ6ZHZtjhRXW1Ym3QVLCSlLcnp8UvHfjc/C6VxV7snewev2sBqO2GjXiH8Wz3zC1ML/kt4eHXTeReVDel9G0BPneWspnJlODry8QLJefI4Jk2NJSvcf5e7Lr8hL2KvlHYR+L6+L2vgjcZJ2dPBxCGnMlDHvvBeTuR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpUYHN0V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpUYHN0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750189579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icFJhskVkKQqZu2iPajxPrgD6zNA+fOLsrBnVy7h8EQ=;
	b=BpUYHN0VDcvJs44dUruAbxmNqFYw/KcM/fTq5uN1sy92onDORvNq69P2y1h2ltnY/OkMO6
	LsT1IWmPGHRNGbiFHQYPIp9sNjW53cz1iQjamQHPsWj66mjLifw94o132qRD/5YHXzRuBi
	wBECYWv9fIWWdPitQAmzu/uZYfl+XYI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-oFkuQSo0O6CZz1kG4QCF0w-1; Tue, 17 Jun 2025 15:46:17 -0400
X-MC-Unique: oFkuQSo0O6CZz1kG4QCF0w-1
X-Mimecast-MFC-AGG-ID: oFkuQSo0O6CZz1kG4QCF0w_1750189576
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so2217170f8f.1
        for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 12:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189576; x=1750794376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icFJhskVkKQqZu2iPajxPrgD6zNA+fOLsrBnVy7h8EQ=;
        b=diL3kLjfYU02lfAe5xgZN4bnlpip7z7IBP6XW4R9eVqOKfc4yXzhhyEWytGtcVxvKO
         RtRngMCPL5o5VtS4UIwW1FqPS2YALstmZHzk95iSAScJ3n1hND59fd6ssIAvy6gkhB1E
         887R2rfGOB3ARsHVSQ0L38dTU0X+W+2lAJgec8q22VWKY74xyVxzcknZUaT7C5Opr+3D
         ULgt4nDCTEmKRMYERHX43cRBVRS0D0lBavfxGDOENWDX3WgmeFZR0l+W3s0PW9Xi7MGT
         hilsoi/COniBJRI7ycUdmtwIIk/76Fvv+T/ucqQG657w3HW34L1dM44hRQCIT3plMfk0
         Jypg==
X-Forwarded-Encrypted: i=1; AJvYcCXthVgp1vXmj/FgoQ0DG8J/D8Wx9Pkyp3bsx2eLBkPRtrL5EoCadRM61BU09U4n8P3ksNCckQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpfYGO6y6q/hLcc6gKQRgJe9ZMOVvBaTkPE+X0fFIWRVod82S6
	fqb2C3XPs+tDj5BmJ1NK1qCa7S/CL4yOEFbjNXQGdO8/dAezrDCUxTJNGwErwhHqDaqAfDbRAk8
	qjS4iiXhVTiRcw1HFou8gRLOVIfk6/YYYOlx8BpSPiexE2ZTJHAjAesqi
X-Gm-Gg: ASbGncuC5N9LyPVvVWfG+2cF+cIq/0Z2RPCATqAJV7Su1ym5m+/v9S9mKr5OBZvgOoJ
	92qZkjB8GKhpYoffmLsREP1Bc27vuAOauP8GJkNtj8yEMk9BXta0eqTbumjZ57oGBQyyeTSTv9E
	QWrqqvxb750nNPC69C5XIrXHwyCsYrYQAcWS2BB0cLMoNXEi/KeQJpE3Pj07neD32rHoIA6OU2a
	orONt+Cfi2hCDghpVcGw/be/FeCwiiejt744sgGllkFrS94U9CTRJctATI5FhhDzZCGlbr8uYls
	yatyEoSa/6Gt4J12
X-Received: by 2002:a05:6000:2007:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3a5723660b5mr12195283f8f.7.1750189576215;
        Tue, 17 Jun 2025 12:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO9JZf66g6UmsF+FsTytz4QymacwGU4iFb1DNv63Dd/5GxeH4PDvqwykdFRQ9tUf5lrXqgjg==
X-Received: by 2002:a05:6000:2007:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3a5723660b5mr12195258f8f.7.1750189575837;
        Tue, 17 Jun 2025 12:46:15 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a543d9sm14603319f8f.5.2025.06.17.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:46:15 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:46:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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
Message-ID: <20250617154524-mutt-send-email-mst@kernel.org>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8958KrMq4YQlxrCPGjh5gCdV9JWvKP45I64X7IYP5x4_1750189576
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 15, 2025 at 02:47:15PM -0400, Demi Marie Obenour wrote:
> Virtio-IOMMU interrupt remapping turned out to be much harder than I
> realized.  The main problem is that interrupt remapping is set up
> very early in boot.  In fact, Linux calls the interrupt remapping probe
> function from the APIC initialization code: x86_64_probe_apic ->
> enable_IR_x2apic -> irq_remapping_prepare().  This is almost certainly
> much before PCI has been initialized.  Also, the order in which devices
> will be initialized is not something Linux guarantees at all, which is a
> problem because interrupt remapping must be initialized before drivers
> start setting up interrupts.  Otherwise, the interrupt remapping table
> won't include entries for already-existing interrupts, and things will
> either break badly, not get the benefit of interrupt remapping
> security-wise, or both.
> 
> The reason I expect this doesn't cause problems for address translation
> is that the IOMMU probably starts in bypass mode by default, meaning
> that all DMA is permitted.  If the IOMMU is only used by VFIO or
> IOMMUFD, it will not be needed until userspace starts up, which is after
> the IOMMU has been initialized.  This isn't ideal, though, as it means
> that kernel drivers operate without DMA protection.
> 
> Is a paravirtualized IOMMU with interrupt remapping something that makes
> sense?  Absolutely!  However, the IOMMU should be considered a platform
> device that must be initialized very early in boot.  Using virtio-IOMMU
> with MMIO transport as the interface might be a reasonable option, but
> the IOMMU needs to be enumerated via ACPI, device tree, or kernel
> command line argument.  This allows it to be brought up before anything
> capable of DMA is initialized.
> 
> Is this the right path to go down?  What do others think about this?
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)



The project for this discussion is also virtio-comment,
this ML is for driver work.



