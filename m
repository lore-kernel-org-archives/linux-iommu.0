Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A833260C
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786390; cv=pass; b=buTYG6jDKJTdPEZvYRitc2Cf4ghK01YzdvlXaiFMDcw2HKT+LAiLF8kVOWgZCKOzFcmIUT3ypqFA9kxzEsluMQKl0jr1hEzACaMfyomdpJZ/Hrh0oNYfr7rU/QhHpasWPwXDqRwI0q5cVqKlpe/cXO0bLQhFVYmr0Soa1qZxZjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786390; c=relaxed/simple;
	bh=aNIzssZF1mCdwDvYrowlE2QRzZGqZukXq6lVCUbnLaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBGC7TWWaheCfmhyEFYpl32R0RD43Qf30/1usY4XjqS6PSxxPaLWYQkPXcXvil35cQ9c10gxbwav4h7Dy8xqYRTrVsvEiu1uprsvKPV2xre+5jjzCAM0iMz8qjWddDC2YLZE+WdLfOzu87xxppjUwqPgEfshuyNBn+arFdxzGlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5df9QpL; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5df9QpL"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d836552daso2263111cf.0
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 08:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776786385; cv=none;
        d=google.com; s=arc-20240605;
        b=TE6WPhUkacFsHesP8wVAL32ZEG8XMUGYis142++na3PuV2yLIpzk9uOEYHbNUepEkD
         0dlPW81zSJ56+hOHuanjHZFQT1yvchy0j5Dj34jORBW2hhwJ/o82fodXVahjWVuSepOq
         u2OEGmps8fHcdrMwD+S0wPO1Ia7W0EWYBYKXf5mpZhiGcBMTo0/L6YH8MHwiOrOZeILc
         pK3+sKq1ZArYLB2HmNCexTgS0Dsc9q1IHhZwth1JS1/Ce8IM7HeFCSvXUtWB26ANOXnZ
         PV+aqLbWMoQe+rNOHHG8ZF7yA78dnmMPLMjdtSRy1QNQPzFsBJ3Y9NgP4Zl2WhV2yyDa
         LubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TnVwTRdqPcgRLPJx4buQ5MbgZ1kP/MbEe0TYwKJ9srY=;
        fh=l6d/N6u1hLHPo4TGqiX7B6XhUFrf2YjgyiVnG6QkPqQ=;
        b=hNQctXcM9vx6oiNeK3Dz4v/c+SJbWDrax/8P6w1/VBSq5drInkTJYzlzYcYDXW5qpo
         VyiP9gXlyydD5zSptazPOcPt/NrXSU3C2s7VJEKADk7QMlhhwe4vxioFpWPJRUk2Vihq
         XesZbCjyZs4xZVoTYKUPCvSIz1wjy3AbdudWHtggkng0ELJ8Aqf1Q+mKWbDl3/B9Ibh1
         yLK8r6DEYNeW5mdTkAqOEkumyJCL+wdmEKZaBTxLm9AZydVRAFNohFLTTmbFKGzlcQos
         S8IM4uDGn6K3O0EnbmyS7Gi8XkYgs7vpbWaxKlBfZp9zaFG+PUK2YlpsecZujzCwO6Td
         5cng==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776786385; x=1777391185; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnVwTRdqPcgRLPJx4buQ5MbgZ1kP/MbEe0TYwKJ9srY=;
        b=s5df9QpLmKHkh8OTrWk6A+XoHp4n+GHjyN8Mj2x6BbZyldSE2obbOPVND1uTirb0Xk
         tq/QwGDdFrE44uREYY6eyGOpqvKlxZfLARlH69NuxHcQ9tf1qPcQ2/27CUlfaEi55uGi
         MIyAgypYxuCi0BnXz7EVjuoJH4vgd0Y5T8HN6hzyiNzW4f4WkDVTp219ro32PX/mbdyl
         j0YyNvuVGyYcjhdE2MaXWylDm+wuqZXulYBTp4phqWCpmkZQjIt7mgBL2/spqdlgsYk0
         qy9FVETUJlAtpqZ972EYfcaQphQ2T/0r+qXrAapy9k85QNRJ60uSxp970gHOTBbHiIeD
         bdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786385; x=1777391185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnVwTRdqPcgRLPJx4buQ5MbgZ1kP/MbEe0TYwKJ9srY=;
        b=eM3/tcN3CRPUrFPcfN4w4+ZNW9yKTD6cigEgXyh5cV9Bw63CBon1L2ZhfEuedDgPt2
         p/ciZNtO26DHW3hERODm7kW1Jgtyjsx11XF3+MtQwp2Bh8Z8ZEDGCyaOHCEo2Dh4uPmy
         86aP2gxx7orQlPtQU9PlauFzRPjVAKNpLGI7HbvqvnsSOC+gZY7LwLrRZ9db39nZxCkX
         apEPdyKElr+Odw0ebR5a/jzgtST3vLyfw4D1uJ/O4/Gr19EIlRMkbADa7xFPYKUknKhS
         /kdgPVsHOq7H7L1X8uWa44zlf1STyiXitJNHf952cYKQlPkSviscy3/NmJQ9dbGdolon
         5Pcw==
X-Gm-Message-State: AOJu0Yys9rTnmvilPqVzEARfY3mNDHn8dlVIPvMtwCJFv+gp2XUCSCsq
	CYI0Qb7A3d5GIRpoGM8hncClTr73jz1hFr46Z2089N3cWQr3UVhjDCTrmAupzi/RRpbGdpbdFXL
	iGPM/G4vhTgtAbjgABvOhn6GsghEqah4G34Rnidnh
X-Gm-Gg: AeBDies7WEoKLdEryeGHimcMsozPhYqr9Gt/VFso2d+5wRXgOfQy5R3Xp+tylxmVjfh
	11540H4y+6WTIkoxzbJp/qQbc7lnWzg4taTv050UXf/RTd+v6ZF1TlXkvTYex7SIquxwYqYW4YW
	3yP5lQFb5ZPuyPROJu8K00/YLx+Ee1i6d/RUO/x3AtNX1Bu8bwTlFMnGmkWVA0zJJOasIG0CXrw
	2TYM8TmTezkCQQxUtBfJNjWfi/vZyqydPnSl3LdMb8LBIXUnLqBY+RUUxuxD1l0XR/Scz8Xn+b4
	rCDwdad/wvfSRKPB19uLw4xAXA==
X-Received: by 2002:a05:622a:d18:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-50e42a6347fmr46462451cf.14.1776786385034; Tue, 21 Apr 2026
 08:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com> <20260414194702.1229094-8-praan@google.com>
In-Reply-To: <20260414194702.1229094-8-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 21 Apr 2026 08:46:12 -0700
X-Gm-Features: AQROBzA0vdH-OEhHYMZ0VN9oiFyYET8tY0kQRmUjfGi5QXGHGVn_bC4g_IpfELc
Message-ID: <CAE2F3rA-M2czg8uz5+Gjrwk6LPvXUb2EJEFwy_QnSm1ZaDiprg@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:47=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
> +       /* Clear the STOP FLAG to allow CMDQ Submissions */
> +       llq.val =3D READ_ONCE(cmdq->q.llq.val);
> +       while (1) {
> +               u64 old_val;
> +               struct arm_smmu_ll_queue head =3D llq;
> +
> +               if (!(head.prod & CMDQ_PROD_STOP_FLAG))
> +                       break;
> +
> +               head.prod &=3D ~CMDQ_PROD_STOP_FLAG;
> +               old_val =3D cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, he=
ad.val);
> +               if (old_val =3D=3D llq.val)
> +                       break;
> +               llq.val =3D old_val;
> +       }

Can you use

atomic_andnot(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);

here?
