Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD7367B6E
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780871797; cv=pass; b=hgUOG9MxsxtkYqs4kYy2x28dddlz8pPTxVIoiXtmeyql8FeOATUgZLYOHWfdY86nghRjSnHoYvjREbC4e1neLi84HhFq2jXJyjE/U+iInuu1E80ZW/gpy6CdjzWBnHvfShjEDtEosTn6HPUnL9PMYEQIsRNJIy1r3M/RqWrg0mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780871797; c=relaxed/simple;
	bh=iiRNonkrU9OEnrLXum+KhTdP8Fdh43k1RmgZBjBlxoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmFQ/0KkdiVe4d6tYXOmFvmDHf96zYv1Ei7D01kkRjOkENaV9l01J3MJbL4xuU8wcFcf4gdUuggsZI4bgnKdPXXoBo+kPNTOpG11ydRiIvYz5bJlRynSfH0Y1PAsJsQPExpokQKQoZGsUU3bBTeKyN75Wf2YmsclzJpIE7ZMbe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfoVf0cB; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfoVf0cB"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51765531803so1579901cf.0
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 15:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780871795; cv=none;
        d=google.com; s=arc-20240605;
        b=RCouRMwQAdulXkdig0gRRbd/hMY4JKjW8luwm453VNuK2zwn9ovZcH6gQmvrV1Zi6C
         CRTtbhq1+aFFucFm7Dw5gB9yq2ctc4420UkShLy6fTr1JTNB8D/pIcFIpdmDTPqii7bc
         i9cD1A5Iu/bppK/epN+h0nZwt7ykAEiByAu/TL2A8NpfJUPPuzOZfFRAWjBcIEJgbL3Y
         oLZMKxhTWTGi70ROIiuqKo0bnz8e955peQD2nEhP6YMZxIuC6/CO0v1MZcRhqFCv4Djy
         DVvUY6uInaoFpVG60L58Jm3hbyA2chYR92a1Fnn0vrZprxXN89T5sZ/X7kdqREcpggn2
         modQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzQapWcP2ymqddngP+24xFPJC/OcI9E0rn+PY/NrRy8=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=XWL7Qy8K6HzZ4YmVroj1LU2G7NEGmciCoKA6gKR/M2ya9MRVH2qG3d/t/zl6brruvl
         QeBN3BuRr1bfBuL1fu8drVIVXQEVNswOvbXjF8Yr+IXIzX0yN9N09dHdMo33MISPcp9R
         JKHJpIFzvzMZD0SH4pcc0f3/P7000sc67CVjfIos03n+5UFVPH0WGt8I04qY9cdKSN1c
         aXLm0o746e4G2aDFPXf6/G9XKNASJSwXBdLlhy2enuNnaAs9ZO6fLcPY4+GxnHUCq++8
         Cy+PFWyiLu/577SqAh54Y0w6wAK9B6tq5G2chWdHfsligSRWPgPxiVD3MjEujbtg//iy
         MrWQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780871795; x=1781476595; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzQapWcP2ymqddngP+24xFPJC/OcI9E0rn+PY/NrRy8=;
        b=VfoVf0cBp2sHKrPvM78c7As7/HQ1J8Lg855sbYfQqEMaZjhkzXlRHQRLBUSEFjGNGk
         NQc9s7dB29zM2HqId5z/a5I0XJEAyFVIEcuq1dZK1kQBL6spBqXxChoUGq8ALBxecM/+
         md2qgzOnrWgP37/pJ96la6S3pa28/9h23rI+K6scn9ISzaMJxU4k9RcQcKL3ZitZ4vua
         5LoNucI05S1B544QgflQBMIb3T8rge3SvuuKyudqhGmExtvU9tWSch4NtLWtW8CIT4e1
         ev8xtbYOvfi0GdTD3k4PxThbaQW/wx4jl1/v4aj7dPQZUkrQTI+2GV2b5RMhNjSHurdJ
         dGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780871795; x=1781476595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzQapWcP2ymqddngP+24xFPJC/OcI9E0rn+PY/NrRy8=;
        b=DxnFiqLOcww3qJUcMOXnVSZwc7RSSkhxDm1xNDuAnehzRpA/MWaxcmh7Dy9XEW995t
         VBRQAaKtFW0KgvCnE35ZoIHpDu4GwI0jB/dEOCy22mAoyRxx6udk4aG+lO9JdL2wHRZj
         eH7o/AXTSiSBhF/16W0jerwZZYg0erP1ME49h0ilS/LpdrvxhcfxEOyGN7pg3Qyd9/Jq
         mbynGUj4mFJEWE1HYS6bKHpFdrrLFUf1+8aSGrE5BCVBa81WTMsU8zQtWI2JwNDnVwYD
         /gR2hQ5o1yuYiACl1nwRPpCmwcSssZd2bym16m/g9ap8n+ocFDoU0TCbfleWaPMvZlAR
         rYfA==
X-Gm-Message-State: AOJu0YyOw7TQp68TJYsEfzvI3GBnyYJlHg/2n65zfMeXY4oNQXJ526O9
	2sbZHDuh1cz9x+9BgLIBUkYdwuDwSSWXldyF/EGP980IOyCJhSr2/lfYL8pLRY1mJSyhoXA8bMP
	YVCDCzt2KEV6DCObvtq7bo3KIjFnir+tAo+l3Izey
X-Gm-Gg: Acq92OFHkzaYjZ53E8gs/zlJYqksppWWwPnXzfxaJpZAuDwE3nu7znfeNnOlbQIxMHX
	ALRNpxdgBjzRt+EWOHVCQCH2rq9c3shMXzqdw7AFGS+5+xBY/Me1j/PNYcRVBhB6c6XkticTORv
	Ub8xSiGPD2typD77/eC6uTxXIduDT6dcUYa9DoK8BHdsjQvIOGwIbno3Sa1r6AODDVOYUfWFyfX
	hcDZRdT4BB1QlDXUvuaOp1prbkyaSVl/P/w6jsO36OGMSjGhsn4q4Nz9biW7oV/RvMKaqE6p9l+
	lh8NY1DYgwcZQSw=
X-Received: by 2002:a05:622a:7b13:b0:517:5c70:46bd with SMTP id
 d75a77b69052e-51798cae59dmr16918231cf.11.1780871794443; Sun, 07 Jun 2026
 15:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-10-praan@google.com>
 <CAE2F3rAYWMq6DO5k20e4iMtPbh_X9JeiU8kUfw8nsS5xs42F_Q@mail.gmail.com> <ah7IoJqmRbK7xK5-@google.com>
In-Reply-To: <ah7IoJqmRbK7xK5-@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 7 Jun 2026 15:36:23 -0700
X-Gm-Features: AVVi8CcBpwT5j7IGxPrmPgiLAQbAn4sKZqb1wXuCaNfPlpIEArZNRn7dVWRuI0A
Message-ID: <CAE2F3rDuq4FYrQSZ0dK535DB0uOUgCZdsRvGy0JVeaOR_fLbgw@mail.gmail.com>
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 5:12=E2=80=AFAM Pranjal Shrivastava <praan@google.co=
m> wrote:
>
> On Mon, Jun 01, 2026 at 10:25:41PM -0700, Daniel Mentz wrote:
> > On Mon, Jun 1, 2026 at 2:59=E2=80=AFPM Pranjal Shrivastava <praan@googl=
e.com> wrote:
> >
> > > +       /* Drain the CMDQs */
> > > +       ret =3D arm_smmu_drain_queues(smmu);
> > > +       if (ret)
> > > +               dev_warn(smmu->dev, "failed to drain queues, forcing =
suspend\n");
> >
> > Can arm_smmu_drain_queues() be called after cmdq->lock is 0? I think
> > that way we can be sure that no other thread updates smmu->cmdq.q.cons
> >
>
> Hmm.. that wouldn't work for impl-specific CMDQs as we STOP and drain
> them together in a single function.. maybe I'll factor out setting the
> STOP_FLAG on impl-specific queues as another impl_op, gate the queues
> first, wait for lock =3D=3D 0 and then drain_queues?

I'm not familiar with impl-specific CMDQs, but what you are suggesting
sounds plausible to me.

>
> > > +
> > > +       /* Wait for cmdq->lock =3D=3D 0 to ensure last CMDQ_CONS_REG =
is written */
> > > +       timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> > > +       while (atomic_read(&cmdq->lock) !=3D 0 && --timeout)
> > > +               udelay(1);
> > > +
> > > +       /* Timing out here implies misconfigured Runtime PM or broken=
 devlinks */
> > > +       if (!timeout)
> > > +               dev_err(smmu->dev, "cmdq lock !=3D 0, forcing suspend=
. Polling CPUs may fault.\n");
