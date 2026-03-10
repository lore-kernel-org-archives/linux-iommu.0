Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2A283FC8
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177406; cv=pass; b=P+2xs/Bj2rr2oU5tDIf2T2VTSmY/F62U/MhIdWzSsfv0/i6pi8sRcfrwLzSIPVju8HTubxPs9c6V0cyVrLeoMAk7EWmcOoZoIp9HHkm97mUNT6sQEdgFxKfnLY31bZmCU1c8fruxNB7YROImdlrXqHJQC9lJt7LLWoYNgJ8ro/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177406; c=relaxed/simple;
	bh=rI9Q8F19UFaWfkz60x+UiUsiB3DX/xTXM3RKZzpLYQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJtKggh5Rqoda9AeGyw8zwnO4t+zfR3R4yGZNvKrHRcBe4tl521VReNJnJ81ZWpJ5oWLosgkP7fygcsqolexlBPzLYdGAbs9yWhwibaeCSMCR0ZgyuOBQFyv9bpHrN88Kke8PUBioAEEcIrcyWCBcK646l8X8cF8DettBIoSVpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qFdryGUo; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFdryGUo"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50906a98ffeso199351cf.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 14:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773177404; cv=none;
        d=google.com; s=arc-20240605;
        b=DMpO65oBE6UtWyIGAEYK06MSpOj/5eJ3oO5ZRhc04l+ZpwwA2/tbsAExHY/cU7hH4u
         XbLAe/TBZvMPRisAEIoqfCjkax0xSXBJVNgYELGJsVUD4emBVko4gNwHqO9IJM8s1IIf
         4q3o/kxUiEuCnY//DIgrticuT2Ws4QRQcYLTUm0oriUY6/fYXvgY8QlgMsKKt4H9ptB+
         CXcoMyG9GXokRQU3zaIucIXPyZLXQ2HLRkMgQvHbY4HF8Kr28r6uZYlYQ7djQmB4YTD+
         VyeUF/kgjMkuSbd0azOmz8EiZVuVJzTnZrRMlJQRTGgRSB21ZNPAMdRDKfhlqYtNueCu
         bzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zizd9ComOIJz7h+1JbtGaDk5qC6/lGb/W/OYH7FplW0=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=QcP+hGwNWVo09F0/hMw9nsBNoQO8zTbpSvP1P6vDKeVEO4tM+w+H7Q+axif3IGqlEJ
         EYfRY1Dil3M00bwmE9irvsZLoKcavs4X9MGSLppRjyAM66x4QJVAdXBnn8rnv3EuBuxl
         JRnGraRcBF4QI53Z8z31WEfd/8nnYp4jiZzZTf2pyaxFLLYFLy5U+yNwTgGOrN2nJ4bx
         vKN1T2BJrUb5xoSWar2pTxQVY+gND8T599pm8UsNfASyDUD5+aG8vcmySK7cLOHtbyaR
         EzMhosrZcUwoSNiskBI8QqWqxMZnYV2E5IwMGi5Whf/8GR3du4vbsZprKoGSz1kG3mjb
         Jf3Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773177404; x=1773782204; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zizd9ComOIJz7h+1JbtGaDk5qC6/lGb/W/OYH7FplW0=;
        b=qFdryGUotmm3+/5zleSzmIT6gpKbL6KUdmB7n3eaya5Hm2XOlyPzgpS6bOz+EZ7dFa
         BGakKZ6sfh1P12/1oBjvEhpTrmDmwWezyH/OxJvGnGTPjeo3e9AvijPeU+BuB6p5GLow
         Y4Hx6dTbEFo9QU3yPvrZMFbpO6qcuQdlb17fCmu/J3wOMzsi02dqfTw66mU5rXiQMU4d
         yx3EthjvpDOvbdGEjIXIFWmj7BTrWzDpG+xwHEEM2accMsJmBmqBwlTT+z0u0HUBdwj8
         em2amfICmVKCmTLbtYkrBOZf3Y3xUVsslNyD02NXKTyIAsGdAANUGT8OTXr30dvdehdz
         CDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177404; x=1773782204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zizd9ComOIJz7h+1JbtGaDk5qC6/lGb/W/OYH7FplW0=;
        b=H3IDO9LZJCD1g829tDO3zytw7QNEX5OirG9/FFn1+uheJ2xcK2p6pKgcyPoRVj3jfY
         sVfpRggp+SdI/saXA54ZIFjZdyDlT4INMD3ydK0JF2glBxVVMIQIhWM92vICTMyIooHS
         AYDlxsVNXLnoipobYs5YV+OfiSe8lXrCGN0JvtgIr5BnSHc/nXXgTF8aYwhOTMxwIS2Q
         kCsME3bTqE1l7Zfepffu7UjY7GOYU11tX4R4Z6WCiQbj5dBG69PSYwou5AYNP7bCtu9v
         HE1gT5Km3sB29mMR7AIuF4xgqK89ol3O13vmOAvWGRIRog/YvuLovwn5OWkLqf/f8OM5
         hMQg==
X-Gm-Message-State: AOJu0Ywp4FRP6k6paoJ/sEcPWgxxtgaThAqcCmAWE1MGp1HjlgJu9e2D
	IKN5q+uoI/QRA0yPqE/7Hjk4Qs5cB3r1eL+3K95uQWIbkbKVm4+TFuh7byyEv0Ndxpg1ipSKKai
	RQkkLrbzHwTrrfl/j6EHfq6cGnAznUyOhvn29H+zh
X-Gm-Gg: ATEYQzyDn0VsHVUXbsF8UORkFrNYY9TeaiWGBzNcZPkhBXXbgJQIcstQBLQhvaKYzk1
	r52ysLHZDJKOVpotL8PsDSqjWQxZqNWsv0nV6ox75pX8WpAnOVflpayL2nBW3uvD+RG7/3a119+
	svvvbLGNW+6/ggQ05W9PJUU3ByPSfCxzFWApT/03KKgeDtSV6E24oPXPhsy3fL0MOZ2eIvp9Cz0
	o3X2DNHDjpgzqB3RFie5iOmDuC8+hR6vzxV7RfA+J4S7Iqx0Vj2TiYwbMOB5PdZOq+MVDK7CisT
	I1Ss
X-Received: by 2002:ac8:5ad4:0:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-50939a0fdb6mr1414131cf.5.1773177403336; Tue, 10 Mar 2026
 14:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-8-praan@google.com>
 <CAE2F3rD-rEpizTpc1fo7Y8fXZfZCF2TGUz8H86rUY6RzTWQDQA@mail.gmail.com> <abBNwXk2a8v6Zgbw@google.com>
In-Reply-To: <abBNwXk2a8v6Zgbw@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 10 Mar 2026 14:16:31 -0700
X-Gm-Features: AaiRm52CJJPOUPhMm46BfLDaInsZOYDKuS8CgFZKTfstyLrrTTdBIuSn3Z3bOJA
Message-ID: <CAE2F3rAqyX_CQaN2Wt2=uTYJqYUV3nbrfmog0YyvPr4pgYU5xQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:58=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Mon, Mar 09, 2026 at 06:45:09PM -0700, Daniel Mentz wrote:
> > On Mon, Jan 26, 2026 at 7:12=E2=80=AFAM Pranjal Shrivastava <praan@goog=
le.com> wrote:
> > >
> > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *de=
v)
> > > +{
> > > +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> > > +       int timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> > > +       u32 enables;
> > > +       int ret;
> > > +
> > > +       /* Try to suspend the device, wait for in-flight submissions =
*/
> > > +       do {
> > > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) =3D=3D=
 1)
> >
> >
> > I understand we must follow the rule: do not elide any invalidations
> > while SMMU is still enabled. Otherwise, the following sequence of
> > events might occur:
> >  * The driver clears a table descriptor
> >  * The TLBI command is skipped
> >  * The driver frees the page that backed the translation table
> >  * The page is re-allocated for some unrelated purpose
> >  * SMMU performs a table walk and then descends into the page that has
> > been reallocated, misinterpreting its contents.
> >
> > Can you disable SMMU before setting nr_cmdq_users to 0?
> >
>
> No, that'd be racy, if I disable the smmu but nr_cmdq_users !=3D 0 an
> "owner" thread might believe that the SMMU is still functional and poll
> for consumption.

I assume that SMMU still processes commands if SMMU_CR0.SMMUEN is
cleared but SMMU_CR0.CMDQEN is set. The arch spec reads: "When
translation is not enabled for a Security state, an SMMU: [...] Can
process commands after the relevant queue pointers are initialized and
SMMU_(*_)CR0.CMDQEN is enabled." Also, the sequence described under
"Arm recommends that software initializing the SMMU performs the
following steps:" suggests this behavior. The existing driver code
also relies on this when it runs CMDQ_OP_CFGI_ALL before setting
SMMU_CR0.SMMUEN.

>
> I don't think that the SMMU would perform a walk as we first set the
> nr_cmdq_users =3D=3D 0 to stop command submissions and then immediately s=
et
> GBPA to abort. IF a command submission raced with this, we wait for the

To ensure we're on the same page: Setting SMMU_GBPA.ABORT doesn't do
anything while SMMU_CR0.SMMUEN is set. SMMU_GBPA only plays a role if
SMMU_CR0.SMMUEN is cleared.

The moment you set nr_cmdq_users =3D=3D 0, you potentially start eliding
TBLIs which means that the TLB entries are at risk of becoming stale.
How about the following sequenc of events:

* suspend handler sets nr_cmdq_users =3D=3D 0
* arm_smmu_cmdq_issue_cmdlist() stops updating the producer index
which means that TLBIs are not executed
* (sequence described above)

Now that I think more about it: I'm concerned that if we set
nr_cmdq_users =3D=3D 0, the hw prod index will no longer be updated and
the arm_smmu_drain_queues() function will wait for ever, because the
cons index is not catching up.


> CMDQ to be drained before doing anything, the owner thread would poll
> till sync in this case only then the driver would return from the unmap
> call and get a chance to free the page.
>
> > >
> > > +       /* Disable everything */
> > > +       arm_smmu_device_disable(smmu);
> > > +       dev_dbg(dev, "Suspended smmu\n");
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev=
)
> > > +{
> > > +       int ret;
> > > +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> > > +
> > > +       dev_dbg(dev, "Resuming device\n");
> >
> >
> > Try to be consistent with these messages.  Here, it says "Resuming
> > device" whereas above, it says "Suspended smmu". Also, try to align
> > new messages with existing messages in the driver. I believe most
> > other messages start with lowercase characters.
>
> Ack. I'll update it in v6.
>
> Thanks
> Praan
