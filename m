Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FC1DF72C
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589839; cv=none; b=tDf50qbgrQcyNXzSCkMaLbpP7MtmDa+m30Li5zdy0AfZMEj+3b2JFk1LkB+BLfjUOzBfk071SmWVDPrGyB7BojXMGbSL8gSZ5+Cl9IVA+knfz6YF0850UBxuyArGNAMlRsrBlepzIQYptL/R3oDV6RR+OxUwJNhVAR19xSmWs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589839; c=relaxed/simple;
	bh=9rAyCAp0JWycHOc8mJx4dBKJhDcA9CLu0OXu8TULZ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNQKsoFEw2Agn8+J73pbyyok+LMY7UR+q/veUgSQk52xZqQ7LnJ5Ri/xwV71xKAlM7ON8wROPszE0Xueyuo5Xm2ABGQ5azhtA8a1/IpgKFgkob2AfhnQv5m6RM784CSBqd7UGd+y0DKgyujAveEPb2LaP+1X+KSdwR77CYbjPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpmMdfoe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpmMdfoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758589836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMdCl+IiTEZQdjIFjdJwfIpOIRvy1QynTRS3PoYFQjM=;
	b=bpmMdfoe0dbq2QSef52bMezo2eTF+pjiFbX50bSkzvM3nOTrdGw8xIiMO7cSAnIgKgC1Df
	v0ZFRdksTx+JBn2zF5d4GFpkFibi+qtyBDoaUmsF6jO1vy5XgbgTYuxoViEv10eL34Fiv2
	JWZxCvU6n6hF/wJQjgKbAEIB0BtVs9g=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-TUE01aY9OE2GjzfHLE_XOA-1; Mon, 22 Sep 2025 21:10:32 -0400
X-MC-Unique: TUE01aY9OE2GjzfHLE_XOA-1
X-Mimecast-MFC-AGG-ID: TUE01aY9OE2GjzfHLE_XOA_1758589832
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42571642af9so6490575ab.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 18:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758589832; x=1759194632;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMdCl+IiTEZQdjIFjdJwfIpOIRvy1QynTRS3PoYFQjM=;
        b=PFQVRsbeZZeBbB/AbUjBob01AwieoNT3zUElRuw+UeE4Uri3iLlWLB9/5BHgGljIFy
         MsiLGXBVIP/rREy59EWojUKn3owAvoW8YEeDoNNGmfsPVVQlqthj6cCJ3qikeGrNnd+K
         iQj7QS9WkFp0peoRzpi+9M8PAl0xRyBLDmb2ukJeAfD16VsO5SZEUJ9t+kAfHJWZntDc
         mAX7gwNJg9Q4CGBc0vM0dvxHAngznWSqtWTpYSbaUT3KzM3LxPUKBlTe6DUBcWvxGaTM
         PApyH5hveJ1a501ifoeTGU495UFa3eEdyxs7/AKBXrknxEaSZkcZRx1X5Bcf3MV0NbE0
         KuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeaMpP5CZRhEfXBM76/eTXqKX0SQBXFohsqv1A7AjWUgn+CMByqsp8RTqQ7/MGwHEqjtP4HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaJRWv10UegRI/Gz5rsCW8WKd2RGfO5d4nqoexnr3Mqw+OG5+u
	pii3+7Fv+GP+khvjfXk+GEw3QB8Arkb2VUN5cnL9PhnJ2mBKX0JKeyKxJF96XD4JiLAimQtwcTd
	6IbWUiQw5H/R60R6xU07V94Ma3WFRSPtLpZNrXS02f9+/nux8Vsq0GRdE
X-Gm-Gg: ASbGncukLdcsbTXLVSK/NIEyXuzIOQY33cIOyFoBX7vK0o74uInBCWWmCMcfVangDgO
	FB2AVXaMeAYCYCn5JZEQNrpJTzwq4MRIP0YwRroJ+yUAQ2yIQ68NAXumwJHUAxBrNqkN6hXbD3W
	gJ1lDaHuXEw0r7YoojEn3gHnLcsMYoBL7TXOLdJ299e0NHB3DjNP9sIxkqbtIR25zoMZJUTJYZY
	0IBOnmaLpsmXMS11zTvfO2CrdPQB3jL+ceRROz0kNHz/4RbDfxhGv7eOkAm94N9dnomE3Vr3UtJ
	NwGQtp50O9hvZ/vnUX11XTto9wmwZtzp7kA9wu0zNbI=
X-Received: by 2002:a05:6e02:1062:b0:425:84b6:a7de with SMTP id e9e14a558f8ab-42584b6aa30mr980485ab.0.1758589831766;
        Mon, 22 Sep 2025 18:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjujwsV4+PvdiPV9xPzzt8xVXDXwwoMNeGQllr4EYycFAIvL2pedut8GhHoH/nZ1k7CtN0Ig==
X-Received: by 2002:a05:6e02:1062:b0:425:84b6:a7de with SMTP id e9e14a558f8ab-42584b6aa30mr980355ab.0.1758589831423;
        Mon, 22 Sep 2025 18:10:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56221c6f374sm865008173.55.2025.09.22.18.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:10:30 -0700 (PDT)
Date: Mon, 22 Sep 2025 19:10:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Donald Dutile <ddutile@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 galshalom@nvidia.com, Joerg Roedel <jroedel@suse.de>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, maorg@nvidia.com,
 patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Message-ID: <20250922191029.7a000d64.alex.williamson@redhat.com>
In-Reply-To: <20250922231541.GF1391379@nvidia.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<3-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<20250701132905.67d29191.alex.williamson@redhat.com>
	<20250702010407.GB1051729@nvidia.com>
	<c05104a1-7c8e-4ce9-bfa3-bcbc8c9e0ef5@redhat.com>
	<20250717202744.GA2250220@nvidia.com>
	<2cb00715-bfa8-427a-a785-fa36667f91f9@redhat.com>
	<20250718133259.GD2250220@nvidia.com>
	<20250922163200.14025a41.alex.williamson@redhat.com>
	<20250922231541.GF1391379@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qNFgthcepDmbTHux1ZHudT1b9XJCGqJoZ2wKXp7-i10_1758589832
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 20:15:41 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 22, 2025 at 04:32:00PM -0600, Alex Williamson wrote:
> > The ACS capability was only introduced in PCIe 2.0 and vendors have
> > only become more diligent about implementing it as it's become
> > important for device isolation and assignment.    
> 
> IDK about this, I have very new systems and they still not have ACS
> flags according to this interpretation.

But how can we assume that lack of a non-required capability means
anything at all??
 
> > IMO, we can't assume anything at all about a multifunction device
> > that does not implement ACS.  
> 
> Yeah this is all true. 
> 
> But we are already assuming. Today we assume MFDs without caps must
> have internal loopback in some cases, and then in other cases we
> assume they don't.

Where?  Is this in reference to our handling of multi-function
endpoints vs whether downstream switch ports are represented as
multi-function vs multi-slot?

I believe we consider multifunction endpoints and root ports to lack
isolation if they do not expose an ACS capability and an "empty" ACS
capability on a multifunction endpoint is sufficient to declare that
the device does not support internal p2p.  Everything else is quirks.

> I've sent and people have tested various different rules - please tell
> me what you can live with.

I think this interpretation that lack of an ACS capability implies
anything is wrong.  Lack of a specific p2p capability within an ACS
capability does imply lack of p2p support.

> Assuming the MFD does not have internal loopback, while not entirely
> satisfactory, is the one that gives the least practical breakage.

Seems like it's fixing one gap and opening another.  I don't see that we
can implement ingress and egress isolation without breakage.  We may
need an opt-in to continue egress only isolation.

> I think it most accurately reflects the majority of real hardware out
> there.
> 
> We can quirk to fix the remainder.
> 
> This is the best plan I've got..

And hardware vendors are going to volunteer that they lack p2p
isolation and we need to add a quirk to reduce the isolation... the
dynamics are not in our favor.  Hardware vendors have no incentive to
do the right thing.  Thanks,

Alex

