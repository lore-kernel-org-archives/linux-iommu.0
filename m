Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9913D1B375A
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647312; cv=none; b=igO25Z5an9YSEI0I22cYu7WP23nryygj41f5l0r2gRSqRuX7fJqwYFzNHQzsEweQXZhFeJqwrEMT/fLanLHJNFuGd8Orsew1w3lWICOos5RP/RvHxtAVWVwknxLDGBo++NvuOQNcGacZcpZ0m3T7R18kHtrn5UVeu6vtvugVG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647312; c=relaxed/simple;
	bh=WoccYl5tJ4uS73R5zSqJbENwLN3ciC51K4xWuQmtihA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCQF+sFYN8Nmahyfe3l5fc6hhEGsPw5xDNN03HxQH8XxznTBjHAygjfHc7eVUSXhafkvsfrYPGfp5gYGE4FzQn8AYuHmi22cI8oR+3PqzQNvkr36e06i2FKOSCUcW98LhZkKLIvab9v8Vcnv78vR1IfjYWgUnHNhJdBvZYuJBGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJ8xBrik; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJ8xBrik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723647309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPm3R6PblHeNKQdvTaJGKrEzfWm2oR4v27v3xkNgebw=;
	b=aJ8xBrikto+YSH+2J5Sb/9wMQ/74XEcwJk1JW1Ogb2864/1M7TuQqkJ2L9mjuQleMO66BE
	1FDwPQ5It0voQVd6CGPUw3zBMHqLeSQhZmcv3Cipi4qEe+llh1sdWg91eR/IW9Xu89WVrE
	ZKOo6xWegCSTbkTkrwGR33hFLS9A1qI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-p66Pf0AqN7WTt_QrYfmbOQ-1; Wed, 14 Aug 2024 10:55:08 -0400
X-MC-Unique: p66Pf0AqN7WTt_QrYfmbOQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81faf98703eso604739f.3
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 07:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647308; x=1724252108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPm3R6PblHeNKQdvTaJGKrEzfWm2oR4v27v3xkNgebw=;
        b=fWCNNYD672xokjnSJMezg4EKQzG0/WBw9UlbOuOOlaCelgbradXwV2Ftgt7gQ2bJ6C
         vbBK9hCgyZn5sKwuK8Jngj4VoPYkP2SaRDQmg7f32NypPAJOBv8NWHQSi3j5wKLn6o5m
         21X5E6/ZeFcpUvRyUt4jfWrJff/D+DmL3tB9VcXKxR6TaDfp8s01AbHfOhYmtcl+wES7
         wC7hCt9DSMdLN1tBhou0Ui725KErtuTJyPO355KNhlXP+54KPf8Gh3XH/magPCmXu+fx
         UQdGyrwee1xjHylRT+FNe6AQGOesS8GBWy86RFEU/ZGFLdWFTMxhyx1RBgb+PULHooV2
         vWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5zMxhKbc9JMGxdqueOm7zlAzsahhxvfvbdtt3EhPXfv0xvbqlY7rTtSmAJG0gn+lrSRVD7eyDmRXaHsqVI2pNcbu7CMc=
X-Gm-Message-State: AOJu0YxDUxHF2uds+2cx/SmWpku7M1i2S7Wv+8EX/NSjyvs8bwNLvgxY
	1VzErWgiv2rA4nMaR0LLBrQWldJMQfygG7sjPhTA2rBesueQY0T1PPaaXSZtNBo8mE46U8Xv54k
	ChherfNfeSZNKviTkxamLT5TXqEZ6OBSfGoA3TPWO8g9lQX/wVETX
X-Received: by 2002:a05:6602:4c8a:b0:7f9:b435:4f5 with SMTP id ca18e2360f4ac-824dae79033mr337940339f.11.1723647307729;
        Wed, 14 Aug 2024 07:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKOB2u3ExmlngG/ZGX6m16GkR9QFQMCyYiDK1GqVIcqqNhWRQ6U/pFLSxgUSO2c6mZ3lkevw==
X-Received: by 2002:a05:6602:4c8a:b0:7f9:b435:4f5 with SMTP id ca18e2360f4ac-824dae79033mr337937239f.11.1723647307328;
        Wed, 14 Aug 2024 07:55:07 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca769102a4sm3274045173.18.2024.08.14.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:55:06 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:55:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
 quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
 johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240814085505.60819623.alex.williamson@redhat.com>
In-Reply-To: <20240813231642.GR1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<20240812170014.1583783-1-alex.williamson@redhat.com>
	<20240813163053.GK1985367@ziepe.ca>
	<20240813151401.789c578f.alex.williamson@redhat.com>
	<20240813231642.GR1985367@ziepe.ca>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 20:16:42 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Aug 13, 2024 at 03:14:01PM -0600, Alex Williamson wrote:
> 
> > > Personally, I very much dislike this. Encouraging such hacky driver
> > > use of the interrupt subsystem is not a good direction. Enabling this
> > > in VMs will further complicate fixing the IRQ usages in these drivers
> > > over the long run.  
> > 
> > Clearly these _guest_ drivers are doing this regardless of the
> > interfaces provided by vfio, so I don't see how we're encouraging hacky
> > driver behavior, especially when it comes to Windows guest drivers.  
> 
> Because people will then say the Linux driver can't be fixed to
> properly use an irq_domain/etc as the only option that works in VMs
> will be the hacky copy from MSI-X approach :\

Ironically QEMU already has direct access to the MSI-X vector table in
MMIO space and could implement this type of quirk with no kernel
changes.  It's MSI that is now blocked by virtualization of the address
and data registers.  Note also that QEMU is still virtualizing these
registers, the values seen in the guest are unchanged.  It's only the
VMM that can bypass that virtualization to see the host values.

Let's imagine the guest driver does change to implement an irq_domain.
How does that fundamentally change the problem for the VMM that guest
MSI values are being written to other portions of the device?  The
guest driver can have whatever architecture it wants (we don't know
the architecture of the Windows driver) but we still need to trap
writes of the guest MSI address/data and replace it with host values.

> > > Thomas Gleixner has done alot of great work recently to clean this up.
> > > 
> > > So if you imagine the driver is fixed, then this is not necessary.  
> > 
> > How so?   
> 
> Because if the driver is properly using the new irq_domain/etc
> infrastructure to model its additional interrupt source then this
> patch won't make it work in the VM anyhow, so it is not necessary..
> 
> Your other patch would be the only short term answer.

The QEMU patch relies on this kernel patch in order to be able to
access the host physical MSI address and data values through the vfio
interface.  Otherwise QEMU has no host values with which to patch-up
guest values.  As noted above, this does not provide any visible change
to a QEMU guest, it only enables QEMU to implement the quirk in the
other patch.  Thanks,

Alex

