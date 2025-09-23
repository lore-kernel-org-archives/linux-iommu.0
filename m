Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BC1D798E
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590265; cv=none; b=UhE1X8KCzelPMkSFAv/uPaqttpot2AsYacPLboRmh8vkNgQXDE/36xIyPCBcKtZOMLjR4XkBGlqwEqxFUj5roP5FQHd5eBNf8IEGomE5F48XRmy5gIMSl0gghgzBSrvl+JDlLkQgoTD9DEKeEyQKBX8i/m9bI+pPEoFLZKZTR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590265; c=relaxed/simple;
	bh=1/e3AyiZPS/c0G1aMUyRNLYzo4gjhYckdUnHLFkO2mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvjy2vemixejSQawgNcmcKDC2xIgoPwaPEAC9jMV4/CFVUb0UhCbDW5R9UYOdNbD6qI1igqvJdGvNcIQdHTPn3VSjchrnub0zVj4gamJSW39x0I7dGPyL4WEAfCdf4k0PIwDaZp1CeecVcv6CiJ6J6QcZvUw1VFskSG2r2+UIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6JQygw4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6JQygw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758590262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ut+zQ+Ol2AC0M60Dd4+aidn6RjiEypu7DiFVdYxlNks=;
	b=d6JQygw4nT3nPSBkXQHm7Bbzxs1a6F+jz+TOUYbgFulGFMFQp1S14AwACz1AJ1fjph9gSa
	sKYfM65WIm/2CpXVoIGsnM+cJCeXepqbGpMaIMwtWtBGpsqM6BrqL88A7xff8FnLU8RkTv
	Lq3VXGDld2onzP6NL/HlbuQFcPsdudA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-m9xVYUhKNoOaogDArRDKaQ-1; Mon, 22 Sep 2025 21:17:41 -0400
X-MC-Unique: m9xVYUhKNoOaogDArRDKaQ-1
X-Mimecast-MFC-AGG-ID: m9xVYUhKNoOaogDArRDKaQ_1758590260
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-30cce8f09f3so1301554fac.1
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 18:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590260; x=1759195060;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ut+zQ+Ol2AC0M60Dd4+aidn6RjiEypu7DiFVdYxlNks=;
        b=ZdRrE5gRhlL92oxX8aLnHCQzwT2yUhH0wAdgu33Q+jhygTHaJfQWUEKgSChqmfJ2tS
         JkVGv+I0d05z7kWa5jEzbSEdMV0BgLfKU/GNu8vpRLuLbW/ykeOtV5dPzOM7YwABU+Ab
         5891pJ/2Wo3hAVBT/0XOl/UnqaB19fL/ICQDa7z/iUQ82ZXkgo3RurcP2Sub9O5Lul71
         Q+K3YRME3LGAzeMpRZzNo7qh3YzjmxsoiTpmdL69Kbi4BWGAZ1/nOGJJgVUvj2YhKABy
         hKY+q25ox/jyGxJ6TmfojMKmPx7iT40gzcbjY5AqiFcuRHVPJ/Clqys53ZkEnG53oDcI
         d6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5AfzeXL3WCx7O49OYKpdY8ztbyawKFyv527Cu9gqb5zkDTDWZuJvVPjyX1gJYrvNCvU15eQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxzSy58CSAzwsnpCuK3XwtmNFY0+ihgkugHkrgkVYEjzV7CT5N
	Pv8NiKrWH9DKlL2CWgqkIuPqYAJx2TLL5z7/jmJo7EDexXhL9x3DJsKaRs1P0OYnsItTuaHVFIx
	YDWEMdG5bKMcl2WfV5pKCOrfXtBXF5MP10uDRqxQPNjA+YmURAcEOBFVD
X-Gm-Gg: ASbGncvNYnLtNqmuUgVQCrLi/9rgghEXERsBCoD9JSSA5FVVas8ubkdRnd50GCrptwv
	US+7iXwagX6eM8ZCf3I5ZVJ+EKGpm+gJM2DeA3oz0HfeG1EXnfpF/6fTK2eqfKJphlWBqv0oDmt
	dICBiX8kPdkiSxMd6xUYAqUy4RwdfJ3zCSd1djNXWUPRFkXhCTKrrYIamcG86ksvLsfHhStohz2
	7NGy+Pj+JpQAupzntmpvn2A/Ifa+j9QSUzx34QA5lOhSy6b7bcr2z/oXUc7i9whQSGZPUEBFJci
	SJ6MPgapGGyx4XLB8zIyTPs+3mUP4CyeaUJPhWe3eqk=
X-Received: by 2002:a05:6808:308d:b0:43d:3c37:a342 with SMTP id 5614622812f47-43f2d12e4d7mr161924b6e.0.1758590260134;
        Mon, 22 Sep 2025 18:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq9zHgq75BiE7ApXBV1Yytp3xnXFPeZg11oR2JKDr/lqHrXhwW6Di8HRCOFBIdLqEvOuYtIw==
X-Received: by 2002:a05:6808:308d:b0:43d:3c37:a342 with SMTP id 5614622812f47-43f2d12e4d7mr161918b6e.0.1758590259726;
        Mon, 22 Sep 2025 18:17:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43e20b45410sm3700113b6e.12.2025.09.22.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:17:39 -0700 (PDT)
Date: Mon, 22 Sep 2025 19:17:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Donald Dutile <ddutile@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 galshalom@nvidia.com, Joerg Roedel <jroedel@suse.de>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, maorg@nvidia.com,
 patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Message-ID: <20250922191737.0df0dbed.alex.williamson@redhat.com>
In-Reply-To: <1845b412-e96d-438a-8c05-680ef70c04e6@redhat.com>
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
	<1845b412-e96d-438a-8c05-680ef70c04e6@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lj8vOijnS6xa8Sg5XYY2hjnyUNeuztHQxefNfsSONbA_1758590260
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 20:51:31 -0400
Donald Dutile <ddutile@redhat.com> wrote:

> On 9/22/25 7:15 PM, Jason Gunthorpe wrote:
> > On Mon, Sep 22, 2025 at 04:32:00PM -0600, Alex Williamson wrote:  
> >> The ACS capability was only introduced in PCIe 2.0 and vendors have
> >> only become more diligent about implementing it as it's become
> >> important for device isolation and assignment.  
> PCIe-2.0 spec-wise, was released in 2007, 18 years ago.
> If hw is on a 3-yr lifecycle, that's 6 generations (7th including this year releases, assuming
> gen-1 was 2007); assuming a 5yr hw cycle, that's 4 generations of hardware.
> 
> Maybe a more interesting date is when DC servers implemented device-assignment/SRIOV
> in full-scale, and then, determine number of hw generations from that point on as
> 'learning -> devel-changing' years.
> I recall we had in in 'enterprise' customers in 2010, which only shaves one generation
> from above counts.

I don't see the relevance of these timelines.  A vendor with their head
in the sand still has their head in the sand regardless of time
passing.  Device assignment has a heavy non-enterprise user base.

> > IDK about this, I have very new systems and they still not have ACS
> > flags according to this interpretation.
> >   
> >> IMO, we can't assume anything at all about a multifunction device
> >> that does not implement ACS.  
> > 
> > Yeah this is all true.
> > 
> > But we are already assuming. Today we assume MFDs without caps must
> > have internal loopback in some cases, and then in other cases we
> > assume they don't.
> > 
> > I've sent and people have tested various different rules - please tell
> > me what you can live with.
> > 
> > Assuming the MFD does not have internal loopback, while not entirely
> > satisfactory, is the one that gives the least practical breakage.
> > 
> > I think it most accurately reflects the majority of real hardware out
> > there.
> > 
> > We can quirk to fix the remainder.
> > 
> > This is the best plan I've got..
> > 
> > Jason
> >   
> 
> +1 to Jason's conclusions.
> We should design the quirk hook to add ACS hooks for MFDs that do
> not adhere to the spec., which should be the minority, and that's what
> quirks are suppose to handle -- the odd cases.

Sorry, I can't agree.  I think we're conflating lack of a specific ACS
p2p capability to imply lack of internal p2p with lack of an ACS
capability at all.  I don't believe we can infer anything from the
latter.  Thanks,

Alex

