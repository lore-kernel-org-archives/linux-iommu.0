Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30235B644
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597502; cv=none; b=iIK5NriiW+AkL9o6+XNjuFzT3+H9DOOcgVxOSACHHH1HMRh6a13ofV7IdlDtHGCu1hWGbzikv+X/kyUad3mq0FJvBZbzfcNTXfAZDu49SUkElbaxYXJLUvjy5R/MYcXtDnn2xH6b+JYK9hIaCKQammwCbI6SC25CAn/aLuwUEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597502; c=relaxed/simple;
	bh=pwHPn0uSXjalVS1fYzKE8yuC0M4roMdbtLUDDT/7QaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WLif1yt+25PNatVmqMF2JDx6py3RfajJq7r8kBsjkebcLlinR3xZJi/PUZjeD72hhm1cRb/OehnoFW7oY+PuRXBV6TMyZWOrG9tM5eq9IWweQ2mq5AVrkjbOZP/6cSdSUy07ESZ3OqJL5A5iwusZl/DMvjykW44Sp8JyD0nFpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrFAoYiJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrFAoYiJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba224c3ffdso80560195ad.0
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778597500; x=1779202300; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxuiWLL/PSSpmcGZYa/jLPGBLLlN9600U6sYLEUkki8=;
        b=VrFAoYiJNyFIhBbmWg43R83wSClQlioe3Ayt9Kgu0viTOMnziuu8QTlC6VamkAHatV
         N4uN75EfNQArp5b6R0buuWGBCQ2hsAwLpciA+jhlQ5xo2LbxDBs+ZDppJY2aXthGNg1I
         uF8II0/uWB0JTRuXMHcz88n6YSxCeO/aFKq/NYYGC312r2MAiXLWqTc2i8SSUhIkEbWN
         5BF//GRaK0rxaaMTdyffYwSV6KSArGakIZkCRH6ov0dkNBnTmj1dDrNtbIy7no5IF1Cj
         rAK8+UND8/EP2m2L06gbL6papGc7IyWLR7xkgLF6Mjjlb5XGKtYdJCodXoog0ACEvD/6
         J24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597500; x=1779202300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxuiWLL/PSSpmcGZYa/jLPGBLLlN9600U6sYLEUkki8=;
        b=IK6bOwHiZul9boy7WX61NkGVg06tZUYGFuHr9Q2SdweI1jkQ1XEA1ANOzZN1FT7h7t
         kZPkmOq6m7cUEHvDmQ/ew8wwoOO0xto0Y42RD80eMMlA5MmZAy9EBrO9exdR3u1tlJM4
         170mBvk9ZL+Yf4A55DXid5NkT3B4j8FVZS7U7CG9VJd82aZ3YW+egWRctK/RSGdtpzE9
         rZzWUzrWA/6ECw1dx3Atvl6H/438PsbtxdQRhAXPIR1WGeyGAYANRueLjsIMRfJTxLm7
         S9tS9iSyYWT3yLmvyF+YqaAmTRTfBx0y4FX1IWZkWPbVYrT2PGYXaTvOYAhefjjxTZkR
         +jCg==
X-Forwarded-Encrypted: i=1; AFNElJ9/ZfmsIvaATAD1lIOkK44fCGo+sq3SGzy7+ILAVlINdP+t3yQPVsGT18tEBYgl5HArN2nRbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYDKyuUXF85byM3Rf0H3tEjRy8WlL08sPKYl1Yf5ciP3dn4E3y
	xXakfm+NCFZmqN/RQEhc31gG+zYN4oP7OJeyr3BJxrjkIo5ikYW3S5xuPdmMIwb9Pyv7fYkXhVv
	1+PKmAaDg/BnYhA19qWRSkaobaw==
X-Received: from plhs10.prod.google.com ([2002:a17:903:320a:b0:2bc:bb08:92dc])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:847:b0:2ba:fed:7891 with SMTP id d9443c01a7336-2bd01301994mr22890545ad.30.1778597499958;
 Tue, 12 May 2026 07:51:39 -0700 (PDT)
Date: Tue, 12 May 2026 14:51:38 +0000
In-Reply-To: <b95b42c6-4d10-4701-88e2-9991f3773e6a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <b95b42c6-4d10-4701-88e2-9991f3773e6a@arm.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512145138.3414002-1-joonwonkang@google.com>
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: robin.murphy@arm.com
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com, 
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, 
	joonwonkang@google.com, joro@8bytes.org, jpb@kernel.org, kees@kernel.org, 
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com, praan@google.com, 
	smostafa@google.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

> On 12/05/2026 1:40 pm, Jason Gunthorpe wrote:
> > On Tue, May 12, 2026 at 09:57:14AM +0000, Joonwon Kang wrote:
> >>> There is a bit more going on though, I think that is what Joonwon is
> >>> mentioning by asking about ST64B and ST64BV. I *think* the answer is:
> >>>
> >>> - ST64B uses a posted write
> >>> - ST64BV can be restricted so EL0 cannot execute it, it uses a
> >>>    non-posted write (AI tells me via EnASR)
> >>> - ST64BV0 can be used by EL0, always uses a non-posted write, and always
> >>>    uses ACCDATA_EL1
> >>>
> >>> Which is similar to Intel.
> >>
> >> Ah, I missed that ST64BV is currently being trapped to EL1 while ST64B is
> >> not [1]. However, I am not sure if the trap is to disallow EL0 to use it.
> >> Can it be instead to pass the response value of the non-posted write to
> >> EL0 while using the EL0-given PASID as-is? If so, I believe EL0 still can
> >> specify arbitrary PASID as it wants via ST64BV.
> > 
> > I think if an OS implements things this way it is would security
> > broken as far as ENQCMD compatible HW goes.
> 
> Yes, I think it's rather the point that the EnALS/EnASR traps to EL1 
> allow EL1 to sanitise the data that ST64B/ST64BV are sending, and do 
> exactly things like substituting a valid PASID. ST64BV0 offers a way of 
> doing so _without_ needing the overhead of trapping, but conversely that 
> needs the EnAS0 opt-in all the way down to indicate both EL1's awareness 
> of programming ACCDATA_EL1 appropriately and EL2/3's awareness of 
> context-switching it.
> 
> I've not looked closely at what exactly the arm64 arch code is doing 
> today and how well it actually fits the expected ENQCMD usage model, but 
> I can well believe it might need a bit of tweaking.
> 
> Thanks,
> Robin.
> 
> >> Since I guess ST64B* instructions are to serve generic purposes not only
> >> for communication with accelerators with SIOV but also with any memory
> >> location or device without SIOV, I am not sure if it is always okay to
> >> make those instructions work the way Jason mentioned.
> > 
> > The end point has to use the posted vs non-posted write distinction
> > for security.
> > 
> >>> The device only processes the PASID from a non-posted write,
> >>
> >> Regarding ST64B, are the ARM devices behind ARM SMMU v3 supposed to work
> >> this way too? If not, EL0 can specify arbitrary PASID via ST64B with the
> >> kernel today [1].
> > 
> > If you want ENQCMD compatible semantics then yes you have to do all of
> > these things, it is part of the security design.
> > 
> > Jason

Appreciate all your clarifications here. So, my understanding is that if
our system does not support ST64BV and ST64BV0 or if our device does not
distinguish between the posted write and the non-posted write regarding
PASID, then we can lift the use of the global PASID space. Can I say this?

If yes, I will create a new patch which checks for that case. It might as
well add a new device tree property to represent if the device supports
the posted write vs. non-posted write distinction.

Thanks,
Joonwon Kang
