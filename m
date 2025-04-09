Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CF2AE89
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190147; cv=none; b=tEbTe0wBRZsTVOySwZICVh9k/JZyBTqKqKN60zVcjfzsYSEcrulKnSoqeWE/0VSXaSdnuFwklXNyef/4iGGgIdz7IEIDVLR7QjrSaVW0U/skM6v4gDOs9zEDKHYQsE4V5yQUJhsnQX1fRqTs+o6QaMwHOC+duw+XC3KB0gD3PDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190147; c=relaxed/simple;
	bh=Ty1pwqrmShrkkSXMYJB/5FbS4/B1OSXP3/4mT9aAsdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ka6/6ViYIYGJL4nprcB029WYYBqdlDIh7+3A6uXlIZaxOKNs0tD/EjKru/lPL9x9ITiG1eIwZ+GLoF6NRR0lZPmuzDvLA7ARRPjxzlqV0vP+uH6Me0gsdjmCmPJ0RYT+xc1SojNVUMqnDy0VLNRAt+4Up+mQ9j4uOsetXE5Dr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+JWoiGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+JWoiGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E7CC4CEE7
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744190146;
	bh=Ty1pwqrmShrkkSXMYJB/5FbS4/B1OSXP3/4mT9aAsdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U+JWoiGnB3Ltj1oq2Lf12BbJStduvwmmIbUpPwE46zLzraulDbpUgoHkBVVxSd8dR
	 xOjYR3O0gjN793iX6J5SWUKGfn+DlCd+uaXBa+XFVfRJqxVnHQLRo7nKYLq9iVeXzp
	 A/XArWDVpftzIr3pQVPG/eHPWRm3RpI0SJr9XSe0gl9SKO/KANIGVe8EcU5X7aFWTa
	 RGiQ2+2WTb/xFNL+o/t7/fYw5Du7FdwDxlEPGS/tMcK8pzaxCTKqVFYH8LIx3xs4J/
	 ErqqLr1eYv8y+gb3UwC3FHhHjttrF/dppMtlQcx4TZpLLNii5sUvwGx1x4OAmCwuw6
	 uOEeyj0DSftjA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54954fa61c9so4703135e87.1
        for <iommu@lists.linux.dev>; Wed, 09 Apr 2025 02:15:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8e8VBzxd3jl20/7mobwnLLndI3Uf0WXMQRkmW/LTIgkzmLH2remTvMoFjWiMezBMtOo5j4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwihFH2V6gIzI9NqxkEMrET1tBvQnLSlcpfojv5g3Jdw9n8rCuG
	DiutjPqz97FxKBsZWe6zi6zB3U6GdK9QXelSto1Sm+9zapf7jQlYkL9kp7ZTR+0I3ObcXMltEmy
	FnNiCmK6h1HFrcunREq1sUulL90o=
X-Google-Smtp-Source: AGHT+IGr6pJEooPeND2WPKwmKzqEYbai9tqpsiAki3uL4C9w+bT2D4fnGON4jq0ew7tRiFB4rDjlDOhGc1mfiwwy2OM=
X-Received: by 2002:a05:6512:3981:b0:545:8a1:5379 with SMTP id
 2adb3069b0e04-54c44561c19mr593775e87.43.1744190145154; Wed, 09 Apr 2025
 02:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
 <20250328230814.2210230-20-ross.philipson@oracle.com> <B41D3199-8054-4B2C-94D6-508D1DE4C8B3@zytor.com>
 <886145d3-a9f2-41f3-a754-253decdb1b4f@oracle.com> <Z_WkaJhel-BYxHeW@char.us.oracle.com>
In-Reply-To: <Z_WkaJhel-BYxHeW@char.us.oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Apr 2025 11:15:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEAZS+839zmpW3WfwvTRMZmRbPYGpEoY=Xj9qFch9J7BA@mail.gmail.com>
X-Gm-Features: ATxdqUF80H-sehwytd1k_ZBdeFEl5wo_O_6zq2xvDwvr3fvlWsrlNSPU8VOuvPk
Message-ID: <CAMj1kXEAZS+839zmpW3WfwvTRMZmRbPYGpEoY=Xj9qFch9J7BA@mail.gmail.com>
Subject: Re: [PATCH v13 19/19] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: ross.philipson@oracle.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 00:35, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> ..snip..
> > > > @@ -925,6 +1014,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> > > >           goto fail;
> > > >   }
> > > >
> > > > +#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
> > > > + /* If a Secure Launch is in progress, this never returns */
> > > > + efi_secure_launch(boot_params);
> > > > +#endif
> > > > +
> > > >   /*
> > > >    * Call the SEV init code while still running with the firmware's
> > > >    * GDT/IDT, so #VC exceptions will be handled by EFI.
> > >
> > > efi_set_u64_form()?
> > >
> > > What the heck is that? If it actually involves two u32 packed into a 64 field, why not simply do two stores?
> > >
> >
> > Well the story is this. The EFI maintainers asked me to use the
> > efi_set_u64_split() type functions (this one splits a u64 into 2 u32). I
> > went to look and there was no function that did the opposite action so I
> > added it. The original function was called efi_set_u64_split() so
> > efi_set_u64_form() was what I came up with. I can name it anything that is
> > desired.
>
> Hey Peter,
>
> Is there anything in particular that needs to be done to this patch?
>

If anyone feels strongly enough about this, we can fix it in a
follow-up patch. The code works as expected, so no need to derail this
series even further.
