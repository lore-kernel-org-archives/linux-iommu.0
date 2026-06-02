Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4D23D7DF
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 05:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780377719; cv=pass; b=qIDjjym0KBnBPqPjLWN+MwJgHGM5gy9Y7nI61VrtQYoiYBmw26OQnivODzh/UvZMF1frbDuv0ksEEdd8jeOSF+s4xWlSjOoqd7s10+Hl+R+1n59oA0WzMfkSiSJmbWkOvMMSnLBJjx4DixadNgGyor7zC0P8JOYXfglV16ErCYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780377719; c=relaxed/simple;
	bh=sDwIHQZ/M8ghRBQC2xx6Ia0d1J96s2fbkGfMECF5nqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pk33gbRGgAOQQLTRQc613P2+obzg6LHqugnPvUUUBTQ5k7hv+vHRiwl3xyhgkT3Q6kA63MZzGHWU334DZvbslwnuWyByTElx8DSb4/Dh2RAvvWlEVEMZRNSrZ251wTuzxigCxI9Rr3HLP7x7CYiv6srMrfHtWJ41hLVf8O3gnpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBeA2m1+; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBeA2m1+"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51765331535so6891cf.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 22:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780377717; cv=none;
        d=google.com; s=arc-20240605;
        b=i2aPsJbFmb8AXi8iLvieNsTRR2UBCTCgjOKhHFtqjKr/lqyC39P55Iih10zymZKwP2
         MrVTZ89esUadCh6SoX/T/aTbgAsY8859igFfZZ0FlHF1NOs38MYQqEmRIHGAijOMlhZo
         y7uDNfHPqrvncRrYDvM/kDyh6h8gUfCet5Lm5VPIS5ZWbWI7GS+jFLrY1GT/kuulLw11
         M03XmleQAVHOZl+xh6jPiTd627uM0ka/K4YOZqrX8rDmWuuXhR6wej5fwE64mrgpH1Ua
         28viD02lS8db1nxuGz8dtALhiw/ULI5S2rKYeXtoDP+85s/y5HSkEJ2P/yiLJ3tCY/cs
         9Qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cw9pwdfqXs7Uf8CkrG+qExWtYc7my1Wo0i0PCQb18Vc=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=ihm/+u0cGD1ri5LTEDD1ynxedQSq4KZR/YoPnKkz/Hy+rnDrMbxS5jKC3ZEee+wcW2
         70HwJVUq9RW2iXetUlgBOilv7mSsx8pb2l6V5cUB/2TWFXYEggAr9tYR6v4gl1RwL7PY
         Iyfstb4SqpHg/3kYHJEVRwn9QXELxdseO+mlKw9yL44C7cMyXLGwWcshW95eGXKJD1oM
         j7pk178uUlSQN7U/z1XS0sfWw2KHGthtAvkBaBPex7vnTSDizUMDuhCWVWmtAq//0nyi
         7hDZXDOSQAkFHOY9rTFIWPvIHpi18yU4ItKEq0WDGINM4t+WsF57Pzn0nUA5V68h0zuU
         oVaQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780377717; x=1780982517; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw9pwdfqXs7Uf8CkrG+qExWtYc7my1Wo0i0PCQb18Vc=;
        b=UBeA2m1+Hs+xQmaYHY+xDlGYRSKwEpS5ztZwRzEN2qwtCWtosggLvQHZILJ9FrdIuN
         smWCNjDO1oYXMmSvDsAAf4AsK8pdd1QmpRyEAlZnCuBrBoroUw17Puz/m7WZA0wDv/sc
         2aiXLmbVMhm8c1m0V5fJkJMMl4uoMPbtK41gZFixlLnrgYpT7pjl4tyBNcacMNhglv1K
         r//AV3bFeGVzAWtNyyrDvch8N0YSXxNC0GOIoFVGh1rm+4tW4XxZfCEky3ch1IsuGhPN
         5zq6qlFsgQMQ39DCiSxcK2o8LxCuc4ImvgEu1CE+6v/GGbD2gsxLBuV0H8JUYNXeouF8
         DNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780377717; x=1780982517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cw9pwdfqXs7Uf8CkrG+qExWtYc7my1Wo0i0PCQb18Vc=;
        b=FvRmi6t1CzCAJSYiDODP3TNgmBJYjk9GMvPABJQtZpsEAfUfZtcmyrjNZA3OjpkDg1
         W8SVnRJCYwmJfnBPgt0s7Y3SJdOqeTCD6Up4mccwyBbmHTEJ4Ghn2F+UjXKqQKcdVsK0
         xiS4k5nMgIQGz8T0Rtbhkl3QPMRKN7eYl+BeeCo4z37GoLlE4HToPQ0lU9YjFfKwYhlg
         2inLxyhdkmlmxq3w3atnCOsK4f11ZFKtwFmALAUjwHa4z9S7mwjbip6koAYEKpAZ9Plg
         pI0LxVKltdOi6JV4LiTU52s9zt2j6VzLUdlSNEGcOOcPoD6n+OwL3qMjcc9XRt6+74wu
         Fn8g==
X-Gm-Message-State: AOJu0YyJh0x7Iw6KsYDZCgxJiO0oNELBBDpaoDt1VozJnnWeLUFYPpLr
	qnNDZjSFunMo3WFSQVMDfBiqAwRfbCBX8/S84RlRap7B9yHx28RHcj946OZ6Naj3TtV7jV9BMnD
	z84IqS13uR/syXB/4VvEJw6qtOzSF6W/gLHUi18sd
X-Gm-Gg: Acq92OEr4QZSidDAKoXTVqBY5te+HF9MU83phDvHUerrB64gYzZybKisA09gpXqrHCe
	UpyKYuKsTP0XliObslq2vTgGV0ii4n1gidvioTOTbkUvQ7cuZK3kLsGgQEbTlMwO+K6Z6eElQVc
	DXcBtkXjsJjZg6G5zWLJKC1TbZgT3YTgm/I6bSpx+xGtjTbaY/FiwumyW0elAzlUCiEfY8BdMp/
	QTyjCU6RZTV48791zK/loGxDHWqZM8wq4OK6ELdnPPgIpp7Ab+LXfhzSsdEG5mQ63OnarftxPG/
	e5yZGSYh5ERPKc4=
X-Received: by 2002:ac8:6a09:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-51768e2b6acmr4774221cf.1.1780377716459; Mon, 01 Jun 2026
 22:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-3-praan@google.com>
In-Reply-To: <20260601215909.3958732-3-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 1 Jun 2026 22:21:45 -0700
X-Gm-Features: AVHnY4I8YiX2irsMsb5ee3Kt3CCMgiXw2RB4C0Da9k4MnZupiKHlGq0wTuwc3Dg
Message-ID: <CAE2F3rDmhUcL7N+aAeK3P1uYHxuRVQidGH-o6_iz8Z9UE3zMbw@mail.gmail.com>
Subject: Re: [PATCH v8 02/12] iommu/arm-smmu-v3: Add a helper to drain cmd queues
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 2:59=E2=80=AFPM Pranjal Shrivastava <praan@google.co=
m> wrote:
> +static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
> +{
> +       int ret;
> +
> +       /*
> +        * Since this is only called from the suspend callback where
> +        * exclusive access is ensured as CMDQ_PROD_STOP_FLAG blocks new
> +        * command submissions to the cmdq, we can skip the cmdq locking.
> +        */

From what I understand, the purpose of this lock is to ensure that
only one thread updates smmu->cmdq.q.cons. The flag
CMDQ_PROD_STOP_FLAG might block new threads from submitting commands
to the command queue. However, other threads might have already passed
that point and are about to update smmu->cmdq.q.cons. Hence, this
assumption might not be safe.

> +       ret =3D arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
> +
> +       return ret;
> +}
