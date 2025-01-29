Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AC3CF58
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738121140; cv=none; b=C4M289sIOXOgaYYmVnWWq7KWE0Rhr3iVQDJnJCzggaPIBQtXMMnrYUOYo4+vOQDUtBOJTKKmSYndvgSxb0IklJJ0faAj2nmReh7H83vRW+HOhrIVDybFXgvZK+VkcHybWi2+ILBn7lySh/wNEXSCQNsK6Vfvk0urbUIbNPNu9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738121140; c=relaxed/simple;
	bh=xWYAyVS9oE6n0w2ZslKjPYlUvgS6FfOZt749QsPmxow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7JhMJYJ3GWcJ5V8HGA+fct5AEpo1vAFywj9ujdXEJP3sHeloxaIEP5U4UfKGwrcwVb3reIHA5MXAJT1FjNRmtVAfJf3V5ud5X6JX4bLuCoWbjXt6qKuyNmx/SUU23AGhehHljkPhqqxnGzpvviimImV/fJR7fIWF91fBQqVbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTZgE6gZ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTZgE6gZ"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844e161a957so453108939f.0
        for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 19:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738121137; x=1738725937; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dDIqA4VDST4yPwcwWTbRUjv9OaOCjso0egT8E2lAps=;
        b=QTZgE6gZM3oanyPhOe2QdjiXWy799cplnj0/ehkJVjQHrMz0OrFuzc/6i3nNJdHnaW
         yz7wEbIB2UXbVKQ+6iMtSAwWpEUayn9BJxQ7V0QXlqbb28aA2dMhXEb07TNXg9vQtGP4
         5EuFiizTgP4c/911H8zyokYB0vbv8tOJEgkzp1QU4l9LuYd45cnVMOGl0lOK0Lhu47TC
         OJGebYoepxTCp3RBivDeyUq9tZF0yOf5WDn277GD2Q+nwIksKYpp0ioniwLx+t2YKAFN
         Q4FnDS1HdO2y62leywE3ttn777+VvUPkCK60Ml8cFCKffvuCqrc8ieTeqJUE5Tf7wj5h
         9J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738121137; x=1738725937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dDIqA4VDST4yPwcwWTbRUjv9OaOCjso0egT8E2lAps=;
        b=eHth1kvOdVShB4fuj4S4rh36ekZFF9ZvLsyDluXSB+Q1QB0jQcdCV1+8igjWpqXl6U
         bgalZuKvFqF/BOUr6CHrr79SAySO8CurtldnRAbqpL2/Z/kmzk0Jg4RHqZRKQw4wgg0q
         4fiMTJ6Hz+vM5gdp0VknhVQb/m1+cRfm1q3Mv6GSuaSv27/QxFTP9AgAiMqET9dp2zH3
         6qxVcfUE8a/MJhqrUwQIW7oTO2Zpvw4hA0FV3OpwQvLq9rULZi4FZB1vV8O+1ucPpviT
         wZ2WZXc+cNdlUoxODB2ISUEx4C75wfOV8QDjI9DV9pYujXCipDlJBmIk/mNm/qzp1Q8b
         TXYw==
X-Forwarded-Encrypted: i=1; AJvYcCXipb70V+yIarNJeXeCIAMdtCgV+/kQD+1FrHbrLhFVdtQLjciw7H4KOYhVbvc+pKinIZCENQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOu9rNsbY8Js7Zb+B4DjNW4b7bvlPjzaCp1NlH0iMKjZv0T/4S
	NAq9ftnt4jwpUKh9RZxlkYH26WrCIEdAKtOQnaRvb5c5HsWyIuHHLrMr/sTvqNqO8StESzs393M
	jYsANcpkPlxDKHSlx4jw0rxdl9bw=
X-Gm-Gg: ASbGnctVv5ttUP9LR0IB1C2XkhE7VeVmA/DAuTfPmDaNBHNmN8cLQNbxuxaNyFiDnsB
	pTw0WmuUE2hiZewnUQk+8X4uHSfTU0l8eRrvMNRuOvJBA34TYTQTlLUfFE4CR6FvoIN1P3AkhJQ
	==
X-Google-Smtp-Source: AGHT+IGpMyCuuvxRf9JKn/IGg4EgOQrCoMhpqUUmXymP6ydEXopJZ7pGxrRwB8qnqi6LFxZVbq4bt2PZZlGgSUMT9/8=
X-Received: by 2002:a05:6e02:138c:b0:3cf:ba60:e2fd with SMTP id
 e9e14a558f8ab-3cffe3e5d81mr18188015ab.12.1738121137443; Tue, 28 Jan 2025
 19:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122-msm-gpu-fault-fixes-next-v3-0-0afa00158521@gmail.com>
 <20250122-msm-gpu-fault-fixes-next-v3-1-0afa00158521@gmail.com>
 <Z5IjsqQ6vTdUXiGt@hu-guptap-hyd.qualcomm.com> <CACu1E7H5X2EfY9AG=xceaoZJkbumwnrsU4QvNbxd_A2wgVVOaQ@mail.gmail.com>
 <Z5KXwNPrdirVUn8Z@hu-guptap-hyd.qualcomm.com> <CACu1E7GOS+_biN=AuQwYK47ApRPFGygyD+U5X9d_4ReXKrzbfw@mail.gmail.com>
 <Z5i6GQDd5apN+a10@hu-guptap-hyd.qualcomm.com> <CAF6AEGstcrAJDBpPm-uQ+zSDVEhDJ4AQhCTDT-z9_8Nq0e35WQ@mail.gmail.com>
 <CACu1E7HErZAL=-GVQfKUAUK5bgK-X0qejt5os3f2UhkeZ1ptMQ@mail.gmail.com>
 <CAF6AEGsUjp+fp1_cN7SGYTh5WSQrU2mm92QsqA5rcSY1OtA8VQ@mail.gmail.com> <CACu1E7FyHwJ2mp5u3rDganYj80eDq3QJzLRFzxD9E9O7hEDiag@mail.gmail.com>
In-Reply-To: <CACu1E7FyHwJ2mp5u3rDganYj80eDq3QJzLRFzxD9E9O7hEDiag@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 28 Jan 2025 19:25:25 -0800
X-Gm-Features: AWEUYZkXMQul2iCS8g_lBAK6cifDDx4C71uDvFmo8QxPAIsqMGize_ZuktCSrPU
Message-ID: <CAF6AEGugDxYjH63+Up_T_pt+jQ2D0m=x1tSg3fGPteu3XgR2qA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Prakash Gupta <quic_guptap@quicinc.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 6:31=E2=80=AFPM Connor Abbott <cwabbott0@gmail.com>=
 wrote:
>
> On Tue, Jan 28, 2025 at 9:21=E2=80=AFPM Rob Clark <robdclark@gmail.com> w=
rote:
> >
> > On Tue, Jan 28, 2025 at 2:15=E2=80=AFPM Connor Abbott <cwabbott0@gmail.=
com> wrote:
> > >
> > > On Tue, Jan 28, 2025 at 5:10=E2=80=AFPM Rob Clark <robdclark@gmail.co=
m> wrote:
> > > >
> > > > On Tue, Jan 28, 2025 at 3:08=E2=80=AFAM Prakash Gupta <quic_guptap@=
quicinc.com> wrote:
> > > > >
> > > > > On Thu, Jan 23, 2025 at 03:14:16PM -0500, Connor Abbott wrote:
> > > > > > On Thu, Jan 23, 2025 at 2:26=E2=80=AFPM Prakash Gupta <quic_gup=
tap@quicinc.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 23, 2025 at 09:00:17AM -0500, Connor Abbott wrote=
:
> > > > > > > > On Thu, Jan 23, 2025 at 6:10=E2=80=AFAM Prakash Gupta <quic=
_guptap@quicinc.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jan 22, 2025 at 03:00:58PM -0500, Connor Abbott w=
rote:
> > > > > > > > > The context would remain stalled till we write to CBn_RES=
UME. Which is done
> > > > > > > > > in qcom_adreno_smmu_resume_translation(). For a stalled c=
ontext further
> > > > > > > > > transactions are not processed and we shouldn't see furth=
er faults and
> > > > > > > > > or fault inerrupts. Do you observe faults with stalled co=
ntext?
> > > > > > > >
> > > > > > > > Yes. I've observed that on MMU-500 writing RESUME before th=
e interrupt
> > > > > > > > has been cleared doesn't clear SS. This happened with v2 in=
 the case
> > > > > > > > where there was already a devcoredump and drm/msm called
> > > > > > > > qcom_adreno_smmu_resume_translation() immediately from its =
fault
> > > > > > > > handler, and we'd get a storm of unhandled interrupts until=
 it was
> > > > > > > > disabled. Given that the architecture spec says we're suppo=
sed to
> > > > > > > > clear the interrupt first this may have been an attempt to =
"help"
> > > > > > > > developers.
> > > > > > > >
> > > > > > >
> > > > > > > Just to clarify, present sequence is:
> > > > > > > 1. context fault with stall enable. FSR.SS set.
> > > > > > > 2. Report fault to client
> > > > > > > 3. resume/terminate stalled transaction
> > > > > > > 4. clear FSR
> > > > > > >
> > > > > > > At what point when you try #2->#3->#4 or #4->#2->#3 sequence,=
 is FSR.SS
> > > > > > > cleared and interrupt storm is observed.
> > > > > >
> > > > > > With #2->#3->#4 FSR.SS is *not* cleared and there is a subseque=
nt
> > > > > > interrupt storm with only FSR.SS asserted. With #4->#2->#3 ther=
e is no
> > > > > > interrupt storm. From this we conclude that MMU-500 does not cl=
ear
> > > > > > FSR.SS unless #4 happens before #3.
> > > > > >
> > > > > Thanks Connor for clarification. I get your point now. I think it=
's
> > > > > expected interrupt storm with #2->#3->#4 sequence is expected.  W=
ith
> > > > > CONFIG_ARM_SMMU_QCOM_DEBUG enabled, context fault follows the seq=
uence of
> > > > > #1->#2->#4->#3, which is spec recommended.
> > > > >
> > > > > so, common fault handler can be modified to follow the same seque=
nce, but I
> > > > > have concern regarding clearing FSR before reporting fault to cli=
ent.
> > > > > qcom_adreno_smmu_get_fault_info() is an example I gave but other =
client
> > > > > handler may have similar expecation of fault register not changed=
 before
> > > > > client fault handler is called.
> > > >
> > > > Simple solution would be to move the clearing of FSR to after the
> > > > fault is reported.  It doesn't really matter if it is before or aft=
er,
> > > > as long as it happens before the irq handler returns, AFAIU.  And
> > > > drm/msm will collect the fault info from the irq handler.
> > >
> > > As I said in the earlier mail: "From this we conclude that MMU-500
> > > does not clear FSR.SS unless #4 happens before #3." #4 is clearing FS=
R
> > > and #3 is writing RESUME. So no, unfortunately it does actually matte=
r
> > > and we get a storm of unhandled IRQs if we don't clear FSR first. You=
r
> > > solution is what v2 did and it didn't work.
> >
> > So, just clear FSR also in the resume path
>
> Then we'd run the risk of incorrectly accepting a second fault if it
> happens immediately after we resume. Not terrible for our use-case
> where we only really need the first fault to be accurate and we
> disable stall-on-fault afterwards, but if you ever leave it on then it
> would result in another interrupt storm.
>

Howso? We'd still be ensuring that #4 happens before #3?  If needed we
can add a param to resume_translation() so drm can tell it to only
clear FSR if it calls resume_translation from the interrupt handler,
or something like that.  But I don't want to lose capturing the FSR,
and I don't think we need to.

BR,
-R
