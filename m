Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DC347B4
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709097; cv=none; b=KEws6rwuNfqSskKbkUpole7VVwF6U4I94VA1HxIB+vAgY1w7wyrHJqxgrGh0eyA7fWn4M2aqpaEYzmOpPAgib9W5OeJeJ5Fvq0X11CpJkWGM7AJheHE3DuyAI3XjOQwd5LUe7lPQ7cpAC9Hw7uRno57Bq9Bc8fDpxLZ0WTgN2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709097; c=relaxed/simple;
	bh=9I2BO1z48IQWxNX0txc+oqBikBJBOzio/TgbiFEkiPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/NmSDmTQwZWFDPAwJcs2G8xkJj4nAbXyYQerJ6Psq2owpdDU+YPnMAt2/HLgM5624l9I0WDT0l3Vxh3GwXYB9GXJx1NZx59W7Hu78YWpEkm6xMNiz2HVdFGly22+Ah3bE9/eVjgJaCEFXpia21lnWWd0rEVRTnMmgtCYG/MSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D07aunMQ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D07aunMQ"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5fcef5dc742so396490eaf.1
        for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 18:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740709095; x=1741313895; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I2BO1z48IQWxNX0txc+oqBikBJBOzio/TgbiFEkiPI=;
        b=D07aunMQ+K7giIVxPVUA51snPgiNkWK9w4Cn4cxtVKTchDm1Ectn1/Seoez42ZmgW6
         1MFZNlAroDzrt/DOeChU5FXe2L//DBrtmUIpCOOLFib1Rn7Q9RvZ7khNIMSHHtVGz1Wf
         7569xCyOkz4mOzpI9fadZfE6py7tUA4nln+2BUv6pNRnX2DGLe5HBO2lcdhQ0aD1yrn6
         Qp2nkYcKNRHKVqr5OYuaHrcIMPSLPofnyw0GLoJaA1pmFsdtdWfe7Fl0bRdcFGo0YYRN
         ogM14d/KwdYO3U/cfwtAqD+Xc5W5TLHHn7DFizDKo08MGK4BuDvpyWZFd2RmN2azLnkY
         Lngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740709095; x=1741313895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I2BO1z48IQWxNX0txc+oqBikBJBOzio/TgbiFEkiPI=;
        b=vEJGHJHfu+tTorurvGQBcD0pytCAeBIoaFvK4uGBvFNLFTMImnRGpMmkTgGQTd90zq
         G5lHPQSGg0k5oJt2/HMvZhiEGffqOOsi48QOy67ZTC1hn1mak3l5Ay8HgxVzFw6J6gs4
         WMtOoXL9oUhvcltROmCavdUh/qDkBXheLm0IryWe8NjuCUmCxmx1I4o/lhCgEWbK7Snc
         4vqao1a0CaGqfBmnVGreqLlqj6KDmXOiaN2tL4hZXf0/MtmsR0ucKsKBKCfQfKsRtmNJ
         YrnKGB5f1nPY4O0AR8OMybvp1kWUPqRKWh4kJ/UArHXJFXSsPXnXo7hPf1Fe+gIq8PtO
         7KLA==
X-Forwarded-Encrypted: i=1; AJvYcCWg/mDcppdN2ph3QETQrhRNgZ87bVb40qTUKo42/OjN89ODyCTBqkYTtcVN0D6nmIBZifAftw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkDhPFWAiudllb5WUURsAOJn9C/tQO6b00eQmIGbBe7798Ecqu
	xkRMHf7yyQmogmD1Ivfxtb4/a3B0iA9/b4E4hbPGGC5ghA4OlpGWJvIAfYUINhsvR5umFaKSJAC
	aBt/KzZNoOLE0/XmVoEG/PUftglkMI3lLnlDSCQ==
X-Gm-Gg: ASbGncvDZQzzEuC34IXrdFc/5c6mURlkHqjM03PvD8X0/Js+fwjhm71XUc5Cn+04w6X
	IH+DeoD5fDV8vqWZEvv4R2qve4yBz8AKITFUG4rJPpMNANQ1k1JK+raGCKmzor1BsV80JZ1bAXx
	FtEJkpzR+hHG8Q/bcQEDqv
X-Google-Smtp-Source: AGHT+IFT/QnwoDQvtYuT7m4lvtyEAzFxYBM3HOFpWcJkIVa+DG02d0v1yu8bwqEDMtcanFsHk2vuA7kNme21ha5fMks=
X-Received: by 2002:a05:6870:793:b0:29e:2caf:8cc with SMTP id
 586e51a60fabf-2c1787befc0mr744505fac.37.1740709094796; Thu, 27 Feb 2025
 18:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com> <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca> <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com> <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
 <20250226130423.GF5011@ziepe.ca> <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>
 <20250227203855.GI5011@ziepe.ca> <7bafd132-6a82-4313-b25f-92fc16faf917@gmail.com>
In-Reply-To: <7bafd132-6a82-4313-b25f-92fc16faf917@gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 28 Feb 2025 10:18:03 +0800
X-Gm-Features: AQ5f1JpaPQbUQXoxOSSLzPZKwS5b9QorWs5Qrw6FpWVvDUtkbOCPSMcOEeJSFoQ
Message-ID: <CAEEQ3w=1H7o7G56hYmwEGErfuFX-2nG=wesJYL7p0dDqLv_rpw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ethan Zhao <haifeng.zhao@linux.intel.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, dwmw2@infradead.org, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

On Fri, Feb 28, 2025 at 8:51=E2=80=AFAM Ethan Zhao <etzhao1900@gmail.com> w=
rote:
>
>
> On 2/28/2025 4:38 AM, Jason Gunthorpe wrote:
> > On Thu, Feb 27, 2025 at 08:40:31AM +0800, Ethan Zhao wrote:
> >> On 2/26/2025 9:04 PM, Jason Gunthorpe wrote:
> >>> On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
> >>>>> Provided the system does not respond to those events when this func=
tion
> >>>>> is called, it's fine to remove the lock.
> >>>> I agree.
> >>> I think it is running the destruction of the iommu far too late in th=
e
> >>> process. IMHO it should be done after all the drivers have been
> >>> shutdown, before the CPUs go single threaded.
> >> Hmm... so far it is fine, the iommu_shutdown only has a little work to
> >> do, disable the translation, the PMR disabling is just backward compat=
ible,
> >> was deprecated already. if we move it to one position where all CPUs a=
re
> >> cycling, we don't know what kind of user-land tasks left there (i.e. r=
eboot -f
> >> case), it would be hard to full-fill the requirement of Intel VT-d, no=
 ongoing
> >> transaction there on hardware when issue the translation disabling com=
mand.
> > There is no guarentee device dma is halted anyhow at this point either.
>
> The -f option to reboot command, suggests data corruption possibility.alt=
hough
>
> the IOMMU strives not to cross the transaction boundaries of its address
> translation.
>
> over all, we should make the reboot -f function works. not to hang
> there. meanwhile
>
> it doesn't break anything else so far.

patch v1:
if (!down_write_trylock(&dmar_global_lock))
return;

 patch v3:
/* All other CPUs were brought down, hotplug interrupts were disabled,
no lock and RCU checking needed anymore*/
list_for_each_entry(drhd, &dmar_drhd_units, list) {
iommu =3D drhd->iommu;
/* Disable PMRs explicitly here. */
iommu_disable_protect_mem_regions(iommu);
iommu_disable_translation(iommu);
}

Since we can remove down_write/up_write, it indicates that during the
IOMMU shutdown process, we are not particularly concerned about
whether others are accessing the critical section. Therefore, it can
be understood that Patch v1 can successfully acquire the lock and
proceed with subsequent operations. From this perspective, Patch v1 is
reasonable and can prevent situations where there is an actual owner
of dmar_global_lock, even though it does not perform a real IOMMU
shutdown.

However, if the IOMMU shutdown truly fails, IOMMU_WAIT_OP will trigger
a panic(). Removing down_write/up_write offers better maintainability
than Patch v1 (as we can retrieve the cause from the vmcore). But this
might not be significant, since the reboot could have been completed
successfully, and the occurrence of panic() might instead cause
confusion.

In summary, it is essential to complete the reboot action here rather
than causing the system to hang. So, which do you prefer, v1 or v3?


>
> Thanks,
>
> Ethan
>
> >
> > Jason

Thanks,
Yunhui
