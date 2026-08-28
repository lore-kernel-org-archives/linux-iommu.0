Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017137F002
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933765; cv=none; b=qZEmfL1DEq9vnSVwO1NN+unSZm106XDsJtZ8VWJRuYw+DEdG3QOCbStEZuKUpQT2mSalTzdgipJYM+ZREF9G7ZeOcG+7RhtYzRqz1ldRHvS4CkQlnVt3HhFGVyjh6Hfu7Dc0VcbYu0x/Yz69jK5ylRlWinVJdAIslV82BUmqVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933765; c=relaxed/simple;
	bh=B3pqQmJqpWZ8Cb06AdIkKqiDrvfvLs/ppE69ssAKPUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZWDOw77BLCs5bv17TkpWm/vi3AQska9F2ooQxUIUV7hdwr3+xKVlCxBvc85w2RTdyiGlFWX0q7v7zN+W/+Eb9wihksNoIYzxyO3AWvl8QhfWvGoq8szRZsxTcgHfnEHn9jVw4q8rCsqEIYrVgOjEXcFQDtWE2KrwVwzkDNAs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/OxqJAo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/OxqJAo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdf36f63dso137985ad.0
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787933763; x=1788538563; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B3pqQmJqpWZ8Cb06AdIkKqiDrvfvLs/ppE69ssAKPUM=;
        b=N/OxqJAot3B7yYWw7NZGD267AkjvXP9PFUibIT7M0lPwheohctiSTrk8oiOaStWLTU
         o8i5x0ei5kl0CGrX/IlSwr1Kg7wV15ptavnwU+VAglOzyIf+O6mjsWxvBSpEAzNueuJ/
         Uc23N9KJiD451yX2FJZaV6mPIrIN6iqB+03QU9i4aBjwq0nD75SKX5uvWYfWNRx5e7jn
         8nYaLGTMbnzjFc0jJZ8zZjasuSzVU3r/VEuttKvqCBNzOwoEE39zKZ3nr9lHiMzwDBcn
         oSJ2zib0x7EP1bubR5li7QUfQfv0d0dixkEKP/mKZafLuzCJUMiuI8fpGjcD9fgIRx2T
         OUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787933763; x=1788538563;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3pqQmJqpWZ8Cb06AdIkKqiDrvfvLs/ppE69ssAKPUM=;
        b=f8LcO83GCvlmK/VDjKtbrXSe4z1NkUd/0ClNGKVhs6T9S9uDtI14M4DgX/oLvc26k6
         VjFEQbY2bZIH47vRT2FSB2fPVl9eoX5uwKgVEEQ08VKCjmCZyf3HL7R3Nx8i/i8jHeYL
         MNB8lVvQvSEVhNBot7NOulMhhF5IjUrh1C/KsiNKzXK8twO5GVkysH6NwDW+DbtIIEUr
         jnKRioRj2ihUXPMOlFPk1HN+i5tWs5appEYhd4ofaAdL8ywwput2XhP3Kx8NQmQqAJ9H
         T8qpv93uJjKYJRosUfK3Vrfepyx55YFkCkcCgUCFIYL3xcVJ8CfM4YF+FWEG7i3VGXeL
         bxKg==
X-Forwarded-Encrypted: i=1; AHgh+RphY58LfMR1yAklYqRx/xAYnHOP/O8uigjRG1tICPMLi0oAXIIestd4egEd54UOflQ4qYV74A==@lists.linux.dev
X-Gm-Message-State: AFuF++nmZUFrJJrR65lHRP+bSJGcM2iG2uBaC97iFuNQQnlSCHampvY3
	FCrm/FK3AqjIGi4sX6P/suvAu7mgH5T8xqKrHaTQg6qZ2ZJuvduWsytiv5L4XH7l8g==
X-Gm-Gg: AR+sD10HmqmTb9tFITdkAKR4K/xqzm5FRipo/C/ZL7DDRG97AK04HnITRWOIOov+Fig
	hRaqSiDngUB5wqSBsetQgTmIA2COpwpDUsUAHTOzqdC+U7qLxpRT/5y/qWFEsgidKcTibGrA/ZM
	u0WoO4SvjYf0uRt7n13K0YsHid1LUuxBzf83C7vFfuVnZRkKJqeRcoamgGJ1gbcJEV+je6JKibB
	9JwaU5IXgyCy1nunXU1wSp48mn+etgYjQmNUlg3PWU3wTfkB3vZ8GkcqbwR0006xYM1fIxesEgE
	y97KyNcy32HUC8B1Co0SVFyRUZWh5ZjiZfKkfSrfnbsP6Vg9CKZvYC749TlCuAYawa+WP9qtudd
	ZyDUrwK/8HwnAHToizqIR97ZmkOAltXrOjmSsk7UbTFbxo4niGA83x7mlxhDlCOmK/HdMtOShWl
	Zho9EkVZy8pCDRtzBVUXtTuYschAHXk/RDu0A3A57tpojOEyzPFB8G8wvrVGh5/x9H5ouxKOmNZ
	mfreRTgJA50U4/ms26VsHNhIVdjkW2fOmlTZn82aVX5P1GhvVegC8mkeX8=
X-Received: by 2002:a17:903:1b48:b0:2ca:6bf:5bac with SMTP id d9443c01a7336-2d74f53de42mr7697375ad.8.1787933760261;
        Fri, 28 Aug 2026 09:16:00 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-856a359515dsm724321b3a.48.2026.08.28.09.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 09:15:59 -0700 (PDT)
Date: Fri, 28 Aug 2026 16:15:56 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <apGpHv8vy4SWIEaV@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
 <apBso6So7UqwR3AX@google.com>
 <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>
 <20260828143546.GC3769797@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260828143546.GC3769797@ziepe.ca>

On Fri, Aug 28, 2026 at 11:35:46AM -0300, Jason Gunthorpe wrote:
>On Fri, Aug 28, 2026 at 09:55:18AM +0800, Baolu Lu wrote:
>> That looks reasonable to me. I have no concerns about keeping ATS
>> enabled on preserved devices across kexec reboot, as long as the
>> software state is synchronized in the new kernel.
>
>The new kernel should issue an ATC flush when it changes away from the
>inherented domain.

Yes, I will make sure this happens when we do the retrieval side. It
should mostly work well with the existing replace machinery.
>
>> By the way, is disabling ATS an option?
>
>No, many devices require ATS.

Agreed on the ATS requirement. I had Nicolin's patch series for CXL
devices in mind here.
>
>It is not that ATS and PRI are coupled, there are good reasons to do
>ATS to pinned memory too.
>
>PRI is a PITA, I continue to think PRI through the iommu was a
>mistake. Devices that have device-specific PRI handling are fine
>because that all lives in the VM. Devices relying on SMMU PRI
>forwarding must also somehow not loose any PRI events across the kexec
>and must ultimately inject all of them into the VM.
>
>> The current design already requires disabling PCI/PRI during kexec,
>> right?
>
>That is also not OK, but there certainly is a useful universe of VMs
>that might pretend to use PRI but actually only use device specific
>fault delivery.
>
>So ignoring PRI for the moment is possibly OK. Someone using this
>should understand what VM shapes thay are making and if that
>limitation is OK.

Agreed. To avoid the massive complexity of handling PRI events across
the kexec right now, I explicitly evaluated this during v4 development
and marked PRI as unsupported to limit the scope for now.
>
>Jason

Thanks,
Sami
