Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585B4C043E
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579838; cv=none; b=O9l/Go6qUiMU/m7eQlTfzWyFKVbebicsh72U7/wI/OoyKVG/QlVGq7AKL5M7HfuGCx0RgT7o8LBgxRj68bJ5AoPbuDFeG+I8OJkoj2LO6DVkLV9PgTeH8b+4Sn86YEZfodCKiHfT3FyZHwSFJYBEhWEtrTDOgqnmujwIG0Sp3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579838; c=relaxed/simple;
	bh=SDtsOGmR30DOkGPUnsFWNAvITpex492ogWrV8biYoYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HsmjJa3nTMkvv/t74zqYT1UvavZLt8CmaZh+Uh43dfUWir6KUVRkjOqdlLyymUwzBloCYAVYTSprzBR1G/fplJn0PVGyhnrcdm7JEu3KDM2VXJSu53agk5xWcWv4h8gmlZA3cvUUKj/R1yLXQ/mI2VycCtEGx/1tj/gjNLG2zss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ap7NMipr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ap7NMipr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so69931665ad.1
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778579836; x=1779184636; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0zdi/e3l+wKGFxp1TktMR4vbugjI/Nwa6alnPNxTnY=;
        b=ap7NMiprmBvKPreYVHA/NFxRiE1oitXFkudjGbHshmtS6waI80nb3737cH08jIgZZ6
         ndqb2CEcrYCZ4SMCaLQK322GBXB1k97Ibuv7Oty9Fu4PG/yEwy50xgvvROiijyAhK3bo
         tUompddkYHFWlQCiS2Ip5ZfgPHty/hQN1WALgDiBM8jW7yF6B0oYIig6NO8S4mjWQ3wy
         kiP1yTkr3JxTuMTb5QabodIXZUnPt0OW88Eadi7TkQC6iokXPDoC99CNBaVmqGoHrHS4
         DO9bjGKnbNFtw22VBvsMgamyPTmrAM/H+36Qq9C0JHAtvgX7lpkiKiSuNDa8ml4EdVOl
         ZtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579836; x=1779184636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0zdi/e3l+wKGFxp1TktMR4vbugjI/Nwa6alnPNxTnY=;
        b=qYMoNbppDjLrXdbkcRM8c5juTy/51sSBBr4ycrcPpDIV6KYtBtXc/UCwWuAtqyez0q
         Hg8ozjz9aaFq1iomfSQCkmZgEXPaznsTIxEANy+uhBrAfEDwW6dreNUYersUqDD6sZc2
         be+XnCJCHWCK1PP1nAp8SLcpAq5KkJpSum8vVLEd+BIE8NwuqrvrRTSl+h4BzVO1iefh
         JmtvdsAR44IU7EpGhZhTrj6+/QSfwNEcFmgDn79JPc5IAkKxJhr9DarsWCTQhbEizzO/
         X79mtl4cKvcOWPwTNSYKdoS3IF8pJvvzn19AnBYzzlA74wrYchjdv4h/y3UkIof5jgQh
         5Czg==
X-Forwarded-Encrypted: i=1; AFNElJ+uB5of3h+FZpAqKVlIj+27FG9PF+MPWKZuA9nCrEzEjR74UEEo+Q2WrzruvH640f0ds1Sytg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxac/L0fFI5VZN7b3rI36+Fv9Ibn+Rqoo/1TOO3rnaMRGIu9zwn
	o6YBoRWqbJnq4UJoUF+scPjrRCl+yu2kjKuTBh+MYAtF39CEr4IMAXQU/LwhZtgDNePIgYCjAFN
	FtUhUkf7mmzraLLoppK/lo7c8UA==
X-Received: from plsr2.prod.google.com ([2002:a17:902:be02:b0:2b2:48d8:c695])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e552:b0:2b2:5840:809c with SMTP id d9443c01a7336-2bc7a97bd6bmr157227255ad.1.1778579835925;
 Tue, 12 May 2026 02:57:15 -0700 (PDT)
Date: Tue, 12 May 2026 09:57:14 +0000
In-Reply-To: <20260511132128.GM9285@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260511132128.GM9285@ziepe.ca>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512095714.2518097-1-joonwonkang@google.com>
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: jgg@ziepe.ca, robin.murphy@arm.com
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com, 
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, joonwonkang@google.com, 
	joro@8bytes.org, jpb@kernel.org, kees@kernel.org, kevin.tian@intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, praan@google.com, smostafa@google.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason and Robin, thanks a lot for sharing your insights! Could you help
to answer the further questions below? or just let me know if it is better
to use other channels for them like ARM support.

> On Mon, May 11, 2026 at 01:39:06PM +0100, Robin Murphy wrote:
> > On 2026-05-09 6:10 pm, Jason Gunthorpe wrote:
> > > On Thu, May 07, 2026 at 09:58:51AM +0000, Joonwon Kang wrote:
> > > 
> > > > By "similar instruction" on ARM, I guess you mean ST64BV0, which fetches
> > > > the bottom 32 bits data from ACCDATA_EL1. Please let me know if you meant
> > > > others as it will matter. If ST64BV0 is supported on ARM, however, it
> > > > would mean that ST64B and ST64BV are also supported already according to
> > > > the ID_AA64ISAR1_EL1's LS64 field. The latter 2 instructions are just to
> > > > atomically store whatever user wants to a memory location without
> > > > referring to ACCDATA_EL1 and all the 3 instructions can be run at EL0. So,
> > > > the userspace driver would have enough capability to designate arbitrary
> > > > PASID as it wants via the latter 2 instructions when communicating with
> > > > multiple devices.
> > > 
> > > IDK exactly what ARM did. IIRC on Intel ENQCMD forms a special
> > > non-posted write TLP and the device can tell the TLP came from ENQCMD
> > > and so it trusts the encoded PASID. ARM has to have done the same
> > > thing - allowing anyone to forge the PASID by using a different
> > > instruction misses the point of the Intel design.
> > 
> > Yes, ACCDATA_EL1 is a privileged register neither writeable nor readable by
> > userspace[1], so it should be functionally equivalent from an SVA point of
> > view.
> 
> There is a bit more going on though, I think that is what Joonwon is
> mentioning by asking about ST64B and ST64BV. I *think* the answer is:
> 
> - ST64B uses a posted write
> - ST64BV can be restricted so EL0 cannot execute it, it uses a
>   non-posted write (AI tells me via EnASR)
> - ST64BV0 can be used by EL0, always uses a non-posted write, and always
>   uses ACCDATA_EL1
> 
> Which is similar to Intel.

Ah, I missed that ST64BV is currently being trapped to EL1 while ST64B is
not [1]. However, I am not sure if the trap is to disallow EL0 to use it.
Can it be instead to pass the response value of the non-posted write to
EL0 while using the EL0-given PASID as-is? If so, I believe EL0 still can
specify arbitrary PASID as it wants via ST64BV.

Since I guess ST64B* instructions are to serve generic purposes not only
for communication with accelerators with SIOV but also with any memory
location or device without SIOV, I am not sure if it is always okay to
make those instructions work the way Jason mentioned.

> The device only processes the PASID from a non-posted write,
> 

Regarding ST64B, are the ARM devices behind ARM SMMU v3 supposed to work
this way too? If not, EL0 can specify arbitrary PASID via ST64B with the
kernel today [1].

[1] https://github.com/torvalds/linux/blob/50897c955902c93ae71c38698abb910525ebdc89/arch/arm64/kernel/cpufeature.c#L3166-L3181

Thanks,
Joonwon Kang
