Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719E314B96
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124285; cv=pass; b=fVa2w/VOIcLhpnyz9GJ8kG66hOKbUhVWJRyeg6gKkYj440ti6B9DgvobGE7y/yIi2A2NBfZZD+qqADIwA+FTVMO7IcMbN6N9qxHM9NeaIKHLnPOgGWRhOaVo0FxtjCp+jyQRNxp4frcaebrfRnFCQd+i/ez/BJj+DcbuURvh72g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124285; c=relaxed/simple;
	bh=BPnHPaOzD2mkdxnV/uDsx0VTY1WsSx3aobXaV8ATF8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLcXXftREGqxeqrIUEnKGmMz3y4lPo8dvu4ep0uQF56JiOcfo542fFQ7xtZA3mE+7rssHIP4OK/EGInjj2J3Vn7NZI8U1nuStlv8KqjrbLLq3E7++6cqEdyUcJ/390rR83ZV2lfB1Pyq7REjeeTjUARsGOgCmhbY2+D6hgGYQDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkXoUqPM; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkXoUqPM"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c01c79467so271961cf.0
        for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 14:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788124283; cv=none;
        d=google.com; s=arc-20260327;
        b=IAXmCqQy51yfrtmNxzokgJ4SgMVa+I6Xb2wcI4SmWxfoxIR67H4HCaXQXoynm/JNpY
         oDC+ORRQ4LyqSUztmLHY9tTCJVDOZE3G8qQ9uzJF5nDJchcNQUQ/oV98cQxnWqT0d5jB
         40v55me+Jpu+sAyKy0/+0F2w2KsHs20sTcZ04DzWwQFfxBVbRqdfmIeuB8AY9DCaBxns
         CcCWoSrnrogFCytwINVhrl8SYxHCDzIKKRVf/+PSzVxUhLWU1CBbSNQjDp1WMMf/euuW
         45yXxc8DtLAcfqLh9OallXI78YkymFiWuez3gEbIXenF2Y435wGmaQ+yBBogheYlJS5u
         qt0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LvoT0ABXJ37oRXJzczpVIrP9vDVAFqUkQqaM10ticEQ=;
        fh=L65e3OnlhDOZ603AHwa0/iBt5n1+v+fYC+T8oQVKUwU=;
        b=g2Q4lF1ReUirAGP8l2jRE7RcBmPwESEZj8p6yUq9ViDHOd1lvMAgLmlPWN3s+xOWLG
         SVVrfDY05EjKkDGwYHet41VNiyUWFtjDhg//6aOZXLNECB23diUpXR7ydtpIiUrhCdwx
         yr3PYzh+8UoRsjbIEMgLbyTCfoChsI8jxKdEOK/AiVXTnsipV0WfiwZEVa77mFXDXu8q
         YX5LvlugjqxJ8ZjxhkSL5lOa0nxy77VzOq7Z+jZlm5nK0i1DNL6jN2NoPmpVoW7zxt4F
         aRLWNWMx+5H7QYpb3ekWNcwP7FnOZi+3IAiu+fA25nALwfiDvADNs7iKqT+ZPiF8A4JT
         uThg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788124283; x=1788729083; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LvoT0ABXJ37oRXJzczpVIrP9vDVAFqUkQqaM10ticEQ=;
        b=OkXoUqPM7U8jPiR2UZxCnN4LZqJzfM9zk0llejR4D2uDyDQ7inyA4K/3dZYjIrw5Cf
         TR70FEiYT7/XXckhlNjaos0CZ/ZINjvnDhjtugxR+LXvb4WzIey3mIbpHRHKyhzHktO0
         hu7X9VKFndG7K8fmPKwIQcnB10HRwolkihLgzPAuBtyenZchqUQcV/GoXaf5GfIfm8do
         ZMmJb3OLsedYTuUAbhPumed2zXF+8h2D80Q2M34sS101TDDljCP5DcWmM/WJNw7faTr9
         SOPkbeqa13MfPEcuWb/pXjngF738MxM0/B8yMLBN0uCLm/nmzZz9Sz/MGdwvzXAK6kSP
         DATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788124283; x=1788729083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvoT0ABXJ37oRXJzczpVIrP9vDVAFqUkQqaM10ticEQ=;
        b=JiMzqk1vHqG6B9H1wOuc30LoIuUK04QHBOpbbmIwznuT6rifd/HWRYpT6ZxqbPeN56
         jIIsHkW6R5IB4rtbip2L1Oy8R2oX71BV+BobBjPIdqVG1N6W98G77yf1NMRPmd3seR5x
         tSUZfLtjeZxr09x0hT+JlYROjd5TwQX9GffqgCDryAG/OnTlzbn5hfioX+SMuO5DsAdd
         e20NmcKEOfe4jsdHsy1e6VWMzusP31rWW8lXRBvXgZX4Kr1ULSeM3Mr3yIDklQCu0fC8
         kzLvg1gbBMrqJMeyHjuGk8BSKPgpRP302RSHYj4yypeBtHNAjUbEHezn/ZhIxfIS92m1
         0mQw==
X-Gm-Message-State: AFuF++kpHo9eiIgNiRC2Llg4P8PX1tfoey3yLZWUx6IHtuPNJw/mzPqX
	yE3wRFMOFzYDFOQLF9+BKN9wB4T2RuWFDAsCdPTK3VXX027nFCYeb/JSrc7Qk3aZDJC+YL6daOl
	URZ0akfiLEAxiDFHaO81B2rA+VGoV3KTB6kDMPzjt
X-Gm-Gg: AR+sD10xnsxvGysEQbR0TCYxisw17VYBLgqy3wZ3okgV97Gh0/pAIffuMVT7l0rlViq
	ZcAh/uAJG36pxFo4mWKGh/hiC1Rr2CUHwHlsAJ62OmY7aKERJ3dQ7UTtQqE8zmNMGTZXe8pbNeD
	4a7A2XL99RTVqSngZlTtUbqOU5F3AAX3dBUbD/pSzDtP13uKRkyK6bgTPsChxVhfRbvYYEkqFgl
	mmtdPD+nsbRyom2qXjbKu6OWb1jSJoASNN/QAWJa1FcVSDhHxaU+MUqfHfRJ2Sjh0PJ/N4Q4/Wv
	ih5+bYY/BJFuKehubSq0cNtidc1wd0EAbFr/tPi7HQ==
X-Received: by 2002:a05:622a:1826:b0:52f:4a75:f840 with SMTP id
 d75a77b69052e-52ff73abd47mr20315321cf.9.1788124282089; Sun, 30 Aug 2026
 14:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com> <20260728210928.1050849-12-praan@google.com>
In-Reply-To: <20260728210928.1050849-12-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 30 Aug 2026 14:11:10 -0700
X-Gm-Features: AcwNN1WSE_2VKnc3OTfaU7trfJzE4w8fa_RgAfFK9wTt348qCgdtkmoNL21lY6M
Message-ID: <CAE2F3rAwUpepQ5UfXuGdDGUzjY+4Xo9ttjyOUKY=7xyyA41j+A@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 2:10=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> @@ -2386,6 +2407,34 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, v=
oid *dev)
>         static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>                                       DEFAULT_RATELIMIT_BURST);
>
> +       /*
> +        * Use a non-sleeping get to avoid a circular dependency deadlock
> +        * with arm_smmu_runtime_suspend().
> +        *
> +        * When using a combined_irq, the suspend thread waits for pendin=
g
> +        * threaded handlers to complete. If the IRQ thread blocks waitin=
g
> +        * for the PM core, it creates a deadlock:
> +        *
> +        *  [Suspend Thread]                  | [IRQ Thread]
> +        *  pm_runtime_suspend()              |
> +        *    state =3D RPM_SUSPENDING;         |
> +        *                                    | IRQ fires
> +        *                                    | arm_smmu_rpm_get()
> +        *                                    |   sleeps (waiting for sus=
pend)
> +        *  arm_smmu_runtime_suspend()        |
> +        *    ...                             |
> +        *    synchronize_irq()               |
> +        *      sleeps (waiting for IRQ)      |
> +        *
> +        *           <=3D=3D=3D=3D DEADLOCK =3D=3D=3D=3D>
> +        *
> +        * A non-sleeping get allows the thread to instantly drop the eve=
nt
> +        * if the device is suspending, safely bypassing the synchronize_=
irq()
> +        * deadlock.
> +        */
> +       if (!arm_smmu_rpm_get_if_active(smmu))
> +               return IRQ_NONE;
> +
>         do {
>                 while (!queue_remove_raw(q, evt)) {
>                         arm_smmu_decode_event(smmu, evt, &event);

Sashiko has the following concern:

> Does returning IRQ_NONE here during transient PM states cause an interrup=
t
> storm or data loss?
> If the device is in a transient state (like RPM_SUSPENDING), this lockles=
s
> check returns false and the thread aborts without acknowledging the hardw=
are
> interrupt. For a level-triggered interrupt, this could cause an infinite
> interrupt storm since the line is unmasked on thread exit.
> Additionally, can aborting early here cause pending events to be permanen=
tly
> erased on resume?
> Because the thread aborts without updating the software llq.prod index vi=
a
> queue_sync_prod_in(), the stale pointer will be written back to the hardw=
are
> EVTQ_PROD register during arm_smmu_device_reset() on resume.

I tend to agree with the concern about the stale producer index.
Should we call queue_sync_prod_in(&smmu->evtq.q) in
arm_smmu_runtime_suspend() after disabling the event queue? Also, how
about printing a warning and returning IRQ_HANDLED if
arm_smmu_rpm_get_if_active(smmu) returns false here?
