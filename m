Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C033219FC
	for <iommu@lists.linux.dev>; Sun,  4 May 2025 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746390508; cv=none; b=e5tfhsMFG+dln+hklnzkd/QFRNHt84+aXma+4zGwJAa7QyOP2YvcVXiFOZnT6LOYv6PCtmPDFF2ik3jq0sOrjosJGOFCiu4CgQh5j/ZcoiLfU2qbKkg9sOXXBoi2JIDEZzLTsa/RnbN4bvewgGQjfvYPW/70azlvRmfFoSSVfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746390508; c=relaxed/simple;
	bh=wAeAr+uNtpVl1oQgRhJT5vrF5gA7kAL1wBSt5zC0dNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk/ffG80SwfogcnLG5umIKeLacmHrQ58ymhUSmdIyctFDGR/MGUNA7noevcMrEj4uYPAroB8SKfh4VMBfEWtqJusaQ/+LbDWJwvog8jPviyPNsh6wvWhomu7eSMpEPXq0iOuMj2iBuKxx+tFZrwb+qhoS9++WoIsfOBGjTjxvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mi9JNyDH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mi9JNyDH"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso3578a12.0
        for <iommu@lists.linux.dev>; Sun, 04 May 2025 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746390505; x=1746995305; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma5VTZtN43eHKx9MXoN2vndgZGyS3IQcfMzkFZsLVr4=;
        b=mi9JNyDH/a+vkWVIwSwNCKiILj1PhVMfnNSyyD0KG4jnOYZ7OUw0rF8uPPGuBvnpSf
         +Cdg4Cm+At2jTJL11/6Qfe3wcp9kge0zRUd185nZy/OQT3WIWxl3YCSdj+5Y0PZw5CZH
         ShzQp8tOTCzHhaI4Tl85SwcFbniH8EEK/6EYBBySJCbJXSyG+OTNm2UPzvhHG/DPOmAU
         bI7BkEDzbkAyrYPggrLOqBXs3+fAKE7I9nJMfElAQPnk9zcJoxKVzra+qpaaS4zjFmFm
         +zGIklEttPzfZ30Os14r4wkJ4d4EJIM7jFmSCD3NCfqbT7xC7Vx42OLsCjE9vL3559ZC
         SoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746390505; x=1746995305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma5VTZtN43eHKx9MXoN2vndgZGyS3IQcfMzkFZsLVr4=;
        b=JRa0Ch2MbDacosg6IM26exJ3Uu0rsvYPYcjNuIConKol6Ajxfv7QqKQYkS4fuxgs4N
         0rA0WjnyGwbJaNkqTL/lq8CJHWA2qVh4U500uzuNRSFLekox/EYWPAc4rSJO76M3+N7i
         CgSMBlFbrzv4elmRkuoradxiFDhkmE+vMv6Bvoe9BTpx83EOJaDbepwpVGU+OnizfuoJ
         vDSKXvN6mf2k/x5MH1zGmTEPG0lwB1rdiuo//vL/JskKKKhL9LHUXy4OQC01ECBb3pgK
         FDSamKHOxIV/PHC/RdLXVDO27sTL0v8Iqm7W1PcNoHHwXpHzpwHH4Q0SKmOpazdxSVMC
         k6uA==
X-Forwarded-Encrypted: i=1; AJvYcCUxcdOvxyp6qlIPNnSLqmXXpAUyFd8KiIGGP3rB6+Aqm9cIHNUZHmy2S6StzI7Xg7UXDB6NZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9Th+1kGkbmUKzlUu/dL2tvgBJ+q6ui3HUtExZnNvB197f1af3
	8ZvJmfYO/CkZrGXtkAlfgWH8VivJ8RFXgtlcbIoUwkiXbn3dgpev4+LqTpdyg4ctCLD4uqUgFb4
	NwiPNmrWNhMK2TWJLYRvxdrEct56XXXwM1aPI/42r7bPH6ZHMklhi
X-Gm-Gg: ASbGncu6imS4WOubojERZbkATDur65zOzwfL6z+4JQQruXDBMYFhVkn7PC27StuKYO4
	WsnxbvXe/O1IBVWxz4S5aapewvKPk8SFE5KFTvD+NMT5Eq1TkP0ad5pwv6JUe05sNRk1Cr1axAU
	5/mTZvfd0BDr1s+ZHVv7w=
X-Google-Smtp-Source: AGHT+IEfcygATG/JiYqs8kFuuV3uPN962mEKSsdv/ZC7xfZXUWcYClUyr+wjWiEIMt6jrvov8aTIueM8qZuFoVDluI8=
X-Received: by 2002:a05:6402:1752:b0:5fb:1bec:9149 with SMTP id
 4fb4d7f45d1cf-5fb1bec920dmr3313a12.2.1746390505052; Sun, 04 May 2025 13:28:25
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com> <20250418233409.3926715-3-praan@google.com>
In-Reply-To: <20250418233409.3926715-3-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 4 May 2025 13:28:13 -0700
X-Gm-Features: ATxdqUEGvzouCWzwyN8CVIV0-zVPnE6k0PvbmRv2-GPuoSigh73p5DIGmodqUhQ
Message-ID: <CAE2F3rDHGjwh+fcW37VnUG6dOyrKkxEseKMmRdZ7vzCroM6PrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/10] iommu/arm-smmu-v3: Add a helper to drain all queues
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 4:34=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> +static int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> +                                          struct arm_smmu_queue *q)
> +{
> +       struct arm_smmu_queue_poll qp;
> +       struct arm_smmu_ll_queue *llq =3D &q->llq;
> +       int ret =3D 0;
> +
> +       queue_poll_init(smmu, &qp);
> +       llq->val =3D READ_ONCE(q->llq.val);
> +       do {
> +               if (queue_empty(llq))
> +                       break;
> +
> +               ret =3D queue_poll(&qp);
> +               llq->cons =3D readl(q->cons_reg);

 A readl_relaxed() is probably sufficient. Also, in other places, they
use WRITE_ONCE to write to llq->cons. Compare with

WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));

in arm_smmu_cmdq_poll_until_not_full.

> +       } while (!ret);
> +
> +       return ret;
> +}
> +
> +static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
> +{
> +       int ret;
> +
> +       /* cmdq */
> +       arm_smmu_cmdq_shared_lock(&smmu->cmdq);

I'm afraid this might not be a correct usage
arm_smmu_cmdq_shared_lock. I understand that acquiring the shared lock
means that you want to prevent any other thread from updating
cmdq->q.llq.cons, which I believe is not what you're looking for here.
If you want to participate in this locking protocol, I believe you
need to acquire the exclusive lock.

This being said, I believe you need some other mechanism to ensure
that no new commands are submitted to the command queue. Otherwise,
the command queue could become non-empty after you return from
arm_smmu_queue_poll_until_empty.

>
> +       ret =3D arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
> +       arm_smmu_cmdq_shared_unlock(&smmu->cmdq);
> +       if (ret)
> +               return ret;

This is basically a command queue timeout. Consider printing an error
message similar to "CMD_SYNC timeout at [...]" in
arm_smmu_cmdq_issue_cmdlist.

> +
> +       /* evtq */
> +       ret =3D arm_smmu_queue_poll_until_empty(smmu, &smmu->evtq.q);

I'm not sure if you can use your arm_smmu_queue_poll_until_empty
function on the event queue. I understand that in the case of the
event queue where the driver is the consumer, the driver's version of
llq->cons is always more up-to-date than the SMMU_EVTQ_CONS register.
In fact, I'm afraid you might move the consumer index backwards with
"llq->cons =3D readl(q->cons_reg);", because llq->cons is more current
than SMMU_EVTQ_CONS.

I'm thinking about the following proposal:
 * Drain only the command queue. Use a local copy for llq->cons. Don't
write to cmdq->q.cons_reg
 * Don't bother draining the other queues
 * Backup consumer and producer indices *after* disabling the queues
in SMMU_CR0. This would involve writing to cmdq->q.cons_reg
