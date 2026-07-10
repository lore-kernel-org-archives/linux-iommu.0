Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756541166C
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685067; cv=none; b=eIVZL66yDVeKC0da9BEYP87AoU9nRbLxGBz4iO+U32SUCCglMHnQRgPv8fYkUX3fpoR+kAJlueKDvBJnxYvtfvCVM/+vjcNeh4OhaCsivmm0+xl038Enhwcik1b4dk2pV7AyHA5DRP8xDyses5e//dyFVpStyZ6jkBD2cGXEGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685067; c=relaxed/simple;
	bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyT4FIBvvXNNsAVgt2YzFZ07HuPAC3R231n/pm2GZu/q+tDGJNw+h9x70KBcnEj9lTHVKYMu9uOBydAWh/cU06MNoDNRdomdM6eRGmCHJVNj/RkCmMYSbZ+rdo6zd6Xzz83oGqGO+IbwmsXBPGC2YnyI57bIV3r3jMOzuY5vtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCyZQILs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCyZQILs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783685065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
	b=ZCyZQILsXTMqcz8z4boE6dk2LDtw6V0LGWHFhb1MUe6H+M1ANABrulHaZoNXDfMojbi8M1
	EPrkGlVYH7awXp6lJNn/bNHst47ZinTgr9Po81O5JBCuW8rZ78uAbIuGGTeVsxQSFor33Y
	vEKyZtTp8uqu2gub6FgYsz26Fo5Bf58=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-O1JRr3ZNPd-hJKDjLHZZNg-1; Fri, 10 Jul 2026 08:04:23 -0400
X-MC-Unique: O1JRr3ZNPd-hJKDjLHZZNg-1
X-Mimecast-MFC-AGG-ID: O1JRr3ZNPd-hJKDjLHZZNg_1783685063
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-48f0c5d20c6so1121331b6e.2
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 05:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783685063; x=1784289863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6yMtU5a9xI+ekMnhRgl8xfMzS3v7/anO/PeMGwUz3g=;
        b=UvuMmIoZ6akvMWEWX8FfYPGdGVY8KOpsLkIwvWkWhl1RXo+I1pXaHQAtM7a/fFiOkM
         UJ8s8YqSOkYYHpibGaLOvi2QAogbdpS7hlliYJGpIdg93ZmMODMn26oyZw3NUtfqsnUK
         tPePAvmwbnjb2hGRnpsPO1ruGQ/GD9FJREyQbWjaSiCP23y1eFXTeLuWfGuby9baNEdp
         wKk8bXpBuandJa2vpc67oj9Dm3LARyvdC+pmAJ0WG1SPRw6FDfiknGofJHzxT4AXclaL
         j68r8T6QblFBgstjy/GW7Bgg7SMbfLr0tgezWpmwHtK0/KWx3817+1ijmnztYEs5V3So
         GReQ==
X-Forwarded-Encrypted: i=1; AFNElJ8buMlQVnnG1SifbWsko1dxZe4a8klLosuwwofpIF8polX0fYjLt8f5o8zYNFiNjqOsIhmvrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YydId8rKAypzM+uQWZHOlzwIauEpqtldrUtqjQ5438SFPYuWzUG
	2t25/kMpKg06QmZdj/XAtMzcmlPA6o6IFDiMzAk8oJGUnMXfMm93pHgMa2+7WPj3ZjB86i2WZKn
	E+yxqGIWM7rqzI/i0scRl559s4XQztvxZQNx7Iv6gTk2m/bJDkVD8ZTp5AimMkxYfebO45Nhz6x
	T9h6Y7kka4X1Bl+VW5mFJ4rJ3s7ze7Ax0=
X-Gm-Gg: AfdE7clPtXY+6PprrrEwBJTAhAJN+OZ4w21lPaKunszKPk243cOXq00FgDOeaE3ztcU
	Yanswd/r0dk/w30K3g7Q/4CZURal2W7NPNLM43mHcw1QMuXoCXVToHnf2IqG/xH3dSU5JX6bgqA
	15PzmFfJdKKCIUgC9/BOLHPNSknt8mWpcFm/gd+b/oeav5FXSjDLO9rqNDqs5fYAG+hsol1s2Gx
	+BXe905PYuatoqkmr2n5wck+i0=
X-Received: by 2002:a05:6808:4495:b0:495:d6b7:6004 with SMTP id 5614622812f47-4a2045e17aemr8153643b6e.26.1783685063070;
        Fri, 10 Jul 2026 05:04:23 -0700 (PDT)
X-Received: by 2002:a05:6808:4495:b0:495:d6b7:6004 with SMTP id
 5614622812f47-4a2045e17aemr8153631b6e.26.1783685062691; Fri, 10 Jul 2026
 05:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260629144837.3244851-1-desnesn@redhat.com> <akRTVinqeeZnVARD@localhost.localdomain>
In-Reply-To: <akRTVinqeeZnVARD@localhost.localdomain>
From: Desnes Nunes <desnesn@redhat.com>
Date: Fri, 10 Jul 2026 09:04:11 -0300
X-Gm-Features: AUfX_mzVC853Yhxe5IzKb6IGxVPhPJKkZ0EBhVqEVYwZEn7zq3i4mNWDrdm-aj8
Message-ID: <CACaw+exCLSLRUNU38uorD9r+fk4AjD-Oe+RZNzFXzjwE2q9rsQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Fix UCTP context table slot when copying
 root entries
To: Tao Liu <ltao@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, stable@vger.kernel.org, baolu.lu@linux.intel.com, 
	dwmw2@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CovXeqeewTWZRdyYbuGhGrRl4s4zc4dhbxna4tea0wA_1783685063
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings Tao,

On Tue, Jun 30, 2026 at 8:38=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
> Thanks for attaching the kernel stack trace, which is similar to the one =
I have
> encountered recently. And I have applied & tested the patch, works good f=
or me.
>
> Tested-by: Tao Liu <ltao@redhat.com>

Thanks for testing it on another system and confirming the fix.

Best regards,

Desnes

