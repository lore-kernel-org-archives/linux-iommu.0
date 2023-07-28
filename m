Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33943C2C0
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:18:42 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4036bd4fff1so209981cf.0
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690528722; x=1691133522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysCAGi0c79oB3HuNtN6di6oujNwWKPP9/x9YkXZxDSo=;
        b=x1RxhFdfUWgACKqP/g4NWP+tZISz9GTHfENu3cj4SbDWQXAlQFJ4jTLLGbrvDIciHK
         73o/+99jGa93LOdlBW3pF0NVLaUMw3pUW5g+NSTSY1+XMorkH5Mb+fKNyh5KQDB53+kf
         AJyKSOo21WkiW2kwoCb2hGtde4uJcUP8nVcKVNTDTvXp+pZgOV18/ZfOsQLjPLaefDjZ
         /vqj+I1/PYS83mq1FcZJSzOn62MnECAOIVyU4MoYVOuycuYIKqM+TfzoB8XzGCy3v4o4
         eUlbqoMlcYzsXV2nPb6PgELr/hjJQ1cmNW4fTGVmOlCJcNt8C9GTSg2BjpxAHGCtG85o
         WY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690528722; x=1691133522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysCAGi0c79oB3HuNtN6di6oujNwWKPP9/x9YkXZxDSo=;
        b=Pvku605S2jk+Fl47Z6AnEU1vngArg9DFxuYSY3GmbG6dyv5wGX9E5bxjR/hzBffjOu
         q9t4ctHb480Ow4RYaQVoqPkj5hCriMXadJJ+HuWTAa2YRIK0KrYEDwbl8XDteI8GkCD0
         Ih4B+7iuzPwukHZ1FIRK3KzjYN/HNgzkzrynLqwQ7RmxO9qEMV+Zjepgf3biOwMCc6O8
         QtItN09hyhUNWP3PgK64eQzuNMEL442IX1PGIowzSLbwEJRNhjY/k1GHDFx00ANZImuP
         iJrS+KW8KkgLJzoKi84X2D5p2+qAZ1R4FP86l4stXFxAit7hDMU2DM3l3p/2AP+s2O+g
         CUzQ==
X-Gm-Message-State: ABy/qLYq0nyfeA60xa0xc5C0RTIXNX80nC9xlRbs/8hOOUn7L6+pt6KS
	iBZv9oMtGXdu2G5YIhqshlm23i5wQcnHpbZxP/PaMQ==
X-Google-Smtp-Source: APBJJlEOrCpjFfE7xzbRq34bPLqamEsRreh52uuKwpcZ/sXYdpvtQf+IQ24Cmjhup27TEpRek85DUOqxBoOOvyOf2IA=
X-Received: by 2002:ac8:7d8c:0:b0:403:eeb9:a76 with SMTP id
 c12-20020ac87d8c000000b00403eeb90a76mr140572qtd.17.1690528721624; Fri, 28 Jul
 2023 00:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <ZMLRWfLET9FC3FQB@Asurada-Nvidia>
In-Reply-To: <ZMLRWfLET9FC3FQB@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 28 Jul 2023 15:18:05 +0800
Message-ID: <CAKHBV272tKQ=ky_ttA5TLcBBKeLf26WC5Hn_HFfH3LRk6udEuA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Refactor the SMMU's CD table ownership
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 4:20=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> The link isn't accessible for public. I guess it should be this?
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+=
/24729

Whoops sorry yeah that's the correct link.
