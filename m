Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41223ABB9
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780377956; cv=pass; b=ttSLMPNTEpNpXATtEDJ8a8mr+IINwgiBQCaKbIBnb2zTTonmFLLgZuU0qKhd4onxfwuBK8um0eG1DdW/p2rk1FFMbMsxYvbW0rSTvzlSHigR8Pf6yUhuXVaMGQ2p9tcxL44Uw9iFGuapDOkGPceV5n1zyV6S+DuA2bISngl/IGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780377956; c=relaxed/simple;
	bh=znt04/k4LTawXoT+2JQrGWnfgBtw4ewV++7dnlkhWbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJeYewguutGiMNiodb1RMtw4YCjRXOGfwAkng3V4N0GlGTqGfSQTfB6POIsOHvZhoYrsoUn53HaQ5Fvj54PPbWb6fVXqh/teGZpGTMbHNZAcd1pRvBfnO2iQEMsxEsihGdlmA/FzlcpgGlq3OilhOi69UuhXNZg+tavbLIgWSvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmJOuzEB; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmJOuzEB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51765531803so3511cf.0
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 22:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780377954; cv=none;
        d=google.com; s=arc-20240605;
        b=Nz06A/1ZJ9PgOvxVSauHHpdHFkmHQrJHkJ/QXNCr11xovpln6Dbv7uAgSdL7dzaLGC
         NEpSQmz0iGqLs9k2K7RxwfeyYYaVSt9YoGhTXjj1rrwcEuftWgegPTyL7Mg/5cENbsuU
         qzmnvIcqN8N9bsyRs2dUqApNCMsxBkbXy3Q75sDNz3FwtwQdCtRfXuxazDEO4YAsApMV
         HXs0dgp+hSjDovfXNRDzrxSo74F9IH4ghPpXG4K2EUU2Ya5ObLP7WkjXta03K3kTsYGf
         rWO+ZQZcZ1imOYGXTvISOQzsdY3RhV/AP6EQ0YA+NIWKM0oBg3ZoS4/38grzwuaw2gwj
         D7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUr/bDGg9l6+S25kggcGIvYETcmzBiihCI+mnqh90MM=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=khBPfskHZQC82BE/9L+fd2ObgARu97N8nZhizv/ZUs0OGeuUkQBQ+eW1uxc2uBmaiW
         MGKFRMN3KTfURmjNlTZneJmzCkxHq+rFIWBJbKqLPnsdEDNwty/QuMH5VXwoXMWFuLlJ
         fxEnKsjOUF47Lp3Qdj/SwB9gF4OnFo2dbcuwyUf27SjV1SLxcKQHhtUfs0Ws8yDJbCfo
         jO/hZnB01GCf19sPCw0PUJcKnnGTmFK/NRKSBds8f58kg11GfAjK7nNDSdxUYtbZWo/D
         ld3+MOPUCaMfm8BJ9FFD6o+x4KZKTHMhVD2hVexkqyrkVG3ZXW9fXRL1z0EaVCLVzBEY
         IoIQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780377954; x=1780982754; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUr/bDGg9l6+S25kggcGIvYETcmzBiihCI+mnqh90MM=;
        b=EmJOuzEBVR/MBlD/NILUFe/5CeGyJdh4o9/77MLORZ4nLe9beOYI5wIs0nNxDUS83N
         HoITohygxJchU4osEjKFwO0h7D4H2Ojo9FjaKSVbiiyypqxnJqjOfmHI/OQ3eBrQorqp
         +pqFgxxdhqgb8LD4+EgSu41FfdGbg5QM6T5oAyXmwYJmVohFJVQO/h/YUFwFWwHXbk27
         AJBPeO4mpZHJm0DxMcy9HoeMCgAEGy1Rgb2v5nvT1kRGYJM0/1Q6SO058uWH0CTlF9ZY
         zCsNObpC0Jb764Q0A4yPwALPJrWdE4QD1kWbXAD3REOEPkHu4dnw2XjjR1+bWxWADiHG
         x5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780377954; x=1780982754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUr/bDGg9l6+S25kggcGIvYETcmzBiihCI+mnqh90MM=;
        b=LNs7joXuoEE+rSo6vdYWW6eNGZbfqOyr5iMOK8iS7uK0Sbi98LMq6rs4IN2a65I+hU
         cefZn0kzpLZKiIXeiu4llQMIcXIvOSbtWgcpRWmEPiBdNWRizPhrhOw0KZ97qAkLqmuP
         NqfhDQN88q9L318hpiBaDkNoPRV+lF42mi7tz81cEWvVZdLOC1CwCqde1Qlb+iBbEM0h
         HyX9SRfQVPuupXPnJBhzjv+2m5i7BSdDUVMWc9gIqNC08mbFiAIp5StH/C76dFxjF9Q9
         AHR3KKJmAuKLBlWs9Pt/eCnzFEyglUlhA2UVCvSDcOp05Zqn+MHIjv9EXy35EfsCCxqK
         Otkg==
X-Gm-Message-State: AOJu0YySblS+Z7UR7PBR7HGaVHXkTFon5nZAw9BDG9vcExGZaj2Mw5Ut
	X23oKbV+9JSy9R/YYJhbD0pgXQB2IHZzg///NjNDTpw19EiWo9L7oq64aq1hQO9hCWuSYlOdLr3
	j00GBejp97MtKTkz1vMPE4WLObhR0UQSoFfa9QWah
X-Gm-Gg: Acq92OGM2ME16Sttn6lCgFlKRllEUBSopgRDh+574yYeZ7cKOiRdWfY9GBVdUAH4zT0
	eAwVNz79xzXcJwvafNeB0ZjGjnaGN4xS/NxNwER/6ZAOwkhz8V7lMN4bVEua57DXDxXMcY/qkZj
	qBXXXf5ITsEGyTULQbdwQXX5KjoFTaSNlqWS2NAq1YY9/RAaCUAyMOgAenOrh/gZUw35IrqXvFn
	wkCbLkTKt/Uc8hziFKU9QaihqyW5yY8KSVhZqsHgJaWvQh3SqUEN16X/10bSl4rCHlsJlt9+w/+
	AsjHBDChqaKbF40=
X-Received: by 2002:ac8:44ca:0:b0:517:5ec3:b59c with SMTP id
 d75a77b69052e-51766ef52aamr6504621cf.2.1780377953476; Mon, 01 Jun 2026
 22:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-10-praan@google.com>
In-Reply-To: <20260601215909.3958732-10-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 1 Jun 2026 22:25:41 -0700
X-Gm-Features: AVHnY4IfYeAAnGDfZFtab7X_lZydVua3zMR87OUc2sWsRLSKLKQf56joUBM3Me0
Message-ID: <CAE2F3rAYWMq6DO5k20e4iMtPbh_X9JeiU8kUfw8nsS5xs42F_Q@mail.gmail.com>
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

> +       /* Drain the CMDQs */
> +       ret =3D arm_smmu_drain_queues(smmu);
> +       if (ret)
> +               dev_warn(smmu->dev, "failed to drain queues, forcing susp=
end\n");

Can arm_smmu_drain_queues() be called after cmdq->lock is 0? I think
that way we can be sure that no other thread updates smmu->cmdq.q.cons

> +
> +       /* Wait for cmdq->lock =3D=3D 0 to ensure last CMDQ_CONS_REG is w=
ritten */
> +       timeout =3D ARM_SMMU_SUSPEND_TIMEOUT_US;
> +       while (atomic_read(&cmdq->lock) !=3D 0 && --timeout)
> +               udelay(1);
> +
> +       /* Timing out here implies misconfigured Runtime PM or broken dev=
links */
> +       if (!timeout)
> +               dev_err(smmu->dev, "cmdq lock !=3D 0, forcing suspend. Po=
lling CPUs may fault.\n");
