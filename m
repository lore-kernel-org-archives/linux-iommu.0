Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71E02DB7B8
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731947; cv=none; b=XOM77Qlwfz4J8BLHAJ5RfAYyw/FfZTD4/Kf5ahccftObH/yBSxFtAUxNc41K4qztxRK53UtAwGWzUJvXjexDx7IfWadK2Baz6hZnPNAgl1Or1QrLpZpnzSXTL/g01dGD5gPT5eMD1orFhA9ZMWkkpv4ogh7CKKnDteI0i83V5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731947; c=relaxed/simple;
	bh=emySSEMl392K5cvOyGvt1pcapOKfhTf8D46ghb3n6Cc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=paj16IGLPGX5SE9D40N/A9L9lkdLgAXP83feyYUU+fLkmHjFkGfmsqRfWm8kB5MdBrT4d+e3MAAz9y9D7QDcOQ9e5A8JsWYu+Q4mVmIBtsrXi0KMkRGqKfwelYOyrBIZoO6FocQXN5m5PglA2qrKD7EwiwR24w61W8LP2/VvCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c10YqV2I; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c10YqV2I"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2baf7378ad0so63071325ad.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778731946; x=1779336746; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLBypvNW5ZYdCzcXRqM68PW6cdfiVcgNLkkpkfrL15Y=;
        b=c10YqV2IsZ+EwSDFIJ0OWXZlzbcsgHGSL3xxUOFqhYPAZHY0x1bNH6Bc/AbAB5Ag0f
         5Ea+iyLaTbFLBVNMgXK97Hejdhat7Rxgyw+rgExYcYAbFdgXwG3mfSHZwFlfOjZXlNqD
         hKdxJcKjvTimymn+hL7vVWDm12edd7lN4O3kkPAOrXmkW0RoR9ZrJYxrjQOeurBxFX/k
         kz20KMWAtdlg85LcbAC+F68PFeUC80Ollqer6IMsK/N0x7eFBX+HmDfGtvv+/CVV2C3J
         RowdSF7o5V4PeunZECeKpPBpfBCIUP6UM5PgwqAHkxNpeIj4gYS/+QfybBR8tZ+39Sll
         8FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778731946; x=1779336746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLBypvNW5ZYdCzcXRqM68PW6cdfiVcgNLkkpkfrL15Y=;
        b=R8V3wgVri7fwgBg1VUUQRPQjgblOkp9ff3oZ2U7+MvEB2zuOI/SkhwF7npZFiREN/i
         wg2AniH+vWFRB5o5WRa+Y3J7TDYD6x6pvTZR1Yzy/mZw/kUbGipsD1mzETGMjgcp8h16
         MTXo1Uy6+N+uUi41FilmioB0ffjn5m/fLH0D/X91yap/j+YA/X8ez9HpFDNEQETQPcqy
         eHQJfhrz5ye65wXkePcaji8Dp+cS6/UX4+OTs1OTsR6UTAir1Lq2VlsJOrSkpjTlndFR
         QDQI+LA7X1pvf6yZ5WF8+hZGzcgw7DoSogFEoTiHr2luePjiPIKGHm5uWbH9wq6TPvPN
         Q/cg==
X-Forwarded-Encrypted: i=1; AFNElJ/AEi/WmDdX8GMnsBKhLD/GFxlZVMc6pXBVzTI2n+Hic62QvOIfjKrULEOoOy7NXJozQpUy+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGJgZtt0kC32DZA5RI8bH6FhaTXvj05idTQr5afz/2rGnsLOCu
	B7SCM9ME10VqOpIxn7VNwHIGnEvc+tGpFHZ2JHrq6kDijB3x3s6RfmxDw9WAac8LDDu8/XOnQTH
	JGv2xvdh6iVOnFpJdfTUvlb8IAw==
X-Received: from plj12.prod.google.com ([2002:a17:902:c14c:b0:2b0:5006:5260])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:388d:b0:2b2:4ffc:a7c4 with SMTP id d9443c01a7336-2bd2fc2201cmr55370495ad.24.1778731945615;
 Wed, 13 May 2026 21:12:25 -0700 (PDT)
Date: Thu, 14 May 2026 04:12:23 +0000
In-Reply-To: <20260513171059.GP7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260513171059.GP7702@ziepe.ca>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514041223.1518250-1-joonwonkang@google.com>
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: jgg@ziepe.ca
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com, 
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, joonwonkang@google.com, 
	joro@8bytes.org, jpb@kernel.org, kees@kernel.org, kevin.tian@intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, praan@google.com, robin.murphy@arm.com, 
	smostafa@google.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Wed, May 13, 2026 at 05:03:33PM +0000, Joonwon Kang wrote:
> > > On Tue, May 12, 2026 at 02:51:38PM +0000, Joonwon Kang wrote:
> > > 
> > > > Appreciate all your clarifications here. So, my understanding is that if
> > > > our system does not support ST64BV and ST64BV0 or if our device does not
> > > > distinguish between the posted write and the non-posted write regarding
> > > > PASID, then we can lift the use of the global PASID space. Can I say this?
> > > 
> > > You should do what Robin said - just have your driver use a per-device
> > > PASID that it allocates and never use the global pasid allocator.
> > > 
> > > To do this lightly re-organize the SVA code so the driver can supply
> > > its own PASID, and in this mode we wouldn't activate the ENQCMD
> > > features in the mm.
> > 
> > Ah, we could actively disallow EL0 to execute ENQCMD-like instructions
> > when the device driver explicitly shows the intention via a new API like
> > `iommu_sva_bind_device_pasid()` that Tian mentioned earlier. 
> 
> You shouldn't need to do anything like this. 
> 
> All you need is to ensure that mm_get_enqcmd_pasid() returns
> IOMMU_PASID_INVALID so long as a the normal iommu_sva_bind_device()
> hasn't been called. Once it is called it is fine to allow the ENQCMD.
> 
> Your new iommu_sva_bind_device_pasid() needs to establish the SVA and
> attach it without triggering mm_get_enqcmd_pasid().
> 
> The arch code is required to block the ENQCMD like instructions when
> IOMMU_PASID_INVALID.
> 
> Devices that can mmap an ENQCMD sensitive BAR region must not do so
> unless iommu_sva_bind_device() has been called.
>

Yes, the basic idea I meant is the same as this: use `mm->iommu` to
deactivate the instructions. The arch code for ARM may block them later
as it does not seem to support FEAT_LS64_ACCDATA for now. Thanks for the
details. I think I am pretty much aligned. Let me try it.

> > To allocate a per-device PASID, I think we should do it using
> > `dev->iommu_group->pasid_array` instead of making the device driver
> 
> No, make the driver manage this, don't mess with the core code. PASID
> isn't supported with multi-device groups already.

Understood. Thanks for this info.

Thanks,
Joonwon Kang
