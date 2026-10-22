Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691840;
	b=zOjAfCZ6NQ1K/UR9zYoGU/QgR//u5kqaXtRO/Mp2Kr1vF+S/uPc/4NP7ujcapeolPID+
	 I2U57z3sJ4PxjeQ/0baV5jCtm6xN3PwdNkedm8MpuMneJOnEB/b9CSlq6jQCsRY1ccE5I
	 8CK7SOVISm/ZHhkEMJBERUQ0o1e+XEKbi19TySedvNWOUzP38wc96Km06qk8JwYKEx+M/
	 Z2hNB6CdG2ANbrLfbMQ+VIi3LIYPyHaidsGr9KjOcplR2o81hVcRDoJZCtPW51orSqauo
	 gHuRxVnyRho08nHde4MP7ia4R4toJDtv6L/AwqaFotSlLaYKBDGEZyZjlojzukVYD6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=8EgRcbuDfKORZQpY0utOTTMffHlpWo5to8q3utLizKM=;
	b=2hPGOGelVFCxlmO/BUMESz6P2LdOtJid9Cb1qnqlYIo+ycDZB6AnndsS5bQwaJ+M/SBS
	 7a704gQy/6Qhnh7AIc65qs5rIK7RqwJgIXtFtnIwkla4BidtuW7bx1xOucvktniqrA3fh
	 8bEx8qoV3XVU95F3XhOVpUnXLNrdANOeEgQmcSDoH8lYEnXt73fw52Mj4thf04SMDdUsv
	 CIRBMF8O3wHyf28tHTohi8FgCmCuU76QXK18NW1+5cynSUNCawScLk8v2qZIjZ50f5RLt
	 NO0Q0zIgnDn+oQ97ZTlHegw75kS08cyd6o3rYCY10wqV24I/gWJZIe9X9yFk+St7XmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="UUZGv/9a";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E4606A31D
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 17:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687E4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UUZGv/9a
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ea4f255ba1so26445ad.2
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792691840; x=1793296640; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8EgRcbuDfKORZQpY0utOTTMffHlpWo5to8q3utLizKM=;
        b=UUZGv/9ajUqdLGXLn0MF+j0DIrUdv8Q7Li+z69ilh3CAiUHlVGTVT0ngNGq3ZqcG5n
         KbKwfFscFEPP1eESah+78UrMNWU449iGN5iXXu1QzMVHcI0FMUJPfGgJDzkicuVcBctE
         JKXJ+/hDpVOPlh0VIEG7ONZGxBv/oojEuYwytCX7tdvy/S3gjKacyLZ7QSF5eYpl18dG
         mrRQ0ne7/h206gEbOwockKJIKgRmw6WITfKJz6LDJZSOkINYqX9SnEKplKB2u6AZUZKh
         XUuTton8GpiT28VvCzAkYmXhTneuqBS4GKsGNqt6IFYQ4A8mkWJ0MK6lIwahASv0PRv4
         GMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691840; x=1793296640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8EgRcbuDfKORZQpY0utOTTMffHlpWo5to8q3utLizKM=;
        b=Eces0ppKrJCsgo7q7jXcvpRndKXO+VL/WdLLB+aP4uQo3yO+liR1EsN9/oUity8Koq
         +eKVWgO9cL89SV0Or6UjtoMEuiQNPftzdtejKL0fb6f3cCfcoN2TUleS7m/4j5msCO1h
         bH9dzuGevX9gTr1mMpvm45E8L1vvn5uzFZN8eLlsu75vyC1qQMGNv+VCsthj8dS8huPD
         RqLssO0t52RYtB78xYyuopEu7MVwB+atXcYCNr8GglQK9HCM6LV0KiYOrEtmT2VetT6G
         AFEPR59i2obd4xaIFd+uxUZFU/hGfwBQDiiyDpaErjMtB/vlMEeeuSOIW7doNE10Z0M0
         PYLg==
X-Forwarded-Encrypted: i=1; AKwUvBw7sQZpAEuU7dRHDHGexjh7owzvPKRnXx2Aa8wpb8/SzBSSSurAhEccP59gLM+2MRS0XmHz1A==@lists.linux.dev
X-Gm-Message-State: AFq9FYIX61t/dywEz7858kUOmfIqaCXK/e4c31iC/IV6o0rmvaYoY4OX
	On6VqAYLpGm0Z21On6EVQ5ly3pFD1YcHg8fmHwKz0xqPDfUnhVMidzKO/tPS6Kj8Wg==
X-Gm-Gg: AYBFou1/VMYKOIMq7fEaWIxaeQjJNGO7WWtidSCMM1n8BRklNHQyr0PPIh9qGBQMrN2
	TwQin25a/bKaAuiDbR3b0LfG2UluAB17xUBraw0hktCiSthZDYDP+fXQG7S/njYycwc5T/SSooY
	+LtH4XN8lU43KZh3PRqqSlbwdDG85b0Jw8TGOq5/kQof8b8KXjvMj1nX+gHNA54yCFP7a0CXkNL
	K+9uFPmWsBdjlNVytG7aMK78XyoXjItH1GJCxgZmTUp8khlCTnKb1keQoGj06QS36KkyNOeUFpx
	exW1mvGJHka4UZZhT+jBmnh3t+r3+lBBbvxYyH/aOi8ZsPNq8torPCq06WV9xu2Cub/V51j6L1c
	SSfj249bnB1VdwtHBygPqhe0beISsJquow8Y/DgxQoFNgw8ivr1XxPmCinl4VloR4RN/7cw/jZl
	9amtPwNjk+anQEf3ePM600PWJuoBGRkUZtx+BkzvUwVSX4ZWX7JZXu6E05ovW/yC+Tt6JETo0Pt
	CY1oa53UjQVQE2qycsgiTnId6+mbjF1oB5+XzS3bDre6MRAAO2lrn7drbZ/xPBtYdEpTa/L1HXk
	okkBR6ixW7vNNqnBsolDPw==
X-Received: by 2002:a17:903:19ef:b0:2e9:61bf:6591 with SMTP id d9443c01a7336-2ea7c33be70mr1491705ad.45.1792691839016;
        Thu, 22 Oct 2026 10:57:19 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b34dadbsm1687675ad.26.2026.10.22.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:57:18 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:57:15 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Tarun Sahu <tarunsahu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in
 the preserve ioctl
Message-ID: <atpOe-blcgW-uDd4@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-3-tarunsahu@google.com>
 <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com>
 <atlEdhPjlyTPDWmG@google.com>
 <CA+CK2bAxgtx2gZ-UE2HqwAU8=h9K5RE3xozBs1njgLo1-CaPvA@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAxgtx2gZ-UE2HqwAU8=h9K5RE3xozBs1njgLo1-CaPvA@mail.gmail.com>

On 2026-10-21 09:14 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 7:02 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On 2026-10-21 01:17 PM, Pasha Tatashin wrote:
> > > On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> > > >
> > > > Currently luo_preserve_file() iterates over luo_file_handler_list and
> > > > picks the first registered handler whose .can_preserve() callback
> > > > returns true. When a subsystem introduces a new, backwards-incompatible
> > > > file handler alongside an existing one for the same file type, userspace
> > > > has no way to choose which handler preserves a file descriptor, nor can
> > > > the kernel keep the existing rollback-safe handler as the default while
> > > > allowing callers to opt into the new handler.
> > >
> > > That is not how it will work. If we are in the .can_preserve() call,
> > > it means the user has already decided which file handlers to use. We
> > > need to do that before any preservation happens; otherwise, we could
> > > run into conflicts on FLBs i.e. FH of different version require
> > > different FLBs.
> > >
> > > Therefore, there should be a luoctl call (i.e via a new ioctl to set
> > > compatability) that provides the kernel with the specs file of the
> > > target kernel we are updating to, allowing the kernel to select the
> > > compatible file handlers. Since .can_preserve() is called when the
> > > user is already preserving files, the specification must have already
> > > been supplied, or the kernel should fall back to using the default
> > > (i.e., latest) file handlers.
> >
> > I don't think that is the right direction. IMO the kernel should not be
> > choosing which file handler to use, userspace should be. If userspace
> > gets it wrong and chooses a file handler the next kernel does not
> > support, that's on them.
> >
> > The problem with the kernel making a decision about file handlers is
> > then userspace does not know what arguments to pass in. We are adding
> > custom per-file handler arguments to PRESERVE_FD and RETRIEVE_FD. If the
> > kernel is picking which file handler to use, say for a memfd, then
> > userspace doesn't know which arguments to pass in.
> 
> It is not the kernel deciding on its own which handler to use; it is
> the system admin (or host orchestrator) that configures LUO before the
> LU process starts, because the sysadmin knows what kernel we are
> rebooting into and the LUO specs of that target kernel. Meanwhile, the
> process calling PRESERVE_FD (e.g., a VMM) only knows about its own FDs
> and should not have to track target kernel serialization versions.
> 
> Also, the PRESERVE_FD and RETRIEVE_FD arguments are uABI tied to the
> FD type, not to a specific internal handler version. They are stable,
> and we can expand them the same way any ioctl argument is expanded
> (via size and flags), without ever shrinking or breaking them. We
> should not play the game of providing completely different uABI
> argument structs for different versions of a file handler. If a caller
> passes a new feature in the uABI args that the currently configured
> file handler version does not support, PRESERVE_FD simply returns
> -EOPNOTSUPP, just like any other extensible ioctl.

If we require that PRESERVE_FD and RETRIEVE_FD uAPI is stable across
different file handlers for the same file type, then my concern is
resolved.

> More generally, we are rebooting the host into a single target kernel,
> so compatibility is a session-level property, not a per-FD property.
> If we need an upfront global ioctl anyway, configuring the target
> compatibility upfront in one place is much cleaner than exposing FLBs
> to userspace and splitting version selection between a global ioctl
> and per-FD PRESERVE_FD calls.

That's a good point. Ok let's not do per-FD FH selection.
