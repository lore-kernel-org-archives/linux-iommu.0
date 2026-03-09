Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAA21507F
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096976; cv=pass; b=ewewPZjFcaaMo372ioTxK1gfyvh6S/7Jd0jpdDmQEY+S3Z3Y6q+3YRjWZxfUVHonoOc7z8cfhLvl5yA4Ua8C+DyP1dPzIoC/HgcirtQArk1JPhJA3eYE1LaF5zmCHIUCylBkgSDRVgPWkZNQR8c88Uh7bUEv7IOeuFRCkjlqt9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096976; c=relaxed/simple;
	bh=XuaXX0r57VwDuXH5eZqpo8Tno/OYopO1ttI0G1ZGK8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkZH/1xpKyT8axW7Xy7OIa9bOdQ5h1i+VtIvpFzFaBVsVfgjkbXbIlLicuqiiZNH0sAB+GFAl82HJ0RPicHGcrI3SLtJXr1ECksGlwriW20Try8GRiSHAZbQ0hG4B39lzcg1jMn9dpZFGdPYv1ER32ZSRGJev7tb/gV6eLComug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AfyzZq7k; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfyzZq7k"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5091ed02c54so119591cf.1
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 15:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773096975; cv=none;
        d=google.com; s=arc-20240605;
        b=CCV7BbhGIgJmWLVG7TF07xmaToZjX7zeU90E4uhwvlFNXY6+AfFTGNSGG6OAMaL0hc
         VZSrZSud2js0Wo+DERVu37yn1/RJGgetsXI5JbUIVxI5KprsPuo0EuUDpI6nWlESbFdX
         87UMQjnlaxeJJkgln1PgpX0coNbBhg/awx2DAP7zUXiT2YLXvGQQIjRM6zIwtC50jJnn
         QCRCnssYLg/VBBwMoQZFarpiozzBrlQjkHI4/Ki1Rkdcu58A1tbBGIjIOA9BLKb8GFtO
         SHAxDE3PFQN4+R6xlG+GTAxH/opDHxLZkUu0vX2D5oL2moAOgWHs8OEUhkpeWWhiZ+LR
         oIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2y1YqK8bsEXjM+KYhVLRJrGFy/8pqs/psRLA3yO98Go=;
        fh=Cr9Gz+4KxVp4Ci1moPY7g4WpWFGCr0a9bcVWr63STi0=;
        b=E52nfPWmGRZVkkEYkcOub3sq7TLpqc1DbX/klZSrW8ROCl9Xw+PKw84nmRzItG+5GN
         tAkOFmLOveDJDgTc8pmCp+/uT7RB0kr95SHlc09e8YYqi4f8aaWdMe5KQCCztMJRVDID
         9aX0DJqmo5+XcFiD82C2iSIfp0PBt45Pw0N4aDX264FCYUhVPQeClJMUdZl92CdfUk2q
         zYski43cQHof3XEhVMZhGu4Igm1PsJK0INqxQP8YBkUqAKrztdwY3OVsXfiu8XJQB0WK
         z13r5RJ3deWoAVVpfFpoEQDHVtUwjGZz4COBWTo8SejmteSghVT3TxnQ0yoPaiiMQUSr
         x/DA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773096975; x=1773701775; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2y1YqK8bsEXjM+KYhVLRJrGFy/8pqs/psRLA3yO98Go=;
        b=AfyzZq7k3bk6MlNjaAaY6E1AMmJf5oEvdAdo7LW7iCPJJ4DdU8ML1ySEmiMFNNCH7M
         piPFKQMsYsKVld9Z19Hsq/PDG47bXPzMLkncVbN+LVb/VZlGyJzaM0HBvZQCKvr0tiMl
         F4klCS9/BdKytlQ31Vf2hfooewrPn0ulcZp+G7eZCDuLK7UoCylM8W30eFRUWxlXYLkI
         dNZwmM0/4LrCTJFy39wuThVZxlJdeMMmKKhFTlGGFHWuBBtcEHcWmNXahPJLaSjLPELT
         M6yuMFujIZWVoH5TVRLACTxUVgNJK/QetJJ/uspH7Zhbe0KthzxvVKkC8XVEJL6nXx/v
         KD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096975; x=1773701775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2y1YqK8bsEXjM+KYhVLRJrGFy/8pqs/psRLA3yO98Go=;
        b=Vu6PwANheNh53epZvrOo3aOg+KSDWCu4pZoy3RPXPfZl8sO1qN4OgnpwFFvsk9bO0g
         UOnuVtavEXXdRNCDxw83IMeP6Jmr2QUYQjJ1qOYMfsDBjaog39QGW7hEAK4euQYl+2di
         fje0y8VcJg5baDmSJikgYddnbK5CI/SDUvdsqUZhSOKErJyS/9ga/z3bLbOkqgKZrVbY
         4QLgXqVHjSAjyz7Nf+KOMQtb01vDBtzYKOk0+YqZJLxCzsUNGhmkPR6CJ+qZoUQGbxK2
         TW+fFECo4qBYfHPlx1l+z5SViNmqs4eoXwTyooa+RuFYuNlLPKN3d170PKo0haNRB1do
         TIzw==
X-Gm-Message-State: AOJu0Yy+uFExlXJ2O0xNCup8NT6fAz93Tx2f+jHmT6i0zGGBafrVVMVh
	jzphe9zH7rwUiLug+MMY8Cv3sdEqr73DJHKzInETwFAvET3FJzRh3hq4FkSR/Ygjt8kR8+ujX7u
	kFoJzbYXVtTxYD64IC/vxgBf3ab3/5m6mxBhciL2yJpXeGL6w8/7UG5jXo/M=
X-Gm-Gg: ATEYQzy7fYK+q1DvDh1lB8WtbCMZkW7aoHyosWwT6j89i8I3CXv5S2jY7B/aQ3LzuFy
	DWdo/RpklCu/cnwifPseOeMuvNY8bU80lH9pI1NH+3TXIZh0e50zdwFuftZWAImSLCJrlaDLkw/
	Or1uAy88KqUg9xYBUYAjD4zZUbzzDNeeJc5lRfFsc39AIyOJGST4vDWjH9UktNlogS1Y5Q8hwGg
	/CA+5dhhDIRV2iLRFpuOaSWsAwlvIs1hsbihIQMGm98cdgHlAZ5SJ8RGdFgobnnRXNDJZJE3XQO
	7Zxf
X-Received: by 2002:ac8:5988:0:b0:509:21ff:cd49 with SMTP id
 d75a77b69052e-50926d597ddmr5471411cf.4.1773096974158; Mon, 09 Mar 2026
 15:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com> <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
 <aa8jkLD0l2WqMnyG@google.com> <aa839kz29GIgg_W3@google.com>
In-Reply-To: <aa839kz29GIgg_W3@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 9 Mar 2026 15:56:03 -0700
X-Gm-Features: AaiRm50fKSMfF6kzDjWzZ3Pn9GowVX0GDE1iDPqEsMC7U5X5-5lh-X3i3rFs9Mo
Message-ID: <CAE2F3rDoVUCdc3c0z-jLSijh6cZmVwscVfuJLj6YoP4ZjwF8nQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 2:13=E2=80=AFPM Pranjal Shrivastava <praan@google.co=
m> wrote:
> Still thinking out loud, but maybe we can have something like:
>
> if (owner) {
>         ....
>
>         if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
>                 writel_relaxes(llq.prod, cmdq->q.prod_reg);
>                 has_ref =3D true;
>         } else {
>
>                 /* SMMU is suspended, fake a consumption */
>                 WRITE_ONCE(cmdq->q.llq.cons, prod);
>
>                 /* Avoid racing with resume */
>                 sync =3D false;
>         }
>
>         atomic_set_release(&cmdq->owner_prod, prod);
> }
>
> if (sync) {
>
>   ... same stuff ..
>
> }
>
> LMK, what you think?

You'd need to make sure to cover the ARM_SMMU_OPT_MSIPOLL case: The
function __arm_smmu_cmdq_poll_until_msi() doesn't read
cmdq->q.llq.cons but rather waits for the MSI write into the command
queue.
