Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529905473B
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738117861; cv=none; b=Z9BOOi3RxvbErHLfqkozOfUPyHDfiN+9pDJFCI+/4EH+vZUwbiCbj/LymgFnuHjYB5CKZcs0C0SQq9JDGqvM6JywWWJbo4JVzglcENaGafcdpMcQMjw0kAX7wia8hX00H851BWi8zxT8+1jwJ8Rfe8TQunPGJddBXIwhDdjwvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738117861; c=relaxed/simple;
	bh=A5VajVGVILVmm6TPzJNNXCbTkkxXbO/J7eIt3AyuFw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPMcHUKkgbxYtMc07KWrPTmJy9jrxYaw1GWleVWBM+i+33QC66bRQKXDtTkG5BkrIKa285i8k9zWARhLS+7sFLfS2mXFuyDwYCUCbOg0NotaCpoUkyYyO0QLFFnhXr2zCTs6DbCp4tIV05oaIJSx/LuqaXrzfC6v/9MzSfl1j/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6260py2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6260py2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so1492987a91.0
        for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 18:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738117859; x=1738722659; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSly2TaNffKLGTngVYEFGfP2OiXY7SuVwdUXwB6ys4U=;
        b=f6260py2sRXGt9AoNlZfHomD3J5Y3EcDD6KgsagKB9QWeW91AOuRlz1n5TGzPkjw5L
         gl5rODhjOHlh7FzLXQAFRl3CTGqo620vfuZ0loVwW7QIInboV2W8jCyzaKFc0G6UyLsZ
         wwOoBWnpI2sijpdF3VwkOJy4w9zs+NxtZU5R9pSjqFySfUmqUJzd+qXu8yQ6WaKx9R3f
         0dVZjd+KYDC+vMINIQ0+zj70dCjdVuxheE6ORCPmslYXhsDs5OSAQt57HDb2gDM8ObK/
         DcUeCCKSQPVlTWSj+FTcs6fILYRuN0zxwZpcSey3LPekCZ+oEyJgxBO1j8OqzY2sudgV
         ChSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738117859; x=1738722659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSly2TaNffKLGTngVYEFGfP2OiXY7SuVwdUXwB6ys4U=;
        b=br2WIHRLYygADJLa6+hIJxuJVyaTjuoYA++YB+Fd0tvyjmDZ5uoHYNsEXrur13LcMP
         JpyP1rj1hFx+qm7l7wo7PhhCzOGrulKDVhgmEiSMJOILB6U05Gh7hppSjvEFb3+fO/yR
         b6eF/1AACgOkHgfebPVM0mzAsxSd3E8tWauVbpDxo1h68myuGSA103+d6qebZ9shUW0I
         PZ68yOkejbIKmmOY+Gty5MVCM007t0GqszQWbeh9XpdTGLuPg5HKeMSQemxuA46ZZzdc
         DQeqvmi7kWARk1Kd+6p22qohq+H9Om36V5dRideAP1Vk9VFrC34p7O/p8GkhXL1NcJtg
         75mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7wbhSF9vRa2kHhc1eGnU1L5PyL7cZD9qmjfpyLMf2S+vAKJtETJfB/euAox0rADgBy/u7Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyD6+6/CzWpo8r9I79nhUc2JHH9NxqSOy4KmXRB8/L6qU/3Feqg
	Hu4gS9JJI3uMu/f/Z3xgdpzsIgRcUWMT79vdWNUkD4RI77N17Q3UEaDKdNmxxMuTX0hx5UdviAe
	5dx/1ognO2868g9px6CI3p2z/EbM=
X-Gm-Gg: ASbGncsoSq5j/hi6PArj8NcTwyPpRlSVNUNtWmzMdOk5zcgOUa0T3kIfs5TfHkJ18oc
	8M8F7M0okMeBNbwBFrmxWx9VPy4hWHJbL1T7PbNDE07PE9qSt19ZWMp8XTM6IMYEXAcXLEZ78
X-Google-Smtp-Source: AGHT+IEjgYmsQ4btVO6NoeAtHUBYo6uBU9FQXTRAoppwQkfpqn+YG0TztYlkbmmr8DweH3LafBf4eykvGJwllpwO6II=
X-Received: by 2002:a05:6a00:3920:b0:72a:83e4:42e2 with SMTP id
 d2e1a72fcca58-72fd0bcee41mr883477b3a.2.1738117859086; Tue, 28 Jan 2025
 18:30:59 -0800 (PST)
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
 <CACu1E7HErZAL=-GVQfKUAUK5bgK-X0qejt5os3f2UhkeZ1ptMQ@mail.gmail.com> <CAF6AEGsUjp+fp1_cN7SGYTh5WSQrU2mm92QsqA5rcSY1OtA8VQ@mail.gmail.com>
In-Reply-To: <CAF6AEGsUjp+fp1_cN7SGYTh5WSQrU2mm92QsqA5rcSY1OtA8VQ@mail.gmail.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 28 Jan 2025 21:30:48 -0500
X-Gm-Features: AWEUYZnXKpZmksZEDv9wE4ehxlAcfC2ZYtvFlEvNuv90BQMKMLlkT9uISLaRedQ
Message-ID: <CACu1E7FyHwJ2mp5u3rDganYj80eDq3QJzLRFzxD9E9O7hEDiag@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu: Fix spurious interrupts with stall-on-fault
To: Rob Clark <robdclark@gmail.com>
Cc: Prakash Gupta <quic_guptap@quicinc.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 9:21=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Tue, Jan 28, 2025 at 2:15=E2=80=AFPM Connor Abbott <cwabbott0@gmail.co=
m> wrote:
> >
> > On Tue, Jan 28, 2025 at 5:10=E2=80=AFPM Rob Clark <robdclark@gmail.com>=
 wrote:
> > >
> > > On Tue, Jan 28, 2025 at 3:08=E2=80=AFAM Prakash Gupta <quic_guptap@qu=
icinc.com> wrote:
> > > >
> > > > On Thu, Jan 23, 2025 at 03:14:16PM -0500, Connor Abbott wrote:
> > > > > On Thu, Jan 23, 2025 at 2:26=E2=80=AFPM Prakash Gupta <quic_gupta=
p@quicinc.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 23, 2025 at 09:00:17AM -0500, Connor Abbott wrote:
> > > > > > > On Thu, Jan 23, 2025 at 6:10=E2=80=AFAM Prakash Gupta <quic_g=
uptap@quicinc.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jan 22, 2025 at 03:00:58PM -0500, Connor Abbott wro=
te:
> > > > > > > > The context would remain stalled till we write to CBn_RESUM=
E. Which is done
> > > > > > > > in qcom_adreno_smmu_resume_translation(). For a stalled con=
text further
> > > > > > > > transactions are not processed and we shouldn't see further=
 faults and
> > > > > > > > or fault inerrupts. Do you observe faults with stalled cont=
ext?
> > > > > > >
> > > > > > > Yes. I've observed that on MMU-500 writing RESUME before the =
interrupt
> > > > > > > has been cleared doesn't clear SS. This happened with v2 in t=
he case
> > > > > > > where there was already a devcoredump and drm/msm called
> > > > > > > qcom_adreno_smmu_resume_translation() immediately from its fa=
ult
> > > > > > > handler, and we'd get a storm of unhandled interrupts until i=
t was
> > > > > > > disabled. Given that the architecture spec says we're suppose=
d to
> > > > > > > clear the interrupt first this may have been an attempt to "h=
elp"
> > > > > > > developers.
> > > > > > >
> > > > > >
> > > > > > Just to clarify, present sequence is:
> > > > > > 1. context fault with stall enable. FSR.SS set.
> > > > > > 2. Report fault to client
> > > > > > 3. resume/terminate stalled transaction
> > > > > > 4. clear FSR
> > > > > >
> > > > > > At what point when you try #2->#3->#4 or #4->#2->#3 sequence, i=
s FSR.SS
> > > > > > cleared and interrupt storm is observed.
> > > > >
> > > > > With #2->#3->#4 FSR.SS is *not* cleared and there is a subsequent
> > > > > interrupt storm with only FSR.SS asserted. With #4->#2->#3 there =
is no
> > > > > interrupt storm. From this we conclude that MMU-500 does not clea=
r
> > > > > FSR.SS unless #4 happens before #3.
> > > > >
> > > > Thanks Connor for clarification. I get your point now. I think it's
> > > > expected interrupt storm with #2->#3->#4 sequence is expected.  Wit=
h
> > > > CONFIG_ARM_SMMU_QCOM_DEBUG enabled, context fault follows the seque=
nce of
> > > > #1->#2->#4->#3, which is spec recommended.
> > > >
> > > > so, common fault handler can be modified to follow the same sequenc=
e, but I
> > > > have concern regarding clearing FSR before reporting fault to clien=
t.
> > > > qcom_adreno_smmu_get_fault_info() is an example I gave but other cl=
ient
> > > > handler may have similar expecation of fault register not changed b=
efore
> > > > client fault handler is called.
> > >
> > > Simple solution would be to move the clearing of FSR to after the
> > > fault is reported.  It doesn't really matter if it is before or after=
,
> > > as long as it happens before the irq handler returns, AFAIU.  And
> > > drm/msm will collect the fault info from the irq handler.
> >
> > As I said in the earlier mail: "From this we conclude that MMU-500
> > does not clear FSR.SS unless #4 happens before #3." #4 is clearing FSR
> > and #3 is writing RESUME. So no, unfortunately it does actually matter
> > and we get a storm of unhandled IRQs if we don't clear FSR first. Your
> > solution is what v2 did and it didn't work.
>
> So, just clear FSR also in the resume path

Then we'd run the risk of incorrectly accepting a second fault if it
happens immediately after we resume. Not terrible for our use-case
where we only really need the first fault to be accurate and we
disable stall-on-fault afterwards, but if you ever leave it on then it
would result in another interrupt storm.

Connor

>
> BR,
> -R
>
> > Connor
> >
> > >
> > > BR,
> > > -R
> > >
> > > > > > The way CFIE disable is helping
> > > > > > with current patch indicates write FSR is unstalling context an=
d subsequent
> > > > > > transactions are faulted.
> > > > >
> > > > > No, it does not indicate that. The interrupt storm happens even w=
hen
> > > > > there is exactly one context fault, and when the interrupt storm
> > > > > happens *only* FSR.SS is asserted. I've verified this with debug
> > > > > prints. Once more, MMU-500 will assert an interrupt when only FSR=
.SS
> > > > > is asserted. This has nothing to do with subsequent transactions.
> > > > >
> > > > > > Do you stop getting interrupt storm after write
> > > > > > RESUME.
> > > > >
> > > > > Yes, as long as the write to RESUME happens after all other bits =
in
> > > > > FSR are cleared.
> > > > >
> > > > > > If you can mention your SCTLR configuration and FSR state in te=
st
> > > > > > sequence, it would be clearer.
> > > > >
> > > > > SCTLR has both HUPCF and CFCFG enabled.
> > > > >
> > > > > >
> > > > > > An aside, If reducing delay between FSR and RESUME write helps =
then both
> > > > > > can be done as part of qcom_adreno_smmu_resume_translation(). T=
his will
> > > > > > follow spec recommendation and also make sure fault registers a=
re not
> > > > > > cleared before reporting fault to client.
> > > > I think this sequence should address the issue you are observing.
> > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Prakash
