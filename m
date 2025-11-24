Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C3265CDD
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024092; cv=none; b=sjljiMAVob/wxVdzCNrYd7RgwvW49bsYwrHkeyshD0QRnxQWHU5gOnu5efMZOoFMyeY5v+LsO1fNbeTN1nrwyrCUeoEUf88hVnjSodAY10FrF8L3G5jtFKJT/dx/17GqnT5zREke50EYBehowOx42v8YlcNXXSRjBYkhnkamihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024092; c=relaxed/simple;
	bh=uf5lyw4AUyS8ftD2FcoTbB+BC47e8kfLHSii3wS8DGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klNbYD0PAWd4mxJObiOq57CKsR+VC6QPSYEvWxcummUlFZ9HEQwpoc8hL57fpYfwt6m4xUpndgwLJ3Rb2MaRjJy858gQKDk2iImZmZmTKf8F6HF3YyCdlbHs+IFh9fVU+SW04r1cec7RBknDTlXd3v6RTgyEN1QqJX28pQPHuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2J5TFQl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2J5TFQl"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee147baf7bso43441cf.1
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 14:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764024090; x=1764628890; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf5lyw4AUyS8ftD2FcoTbB+BC47e8kfLHSii3wS8DGA=;
        b=I2J5TFQlFRpoQPUtzYuDKxZjnzhl3gTFRs2kzoCg4UW60Lj0cnEpvGB3R7llz8ZoV3
         i86OEsN/d6sz0vobhi7GzEDg+bwkICaGIpY05b/QN+CMLqxkBvIEUtcSiGyCNMep35Rz
         ATVRJMnnn/SRawkYD06PVzO0pB7OSvZaPGThnYPXJ01JNlwYfQi7J+y2xNH5J2y9nbu9
         fV64KwqAlA6AuMLruTGWk0eVeMaqL8EwQtMlHJmPzTSRi7+9w9eM1WTRqmX4Zxttgdh/
         oGiclmF/tqkH639N/U4EC1Qm0iiCBxTpiP20m2XloaRBbh3KYQqfGlsH6f+/PHb8Is1f
         hr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764024090; x=1764628890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uf5lyw4AUyS8ftD2FcoTbB+BC47e8kfLHSii3wS8DGA=;
        b=P4DYuEhqXktrkJ1oFOWuGf4S9ZW0IdFk4HIguq9G0av5bQQrPeNisc9kIhg2uekItT
         wsd2fAVN6ZoNi543WMWgUwl3IjflZ/oTXQCbDCXe61xM2ox80W726F4/6lalwoFyrlyT
         Xe62RCNEkK+uHr4Ybe2OoX5lkSb7ilqAPrtZg32QYoFrzg1RiOzku9J/AFjWjW1VqlRe
         TfU67HoPBQWcn2eL7+0UFVNs9zXAHBhAc4TX20RZw8RbZSL6SItNBDf/56MifTaW03mM
         +/1SCMTWLw1pSgSoAQRUIuYAj0CRaPbrQl5v4/yz3H+UaxPq6uECuW9+yhd9JvnhTBDp
         odXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ew80YWPDs1TRuRA4G+wAtinQDml+lwYDUYiDkOhSO/KPnJU6AcPWz/7+UicnwWJZLMcOpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yztc/F0rIoQ8Bm5gMqSMKewccEapyXBn+6ADaDtA7ZmLr6yGvMu
	wbw/A8uJHekUZdC2w8rn4KDeEs8rBAbIO1TVybFwukFIkraM2AnIW1ecpSg4CGBQlYKBgLBvsl5
	kl0Q41omm66El0wS/M9TBAGe0LD6m6dqCmbdV3Omr
X-Gm-Gg: ASbGncuD8myxydIHL9RCRqwVxuewH+94HQnWbQvBJTi8bedEGR3JjmnOMPrQrkMlw59
	Yn/ozOnnxb0tbufhBeNKF6tZaEvgyHje9WSqE7G8/A1dcVyQL95DXFK38zyh/WT274QsHQGWmdk
	j0kxx0RMC6w+1OI/EPWqI+GWO5Pb25y65CeYUWqF02O2/CZvz3ZK/Hn3kSoRXpou+J1sq57l9pb
	dJxqqqczG3WdE6KefmZ4lBM75CQAV6W+cmkDRf2oQ2TxHUK4z1k4DNrENM+1PY5c/0KYvaY
X-Google-Smtp-Source: AGHT+IFOQkAxR4ULJFB4RScZMAEAUkNKfmbfyajpBFtB8b5ePnIrEnIzK+kruSK7VAVgeojPUj2lG/e5h+FFPP490nY=
X-Received: by 2002:a05:622a:11cc:b0:4e8:85ac:f7a7 with SMTP id
 d75a77b69052e-4efbe8f05d2mr254121cf.9.1764024089358; Mon, 24 Nov 2025
 14:41:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240423174114.526704-1-jacob.jun.pan@linux.intel.com>
 <20251124104836.3685533-1-lrizzo@google.com> <87a50bi7e0.ffs@tglx>
In-Reply-To: <87a50bi7e0.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 24 Nov 2025 23:40:51 +0100
X-Gm-Features: AWmQ_bm3FHGHdRVq_GUSGfDS_8Fd7xuBa7l-CHqDp7boVmlt7n6cClYUopURHS0
Message-ID: <CAMOZA0+Bo--AeyrkMHJv384kdANLbWKc6ieubkiwyQD-r44CtA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Coalesced Interrupt Delivery with posted MSI
To: Thomas Gleixner <tglx@linutronix.de>
Cc: jacob.jun.pan@linux.intel.com, rizzo.unipi@gmail.com, seanjc@google.com, 
	a.manzanares@samsung.com, acme@kernel.org, axboe@kernel.dk, 
	baolu.lu@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com, 
	dave.hansen@intel.com, guang.zeng@intel.com, helgaas@kernel.org, 
	hpa@zytor.com, iommu@lists.linux.dev, jim.harris@samsung.com, joro@8bytes.org, 
	kevin.tian@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maz@kernel.org, mingo@redhat.com, oliver.sang@intel.com, 
	paul.e.luse@intel.com, peterz@infradead.org, robert.hoo.linux@gmail.com, 
	robin.murphy@arm.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 7:59=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Mon, Nov 24 2025 at 10:48, Luigi Rizzo wrote:
> > I think there is an inherent race condition when intremap=3Dposted_msi
> > and the IRQ subsystem resends pending interrupts via __apic_send_IPI().
> > ...
...
> It sends an IPI to the actual vector, which invokes the handler
> directly. That works only once because the remap interrupt chip does not
> issue an EOI, so the vector becomes stale.... Clearly nobody ever tested
> that code.

Thanks for clarifying that the problem is the missing EOI.

> ...
> So instead of playing games with the PIR, this can be actually solved
> for both cases. See below.

Thanks, I verified that your patch fixes the problem (and also works
with software moderation)

Tested-by: Luigi Rizzo <lrizzo@google.com>

cheers
luigi
