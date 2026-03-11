Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF913E41A
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773187949; cv=pass; b=HuvaPNF6vCkL/3tBDejJEppGumtJb6CAC1SgP8izxaT8Zozsb2uLyJqKZcXtw+Nt8h7WVa3FE25V6bkoECWt97zDSjHaGy63THk8WBW4OgrPc2TNUHLXswcvca8cWm5efObdJnZDPdpOrllAN4NySnLC2GxDKTPYLt+q8gdghPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773187949; c=relaxed/simple;
	bh=HrLgoCijdVOuUyeEGRQL5Y8gF33i8aIcWZy/GvZqO1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3y4EYvoFVbmI2TM/YJr//zo6dyMN1s0I/5uuw7pbftudW8IPSVweyimuZNpzNVxg3ANjbaD/jqOhKtYC+J7hdvYgFOWVXh7Pz0lP87jMCGO2UTdKL4iO6jSV7bNeHxbCnlsRRMJ5YP+kGy0sqVT2RTJWtjIhc2d+vi8l7MymDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ls6K8JrL; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ls6K8JrL"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50906a98ffeso281851cf.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 17:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773187947; cv=none;
        d=google.com; s=arc-20240605;
        b=KzQWH8xzZ9HhidP8hSwrvGSUzEl1RrWSe5/7FVzHo69Fq4lI0YTdGu3zn6QIJgnywd
         hPtX/7hFYPoB9tPXpc5YAxMCUbLEnC8B7V4mKMngkFl+oq8SJjYTSAbuIOUXt3wZj6sE
         UubT1LnB7iGG8Z0Zb4aDeEdMR+vL2flKvs4TtbYzeJAycwUKJotGof7B7fkEhV1o2USF
         hNw1fWSJHRuc3jGBM4NbpheABShbBLOtHGBRE6xXiUWh0Z5aLe9z6qFPwsTEgiHAzKSr
         TW2lhbMUPGid2u7zxkCumYG3rX5h/o4yZTcxH93kxpFDm85AHX5yEws/FSh4h9Chjd8W
         PCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+eqNGb5E3LRnmmm7nbVAXoTTaCsbe3C2T3L0Fo7oiIQ=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=XGemLA8f2oJeq9NzCiVVPGB1PJC5Ph2Ixr7nEL8/vmsx0eNJQhHUSSWsTSCocjCw0G
         +RvgA7ptfyiU4QH/nKRGZKvWtbl5uc/0o906qdfAh6SSLpq9Kmzormo1DQAbVt7H2bhJ
         FXA+bV/CLug9mdTjF5nr3KLgmd1VvKO7Zp6TpL2v/juP/S2mk7WALpj+2JDbe1iArTII
         pDPIIz/lhtFgavNw2B8L16dSXvmMuniTFMfwTNeAPhqElDIqLOyoLeJwr4u0S4z/BKVz
         d078xA6H2Xs3TMXIq+80kpBqHX1o9pqtB6z1FJT8z7LVX4O+wKUKE5/ogYCBhmwCrHQg
         RBVw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773187947; x=1773792747; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eqNGb5E3LRnmmm7nbVAXoTTaCsbe3C2T3L0Fo7oiIQ=;
        b=Ls6K8JrLS6f6LJKQYavNX7tZmPTf1lS0ZdOVbs9r+0+DHU/1r+vB/hYXothg6g2426
         q2H9O6gc2ur+ocOp9akRGBZOf9ghOfw4B8J5EE1J//GGEt9zXFSOJPHvt2cdwIkoJgtQ
         TmRJ3QZenJ5e83iRpRBlsZY31tQyjR7jVTPzcjA64zbydWImYadOW7hBx4/t0fJ0Pbpe
         xl1En4zFet/Q2SbZOVdPT7IoBkdmXRowl1DAthtALXxgo82f5y6gdKCieeMtehqyzv8o
         oOZ7xYEToLik2Wmuw/ea8E5xgpEy9sVJVW4KvvENoRIbqA+7StWDUz9FTa1Wg+cwXvBC
         hjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773187947; x=1773792747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eqNGb5E3LRnmmm7nbVAXoTTaCsbe3C2T3L0Fo7oiIQ=;
        b=wkI9mXQc3/fUcr7fdda9BZAMQinjqHuK+XfHcOx5DxAO+W7vN0xJxOXzmcXDi9rldv
         QACOUYsKvpixhlZHB5PfKxxTuwIQrKJ7y3/w5ss/RWOADzKGf9sBG+vow8Ww3NWACqRa
         L12Bt51PAZFUQ8+zSOUZVy0YRM2eIHrD7NBsUeK/Qy/Ln33g/phN3VDhVkntQhPimlo5
         6uauD9Ft6EAqJSXf/OIXuK5CdLJe0bRbby9vDLFuGKFgQDEc/S28y1uN2lnxKtzJWKtL
         XDfjW80WDZPAb4gtmKM0GahmtYQsrEZK7okIM7zgNEkFECR+6tbZyFpC0mCsKuYKfidr
         AcaQ==
X-Gm-Message-State: AOJu0YznU6FNh4NZxy7ehpaBwIrCla5l4bmgxs7LH3BBg+3rNr9tJ05l
	1nilSEkjXcV5h1ixfKeNl4+DSZNQVLnqgBoIjoIhHtmXKBk2vZl2WCiZS7aEOHfNb1frnoUptG5
	JAYy3CWi7bB+mPbvmlrUcmJAsYttf+Dk9fSjyoUez
X-Gm-Gg: ATEYQzz3FUFGhgXreMcrw9LRsFBlv87ZeI3Kk66yKs7DpRyyDSclvXSJZCYpnk7Z03N
	/uLsA/GI8tY8RWnl4TcGlQNqFHm0jvlmKWcTproweeJ0R0mktUR92e3SLFhxArpb0kr4VEdl+0p
	0yo/Meqa3etvpg7JrmaIv4gXXgFHxYVnEEPrSsPOvgsw16RhKBbqrgtM0Ln+n+60Nc6Oa/guOmG
	+xPsPKCR23NFxpcFHEjOQk5EDsydIfllfcZ4u5a9fYBWrvz76wFDsNOlAaPE75CJEYaWjxa4jCL
	hLwT
X-Received: by 2002:a05:622a:14cb:b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-5093818c817mr5484451cf.2.1773187946874; Tue, 10 Mar 2026
 17:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-8-praan@google.com>
 <CAE2F3rD-rEpizTpc1fo7Y8fXZfZCF2TGUz8H86rUY6RzTWQDQA@mail.gmail.com>
 <abBNwXk2a8v6Zgbw@google.com> <CAE2F3rAqyX_CQaN2Wt2=uTYJqYUV3nbrfmog0YyvPr4pgYU5xQ@mail.gmail.com>
 <abCP0wLkVvUSUeYI@google.com>
In-Reply-To: <abCP0wLkVvUSUeYI@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 10 Mar 2026 17:12:15 -0700
X-Gm-Features: AaiRm53WTnOxZdpfEm8xBU1DtgFK8Qz5FB_pieGq3Lp05RTtAFl9btQYeE1QEo0
Message-ID: <CAE2F3rDbB4RgZLfqKu=AeGdJU6TLdmO=XTCzCb1-yq7VKH0zdw@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 2:40=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Tue, Mar 10, 2026 at 02:16:31PM -0700, Daniel Mentz wrote:
> > On Tue, Mar 10, 2026 at 9:58=E2=80=AFAM Pranjal Shrivastava <praan@goog=
le.com> wrote:
> > >
> > > On Mon, Mar 09, 2026 at 06:45:09PM -0700, Daniel Mentz wrote:
> > > > On Mon, Jan 26, 2026 at 7:12=E2=80=AFAM Pranjal Shrivastava <praan@=
google.com> wrote:
> > > > >
> > > > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device=
 *dev)
> > > > > +{
> > > > > +       struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);
> > > > > +       int timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> > > > > +       u32 enables;
> > > > > +       int ret;
> > > > > +
> > > > > +       /* Try to suspend the device, wait for in-flight submissi=
ons */
> > > > > +       do {
> > > > > +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) =
=3D=3D 1)
> > > >
> > > >
> > > > I understand we must follow the rule: do not elide any invalidation=
s
> > > > while SMMU is still enabled. Otherwise, the following sequence of
> > > > events might occur:
> > > >  * The driver clears a table descriptor
> > > >  * The TLBI command is skipped
> > > >  * The driver frees the page that backed the translation table
> > > >  * The page is re-allocated for some unrelated purpose
> > > >  * SMMU performs a table walk and then descends into the page that =
has
> > > > been reallocated, misinterpreting its contents.
> > > >
> > > > Can you disable SMMU before setting nr_cmdq_users to 0?
> > > >
> > >
> > > No, that'd be racy, if I disable the smmu but nr_cmdq_users !=3D 0 an
> > > "owner" thread might believe that the SMMU is still functional and po=
ll
> > > for consumption.
> >
> > I assume that SMMU still processes commands if SMMU_CR0.SMMUEN is
> > cleared but SMMU_CR0.CMDQEN is set. The arch spec reads: "When
> > translation is not enabled for a Security state, an SMMU: [...] Can
> > process commands after the relevant queue pointers are initialized and
> > SMMU_(*_)CR0.CMDQEN is enabled." Also, the sequence described under
> > "Arm recommends that software initializing the SMMU performs the
> > following steps:" suggests this behavior. The existing driver code
> > also relies on this when it runs CMDQ_OP_CFGI_ALL before setting
> > SMMU_CR0.SMMUEN.
> >
> > >
> > > I don't think that the SMMU would perform a walk as we first set the
> > > nr_cmdq_users =3D=3D 0 to stop command submissions and then immediate=
ly set
> > > GBPA to abort. IF a command submission raced with this, we wait for t=
he
> >
> > To ensure we're on the same page: Setting SMMU_GBPA.ABORT doesn't do
> > anything while SMMU_CR0.SMMUEN is set. SMMU_GBPA only plays a role if
> > SMMU_CR0.SMMUEN is cleared.
> >
>
> I think you're missing that we *DO* actually set SMMUEN =3D 0 *with* the
> GBPA abort, please look at this part of the patch:
>
> +       /* Abort all transactions before disable to avoid spurious bypass=
 */
> +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> +
> +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> +       enables =3D CR0_CMDQEN;
> +       ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_=
SMMU_CR0ACK);
> +       if (ret) {
> +               dev_err(smmu->dev, "Timed-out while disabling smmu\n");
> +               atomic_set(&smmu->nr_cmdq_users, 1);
> +               return ret;
> +       }
>
> We disable everything except for the CMDQ. Since, everything is disabled
> at this point, any new commands can safely be elided as the SMMU won't
> access any config structures as mentioned by the spec.
>
> > The moment you set nr_cmdq_users =3D=3D 0, you potentially start elidin=
g
> > TBLIs which means that the TLB entries are at risk of becoming stale.
>
> Not really, the SMMU isn't accessing anything since SMMUEN=3D0 and GBPA i=
s
> set by this point.

I believe you are assuming that all these things happen atomically
when they, in fact, happen sequentially. Imagine the CPU takes an
interrupt after setting nr_cmdq_users=3D=3D0 but before clearing
SMMU_CR0.SMMUEN, then we are in a state where nr_cmdq_users=3D=3D0 but
SMMUEN is still set.

>
> > How about the following sequenc of events:
> >
> > * suspend handler sets nr_cmdq_users =3D=3D 0
> > * arm_smmu_cmdq_issue_cmdlist() stops updating the producer index
> > which means that TLBIs are not executed
> > * (sequence described above)
> >
> > Now that I think more about it: I'm concerned that if we set
> > nr_cmdq_users =3D=3D 0, the hw prod index will no longer be updated and
> > the arm_smmu_drain_queues() function will wait for ever, because the
> > cons index is not catching up.
> >
>
> If we go ahead with the suggestion to completely elide a command
> submission, if (nr_users_cmdq =3D=3D 0) return 0; (as discussed in the ot=
her
> thread), then we don't update llq.cons / prod. Then this shouldn't be an
> issue right?

I still think we have to clear SMMUEN before setting nr_users_cmdq=3D0

>
> The problem I see in swapping the sequence is::
>
> +       /* Abort all transactions before disable to avoid spurious bypass=
 */
> +       arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> +
> +       /* Disable the SMMU via CR0.EN and all queues except CMDQ */
> +       enables =3D CR0_CMDQEN; <-- Tear down everything except CMDQ
> +       ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_=
SMMU_CR0ACK);
> +       if (ret) {
> +               dev_err(smmu->dev, "Timed-out while disabling smmu\n");
> +               atomic_set(&smmu->nr_cmdq_users, 1);
> +               return ret;
> +       }
> +       /* Try to suspend the device, wait for in-flight submissions */
> +       do {
> +               if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) =3D=3D 1)
> +                       break;
> +
> +               udelay(1);
> +       } while (--timeout);
> +
> +       if (!timeout) {
> +               dev_warn(smmu->dev, "SMMU in use, aborting suspend\n");
> +               return -EAGAIN; <--- suspend failed, but we already tore =
down the smmu
> +       }
> +
> +
> +       /*
> +        * At this point the SMMU is completely disabled and won't access
> +        * any translation/config structures, even speculative accesses
> +        * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> +        */
> +
> +       /* Wait for the CMDQs to be drained to flush any pending commands=
 */
> +       ret =3D arm_smmu_drain_queues(smmu);
> +       if (ret)
> +               dev_err(smmu->dev, "Draining queues timed-out..forcing su=
spend\n");
> +
> +       /* Disable everything */
> +       arm_smmu_device_disable(smmu); <---- Note that this still just di=
sables the CMDQ
> +       dev_dbg(dev, "Suspended smmu\n");
> +
> +       return 0;
> +}
> +
>
> In the current implementation we first see if we can suspend only then
> tear down the SMMU (Except for the CMDQ),

What do you mean by "if we can suspend"? I think we can clear SMMUEN
even while commands are in-flight.

>
> I think this would NOT be a problem if we just bail out of issue_cmdlist
> early as discussed on the other thread if (nr_cmdq_users =3D=3D 0) return=
 0;
> that way, we don't end up in a "fake command" consumption situation
> which could lead to the cons never catching up while draining the queue.
>
> Thanks
> Praan
