Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB02ED16D
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250026; cv=pass; b=XP7gA2AMGG8wtf+pAWOxWc3Zc39WPmG7gUAGn3aZ8tC2s1kWmjK9bLKr3Ra1OmQ8BLko4rer/+ch9FoP/8UjxPcIF78J7eFe7DMATMLYCxSt7MlDKgJnhroHMu8/CY2DRjcBABVa1YSMzD2xMnEplXOckwzBoIFL3v5KHigxhAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250026; c=relaxed/simple;
	bh=C2LbRbe/Zk3V027cBTYZEqICuvncHjc3fYe2qi7W2Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jARwC0fmjgRqzFbZa1me5j/6AY//85N5wwY6y5RPRmZkp1DewQEfHDTKWjG9ga544hjPkA3u7tS3E3TQK0po6Tk15Zrh0styrXdlrDr5L2/2tscpAS+5jyRQ8JMYsRqfDqwXXSi3tqGCTmhYzDBkMsMbQJQtfyGBI+6s6+YYi9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0KE4XFbf; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0KE4XFbf"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6628cc1bd69so710a12.1
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 10:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773250022; cv=none;
        d=google.com; s=arc-20240605;
        b=FX20gKoSYapQCBliuFAsr8wnTWcDxWOXIpvHuf4RJIbhZqEYQNbgRFhg6WIGY44dDI
         ugN6CLCFsVwLDy/76ATHCO4xRrCZTkRtYlKj3ZCgbUzjLOCqfxiTJ7Zqg9rg7aJsAJqb
         TQYqSmuIfVCJeF7w6sGb6Zu+ymQtMIJun8u2xUudpfIXpL56cPyTnJj0/tH7WbgkfM+c
         QxlVB719ynsAgqHSdPwyyn4p6XppEx4UCkA0oKKyX86bSgi1tBa3CouN4/41dWLt61XI
         dYTA2Tn7988byFxOVm51W3VZFwZoTNnrUxjehpsXHx4ct7Clu1CpSJI0HTapK7NBjm41
         flmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=moonpXQJnI1Imfb4yAtK41ZVv/1ss3ArCrfNFMWi70c=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=P6io7gKYiSfUzIzb3pex52Jlyb56KwLT1snzydTUr45OZa9C0xiZhWCaFbLkgtFf24
         XCKzmSt+zwrF3FL9nNtSYu2AXQccVpEjeIvQx2RigmrSBuwrsVABkXaqXEpBkzBY4UE7
         eSsyMgHIAM2wJAdZg4LwQyys2bYJ3TX9eu/MHgkn28CQDptVcWXIP2ZpWo576eQN+e+q
         TF4kVW0icr7pYFJvZpFq45GVOx8HG3a9ur2Ar1AHjDnCNwIXdLQuAkmJDOh4XpkJxVm5
         Ko3ymdeBQhKQXLyNsqhCEeLYUH7OJ1/7VOjzSdSacEFVJypU9g4+4miZj0XJbTOcicv8
         MNuw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773250022; x=1773854822; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moonpXQJnI1Imfb4yAtK41ZVv/1ss3ArCrfNFMWi70c=;
        b=0KE4XFbfiDgZj84GnDLCRNupD0/+IMsB9Q5d14rnUVQS77eFdrUVUmyvg6H4NG2Z1e
         d1wV6SUJeGhcvFKVvUK/DHqet6f7RolbsLpaVRk3G38jHtPE7VCBsLd2qsXjIzuOw5h7
         TFN8TrtXBACGyyAlWSIdOC6xaHjXTgdQd+nP1dDt1jMIwfgI8/WVULhGXRLCRce+acG5
         rvaQZ4hNvPe1iro1e9BH8neoTbTjal2a/9ORdPTZEJQ1HbBwdf6UAnfNoSrfcSj6hcRj
         KQBvFRiwBsKuQ/uI95V4YBvy4WF2SisAGxJ7SfH9rP5PHEp7zj5MCwz7t5AF25ZZ+DLS
         GB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250022; x=1773854822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=moonpXQJnI1Imfb4yAtK41ZVv/1ss3ArCrfNFMWi70c=;
        b=KC/K0I1KSrEn87mGNJaP0IBjMMnomyl4+vTZnAoYsa9JfclxnvmUyiHI4WW+gwBrdM
         IQI1gUcbpX11Pjfci/5GlpalYtzAjXP6cDr1QYCaONlQs+0YHck2pC1M5ZAM/Z5bahpa
         cikJVvxKlSx247ISyAM8kPhib3F6hQKECjrXA+NPP3h7zGFZ411umWabqx5n4XkgDyDs
         py/aCoj4f3QSAu1qwUnGflfstSscKQTkBQTZ1dC0C01z0A7RVj3lpU/aHyxn5PIsVQjE
         6CtvVo4HtMet3U+AXzq0jLjtRPY4GlV2yXGVENXsbYSvlCLpdUTzPbcMqQ2nt+as5/ra
         iEWA==
X-Gm-Message-State: AOJu0YwKf0x8AYQcHbuWKz0rE4G0QDCygkBHspR5LsYDFG5WsKi5UuCb
	ikEVA5yhDAIhUEZEpbnZtOaKSzdatU5g6uuKXGYJvHkOVly5v9m7LDh2YHEQ3eXKb+rMlZx82Uo
	Uj8HUibA6q2KeDVTqElaIpMwKQdpMDuyVfcl047Ca
X-Gm-Gg: ATEYQzzXsj9ypJWKwdQdNTHuFCzarMfllXTe1gnkRAoD0ANPiMRMGaMktW4Pfh4HD2e
	5f2GwvtjZtdL4QWzezF20SLSt5QY5E46wA6c4v0A7z86BEaLMOAE57p7nL2SYr7m3twiE2gE32v
	UJFl0QpPWkjBtfFe/G5Nla4v8NW8y5uyGtXABSWv6jl74ZJsDItdbr3suJ6/RGR1s0FoKoGCwkV
	dWPmyDzOkUSpSauXlsD6XyPCcKDVPA6cSpaJHT7NHT5TTP6JTk26OA4VIkK+j57ZMqhTimeJLbY
	ba4DdJibBwu9DgPuXeAcrK6vzGd6VTv5zlZXMIUVMgJDgS2C
X-Received: by 2002:a05:6402:a58a:20b0:663:3a01:931d with SMTP id
 4fb4d7f45d1cf-6635820d5c8mr797a12.5.1773250021942; Wed, 11 Mar 2026 10:27:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-8-praan@google.com>
 <CAE2F3rD-rEpizTpc1fo7Y8fXZfZCF2TGUz8H86rUY6RzTWQDQA@mail.gmail.com>
 <abBNwXk2a8v6Zgbw@google.com> <CAE2F3rAqyX_CQaN2Wt2=uTYJqYUV3nbrfmog0YyvPr4pgYU5xQ@mail.gmail.com>
 <abCP0wLkVvUSUeYI@google.com> <CAE2F3rDbB4RgZLfqKu=AeGdJU6TLdmO=XTCzCb1-yq7VKH0zdw@mail.gmail.com>
 <abD-Kl0xkfg4tsh4@google.com>
In-Reply-To: <abD-Kl0xkfg4tsh4@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 11 Mar 2026 10:26:49 -0700
X-Gm-Features: AaiRm51fhErkLiJYDhwFbi5TCUIJaNlnk46IdAPUE8fioadXZG1u6Bw1OdMaZYw
Message-ID: <CAE2F3rAUfU0+y2C3ro=ApShugU9ujDxnWx3bigZ2wo89xnzvbw@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:31=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> On Tue, Mar 10, 2026 at 05:12:15PM -0700, Daniel Mentz wrote:
> > On Tue, Mar 10, 2026 at 2:40=E2=80=AFPM Pranjal Shrivastava <praan@goog=
le.com> wrote:
> > >
> > > On Tue, Mar 10, 2026 at 02:16:31PM -0700, Daniel Mentz wrote:
> > > > On Tue, Mar 10, 2026 at 9:58=E2=80=AFAM Pranjal Shrivastava <praan@=
google.com> wrote:
> > > > >
> > > > > On Mon, Mar 09, 2026 at 06:45:09PM -0700, Daniel Mentz wrote:
> > > > > > On Mon, Jan 26, 2026 at 7:12=E2=80=AFAM Pranjal Shrivastava <pr=
aan@google.com> wrote:
> > > > > > >
> > > > > > > +static int __maybe_unused arm_smmu_runtime_suspend(struct de=
vice *dev)
> > > > > > > +{
> > > > > > > +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev)=
;
> > > > > > > +       int timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> > > > > > > +       u32 enables;
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       /* Try to suspend the device, wait for in-flight subm=
issions */
> > > > > > > +       do {
> > > > > > > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0=
) =3D=3D 1)
> > > > > >
> > > > > >
> > > > > > I understand we must follow the rule: do not elide any invalida=
tions
> > > > > > while SMMU is still enabled. Otherwise, the following sequence =
of
> > > > > > events might occur:
> > > > > >  * The driver clears a table descriptor
> > > > > >  * The TLBI command is skipped
> > > > > >  * The driver frees the page that backed the translation table
> > > > > >  * The page is re-allocated for some unrelated purpose
> > > > > >  * SMMU performs a table walk and then descends into the page t=
hat has
> > > > > > been reallocated, misinterpreting its contents.
> > > > > >
> > > > > > Can you disable SMMU before setting nr_cmdq_users to 0?
> > > > > >
> > > > >
> > > > > No, that'd be racy, if I disable the smmu but nr_cmdq_users !=3D =
0 an
> > > > > "owner" thread might believe that the SMMU is still functional an=
d poll
> > > > > for consumption.
> > > >
> > > > I assume that SMMU still processes commands if SMMU_CR0.SMMUEN is
> > > > cleared but SMMU_CR0.CMDQEN is set. The arch spec reads: "When
> > > > translation is not enabled for a Security state, an SMMU: [...] Can
> > > > process commands after the relevant queue pointers are initialized =
and
> > > > SMMU_(*_)CR0.CMDQEN is enabled." Also, the sequence described under
> > > > "Arm recommends that software initializing the SMMU performs the
> > > > following steps:" suggests this behavior. The existing driver code
> > > > also relies on this when it runs CMDQ_OP_CFGI_ALL before setting
> > > > SMMU_CR0.SMMUEN.
> > > >
> > > > >
> > > > > I don't think that the SMMU would perform a walk as we first set =
the
> > > > > nr_cmdq_users =3D=3D 0 to stop command submissions and then immed=
iately set
> > > > > GBPA to abort. IF a command submission raced with this, we wait f=
or the
> > > >
> > > > To ensure we're on the same page: Setting SMMU_GBPA.ABORT doesn't d=
o
> > > > anything while SMMU_CR0.SMMUEN is set. SMMU_GBPA only plays a role =
if
> > > > SMMU_CR0.SMMUEN is cleared.
> > > >
> > >
> > > I think you're missing that we *DO* actually set SMMUEN =3D 0 *with* =
the
> > > GBPA abort, please look at this part of the patch:
> > >
> > > +       /* Abort all transactions before disable to avoid spurious by=
pass */
> > > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > > +
> > > +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> > > +       enables =3D CR0_CMDQEN;
> > > +       ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, =
ARM_SMMU_CR0ACK);
> > > +       if (ret) {
> > > +               dev_err(smmu->dev, "Timed-out while disabling smmu\n"=
);
> > > +               atomic_set(&smmu->nr_cmdq_users, 1);
> > > +               return ret;
> > > +       }
> > >
> > > We disable everything except for the CMDQ. Since, everything is disab=
led
> > > at this point, any new commands can safely be elided as the SMMU won'=
t
> > > access any config structures as mentioned by the spec.
> > >
> > > > The moment you set nr_cmdq_users =3D=3D 0, you potentially start el=
iding
> > > > TBLIs which means that the TLB entries are at risk of becoming stal=
e.
> > >
> > > Not really, the SMMU isn't accessing anything since SMMUEN=3D0 and GB=
PA is
> > > set by this point.
> >
> > I believe you are assuming that all these things happen atomically
> > when they, in fact, happen sequentially. Imagine the CPU takes an
> > interrupt after setting nr_cmdq_users=3D=3D0 but before clearing
> > SMMU_CR0.SMMUEN, then we are in a state where nr_cmdq_users=3D=3D0 but
> > SMMUEN is still set.
> >
> > >
> > > > How about the following sequenc of events:
> > > >
> > > > * suspend handler sets nr_cmdq_users =3D=3D 0
> > > > * arm_smmu_cmdq_issue_cmdlist() stops updating the producer index
> > > > which means that TLBIs are not executed
> > > > * (sequence described above)
> > > >
> > > > Now that I think more about it: I'm concerned that if we set
> > > > nr_cmdq_users =3D=3D 0, the hw prod index will no longer be updated=
 and
> > > > the arm_smmu_drain_queues() function will wait for ever, because th=
e
> > > > cons index is not catching up.
> > > >
> > >
> > > If we go ahead with the suggestion to completely elide a command
> > > submission, if (nr_users_cmdq =3D=3D 0) return 0; (as discussed in th=
e other
> > > thread), then we don't update llq.cons / prod. Then this shouldn't be=
 an
> > > issue right?
> >
> > I still think we have to clear SMMUEN before setting nr_users_cmdq=3D0
> >
> > >
> > > The problem I see in swapping the sequence is::
> > >
> > > +       /* Abort all transactions before disable to avoid spurious by=
pass */
> > > +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> > > +
> > > +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> > > +       enables =3D CR0_CMDQEN; <-- Tear down everything except CMDQ
> > > +       ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, =
ARM_SMMU_CR0ACK);
> > > +       if (ret) {
> > > +               dev_err(smmu->dev, "Timed-out while disabling smmu\n"=
);
> > > +               atomic_set(&smmu->nr_cmdq_users, 1);
> > > +               return ret;
> > > +       }
> > > +       /* Try to suspend the device, wait for in-flight submissions =
*/
> > > +       do {
> > > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) =3D=3D=
 1)
> > > +                       break;
> > > +
> > > +               udelay(1);
> > > +       } while (--timeout);
> > > +
> > > +       if (!timeout) {
> > > +               dev_warn(smmu->dev, "SMMU in use, aborting suspend\n"=
);
> > > +               return -EAGAIN; <--- suspend failed, but we already t=
ore down the smmu
> > > +       }
> > > +
> > > +
> > > +       /*
> > > +        * At this point the SMMU is completely disabled and won't ac=
cess
> > > +        * any translation/config structures, even speculative access=
es
> > > +        * aren't performed as per the IHI0070 spec (section 6.3.9.6)=
.
> > > +        */
> > > +
> > > +       /* Wait for the CMDQs to be drained to flush any pending comm=
ands */
> > > +       ret =3D arm_smmu_drain_queues(smmu);
> > > +       if (ret)
> > > +               dev_err(smmu->dev, "Draining queues timed-out..forcin=
g suspend\n");
> > > +
> > > +       /* Disable everything */
> > > +       arm_smmu_device_disable(smmu); <---- Note that this still jus=
t disables the CMDQ
> > > +       dev_dbg(dev, "Suspended smmu\n");
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >
> > > In the current implementation we first see if we can suspend only the=
n
> > > tear down the SMMU (Except for the CMDQ),
> >
> > What do you mean by "if we can suspend"? I think we can clear SMMUEN
> > even while commands are in-flight.
> >
>
> I mean a race where we set SMMUEN =3D 0 but we get another CMDQ user,
> since the nr_cmdq_users !=3D 0, we can have multiple users flushing their
> commands unless it's back to 1. The problem is how long do we wait for
> nr_users =3D 0 ? If we timeout, we'll have to reset the SMMU as we can't
> simply re-enable SMMUEN.

Why can't we just re-enable SMMUEN? If we never set nr_cmdq_users to
0, we never elided any invalidation commands.

>
> We can't forcibly set nr_cmdq_user =3D 0 as we don't know where in the
> issue_cmdlist a thread is, forcibly setting it 0 would cause trouble if
> a thread is polling on a sync or about to increment the prod_index..

I agree that we can't forcibly set nr_cmdq_user =3D 0. When I wrote set
nr_cmdq_user to 0, I meant using your atomic_cmpxchg loop.
