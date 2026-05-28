Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F680352008
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002186; cv=pass; b=B9aGtTi6V5YnO8o2YqQq28eJuWTl8MS+5NBipjJAIW41M9YSRCroHfUS4up9JWR5+4Q2PmHbYg8KE2ADieeoikgdvzjMF07a6ngyW4Jydy9mV+nPVyZWMna1/9fax5BLLLrkp/g9iaQzSuIK0byw+ruyIP5w1CQsKeq+VGy8nRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002186; c=relaxed/simple;
	bh=8/H0s5ObSXuYN0fXRn8e8f15KeuvhPQzxR4j5wSdGW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAraKKPP/+A1Vm+oMZHJBsfAbwNxEmeooYuFmIdRxGMujpIs9VVVVi6BlqsQ88MgheSJg/2FSiJSDAhRB0OuxHLovKgZN6DubL3bzM0VmBXJtykbKJsWUJpfavAD1GM8HrURJgkz9L4IPDe4HrRh0nVUO+Sli7kJVFWmmXDKmfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqDJDKq2; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqDJDKq2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8bd9a881eso99e87.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 14:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780002183; cv=none;
        d=google.com; s=arc-20240605;
        b=hZ2N9JB6N42Ny5aztIUio3CJ0vZLCJ0OXDrceM8cX2KikED0PxG+QS59g1wWLpDSFu
         MTTTkxHl5kJKUeBRiHVKhbo50EI3gEVjgwTAXS7VdLjGuD5nibNkTSwBeckzOg08mQxt
         Fnk54mtrQFc0cKUa5vGJyURGXpHFKscEYu9p6s/PQuCLla5UDinI53qu4TQDjesQ2r1x
         YB7GckZLxv5xZU9DZrQf3szIFjAk99/TKoaqMc0rlpTMmNtxv5xeN5gp4tBkY92CV+QH
         Uz+SNR2cgjx6PFVx/Ed8UbGESZm4hNL0cSlZl6Jn5Cw3f0wtVet96oQSitPwoGUb03Uc
         Ylhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aO12JApDqdyz9RPHxp/SAH2mf80I46UDQfAPg6V7HWE=;
        fh=DUIRIKNixXWvMZMswXfqP7RGL+VDbEMRSgN37XpFpIc=;
        b=CWkSonnJFHynfRzWv16f3O1Sobvrbf0HF1CvSVKZpmflMSXZsEeFxI/ur1uhNiOoD3
         NJC3UpFsDeVyOkjB/nLQtuYlwf6BfvwmnPH/MoYYf2NgdYyT9CLX8mBAK1EUyHsAO5ep
         JpbOoZ2AKAWuBaBvcQayADBHLLs+GPo1MS5GpZTiUstPsxh0feWX6gybQPLq10VO6g+4
         fMhJkfqjMH+RmbIcSufp7whs2yBs0FtXpj5ULLQ3x/Znb/hhI5xJx3YPcuAeXny8XBNW
         x1dAbTGkpqKzDp6HSOiWQQmRCxtShwrudyoJphuo94BGLVyOcbOwPgOo99ENbXn2s18n
         1hkg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780002183; x=1780606983; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO12JApDqdyz9RPHxp/SAH2mf80I46UDQfAPg6V7HWE=;
        b=FqDJDKq2uYWiMdnrA7jkk0xR2Dh1J6rVaqczTyf2sZH3LYsx2WhM5If8Coi/O0u/vo
         HuvhU5SrtVF4AEMLdZcDlfQRXE8GJTyIDv7kgSwJ2zOmNx/MY+FSyQ9x2U/DrlpdzSt/
         EcPgLO435Yq2MYEd+WlFfKe+p1DvytwcUwBJ1NeyhKlVx9Yu6BzloDWLK2yIl6oIIJNm
         dR/UcRHe4uC6iG918Z3B9Tp5Pv61SdL3yLgVUZvPHwK1ZPgQJtLpN0p0/vy0kIckQtAc
         Pzqt13DaYQGT6B+l+lblmjUF40lQGNy8LhpIAMLpx4ouue/clzavdHyUemqnvt9704v/
         0eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780002183; x=1780606983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aO12JApDqdyz9RPHxp/SAH2mf80I46UDQfAPg6V7HWE=;
        b=kb9sKtKio0q49OTF93ZhZuvfHiTVzBvMv0v+niVoK5vG5goVirEwcrMibAf+0dlJTK
         2Zk14HK5IJYtQH5CLOeEm28Y2zKuvAfUJz48W8GWswjov+JxEd9mNLyqWFXi+bI4Vll5
         zYCIkfXHpj0J49ze/uH1zYEFVc0xqvIV63sSB7weGXR3lqIOv40h/zQoAxuf62xR56nL
         PbX/s8CRg9WhTs2VK4sZdtYrwuy4+uRDRTxca42tHjRdc/Gh2FjnqVjRSDeZMBpqv4yV
         aqUKyawshpybAI4+QprDCs/w8ChFSUuTHhtuzkirjIVWsnrtxcu4CiwLGmk4ELlHB0Ey
         ZGMw==
X-Gm-Message-State: AOJu0YzvfBoOjgPo5u91H7ldTw661Tq6eT6JzJkaQhGwhqV+7Rk1MYUp
	DBHPoAltVsAXaU9f2Fg4BABSnJFRcaVP7paTbVZkwZjs8ePCkqoChadcU5w6I0OzjmiOxN1LyZy
	xLW000K71JMAsE7G85c+fPO6CNtQaImzXsvLkut7R
X-Gm-Gg: Acq92OEauRp4NPM31dsHhNMrWvc4yl5duG3DNyPU2F/l+D2NLLX9T8U2DJGwtrZUIEl
	hUCxTZ0T+vbGqoEEvmuKiEKYhYMvKAW5iJ2RhzVC76+t9sTyi9wjnL/mzxllLsDydzAybOfJAN6
	rQA28SwTU7VcFebyQMyese5udkIUmlUV6iAimixhdwcSVV6M3WJC7LSQwMI0SpcM/6IipX61Srv
	Xi+V4KDGIKVJmgZXlDFSc1Q1N8Pzr50pbyEVs0PtbgMaDqmw1/GZtDOkGRXGURbVsupoXkxXqdH
	5U9hr0sBTMjpioW8HFWsguIQZ2v+EZLpbpAgvdMBFMYEj+A=
X-Received: by 2002:a05:6512:234d:b0:5a4:b0e:d756 with SMTP id
 2adb3069b0e04-5aa58f9c0a2mr11796e87.0.1780002182945; Thu, 28 May 2026
 14:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414210626.2097722-1-wnliu@google.com> <ahftwWxiL9NlJ5g6@8bytes.org>
In-Reply-To: <ahftwWxiL9NlJ5g6@8bytes.org>
From: Weinan Liu <wnliu@google.com>
Date: Thu, 28 May 2026 14:02:51 -0700
X-Gm-Features: AVHnY4LPgbWDgplNNi5uPg9sYMAtw_Ybfu0DFYLHcXRDXVQxdtLgvA5J223arPw
Message-ID: <CAPhhraxy5Bey67Psynqvsp37cW3HfYdWEU8+n_3YVqPAqt5TnQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] Don't split flush for amd_iommu_domain_flush_all()
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: iommu@lists.linux.dev, jgg@nvidia.com, patches@lists.linux.dev, 
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com, wei.w.wang@hotmail.com, 
	will@kernel.org, kpsingh@kernel.org, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback. I will update the patch, gather the necessary
tags, and re-send it as a new thread shortly.

Weinan

On Thu, May 28, 2026 at 12:25=E2=80=AFAM J=C3=B6rg R=C3=B6del <joro@8bytes.=
org> wrote:
>
> Hi,
>
> There is an updated patch in this thread, can you please re-send with the
> correct diff as a new thread and all Acks/Reviewed-by tags added?
>
> Thanks,
>
>         Joerg
