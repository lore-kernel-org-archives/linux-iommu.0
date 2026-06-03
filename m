Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D93D9029
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525126; cv=pass; b=O2NMj1AiAFwyMT/4WjJMKtNyJ4Pe0fM7g2UGAVvkoMJosWOa0Sza4dgygSpvYvxzNUCWc8EQ8Gm/nLBUuQwn8srQsG+RUdosKKfE+SA/5ZQ1mzfo3PdplYUrpp/Ov9oC795EaoEH0jlcdOYb2Fpqt/Tk/hpbxOUVST24/G4LyGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525126; c=relaxed/simple;
	bh=YEnl0CjbpYzEzr2ANZLBuMg/VY55F7qyhRm6Ui2g+y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWWWga49iO5Jzjj8abKxn7t+5yAukj67jOXfyGmE6OGg/UXHZgTJgQBMhrnJcp7kekiq7Nyla+gZoL5b+nYj1mmouIlevVAb6IulaIe1INyAbg/QNvpTasWyqPiwWDuLnaBU/GndLOyt72FTc2xr+e8dhbjJV/5gQDLWTIKu5D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvJ74ox1; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvJ74ox1"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5175d339e8bso203041cf.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 15:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780525124; cv=none;
        d=google.com; s=arc-20240605;
        b=WGxUH+yCoYXNla4mAbfGMdf5HWpJtr6tV1SC1J+t4KVv4NrSZrhPtG8SlMTFBlM/Bs
         dUcHVEgbTNOJ6LMqJC128qRh7Dlp9SD1PL33DErDy7DXNmdQ6YgO5wCMkIGaEZREKbmT
         JsC1iwh5LwwAX6BoyBmIxTGzghLLoMnB57xkQaLU+PEm4QwUnT5+17eGELl6xzpN5tKh
         6yJ44Wr0ehZraQ4UgCHM2TJUoqRf21pRjWD6yreBGUWWLwkRo3vE5efF2wRCYbTGddUN
         eLLyYh3xh5K5LJFjnu5rM0WH/9IIohrndKDa9pAGlKUg+WPj296UGh19xNehjj4ZqFU8
         AKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YEnl0CjbpYzEzr2ANZLBuMg/VY55F7qyhRm6Ui2g+y8=;
        fh=LzKtVEQ1JIuAgC2toWU3z56gbGJiWUjM6UnM6nAef2o=;
        b=T/sYoeZKuM27VcFPzJ3NVj3dT13V4wBbdPAAs9nqRZEXtCpgcSr9vPmz+7askuEPLu
         zcoQosYwyM6c1PXTieCIOVhKcXLLdn2p8a5DKneBifbtj5ojd8n8a/v8BOo3r9KoVCoA
         MIHD9+jcbvjVowDEQeVYgmA5XyJjDc8F7Te/o0k31qXY1at8twuy4G+Y2xYC+RcLNOE/
         uYTXJczR26U7gg963n2Jc95lpK0ad2EeYrMYtHF71spr0UE5NmnyABAfVdrj1gX7VHda
         kqC6Lo8qnKNYjdVtRJ3V1sQICZrfn1PpZVio5vPOyBb13rf7RCdDxhORsA5p+0Owd2BG
         z8ew==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780525124; x=1781129924; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEnl0CjbpYzEzr2ANZLBuMg/VY55F7qyhRm6Ui2g+y8=;
        b=CvJ74ox1tVMF3OYdGNZLd/GXmLfEzVJE/qQMGtG9nZdG/jpHo/hCXnjJiwm/l31hu4
         6Z0BCZaBHY/jnFodY6EE4T9N/83mXP5pBGdCDqOLgDHQktUMYCRkaGcH9bfW0r5v1fzU
         K+HjX7OkpOJ7XHCa29Wt/A06MuurVfO9T7xX9aNyz+dRSrmKSMu36ldgGgPnQhPnK5Vo
         4Ex5LpID85JT0wOxXkoFXN7jxKtrUOHnC0slTG4wAnVvH8CO1JigxVXJP7Pw/JA0idzz
         FgwIy/zmfdq1hZranl85+RRE+ebuoFEAAwfyZyLBITRtRaSWllJWsCaHSKC9UaVCgGIx
         +WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780525124; x=1781129924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YEnl0CjbpYzEzr2ANZLBuMg/VY55F7qyhRm6Ui2g+y8=;
        b=EKbbjR5xWVMNLd9NSUSAUsXOhnuoLtiqw+SLOKyUzz/ClMMTjT/P7ddTJ+oXtQY0GI
         r2vbezkHZVoBx/M0wr6kI2pgomvKrMmibOcHhNKEb57cIqMerUJTLXHqIj99AuTK0qgl
         hcPrlWdbpGQoyQYdDMdcJKn3lP5VQrKsJ336VOrEv3CW4IYorLF2PVuhuewlN360O7XJ
         KBpPfb9IeUsxzFhtHSo4+DFv/LtGuBru8cLgFVxScGj5l9yhgm8Tp8NpuSMys10Y8hTV
         czftGoSMFMISNxpSl9lnU3S/SMGuesCtSiT+S2JcVJXSd7+nd67fNJXJwzNZOTWWL6hY
         pv3A==
X-Forwarded-Encrypted: i=1; AFNElJ+h7vAgrbDB1m90aDSRNaFKQnu+cQRTioIA38kCkqXAeBJgQXz9dSrxrYRpxhZ7OabgWwlGjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHEJNXp6GVpQZ02tjHtyJKLVJBpvIdHe4rJPLbe6U6iywtuW9H
	kmBUZ1UCYvksYiujg4PkX7s0WqYVBNMy6n6nRPaxjZS9Fssjksyf3o2YhVtLbmg1hX4O8vzKFXk
	3I55Sw/nNz4V/LAMuZdmZMi/fowTtZN22amU8fv3+
X-Gm-Gg: Acq92OFHcmot/3OggBbe3wwgO9euXpyxV30lpNvoiXkbGDdb0ZjTTA3WBxOhlWXL86E
	8i/X1VMDnpBQ3WXWJ2yjKPyrsbk8e4vq6L1pWPuIDbv77K5OzhWwk2khBHwAXj8xmV39q9YUseH
	EKQ0LVmJEKjohvo+RpYOUjtm7iFfAsRQLmaUy6j2t+ndxawhobkwC9URQNoUzMg1PCqsT2rFHDd
	diM8hSikCbiKxkNSjJ/3e4hgah7dm1oDV47b0cwJ2QCiWOZsRoK8B9xKL/U4G9Eld3DOG9iSibz
	yURII1/lNPSz5xgRbgzn392xR6y711ATXYGTl3J1bn+JnkXd95C13r5ZZaU=
X-Received: by 2002:a05:622a:1801:b0:516:4f62:85f1 with SMTP id
 d75a77b69052e-51787ab8be4mr3489001cf.22.1780525123437; Wed, 03 Jun 2026
 15:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com> <20260527221407.1756491-11-praan@google.com>
 <ahilX8Za1NRCH3ik@Asurada-Nvidia> <ahi3uY9YZZtR1Lq5@google.com>
In-Reply-To: <ahi3uY9YZZtR1Lq5@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 3 Jun 2026 15:18:32 -0700
X-Gm-Features: AVHnY4ILrsvBe4oXAMQWWdFEm4mbOUJGKXcyXE1-JTxXk1zIsDS0pKvD5RiQwxo
Message-ID: <CAE2F3rDeZe+w7-V6hyJtSOwCj619E5SNtjJjZ1-yu1sVdf=35A@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 2:46=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Thu, May 28, 2026 at 01:28:15PM -0700, Nicolin Chen wrote:
> > On Wed, May 27, 2026 at 10:14:06PM +0000, Pranjal Shrivastava wrote:
> > > TLB and CFG invalidations are
> > > elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG =
via
> > > the arm_smmu_can_elide() helper.
> >
> > All the arm_smmu_can_elide() call sites here would eventually elide
> > the commands in arm_smmu_cmdq_issue_cmdlist() that is already gated
> > by CMDQ_PROD_STOP_FLAG? It doesn't seem necessary to gate again?
>
> While issue_cmdlist() would eventually elide these commands, the
> can_elide() check is necessary to return early during suspension.
>
> This avoids unnecessary stack allocation, cmd building, and spinlock
> contention on the cmdq->lock for threads that are anyway about to be
> elided.
>
> By dropping these requests immediately, we significantly reduce cacheline
> bouncing and contention during unmap storms. Furthermore, the early check
> also allows us to specifically trigger the WARN_ON_ONCE() for broken
> devlinks.

Hi Pranjal,

Have you observed unmap storms in a real-world use case, or is this a
preemptive optimization? I would not expect a high rate of map/unmap
operations while the SMMU is suspended. If a client device calls
iommu_map/iommu_unmap (directly or indirectly), it suggests the client
device is RPM_ACTIVE, meaning the SMMU should be active as well.

I am in favor of removing arm_smmu_can_elide().
