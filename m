Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5163C6A29
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147935; cv=none; b=OUPwAB08N+j1mBbqqbgDiJlwKaLFwrTMtq2CJOnRTMZqgdsntYOzuIiOcgdEC58kdXC8UqSgPHZpIdswrYTR8uOAgdCp6TJBxf36ypgW8CCxjNGaUZJvMRL1YoK+wfGM3whu/BhwOKhqZAMy1G4jGhhwDWLbDyiMcHCJAZftNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147935; c=relaxed/simple;
	bh=xMLrZlHEoMKQqjUsB4Iq5/Hl6DyHAHS/iyWEMmXHV8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uUhS8aGIND0hGNvaAS/XcjpwuGAvxLOGnLGvhogB+VqnifNH8kfxUze9qWqNccpEpjIu4Qu+r2SJiQIW9pcJgNZGfoVKBIZRT4FmfMRFXpMJ+d5KpgejNomupen59MJkbuuqxn1gPv2rZKstDiurlTm/BRqZZYYRjgUjNKopZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijpKWyy5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijpKWyy5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-362eb03240bso905415a91.3
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778147933; x=1778752733; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv6ESL3sqOkfsUQX3nZNF8lwSawGbrEYEhFUcZ/x1Kc=;
        b=ijpKWyy5p9F7c4+immLX9mNYUKHJ0BK0lZRptPBm50PqUSqak7JrUwcLnNK0YA5Hmh
         Eb61U4HlS3a6lV4osp5ngbrQ2oRWKw1cZYkrG8Y/lWpPuj5wmASbeI6T17OUGMZ8FrUQ
         mA4s8fjMrwtsLjEm5jx2o6ops5UFIYu2i+1bwLG2vDf6wUkbmHC83QGjdfbSpNGQRPq/
         xQ2mgS0ltowPMGzq/tb10tIilgx8dvgzR8j54rfzTexRJe/UtFIAl5dX0PAnlj5WCEgu
         I5+rP1JUaUIECI6zYaNW+Uv8LCKrNdvK/hFOd2z7DvNrnO4aWqNCEjTe2VhvaCVC/pEd
         7UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778147933; x=1778752733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv6ESL3sqOkfsUQX3nZNF8lwSawGbrEYEhFUcZ/x1Kc=;
        b=ckU5Br5zs2p/cezLl6y2Uz9I3uarDiJ/0c5RiZS6BXc/i21wlUzujfJAcLD4yWRxtJ
         ZADfIzr6iF2OVbPr/lLMOWjqwx9/W8nfc1TcPe6bAraqS4tj1J9cLWqWBcA/OXoYflfi
         DT1KpaQivu+AefIrctpezdI2ug4hSpnZUcnty84THXCrBzX0n6cUKakdbjLbsUjtiop/
         DV/8zyikvVyfqb7sQGHUkzpgt2Pjn+Nm0d2vX/u3frwJHnxyB3EniR1s7N6SEWK2Z7x/
         3p1xnE0g0OC2eD5uylXdoShpBwE/TUw5qmzxOljCXjlE4MbqL1Kj+0o4eFocKIJ1fVDZ
         /LKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+v6QA5ViQb8PV+oDIRjDw5Tk2JUfUqpi4Dr1vxbxRVN/bFT7vuc+14Ge5JhTXR6hUoxncLg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5WUT2E+F2dZ4uqm9bsx+TOO4gHWDQd4JwybSoLGEorEg7/2w2
	4QuBAsp69R5FDJmyjLASStkIhTzTZXd8rcs5FqiwyEc38JQ/qu2js+vDSxwE4XzgoSnKniH6Nxh
	vaEV3/vkJM3u1/1vXe3WQlkuMQw==
X-Received: from pgac3.prod.google.com ([2002:a05:6a02:2943:b0:c6e:228a:f070])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d88:b0:39b:e710:e2e2 with SMTP id adf61e73a8af0-3aa5ac1ae28mr8112180637.46.1778147932850;
 Thu, 07 May 2026 02:58:52 -0700 (PDT)
Date: Thu,  7 May 2026 09:58:51 +0000
In-Reply-To: <20260424133953.GY3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260424133953.GY3611611@ziepe.ca>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260507095851.3220765-1-joonwonkang@google.com>
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: jgg@ziepe.ca
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com, 
	baolu.lu@linux.intel.com, iommu@lists.linux.dev, joonwonkang@google.com, 
	joro@8bytes.org, jpb@kernel.org, kees@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, praan@google.com, robin.murphy@arm.com, 
	smostafa@google.com, will@kernel.org, jacob.jun.pan@linux.intel.com, 
	easwar.hariharan@linux.microsoft.com, kevin.tian@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Jason, thank you for your review and sorry for the late reply.

> On Fri, Apr 24, 2026 at 08:53:39AM +0000, Joonwon Kang wrote:
> > For SVA, the IOMMU core always allocates PASID from the global PASID
> > space. The use of this global PASID space comes from the limitation of
> > the ENQCMD instruction in Intel CPUs that it fetches its PASID operand
> > from IA32_PASID, which is per-task.
> 
> That's right, and all the iommu drivers should have no issue with
> per-device pasid or they are not following the API contract..  I
> believe that has been taking care of already.
> 

Thanks for this info that every IOMMU should support per-device PASID
space already, i.e. each device behind the IOMMU can have its own PASID
space.

Let me clarify my understanding first to prevent future confusion.

The reason of using the global PASID space in the first place, i.e.
`iommu_global_pasid_ida`, is to support the case where a userspace driver
wants to communicate with multiple devices using the ENQCMD instruction
without kernel's intervention. Since the ENQCMD instruction fetches PASID
from the per-process IA32_PASID, the userspace driver could not use a
different PASID for each device. If a syscall had been provided to change
the process' current PASID, however, we might have been able to get rid of
the use of the global PASID space, although it may cause other issues and
require research on feasibility and effectiveness.

Please let me know if there is any other reason of the global PASID space
use that the team considered back then.

> So, I don't think this is an iommu driver capability.
> 
> Instead, you have to decide if the PASID is per device or not based on
> if the system will use ENQCMD or any similar instruction.  I
> understand ARM has introduced a similar instruction.
> 

By "similar instruction" on ARM, I guess you mean ST64BV0, which fetches
the bottom 32 bits data from ACCDATA_EL1. Please let me know if you meant
others as it will matter. If ST64BV0 is supported on ARM, however, it
would mean that ST64B and ST64BV are also supported already according to
the ID_AA64ISAR1_EL1's LS64 field. The latter 2 instructions are just to
atomically store whatever user wants to a memory location without
referring to ACCDATA_EL1 and all the 3 instructions can be run at EL0. So,
the userspace driver would have enough capability to designate arbitrary
PASID as it wants via the latter 2 instructions when communicating with
multiple devices.

> So you may be better off with some kind of 'arch has enqcmd like
> instruction' to control this instead of involving the iommu driver.
> 

If the above makes sense, I guess we could lift the use of the global
PASID space on ARM unconditionally. What do you think?

> > - The device is not a PCIe device.
> > - The device is to use SVA.
> > - The supported SSID/PASID space is very small for the device; only 1 to
> >   3 SSIDs are supported.
> 
> Yuk
> 
> > With this setup, when other modules have allocated all the PASIDs that
> > our device is expected to use from the global PASID space via APIs like
> > iommu_alloc_global_pasid() or iommu_sva_bind_device(), SVA binding to
> > our device fails due to the lack of available PASIDs.
> 
> So you have multiple SVA using devices as well? Or multiple instances
> of the same device?

We have multiple processes and a single device, those processes want to
do SVA with the same device, and only one process will do SVA with the
device at a time. Though, the problem occurs even when irrelevant
processes allocate the PASIDs from the global PASID space for their own
irrelevant purposes.

Thanks,
Joonwon Kang
