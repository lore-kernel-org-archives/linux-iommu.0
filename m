Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8A37BE7E
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169014; cv=none; b=YlQzePpbMIeG3kc4HfUk9y1Jocx9zcv/k+/Ua2jnmt+rAmjUDZn/bBKqoXAANYBTfK2SO1v64OurZkzpsVjxzIMQ/XOK4SXbEGw+1JnJSHDowZG6lh5z05Oa3XdSgCyAFaUSB2myICXZgCoyJ2KL9Ui+RXI2nSWgW/Asy3BvIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169014; c=relaxed/simple;
	bh=ohBLg6zklX4DgJ9bSXQSZGhcNkuU9UAPO40x8h/3VwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMQEPHclU7KEoY0F7ONwSCiDmaE6THfhNt4p9Arde34AUIoWLThe1shrG1T4Zh1G8JyaPXKhieYBjaobAjvo9fUd7OqSrE6DC2sntQ4d+oFYf886L0ZSZv5r5zTrOs7/LFtMp3f7md8jPd7Bcnip5LeltdDyZPkFhs1txCoJQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GUfGWCec; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUfGWCec"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so21155ad.0
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 15:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782169011; x=1782773811; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O/6a4uQH4M/fYcm4KZch0IFgU0DNYbj6+XqTiDv43tU=;
        b=GUfGWCecNwvlIWjbh3+6LIlooeOWa+SWE9cACTqFcb/MiR7LhdNClD3pBwm286lOZr
         3D/Xyc47G9KUqhYL4+NwpxrcbXgjjBs0A01laFGjJJEy9Lj/V0sgZb02R+n1s3h3hPO9
         FMBYq8ZTcEdfSVij9hyIXPdTALTY3VGKsdoeCldn040fLPmjjCJnGk8pVpx/VHhbD8te
         7nzfiQxzhvfXAGeDseylF7sdVDKxGdSEBh39KhxZBjqfU6L/9HXQi5cXupRcrJUp7nhF
         mGfQzbn267fqLoYIH3l2KDRx1GXLu7Jg5QEUM3hlNg/ArCAOd80sjJSoRV4xsLZyOVQu
         yfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169011; x=1782773811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/6a4uQH4M/fYcm4KZch0IFgU0DNYbj6+XqTiDv43tU=;
        b=Gx4P0H6HKs+bN3CoJN0kFTWN3bSfrkgGSNXvScpYiKsGJgfH6oJMY8p5okzSWZz4lz
         fMNE2ePbJX5etKOS6uOR0GR35qWuLMpS+0PgPcSNYJMqyviGJcnBdERpKM0461Cx3GHO
         4sUe4Xr28YvDEJhX7GDZWMI22HMkJzVh59RHBK5POJKEiEqIoHGJXXdyBqZkov9BYGUY
         YbILtjlaSsOZh3gUYB+q6tqvARKicPChkDHAv17EktQVe51ZkvS4phNk6DJkWGIjaHVb
         Sshtutq8hrTBmJVquyNQJtlmyI0Ef8pCBdlqvMeM0dQmZ/jFoL8rH0LNGGwujcBoEwQP
         vVTA==
X-Forwarded-Encrypted: i=1; AHgh+RpdXCqIADWtrd74rea47/u8fTAjgmSp+/E1ToO2qt1weul3ioImkbYTqTUrG+XUwGfWozyegg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+EjArI59dScLhSQQeXmbQoYM3jMu/lIhRAB+3sL1Cl5hlxa2S
	WOVYo2kym8J65P2BrdigmeVBNA5Rt1mu/6DIelWzVANnqGH21eNFt0K1ugP7vG3oSg==
X-Gm-Gg: AfdE7cmYGVyco+P2eDEbrPOOmYCq2bAX77ERxwU8rmgWnMnFKJZtf6KJadfIJigX3Xu
	wP/fUwHXRCv4iaMLLBXCuSxfdLhLV7DqwBa9URe+7V0ErDuey9ny02M8b2oJZscsBl7ztQ4YIHE
	gyQSOg0Am24y4W0opOgZyIG0pKke+v6d3zugZjvx6UHvObXJUM/in+Y69yXe/oMCMe8zoe5Ka+k
	k0B0tvDPi6rFBtHr8lboiDaaWdsnUeFwa585a/DoFu4rQpjgRpRIk0t2oPGo/4v6sM4bHRqoG9p
	HxQZj7UqfjZfyjO+oveQSun4sqWwTKQ09CqkOBGzd5nSImD9LxE73XSiWWbVdJ5QrG5CDZjOylt
	KoKqPHfbQeX5Q0PrnUrdIkmNleyDv6d6OveeXUDKq6CeFZTBhosrBt/oqJsEyHwlECr/AZal3y2
	Ccq2NTc5OHeme4/ZJBydnjVombqO9eyigpPfCK3/R+PO6WYm9rYPBzwkFNk38KXGjyKXat/ifa+
	u4BQwAu
X-Received: by 2002:a17:903:98b:b0:2c1:ee6e:be1e with SMTP id d9443c01a7336-2c7c539a5acmr932245ad.28.1782169010638;
        Mon, 22 Jun 2026 15:56:50 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aa5f1sm105411885ad.78.2026.06.22.15.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:56:49 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:56:46 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 08/18] iommu/vt-d: clear unpreserved context entries
 during shutdown
Message-ID: <ajmYQFemGb2JD0BF@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-9-skhawaja@google.com>
 <51e03b42-796c-489c-a0fa-525ed1a492ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <51e03b42-796c-489c-a0fa-525ed1a492ca@linux.intel.com>

On Mon, Jun 22, 2026 at 10:47:05AM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>During normal shutdown the iommu translation is disabled. Since the root
>>table is preserved during live update, it needs to be cleaned up and the
>>context entries of the unpreserved devices and root entries for the
>>unpreserved context tables need to be cleared.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  9 ++--
>>  drivers/iommu/intel/iommu.h      |  6 +++
>>  drivers/iommu/intel/liveupdate.c | 74 ++++++++++++++++++++++++++++++++
>>  3 files changed, 86 insertions(+), 3 deletions(-)
>
>Please tweak the commit title to: "iommu/vt-d: Clear unpreserved..."
>(capitalize "Clear") to match the driver's commit history style.

Agreed. Will do.
>
>A high-level question: have you looked at how the suspend/resume path
>behaves with the iommu and device preservation? DMA translation is
>disabled and re-enabled there. I don't see any immediate changes are
>needed there, but it would be good to call it out explicitly if it was
>overlooked.

I looked into this during early implementation. The preserved state data
structures are not affected by the suspension of the IOMMU, as during
resume it reuses those exact same data structures in RAM. But I have not
tested this since it is unlikely that in the environments where
liveupdate is used, the suspend/resume functionality is also used.

But I plan to simply return -EBUSY from iommu_suspend() if the IOMMU is
currently preserved. This explicitly prevents the two states from
overlapping and avoids any complex edge cases. I'll add that check in
v4.
>
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 715b538e7efe..26258861e3bf 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -2374,8 +2374,11 @@ void intel_iommu_shutdown(void)
>>  		/* Disable PMRs explicitly here. */
>>  		iommu_disable_protect_mem_regions(iommu);
>>-		/* Make sure the IOMMUs are switched off */
>>-		iommu_disable_translation(iommu);
>>+		/* Make sure the IOMMUs are switched off if not preserved. */
>>+		if (iommu_preserved_state(&iommu->iommu))
>>+			clear_unpreserved_context_entries(iommu);
>
>How are PCI devices handled during a live update kexec? Do they go
>through the standard iommu_release_device() path?
>
>I assume they do not, because if they did, the context entries for
>preserved devices could be updated after preservation. If they do bypass
>the release_device path, why not just explicitly invoke
>iommu_release_device() for all devices that are not preserved?
>
>Using iommu_release_device() for the unpreserved devices would naturally
>erase their context entries and securely park those devices in a DMA
>blocking state.

I considered reusing iommu_release_device(), but it leaves the hardware
in a state that is unsafe to carry across a kexec boundary when global
translation remains enabled.

- In legacy mode, iommu_release_device() does not clear the context
   entries. It assumes device_block_translation() was called during a
   prior domain detach to clear context entries.
- In scalable mode, while it does clear the context entries, it skips
   the PASID cache invalidations (per VT-d spec 6.5.3.3 Table 25, second
   row). It assumes intel_pasid_tear_down_entry() was already called
   during domain detach to handle the invalidations.

During a normal shutdown, this is safe because the IOMMU driver disables
translation globally. However, since live update keeps global
translation enabled across the kexec, relying on iommu_release_device()
would lead to DMAR faults from unpreserved devices.

Manually clearing the entries and issuing global invalidations is the
safest way to guarantee the unpreserved devices are securely parked.
>
>>+		else
>>+			iommu_disable_translation(iommu);
>>  	}
>>  }
>>
>
>[...]
>
>Thanks,
>baolu

Thanks,
Sami
