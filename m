Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F07DD304
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 11:12:23 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-40550136e54so267671cf.0
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690542742; x=1691147542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UotFYhFco/Iuol2S9aBRnr5uMRdY1d0OsmUPUsVhPM=;
        b=0L3um8XwEDIm9CcfzBp/NYrL85AoBsHWAlMSlr7GgXtEvGgtiWnhtu6EwyGQQ1d7zz
         AriaGx/fxqbCxALqypqcx3XHMvQMPCahpECFIwwG8OJaeZp2KFaxlJ7YaKOgY+NmZiXV
         fiYp+e/DGKkNnFLp7NLmF4U1JnB6t93ATJPlIH/nTRm49efbbJddQOz0p2ZsjJwrdnvW
         pn+8bVAL4J7hLQaz18rq7z4+FXCH8txBA8etD/L6Q4+xvT1Fk+XGYhL5hicUCx/jS7Pd
         TPiQQ/GTdYyYVidRoDWE8C/+kPpwU76KeIIQfF9c49GoFI2QTJQP08uHENC1SKO4QG1l
         /FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690542742; x=1691147542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UotFYhFco/Iuol2S9aBRnr5uMRdY1d0OsmUPUsVhPM=;
        b=g9yDnt74QssoifxUF8hGRSjdIJ7llLaQ5NVB08F+Xn5AuqgBekzaKBy+xP2acuoRlB
         qZDH3T5F79RNql9Pz16k6fU/448Bo+Iw8PhAPwrlg1V8TXpVTAzvzW1NToiHj5CUrPQO
         FZVhntSDxmCtn8cRBfIKjBzjM90IV/Ll3B13pQBfoiAJAOPPefRCp6erx4FsRO3/jt4V
         dqyXFqiVzs/WuxhmIvTSrq++TgHy5WpxiHrZt8sxYLCPwDTmOZIH3Smi+2y3fasvSMtk
         y2rewD04G/S+xpgqcaig0m90x/sZcXGgx7VBknAslQHsIceoxIODwwT+WEO3CyhaJu5F
         yqCw==
X-Gm-Message-State: ABy/qLZeEGI/m2XVUl5x8UauJDLqYI44trG70d58SQDsAEJCfiYux756
	0fgs2qV1V+i2sGGd4gMQ7TQRgd2E5H+hLwi8JmoePA==
X-Google-Smtp-Source: APBJJlEmRPcQvTvFDB4kprRSijQQyenOpD6f2/GYwYu8xjeFnmK2hJdA90/7qhPXaeRigESpHEqLIYuGN4K8DNx9e7g=
X-Received: by 2002:a05:622a:1301:b0:403:affb:3c03 with SMTP id
 v1-20020a05622a130100b00403affb3c03mr201911qtk.10.1690542742215; Fri, 28 Jul
 2023 04:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-8-mshavit@google.com>
 <ZMK60wm3BBk038r7@nvidia.com>
In-Reply-To: <ZMK60wm3BBk038r7@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 28 Jul 2023 19:11:46 +0800
Message-ID: <CAKHBV24QkjnLKXp1Hewo1nTJnBTPdJWxiSfiXdNPZG=zqQWFqQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 2:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:

> Then you can put the free in a detach op once the CD table becomes
> empty and it behaves much like it already does.

This turns out to be a bit tricky; the SMMU driver detaches the
currently attached domain whenever a new domain is attached with
attach_dev(). More generally, do we really want to be de-allocating
the table whenever we switch between an S1 domain and other domain
types that don't make use of the table (such as IDENTITY or NESTED)?

One solution is to defer the allocation to the first attach_op, but
only free when the master is freed (this patch's v1 behavior).
