Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6AD1ACEDE
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414056; cv=pass; b=P2XnqnzWbc3UXDjvKKVX9qDu44fh7g1zjTij6IE3i50zfKfLLW6CQINrNtKJ1rCJQgbYRYNZgD8fKuEDTGUpqBjhztiwAZVrxAsmemFOijJ5OIew3Y3zSGG4ASAmP9VvnpOouZ64sOca3ARzMFWko1SEDf9ddJX7+jUuVtNHuCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414056; c=relaxed/simple;
	bh=36CJoZULkIPeuGYFzk0VqQFUVWjg2o/pDk/t6tDTzAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JG94F2gDC3JGtLS6//J5v1RAzm4qgNmsgIYDbAPFEVxKvOqUu6T2wcLsVGt/tj1K6ngU1+QRaW6cGUQXmc5GLJRYypNQ4BjO0dIaTmrP3btvvQDfrngeC6RZC036B4BJQFpQhhVVBfbk9NWyjbu1/lXOMPNtRMvcbNZqpeMZpks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZKqeIxx; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZKqeIxx"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765331535so7261cf.1
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 08:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780414054; cv=none;
        d=google.com; s=arc-20240605;
        b=b5Eaf54Yg3gr4SAYyar74T2ZhtGx7Ymz25ZEzojLUjtGNNG/JMMSwCzJA7RklwE9cY
         kfrbt8vZ2x94PE0URhpCnnB+llMKYOQdJh6gPA5rTMOybgJpKuHB7o3JIfe4HC5PDi68
         8hdd/ypDyizqR1CGhxuSVYZplp3xpn+WnJK0i9YEr3dc6Vkzgs14sDtuaoaNUchIi/6y
         P9KDNURMxw6+tbp7IIkgR4VAC4+J8KB2Tr67HL15S75kYl2DOyZFVwS4F6bQwMF1LS1c
         497sG5Mg7kwWaLR5xVjrPRuMq4+1Rbx7agCn1umhcFh7TmtWqaTGZBClwC6QL1HLx5iq
         QySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IoL22FIeKfAXh+SYG0vrRqgXDdNNko8Yfwwz9xbVvfg=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=IDjCGWpTcK4KJluiBQ+Jnv78i6SX052QIf0IL93x+yWiDAepztSxZz9ClFZ62yOZhF
         Eu+J4AacE7PSK48/gn7AREKeN2CQ8Yzx488+3B7OryL7HE1TJ4MSKob+mEjIPP9Ocj5j
         4diqHUERQW/Xh+dhMI65YhBrJ4AlMhHKXw2ug5oHv2WMgPTg1+MvpqkDiYzLsXdUWO22
         dBgpWaXZiZmK1o0VEhusoaG34vvo8OScSNUKbNxQVGRpZeqWh44c/I3EQZRKTvH6ECwy
         QwyrULD4Z+ibRiM74+TIbeLFrUGtcAovRXy6Z/tBu4h6Fruk069ijqnqYdhoEH/os5XI
         SIYQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780414054; x=1781018854; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoL22FIeKfAXh+SYG0vrRqgXDdNNko8Yfwwz9xbVvfg=;
        b=gZKqeIxxD/uD2mm+x1yveSzhKuWWvBF58yZCX9eBpWOIzlVZGyqdQPQSVuIoXW/KkV
         E8Xc11HhUG8VjIkrw64EsoW2RbAkIzVUXkdogNXzV4Qq3b+z5YrnUw8DR/noBaLnRQfh
         HkUFOLeng7qJMIGUFGMcffoB90hkfrdu5seupeajNO7bVoHSftpLRYpfD0K7/f3Il+sz
         b+fENBN2Ufcik/JiqB2z2jDvK+vhUVuVAPJHZ3SyHlfhd2KHuh4OW5G9l7QRGoltQfV5
         l6wkZegv1ea1SjNsDoCRQq1Zfh5Wzx6RSg16p4OASmajG3KgbvbfJxF9N1pwXnNn8w9z
         WQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414054; x=1781018854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IoL22FIeKfAXh+SYG0vrRqgXDdNNko8Yfwwz9xbVvfg=;
        b=GrDWHhNZ/q7agRPiZje4FhjxFR2D+yp1JGpQTfRxe7HDHzp/ihPspUnNRy2hTjJvvx
         bRfbKp1fRkCkuuXCIhdczywQS+wVh6fdAzTU4+8YkaECRj2cQRNJL7y7+tmaGgolvRAG
         oDWFJykR+B/AS2yWEZUDTeOSD/NzPqdJ626VLr79J05WZYMZtxqjYROq20ciIGTeB3Pn
         4EI8aUj1zWVISwGnuhd90cdVvABWt7gnr2ATmmgy89a3z7GfeMj/INtUk7rS4TrWKSoA
         tZO6lneqBv201h7J4HKLH0In+0plxKr054WI5Er/6Y4llrUCd05YD7xeYzBmBG3+iTX/
         bDbA==
X-Gm-Message-State: AOJu0YwbQbJxSjPydhgHI8gRkiwBxtpWQgobxEU0AwpRvMWJ1chtsrCr
	wINBKh6Muav9WPG0otZqpTxS0ImAw7FfIXQzqJCykMTjMWJASEa8I3zZ/gmr2olKWtHmHvEKau1
	I13HKRk+10tB6zo41B/nEfGFNLxKEhmRb+BCq4Oo2
X-Gm-Gg: Acq92OE0kwMTaxATc2B55k+tvz+c5iekVezvGxUnGIkMu/lmKFFYuuDklzL+P1lNMbW
	83c3Iv6Tu55fpdDZmL8E3f1ezlFA5bNOAyHf/aTxKvkl3qVmsAESjfeAu/DKA/5toifjIWUjBR8
	X1n3tFJotzsWAYiL9PEGY6OXrvkL4URVdxGGCeLWkQLTIKHFK4xNuWLVrLI+VjZvHmii1Sq04Hd
	+eIm7hhHgO5OckdwIEEm88hQHMff71zMlahyaac6t/7voPU3CTadKQdTIqISj+zKmIJ0lZMYnB4
	yuWtEJvtdp5jwur71SRYr40x0g==
X-Received: by 2002:ac8:5497:0:b0:516:4f62:85ef with SMTP id
 d75a77b69052e-517670ffcadmr12205751cf.20.1780414053704; Tue, 02 Jun 2026
 08:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-10-praan@google.com>
In-Reply-To: <20260601215909.3958732-10-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 2 Jun 2026 08:27:22 -0700
X-Gm-Features: AVHnY4JtchXYcXtVOWWrA9WzUeBrl1Y_b5SMm__JOC9anLOCtO0FRHxOlKdqsXA
Message-ID: <CAE2F3rCTHZOiSx5tTVmLmubJ4SUDtXvCX6oLqsdEsPAFTKJZ4A@mail.gmail.com>
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 2:59=E2=80=AFPM Pranjal Shrivastava <praan@google.co=
m> wrote:
> +static inline u32 arm_smmu_cmdq_owner_prod_idx(struct arm_smmu_cmdq *cmd=
q)
> +{
> +       return atomic_read(&cmdq->owner_prod) & CMDQ_PROD_IDX_MASK;

Is this masking necessary? Can't we just use
atomic_read(&cmdq->owner_prod) as is? The only place in
arm_smmu_cmdq_issue_cmdlist() that writes to cmdq->owner_prod already
applied CMDQ_PROD_IDX_MASK.

> +}
> +

> @@ -4839,6 +4876,10 @@ static int arm_smmu_device_reset(struct arm_smmu_d=
evice *smmu)
>                 return ret;
>         }
>
> +       /* Clear any flags from the previous life */
> +       atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.owner_prod);

Same. I believe CMDQ_PROD_STOP_FLAG will never be set in
smmu->cmdq.owner_prod. Hence, clearing it shouldn't be necessary.

> +       atomic_andnot(CMDQ_PROD_STOP_FLAG, &smmu->cmdq.q.llq.atomic.prod)=
;
> +
>         /* Invalidate any cached configuration */
>         arm_smmu_cmdq_issue_cmd_with_sync(smmu, arm_smmu_make_cmd_cfgi_al=
l());
>
> @@ -4898,6 +4939,21 @@ static int arm_smmu_device_reset(struct arm_smmu_d=
evice *smmu)
